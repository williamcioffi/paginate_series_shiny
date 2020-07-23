
navbarPage('sattagqlook',
  tabPanel('paginate_series',
    fluidPage(
     uiOutput('seriestags'),
     fluidRow(
      column(1, actionButton('sall',   'all')),
      column(1, actionButton('sstart', '<<')),
      column(1, actionButton('sback',  '<')),
      column(1, textOutput('scurpage')),
      column(1, actionButton('sfore',  '>')),
      column(1, actionButton('send',   '>>'))
     ),
     br(), br(),
     plotOutput('spreviewplot', height = '20%'),
     plotOutput('seriesplot')
    )
  )
)