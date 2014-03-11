#(ly:set-option 'relative-includes #t)
\include "lib.ly"

\header {
  title = "Goody Goody"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
}

global = {
  \time 4/4
  \key f \major
  \clef "violin"
  \set Score.skipBars = ##t % combine multi-rests
}

structure = {
  \tempo 4 = 138
  \partial 4.
  s4.
  s1*4  % intro
  \bar "||"
  s1*16 % A
  \bar "||"
  s1*16 % B
  s1*0 \rightBreakMark \markup { \right-align \fontsize #4 \musicglyph #"scripts.coda" }
  \bar "||"
  s1*4
  s1*6 \rightMark \markup { \column { \line {"2nd time"} \line{"D.S. al Coda"} } }
  s1*2
  \pCoda
  s1*7 % coda
}

remarks = \lyricmode {
  % \skip 1*34
  % \markupBox "Solo tp"
}

chorusChords = \chordmode {
}

soloChords = \chordmode {
}

theChords = {
  % s1*4
  % \chorusChords
  % s1*4
  % \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  % \soloChords
  % \unset Score.proportionalNotationDuration
}


trumpetChords = \transpose c c \theChords
altoChords = \transpose c c \theChords

slTp = \relative c''' { as4 as as as }
slAs = \relative c'' { des4 des des des }

trumpet = \transpose c c \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  \partial 4.
  f8 r c | f4 e d-- c8 f | r f e4 d-- c8 c | f f f4 f4. c'8 | r1 |
  r1 | r | r | r4 d,\fall d\fall r |
  r1 | r | r | r4 d\fall d\fall r |
  r1 | r | r | r |
  r2 b4 r | b r8 b r2 | r2 b4 r | bes r8 bes r2 |
  des,4 c b bes | des c b bes | r4 d'\fall d\fall r4 | r4 r8 d\fall r2 |
  r1 | r1 | r2 r4 r8 f~ | f4 g bes8 c r bes\fall
  r4 r8 d,~ d4 r | r4 r8 des~ des4 r | c,2 d | d4. e8 r2
}

breaksTp = {
  \partial 4.
  s4.
  s1*4
  s1*16
  s1*16 \break
  s1*4
  s1*6  \break
}

altoSax = \transpose c c \relative c'' {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  \partial 4.
  r4.
  R1*4
  R1*4
  R1*4
  R1*4
  R1*4
  a4 gis g e | a gis g e | r4 a\fall a\fall r4 | r4 r8 a\fall r2 |
  r1 | r2 r4 r8 f~ | f4 g bes8 c r d\fall | r1 |
  r4 r8 bes~ bes4 r | r4 r8 bes~ bes4 r | e,2 fis | g4. a8 r2 |
  r2 \tuplet 3/2 {r8 g gis} \tuplet 3/2 {a c d} | f4-- e8 c d4 r |
  r2 r8 a' r a~ | a4 e d r

}

breaksAs = {
}

\book {
  \score {
    <<
      \lyricsAbove \remarks
      \new ChordNames \trumpetChords
      \new Staff = "trumpet" <<
        \structure
        \trumpet
      >>
      % \new Staff \trumpet
      \new ChordNames \altoChords
      \new Staff = "altoSax" <<
        \altoSax
      >>
    >>
  }
% }
% \book {
%   \bookOutputSuffix "tp"
  \paper {
    % fit on one page
    % system-system-spacing = #'(
    %   (basic-distance . 10)
    %   (minimum-distance . 0)
    %   (padding . 0)
    %   (stretchability . 0))
  }
  \score {
    <<
      \lyricsAbove \remarks
      \new ChordNames \trumpetChords
      \new Staff = "trumpet" <<
        \structure
        \breaksTp
        \trumpet
      >>
    >>
  }
% }
% \book {
%   \bookOutputSuffix "as"
  \score {
    <<
      \lyricsAbove \remarks
      \new ChordNames \altoChords
      \new Staff = "altoSax" <<
        \structure
        \breaksAs
        \altoSax
      >>
    >>
  }
}
