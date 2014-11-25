slash = {
  \override NoteHead.style = #'slash
  \hide Stem
}

endSlash = {
  \revert NoteHead.style
  \undo \hide Stem
}

slashStem = {
  \override NoteHead.style = #'slash
}

endSlashStem = {
  \revert NoteHead.style
}

cross = {
  \override NoteHead.style = #'cross
}

endCross = {
  \revert NoteHead.style
}


% function that returns music
lyricsAbove = #(define-music-function
  (parser location lyrics)
  (ly:music?)
  #{
    \new Lyrics \with { \override VerticalAxisGroup.staff-affinity = #DOWN } $lyrics
  #})

% function that does not return music
markupBox = #(define-scheme-function
  (parser location text)
  (markup?)
  #{
    \markup { \box { #text } }
  #})

% right-aligned mark
rightMark = #(define-music-function
  (parser location text)
  (markup?)
  #{
    \once \override Score.RehearsalMark.self-alignment-X = #RIGHT
    \mark #text
  #})

centerMark = #(define-music-function
  (parser location text)
  (markup?)
  #{
    \once \override Score.RehearsalMark.self-alignment-X = #CENTER
    \mark #text
  #})

leftMark = #(define-music-function
  (parser location text)
  (markup?)
  #{
    \once \override Score.RehearsalMark.self-alignment-X = #LEFT
    \mark #text
  #})

% right-aligned mark in an end-of-line bar
rightBreakMark = #(define-music-function
  (parser location text)
  (markup?)
  #{
    \once \override Score.RehearsalMark.break-visibility = #end-of-line-visible
    \once \override Score.RehearsalMark.self-alignment-X = #RIGHT
    \mark #text
  #})

pSegno = \mark \markup { \musicglyph #"scripts.segno" }

pCoda = {
  \once \override Score.RehearsalMark.font-size = #4
  \mark \markup { \musicglyph #"scripts.coda" }
}

fall = \bendAfter #-2

% don't know how to put \bendAfter into a music-function.
% current usage: \be c \nd
nd = \bendAfter #2
be = #(define-music-function
  (parser location note)
  (ly:music?)
  #{
  \once \override BendAfter #'extra-offset = #'(-2.9 . -1.2)
    #note
  #})
