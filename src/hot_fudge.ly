#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "Hot Fudge"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
  ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key cis \major
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 104

  s1*4 \bar "||" % intro piano

  \pSegno
  s1*4 % intro band

  s1*4 % verse, repeated

  s1*4 \bar "||" % pre-chorus

  s1*8 \bar "||" % chorus
  \rightBreakMark \markupBox "D.S."

  s1*4 % bridge

  \leftMark \markupBox "Solo Git"
  s1*4 % solo git, repeated
  s1*4 % solo git

  s1*3 \time 2/4 s2 \time 4/4 s1*2 % pre-chorus

  s1*8 % chorus, repeated
  s1*2 % endings

  s1*5 \bar "|." % ending
}

breaks = {
  s1*4
  s1*4 \break
  s1*4
  s1*4 \break
  s1*8 \break
  s1*4 \break
  s1*4
  s1*4 \break
  s1*6 \break
  s1*8 \break
}

remarks = \lyricmode {
}

theChords = \chordmode {
}

altoChords = \transpose es g \theChords

trumpetChords = \transpose bes g \theChords

slT = \absolute {a''4}
slS = \absolute {d''4}
slbT = \repeat unfold 4 \slT
slbS = \repeat unfold 4 \slS

chorusTp = \relative c'' {
  gis8-- ais4-. b8~ b2. r4
  r2 ais8-- b4-. cis8~ cis2. r4
  r2 gis8-- ais4-. b8~ b2. r4
  ais2 cis8-- cis4-. cis8~
}

chorusTpEnd = \relative c'' {
  cis2 gis16 ais cis8-. dis-- cis-.
}

trumpet = \transpose ais a \relative c' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  R1*4
  R1*2 cis'1~^\markup "1st time tacet (until D.S.)" cis2. r4
  \repeat volta 2 { R1*4 }
  r1 r2 r8 gis16 gis ais cis~ cis8 R1*2

  r2 \chorusTp \chorusTpEnd

  cis4-. r4 r4 r16 b8. | cis4-. r4 r4 r16 b'8. |
  cis4-. r4 r2 | r8 gis r gis r gis~ gis4 |

  \repeat volta 2 { cis4-.^\markup "1st time only" r4 r2 R1*3 }
  R1*4

  r1 r2 r8 gis,16 gis ais cis~ cis8 r1 \time 2/4 dis8. eis16~ eis8 fis~ \time 4/4 fis1~ fis1

  \repeat volta 3 {
    \parenthesize cis'4-.-\tweak self-alignment-X #-0.3 ^"1st"
    \leftMark \markupBox "3rd Solo Sax "
    r \chorusTp
  }
  \alternative {
    { \chorusTpEnd }
    { cis,2 eis8-- gis-. ais-- cis-. }
    { cis,2 eis8^∪ eis^∪ dis16 cis ais gis }
  }

  \repeat volta 2 { R1*4 } r1
}

chorusAs = \relative c' {
  eis8-- fis4-. gis8~ gis2. r4
  r2 fis8-- gis4-. ais8~ ais2. r4
  r2 eis8-- fis4-. gis8~ gis2. r4
  fis2 eis8-- eis4-. fis8~
}

chorusAsEnd = \relative c' {
  fis2 dis16 fis gis8-. ais-- gis-.
}

altoSax = \transpose dis a \relative c'' {
  \global
  \set Staff.instrumentName = #"Alto Sax"

  R1*4
  R1*2 gis2^\markup "1st time tacet (until D.S.)" (g fis gis4) r4
  \repeat volta 2 { R1*4 }
  r1 r2 r8 dis16 dis eis gis~ gis8 R1*2

  r2 \chorusAs \chorusAsEnd

  gis4-. r4 r4 r16 fis8. | gis4-. r4 r4 r16 fis'8. |
  gis4-. r4 r2 | r8 cis, r cis r cis~ cis4 |

  \repeat volta 2 { gis'4-.^\markup "1st time only" r4 r2 R1*3 }
  R1*4

  r1 r2 r8 dis,16 dis eis gis~ gis8 r1 \time 2/4 fis8. cis16~ cis8 dis~ \time 4/4 dis1~ dis1

  \repeat volta 3 {
    \parenthesize gis'4-.-\tweak self-alignment-X #-0.3 ^"1st"
    \leftMark \markupBox "3rd Solo Sax "
    r \chorusAs
  }
  \alternative {
    { \chorusAsEnd }
    { fis,2 cis'8-- dis-. eis-- gis-. }
    { fis,2 eis'8^∪ eis^∪ dis16 cis ais gis }
  }

  \repeat volta 2 { R1*4 } r1
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
    system-system-spacing #'basic-distance = #18 % increase space
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
  \bookOutputSuffix "bs"
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

tenorSax = \transpose bes, es, \altoSax
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
