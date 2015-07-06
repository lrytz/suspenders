#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "What'd I Say"
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
  \tempo 4 = 204

  s1*0^\markupBox "Intro (2x)"
  \repeat volta 2 { s1*12 }

  s1*0^\markupBox "Voc (3x)"
  \repeat volta 3 { s1*12 }

  s1*0^\markupBox "Instrumental (1x)"
  s1*12

  s1*0^\markupBox "Voc (2x)"
  \repeat volta 3 { s1*12 }

  s1*0^\markupBox "With Horns (2x)"
  \repeat volta 2 { s1*12 }

  s1*0^\markupBox "Voc ''ooh'' (3x)"
  \repeat volta 3 {
    s1*8 \bar "||"
    s1*12
  }

  s1*0^\markupBox "Ending (2x)"
  \repeat volta 2 {
    s1*12
  }
}

breaks = {
  s1*48 \break
  s1*12 \break
  s1*8 s1*12 \break
}

remarks = \lyricmode {
}

theChrods = \chordmode {
  % s1*52
  % c1 e:m f d2:m g:7
}

altoChords = \transpose es es \theChrods

trumpetChords = \transpose bes bes \theChrods

slT = \absolute {a''4}
slS = \absolute {d''4}
slbT = \repeat unfold 4 \slT
slbS = \repeat unfold 4 \slS

tpVoice = \relative c'' {
  gis2 gis8 gis r4 | gis4 r8 gis r2 | gis2 gis8 gis r4 | gis4 r8 gis r2
  g2 g8 g r4 | g4 r8 g r2           | gis2 gis8 gis r4 | gis4 r8 gis r2
  a2 a8 a r4 | g4 r8 g r2           | gis2 gis8 gis r4 | gis4 r r2
}

trumpet = \transpose bes as \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  R1*12
  R1*12
  R1*12
  R1*12

  \repeat volta 2 \tpVoice
  \repeat volta 3 { R1*8 \tpVoice }
  \repeat volta 2 { \tpVoice }
}

asVoice = \relative c' {
  d2 d8 d r4 | d4 r8 d r2 | d2 d8 d r4 | d4 r8 d r2
  cis2 cis8 cis r4 | cis4 r8 cis r2 | d2 d8 d r4 | d4 r8 d r2
  dis2 dis8 dis r4 | cis4 r8 cis r2 | d2 d8 d r4 | d4 r r2
}

altoSax = \transpose es as \relative c' {
  \global
  \set Staff.instrumentName = #"Alto Sax"

  R1*12
  R1*12
  R1*12
  R1*12

  \repeat volta 2 \asVoice

  \repeat volta 3 { R1*8 \asVoice }

  \repeat volta 2 { \asVoice }
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
