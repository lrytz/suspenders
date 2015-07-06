#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "You Haven't Done Nothin'"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
  ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key es \major
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 104

  s1*0^\markupBox "Intro"
  \repeat volta 2 s1*4

  \repeat volta 2 {
    s1*0^\markupBox "A"
    \pSegno
    s1*8
    s1*0^\markupBox "B"
    s1*6 \rightBreakMark \markupBox "To Coda"
    s1*4
  }
  s1*4 \bar "||"
  \rightBreakMark \markupBox "D.S."

  s1*0^\markup { \right-align \fontsize #4 \musicglyph #"scripts.coda" }
  s1*4 \bar "|."
}

breaks = {
  s1*4 \break

  s1*14 \break
  s1*4 \break

  s1*4 \break
}

remarks = \lyricmode { 
}

theChrods = \chordmode {
}

altoChords = \transpose es es \theChrods

trumpetChords = \transpose bes bes \theChrods

slT = \absolute {a''4}
slS = \absolute {d''4}
slbT = \repeat unfold 4 \slT
slbS = \repeat unfold 4 \slS

tpLick = \relative c' {
  es8-- es-. g-- bes-. des4\fall c\fall r8 es,16 g~ g bes des8\fall r des16 des c8\fall
}

trumpet = \transpose bes g \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  R1*4

  es,8\fall^"Only 2nd/3rd time" r r4 r2
  R1*7
  s1*0^"Only 2nd/3rd time"
  as'2 as8 g ges f\fall r4 c8\fall r f\fall r c\fall r
  f\fall r c\fall r f\fall r c f\fall r4 d8\fall r f\fall r d\fall r
  es-- es-. d-- d-. des c ces bes~ | bes2 r16 des \tuplet 3/2 { a as ges } as ges8.
  s1*0^"Play always"
  \tpLick es16 es \tpLick r8

  \tpLick es16 es \tpLick r8

  \tpLick es16 es \tpLick r8
}

asLick = \relative c' {
  bes8-- bes-. des-- es-. ges4\fall f\fall r8 bes,16 des~ des es ges8\fall r ges16 ges f8\fall
}

altoSax = \transpose es g \relative c'' {
  \global
  \set Staff.instrumentName = #"Alto Sax"

  R1*4

  bes,8\fall^"Only 2nd/3rd time" r r4 r2
  R1*7
  s1*0^"Only 2nd/3rd time"
  es'2 es8 d des c\fall r4 a8\fall r c\fall r a\fall r
  c\fall r a\fall r c\fall r a bes\fall r4 f8\fall r bes\fall r f\fall r
  bes-- bes-. a-- a-. as g ges f~ | f2 r16 des' \tuplet 3/2 { a as ges } as ges8.
  s1*0^"Play always"
  \asLick bes,16 bes \asLick r8

  \asLick bes16 bes \asLick r8

  \asLick bes16 bes \asLick r8
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

tenorSax = \transpose bes es' \altoSax
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
