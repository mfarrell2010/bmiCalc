library(shiny)

height_in_inches <- function(height_feet, height_inches) {
  (height_feet * 12) + height_inches
}

bmi_calc <- function(height, weight) {
  (weight * 703.0)/(height * height)
}
  
weight_cat <- function(bmiVal) {
  if (bmiVal < 16) "Severe Thinness"
  else if (bmiVal < 17) "Moderate Thinness"
  else if (bmiVal < 18.5) "Mild Thinness"  
  else if (bmiVal < 25) "Normal" 
  else if (bmiVal < 30) "Overweight" 
  else if (bmiVal < 35) "Obese Class I" 
  else if (bmiVal < 40) "Obese Class II" 
  else  "Obese Class III" 
}

weight_by_bmi <- function(height, bmiVal) {
  (bmiVal * height * height) / 703.0
}

shinyServer(function(input, output) {

  output$inputValue <- renderText({
    sprintf("Weight = %3d lbs; Height = %d feet %d inches", input$weight, input$height_feet, input$height_inches)
  })
  output$line1 <- renderText({
    sprintf("BMI = %5.2f kg/m2   (%s)", bmi_calc(height_in_inches(input$height_feet, input$height_inches), input$weight),
            weight_cat(bmi_calc(height_in_inches(input$height_feet, input$height_inches), input$weight)))
  })
  output$line2 <- renderText({"Normal BMI range: 18.5kg/m2 - 25 kg/m2"
  })
  output$line3 <- renderText({
    sprintf("Normal BMI weight range for the height: %5.1f lbs - %5.1f lbs", 
            weight_by_bmi(height_in_inches(input$height_feet, input$height_inches),18.5),
            weight_by_bmi(height_in_inches(input$height_feet, input$height_inches),25))
  })
  # Plot BMI
  output$bmiPlot <- renderPlot({
    ht = seq(48,84, length.out=1000)
    wt = seq(90,300, length.out=1000)
    wtht = expand.grid(x=ht, y=wt)
    bmi = function(h,w) {(w * 703)/(h*h)}
    bmiwtht = matrix(bmi(wtht$x,wtht$y),length(ht),length(wt))
    
    contour(ht,wt,bmiwtht,levels = c(18.5,25,30), drawlabels=FALSE,
            xlab="Height (inches)",ylab="Weight (lbs)",
            main="BMI categories by height and weight")
    text(55,200,"Obese",cex=2,srt=45)
    text(65,165,"Overweight",cex=2,srt=40)
    text(70,150,"Normal",cex=2,srt=35)
    text(75,120,"Underweight",cex=2,srt=18)
    points(height_in_inches(input$height_feet, input$height_inches), input$weight, pch=17, col='red')
  })
}) 