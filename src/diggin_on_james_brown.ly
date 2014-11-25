#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "Diggin' on James Brown"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
  ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key c \major
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 132

  s1*4

  s1*14 \centerMark \markup { \center-column { \line { \box {"3rd to Coda"} } \line{"↓"} } }
  s1*2 \bar "||" % A
  s1*12 \rightBreakMark \markupBox "3x" % B

  s1*0^\markup \fontsize #4 { \musicglyph #"scripts.coda" }
  s1*4

  s1*10 %bridge
  s1*14 \bar "||"
  s1*12 \bar "||"
  s1*4

  s1*4 s1

  s1*4
  s1*6 \bar "|."
}

breaks = {
  s1*4 \break
  s1*16 \break
  s1*12 \break
  s1*4
  s1*10 \break
  s1*14
  s1*12 \break
  s1*4 \break
  s1*4 \break
}

remarks = \lyricmode {
}

theChords = \chordmode {
  s1*4
  s1*14
  s1*2
  s1*12
  s1*4
  f1:7 s1*5 g:7
}

altoChords = \transpose es g \theChords

trumpetChords = \transpose bes g \theChords

slT = \absolute {a''4}
slS = \absolute {d''4}
slbT = \repeat unfold 4 \slT
slbS = \repeat unfold 4 \slS

introRiffTp = \relative c'' { \repeat unfold 2 { c'8 bes4 g8~ g8 f4 r8 } }
introEndTp = \relative c'' { c'8 bes4 g8~ g8 f4 bes8~ | bes4 bes r2 }

kicksDropTp = \relative c'' { c8 r r c r4 r8 es~ | es4 d8 des c4 }

laufTpA = \relative c'' { r8 c16 es f es f es16~ es16 f16 r8 }
laufTpBOpen = \relative c'' { r8 c16 es f es f8 r2 }
laufTpBClosed = \relative c'' { r8 c16 es f es f es r2 }

trumpet = \transpose bes g \relative c' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  \introRiffTp \introEndTp

  \repeat volta 3 {
    \repeat unfold 4 { c'8 r r c r2 | r1 }
    f8 r r f r2 | r1 | c8 r r c r2 | r1 |
    g'8 r r g r4 r8 g | r1
    \introEndTp

    \repeat unfold 2 { c,8 r r c r2 | r1 }
    f8 r r f r2 | r1 | c8 r r c r2 | r1 |
    r4 g' f8 fis4 g8 | r1
    \introEndTp
  }

  c8 bes4 g8~ g8 f4 es8 | r4 bes'~ bes2 | r1 | r4 es,4 r2 |

  \repeat volta 2 { 
    s1*0^\markup { \left-column {\line{"1st time only"} \line{"2nd solo sax"} } }
    \repeat unfold 3 { r4 f es8 e4 f8 | r1 }
    g4^\markup "play" g r2 | r1
  }
  \alternative { { \introEndTp } { c,8 r r c r2 } } r1
  c8 r r c r2 | r1 |
  f8 r r f r2 | r1 | c8 r r c r2 | r1 |
  r4 g' f8 fis4 g8 | r1

  \introRiffTp \introEndTp

  \kicksDropTp r4 \kicksDropTp r4 \kicksDropTp r4 \kicksDropTp c
  \kicksDropTp r4 \kicksDropTp c

  \laufTpA r4 \laufTpBClosed \laufTpA r4 \laufTpBOpen
  \repeat volta 3 { \laufTpA r8 g \laufTpBClosed \laufTpA r8 g }
  \alternative { { \laufTpBOpen } { r1 } }

  r4 g f8 fis4 g8 | r1 
  \repeat volta 2 { c8 bes4 g8~ g8 f4 bes8 | r1 | r4 g f8 fis4 g8 | r1 }

  \introRiffTp c8 bes4 g8~ g8 f4 c'8~ | c4 c r2
}


introRiffBs = \relative c' { \repeat unfold 2 { c'8 bes4 g8~ g8 f4 r8 } }
introEndBs = \relative c' { c'8 bes4 g8~ g8 f4 f8~ | f4 f r2 }

kicksBs = \relative c'' { g8 c, r g' c, r }
chromaticBs = \relative c'' { g8 r g4 f8 fis4 g8 }

kicksChromaticBs = \relative c'' { g8 c, r g' c, r r8 bes'~ bes4 a8 as g4 }

laufBsA = \relative c'' { c,8 g'16 bes c bes c bes~ bes c }
laufBsBClosed = \relative c'' { r8 g16 bes c bes c bes r4 }
laufBsBOpen = \relative c'' { r8 g16 bes c bes c8 }

altoSax = \transpose es g \relative c'' {
  \global
  \set Staff.instrumentName = #"Baritone Sax"

  \introRiffBs \introEndBs

  \repeat unfold 4 { \kicksBs r4 r1 }
  \transpose c f { \kicksBs r4 r1 }
  \kicksBs r4 r1
  \transpose c g { \kicksBs r8 c' r1 }

  \introEndBs

  \repeat unfold 2 { \kicksBs r4 r1 }
  \transpose c f { \kicksBs r4 r1 }
  \kicksBs r4 r2 r4 r8 fis,
  \chromaticBs r8 g r4 r2 \introEndBs

  c8 bes4 g8~ g8 f4 es8 | r4 f~ f2 | r1 | r4 bes,4 r4 r8 e |

  \repeat volta 2 {
    s1*0^\markup { \left-column {\line{"1st time only"} \line{"2nd solo sax"} } }
    \repeat unfold 2 { \transpose g f \chromaticBs r2 r4 r8 e }
    \transpose g f \chromaticBs r1 d'4^\markup "play" d r2 r1
  }
  \alternative { {\introEndBs} {\kicksBs r4} } r1
  \kicksBs r4 r1 \transpose c f \kicksBs r4 r1 \kicksBs r4 r2 r4 r8 fis, \chromaticBs r1
  \introRiffBs \introEndBs

  \repeat unfold 2 { \kicksChromaticBs r4 }
  \repeat unfold 2 { \kicksChromaticBs r4 \kicksChromaticBs g'4 }

  \laufBsA r8 r8 c,,
  \laufBsBClosed bes8 b
  \laufBsA r8 r8 c
  \laufBsBOpen \tuplet 3/2 { r4 bes b }
  \repeat volta 3 {
    \laufBsA r8 r8 c
    \laufBsBClosed bes8 b
    \laufBsA r8 r8 c
  }
  \alternative {
    {\laufBsBOpen \tuplet 3/2 { r4 bes b }}
    {r2 r4 r8 fis'}
  }
  \chromaticBs r8 g r4 r2 | 
  \repeat volta 2 {
    c8 bes4 g8~ g8 f4 f8 | r2 r4 r8 fis
    \chromaticBs r8 g r4 r2
  }
  \introRiffBs c8 bes4 g8~ g8 f4 g,8~ | g4 g4 r2 |
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
