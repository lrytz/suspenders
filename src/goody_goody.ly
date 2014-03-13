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
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 138
  \partial 4.
  s4.
  s1*4  % intro
  \bar "||"
  s1*16 % A
  \bar "||"
  \pSegno
  s1*16 % B
  s1*0 \rightBreakMark \markup { \right-align \fontsize #3 \musicglyph #"scripts.coda" }
  \bar "||"
  s1*4
  s1*6 \centerMark \markup { \center-column { \line { \box {"2nd time D.S. al Coda"} } \line{"↓"} } }
  s1*2
  \pCoda
  s1*10 % coda
  \bar "|."
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

trumpet = \transpose ges c \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  \partial 4.
  f8 r c | f4 e d-- c8 f | r f e4 d-- c8 c | f f f4 f4. c'8 | r1 |
  r1 | r | a,8 as a4 g8 f4 a8 | r4 d\fall d\fall r |
  r1 | r | a8 as a4 g8 fis4 a8 | r4 d\fall d\fall r |
  r1 | r | r | r |
  r2^"cup mute" b4 r | b r8 b r2 | r2 b4 r | bes r8 bes r2^"open" |
  des4^"first time only"( c b bes | des c b bes) | r4 d^"play always"\fall d\fall r4 | r4 r8 d\fall r2 |
  r1 | %TODO: background
  r1 | r2 r4 r8 f~ | f4 g bes8 c r bes\fall
  r4 r8 d,~ d4 r | r4 r8 des~ des4 r | c2 d | d4. e8 r2 |
  r2 \tuplet 3/2 {r8 g, as} \tuplet 3/2 {a c d} | f4-- e8 c d4 r |
  r2 r8 a'\fall r a~ | a4 e d r
  r8 d4.~ d2 | r8 d4. r8 d4. | r4 f8 f f4 f8 f8 | f4 r r2

  \repeat volta 2 {
    \cross
    r4^"hand clap" f r f \repeat unfold 7 {r4 f r f}
    \endCross
  }

  R1*6 % TODO: background
  \tuplet 3/2 {r4 as f} \tuplet 3/2 {es c as} | \tuplet 3/2 {f es' b} \tuplet 3/2 {bes as f} | r2 r8 f'' r8 d8~ | d2 \fermata r2
}

breaksTp = {
  \partial 4.
  s4.
  s1*4
  s1*16
  s1*16 \break
  s1*4
  s1*8  \break
}

altoSax = \transpose ces c \relative c'' {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  \partial 4.
  r4.
  a4. bes8~ bes4. c8~ | c4. d8~ d4. ces8~ | ces2~ ces4. g8 | r1 |
  r1 | r | c8 ces c4 bes8 a4 c8 | r4 a'\fall a\fall r4
  r1 | r | c,8 ces c4 bes8 a4 c8 | r4 a'\fall a\fall r4
  g,4. ges8~ ges4. g8~ | g4. ges8~ ges4. g8~ | g4. ges8~ ges4. g8~ | g4. ges8~ ges4. g8~ |
  g1~ | g2. r8 g8~ | g1~ | g2 r
  a4^"first time only"( as g e | a as g e) | r4 a'^"play always"\fall a\fall r4 | r4 r8 a\fall r2 |
  r1 | %TODO: background
  r2 r4 r8 f,~ | f4 g bes8 c r d\fall | r1 |
  r4 r8 bes~ bes4 r | r4 r8 bes~ bes4 r | e,2 ges | g4. a8 r2 |
  r2 \tuplet 3/2 {r8 g as} \tuplet 3/2 {a c d} | d4-- c8 as a4 r |
  r2 r8 ges'\fall r ges~ | ges4 c, a r |
  r8 ces,4.~ ces2 | r8 bes4. r8 bes4. | r4 d'8 d d4 d8 d8 | d4 r r2

  \repeat volta 2 {
    \cross
    r4^"hand clap" bes r bes \repeat unfold 7 {r4 bes r bes}
    \endCross
  }

  R1*6 % TODO: background
  \tuplet 3/2 {r4 as' f} \tuplet 3/2 {es c as} | \tuplet 3/2 {f es ces} \tuplet 3/2 {bes as f} | r2 r4 r8 ces''8~ | ces2 \fermata r2

}

breaksAs = {
  \partial 4.
  s4.
  s1*4
  s1*16
  s1*16 \break
  s1*4
  s1*8  \break
}

% \book {
%   \score {
%     \midi { }
%     <<
%       \lyricsAbove \remarks
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
}
\book {
  \bookOutputSuffix "as"
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
