library(shiny);

# TAKE PARAMETERS OF SAMPLE SIZE AND REPETITIONS TO EVALUATE BOOTSTRAP FUNCTION

funBoot <- function(sampleSize, numRep){
   vec <- numeric(numRep);
   for(i in 1:numRep){
      x1 <- runif(sampleSize, -1, 1);
      x2 <- runif(sampleSize, -1, 1);        
      vec[i] <- 4*mean(x1^2 + x2^2 < 1);
   }
   return = list(vec, x1, x2);
}

shinyServer(
   function(input, output){
      
      # EVALUATE BOOTSTRAP FUNCTION
      dat <- reactive({
         funBoot(input$sampleSize, input$numRep)
      })
      
      # DEFINE COLORS
      myCol <- colors()[20:23]
      
      
      # RENDER SCATTERPLOT OF LAST UNIFORM RENDOM NUMBERS USED IN BOOTSTRAP
      output$distPlot1 <- renderPlot({
         opar <- par(mar = c(2,2,1,1));
         plot(dat()[[2]], dat()[[3]], pch = 16, col = ifelse(dat()[[2]]^2 + dat()[[3]]^2 < 1, "green4", "tomato"));
         curve(sqrt(1-x^2), add = TRUE);
         curve(-sqrt(1-x^2), add = TRUE);
         par(opar);
      })
      
      # RENDER HISTOGRAM OF PI EMPIRIC DISTRIBUTION GENERATED WITH BOOTSTRAP
      output$distPlot2 <- renderPlot({
         opar <- par(mar = c(4,4,2,1));
         hist(dat()[[1]], col = myCol, main = "Sample distribution", xlab = "Estimated Pi", ylab = "Frecuencies");
         abline(v = quantile(dat()[[1]], p = c(0.025, 0.5, 0.975)), col = "red3", lwd = 3, lty = c(1, 2, 1));
         abline(v = t.test(dat()[[1]])$conf.int, col = "green4", lwd = 2);
         par(opar);
      })
      
      # SUMMARY AN CONFIDENCE INTERVAL FOR PI ESTIMATES
      output$summary <- renderPrint({
         
         cat("Estimated nean of Pi vector\n");
         cat("------------------------------------------\n");
         print(mean(dat()[[1]]));
         cat("------------------------------------------\n");
         
         cat("\n Summary for Pi empirical distribution\n");
         cat("------------------------------------------\n");
         print(summary(dat()[[1]]));
         cat("------------------------------------------\n");
         
         cat("\n Confidence intervel through t.test function\n");
         cat("------------------------------------------\n");
         print(t.test(dat()[[1]])$conf.int);
         cat("------------------------------------------\n");
      })
      
   }
)