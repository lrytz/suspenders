#(ly:set-option 'relative-includes #t)
\include "lib.ly"

\header {
  title = "A Little Bird Told Me"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
  ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key bes \major
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 208
  \leftMark \markupBox "Intro Piano"
  s1*4 \bar "||"
  \leftMark \markupBox "Voc AABA"
  s1*32 \bar "||"

  \leftMark \markupBox "Voc A + half A"
  s1*12 \bar "||"

  \leftMark \markupBox "Bridge, break"
  s1*12 \bar "||"

  \leftMark \markupBox "Choir AA"
  s1*16 \bar "||"

  \leftMark \markupBox "Bridge, break"
  s1*12 \bar "||"

  \leftMark \markupBox "Voc A"
  s1*8 \bar "||"
  \leftMark \markupBox "Turnaround"
  s1*8 \bar "||"

  s1*2
  s1*4 \bar "|." % horns
}

remarks = \lyricmode {
}

theChords = \chordmode {
}

altoChords = \transpose c c \theChords

trumpetChords = \transpose c c \theChords

slT = \absolute {a''4}
slS = \absolute {d''4}
slbT = \repeat unfold 4 \slT
slbS = \repeat unfold 4 \slS

pauseses = {
  R1*4
  R1*32
  R1*12
  R1*12
  R1*16
  R1*12
  R1*8
  R1*8
  R1*2
}

breaks = {
  s1*4 \break
  s1*32 \break
  s1*12 \break
  s1*12 \break
  s1*16 \break
  s1*12 \break
  s1*8 \break
  s1*8 \break
  s1*2
}

ending = {
  r8 bes4. as8 bes4. | g8 es f ges~ ges4 r4 |
  r8 bes4. g8-. a \tuplet 3/2 {bes c cis} | d4 f,8 bes~ bes2
}

trumpet = \transpose g c \relative c''' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  \pauseses
  \ending
}

altoSax = \transpose c c \relative c'' {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  \pauseses
  \ending
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
