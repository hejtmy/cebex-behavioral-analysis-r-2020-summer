pth <- "data/jovi/Jovi4_13.json"
library(jsonlite)
dat <- fromJSON(pth)
str(dat)
head(dat$data)
View(dat$data)

txt <- dat$data$image[120]
## REGULAR EXPRESSION
dat$data %>%
  extract(image, into=c("jitter"), regex = "jit([0-9]+)",
          remove=FALSE, convert = TRUE) %>%
  str()

load_jovi <- function(path){
  dat <- fromJSON(pth)
  dat$data <- dat$data %>%
    extract(image, into=c("jitter"), regex = "jit([0-9]+)",
            remove=FALSE, convert = TRUE)
  return(dat)
}

jovi <- load_jovi(pth)
head(jovi$data)

#list.files
#for
#rbind
