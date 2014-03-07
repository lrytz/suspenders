#(ly:set-option 'relative-includes #t)
\include "lib.ly"

\header {
  title = "Ain't Misbehavin'"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #6 %space after title
}

global = {
  \time 4/4
  \key es \major
  \clef "violin"
  \set Score.skipBars = ##t % combine multi-rests
}

structure = {
  \tempo 4 = 98
  s1*4 \bar "||"
  s1*32 \bar "||"
  s1*0^"Vocals" s1*30 \bar "||"
  \tempo 4 = 136
  s1*4 \bar "||"
  s1*0^"Piano + Percussion" s1*16
  s1*6 s1^"rit. "
  \tempo 4 = 98
  s1*8 \bar "|."
}

remarks = \lyricmode {
  \skip 1*4
  \skip 1*32
  \skip 1*30
  \skip 1*4
  \skip 1*16
  \markupBox "Solo (tutti)" 1 % duration 1
  \skip 1*7
  \markupBox "Fills (tutti)"
}

slash = {
  \override NoteHead.style = #'slash
  \hide Stem
}
endSlash = {
  \revert NoteHead.style
  \undo \hide Stem
}

theChords = \chordmode {
  s1*4
  s1*32
  s1*30
  s1*4
  s1*16
  \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  c1:m7 as:7 f:7 c:7
  bes c2:m7 f:7 s1 s % bes1:7 f2:m7 bes:7
  es2 c:m7 f:m7 bes:7 es g:7.5+ as as:m
  es:/g c:m7 f:7 bes:7 % es1 es4 b:7 bes2:7
  \unset Score.proportionalNotationDuration
}

trumpetChords = \transpose bes c \theChords
altoChords = \transpose es c \theChords

slTp = \relative c''' { as4 as as as }
slAs = \relative c'' { d4 d d d }

trumpet = \transpose bes c \relative c''' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  R1*4
  R1*31 r2 r4 fis,^"Flugel" \glissando
  g2 r8 g \tuplet 3/2 { bes a as~ } | as2 r8 as f fis | g2 des' | c ces |
  bes r4 g8 ges | f2 as | g bes4. r8 | a2 as4 fis4 \glissando |
  g2 r4 g | as2 r4 \tuplet 3/2 { as8 f fis } | g2 des' | c ces |
  bes r4 g8 ges | f2 as | g as8 ces4 as8 | g2 r |
  R1*7 | r2 r4 fis \glissando
  g2 r8 bes \tuplet 3/2 { r c bes } | as2 r4 \tuplet 3/2 { es'8 c as } | g2 bes4 des | es c8 ces~ ces4 ces8 bes~ |
  bes2 r8 g \tuplet 3/2 { c g ges } | f2 as |
  R1*4  % drums
  R1*16 % piano + percussion
  \slash
  as4^"Trumpet" as as as \repeat unfold 5 \slTp R1*2 %solo
  \repeat unfold 6 \slTp  % fills
  \endSlash
  r8 bes b c des4-. des8 c~ | c4 ces8 bes~ bes2^\fermata
}

breaksTrumpet = {
  s1*40 \break
  s1*8  \break
  s1*13 \break
  s1*5  \break
  s1*20 \break % drums, piano + percussion
  s1*4  \break % solo
  s1*4  \break % solo
  s1*4  \break % solo
}

altoSax = \transpose es c \relative c''   {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  R1*4 R1*32
  R1*15 | r2 \tuplet 3/2 { g8 a d } \tuplet 3/2 { f d es } |
  c4 \tuplet 3/2 { d8 es f } \tuplet 3/2 { g es f }  \tuplet 3/2 { d es c } | es4 r8 fis, \tuplet 3/2 { a c es }  \tuplet 3/2 { f ges f } | es4 r \tuplet 3/2 { a8 c d } \tuplet 3/2 { es d c } | a4-- bes8 g \tuplet 3/2 { e c d } bes4 |
  r g16. bes32 \tuplet 5/4 { c32 cis d f a } d4 d8 d | es r \tuplet 3/2 { fis, g bes } d d~ d4 | r8 f,16 g bes g des' b c8-. g~ g8. g16 | d c g'8 d16 c8. r8 ges' \tuplet 3/2 { d16 c bes } ges8 |
  R1*6
  R1*4  % drums
  R1*16 % piano + percussion
  \slash
  \repeat unfold 6 \slAs R1*2 %solo
  \repeat unfold 6 \slAs % fills
  \endSlash
  r8 es' e f ges4-. ges8 f~ | f4 ges8 g~ g2^\fermata
}

breaksAlto = {
  s1*52 \break
  s1*4  \break
  s1*4  \break
  s1*26 \break % drums, piano + percussion
  s1*4  \break % solo
  s1*4  \break % solo
  s1*4  \break % solo
}

% \book {
%   \score {
%     <<
%       \new ChordNames \trumpetChords
%       \new Staff = "trumpet" <<
%         \structure
%         \trumpet
%       >>
%       % \new Staff \trumpet
%       \new ChordNames \altoChords
%       \new Staff = "altoSax" <<
%         \altoSax
%       >>
%     >>
%   }
% }
\book {
  \bookOutputSuffix "tp"
  \score {
    <<
      \lyricsAbove \remarks
      \new ChordNames \trumpetChords
      \new Staff = "trumpet" <<
        \structure
        \breaksTrumpet
        \trumpet
      >>
    >>
  }
}
\book {
  \bookOutputSuffix "as"
  \score {
    <<
      \lyricsAbove \remarks
      \new ChordNames \altoChords
      \new Staff = "altoSax" <<
        \structure
        \breaksAlto
        \altoSax
      >>
    >>
  }
}
