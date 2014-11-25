#(ly:set-option 'relative-includes #t)
\version "2.18.0"
\include "lib.ly"

\header {
  title = "Hit the Road, Jack"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
  ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key as \minor
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 172
  s1*4  % intro
  \pSegno
  s1*16 % 2x thema, 3rd time to coda
  \pCoda
  s1*8  % verse
  s1*4  % extended verse, then back
  \rightBreakMark \markupBox "D.S. al Coda"
  s1*0^\markup {
    \fontsize #4
    \right-align
    \musicglyph #"scripts.coda"
  }
  s1*4  % repeat ad lib, fade out
  \rightMark "Repeat ad lib, fade out"

}

remarks = \lyricmode {
}

chorusChords = \chordmode {

}

theChords = {
  s1*8
  % \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  % \chorusChords
  % \unset Score.proportionalNotationDuration
}

trumpetChords = \transpose es c \theChords
altoChords = \transpose as c \theChords

slTp = \relative c'' { e4 }
slAs = \relative c''' { a4 }
slbTp = \repeat unfold 4 \slTp
slbAs = \repeat unfold 4 \slAs

kickTp = \relative c''' {r2 r8 as r4}
abstiegTp = \relative c'' {as2 ges | fes es}

trumpet = \transpose es c \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  \abstiegTp | as ges | fes es4^^ r |
%  es,2 des | ces bes | es des | ces bes4 r |

  \repeat volta 2 {
    \kickTp R1*3
    \kickTp r1 \abstiegTp
    \kickTp R1*3
    \kickTp r1 \abstiegTp
    R1*5
    r4 r8 es'8^\markup \center-align "1st time only" r2 | R1*2
  }
  r1 r4 r8 es8 r2 | R1*2
  \repeat volta 16 {
    \abstiegTp \abstiegTp
  }
}

breaks = {
  s1*10 \break
  s1*11 \break
  s1*11 \break
}

kickSax = \relative c'' {r2 r8 es r4}
abstiegSax = \relative c''' {as2 ges | fes}

altoSax = \transpose as c \relative c'' {
  \global
  \set Staff.instrumentName = #"Baritone Sax"
  \abstiegSax es2 | \abstiegSax es4^^ r |

  \repeat volta 2 {
    \kickSax R1*3
    \kickSax r1 \abstiegSax es2
    \kickSax R1*3
    \kickSax r1 \abstiegSax es4-- g,--
    as-. r r2 | R1*4
    r4 r8 g'8^\markup \center-align "1st time only" r2 | R1*2
  }
  r1 r4 r8 g8 r2 | R1*2
  \repeat volta 16 {
    \abstiegSax es2 \abstiegSax es2
  }
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
