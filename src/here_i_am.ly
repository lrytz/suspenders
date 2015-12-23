#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "Here I Am"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
  ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key fis \minor
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 94

  s1*0^\markupBox "Intro"
  s1*2

  \repeat volta 2 {
    s1*0^\markupBox "A"
    s1*8
    s1*0^\markupBox "B"
    s1*8
    s1*0^\markupBox "C"
    s1*7 \time 2/4 s2 \time 4/4
    s1*2
  }

  s1*0^\markupBox "D1"
  \repeat volta 2 { s1*8 }

  s1*0^\markupBox "D2"
  \repeat volta 2 { s1*8 }

  s1*0^\markupBox "Ending (open)"
  \repeat volta 2 { s1*8 }
}

breaks = {
  s1*2 \break
  s1*8 \break
  s1*8 \break
  s1*7 s2 s1*2 \break
  s1*8 \break
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

trumpet = \transpose bes beses \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  fis2 e8 e4 fis8~ | fis2 r

  \repeat volta 2 {
    R1*8
    fis,8 a b cis b a fis4~ | fis2 r | b2~ b4~ b8 fis~ | fis2 r
    fis8 a b cis b a fis4~ | fis2 r | b2. r4 | r8 fis' r fis r fis r4

    \repeat unfold 3 { r4 cis16 cis d d e8 e r4 | r1 } r4 cis16 cis d d e8 e r4 | r4 r8 fis,~ |
    fis1~ fis1
  }

  \repeat volta 2 {
    R1*4
    a1 | b2. r4 | fis'2 e8 e4 fis8~ | fis2 r
  }

  \repeat volta 2 {
    R1*2 | b,2 a | b8-- a-. fis-. a~ a b r4 | R1*2 | fis'2 e8 e4 fis8~ | fis2 r
  }

  \repeat volta 2 {
    \repeat unfold 4 { r4 cis16 cis d d e8 e r a | r1 }
  }
}

altoSax = \transpose es beses \relative c'' {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  a2 gis8 gis4 a8~ | a2 r

  R1*8
  cis,8 dis fis a fis dis cis4~ | cis2 r | fis2~ fis4~ fis8 cis~ | cis2 r
  cis8 dis fis a fis dis cis4~ | cis2 r | fis2. r4 | r8 cis' r cis r cis r4

  \repeat unfold 3 { r4 a16 a b b gis8 gis r4 | r1 } r4 a16 a b b gis8 gis r4 | r4 r8 cis,~ |
  cis1~ cis1

  \repeat volta 2 {
    R1*4
    dis1 | fis2. r4 | a2 gis8 gis4 a8~ | a2 r
  }

  \repeat volta 2 {
    R1*2 | dis,2 dis | dis8-- cis-. b-. cis~ cis dis r4 | R1*2 | a'2 gis8 gis4 a8~ | a2 r
  }

  \repeat volta 2 {
    \repeat unfold 4 { r4 a16 a b b gis8 gis r e' | r1 }
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
