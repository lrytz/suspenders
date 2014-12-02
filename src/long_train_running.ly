#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "Long train runnin"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
  ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key g \minor
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 118

  s1*0^\markupBox "Intro"
  s1*4 \bar "||" % intro git
  s1*4 % intro horns

  s1*0^\markupBox "A"
  s1*12 % verse (repeated), horn background

  s1*0^\markupBox "B1"
  s1*12 % verse with breaks, horn background

  s1*0^\markupBox "Solo Sax"
  s1*12 % solo sax (open, repeated)

  s1*0^\markupBox "B2"
  s1*12 \bar "||" % verse with breaks, horn background, sax fills

  s1*0^\markupBox "C"
  s1*12 \bar "||" % verse with steps, fermata

  s1*0^\markupBox "Intro"
  s1*4 \bar "||" % intro git
  s1*8 % intro hornz (repeated)

  s1*0^\markupBox "D"
  s1*4 % horn kicks 2,4 (repeated)
  s1*4 % cadence (repeated)
  s1*4 % cadence, break

  s1*0^\markupBox "Solo Drums"
  s1*4 % solo perc, with git (repeated)

  s1*0^\markupBox "Horns vs Git"
  s1*14 \bar "||" % 3x 2-2 horn section vs. git

  s1*0^\markupBox "Ending"
  s1*10 \bar "|." % cadence with horn break


}

breaks = {
  s1*8 \break
  s1*12 \break %a
  s1*12 \break %b1
  s1*12 \break %sax
  s1*12 \break %b2
  s1*12 \break %c
  s1*12 \break %intro
  s1*4
  s1*4
  s1*4
  s1*4 \break %drum
  s1*4 %\break %horns git
  s1*4 %\break
  s1*4 %\break
  s1*2 \break
  s1*3 \break
}


remarks = \lyricmode {
}

theChords = \transpose c c \chordmode {
  s1*8 %intro
  s1*12 %a
  s1*12 %b
  g1:m s1*3 c1:m s1 g:m s1 es g2:m/d d g1:m s
}

altoChords = \transpose as es \theChords

trumpetChords = \transpose bes es \theChords

slTp = \relative c''' { bes4 bes bes bes }
slAs = \relative c'' { bes4 bes bes bes }

introTp = \relative c' {
  d2~ d8 r16 f g g f bes~ bes f g8~ g4~ g4 r8. f'16~
  f8 g-. d-- f-. c-- d-. bes-. r16 g~ g2
}
kickTp = \relative c'' { r8 d f16 g8 g16 }
cadenceTp = \relative c''' { g1 g2 fis g8 r r4 }

massive = \relative c'' {
  f16 g8 f16 r f d8 f g r16 g8 g16 r f d8 f g r16 g8 g16 r f d8
}

trumpet = \transpose bes es' \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  R1*4 \introTp r8 g'~ g16 g8.

  \repeat volta 2 {
    R1*6 r2 \kickTp r1
    \cadenceTp \kickTp r1
  }

  \repeat unfold 3 { g4 r r2 } R1*3 r2 \kickTp r1 \cadenceTp r2 r1
  \repeat volta 2 R1*12

  R1*6 r2 \kickTp r1
  \cadenceTp \kickTp r1

  \repeat unfold 3 {d4-. d-. d-. d8-. cis--} d4-. r r2 R1*2
  r2 \kickTp r1 g1 g2 fis es1~ es \fermata

  R1*4 \introTp r2 \introTp r8 g~ g16 g8.

  \repeat volta 2 { r4 g r2 r4 g r2 r4 g r2 r1 }
  \repeat volta 2 { \cadenceTp \kickTp r1 }
  g1 g2 fis g2. \fall r4 r1

  \repeat volta 2 R1*4

  d4 bes f16 g8 g16 r f d8 f g r16 g8 g16 r f d d f8 g d'4 \raise r r2 r1

  c16 des c bes r g8 d16 f g8 g f16 d8 f g r16 g8 g16 r f d d f8 g cis16 d cis d r4 r2
  r2 r4 bes16 bes a g
 
  a8 g r16 d8 f16 r g8 d16 g g d d f8 g r8 r16 g~ g g d d f8 g d'4 \raise  r r2
  r2 r4 r16 bes a g

  a g8 g16 r d8 d16 f8 g r16 d8 f16 r g8 r16 d'4 \fall r d16 f r8
  \massive bes4 \fall r r2

  g1 g2 fis

  \massive

  g1 g,,1 \glissando g''4 r r2
}

introAs = \relative c' {
  d2~ d8 r16 f g g f bes~ bes f g8~ g4~ g4 r8. c16~
  c8 d-. bes-- c-. g-- bes-. f-. r16 d~ d2
}
kickAs = \relative c'' { r8 bes bes16 d8 d16 }
cadenceAs = \relative c'' { es1 d2 c bes8 r r4 }

altoSax = \transpose es es \relative c' {
  \global
  \set Staff.instrumentName = #"Alto Sax"

  R1*4 \introAs r8 bes'~ bes16 bes8.

  \repeat volta 2 {
    R1*6 r2 \kickAs r1
    \cadenceAs \kickAs r1
  }

  \repeat unfold 3 { bes4 r r2 } R1*3 r2 \kickAs r1 \cadenceAs r2
  \slash s1*0^"pickup" \slAs \repeat volta 2 {\repeat unfold 12 \slAs} \endSlash

  R1*6 r2 \kickAs r1
  \cadenceAs \kickAs r1

  \repeat unfold 3 {g4-. g-. g-. g8-. fis--} g4-. r r2 R1*2
  r2 \kickAs r1 es'1 d2 c g1~ g \fermata

  R1*4 \introAs r2 \introAs r8 bes~ bes16 bes8.

  \repeat volta 2 { r4 bes r2 r4 bes r2 r4 bes r2 r1 }
  \repeat volta 2 { \cadenceAs \kickAs r1 }
  es1 d2 c bes2. \fall r4 r1

  \repeat volta 2 R1*4

  d4 bes f16 g8 g16 r f d8 f g r16 g8 g16 r f d d f8 g bes4 \raise r r2 r1

  c16 des c bes r g8 d16 f g8 g f16 d8 f g r16 g8 g16 r f d d f8 g a16 bes a bes r4 r2
  r2 r4 bes16 bes a g
 
  a8 g r16 d8 f16 r g8 d16 g g d d f8 g r8 r16 g~ g g d d f8 g bes4 \raise  r r2
  r2 r4 r16 bes a g

  a g8 g16 r d8 d16 f8 g r16 d8 f16 r g8 r16 bes4 \fall r d16 f r8
  \massive g4 \fall r r2

  es1 d2 c

  \massive

  es1 bes,1 \glissando bes''4 r r2
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
