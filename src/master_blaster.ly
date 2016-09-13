#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "Master Blaster (Jammin)"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
  ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key c \minor
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 134

  s1*4 \bar "||" % intro dr

  s1*8           % band (rep, 2nd time horns)

  s1*8           % verse (rep)
  s1*8 \bar "||" % chorus
  s1*4           % interlude

  s1*8           % chorus (rep, 2nd time horns)
  s1*8           % chorus (rep, with horns)

  s1*8 \bar "||" % interlude
  s1*8^\markupBox "Solo Sax"

  s1*8           % verse (rep, 2nd time horns)
  s1*8           % chors (open rep, with horns)
}

breaks = {
  s1*12 \break
  s1*8  \break
  s1*20 \break
  s1*8  \break

  s1*8  \break
  s1*16 \break
  s1*8  \break
}

remarks = \lyricmode {
}

verse = \chordmode { c1:m c2:m bes as1 aes2 g f1 f c:m bes }
chorus = \chordmode { c1:m g:7 f:7 f:7 c:m g:7 f:7 f:7 }

theChords = \transpose c c \chordmode { s1*56 \verse s1*8 \chorus }

altoChords = \transpose es f \theChords

trumpetChords = \transpose bes f \theChords

verseTp = \relative c' {
    r4 r8. es16 g8 r16 c es8 r | r2 r4 r8. d16 | c8 r16 as es8 r r2 | r2 r4 r8. f16 |
    a8 r16 c f8 r r2 | r1 | r4 r8. g16 es8 r16 c g8 r | r8. f'16 d8 r16 bes f8 r r4 |
}

chorusTp = \relative c'' {
  \repeat unfold 2 { g'1 f1 es4 es8 es r2 r1 }
}

verseAlto = \relative c' {
    r4 r8. c16 es8 r16 g c8 r | r2 r4 r8. bes16 | as8 r16 es c8 r r2 | r2 r4 r8. c16 |
    f8 r16 a c8 r r2 | r1 | r4 r8. es16 c8 r16 g es8 r | r8. d'16 bes8 r16 f d8 r r4 |
}

chorusAlto = \relative c' {
  \repeat unfold 2 { es'1 b1 a4 a8 a r2 r1 }
}

trumpet = \transpose bes f \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  R1*4

  \repeat volta 2 { s1*0^"2nd time only" \verseTp }
  \repeat volta 2 R1*8
  R1*8
  R1*4
  \repeat volta 2 \verseTp
  \repeat volta 2 \chorusTp

  R1*8
  R1*8

  \repeat volta 2 \verseTp

  \repeat volta 2 {s1*0^\markupBox "Repeat ad-lib" \chorusTp } 
}


altoSax = \transpose es f \relative c' {
  \global
  \set Staff.instrumentName = #"Alto Sax"

  R1*4

  \repeat volta 2 { s1*0^"2nd time only" \verseAlto }
  \repeat volta 2 R1*8
  R1*8
  R1*4
  \repeat volta 2 \verseAlto
  \repeat volta 2 \chorusAlto

  R1*8
  R1*8

  \repeat volta 2 \verseAlto

  \repeat volta 2 {s1*0^\markupBox "Repeat ad lib" \chorusAlto } 
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
    system-system-spacing #'basic-distance = #14 % increase space
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
    system-system-spacing #'basic-distance = #14 % increase space
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
    system-system-spacing #'basic-distance = #14
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
