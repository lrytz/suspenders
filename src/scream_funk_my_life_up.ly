#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "Scream (Funk my Life up)"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
  ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key b \major
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 112
  s1*4 %intro

  % repeated
  s1*0^\markupBox "Verse"
  s1*8 \bar "||"
  s1*0^\markupBox "Chorus"
  s1*4

  s1*0^\markupBox "Interlude 1"
  s1*6 \bar "||"
  s1*0^\markupBox "Pre-Chorus"
  s1*4 \bar "||"

  s1*0^\markupBox "Chorus"
  s1*4 \bar "||"
  s1*2 \bar "||"

  s1*0^\markupBox "Interlude 2"
  s1*9 \bar "||"

  s1*0^\markupBox "Pre-Chorus"
  s1*6 \bar "||"

  s1*0^\markupBox "Chorus"
  s1*8 \bar "||"

  s1*2 \bar "|."
}

breaks = {
  % s1*8 % intro

  % s1*8 % verse simple
  % s1*8 \break % chorus

  % s1*8 % verse (segno)
  % s1*8 \break % chorus (to coda)

  % s1*8 % bridge
  % s1*8 % chorus
  % s1*4 \break % intro (dal segno)

  % s1*4 % breaks
  % s1*8 % chorus
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

verseTp = \relative c' \repeat unfold 4 {
  r8 fis~ fis16 gis r8 a8. gis16 r8 fis | gis16 fis8 d16 r4 r2
}

chorusTp = \relative c'' {
  b2 ais | a gis4. gis8 | fis8 r r4 r2 | r1
}

trumpet = \transpose bes bes \relative c' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  R1*4

  \repeat volta 2 {
    \verseTp
    \chorusTp
  }
  \repeat unfold 3 { r8 b' b, r r2 | r1 }
  \chorusTp
  \chorusTp R1*2
  R1*3 r2 r4 gis''16 fis8 d16 | r1 | a16 b8 d16~ d e8 f16~ f fis r8 gis16 fis8 d16 | r1 | r2 r4 gis16 gis8 fis16 | r1
  \repeat unfold 2 { b,2 ais | a r } b d e1
  b'2. d8 b | a2. r8 d8-- | b8^. r r4 r r8 r16 fis, | a16 b8 d16~ d e8 f16~ f fis8 fis16 a fis a8 |
  b2. d8 b | a2. r8 d8-- | b8^. r r4 r2 | r1 | b,8 r r4 r2 | r1
}

verseAs = \relative c' \repeat unfold 4 {
  r8 b~ b16 cis r8 d8. cis16 r8 b | cis16 b8 fis16 r4 r2
}

chorusAs = \relative c' {
  dis2 cis | cis b4. d8 | b8 r r4 r2 | r1
}

altoSax = \transpose es bes \relative c {
  \global
  \set Staff.instrumentName = #"Alto Sax"

  R1*4

  \repeat volta 2 {
    \verseAs
    \chorusAs
  }
  \repeat unfold 3 { r8 b' b, r r2 | r1 }
  \chorusAs
  \chorusAs R1*2
  R1*3 r2 r4 d''16 cis8 b16 | r1 | d,16 e8 fis16~ fis a8 b16~ b d r8 d16 cis8 b16 | r1 | r2 r4 d16 d8 b16 | r1
  \repeat unfold 2 { fis2 fis | e r } fis a a1
  fis'2. a8 fis | e2. r8 a8-- | fis8^. r r4 r r8 r16 b,, | d16 e8 fis16~ fis a8 b16~ b d8 b16 d b d8 |
  fis2. a8 fis | e2. r8 a8-- | fis8^. r r4 r2 | r1 | fis,8 r r4 r2 | r1
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
tenorChords = \transpose bes es' \altoChords
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
