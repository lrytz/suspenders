#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "Just a Gigolo"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #4 %space after title
  % ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key g \major
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 2 = 122
  s1*2 % intro
  s1*16 % verse
  s1*9 \bar "||" % chorus
  s1*8 \bar "||" % horns
  s1*8 % chorus
  s1*12^\markupBox "solo sax" \bar "||"
  s1*8^\markupBox "solo tp" \bar "||"
  s1*8 % tutti
  s1*9 \bar "||" % chorus
  s1*16 % horns
  s1*6 \bar "|."
}

remarks = \lyricmode { }

theChords = \chordmode {
  s1*2 s1*16 s1*9 s1*8 s1*8
  % sax
  g1:7 s e:7 s a:m7 d:7 g:6 s a:m7 s d:7 s
  % tp
  g:6 s c:6 s e:7 s a:m7 d:7
  % tutti
  g:7 s e:7 s a:m7 d:7 g:6
}

trumpetChords = \transpose bes c { \theChords }
altoChords = \transpose es c { \theChords }

lickTp = \relative c''' { }
lickAs = \relative c'' { }


trumpet = \transpose bes c \relative c''' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  R1*2
  \repeat volta 2 { R1*16 }
  \repeat volta 2 { R1*7 }
  \alternative {
    {R1}
    {r4 r8 g~ g4 e}
  }
  g, r8 g'~ g4 e | g, r8 g'~ g4 e | g, r8 g'~ g4 e | g, r8 g'~ g4 e | b r8 fis'~ fis4 e | b r8 fis'~ fis4 e | g r r2 R1
  R1*8
  \repeat volta 2 { R1*4 }
  \alternative {
    { R1*4 }
    { R1*4 }
  }
  R1*5 r2 r4 r8 b16 b
  b4 \fall r8 b16 b b4 \fall r8 b16 b b4 \fall r8 b16 b b4 \fall r
  b b b \fall r8 b | r b r b b b b4 | b b b \fall r8 b | r b r b b b b4 | b b b \fall r8 b | r b r b b b b4 | b r r2 | R1

  \repeat volta 2 { R1*7 }
  \alternative {
    {R1}
    {r4 r8 g~ g4 e}
  }
  g, r8 g'~ g4 e | g, r8 g'~ g4 e | g, r8 g'~ g4 e | g, r8 g'~ g4 e | b r8 fis'~ fis4 e | b r8 fis'~ fis4 e | r8 g~ g4 \fall r8 g~ g4 \fall | r8 g~ g4 \fall r8 g~ g4 \fall
  r8 g~ g4 \fall r8 g~ g4 \fall | r8 g~ g4 \fall r8 g~ g4 \fall | r8 d'~ d4 \fall r8 d~ d4 \fall | r8 d~ d4 \fall r8 d~ d4 \fall R1*4
  \repeat volta 2 { R1*2 }
  \alternative {
    {R1*2}
    {r4 \tuplet 3/2 { g,8 a b } d c g a | b4 ais8 b8~ b2 }
  }
}


altoSax = \transpose es c \relative c'' {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  R1*2
  \repeat volta 2 { R1*16 }
  \repeat volta 2 { R1*7 }
  \alternative {
    {R1}
    {r4 r8 b~ b4 d}
  }
  g, r8 b~ b4 d | g, r8 b~ b4 d | g, r8 e'~ e4 g | g, r8 e'~ e4 g | b, r8 e~ e4 gis | b, r8 e~ e4 gis | b, r r2 R1
  R1*8
  \repeat volta 2 { R1*4 }
  \alternative {
    { R1*4 }
    { R1*4 }
  }
  g4 r8 g'~ g4 e | g, r8 g'~ g4 e | g, r8 g'~ g4 e | g, r8 g'~ g4 e | b r8 fis'~ fis4 e | b r8 fis'~ fis4 e | r8 g~ g4 \fall r8 g~ g4 \fall | r8 g~ g4 \fall r8 g~ g4 \fall

  g g g \fall r8 g | r g r g g g g4 | gis gis gis \fall r8 gis | r gis r gis gis gis gis4 | g g g \fall r8 g | r g r g g g g4 | g r r2 | R1

  \repeat volta 2 { R1*7 }
  \alternative {
    {R1}
    {r4 r8 b,~ b4 d}
  }
  g, r8 b~ b4 d | g, r8 b~ b4 d | g, r8 e'~ e4 g | g, r8 e'~ e4 g | b, r8 e~ e4 gis | b, r8 e~ e4 gis | r8 e~ e4 \fall r8 e~ e4 \fall | r8 e~ e4 \fall r8 e~ e4 \fall
  r8 e~ e4 \fall r8 e~ e4 \fall | r8 e~ e4 \fall r8 e~ e4 \fall | r8 gis~ gis4 \fall r8 gis~ gis4 \fall | r8 gis~ gis4 \fall r8 gis~ gis4 \fall R1*4
  \repeat volta 2 { R1*2 }
  \alternative {
    {R1*2}
    {r4 \tuplet 3/2 { g,8 a b } d c g a | b4 dis8 e8~ e2 }
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
    system-system-spacing #'basic-distance = #20 % increase space
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
    system-system-spacing #'basic-distance = #20 % increase space
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
    system-system-spacing #'basic-distance = #20
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
