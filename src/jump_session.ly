#(ly:set-option 'relative-includes #t)
\version "2.18.0"
\include "lib.ly"

\header {
  title = "Jump Session"
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
  \tempo 4 = 166
  s1*4 % intro
  s1*8 % A
  \bar "||"
  s1*8 % A
  \bar "||"
  s1*8 % B
  \bar "||"
  s1*8 % A
}

remarks = \lyricmode {
  \skip 1*4
  \markupBox "Tacet (Thema) - Open Soli" 1
  \skip 1*7
  \skip 1*8
  \skip 1*8
  \markupBox "Last Time Tacet (Thema)"

}

fChords = \chordmode {
  f2:6 d:m7 g:m7 c:7 f:6 d:m7 g:m7 c:7
  f2:6 d:m7 bes bes:m6 f:/c b:dim bes4 bes:m6
}

asChords = \chordmode {
  as2:6 f:m7 bes:m7 es:7 as:6 f:m7 bes:m7 es:7
  as:6 f:m7 bes:m7 es:7 as1:6 g2:m7 c:7
}

theChords = \chordmode {
  s1*4
  \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  \fChords f2:6
  \fChords f4:6 es:7
  \asChords
  \fChords f2:6
  \unset Score.proportionalNotationDuration
}

trumpetChords = \transpose c c \theChords
altoChords = \transpose f c \theChords

slTp = \relative c'' { bes4 }
slAs = \relative c'' { e4 }
slbTp = \repeat unfold 4 \slTp
slbAs = \repeat unfold 4 \slAs

trumpet = \transpose c c \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  R1*4
  \repeat volta 3 {
    \slash
    \repeat unfold 32 \slbTp
    \endSlash
  }
}

breaks = {
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4
}

altoSax = \transpose f c \relative c'' {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  R1*4
  \repeat volta 3 {
    \slash
    \repeat unfold 32 \slbAs
    \endSlash
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
        \breaks
        \tenorSax
      >>
    >>
  }
}
