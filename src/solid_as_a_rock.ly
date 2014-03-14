#(ly:set-option 'relative-includes #t)
\include "lib.ly"

\header {
  title = "Solid as a Rock"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
}

global = {
  \time 4/4
  \clef "violin"
  \key as \major
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 148
  \partial 2. s2.
  s1*8 % intro
  s1*12 s1*2 % A
  \bar "||"
  s1*16
  \bar "||"
  s1*12
  s1*0^"play only if no choir"
  s1*12 % A
  s1*20
  \bar "|."

}

remarks = \lyricmode {
  \partial 2. \skip 2.
  \skip 1*8
  % \rightBreakMark \markup \box \fontsize #3 "2./3. to A"
}

chorusChords = \chordmode {

}

theChords = {
  \partial 2. s2.
  s1*8
  % \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  % \chorusChords
  % \unset Score.proportionalNotationDuration
}

trumpetChords = \transpose as c \theChords
altoChords = \transpose cis c \theChords

slTp = \relative c'' { e4 }
slAs = \relative c''' { a4 }
slbTp = \repeat unfold 4 \slTp
slbAs = \repeat unfold 4 \slAs

trumpetA = \relative c''' {
  r1 | r4 r8 es,8~^"wah wah mute" es4. c8\fall | r1 r
  r8 as'4.~ as4. r8 | r8 as4.~ as4. r8 | r8 as4.~ as4. r8 | r8 as4.~ as4. r8 |
  r8 as4.~ as4. r8 | r1
}

trumpet = {
  \transpose as c \relative c''' {
    \global
    \set Staff.instrumentName = #"Trumpet"
    \partial 2. r4 r2
    r1 r2 as4.^"wah wah mute" as8\fall | R1*4
    r8 as4. f4 es | ces8 bes as4 f2

    \repeat volta 2 {
      \trumpetA
    }
    \alternative {
      { as'2 f4 es | ces8 bes as4 f2 }
      { es'2 as4. as8 | as2 r }
    }

    r4 des~^"open" des4. d8\fall | R1*3
    r4 bes~ bes4. bes8\fall | R1*9
    r4 r8 c des es e f | r1

    \trumpetA as,1^"open" | as2. r4 |
  }
  \transpose gis c \relative c''' {
    \key a \major

    \repeat volta 2 {
      \transpose as a \trumpetA a2^"1st time only" fis4 e | c8 b a4 fis2
    }

    R1*4
    \repeat unfold 3 {r8 a'4.~ a4. r8}
    r8 a4.~ a4. r8^"open"
    R1*9
    r1^"rit."
    r2 a2^\markup \right-align \italic "\"...with me\"" \fermata | a2\fermata r2
  }
}


breaksTp = {
  % s1*8 \break
}

altoAFirst = \relative c'' {
  c2~ c4. as8\fall | r1 | r4 r8 f'8~ f4 es-. | ces-- as-. f-. as-. |
}

altoA = \relative c'' {
  \altoAFirst
  c2~ c4. as8\fall | r1 | c2~ c4. as8\fall | r1 |
  c2~ c4. as8\fall |
}

altoSax = {
  \transpose des c \relative c'' {
    \global
    \set Staff.instrumentName = #"Alto Sax"
    \partial 2. es,4-. f-. as-.
    c2~ c4. as8\fall | r1 | r4 r8 f'8~ f4 es-. | b-- as-. f-. as-. |
    c2~ c4. as8\fall | r2 f4-. as-. | as1 | r4 es-. f-. as-. |

    \repeat volta 2 {
       \altoA r2 des4-. c-. |
    }
    \alternative {
      { r1 | r4 es,-. f-. as-.}
      { r1 | des4. c8~ c4 r}
    }
    r4 f~f4. f8\fall | R1*3
    r4 des~des4. des8\fall | R1*3
    r2 r8 as a bes~ | bes4 as8 b8~ b4 as8 des~ | des4 r8 g bes as es c | bes c~ c4 bes-- c-- | f2 e | es d | des1 | r4 es,-. f-. as-. |

    \altoA | r2 des4-- c-- | des1 | c2. r4 |
  }
  \transpose cis c \relative c'' {
    \key a \major

    \repeat volta 2 {
      \transpose as a \altoA r2 d4-. cis-. | r1 | r4 e,-.^"play ending" fis-. a-.
    }
    \transpose as a \altoAFirst | r2 fis4 a8 c~ | c a8~ a4 r2 |
    r2 fis4 a8 c~ | c a8~ a4 r2 | R1*2
    e2 fis4 a8 c~ | c a8~ a4 r2 | R1*2
    e2 fis4 a8 c~ | c a8~ a4 r2 | r1 r^"rit."
    r2 d2^\markup \right-align \italic "\"...with me\"" \fermata | cis2\fermata r2

  }
}

breaksAs = {
  \partial 2. s2.
  s1*8
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
        \breaksTp
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
        \breaksAs
        \altoSax
      >>
    >>
  }
}
