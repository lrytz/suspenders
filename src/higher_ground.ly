#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "Higher Ground"
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
  \tempo 4 = 116
  s1*4^\markupBox "Intro Keys" s1*8^\markupBox "Band" \bar "||" \break
  s1*32^\markupBox "Verse" \break
  s1*8^\markupBox "Chorus" s1*3 s1 \break
  s1*4^\markupBox "Ending"
}

remarks = \lyricmode {
}

theChords = \chordmode {
  e2:7 g4 a e2:7 g4 a e2:7 g4 a e2:7 g4 a
  cis2:7.11+ d:7 c:6 g4/a a/b e2:7 g4 a e2:7 g4 a
  a1/b g2/a f4/g g/a e2:7 g4 a e2:7 g4 a
  e2:7 g4 a e2:7 g4 a
  s1*6
  cis2:7.11+ d:7 c:6 g4/a a/b
  e2:7 g4 a e2:7 g4 a e2:7 g4 a e2:7 g4 a
 }

altoChords = {} % \transpose es c { s1*8 \theChords }

trumpetChords = {} % \transpose bes c { s1*8  \theChords }

trioleTp = \relative c''' {
  \tuplet 3/2 { r8 des-. es-. } \tuplet 3/2 { ges( es) des-. } \tuplet 3/2 { bes( as) ges-. }
}

lickTp = \relative c''' {
  \trioleTp
  r4 r8 bes'~ bes4 r
  r4 \trioleTp
  r4 \tuplet 3/2 { r8 r des, } \tuplet 3/2 { r bes r } \tuplet 3/2 { as4\turn ges8 }}

trioleAs = \relative c'' {
  \tuplet 3/2 { r8 ges-. as-. } \tuplet 3/2 { bes( as) ges-. } \tuplet 3/2 { es( des) bes-. }
}

lickAs = \relative c'' {
  \trioleAs
  r4 r8 ges'~ ges4 r
  r4 \trioleAs
  r4 \tuplet 3/2 { r8 r des } \tuplet 3/2 { r bes r } \tuplet 3/2 { as4\turn ges8 }}


trumpet = \transpose bes g, \relative c''' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  R1*12

  \repeat volta 2 {
    \repeat unfold 2 {
      R1*12
      r4 \lickTp
    }
    R1*4 as'4 as as8 ges es des es des \tuplet 3/2 { bes as bes } r2
    r2 r4 r8 as'~ as as~ as as~ as ges es des
    es r \lickTp
  }

  \repeat volta 2 {
    r4 \lickTp
  }
}


altoSax = \transpose es g \relative c'' {
  \global
  \set Staff.instrumentName = #"Alto Sax"

  R1*12

  \repeat volta 2 {
    \repeat unfold 2 {
      R1*12
      r4 \lickAs
    }
    R1*4 es4 es es8 des bes as bes as \tuplet 3/2 { ges es ges } r2
    r2 r4 r8 es'~ es es~ es es~ es des bes as
    bes r \lickAs
  }

  \repeat volta 2 {
    r4 \lickAs
  }

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
    system-system-spacing #'basic-distance = #20 % increase space
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
    system-system-spacing #'basic-distance = #20 % increase space
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
    system-system-spacing #'basic-distance = #20
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
