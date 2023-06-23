
predict.cmprsk <- function (object, newdata = NULL, time, lps = FALSE, ...) 
{
  if (!any(regexpr("rms", search()) != -1)) {
  }
  if (!lps) {
    if (missing(time)) 
      stop("specify expected time point.")
    if (time > max(object$uftime)) 
      stop("select a  smaller time.")
    if (time < min(object$uftime)) 
      stop("select a larger time.")
  }
  if (is.null(newdata)) 
    cov1 <- as.matrix(object$cphdat[, -c(1:2)])
  else cov1 <- predict(object$cph.f, newdata, type = "x")
  np <- length(object$coef)
  if (length(object$tfs) <= 1) {
    if (length(object$coef) == length(cov1)) {
      lhat <- cumsum(exp(sum(cov1 * object$coef)) * object$bfitj)
      lp <- sum(cov1 * object$coef)
    }
    else {
      cov1 <- as.matrix(cov1)
      lhat <- matrix(0, nrow = length(object$uftime), ncol = nrow(cov1))
      lp <- matrix(0, nrow = length(object$uftime), ncol = nrow(cov1))
      for (j in 1:nrow(cov1)) {
        lhat[, j] <- cumsum(exp(sum(cov1[j, ] * object$coef)) * 
                              object$bfitj)
        lp[, j] <- sum(cov1[j, ] * object$coef)
      }
      lp <- lp[1, ]
    }
  }
  else {
    if (length(object$coef) == ncol(as.matrix(object$tfs))) {
      if (length(object$coef) == length(cov2)) 
        lhat <- cumsum(exp(object$tfs %*% c(cov2 * object$coef)) * 
                         object$bfitj)
      else {
        cov2 <- as.matrix(cov2)
        lhat <- matrix(0, nrow = length(object$uftime), 
                       ncol = nrow(cov1))
        for (j in 1:nrow(cov2)) lhat[, j] <- cumsum(exp(object$tfs %*% 
                                                          c(cov2[j, ] * object$coef)) * object$bfitj)
      }
    }
    else {
      if (length(object$coef) == length(cov1) + length(cov2)) 
        lhat <- cumsum(exp(sum(cov1 * object$coef[1:length(cov1)]) + 
                             object$tfs %*% c(cov2 * object$coef[(np - length(cov2) + 
                                                                    1):np])) * object$bfitj)
      else {
        cov1 <- as.matrix(cov1)
        cov2 <- as.matrix(cov2)
        lhat <- matrix(0, nrow = length(object$uftime), 
                       ncol = nrow(cov1))
        for (j in 1:nrow(cov1)) lhat[, j] <- cumsum(exp(sum(cov1[j, 
                                                                 ] * object$coef[1:ncol(cov1)]) + object$tfs %*% 
                                                          c(cov2[j, ] * object$coef[(np - ncol(cov2) + 
                                                                                       1):np])) * object$bfitj)
      }
    }
  }
  if (lps) 
    lp
  else {
    lhat <- cbind(object$uftime, 1 - exp(-lhat))
    lhat <- lhat[lhat[, 1] <= time + 1e-10, ]
    lhat <- lhat[dim(lhat)[1], -1]
    lhat
  }
}










































