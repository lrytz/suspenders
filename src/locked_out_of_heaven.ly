#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "Locked out of Heaven b"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #4 %space after title
  % ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key d \minor
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 2 = 144
  s1*8^"intro" % intor
  s1*8^"verse" % verse
  s1*8^"pre-chorus" \break % pre-chorus
  s1*8^"chorus" \rightBreakMark \markupBox "D.C." \break % chorus
  s1*8^"bridge" \break % bridge
  s1*8^"chorus (soft, then half time)" \break % chorus leise
  s1*8^"ending" \bar "|." % ending
}

remarks = \lyricmode { }

theChords = \chordmode { }

altoChords = {} % \transpose es c { s1*8 \theChords }

trumpetChords = {} % \transpose bes c { s1*8  \theChords }

lickTp = \relative c'' { f4. e8~ e4 a,4~ a1 | f'4. e8~ e4 g,4~ g1  }

lickAs = \relative c'' { c4. a8~ a4 c,4~ c1 | c'4. g8~ g4 c,4~ c1 }

trumpet = \transpose bes f \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  R1*8
  \repeat volta 2 { R1*8 }
  R1*8
  \repeat volta 2 { R1*4 \lickTp }
  \repeat volta 2 { R1*4 \lickTp }
  \repeat volta 2 { R1*4 \lickTp }
  R1*8
}


altoSax = \transpose es f \relative c'' {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  R1*8
  \repeat volta 2 { R1*8 }
  R1*8
  \repeat volta 2 { R1*4 \lickAs }
  \repeat volta 2 { R1*4 \lickAs }
  \repeat volta 2 { R1*4 \lickAs }
  R1*8
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
