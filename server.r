# globals
# table of cees to highlight in various plots


function(input, output, session) {
    # make series drop down menu
    output$seriestags <- renderUI({
      staglist <<- c(paste(DeployID(seriestags), Ptt(seriestags)))
      selectInput('stagmenu', 'select a tag:', staglist)
    })
    
    observeEvent(input$stagmenu, {
      curtag_now <- which(staglist == input$stagmenu)
      
      if(curtag_now != scurtag) {
        setupseries(curtag_now)
        scurtag <<- curtag_now
      }
        
      output$spreviewplot <- renderPlot(renderspreviewplot(ser, sst, sen))
      output$seriesplot <- renderPlot(renderseriesplot(ser, sst, sen))
      output$scurpage <- renderText(paste0(si, '/', ssteps))
    })
    
    output$curpage <- renderText(paste0(si, '/', ssteps))
    
    observeEvent(input$sall, {
      si <<- 0
      sst <<- 1
      sen <<- nrow(ser)
      
      output$spreviewplot <- renderPlot(renderspreviewplot(ser, sst, sen))
      output$seriesplot <- renderPlot(renderseriesplot(ser, sst, sen))
      output$scurpage <- renderText(paste0('1:', ssteps, '/', ssteps))
    })
    
    observeEvent(input$sstart, {
      si <<- 1
      sst <<- (si-1)*sincrement + 1
      sen <<- sst + sincrement - 1
      
      output$spreviewplot <- renderPlot(renderspreviewplot(ser, sst, sen))
      output$seriesplot <- renderPlot(renderseriesplot(ser, sst, sen))
      output$scurpage <- renderText(paste0(si, '/', ssteps))
    })
    
    observeEvent(input$send, {
      si <<- ssteps
      sst <<- (si-1)*sincrement + 1
      sen <<- sst + sincrement - 1
      
      if(sen > nrow(ser)) sen <<- nrow(ser)
      
      output$spreviewplot <- renderPlot(renderspreviewplot(ser, sst, sen))
      output$seriesplot <- renderPlot(renderseriesplot(ser, sst, sen))
      output$scurpage <- renderText(paste0(si, '/', ssteps))
    })
    
    observeEvent(input$sfore, {
      si <<- si + 1
      if(si > ssteps) si <<- ssteps
      
      sst <<- (si-1)*sincrement + 1
      sen <<- sst + sincrement - 1
      
      if(sen > nrow(ser)) sen <- nrow(ser)
      
      output$spreviewplot <- renderPlot(renderspreviewplot(ser, sst, sen))
      output$seriesplot <- renderPlot(renderseriesplot(ser, sst, sen))
      output$scurpage <- renderText(paste0(si, '/', ssteps))
    })
    
    observeEvent(input$sback, {
      si <<- si - 1
      if(si < 1) si <<- 1
      
      sst <<- (si-1)*sincrement + 1
      sen <<- sst + sincrement - 1
      
      output$spreviewplot <- renderPlot(renderspreviewplot(ser, sst, sen))
      output$seriesplot <- renderPlot(renderseriesplot(ser, sst, sen))
      output$scurpage <- renderText(paste0(si, '/', ssteps))
    })
    
    
    
    output$spreviewplot <- renderPlot(renderspreviewplot(ser, sst, sen))
    output$seriesplot <- renderPlot(renderseriesplot(ser, sst, sen))
}
