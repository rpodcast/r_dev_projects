# function to play audio file
play_sound <- function(sound_dir = "/path/to/soundboard_files", custom_sink = NULL) {
  audio_file <- sample(list.files(sound_dir, full.names = TRUE))

  play_args <- c(audio_file)

  if (!is.null(custom_sink)) {
    play_args <- c(play_args, "-d", custom_sink)
  }



  system2("paplay", args = c("some_file.wav", "-d", "SoundBoard"), wait = FALSE)

  invisible(TRUE)
}