# Hangman

A command line game of Hangman built using Ruby.

## How to Play

Pretty standard game of Hangman. You attempt to reveal a word by guessing one letter at a time. Correct letters are shown to you while incorrect guesses contribute to your error tally. Accumulate 6 errors and you ... hang? Kinda dark.

Easiest way to play is to use the replit I have set up here: <!--FIXME: Add replit-->

## Improvements

Two most notable improvements I could make:
1. Improve the look of the display/command line output. Could add colors to some of the text, and most significantly, I could represent the incorrect_guesses with an ascii art hangman.
2. Running `play_again?` after the user saves their game is an odd bit of user experience. I suspect fixing this will require quite a bit of refactoring, so I'll leave it as something to possibly return to later.

## Special Thanks

To the [Odin Project](https://theodinproject.com) and the Odin community.