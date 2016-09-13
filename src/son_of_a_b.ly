#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "Son of a B*"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
  ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key ges \major
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 116
  s1*4^\markupBox "3x"
  s1*4^\markupBox "4x"

  s1*8 \bar "||" % chorus

  s1*4
  s1*4^\markupBox "2x"

  s1*8 \bar "||" % chorus
  s1*8^\markupBox "Solo Tp" \bar "||"

  s1*4
  s1*4^\markupBox "4x"

  s1*8^\markupBox "2x" % chorus

  s1*8^\markupBox "Solo Git" \bar "||"

  s1*8 \bar "|."
}

breaks = {
  % s1*12 \break
}

remarks = \lyricmode {
}

theChords = \chordmode { ges1 ces ges des ges ces ges2 ces2:6 ges1 }

altoChords = \transpose es a { s1*32 \theChords }

trumpetChords = \transpose bes a { s1*32  \theChords }

chorusTp = \relative c' {
  r8 bes' r16 bes r8 bes2
  r8 ges r16 ges r8 ges2
  r8 bes r16 bes r8 bes2
  r8 as r16 as r8 as8. as16 r4
  r8 bes r16 bes r8 bes2
  r8 ges r16 ges r8 ges2
  bes2 as ges r
}

chorusAs = \relative c' {
  r8 ges' r16 ges r8 ges2
  r8 es r16 es r8 es2
  r8 ges r16 ges r8 ges2
  r8 f r16 f r8 f8. f16 r4
  r8 ges r16 ges r8 ges2
  r8 es r16 es r8 es2
  ges2 f des r
}

trumpet = \transpose bes a \relative c' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  \repeat volta 3 R1*4
  \repeat volta 4 R1*4

  \chorusTp

  \repeat volta 2 R1*4
  \repeat volta 2 R1*4

  \chorusTp

  R1*8 % solo tp

  \repeat volta 2 R1*4
  \repeat volta 4 R1*4

  \repeat volta 2 \chorusTp

  R1*8

  \chorusTp
}


altoSax = \transpose es a \relative c' {
  \global
  \set Staff.instrumentName = #"Baritone Sax"

  \repeat volta 3 R1*4
  \repeat volta 4 R1*4

  \chorusAs

  \repeat volta 2 R1*4
  \repeat volta 2 R1*4

  \chorusAs

  R1*8 % solo tp

  \repeat volta 2 R1*4
  \repeat volta 4 R1*4

  \repeat volta 2 \chorusAs

  R1*8 % solo git

  \chorusAs
}

% \book {
%   \score {
%     % \midi { }
%     <<
%       \lyricsAbove \remarks
%       \new ChordNames \trumpetChords
%       \new Staff = "trumpet" <<
%         \structure
%         \breaks
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
        \breaks
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
        \breaks
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
    system-system-spacing #'basic-distance = #15
  }
  \score {
    <<
      \lyricsAbove \remarks
      \new ChordNames \tenorChords
      \new Staff = "tenorSax" <<
        \structure
        \breaks
        \tenorSax
      >>
    >>
  }
}
