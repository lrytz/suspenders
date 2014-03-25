#(ly:set-option 'relative-includes #t)
\include "lib.ly"

\header {
  title = "Pent up in a Penthouse"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
}

global = {
  \time 4/4
  \key f \major
  \clef "violin"
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 132
  s1*0^\markupBox "Intro Piano"
  s1*4
  s1*8  % A
  \bar "||"
  s1*8  % A
  \bar "||"
  s1*8  % B
  \bar "||"
  s1*12 % A'
}

remarks = \lyricmode {
  \skip 1*4
  \markupBox "1. Tacet (Solo Piano), 2. Play Notes (Thema), 3. Solo Voc+Trumpet, 4. Play Notes" 1
  \skip 1*15
  \markupBox "2. Fills Sax, 3. Solo Piano, 4. Fills Sax"
  \skip 1*7
  \markupBox "2. & 4. Play Notes (Thema)"
  \skip 1*3
  \markupBox "Breaks"
}

chorusA = \chordmode {
  g2:7/b g:m7/bes f:/a d:7 g:7/b g:m7/bes f:/a d:7
}
chorusChords = \chordmode {
  \chorusA
  g2:m7 c:7 f:6 d:7 g1:7 c:7
  \chorusA
  g2:m7 c:7 f:6 d:7 g:m7 c:7 f1:6

  % B
  c1:m7 f:7 bes:6 s2 a:7
  d1:m7 s g:7 c:7

  b2:dim7 g:m7/bes f:/a d:7 g:m7 c:7 a1:7
  d:m7 f:7/es bes:6 bes2.:m6 c4:7
  f1:6 d:7 g2:7 c:7 f c
}

theChords = {
  s1*4
  \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  \chorusChords
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
  R1*4
  \repeat volta 3 {
    as4.^"Plunger, 2nd time only" r8 g4. f8 | r8 d r4 r2 | as'4. r8 g4. f8 | r8 d r4 r2 |
    as'4. r8 g4. f8 | r8 d r4 r2 | r1 | r1
    as'4. r8 g4. f8 | r8 d r4 r2 | as'4. r8 g4. f8 | r8 d r4 r2 |
    as'4. r8 g4. f8 | r8 d r4 r2 | r1 | r1
    r1 R1*7
    as'4.^"2nd time only" r8 g4. f8 | r8 d r4 r2 | as'4. r8 g4. f8 | r1
    R1*4
    r1 R1*2 \cross f4^"4. Fine" f8 f8 \endCross r2
  }
}


breaksTp = {
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4
}

altoSax = \transpose es c \relative c'' {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  R1*4
  \repeat volta 3 {
    d4.^"2nd time only" r8 des4. c8 | r8 a r4 r2 | d4. r8 des4. c8 | r8 a r4 r2 |
    d4. r8 des4. c8 | r8 a r4 r2 | r1^"2nd time fills" | r1
    d4. r8 des4. c8 | r8 a r4 r2 | d4. r8 des4. c8 | r8 a r4 r2 |
    d4. r8 des4. c8 | r8 a r4 r2 | r1^"2nd time fills" | r1
    r1 R1*7
    d4.^"2nd time only" r8 des4. c8 | r8 a r4 r2 | d4. r8 des4. c8 | r1
    R1*4
    r1^"2nd time fills" R1*2 \cross bes4^"4. Fine" bes8 bes8 \endCross r2
  }
}

breaksAs = {
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4
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
        \breaksTp
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
        \breaksAs
        \altoSax
      >>
    >>
  }
}

tenorSax = \transpose bes es \altoSax
tenorChords = \transpose bes es \altoChords
\book {
  \bookOutputSuffix "ts"
  \paper {
    system-system-spacing #'basic-distance = #15 % increase space
  }
  \score {
    <<
      \lyricsAbove \remarks
      \new ChordNames \tenorChords
      \new Staff = "tenorSax" <<
        \structure
        \breaksAs
        \tenorSax
      >>
    >>
  }
}
