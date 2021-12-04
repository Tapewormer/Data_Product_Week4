### Interactive Data Viewer ###
library(shiny)
library(ggplot2)

#ds_list <-ls(package:datasets)
ds_list <- c("mtcars","iris","airquality","swiss","women")
shinyUI(fluidPage(
    titlePanel("Classic Dataset Inspector"),
    sidebarLayout(
        # SIDEBAR
        sidebarPanel(
            selectInput("var_ds", "Dataset", ds_list ),
            selectInput("var_x", "Axe x", ""),
            selectInput("var_y", "Axe y", ""),
            selectInput("reg_type", "Regression Type", c("Linear","Non-linear")),
            uiOutput("tab")
        ),
        # MAIN PANEL
        mainPanel(
            plotOutput("main_plot")
        )
    )
))
