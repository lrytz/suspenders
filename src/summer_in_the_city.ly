#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "Summer in the City"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #4 %space after title
  % ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key d \minor
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 2 = 88
  s1*8  % intro
  s1*6 \time 2/4 s2 \time 4/4 \bar "||"
  \key g \major
  s1*4 \key d \major s1*4 \bar "||" % reggae
  \key d \minor
  s1*2
  s1*2 \bar "||"

  \key g \minor
  s1*4^\markupBox "solo git" \key d \minor s1*6 \time 2/4 s2 \time 4/4 \bar "||" % solo git
  \key g \major
  s1*4 \key c \major s1*4 \bar "||" % reggae
  \key a \major
  s1*4 % hornz
  \key e \minor
  s1*4 % interlude
  s1*4 % ending

}

remarks = \lyricmode { }

theChords = \chordmode { }

altoChords = {} % \transpose es c { s1*8 \theChords }

trumpetChords = {} % \transpose bes c { s1*8  \theChords }

lickTp = \relative c''' { }

lickAs = \relative c'' { }


trumpet = \transpose bes bes \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  R1*8
  \repeat volta 2 {
    R1*6 R2
    \repeat unfold 2 { r2 r4 r16 g'-. g-. g-^ r1 } R1*4 R1*2
  }
  R1*2
  R1*10 R2
  \repeat unfold 2 { r2 r4 r16 g-. g-. g-^ r1 } R1*4
  r8 fis,16 gis a gis fis8 fis fis16 b r4 | r8 fis16 gis a gis fis fis-^ r dis' d b cis b a fis
  r16 fis r gis a gis fis8 fis fis16 b r4 | r16 fis r gis a gis fis fis-^ r dis' d b cis b a g
  \repeat volta 2 { R1*3 r4 r8. b16^"2nd time only" r g' fis d f e d b }
  \repeat volta 2 { r b r b e4~ e2~ | e2 r16 d des c b bes a g | e2 fis' | g4~ g8 r16 b,16 r g' fis d f e d b}
}


altoSax = \transpose es bes \relative c'' {
  \global
  \set Staff.instrumentName = #"Alto Sax"

  R1*8
  \repeat volta 2 {
    R1*6 R2
    \repeat unfold 2 { r2 r4 r16 c-. c-. c-^ r1 } R1*4 R1*2
  }
  R1*2
  R1*10 R2
  \repeat unfold 2 { r2 r4 r16 c-. c-. c-^ r1 } R1*4
  r8 a16 b cis b a8 a a16 dis r4 | r8 a16 b cis b a a-^ r b a fis a fis dis cis
  r16 a' r b cis b a8 a a16 dis r4 | r16 a r b cis b a a-^ r b a fis a fis dis e
  \repeat volta 2 { R1*3 r4 r8. g16^"2nd time only" r e' d b d b a g }
  \repeat volta 2 { r g r g b4~ b2~ | b2 r16 a aes g ges f e dis | b2 d' | cis4~ cis8 r16 g r e' d b d b a g}
}

% \book {
%   \score {
%     % \midi { }
%     <<
%       \lyricsAbove \remarks
%       \new ChordNames \trumpetChords
%       \new Staff = "trumpet" <<
%         \transpose bes bes { \structure }
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
        \transpose bes bes { \structure }
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
        \transpose es bes { \structure }
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
        \transpose bes bes { \structure }
        \tenorSax
      >>
    >>
  }
}
