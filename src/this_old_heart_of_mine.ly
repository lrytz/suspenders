#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "This Old Heart of Mine"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
  ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key c \major
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 128


  s1*0^\markupBox "Intro"
  s1*8 \bar "||"

  s1*0^\markupBox "Verse"
  \pSegno
  s1*8 \bar "||"
  s1*8 \pCoda \bar "||"
  s1*0^\markupBox "Chorus"
  s1*8 \bar "||"

  s1*0^\markupBox "Verse"
  s1*4 \bar "||"
  s1*8 \bar "||"
  s1*0^\markupBox "Chorus"
  s1*8 % \bar "||"

  s1*0^\markupBox "Solo Barisax"
  \bar ".|:" s1*4 \bar ":|.|:" % solo bari
  \rightBreakMark \markupBox "D.S. (no repeat)"

  s1*0^\markup { \right-align \fontsize #4 \musicglyph #"scripts.coda" }
  s1*8 \bar ":|."
}

breaks = {
  s1*8

  s1*8
  s1*8
  s1*8 \break

  s1*4
  s1*8
  s1*8 \break

  s1*4 \break

  s1*8
}

remarks = \lyricmode {
}

theChrods = \chordmode {
  s1*52
  c1 e:m f d2:m g:7
}

altoChords = \transpose es d \theChrods

trumpetChords = \transpose bes d \theChrods

slT = \absolute {a''4}
slS = \absolute {d''4}
slbT = \repeat unfold 4 \slT
slbS = \repeat unfold 4 \slS

trumpet = \transpose bes d \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  R1*8

  R1*2 f4 f8 f e4 e8 e | d4 d8 d c d4. |
  g,4. g8 r2 | r1 | f'4 f8 f e4 e8 e | d4 d8 d c d4 e8 |

  f2. r8 cis | d2. r8 fis | g2. r8 f | e2. r8 e |
  f2. r8 cis | d2. r8 e | f4. f8 g4. g8 | a4. a8 b4. b8

  g,4. g8 r2 | r1 | f'4 f8 f e4 e8 e | d4 d8 d c d4. |
  g,4. g8 r2 | r1 | f'4 f8 f e4 e8 e | d4 d8 d c d4. |

  g,4. g8 r2 | r1 | f'4 f8 f e4 e8 e | d4 d8 d c d4 e8 |

  f2. r8 cis | d2. r8 fis | g2. r8 f | e2. r8 e |
  f2. r8 cis | d2. r8 e | f4. f8 g4. g8 | a4. a8 b4. b8

  g,4. g8 r2 | r1 | f'4 f8 f e4 e8 e | d4 d8 d c d4. |
  g,4. g8 r2 | r1 | f'4 f8 f e4 e8 e | d4 d8 d c d4. |

  R1*4

  g4. g8 r2 | r1 | f4 f8 f e4 e8 e | d4 d8 d c d4. |
  g,4. g8 r2 | r1 | f'4 f8 f e4 e8 e | d4 d8 d c d4. |
}

altoSax = \transpose es d \relative c' {
  \global
  \set Staff.instrumentName = #"Baritone Sax"

  R1*8

  R1*2 f4 f8 f e4 e8 e | d4 d8 d c d4. |
  c4. c8 r2 | r1 | f4 f8 f e4 e8 e | d4 d8 d c d4 cis8 |

  d4. d8 r d r fis | g4. g8 r g r dis | e4. e8 r e r b' | a4. a8 r a r cis, |
  d4. d8 r d r fis | g4. g8 r g r cis, | d4. d8 e4. e8 | f4. f8 g g g g |

  c,4. c8 r2 | r1 | f4 f8 f e4 e8 e | d4 d8 d c d4. |
  c4. c8 r2 | r1 | f4 f8 f e4 e8 e | d4 d8 d c d4. |

  c4. c8 r2 | r1 | f4 f8 f e4 e8 e | d4 d8 d c d4 cis8 |

  d4. d8 r d r fis | g4. g8 r g r dis | e4. e8 r e r b' | a4. a8 r a r cis, |
  d4. d8 r d r fis | g4. g8 r g r cis, | d4. d8 e4. e8 | f4. f8 g g g g |

  c,4. c8 r2 | r1 | f4 f8 f e4 e8 e | d4 d8 d c d4. |
  c4. c8 r2 | r1 | f4 f8 f e4 e8 e | d4 d8 d c d4. |

  R1*4

  c4. c8 r2 | r1 | f4 f8 f e4 e8 e | d4 d8 d c d4. |
  c4. c8 r2 | r1 | f4 f8 f e4 e8 e | d4 d8 d c d4. |
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

tenorSax = \transpose bes es' \altoSax
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
