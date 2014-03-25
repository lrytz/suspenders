#(ly:set-option 'relative-includes #t)
\include "lib.ly"

\header {
  title = "Sermonette"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
}

global = {
  \time 4/4
  \key c \major
  \clef "violin"
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 120
  \partial 2.
  s2.^"laid-back"
  \bar "||"
  s1*8 % intro
  s1*8 % A
  \bar "||"
  s1*8 % A
  \bar "||"
  s1*8 % B
  \bar "||"
  s1*8 % A
  s1*3 % end
  \bar "|."
}

remarks = \lyricmode {
  \partial 2. \skip 2.
  \skip 1*8
  \markupBox "1. Tacet (Thema), 2. Solo Sax, ... 3. Tacet (Thema)" 1
  \skip 1*15
  \skip 1*15
  \markupBox "1. Solo Sax, 3. Fill Sax"
  \skip 1
  \markupBox "Fill piano"
}

chorusA = \chordmode {
  c1 s g:7 s2. e4:7/gis
  a1:m f2 a:7/e
}
chorusChords = \chordmode {
  \chorusA d1:7 g:7
  \chorusA d2:7 g:7 c1:7

  % B
  g1:7 s c s2. e4:7/gis
  a1:m e:m d2..:7 g8:7 s1

  c1 s f2 fis:dim c2.:/g e4:7/gis
  a1:m7 f2 a:7/e d:7 g4.:7sus4 c8 s1
}

theChords = {
  \partial 2. s2.
  s1*8
  \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  \chorusChords
  \unset Score.proportionalNotationDuration
}

trumpetChords = \transpose f c \theChords
altoChords = \transpose bes c \theChords

slTp = \relative c'' { e4 }
slAs = \relative c''' { a4 }
slbTp = \repeat unfold 4 \slTp
slbAs = \repeat unfold 4 \slAs

trumpet = \transpose f c \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  \partial 2. r4 r2
  R1*6 | fis4 fis f4. e8 | r1
  \repeat volta 3 {
    \slash
    \repeat unfold 16 \slbTp
    \endSlash
    f1^"1st and 3rd time only"~ | f2. r4 | e1~ | e2. r4 |
    e1 | g | fis | r
    \slash
    \repeat unfold 6 \slbTp
    \endSlash
    fis4 fis f4. e8 | \slash \slbTp \endSlash
  }
  R1*2 \slashStem e4 e e4. e8 \endSlashStem
}


breaksTp = {
  \partial 2. s2.
  s1*8 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
}

altoSax = \transpose bes c \relative c'''' {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  \partial 2. r4 g,8 a c4 |
  e4^\lheel r e4.^\lheel c8~ | c2 c8 c c c | a'1 | g8\glissando e4. c4 f8 e~ |
  e2\glissando c4 r | e d c8 a g4 | a a a4. g8 | r1
  \repeat volta 3 {
    \slash
    \repeat unfold 16 \slbAs
    \endSlash
    b1^"1st and 3rd time only"~ | b2. r4 | c1~ | c2. r4 |
    c1 | b | a | r
    \slash
    \repeat unfold 6 \slbAs
    \endSlash
    a4 a a4. g8 | \slash \slbAs \endSlash
  }
  R1*2 \slashStem a4 a a4. a8 \endSlashStem
}

breaksAs = {
  \partial 2. s2.
  s1*8 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
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
