#(ly:set-option 'relative-includes #t)
\include "lib.ly"

\header {
  title = "Joshua fit the Battle"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
}

global = {
  \time 4/4
  \key f \minor
  \clef "violin"
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

% A A B B
% A A B (tp)
% A A B (tb)
% A A ... Coda

structure = {
  \tempo 4 = 182
  \leftMark \markupBox "Intro Guitar"
  s1*8 % guitar
  
  \leftMark \markup {\box {\fontsize #5 A} \box{"Thema Sax"} }
  s1*8
  \mark \markup \box \fontsize #5 B
  s1*8

  \leftMark \markup {\box {\fontsize #5 A} \box{"1. Play Notes, 2. Solo Tutti"} }
  s1*8 \bar "||" s1*8 \bar "||"
  \mark \markup \box \fontsize #5 B
  s1*8

  \leftMark \markup { \musicglyph #"scripts.segno" \box {\fontsize #5 A} \box{"Solo Tutti"} }
  s1*8 \bar "||" s1*7 \pCoda s1
  \mark \markup \box \fontsize #5 B
  s1*8 \rightBreakMark \markupBox "D.S. al Coda"

  % \mark \markup \box \fontsize #6 A
  % s1*8 % A
  % \bar "||"
  % s1*7 \pCoda s1 % A
  % \bar "||"
  % \mark \markup \box \fontsize #6 B
  % s1*8 % B
  % \bar "||"
  % s1*8 % B

  s1*0^\markup { \right-align \fontsize #4 \musicglyph #"scripts.coda" }
  s1*4 % end
  \bar "|."
}

remarks = \lyricmode {
  % \skip 1*8
  % \skip 8
  % \markup \box \fontsize #2 \column {
  %   \line {"1. Thema Sax, 2. Thema tutti"}
  %   \line {"3. Solo tutti, 4. Solo tutti over A (on cue Coda)"}
  % } 2..
  % \skip 1*7
  % \skip 1*8
  % \skip 8
  % \markup \box \fontsize #2 "1. Sax, 2. Trumpet, 3. Tutti, 4... repeat A (don't play B)" 2..
  % \skip 1*7
  % \rightBreakMark \markup { \box {\fontsize #3 "1 continue, 2./3. to A"}↓}
}

chorusA = \chordmode {
  f1:m s c:7 f:m
  f:m s c:7 f:m
}

chorusB = \chordmode {
  f1:m c:7 f:m c:7
  f:m bes:m7 c:7 f:m
}

chorusChords = \chordmode {
  \chorusA
  \chorusA
  \chorusB
  \chorusB
}

theChords = \chordmode {
  s1*8 s1*16
  \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  \chorusA
  \chorusA
  \chorusB
  \chorusA
  \chorusA
  \chorusB
  \unset Score.proportionalNotationDuration
}
trumpetChords = \transpose bes c \theChords
altoChords = \transpose es c \theChords

slTp = \relative c''' { as4 }
slAs = \relative c''' { a4 }
slbTp = \repeat unfold 4 \slTp
slbAs = \repeat unfold 4 \slAs

melodyA = \relative c''' {
  f,8 f g4 as bes | c8 as4 c8~ c4 r | bes8 g4 bes8~ bes4 r | c8 as4 c8~ c4 r |
  f,8 f g4 as bes | c8 as4 c8~ c4 des8 des | c4 bes as8 g4 f8~ | f2
}

secondA = \relative c''' {
  d,8 d e e f f g g | as f4 as8~ as4 r | g8 e4 g8~ g4 r | as8 f4 as8~ as4 r |
  d,8 d e e f f g g | as f4 as8~ as4 bes8 bes | as as g g f4 e8 d~ | d2
}

melodyB = \relative c''' {
  f2 c8 as4 c8~ | c2 r4 c | f2 c8 as4 c8~ | c2 r4 c |
  f2 c8 as4 c8~ | c2 c4 des | c8 c bes4 as g8 f~ | f2
}

trumpet = \transpose bes c \relative c''' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  R1*8
  \repeat volta 2 R1*8 \repeat volta 2 R1*8
  \repeat volta 2 {
    \secondA r2
    \secondA r4 c
    \melodyB r2
  }
  \pageBreak
  \repeat volta 2 {
    \secondA r2
    \secondA r4 c
  }
  R1*8
  % \repeat volta 8 {
  %   \secondA r2
  %   \secondA r4 c
  %   \melodyB r4 c
  %   \melodyB r2
  % }
  d,4 r des'2^"rit." | c bes | as g | f2\fermata r
}


breaksTp = {
  s1*8
  s1*16 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
}

altoSax = \transpose es c \relative c''' {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  R1*8
  \repeat volta 2 {\melodyA r4^"2nd time" c} \repeat volta 2 {\melodyB r4^"1st time" c}
  \repeat volta 2 {
    \melodyA r2
    \melodyA r4 c
    R1*8
  }
  \pageBreak
  \repeat volta 2 {
    \melodyA r2
    \melodyA r2
  }
  R1*8
  f,4 r bes2^"rit." | as g | f e | d2\fermata r
}

breaksAs = {
  s1*8
  s1*16 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
}

% \book {
%   \score {
%     % \midi { }
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
    system-system-spacing #'basic-distance = #15 % increase space
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
  \paper {
    system-system-spacing #'basic-distance = #15 % increase space
  }
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

tenorSax = \transpose bes es \altoSax
tenorChords = \transpose bes es \altoChords
\book {
  \bookOutputSuffix "ts"
  \paper {
    system-system-spacing #'basic-distance = #15 % increase space
  }
  \score {
    <<
      \lyricsAbove \remarks
      \new ChordNames \tenorChords
      \new Staff = "tenorSax" <<
        \structure
        \breaksAs
        \tenorSax
      >>
    >>
  }
}
