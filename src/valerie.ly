#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "Valerie"
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
  \tempo 4 = 106

  \leftMark \markupBox "Intro"
  s1*4 % intro

  \leftMark \markupBox "On Cue"
  s1*8 % verse a
  \pSegno
  s1*8 \bar "||" % verse b
  s1*8 \bar "||" % chorus
  \rightBreakMark \markupBox "3rd to Coda"
  s1*8 \bar "||" % verse c
  s1*8 % verse d

  \pCoda
  s1*8 \bar "||" % chorus

  s1 \bar "|."
}

breaks = {
  s1*4

  s1*8

  s1*8
  s1*8 \break
  s1*8 \break
  s1*8 \break
}

remarks = \lyricmode {
}

turnChords = \chordmode {
}

chorusChords = \chordmode {
}

altoChords = \transpose es c {
  % s1*8
  % s1*12
  % s1*10 \turnChords % voc
  % s1*12 % voc
  % s1*12 % voc breaks
  % \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  % \chorusChords
  % \unset Score.proportionalNotationDuration
}

trumpetChords = \transpose bes c {
  % s1*8
  % s1*12 % horns
  % s1*12 % voc
  % s1*12 % voc
  % s1*12 % voc breaks
  % \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  % \chorusChords
  % \unset Score.proportionalNotationDuration
}

slT = \absolute {a''4}
slS = \absolute {d''4}
slbT = \repeat unfold 4 \slT
slbS = \repeat unfold 4 \slS

trumpet = \transpose bes a \relative c' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  \repeat volta 2 R1*4
  R1*8

  \repeat volta 3 {

    c'1 | bes2. r4 | c2. d4 | bes2. r4 | c1 | bes2. r4 | 
    <<
     {  d2^\markup "3rd" es | f2. } \\
     {  d1_\markup "1st, 2nd"~ | d2. }
    >> r4

    \repeat unfold 2 {
      \repeat unfold 2 { r8 g, r g g16 as8 bes16 r4 }
      \repeat unfold 2 { r8 as r as as16 bes8 c16 r4 }
    }

    R1*8 \rightBreakMark \markupBox "2nd D.S."
    \repeat unfold 2 {
      \repeat unfold 2 { r8 g r4 r2 }
      \repeat unfold 2 { r8 as r4 r2 }
    }
  }

  \repeat unfold 2 {
    \repeat unfold 2 { r8 bes r bes bes16 c8 d16 r4 }
    \repeat unfold 2 { r8 c r c c16 d8 es16 r4 }
  }

  d1 \fermata
}


altoSax = \transpose es a \relative c'' {
  \global
  \set Staff.instrumentName = #"Baritone Sax"

  \repeat volta 2 R1*4
  R1*7 | r2 r4 r8 g(

  \repeat volta 3 {
    as2.) r8 as | g2. r8 g | as2. bes4 | g2. r8 g | as2. r8 as | g2. r4 | bes1~ | bes2. r4 |

    \repeat unfold 2 {
      \repeat unfold 2 { r8 es, r es es16 f8 g16 r4 }
      \repeat unfold 2 { r8 f r f f16 g8 as16 r4 }
    }

    R1*7 | r2 r4 r8 << bes^\markup "1st" \\ g_\markupBox "2nd, D.S." >> |

    es8-. es r4 r4 r8 bes'( | es,-.) es r4 r4 r8 e( | f-.) f r4 r4 r8 e | f-. f r4 r4 r8 bes |
    es,8-. es r4 r4 r8 bes' | es,-. es r4 r4 r8 e | f-. f r4 r4 r8 e | f-. f r4 r4 r8 g |
  }

  \repeat unfold 2 {
    \repeat unfold 2 { r8 g r g g16 as8 bes16 r4 }
    \repeat unfold 2 { r8 as r as as16 bes8 c16 r4 }
  }

  g1 \fermata
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
    % system-system-spacing #'basic-distance = #15 % increase space
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
  \bookOutputSuffix "bs"
  \paper {
    % system-system-spacing #'basic-distance = #11 % increase space
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
    % system-system-spacing #'basic-distance = #16
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
