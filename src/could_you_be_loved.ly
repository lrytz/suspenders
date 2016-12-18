#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

% original: d major
% suspenders: b major
% coker: bb major

\header {
  title = "Could you be loved"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #4 %space after title
  % ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key d \major
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 104
  s1*6^\markupBox "Intro Git" \break
  s1*4^\markupBox "Chorus" \break    % 2x

  \pSegno
  s1*4^\markupBox "Verse A"          % 2x
  s1*4^\markupBox "Verse B" \rightBreakMark \markupBox "to Coda" \break   % 2x
  s1*4^\markupBox "Chrous" \break    % 2x
  s1*4^\markupBox "Interlude" \rightBreakMark \markupBox "D.S. al Coda" \break % 3x


  s1^\markup { \right-align \fontsize #4 \musicglyph #"scripts.coda" }
  s1*4^\markupBox "Chrous" \break    % 2x
  s1*4^\markupBox "Solo Keys" \break % open
  s1*4^\markupBox "Chrous" \break    % 2x
  s1*4^\markupBox "Ending"           % open
}

remarks = \lyricmode {
}

% theChords = \chordmode { ges1 ces ges des ges ces ges2 ces2:6 ges1 }

altoChords = {} % \transpose es a { s1*32 \theChords }

trumpetChords = {} % \transpose bes a { s1*32  \theChords }


tpChorus = \relative c'' {
% b8. a16~ a g fis8 r2           | fis8. e16~ e d b8 r2     | g'8. b16~ b d e8 r2         | e8-- d-. r16 d b8-. d-. r r4
  b8. a16~ a g fis8 fis( g a a~) | a2. r4                   | g8. b16~ b d e8 r fis, a g~ | g~ fis~ fis4~ fis r
}

tpVerseA = \relative c'' {
% d8-- e-- fis-- b, r4 r8. b16 | d8-- e-- fis-- b, r2 | a16 b8 e16~ e d b8 e e b r | a16 b8 e16~ e d b8 e16 e e8 b r
  R1*2                                                | a16 b8 e16~ e d b8 e e b r | a16 b8 e16~ e d b8 e16 e e8 b r
}

tpVerseB = \relative c'' {
% d8 e fis b, r4 r8. b16 | d8 e fis b, r2 R1*2
  R1*4
}


asChorus = \relative c' {
% fis8. d16~ d e d8 r2         | b8. a16~ a g fis8 r2 | d'8. e16~ e g b8 r2       | b8-- a-. r16 a fis8-. a-. r r4
  fis8. d16~ d e d8 a( b d d~) | d2. r4               | d8. e16~ e g b8 r a, d b~ | b a~ a4~ a r
}

asVerseA = \relative c' {
% fis8-- a-- b-- fis r4 r8. d16 | fis8-- a-- b-- fis r2 | d16 e8 a16~ a g e8 a g e r | d16 e8 a16~ a g e8 a16 a g8 e r
  R1*2                                                  | d16 e8 a16~ a g e8 a g e r | d16 e8 a16~ a g e8 a16 a g8 e r
}

asVerseB = \relative c' {
% fis8 a b fis r4 r8. d16 | fis8 a b fis r2 R1*2
  R1*4
}


trumpet = \transpose ais a \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  R1*6
  \repeat volta 2 { \tpChorus }

  \repeat volta 2 { \tpVerseA }
  \repeat volta 2 { \tpVerseB }
  \repeat volta 2 { \tpChorus }
  \repeat volta 3 { R1*4 }

  R1
  \repeat volta 2 { \tpChorus }
  \repeat volta 2 { R1*4 }
  \repeat volta 2 { \tpChorus }
  \repeat volta 2 { R1*4 }
}


altoSax = \transpose dis a \relative c' {
  \global
  \set Staff.instrumentName = #"Alto Sax"

  R1*6
  \repeat volta 2 { \asChorus }

  \repeat volta 2 { \asVerseA }
  \repeat volta 2 { \asVerseB }
  \repeat volta 2 { \asChorus }
  \repeat volta 3 { R1*4 }

  R1
  \repeat volta 2 { \asChorus }
  \repeat volta 2 { R1*4 }
  \repeat volta 2 { \asChorus }
  \repeat volta 2 { R1*4 }

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
