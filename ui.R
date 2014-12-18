library(shiny);

shinyUI(
   fluidPage(
      # Application title 
      tags$h2("Bootstrap Pi estimation", align = "center", style = "color:brown"),
      br(),
      fluidRow(
         column(width = 4,
                h4("Description", style = "color:brown"),
                p("From a geometric approach, pi is defined as the ratio between a circumference an its perimeter."),
                p("As it is well known, pi is an irational number that can be calculated with defined presision using numeric sequences."),
                p("An alternative way to define the number pi is as expectation of random variable estimated through bootstrap techinque."),
                br(),
                h4("Methodology", style = "color:brown"),
                p("In order to build the empirical distribution of random variable with expectation being the irrational number pi, a sample of size sampleSize and bootstrap number repetitions numRep are given by users."),
                p("Two random samples of size sampleSize are taken from uniform distribution in (-1, 1)"),
                p("If squared sum of each pair of samples is less than one, number one is assigned, otherwise a 0 is assigned. Then proportion is calculated"),
                p("Every point selected belongs to a square with area equals 4, then 4 times proportion is an estimation of Pi"),
                p("This procedure is repeated numRep times to find the empirical distribution, summary, expectation and confidence interval are calculated."),
                p("Two plots are build: scatterplot of las uniform variables selected and histogram of empirical distribution of pi with mean an confidence interval of 95% drawn in vertical red lines and mean confidence through t.test function in green lines.")
            ),
         column(width = 5,
                tabsetPanel(type = "tabs", 
                            tabPanel("ScatterPlot", plotOutput("distPlot1")),                        
                            tabPanel("Histogram", plotOutput("distPlot2")),
                            tabPanel("Estimates", verbatimTextOutput("summary"))
                )
         ),
         column(width = 3,
                br(),
                br(),
                img(src="PiLogo.png", width = 150),
                br(),
                br(),
                sliderInput('sampleSize', 'Sample size', 300, 1000, 600, step = 100),
                sliderInput('numRep', 'Repetitions', 800, 1200, 1000, step = 100),
                submitButton('Submit')
         )
      )
      
   )
)