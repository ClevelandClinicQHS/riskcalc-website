load(".RData")
n = dim(df)[1]
i = n+1
repeat {
    startTime <- Sys.time()
    df <- rbind(df, data.frame(id = i, gender = sample(c("Female", "Male"), 1), bmi = runif(1, min = 15, max = 45)))
    i <- i+1
    save(df, file = ".RData")
    sleepTime <- startTime + 36000 - Sys.time()
    if (sleepTime > 0)
        Sys.sleep(sleepTime)
}

