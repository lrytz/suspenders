#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "The Golden Age"
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
  \tempo 4 = 112
  s1*0^\markupBox "Drum"
  s1 \bar "||"

  s1*0^\markupBox "Intro"
  s1*4

  s1*0^\markupBox "Verse"
  \pSegno
  s1*8 \bar "||"
  s1*0^\markupBox "Chorus"
  s1*9 \bar "||" % 2nd ending

  s1*0^\markupBox "Bridge"
  s1*8 \bar "||"
  \rightBreakMark \markupBox "D.S. (no repeat)"

  s1*0^\markupBox "Ending"
  s1*8 \bar "|."
}

breaks = {
  s1*5 \break

  s1*8 \break
  s1*9 \break

  s1*8 \break
}

remarks = \lyricmode {
}

turnChords = \chordmode {
}

chorusChords = \chordmode {
}

altoChords = \transpose es c {
}

trumpetChords = \transpose bes c {
}

slT = \absolute {a''4}
slS = \absolute {d''4}
slbT = \repeat unfold 4 \slT
slbS = \repeat unfold 4 \slS

trumpet = \transpose bes e \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  r1 R1*4

  \repeat volta 2 {
    f'4_"only on D.S." \fall r r2 R1*7
    \repeat unfold 7 { r4 a,8 r r4 bes8 r }
  }
  \alternative { {r4 a8 r bes8 bes bes bes} {r4 a8 r c4-- bes-- } }

  \repeat unfold 3 { r8 e,-- es16 des8 es16~ es bes16~ bes8 r4 }
  r8 e-- es16 des8 bes'16~ bes8 e,8 es16 des es des
  \repeat unfold 3 { r8 e-- es16 des8 es16~ es bes16~ bes8 r4 }
  des'4 d es e

  f4 \fall a,8 r r4 bes8 r \repeat unfold 7 { r4 a8 r r4 bes8 r }
}

altoSax = \transpose es e \relative c' {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  r1 R1*4

  \repeat volta 2 {
    c''4_"only on D.S." \fall r r2 R1*7
    \repeat unfold 3 { f,,8 r f' r r4 f8 es,-- | f r f' r r4 f8 as,-- } f8 r f' r r4 f8 es,--
  }
  \alternative { {f8 r f'8 r f8 f f f} {f,8 r f'8 r es4-- f4-- } }

  \repeat unfold 3 { r8 bes,-- as16 as8 bes16~ bes ges16~ ges8 r4 }
  r8 bes-- as16 as8 e'16~ e8 bes8 as16 ges as ges
  \repeat unfold 3 { r8 bes-- as16 as8 bes16~ bes ges16~ ges8 r4 }
  as'4 a bes b

  c4 \fall f,8 r r4 f8 r | r4 f8 r r4 f8 r \repeat unfold 3 { f,8 r f'8 r r4 f8 r | r4 f8 r r4 f8 r }
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
