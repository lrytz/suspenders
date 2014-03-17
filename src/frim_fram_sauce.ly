#(ly:set-option 'relative-includes #t)
\include "lib.ly"

\header {
  title = "Frim Fram Sauce"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
}

global = {
  \time 4/4
  \key as \major
  \clef "violin"
  \set Score.skipBars = ##t % combine multi-rests
}

structure = {
  \tempo 4 = 106
  s1*4 % intro
  \pSegno
  s1*9 % A
  s1*8 % B
  \bar "||"
  s1*7 \pCoda % A
  s1 \rightBreakMark "D.S."
  s1*0^\markup { \right-align \fontsize #4 \musicglyph #"scripts.coda" }
  s1*1
  \bar "||"
  s1*4 % intro
  \bar "||"
  s1*10 % solo tp, end

}

remarks = \lyricmode {
  \skip 1*34
  \markupBox "Solo tp"
}

chorusChords = \chordmode {
  as1:6 s bes:7 s
  des2 d:dim as:/es f:7 bes:m es:7 as bes4:7 es:7 as2 as:7
  es2:m7 as:7 es:m7 as:7 des as:5+7 des1:6
  bes:7 es2:maj7 c:7 f:m7 bes:7 bes:m7 es:7
  as1:6 s bes:7 s
  des2 d:dim as:/es f:7 bes:m es:7 as4 es8:sus7 es:7 s2 as as:7
}

soloChords = \chordmode {
  des2 as:/c bes:m des:/as g1:m7-5 es:7
  ges2 g:dim des:/as bes:7 es1:7 as:7
  des2 as:5+7 des1
}

theChords = {
  s1*4
  \chorusChords
  s1*4
  \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  \soloChords
  \unset Score.proportionalNotationDuration
}


trumpetChords = \transpose bes c \theChords
altoChords = \transpose es c \theChords

slTp = \relative c''' { as4 as as as }
slAs = \relative c'' { des4 des des des }

trumpet = \transpose bes c \relative c''' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  b8^"Cup Mute" as4 b8 r2 | b8 as4 b8 r2 | b8 c b c b c as\prall f | as4 as8 as r2 |
  \repeat volta 2 {
    r8 as r4 r8 as r4 | r8 as r4 r8 as \tuplet 3/2 {f es as~} | as4. bes8~ bes as bes4 | r8 f'~ f4 b,8 c8 f, as |
    r8 as r4 r8 as r4 | r8 as r4 r8 es' r8 des~| des4. des8 r2 
  }
  \alternative {
    { r8 as as as as4 g }
    { r8 b c4-- \tuplet 3/2 {e,8 f as} \tuplet 3/2 {c r as}}
  }
  % B
  r4 r8 c,~ c4 r8 des~ | des4 des8 c r2 | r1
  \tuplet 3/2 {e8 f as} \tuplet 3/2 {c r bes} as8 f es des | bes'4 r r2 | r4 \tuplet 3/2 {es,8 g bes} d8 c  g as~ | as4 r r g8 es | r1
  % A3
  r8 as r4 r8 as r4 | r8 as r4 r8 as \tuplet 3/2 {f es as~} | as4. bes8~ bes as bes4 | r8 f'~ f4 b,8 c8 f, as |
  r8 as r4 r8 as r4 | r8 as r4 r8 es' r8 des~| des4. des8 r4 des8 c |r4 c8 es r2 |
  r8 c~ c4 es8 as r4
  % intro
  b,8 as4 b8 r2 | b8 as4 b8 r2 | b8 c b c b c as\prall f | as4 as8 as r2 |
  \slash
  as4^"Open" as as as
  \repeat unfold 8 \slTp \undo \hide Stem as4 as8 as r2
  \endSlash
}

breaksTp = {
  s1*4 \break
  s1*9 \break
  s1*8 \break
  s1*8 \break
  s1*5 \break
  s1*4 \break
  s1*4 \break
}

altoSax = \transpose es c \relative c'' {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  d8 b4 d8 r2 | es8 c4 es8 r2 | d8 es d es d es b\prall as | des4 des8 c r2
  \repeat volta 2 {
    r8 c r4 r8 c r4 | r8 c r4 r8 c \tuplet 3/2 {as f d'~} | d4. es8~ es c es4 | r8 d8~ d4 d d |
    r8 des r4 r8 d r4 | r8 es r4 r8 a r8 as~ | as4. g8 r2
  }
  \alternative {
    { r8 d es es d4 des }
    { r8 as'~ as4 ges ges }
  }
  % B
  r4 r8 as~ as4 r8 ges~ | ges4 ges8 ges r2 | r8 c~ c4 e8 c bes as | c4 es8 des r2 |
  r8 f, r4 g4. f8 | r es r8 d r8 c r4 | r8 as r bes ~ bes4 r | r8 as f g r2
  % A3
  r8 c r4 r8 c r4 | r8 c r4 r8 c \tuplet 3/2 {as f d'~} | d4. es8~ es c es4 | r8 d8~ d4 d d |
  r8 des r4 r8 d r4 | r8 es r4 r8 a r8 as~ | as4. g8 r4 g8 as | r4 f8 g r2
  r8 as~ as4 bes8 c r4
  % intro
  d,8 b4 d8 r2 | es8 c4 es8 r2 | d8 es d es d es b\prall as | des4 des8 c r2
  \slash
  \repeat unfold 9 \slAs  \undo \hide Stem des8 des r2
  \endSlash
}

breaksAs = {
  s1*4 \break
  s1*9 \break
  s1*8 \break
  s1*8 \break
  s1*5 \break
  s1*4 \break
  s1*4 \break
}

% \book {
%   \score {
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
