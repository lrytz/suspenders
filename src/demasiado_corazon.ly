#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "Demasiado Corazon"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #4 %space after title
  % ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key a \minor
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 2 = 110
  s1*10 \bar "||" \break
  \pSegno
  s1*8 \bar "||" \break
  s1*16 \bar "||" \break
  s1*8 \rightBreakMark \markupBox "To Coda" \break
  s1*8 \bar "||"
  s1*15^\markupBox "solo tp" \bar "||"
  s1*8^\markupBox "solo dr" \bar "||"
  s1*8^\markupBox "piano" \bar "||"
  s1*16 \bar "||" \rightBreakMark \markupBox "D.S. al Coda" \break
  s1*10^\markup {
    \fontsize #4
    \right-align
    \musicglyph #"scripts.coda"
  } \bar "|."
}

remarks = \lyricmode { }

theChords = \chordmode { }

altoChords = {} % \transpose es c { s1*8 \theChords }

trumpetChords = {} % \transpose bes c { s1*8  \theChords }

lickTp = \relative c''' { }

lickAs = \relative c'' { }


trumpet = \transpose c c \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  \repeat volta 2 {
    % intro
    R1*6 a4. c8~ c4 e-- | d2. r4 | a'8 a a4-. r a-^ | r r8 e-- d4-. c

    % thema
    r8 c-. c-. a~-. a c4-. b8~-. | b g4-. b8~-. b d4-. c8~-- | c a-. c-. b~-- b gis-. b-. a~-- | a b-. c-. b-. c4 \fall r
    r8 a'-. a-. e~-. e a4-. g8~-. | g d4-. g8~-. g b4-. a8~-- | a f-. a-. gis~-- gis e-. d-. c~--| c g'-. a-. g-. a4 \fall r

    % voc
    R1*8
    \repeat unfold 2 { e8-. a-. r4 r2 | r r8 d,-. f-. e~-. | e f4-. e8-. r2 | r1 }

    c4-. r8 a-. r4 f~ | f8 e'( f f f4-.) b,-. | c-. r8 b-. r4 c~ | c e8( d c4-.) c8( b |
    a4-.) r8 e-. r4 f~| f8 e'( f f f4-.) b,-. | c-. r8 gis'-. r4 a~ | a \fall r r2
  }

  % intro
  R1*6 a,4. c8~ c4 e-- | d2. r4
  
  % solo tp, dr
  R1*14 f4-. r8 e-. r4 a-^  R1*8

  % piano
  R1*8 R1*14 a4-^ r8 a-^ r4 r8 a-- | a4-^ a4-^ r2

  % coda
  R1*6 a,4. c8~ c4 e-- | d2. r4 | a'4-^ r8 a-^ r4 r8 a( | a a a4-^) r2
}


altoSax = \transpose f c \relative c'' {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  \repeat volta 2 {
    % intro
    R1*4 \repeat unfold 2 { a4. c8~ c4 e-- | d2. r4 } c'8 c c4-. r c-^ | r r8 e-- d4-. c

    % thema
    \repeat unfold 2 {
      r8 c-. c-. a~-. a c4-. b8~-. | b g4-. b8~-. b d4-. c8~-- | c a-. c-. b~-- b gis-. b-. a~-- | a b-. c-. b-. c4 \fall r
    }

    % voc
    R1*8
    \repeat unfold 2 { a8-. c-. r4 r2 | r r8 g-. b-. a~-. | a a4-. gis8-. r2 | r1 }

    a4-. r8 f-. r4 d~ | d8 c'( d d d4-.) b-. | a-. r8 gis-. r4 a~ | a r r2 |
    c4-. r8 a-. r4 d,~| d8 c'( d d d4-.) b-. | a-. r8 b-. r4 c~ | c \fall r r2
  }

  % intro
  R1*4 \repeat unfold 2 { a,4. c8~ c4 e-- | d2. r4 }
  
  % solo tp, dr
  R1*14 d4-. r8 c-. r4 c-^  R1*8

  % piano
  R1*8 R1*14 c4-^ r8 c-^ r4 r8 c-- | c4-^ c4-^ r2

  % coda
  R1*4 \repeat unfold 2 { a4. c8~ c4 e-- | d2. r4 } c'4-^ r8 c-^ r4 r8 c( | c c c4-^) r2
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
