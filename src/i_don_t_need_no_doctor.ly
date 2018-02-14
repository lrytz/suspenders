#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "I don't need no doctor"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #4 %space after title
  % ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key e \major
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 85
  s1*8^\markupBox "Intro" \bar "||" \break
  s1*4^\markupBox "A" \break s1*4 \break s1*3 s1 \rightBreakMark \markup { \box { \right-column {
    "1 cont, 2/3 to A, 4 to B"
    "after Solos: 1x A (voc), then to C"
  } } } \bar "||" \break
  s1^"First time only!" s1 \rightBreakMark \markupBox "to A" \bar "||" \break
  
  s1*6^\markupBox "B" s1^"Pickup Solo" s1 \rightBreakMark \markupBox "to A" \bar "||" \break

  s1*5^\markupBox "C" \bar "|."
}

remarks = \lyricmode {
}

theChords = \chordmode {
  e2:7 g4 a e2:7 g4 a e2:7 g4 a e2:7 g4 a
  cis2:7.11+ d:7 c:6 g4/a a/b e2:7 g4 a e2:7 g4 a
  a1/b g2/a f4/g g/a e2:7 g4 a e2:7 g4 a
  e2:7 g4 a e2:7 g4 a
  s1*6
  cis2:7.11+ d:7 c:6 g4/a a/b
  e2:7 g4 a e2:7 g4 a e2:7 g4 a e2:7 g4 a
 }

altoChords = \transpose es as { s1*8 \theChords }

trumpetChords = \transpose bes as { s1*8  \theChords }

trumpet = \transpose bes as, \relative c''' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  R1*8
  R1*12
  R1*2

  R1*8

  \repeat volta 2 {
    r2 d4^"on cue" e4 \repeat unfold 3 { r2 d4 e4 }
  } e1\fermata
}


altoSax = \transpose es as, \relative c''' {
  \global
  \set Staff.instrumentName = #"Alto Sax"

  R1*8
  R1*12
  R1*2

  R1*8

  \repeat volta 2 {
    r2 g4^"on cue" a4 \repeat unfold 3 { r2 g4 a4 }
  } b1\fermata
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
    system-system-spacing #'basic-distance = #20 % increase space
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
        \trumpet
      >>
    >>
  }
}
\book {
  \bookOutputSuffix "as"
  \paper {
    system-system-spacing #'basic-distance = #20 % increase space
  }
  \score {
    <<
      \lyricsAbove \remarks
      \new ChordNames \altoChords
      \new Staff = "altoSax" <<
        \structure
        \altoSax
      >>
    >>
  }
}

tenorSax = \transpose bes, es \altoSax
tenorChords = \transpose bes es \altoChords
\book {
  \bookOutputSuffix "ts"
  \paper {
    system-system-spacing #'basic-distance = #20
  }
  \score {
    <<
      \lyricsAbove \remarks
      \new ChordNames \tenorChords
      \new Staff = "tenorSax" <<
        \structure
        \tenorSax
      >>
    >>
  }
}
