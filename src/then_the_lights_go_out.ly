#(ly:set-option 'relative-includes #t)
\version "2.18.0"
\include "lib.ly"

\header {
  title = "Then the Lights go Out"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
  ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \key f \major
  \clef "violin"
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 102
  \partial 4. s4.
  s1*0^"shuffle"
  s1*8 % intro
  s1*8 s1*1 % A, second ending
  \bar "||"
  s1*8 % B
  \bar "||"
  s1*6 % A
  \pCoda
  s1*2
  \pCoda
  s1*2 % Coda
  \bar "|."
}

remarks = \lyricmode {
  \partial 4. \skip 4.
  \skip 1*8
  \markupBox "1. Background (Thema), 2. Open Soli (Sax, others)" 1
  \skip 1*8
  \markupBox "1. Background (Thema), On Cue After Soli Background (Thema), to Coda"
}

chorusChords = \chordmode {
  f2:6 d:m7 g:m7 c:7 f:6 d:m7 g:m7 c:7
  f:6 f:7 bes b:dim f1:/c s1
  s2 f:7 % second ending
  bes2 b:dim f:/c f:7 bes2 b:dim f:/c f:7
  bes2 b:dim f:/c d:7 g1:7 c:7

  f2:6 d:m7 g:m7 c:7 f:6 d:m7 g:m7 c:7
  f:6 f:7 bes b:dim f1:/c s1
}

theChords = {
  \partial 4. s4.
  s1*8
  \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  \chorusChords
  \unset Score.proportionalNotationDuration
}

trumpetChords = \transpose c c \theChords
altoChords = \transpose f c \theChords

slTp = \relative c'' { e4 }
slAs = \relative c''' { a4 }
slbTp = \repeat unfold 4 \slTp
slbAs = \repeat unfold 4 \slAs

introLick = \relative c'' {
  r8 f, bes f as f r8 f | bes f as f
}

trumpet = \transpose c c \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  \partial 4. r4.
  \introLick r2 | \introLick r2 |
  \introLick r2 | \repeat unfold 4 \tuplet 3/2 {b8( c) c} | b8\turn bes as f r f \tuplet 3/2 {bes f as} |

  \repeat volta 2 {
    \repeat volta 2 {
      f4 r4 r2 | r2 r8 f \tuplet 3/2 {bes f as} | f4 r4 r2 | r2 r8 f \tuplet 3/2 {bes f as} |
      f4 r4 r2 | r2 r8 f \tuplet 3/2 {bes f as} | r1 |
    }
    \alternative {
      { r2 r8 f \tuplet 3/2 {bes f as} }
      { r1 }
    }
    r1 | r4 r8 f'\fall r2 | r1 | r4 f8 f~ f4 r4 |
    r1 | c4^- c8 d~ d2 | r1 | r2 r8 f, \tuplet 3/2 {bes f as}

    f4 r4 r2 | r2 r8 f \tuplet 3/2 {bes f as} | f4 r4 r2 | r2 r8 f \tuplet 3/2 {bes f as} |
    f4 r4 r2 | r2 r8 f \tuplet 3/2 {bes f as} | r1 | r1
  }
  r1^"rit." | es'4-.^"on cue" e-. f2\fermata
}

breaks = {
  \partial 4. s4.
  s1*8 \break
  s1*4 \break
  s1*5 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
}

altoSax = \transpose f c \relative c''' {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  \partial 4. r4.
  \transpose c, c {
    \introLick r2 | \introLick r2 |
    \introLick
  } r8 g as-. a r1 | r2 r8 f \tuplet 3/2 {bes f as} |

  \repeat volta 2 {
    \repeat volta 2 {
      f4 r4 r2 | r2 r8 f \tuplet 3/2 {bes f as} | f4 r4 r2 | r2 r8 f \tuplet 3/2 {bes f as} |
      f4 r4 r2 | r2 r8 f \tuplet 3/2 {bes f as} | r1 |
    }
    \alternative {
      { r2 r8 f \tuplet 3/2 {bes f as} }
      { r1 }
    }
    r1 | r4 r8 a\fall r2 | r1 | r4 c8 c~ c4 r4 |
    r1 | a4^- g8 fis~ fis2 | r1 | r2 r8 f \tuplet 3/2 {bes f as}

    f4 r4 r2 | r2 r8 f \tuplet 3/2 {bes f as} | f4 r4 r2 | r2 r8 f \tuplet 3/2 {bes f as} |
    f4 r4 r2 | r2 r8 f \tuplet 3/2 {bes f as} | r1 | r2 r2^"Pickup Solo"
  }
  r1^"rit." | b4-.^"on cue" bes-. a2\fermata
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

tenorSax = \transpose bes es \altoSax
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
