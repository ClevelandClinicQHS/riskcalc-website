##' Generate index numbers for passwords
##'
##' Generate index numbers for passwords or passwords based
##' on the index numbers reversely
##'
##' @title Generate index numbers for passwords
##' @param index, the index numbers for passwords.
##' @param key, passwords in character
##' @param seed, random seed used for index generation
##' @param ..., other parameter that is not implemented yet.
##' @return index or password
##' @author Changhong
##' @export
keyGen <- function(index ,key,seed = 111,...) {
    set.seed(seed)
    tmp.key <- c(0:9,letters,LETTERS,c("@","$","&","*","?","^",",","+","-",".",",","#"))
    dict <- sample(tmp.key ,length(tmp.key ))
    if(!missing(key)){
         key <- unlist(strsplit(key,split = ""))
         index <- sapply(key,function(x) charmatch(x, dict))
         return(index = paste(index,sep="",collapse=","))
    }
    else  {
           if(missing(index)) stop("either index or key must be specified !!!")
           else    {
             index <- paste("c(",index,")")
             index.num <- eval(parse(text =index))
             return(key =paste(dict[index.num],sep="",collapse=""))
           }

       }

}
