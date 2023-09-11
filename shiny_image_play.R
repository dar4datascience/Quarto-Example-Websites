pacman::p_load(
  shiny,
  bslib,
  magick
)


ui <- page_sidebar(
  title = "Play dashboard",
  theme = bs_theme(
    bootswatch = "darkly",
    base_font = font_google("Poppins"),
    navbar_bg = "purple"
  ),
  sidebar = sidebar(
    title = "Magick controls",
    sliderInput("fps",
                "Frames per Second",
                10,
                60,
                step = 5,
                round = TRUE,
                animate = TRUE,
                value = 20)
  ),
  card(
    card_header("We want smooth Gif"),
    imageOutput("video2gif")
  )
)

server <- function(input, output) {
  output$video2gif <- renderImage({
    # A temp file to save the output. It will be deleted after renderImage
    # sends it, because deleteFile=TRUE.
    #outfile <- tempfile(fileext='png')

    demo_video <- image_read_video("Site Image Reels Assets/PXL_20230911_004506245.TS~2.mp4",
                                   fps = 20,
                                   format = 'png')


    outfile <- image_animate(demo_video,
                               fps = input$fps, optimize = TRUE)


    # Return a list
    list(src = outfile,
         alt = "This is alternate text")
  }, deleteFile = TRUE)

}

shinyApp(ui, server)
