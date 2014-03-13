#(ly:set-option 'relative-includes #t)
\include "lib.ly"

\header {
  title = "Just a Gigolo"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
}

global = {
  \time 4/4
  \key g \major
  \clef "violin"
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 138
  \partial 8 s8
  s1*16
  s1*16
  s1^"rit."
  s1*3
}

remarks = \lyricmode {
  \skip 8
  \skip 1*16
  \markupBox "1. Fills as (Thema), 2. Solo tp, Fills as (long notes)"
}

chorusChords = \chordmode {
  g1:6 g:maj7 g2:6 bes:dim a:m7 d:7
  a1:m a:m7 d:7 g:6
  g:7 f:7 e:7 a:m
  a2:m7 c:m6 g:6 a:7 a:m7 d:7 g:6 d:7sus4
}

codaChords = \chordmode {
  a2:m7 c:m6 g:6 a:7 a:m7 d:7 g:6
}

theChords = {
  \partial 8 s8
  \chorusChords
  \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  \chorusChords
  \codaChords
  \unset Score.proportionalNotationDuration
}

trumpetChords = \transpose bes c \theChords
altoChords = \transpose es c \theChords

slTp = \relative c''' { a4 }
slAs = \relative c'' { d4 }
slbTp = \repeat unfold 4 \slTp
slbAs = \repeat unfold 4 \slAs

trumpet = \transpose bes c \relative c''' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  \partial 8 d,8
  b' b b b b4. g8 | a a a a a4. r8 | g8 g fis g a4. fis8 | e d4.~ d4 r8 d8 |
  a' a a a a4. e8 | g g \tuplet 3/2 {g a g~} g4. r8 | \tuplet 3/2 {fis4 f fis} a4. fis8 | e d4.~ d4 r8 d8 |
  d' d d d d4. d8 | c c \tuplet 3/2 {c d c~} c4. r8 | b b bes b d4. c8 | b a4. r4 a8 b |
  c c b a c4 g8 a | b b \tuplet 3/2 {a g b~} b2 | r8 c b c d4 b | a8 g4.~ g4 r |

  \repeat volta 2 {
    \slash
    \repeat unfold 14 \slbTp
    \endSlash
    r8^"last time (end of solo)" c b c d4 b | a8 g4. r4 a8 b |
  }
  c c \tuplet 3/2 {b a c~} c4\fermata^"fill" g8 a | b b \tuplet 3/2 {a g b~} b4\fermata^"fill" r4 | r2^"cadenza" d4\fermata r4^"cad." | g2\fermata r2 |
}


breaksTp = {
  \partial 8
  s8
  s1*16 \break
  s1*16 \break
}

altoSax = \transpose es c \relative c''' {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  \partial 8 r8
  g1 | fis | b2 bes | a2. r4 |
  c1 | a | a2 c | b2. r4 |
  b1 | a | as2 b | c2. r4 |
  e,8 e e e es4 c8 dis | d d \tuplet 3/2 {d d cis~} cis2 | r8 e e e fis4 c | b8 b4.~ b4 r

  \repeat volta 2 {
    \slash
    \repeat unfold 16 \slbAs
    \endSlash
  }
  
  e2 dis4\fermata r | d2 cis4\fermata r | r2 fis4\fermata r | e2\fermata r | 
}

breaksAs = {
  \partial 8
  s8
  s1*16 \break
  s1*16 \break
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
    system-system-spacing #'basic-distance = #16 % increase space
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
        \breaksTp
        \trumpet
      >>
    >>
  }
}
\book {
  \bookOutputSuffix "as"
  \paper {
    system-system-spacing #'basic-distance = #16 % increase space
  }
  \score {
    <<
      \lyricsAbove \remarks
      \new ChordNames \altoChords
      \new Staff = "altoSax" <<
        \structure
        \breaksAs
        \altoSax
      >>
    >>
  }
}
