#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "Trybguet"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #4 %space after title
  ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key bes \major
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 144
  s1*8^\markupBox "Intro"
  s1*8^\markupBox "Verse"
  s1*8^\markupBox "Interlude"
  s1*8^\markupBox "Verse" \break
  s1*8^\markupBox "Chorus" s1*2 \bar "||" \break
  s1*8^\markupBox "Interlude"
  s1*8^\markupBox "Bridge"
  s1*8^\markupBox "Verse" \break
  s1*8^\markupBox "Chorus" \break
  s1*8^\markupBox "Horns & Git" \break
  s1*8^\markupBox "Horns" \break
  s1*9^\markupBox "Ending" \bar "|."
}

remarks = \lyricmode {
}

% theChords = \chordmode { ges1 ces ges des ges ces ges2 ces2:6 ges1 }

altoChords = {} % \transpose es a { s1*32 \theChords }

trumpetChords = {} % \transpose bes a { s1*32  \theChords }

chorusTpA = \relative c' {
  bes'1 a2. f4 | g1~ | g4 r g a |
}

chorusTpBa = \relative c' {
  bes' r bes8 c d bes | c4 f~ f2 |
}

chorusTpBb = \relative c' {
  r4 c'8 bes c d r bes~ | bes4 bes8 a bes c r4 |
}



chorusAsA = \relative c' {
  f1 c2. c4 | es1~ | es4 r es f |
}

chorusAsBa = \relative c' {
  f r f8 g bes f | f4 a~ a2 |
}

chorusAsBb = \relative c' {
  r4 es8 d es g r es~ | es4 es8 d es f r4 |
}

trumpet = \transpose bes c' \relative c' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  \repeat volta 2 R1*8
  \repeat volta 2 R1*8
  R1*8
  \repeat volta 2 R1*8

  \repeat volta 2 { \chorusTpA \chorusTpBa }
  \alternative {
    \chorusTpBb
    { r4 c'8 bes c d r4 | bes r r2 }
  }

  R1*8 % interlude
  R1*8 % bridge
  R1*8 % verse
  \repeat volta 2 { \chorusTpA \chorusTpBa \chorusTpBb }
  \repeat volta 2 { \chorusTpA \chorusTpA }
  \repeat volta 2 { \chorusTpBa \chorusTpBb \chorusTpA  }
  bes1~ bes~ bes~ bes R1*5
}


altoSax = \transpose es c' \relative c' {
  \global
  \set Staff.instrumentName = #"Alto Sax"

  \repeat volta 2 R1*8
  \repeat volta 2 R1*8
  R1*8
  \repeat volta 2 R1*8

  \repeat volta 2 { \chorusAsA \chorusAsBa }
  \alternative {
    \chorusAsBb
    { r4 es8 d es g r4 | es r r2 }
  }

  R1*8 % interlude
  R1*8 % bridge
  R1*8 % verse
  \repeat volta 2 { \chorusAsA \chorusAsBa \chorusAsBb }
  \repeat volta 2 { \chorusAsA \chorusAsA }
  \repeat volta 2 { \chorusAsBa \chorusAsBb \chorusAsA  }
  f1~ f~ f~ f R1*5

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
        \tenorSax
      >>
    >>
  }
}
