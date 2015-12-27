library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
  
  title = "BMI Calculator",
  titlePanel("BMI Calculator"),
  fluidRow(
    column(2,
           numericInput('weight', 'Weight (pounds)', 150, min = 50, max = 200, step = 5)),
    column(2),
    column(8,
           h2("RESULTS", style = "color: red;"))
  ),
  fluidRow(
    column(2,
           numericInput('height_feet', 'Height (feet)', 5, min = 1, max = 8, step = 1),
           submitButton('Calculate')),
    
    column(2,
           numericInput('height_inches', 'Height (inches)', 8, min = 0, max = 11, step = 1)),
           
    column(8,
           h4('You entered:'),
           verbatimTextOutput("inputValue"),
           h4('Which resulted in a calculation of: '),
           verbatimTextOutput("line1"))
  ),
  fluidRow(
    column(4,
           h4('Instructions: Enter weight and height, press Calculate.'),
           p("The body mass index (BMI) or Quetelet index is a value derived from the mass (weight) and height of an individual. The BMI is defined as the body mass divided by the square of the body height, and is universally expressed in units of kg/m2, resulting from mass in kilograms and height in metres. The BMI may also be determined using a table[note 2] or chart which displays BMI as a function of mass and height using contour lines or colors for different BMI categories, and may use two different units of measurement."),
           p("The BMI is an attempt to quantify the amount of tissue mass (muscle, fat, and bone) in an individual, and then categorize that person as underweight, normal weight, overweight, or obese based on that value. However, there is some debate about where on the BMI scale the dividing lines between categories should be placed.[2] Commonly accepted BMI ranges are underweight: under 18.5, normal weight: 18.5 to 25, overweight: 25 to 30, obese: over 30")),    
    column(8,
           h5("Classification based on World Health Organization's (WHO) recommended body weight based on BMI values for Adults"),
           verbatimTextOutput("line2"),
           verbatimTextOutput("line3"),
           plotOutput("bmiPlot"))
  )
))