#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "Baila Morena"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #4 %space after title
  % ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key es \major
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 120
  s1*8^\markupBox "Intro"
  s1*8^\markupBox "Verse" \break

  s1*4^\markupBox "Interlude Git" \break   % start repeat

  s1*8^\markupBox "Verse"
  s1*8^\markupBox "Pre-Chorus" \break

  s1*8^\markupBox "Chorus" \break          % end repeat
  s1*8 \break

  s1*8^\markupBox "Solo Git"
  s1*8^\markupBox "Bridge" \break

  s1*8^\markupBox "Chorus" \break
  s1*8 \break

  s1*8^\markupBox "Ending"
}

remarks = \lyricmode {
}

% theChords = \chordmode { ges1 ces ges des ges ces ges2 ces2:6 ges1 }

altoChords = {} % \transpose es a { s1*32 \theChords }

trumpetChords = {} % \transpose bes a { s1*32  \theChords }


tpChorus = \relative c''' { as1 des c bes as1 des c bes }

asChorus = \relative c'' { f1 f es es f1 f es es }

trumpet = \transpose bes c \relative c'' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  
  R1*8
  R1*8
  \repeat volta 2 {
    R1*4
    R1*8
    R1*8
    \tpChorus
  }
  \tpChorus

  R1*8
  R1*8

  \tpChorus
  \tpChorus

  R1*8
}


altoSax = \transpose es c \relative c' {
  \global
  \set Staff.instrumentName = #"Alto Sax"

  R1*8
  R1*8
  \repeat volta 2 {
    R1*4
    R1*8
    R1*8
    \asChorus
  }
  \asChorus

  R1*8
  R1*8

  \asChorus
  \asChorus

  R1*8
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
    system-system-spacing #'basic-distance = #15
  }
  \score {
    <<
      \lyricsAbove \remarks
      \new ChordNames \tenorChords
      \new Staff = "tenorSax" <<
        \structure
        \tenorSax
      >>
    >>
  }
}
