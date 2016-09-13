#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "Lucille"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
  ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key f \major
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 152

  s1*12^\markupBox "Intro" % intro

  s1*13^\markupBox "A" \bar "||"
  s1*12^\markupBox "B" \bar "||"
  s1*12^\markupBox "Solo Sax" \bar "||"
  s1*12^\markupBox "B"
  s1*12^\markupBox "A1" \bar "||"
  s1*12 \bar "|."
}

breaks = {
  s1*12 \break
  s1*13 \break
  s1*12 \break
  s1*12 \break
  s1*12 \break
  s1*12 \break
}

remarks = \lyricmode {
}

theChords = \chordmode { c1:7 s s s f:7 f:7 c:7 c:7 g:7 f:7 c:7 c2:7 g:7 }

altoChords = \transpose es f { s1*37 \theChords }

trumpetChords = \transpose bes f { s1*37  \theChords }

tpB = \relative c' {
  \repeat unfold 3 { g'4 r r2 } r1
}

saxA = \relative c' {
  \repeat unfold 4 { c8-. c-. e-- g-. bes-- a-. r4 }
}

saxB = \relative c' {
  \repeat unfold 3 { c4 r r2 } r1
}


saxLineTwo = \relative c' {
  \repeat unfold 2 { f8-. f-. a-- c-. es-- d-. r4 } \repeat unfold 2 { c,8-. c-. e-- g-. bes-- a-. r4 }
}

saxLineThree = \relative c' {
  g'8-. g-. b-. b-. d-. d-. g-- f-. | f,-. f-. a-. a-. c-. c-. f-- es-. |
  c,8-. c-. e-- g-. bes-- a-. r4
}

saxRest = \relative c' {
  \saxLineTwo
  \saxLineThree
}

saxEnd = \relative c' { c8-. c-. e-- g-. bes-- a-. r4 }
saxEndDom = \relative c' { g8-. g-. b-- d-. bes'-- a-. r4 }

trumpet = \transpose bes f' \relative c' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  R1*12

  \repeat volta 2 { \saxA \saxRest } \alternative { \saxEndDom \saxEnd }

  \tpB \saxRest \saxEnd

  R1*12

  \tpB \saxRest \saxEnd

  \repeat volta 2 { \saxA \saxLineTwo } \saxLineThree \saxEnd

  \saxB \saxLineTwo

  g'8-. g-. b-. b-. d-. d-. g-- f-. | f,4 r r2

  c8-. c-. e-- g-. bes-- a-. g-- e-. | c4-. as8-- g8~ g2
}


altoSax = \transpose es f \relative c' {
  \global
  \set Staff.instrumentName = #"Baritone Sax"

  R1*12

  \repeat volta 2 { \saxA \saxRest } \alternative { \saxEndDom \saxEnd }

  \saxB \saxRest \saxEnd

  R1*12

  \saxB \saxRest \saxEnd

  \repeat volta 2 { \saxA \saxLineTwo } \saxLineThree \saxEnd

  \saxB \saxLineTwo

  g'8-. g-. b-. b-. d-. d-. g-- f-. | f,4 r r2

  c8-. c-. e-- g-. bes-- a-. g-- e-. | c4-. des8-- c8~ c2
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
