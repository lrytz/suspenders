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
  \tempo 4 = 202
  \leftMark \markupBox "Intro Piano"
  s1*4 \bar "||"
  \leftMark \markupBox "Voc AABA"
  s1*32 \bar "||"

  \leftMark \markupBox "Voc A + half A"
  s1*12 \bar "||"

  \leftMark \markupBox "Bridge, break"
  s1*12

  \leftMark \markupBox "Open Soli"
  s1*16

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

soloChords = \chordmode {
  \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  bes1 s s s c:7 g:7 bes2 c:m7 bes:6/f c:m7
  \unset Score.proportionalNotationDuration
}

theChords = \chordmode {
  s1*4 s1*32 s1*12 s1*12 \soloChords \soloChords
}

trumpetChords = \transpose f c \theChords

altoChords = \transpose bes c \theChords

slT = \absolute {a''4}
slS = \absolute {d''4}
slbT = \repeat unfold 4 \slT
slbS = \repeat unfold 4 \slS

pauseses = {
  R1*4
  R1*32
  R1*12
  R1*12
  \repeat volta 2 R1*16
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
  s1*4 \break s1*4 \break s1*4 \break s1*4 \break % solo
  % s1*16 \break
  s1*12 \break
  s1*8 \break
  s1*8 \break
  s1*2
}

ending = {
  r8 bes4. as8 bes4. | g8 es f ges~ ges4 r4 |
  r8 bes4. g8-. a \tuplet 3/2 {bes c cis} | d4 f,8 bes~ bes2
}

trumpet = \transpose f c \relative c''' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  \pauseses
  \ending
}

altoSax = \transpose bes, c \relative c'' {
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
    system-system-spacing #'basic-distance = #14 % increase space
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
