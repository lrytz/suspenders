#(ly:set-option 'relative-includes #t)
\include "lib.ly"

\header {
  title = "Bei Mir Bist Du Schön"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
}

global = {
  \time 4/4
  \key a \minor
  \clef "violin"
  \set Score.skipBars = ##t % combine multi-rests
}

structure = {
  \tempo 4 = 150
  \partial 4.
  s4.
  % markup here because it should not break the multi-rests,
  % which it would do in lyricmode (below)
  s1*0^\markupBox "Intro Piano"
  s1*16 \bar "||" % intro piano
  \pSegno
  s1*12 \pCoda
  s1*20
  s1*32           % chords (gesang, soli, gesang)
  \rightBreakMark "Repeat 4x, D.S. al Coda"
  % the coda sign cannot be placed using \mark (can't have two marks in a row)
  s1*0^\markup { \right-align \fontsize #4 \musicglyph #"scripts.coda" }
  s1*4            % coda
}

remarks = \lyricmode {
  \skip 4.
  \skip 1*16
  \skip 1*32
  % markup here because it needs to be above chords
  \markupBox "1. Tacet (Thema), 2. Solo as, 3. Solo tp / piano (share), 4. Fills tutti (Thema)" 1
  \skip 1*15
  \markupBox "1. Fills tutti"
  \skip 1*7
  \markupBox "1. Tacet"
}

chorusChords = \chordmode {
  a1:m s s s
  e:7 s a:m f2:7 e:7
  a1:m s s s
  e:7 s a:m s
  d:m s a:m s
  d:m dis:dim7 e:7 s
  a:m s s s
  e:7 s a:m e:7
}

theChords = {
  \partial 4.
  s4.
  s1*16
  \chorusChords
  \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  \chorusChords
  \unset Score.proportionalNotationDuration
}

trumpetChords = \transpose c c  \theChords % TODO transpose
altoChords = \transpose c c \theChords % TODO transpose

slTp = \relative c'' { a4 a a a }
slAs = \relative c'' { d4 d d d }

trumpet = \transpose c c \relative c'' { % TODO transpose
  \global
  \set Staff.instrumentName = #"Trumpet"
  \partial 4.
  r8 r4
  R1*15 r2 r4 a^\markup { \center-align Plunger } |
  c2 b4 a8 c | r2 r4 a | c2 b4 a8 e | r2 r4 e~ |
  e2 r | r4 e c'2 \glissando | a4 r r2 | r2 r4 a |
  c2 b4 a8 c |  \tuplet 3/2 {r4 r e-+} \tuplet 3/2 {e-0 e-+ e-0} | r2 e8 c a gis | a4 r r a | gis2 e | r8 e dis e c'2 \glissando | a4 r r2 | r4 a^"Open" b c |
  d4. a8~ a4 d~ | d8 c8~ c4 r2 | a8 a e a r4 g8 g | a a g a r4 a |
  d4. a8~ a4 d~ | d8 c8~ c4 r2 | e4 e e e | e e e a,^\markup { \center-align Plunger } |
  c2 b4 a8 c | r2 r4 a | c2 b4 a8 e | r2 r4 e~ |
  e2 r | r8 e dis e c'2 \glissando | a16 fis8.~ fis4 r2 | r1 |
  \repeat volta 4 {
    \slash
    \repeat unfold 16 \slTp
    \endSlash
    <<
    { \voiceOne a1_"3. only (Solo as)"( | a) | a( | a2) r | a1( | a) | b1 | b2 r2 }
    { \voiceTwo f1( | f) | e( | e2) r | f1( | fis) | gis1( | gis2) r2 }
    >>
    \oneVoice
    \slash
    \repeat unfold 7 \slTp
    a4 a a \endSlash a_"On D.S."
  }
  % coda
  gis2 e | c' b | r8 e dis e f fis g gis | a4 r fis,2 \fermata |
}

breaksTp = {
  \partial 4.
  s4.
  s1*16
  s1*32 \break
  s1*4  \break
  s1*4  \break
  s1*4  \break
  s1*4  \break
  s1*4  \break
  s1*4  \break
  s1*4  \break
  s1*4  \break
}

altoSax = \transpose c c \relative c'' { % TODO transpose
  \global
  \set Staff.instrumentName = #"Alto Sax"
  \partial 4.
  r8 r4
  R1*15 r2 r4 c |
  e2^"Add Fills" d4 c8 e | r2 r4 c | e2 d4 c8 a | r1 |
  r4 d8 c b d c b | c gis a gis e'4. d8 | c4 r4 r2 | r2 r4 c |
  e2 d4 c8 e | r2 r4 c | e2 d4 c8 a | r1 |
  gis2 a4 b | c r e4. d8 | c4 c8 d e g g4 | g r r2 |
  \slash \repeat unfold 6 \slAs \endSlash r1 | r2 r4 c, |
  e2 d4 c8 e | r2 r4 c | e2 d4 c8 a | r1 |
  d8 d c4 c b | b r e4. d8 | c4 r4 r2 | r1

  \repeat volta 4 {
    \slash
    \repeat unfold 31 \slAs
    d4 d d \endSlash c_"On D.S."
  }
  % coda
  gis2 e | c' b | r8 e dis e dis d cis b | c4 r cis2 \fermata |
}

breaksAs = {
  \partial 4.
  s4.
  s1*16
  s1*32 \break
  s1*4  \break
  s1*4  \break
  s1*4  \break
  s1*4  \break
  s1*4  \break
  s1*4  \break
  s1*4  \break
  s1*4  \break
}

% \book {
%   \score {
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
    % fit on one page
    system-system-spacing = #'(
      (basic-distance . 10)
      (minimum-distance . 0)
      (padding . 0)
      (stretchability . 0))
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
    % fit on one page
    system-system-spacing = #'(
      (basic-distance . 11)
      (minimum-distance . 0)
      (padding . 0)
      (stretchability . 0))
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
