#(ly:set-option 'relative-includes #t)
\include "lib.ly"

\header {
  title = "Big Fat Mama"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
  ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key g \major
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 174
  \partial 4. s4.
  s1*8 \bar "||"
  \pSegno
  s1*6 \pCoda s1*6 \bar "||" % thema horns
  s1*12 \bar "||" % thema voc 1
  s1*12 \bar "||" % thema voc 2
  s1*12 % thema voc breaks
  \leftMark \markupBox "Solo Sax"
  s1*12 % solo sax
  \rightBreakMark \markupBox "Solo ad lib, D.S. al Coda"
  s1*0^\markup \fontsize #4 {\musicglyph #"scripts.coda"}
  s1*6 \bar "||"
  s1*12 \bar "|."

}

remarks = \lyricmode {
}

turnChords = \chordmode {
  g2:6 g:m6/bes a:m7 d:7
}

chorusChords = \chordmode {
  g1:7 s s s c:7 s g:7 s d:7 s \turnChords
}

altoChords = \transpose es c {
  \partial 4. s4.
  s1*8
  s1*12
  s1*10 \turnChords % voc
  s1*12 % voc
  s1*12 % voc breaks
  \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  \chorusChords
  \unset Score.proportionalNotationDuration
}

trumpetChords = \transpose bes c {
  \partial 4. s4.
  s1*8
  s1*12 % horns
  s1*12 % voc
  s1*12 % voc
  s1*12 % voc breaks
  \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  \chorusChords
  \unset Score.proportionalNotationDuration
}

slT = \absolute {a''4}
slS = \absolute {d''4}
slbT = \repeat unfold 4 \slT
slbS = \repeat unfold 4 \slS

trumpet = \transpose bes c \relative c''' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  \partial 4. r8 r4
  R1*2 | r4 r8 g' r g r e | g4. b8 r4 a8 g |
  r1 | r2 r4 r8 b,~ |  b4. b8~ b4. b8~ | b2 r |

  \repeat unfold 4 {r2 r4 r8 e | r e4. e4--\fall r}

  R1*2 | r8 g4. e8 g r e | a4-- fis8 d~ d4 r

  R1*12 % thema voc
  R1*10 % thema voc
  r8 g r e g4. g8 | r e g g r g4. |

  \repeat unfold 3 {g4 r r2} R1*7
  r2 g8 g r e | g4 g8 e r e r e~ |

  \repeat volta 3 {
    e4_"1st time only"\fall \slash \slT \slT \slT
    \repeat unfold 11 \slbT \endSlash
  }
  r2 r4 r8 e | r e4. e4--\fall r | r2 r4 r8 fis | r fis4. fis4--\fall r

  R1*2

  % end
  d4\fall r8 g~ g4 r | r1 dis4\fall r8 gis~ gis4 r | r1
  e4\fall r8 a~ a4 r | R1*4 |

  r2 r4 r8 d, | r d~ d des c d e fis | b4. g8 r2

}

breaks = {
  \partial 4. s4.
  s1*8
  s1*12 % horns
  s1*12 % voc
  s1*12 % voc
  s1*12 \break % voc breaks
  s1*4 \break
  s1*4 \break
  s1*4 \break
}

altoSax = \transpose es c \relative c'' {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  \partial 4. g8 b c |
  d g~ g2. | d4 des c bes8 b~ | b4 r8 e8 r e r b | e4. fis8 r4 e8 d |
  b8 bes a g d' des c b | c b bes a es' d des e,~ | e4. e8~ e4. fis8~ | fis2 r8 d'  d d |

  % thema sax
  \repeat unfold 2 {g4 a \grace bes16( b8) e,~ e b' | r b4. b8-- d, d d}
  g4 a bes8 e,~ e bes' | r bes4. bes8-- d, d d | g4 a \grace bes16( b8) e,~ e b' | r b4. b8-- g, b d |
  g4 g8 e es d r bes'8~ | bes4 g8 d c bes b d | g-- e4. cis8 e r cis | c4-- c8 a~ a4 r

  R1*10 \slash s1*0^"Fill" \slbS \slbS \endSlash
  R1*10
  r8 d r b d4. c8 | r a c bes r bes4. |

  \repeat unfold 3 {b4 r r2} r2 r8 g a4 |
  \repeat unfold 2 {bes2.. g8 | r2 r8 g a4} bes2.. a8 r1
  r2 d8 d r d | c4 c8 bes r bes r b~ |

  \repeat volta 3 {
    b4_"1st time only"\fall \slash \slS \slS \slS
    \repeat unfold 10 \slbS \slS \slS
    \endSlash r8 d_"on D.S." d d
  }
  g4 a \grace bes16( b8) e,~ e b' | r b4. b8-- d, d d | g4 a c8 fis,~fis c' | r c4. c8-- d,4. |
  g8 d a' d, b' d, c' d, | d' d, c' d, b' d, a' d, | 

  %end
  g4\fall r8 d'~ d4 r | r1 | gis,4\fall r8 dis'~ dis4 r | r1
  a4\fall r8 e'~ e4 r | R1*3 |

  r8 g, r ges f2 | e8 g a g bes4. fis8 | r fis~ fis f e fis a c | e4. d8 r2




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
