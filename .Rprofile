# function to play audio file
play_sound <- function(sound_dir = "soundboard", custom_sink = NULL) {
  audio_file <- sample(list.files(sound_dir, full.names = TRUE))

  play_args <- c(audio_file)

  system2("paplay", args = c("some_file.wav", "-d", "SoundBoard"), wait = FALSE)

  invisible(TRUE)
}