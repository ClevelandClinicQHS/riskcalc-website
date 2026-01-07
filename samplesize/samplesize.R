rct_continuous = function(treat, control, diff=0, delta, sd, r=1, power, alpha, drop_rate, design = c("Equivalence", "NonInferiority", "Superiority")) {
  design = match.arg(design, c("Equivalence", "NonInferiority", "Superiority", "Equality"))
  beta = 1 - power
  z.alpha = qnorm(1 - alpha, mean = 0, sd = 1)
  z.beta = qnorm(1 - beta, mean = 0, sd = 1)
  if (design != "Equality") {
    if (delta < 0) {stop("difference margin must be non-negative")}
  }
  
  if (design == "NonInferiority") {
    n_c = (1 + 1/r) * (sd * (z.alpha + z.beta) / (diff + delta)) ^ 2
  } else if (design == "Equivalence") {
    z.beta = qnorm(1 - beta/2, mean = 0, sd = 1)
    n_c = (1 + 1/r) * (sd * (z.alpha + z.beta) / (abs(diff) - delta)) ^ 2
  } else if (design == "Superiority") {
    n_c = (1 + 1/r) * (sd * (z.alpha + z.beta) / (diff - delta)) ^ 2
  } else if (design == "Equality") {
    z.alpha = qnorm(1 - alpha/2, mean = 0, sd = 1)
    n_c = (1 + 1/r) * (sd * (z.alpha + z.beta) / (diff)) ^ 2
  } 
  
  # r = n_t/n_c
  n_c = ceiling(n_c/(1-drop_rate))
  n_t = ceiling(n_c * r)
  
  return(list(n_treat = n_t, n_control = n_c, n_total = n_t + n_c))
}

rct_proportion = function(treat, control, OR, delta, r=1, power, alpha, drop_rate, design = c("Equivalence", "NonInferiority", "Superiority")) {
  if (!missing(treat)) {useP=TRUE}
  else {useP=FALSE}
  design = match.arg(design, c("Equivalence", "NonInferiority", "Superiority", "Equality"))
  beta = 1 - power
  z.alpha = qnorm(1 - alpha, mean = 0, sd = 1)
  z.beta = qnorm(1 - beta, mean = 0, sd = 1)
  
  # if (!is.na(delta) & delta < 0) {
  #     stop("difference margin must be non-negative")
  # }
  # if (!is.na(delta_exp) & delta_exp < 0) {
  #     stop("difference margin in exp scale must be non-negative")
  # }
  # if (!is.na(OR) & (is.na(treat) | is.na(control))) {
  #     if (is.na(treat) & is.na(control)) {
  #         control = 0.5
  #         treat = OR / (1+OR)
  #     } else if (is.na(treat)) {
  #         treat = control * OR / (1 - control + control * OR)
  #     } else if (is.na(control)) {
  #         control = treat / (OR - OR * treat + treat)
  #     }
  # }
  # if (!is.na(delta_exp) & is.na(delta)) {
  #     delta = abs(log(delta_exp))
  # }
  if (useP) {
    if (design == "NonInferiority") {
      n_c = (treat * (1 - treat) / r + control * (1 - control)) * ((z.alpha + z.beta) / (treat - control + delta)) ^ 2
    } else if (design == "Equivalence") {
      z.beta = qnorm(1 - beta/2, mean = 0, sd = 1)
      n_c = (treat * (1 - treat) / r + control * (1 - control)) * ((z.alpha + z.beta) / (abs(treat - control) - delta)) ^ 2
    } else if (design == "Superiority") {
      n_c = (treat * (1 - treat) / r + control * (1 - control)) * ((z.alpha + z.beta) / (treat - control - delta)) ^ 2
    } else if (design == "Equality") {
      z.alpha = qnorm(1 - alpha/2, mean = 0, sd = 1)
      n_c = (treat * (1 - treat) / r + control * (1 - control)) * ((z.alpha + z.beta) / (treat - control)) ^ 2
    } 
  } else {
    treat = control*OR / (1 - control + control * OR)
    if (design == "NonInferiority") {
      n_c = ((z.alpha + z.beta) / (log(OR) + delta))^2 * (1/(r*treat*(1-treat)) + 1/(control*(1-control)))
    } else if (design == "Equivalence") {
      z.beta = qnorm(1 - beta/2, mean = 0, sd = 1)
      n_c = ((z.alpha + z.beta) / (delta - abs(log(OR))))^2 * (1/(r*treat*(1-treat)) + 1/(control*(1-control)))
    } else if (design == "Superiority") {
      n_c = ((z.alpha + z.beta) / (log(OR) - delta))^2 * (1/(r*treat*(1-treat)) + 1/(control*(1-control)))
    } else if (design == "Equality") {
      z.alpha = qnorm(1 - alpha/2, mean = 0, sd = 1)
      n_c = ((z.alpha + z.beta) / log(OR))^2 * (1/(r*treat*(1-treat)) + 1/(control*(1-control)))
    } 
  }
  
  
  # r = n_t/n_c
  n_c = ceiling(n_c/(1-drop_rate))
  n_t = ceiling(n_c * r)
  
  return(list(n_treat = n_t, n_control = n_c, n_total = n_t + n_c))
}

rct_survival = function(delta, ta, tb, k=1, power, alpha, 
                            lambdaT, lambdaC, mC, mT,
                            design = c("Equivalence", "NonInferiority", "Superiority", "Equality")) {
  design = match.arg(design, c("Equivalence", "NonInferiority", "Superiority", "Equality"))
  beta = 1 - power
  z.alpha = qnorm(1 - alpha, mean = 0, sd = 1)
  z.beta = qnorm(1 - beta, mean = 0, sd = 1)
  if (design != "Equality") {delta = abs(delta)}
  pcpt = k/((1+k)^2)
  
  if (missing(lambdaC) | missing(lambdaT)){
    lambdaC = log(2) / mC
    lambdaT = log(2) / mT
    b = log(mT / mC)
  } else {
    mC = log(2) / lambdaC
    mT = log(2) / lambdaT
    b = log(lambdaC / lambdaT)
  }
  
  # probability of events
  Pr_control = 1 - (1/6)*(exp(-lambdaC * tb) + 4*exp(-lambdaC * (0.5*ta + tb)) + exp(-lambdaC * (ta + tb)))
  Pr_treat = 1 - (1 - Pr_control)^(lambdaT/lambdaC)
  Pr = (Pr_control + k * Pr_treat) / (1 + k)
  
  # calculate n total
  if (design == "NonInferiority") {
    n_total = ((z.alpha + z.beta)^2) / (((b + delta)^2) * pcpt * Pr)
  } else if (design == "Equivalence") {
    z.beta = qnorm(1 - beta/2, mean = 0, sd = 1)
    n_total = ((z.alpha + z.beta)^2) / (((delta - abs(b))^2) * pcpt * Pr)
  } else if (design == "Superiority") {
    n_total = ((z.alpha + z.beta)^2) / (((b - delta)^2) * pcpt * Pr)
  } else if (design == "Equality") {
    z.alpha = qnorm(1 - alpha/2, mean = 0, sd = 1)
    n_total = ((z.alpha + z.beta)^2) / ((b^2) * pcpt * Pr)
  }
  
  # k = n_t/n_c with n_c = 1
  n_c = ceiling((1/(1+k)) * n_total)
  n_t = ceiling(k * n_c)
  n_total = n_c + n_t
  
  return(list(n_treat = n_t, n_control = n_c, n_total = n_total, 
              lambdaC = lambdaC, lambdaT = lambdaT, mC = mC, mT = mT,
              Pr_control = Pr_control, Pr_treat = Pr_treat,
              Pr = Pr))
}

cc = function(p0, p1, OR, r=1, rho=0.2, alpha, power, two.side=T, design = c("matched", "unmatched")) {
    design = match.arg(design,  c("matched", "unmatched"))
    beta = 1 - power
    alpha = ifelse(two.side==T, alpha / 2, alpha)
    z.alpha = qnorm(1 - alpha, mean = 0, sd = 1)
    z.beta = qnorm(1 - beta, mean = 0, sd = 1)
    
    if (design == "unmatched" & !missing(OR)) {
        p1 = p0*OR/(1-p0+OR*p0)
    }

    if (design == "matched" & !missing(OR)) {
        a = (1-p0+OR*p0)^2+rho^2*(1-OR)^2*p0*(1-p0)
        b = -2*OR*p0*(1-p0+OR*p0)-rho^2*(1-OR)^2*p0*(1-p0)
        c = OR^2 * p0^2
        case1 = (-b + sqrt(b^2-4*a*c)) / (2*a)
        case2 = (-b - sqrt(b^2-4*a*c)) / (2*a)
        err1 = (case1*(1-p0)-rho*sqrt(case1*p0*(1-case1)*(1-p0)))/(p0*(1-case1)-rho*sqrt(case1*p0*(1-case1)*(1-p0)))-OR
        err2 = (case2*(1-p0)-rho*sqrt(case2*p0*(1-case2)*(1-p0)))/(p0*(1-case2)-rho*sqrt(case2*p0*(1-case2)*(1-p0)))-OR
        if (abs(err1) < 10^-5) p1 = case1
        if (abs(err2) < 10^-5) p1 = case2
    } else if (design == "matched" & missing(OR)) {
        OR = (p1*(1-p0) - rho * sqrt(p1*(1-p1)*p0*(1-p0))) / (p0*(1-p1) - rho * sqrt(p1*(1-p1)*p0*(1-p0)))
    }
    
    if (design == "unmatched") {
        pbar = (r * p0 + p1) / (r + 1)
        Np1 = z.alpha * sqrt((r + 1) * pbar * (1 - pbar))
        Np2 = z.beta * sqrt(p0 * (1 - p0) + r * p1 * (1 - p1))
        n = (Np1 + Np2) ^ 2 / (r * (p1 - p0) ^ 2)
        n_cc = n / 4 * (1 + sqrt(1 + 2 * (r + 1)/(r * n * abs(p1 - p0)))) ^ 2
        n_case = ceiling(n)
        n_case_cc = ceiling(n_cc)
        n_control = ceiling(r * n_case)
        n_control_cc = ceiling(r * n_case_cc)
        return(list(fless.case = n_case, fless.control = n_control, 
                    flesscc.case = n_case_cc, flesscc.control = n_control_cc))
    }
    
    if (design == "matched") {
        psi = OR
        pq = p1 * (1 - p1) * p0 * (1 - p0)
        p0.p = (p1 * p0 + rho * sqrt(pq)) / p1
        p0.n = (p0 * (1 - p1) - rho * sqrt(pq)) / (1 - p1)
        
        tm = ee.psi = ee.one = nu.psi = nu.one = rep(NA, r)
        for(m in 1:r){
            tm[m] <- p1 * choose(r, m - 1) * ((p0.p)^(m - 1)) * ((1 - p0.p)^(r - m + 1)) + (1 - p1) * choose(r,m) * ((p0.n)^m) * ((1 - p0.n))^(r - m)
            ee.psi[m] <- m * tm[m] * psi / (m * psi + r - m + 1)
            ee.one[m] <- m * tm[m] / (r + 1)
            nu.psi[m] <- m * tm[m] * psi * (r - m + 1) / ((m * psi + r - m + 1)^2)
            nu.one[m] <- m * tm[m] * (r - m + 1) / ((r + 1)^2)
        }
        
        ee.psi <- sum(ee.psi)
        ee.one <- sum(ee.one)
        nu.psi <- sum(nu.psi)
        nu.one <- sum(nu.one)
        
        n1 <- ceiling(((z.beta * sqrt(nu.psi) + z.alpha * sqrt(nu.one))^2) / ((ee.one - ee.psi)^2))
        n2 <- ceiling(r * n1)    
        return(list(n.case = n1, n.control=n2))
    }
}

cohort = function(p1, p2, RR, r=1, rho=0.2, alpha, power, drop_rate, two.side=T, design = c("independent", "paired")) {
    design = match.arg(design,  c("independent", "paired"))
    beta = 1 - power
    alpha = ifelse(two.side==T, alpha / 2, alpha)
    z.alpha = qnorm(1 - alpha, mean = 0, sd = 1)
    z.beta = qnorm(1 - beta, mean = 0, sd = 1)
    
    if (design=="independent" & !missing(RR)) {
        p2 = RR * p1
    }
    
    if (design == "independent") {
        pbar = (r * p1 + p2) / (r + 1)
        Np1 = z.alpha * sqrt((r + 1) * pbar * (1 - pbar))
        Np2 = z.beta * sqrt(p1 * (1 - p1) + r * p2 * (1 - p2))
        n = (Np1 + Np2) ^ 2 / (r * (p2 - p1) ^ 2)
        n_cc = n / 4 * (1 + sqrt(1 + 2 * (r + 1)/(r * n * abs(p2 - p1)))) ^ 2
        n_exposed = ceiling(n/(1-drop_rate))
        n_exposed_cc = ceiling(n_cc/(1-drop_rate))
        n_unexposed = ceiling(r * n_exposed)
        n_unexposed_cc = ceiling(r * n_exposed_cc)
        return(list(n_exposed = n_exposed, n_unexposed = n_unexposed,
                    n_exposed_cc = n_exposed_cc, n_unexposed_cc = n_unexposed_cc))
    }
    
    if (design=="paired" & !missing(RR)) {
        p2 = RR * p1
    }

    if (design == "paired") {
        pa = p1 * (1-p2) - rho * sqrt(p2 * (1-p2) * p1 * (1-p1))
        pb = p2 * (1-p1) - rho * sqrt(p2 * (1-p2) * p1 * (1-p1))
        pstar = pb / (pa + pb)
        n = (0.5 * z.alpha + z.beta * sqrt(pstar * (1 - pstar))) ^ 2 / (pa * pb * (pstar - 0.5)^2)
        n_exposed = ceiling(n/(1-drop_rate))
        return(list(n_exposed = n_exposed, n_unexposed = n_exposed))
    }
}

cohort_survival = function(p1, p2, HR, lambda, ta, tb, r=1, alpha, power, two.side=T) {
    beta = 1 - power
    alpha = ifelse(two.side==T, alpha / 2, alpha)
    z.alpha = qnorm(1 - alpha, mean = 0, sd = 1)
    z.beta = qnorm(1 - beta, mean = 0, sd = 1)
    
    if (!missing(ta)&!missing(tb)) {
        p1 = 1 - exp(-lambda*tb) *(1-exp(-lambda*ta)) / lambda*ta
        p2 = 1 - exp(- lambda*HR * tb) *(1-exp(- lambda*HR * ta)) / (lambda*HR * ta)
    }
    n2 = (1 / (r * p1) + 1 / p2) * ((z.alpha + z.beta) / log(HR)) ^ 2
    n2 = ceiling(n2)
    n1 = ceiling(n2 * r)
    return(list(n_exposed=n2, n_unexposed = n1, p1=p1, p2=p2))
}

cross_sectional = function(p1, p2, variance, RR, r=1, alpha, power, two.side=T, design = c("continuous", "proportion")) {
    design = match.arg(design,  c("continuous", "proportion"))
    beta = 1 - power
    alpha = ifelse(two.side==T, alpha / 2, alpha)
    z.alpha = qnorm(1 - alpha, mean = 0, sd = 1)
    z.beta = qnorm(1 - beta, mean = 0, sd = 1)
    
    if (design == "proportion" & !missing(RR)) {
        p1 = p2 * RR
    }
    if (design == "proportion") {
        pbar = (r * p1 + p2) / (r + 1)
        Np1 = z.alpha * sqrt((r + 1) * pbar * (1 - pbar))
        Np2 = z.beta * sqrt(p1 * (1 - p1) + r * p2 * (1 - p2))
        n = (Np1 + Np2) ^ 2 / (r * (p2 - p1) ^ 2)
        n_cc = n / 4 * (1 + sqrt(1 + 2 * (r + 1)/(r * n * abs(p2 - p1)))) ^ 2
        n_exposed = ceiling(n)
        n_exposed_cc = ceiling(n_cc)
        n_unexposed = r * n_exposed
        n_unexposed_cc = r * n_exposed_cc
        return(list(n1 = n_unexposed, n2 = n_exposed,
                    n1_cc = n_unexposed_cc, n2_cc = n_exposed_cc))
    }
    if (design == "continuous") {
        n2 = (1 + 1/r) * variance * ((z.alpha + z.beta) / (p1 - p2))^2
        n2 = ceiling(n2)
        n1 = ceiling(r * n2)
        return(list(n1 = n1, n2 = n2))
    }
}

survey = function(v, d, alpha, two.side=T, design = c("continuous", "proportion")) {
    design = match.arg(design,  c("continuous", "proportion"))
    alpha = ifelse(two.side==T, alpha / 2, alpha)
    z.alpha = qnorm(1 - alpha, mean = 0, sd = 1)
    
    if (design=="continuous") {
        n = (z.alpha*v/d)^2
    }
    if (design=='proportion') {
        n = (z.alpha/d)^2*v*(1-v)
    }
    n = ceiling(n)
    return(list(n=n))
}

auc = function(beta, alpha, theta, theta0, prevalence) {
    r = prevalence / (1 - prevalence)
    n = ((qnorm(beta) + qnorm(1-alpha/2)) / (log(theta/(1-theta)) - log(theta0/(1-theta0))))^2
    n = n * (1 + r) 
    n = n *(theta / (r * (2 - theta)) + 2*theta^2/(1+theta) - theta^2 * (1/r+1))
    n = n/(theta^2*(1-theta)^2)
    ncase = ceiling(n * prevalence)
    ncontrol = ceiling(n * (1 - prevalence))
    return(list(ncase=ncase, ncontrol=ncontrol))
}

# === Archived functions === #
rct_survival_archive = function(HR, delta, pi_treat, pi_control, ta, tb, lambda, r=1, power, alpha, design = c("Equivalence", "NonInferiority", "Superiority")) {
  design = match.arg(design, c("Equivalence", "NonInferiority", "Superiority"))
  beta = 1 - power
  z.alpha = qnorm(1 - alpha, mean = 0, sd = 1)
  
  delta = abs(delta)
  log_hr = log(HR)
  
  if (missing(pi_treat) & missing(pi_control)) {
    pi_control = 1 - exp(-lambda*tb) *(1-exp(-lambda*ta)) / lambda*ta
    pi_treat = 1 - exp(- lambda*HR * tb) *(1-exp(- lambda*HR * ta)) / (lambda*HR * ta)
  }
  pi = (pi_control + pi_treat) /2
  
  if (design == "NonInferiority") {
    z.alpha = qnorm(1 - alpha, mean = 0, sd = 1)
    z.beta = qnorm(1 - beta, mean = 0, sd = 1)
    n_c = ((r + 1) / (pi * r)) * ((z.alpha + z.beta) / (log_hr + delta)) ^ 2
  } else if (design == "Equivalence") {
    z.alpha = qnorm(1 - alpha, mean = 0, sd = 1)
    z.beta = qnorm(1 - beta, mean = 0, sd = 1)
    n_c = ((r + 1) / (pi * r))  / r * ((z.alpha + z.beta) / (delta - abs(log_hr))) ^ 2
  } else if (design == "Superiority") {
    z.alpha = qnorm(1 - alpha, mean = 0, sd = 1)
    z.beta = qnorm(1 - beta, mean = 0, sd = 1)
    n_c = ((r + 1) / (pi * r))  / r * ((z.alpha + z.beta) / (log_hr - delta)) ^ 2
  } else if (design == "Equality") {
    z.alpha = qnorm(1 - alpha/2, mean = 0, sd = 1)
    z.beta = qnorm(1 - beta, mean = 0, sd = 1)
    n_c = ((r + 1) / (pi * r))  / r * ((z.alpha + z.beta) / (log_hr)) ^ 2
  }
  
  # r = n_t/n_c
  n_c = ceiling(n_c)
  n_t = ceiling(r * n_c)
  
  return(list(n_treat = n_t, n_control = n_c, n_total = n_t + n_c, pi_control=pi_control, pi_treat=pi_treat))
}