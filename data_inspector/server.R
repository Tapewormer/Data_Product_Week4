### Interactive Data Viewer ###

shinyServer(function(input, output) {
    # HELP PAGE
    output$tab <- renderUI({
        # tag uses html tag. "a" is for link adress
        tags$a(href="https://github.com/Tapewormer/Data_Product_Week4/blob/main/README.md", "Online instructions")
    })
    # var_ds = contains the name (only as character) of the chosen dataset. 
    # Need to use get() to obtain the actual instance (then names() for cols)
    ds_col_names = reactive({
        names(get(input$var_ds))
    })
    # works with observe and not reactive 
    observe({
        plot_ds=print(input$var_ds)
        updateSelectInput(session = getDefaultReactiveDomain(), "var_x", choices = ds_col_names())
        updateSelectInput(session = getDefaultReactiveDomain(), "var_y", choices = ds_col_names())
        #### PLOT ########
        output$main_plot <- renderPlot({
            if (input$reg_type == "Linear"){
                reg_method = "lm"
            } else {
                reg_method = "loess"
            }
            # Plot rendering (comprehension of col names is lost when called inside
            # the function so !! are needed in front to get them back see rlang)
            ggplot(get(plot_ds), aes(get(!!input$var_x) , get(!!input$var_y))) + 
                geom_point() +  
                geom_smooth(method=reg_method)
        })
        #### PLOT ########
    })
})

