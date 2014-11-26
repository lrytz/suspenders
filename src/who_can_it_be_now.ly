#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "Who can it be now?"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
  ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key e \major
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 132

  s1*8 % intro

  \pSegno
  s1*8 % verse, repeated

  s1*8 \bar "||" % chorus
  \rightBreakMark \markupBox "D.S."

  s1*9 % bridge

  \leftMark \markupBox "Solo Sax"
  s1*8 % solo sax, repeated

  s1*8 % chorus

  s1*4 % tutti, 3x repeated
  s1*8 \bar "|." % end
}

breaks = {
  s1*8 \break
  s1*8 \break
  s1*8 \break
  s1*9 \break
  s1*8 \break
  s1*8 \break
}

remarks = \lyricmode {
}

theChords = \transpose c e \chordmode {
  \repeat unfold 2 {a1:m s g:6 s}
  \repeat unfold 2 {c1 bes a:m s2 s8 g4.}
  \repeat unfold 2 {a1:m s g:6 s}
  d1:m g d:m g d:m g d:m g s
  \repeat unfold 2 {c s bes s}
  \repeat unfold 2 {a:m s g:6 s}
  \repeat unfold 3 {g s f s}
}

altoChords = \transpose es as \theChords

trumpetChords = \transpose c c \theChords

slT = \absolute {a''4}
slS = \absolute {fis'4}
slbT = \repeat unfold 4 \slT
slbS = \repeat unfold 4 \slS

trumpet = \transpose c c \relative c' {
  \global
  \set Staff.instrumentName = #"Trumpet"
}

lickAs = \relative c' {
  cis8 gis' a( e')~ e4 a,8 gis
}

altoSax = \transpose es as \relative c' {
  \global
  \set Staff.instrumentName = #"Alto Sax"

  \repeat unfold 4 { \lickAs r1 }

  \repeat volta 2 { \repeat unfold 8 r1 }

  \repeat unfold 4 { r1 \lickAs }

  \repeat unfold 7 r1 b1~ b

  \repeat volta 2 { \slash \repeat unfold 8 \slbS \endSlash }

  \repeat unfold 4 { r1 \lickAs }

  \repeat volta 2 { r1 r1 \lickAs r1 }

  r1 r1 cis8 gis' a gis~ gis4 a8 gis~ gis4 r8 b a gis cis,4
  r1 r1 a'4. gis8~ gis4 cis,~ cis1 \fermata
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


% \book {
%   \bookOutputSuffix "tp"
%   \paper {
%     system-system-spacing #'basic-distance = #18 % increase space
%     % fit on one page
%     % system-system-spacing = #'(
%     %   (basic-distance . 10)
%     %   (minimum-distance . 0)
%     %   (padding . 0)
%     %   (stretchability . 0))
%   }
%   \score {
%     <<
%       \lyricsAbove \remarks
%       \new ChordNames \trumpetChords
%       \new Staff = "trumpet" <<
%         \structure
%         \breaks
%         \trumpet
%       >>
%     >>
%   }
% }
\book {
  \bookOutputSuffix "as"
  \paper {
    system-system-spacing #'basic-distance = #18 % increase space
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
    system-system-spacing #'basic-distance = #18
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
