#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "I Wanna be Like You"
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
  \tempo 4 = 196 

  s1*8  % intro
  s1*16  % verse
  s1*10 \bar "||" % chorus
  s1*8  \bar "||" % solo

  s1*8 \bar "||" s1*8 % verse 2
  s1*10 % chorus
  s1*8  % solo

  s1*16  \bar "||"  % verse 3
  s1*12 % tutti

  s1*8  % solo
  s1*10 \bar "||" % chorus
  s1*9  % end
}

breaks = {
  s1*8 \break
  s1*16 \break
  s1*10 \break
  s1*8 \break

  s1*8 s1*8 \break
  s1*10 \break
  s1*8 \break

  s1*16 \break
  s1*12 \break

  s1*8 \break
  s1*10 \break
  s1*6 \break
}

remarks = \lyricmode {
}

verse = \chordmode { a1:m s s e:7 s s s }
chorus = \chordmode { c1 s a:7 s d:7 g:7 c2 es:6 d:7 g:7 }

theChords = \transpose c es \chordmode {
  \verse a1:m
  \verse a1:m \verse a2:m g:7
  \chorus c2 f:7 c g:7

  c1 s a:7 s d:7 g:7 c2 f:7 c g:7

  c e:7 a1:m s e:7 s s s a:m
  a2:m e:7 a1:m s e:7 s s s a2:m g:7
  \chorus c2 f:7 c e:7

  \verse a1:m
  \verse a1:m a2:m g:7

  c1 s a:7 s d:7 g:7 c2 bes:7 a1:7 d:7 g:13 c2 f:7 c g

  c1 s a:7 s d:7 g:7 c2 f:7 c g:7
  \chorus c2 bes:7 a1:7

  d1:7 g:7 c2 bes:7 a1:7 d:7 g:7 c s4 g s2 c4:7
}

altoChords = \transpose es a \theChords

trumpetChords = \transpose bes a \theChords

flute = \relative c' {
  \tiny
  r4 es^\markupBox "Fills Blockflöte" f r | f es8 c r2 | r4 es8 f f4 r8 c' g4 f8 d r2 |
  r4 f8 g b4 c8 b | r d, f g b c b cis, | d f b c b g d g | c g es c~ c4 r |
  r4 c'8 b c4 r8 c | b4 bes r bes | a r as8 g~ g4~ | g8 f d b r2 |
  r4 c' b r8 bes | r4 bes a8 as r as | g4. g8 f4 es | c
}

trumpet = \transpose bes a \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  \repeat unfold 7 r1 c4 r4 r2

  \flute r4 r2 \normalsize

  \repeat volta 2 { g1~ g | bes~ bes2. r4 | a1 | as }
  \alternative { {g4 r bes2 | a4 r as2} {g2 as g4 bes8^"Solo" c d es f fis} }

  g4 f8 es~ es2 | r4 es, g bes | c2~ c8 bes g e | c2. r4 |
  f8 a4 c,8 f a c, f | as2 \glissando d | g,4. f8 es4. f8 | es2 r

  s1*0^\markupBox "Fills Trombone Style" R1*16

  \repeat volta 2 { g1~ g | bes~ bes2. r4 | a1 | as }
  \alternative { {g4 r bes2 | a4 r as2} {g2 as g r} }

  \repeat volta 2 { s1*0^\markupBox "Solo Tutti" R1*8 }

  \flute \normalsize r8 g' bes bes a as

  g4^\markupBox "Solo Tutti" es es2 R1*7
  g8 c4 g8 c4 g8 bes |
  r fis \tuplet 3/2 {g as a} \tuplet 3/2 {bes a as} \tuplet 3/2 {g ges f}
  es1 \glissando es'4 r bes r

  \repeat volta 2 {
    bes,4 g bes r bes8 g r4 bes8 g r4
    bes4 g bes r bes8 g r4 bes8 g r4
    c8 a r4 r2 bes8 f r4 r2
    bes4 g as8 bes as g r4 g8 as bes2
  }

  \repeat volta 2 {
    g'4 es es2 r8 es r es es4 es |
    e c c2 r8 c r c c4 c
    g'4. c,8~ c2 | g'4. d8~ d2
  }
  \alternative {
    {c4 bes c2 r8 c r c bes4 c}
    {es2 des8 es des4 c2. r4} 
  }
  g'4. c,8~ c2 | g'4. d8~ d2
  es2 des8 es des4 c2. r4
  r8 g' r g g4 g bes bes r2
  bes,8^"straigth 8" c es f g bes es, f g4 bes r2 \fermata
  \grace es,4 \glissando es'4 r r2
}


altoSax = \transpose es a \relative c' {
  \global
  \set Staff.instrumentName = #"Alto Sax"

  \repeat unfold 7 r1 es4 r4 r2

  \flute r4 r2 \normalsize

  \repeat volta 2 { es1~ es | e~ e2. r4 | es1 | d }
  \alternative { {es4 r e2 | es4 r d2} {es2 c es r} }
  
  R1*8

  s1*0^\markupBox "Fills Trombone Style" R1*16

  \repeat volta 2 { es1~ es | e~ e2. r4 | es1 | d }
  \alternative { {es4 r e2 | es4 r d2} {es2 c es r} }

  \repeat volta 2 { s1*0^\markupBox "Solo Tutti" R1*8 }

  \flute r4 r2 \normalsize

  s1*0^\markupBox "Solo Tutti" R1*10 g2 as g4 r bes r

  \repeat volta 2 {
    g4 es g r g8 es r4 g8 es r4
    g4 e g r g8 e r4 g8 e r4
    g8 c, r4 r2 g'8 d r4 r2
    es4 c es8 f es es r4 es8 f g2
  }

  \repeat volta 2 {
    bes4 g g2 r8 g r g g4 g |
    g e e2 r8 e r e e4 e
    c'4. a8~ a2 | bes4. f8~ f2
  }
  \alternative {
    {g4 g ges2 | r8 f r f f4 g}
    {g2 f8 g f4 e2. r4}
  }
  c'4. a8~ a2 | bes4. f8~ f2
  g2 f8 g f4 e2. r4
  r8 es' r es es4 es d d r2
  bes,8^"straigth 8" c es f es f c d e4 g r2 \fermata
  \grace bes,4 \glissando bes'4 r r2

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
