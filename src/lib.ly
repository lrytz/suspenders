\version "2.18.0"

slash = {
  \override NoteHead.style = #'slash
  \hide Stem
}

endSlash = {
  \revert NoteHead.style
  \undo \hide Stem
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
