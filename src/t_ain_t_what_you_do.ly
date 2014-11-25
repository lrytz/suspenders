#(ly:set-option 'relative-includes #t)
\version "2.18.0"
\include "lib.ly"

\header {
  title = "T'ain't what you do"
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
  \tempo 4 = 164
  \partial 4. s4.
  s1*8 s1
  s1*8 \bar "||"
  s1*8 \bar "||"
  s1*8 \bar "||" % tutti
  \leftMark \markupBox "Breaks, Thema Voc"
  s1*8 % breaks
  s1*8 % voc A
  s1*8 \bar "||" % voc B
  s1*8 % voc A
  \leftMark \markupBox "Solo Bass"
  s1*8 % solo bass
  \rightMark \markupBox "Repeat 3x"
  s1*0^\markupBox "Solo Drums"
  s1*8 \leftMark "On Cue" s1*2 \bar "||" % solo drum
  s1*8 \bar "|."

}

remarks = \lyricmode {
}

aChords = \chordmode {
  es2 es:7/des c:m7 ces:/bes as es:/g f:m7 bes:7
  es es:7/g as a:dim bes1:7 es
}

bChords = \chordmode {
  as1 bes es s
  as f:m7 bes s
}

altoChords = \transpose ges c \chordmode {
  \partial 4. s4.
  s1*8 s1
  \bChords
  s1*8
  s1*8 % tutti
  s1*8 % breaks
  s1*24 % vocals
  \transpose es des \aChords
  % \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  % \chorusChords
  % \unset Score.proportionalNotationDuration
}

trumpetChords = \transpose des c \chordmode {
  \partial 4. s4.
  s1*8 s1
  s1*8
  s1*8
  s1*8 % tutti
  s1*8 % breaks
  s1*24 % vocals
  \transpose es des \aChords
}

slT = \absolute {c''4}
slS = \absolute {f''4}
slbT = \repeat unfold 4 \slT
slbS = \repeat unfold 4 \slS

trumpet = \transpose des c \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  \partial 4. r8 r4
  \repeat volta 2 {
    es,2^"2nd time only" r | r es'4 es | es r r2 | r ges4 ges |
    es r4 r2 | r es4 es | es r4 r2 |

  }
  \alternative {
    {r8 es4.^"play" c8 bes ges f}
    {r2 es4 f}
  }
  as4. as8~ as2 | r8 bes r as r ges r es~ | es1 | r2 es4 f |
  as4. as8~ as2 | r1 | r8 bes r g bes4 g | bes2 r8 es r4 |

  r2 r8 es r es | es es es c r bes r4 | r2 r8 es r es | es es es c r bes r4 |
  r2 r8 es r es | es es es ges r es~ es4 | ges4 es beses'8 as ges es~ | es4 r r es |

  % tutti
  bes'2 as4. g8~ | g2 es4 es | bes'2 as4. g8~ | g2 es4 es |
  bes'2 as4. g8~ | g2 es4 es | g2 r | r1

  R1*8 % breaks

  \key as \major

  \repeat volta 2 {
    R1*8
  }
  R1*8 % B
  R1*8 % A
  \key des \major
  % solo bass

  \slash
  \repeat volta 3 \repeat unfold 8 \slbT
  \endSlash
  \repeat volta 2 {R1*8} | as1~ as2. r4 |
  r2 as~ | as r | r bes~ | bes r |
  r as~ | as r | r bes4. des8~ | des2. r4
}

breaks = {
}

altoSax = \transpose ges c \relative c'' {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  \partial 4. r8 r8 es8
  \repeat volta 2 {
    r es r es es es r es | es es r es c bes r es | r es r es es es r es | es es r es ges f r es |
    r es r es es es r es | es es r es bes' es, r ges | r es r ges f es r es~ |
  }
  \alternative {
    {es2 r4 r8 es}
    {es2 r}
  }

  r1 r \slash s1*0^"Fills" \slbS \slbS
  r1 \slbS r1 \slS \slS \slS \endSlash r8 es |
  r es r es es4 r | r2 r4 r8 es | r es r es es4 r | r2 r4 r8 es |
  r es r es es4 r | r1 | ges4 es beses'8 as ges es~ | es4 r r c' |

  % tutti
  es2 des4. c8~ | c2 c4 c | es2 des4. c8~ | c2 c4 c |
  es2 des4. c8~ | c2 c4 c | es2 es4. g8 | r1

  R1*8 % breaks

  \key as \major

  \repeat volta 2 {
    R1*8
  }
  R1*8 % B
  R1*8 % A

  \key des \major

  %solo bass
  \slash
  \repeat volta 3 \repeat unfold 8 \slbS
  \endSlash
  \repeat volta 2 {R1*8} | bes,1~ bes2. des4^^ |
    as'2 r8 des, f \grace ges16( g8) | r8 ges~ ges fes des bes des4^^ | as'2 r8 des, f \grace ges16( g8) | r8 ges~ ges fes des bes des4^^ |
    as'2 r8 des, f \grace ges16( g8) | r8 ges~ ges fes des bes des4^^ | as'2 ges8 g as bes~ | bes2. r4

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
    system-system-spacing #'basic-distance = #16 % increase space
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
    system-system-spacing #'basic-distance = #16 % increase space
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

tenorSax = \transpose bes es \altoSax
tenorChords = \transpose bes es \altoChords
\book {
  \bookOutputSuffix "ts"
  \paper {
    system-system-spacing #'basic-distance = #16
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
