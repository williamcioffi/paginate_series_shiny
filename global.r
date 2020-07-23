library(shiny)
library(sattagutils)
source('findgaps.r')

tags <- sattagutils::batch_load_tags('testtags')
tags <- tags[order(DeployID(tags))]
seriestags <- tags[sapply(sattagutils::streamtype(tags), function(x) 'series' %in% x)]
behtags <- tags[sapply(sattagutils::streamtype(tags), function(x) 'behavior' %in% x)]

ceetable_cur <- NULL
staglist <- NULL
scurtag <- 1

sct <- seriestags[[scurtag]]
ser <- sattagutils::getstream(sct, 'series', squash = TRUE)
sincrement <- 4*48
ssteps <- ceiling(nrow(ser) / sincrement)
si <- 1
sst <- (si-1)*sincrement + 1
sen <- sst + sincrement - 1

setupseries <- function(tagnum) {
  sct <<- seriestags[[tagnum]]
  ser <<- sattagutils::getstream(sct, 'series', squash = TRUE)
  ssteps <<- ceiling(nrow(ser) / sincrement)
  si <<- 1
  sst <<- (si-1)*sincrement + 1
  sen <<- sst + sincrement - 1
}


renderspreviewplot <- function(ser, sst, sen) {
  if(nrow(ser) > 0) {
    par(mar = rep(0, 4))
    sattagutils::plot_series(ser, axes = FALSE, points = FALSE)
    rect(ser$Date[sst], -10000, ser$Date[sen], 10000, col = rgb(0, 0, 1, .25), border = FALSE)
  } else {
    emptyplot()
  }
}

renderseriesplot <- function(ser, sst, sen) {
  if(nrow(ser) > 0) {
    sattagutils::plot_series(ser[sst:sen, ], xaxt = 'n', las = 1)
    ax <- sattagutils::dateseq(c(ser$Date[sst], ser$Date[sen]))
    ax2 <- sattagutils::dateseq(c(ser$Date[sst], ser$Date[sen]), hours = TRUE)
    axis(1, at = ax, lab = format(sattagutils::num2date(ax), "%d-%b"), las = 2)
    axis(1, at = ax2, lab = NA, tcl = -0.15)
  } else {
    emptyplot()
  }
}

emptyplot <- function() plot(0, 0, type = 'n', axes = FALSE, xlab = "", ylab = "")

# functions
# setupdisp <- function() {
  
# }

# dispall <- function()
# dispstart <- function()
# dispback <- function()
# dispfore <- function()
# dispend <- function()
