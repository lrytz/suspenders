\version "2.18.0"

\header {
  title = "All Of Me"
}

global = {
  \time 4/4
  \key des \major
  \clef "violin"
  \set Score.skipBars = ##t % combine multi-rests
}

structureTp = {
  \tempo 4 = 176
  \partial 2..
  s2..
  \bar "||"
  s1*32 \bar "||" % instrumental
  s1^"Vocals" s1*31 %\bar "||" % theme voc (fills clarinet)
  s1*32 %\bar "||" % solo voc (fills trombone)
  s1*4  \bar "|."
}

structureAs = {
  \tempo 4 = 176
  \partial 2..
  s2..
  s1*32
  s1*4  \bar "|."
}

slash = {
  \override NoteHead.style = #'slash
  \hide Stem
}
endSlash = {
  \revert NoteHead.style
  \undo \hide Stem
}

theChords = \chordmode {
  \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  des1 s f:7 s
  bes:7 s es:m s
  f:7 s bes:m s
  es:7 s as:7 s
  des1 s f:7 s
  bes:7 s es:m s
  ges ges:m f:m bes:7
  es:7 as:7 des s
  \unset Score.proportionalNotationDuration
}

trumpetChords = \transpose bes c {
  s2..
  s1*32
  s1*32
  \theChords
}
altoChords = \transpose es c {
  s2..
  \theChords
  \chordmode { es:7 as:7 des s }
}

slTp = \relative c''' { as4 as as as }
slAs = \relative c'' { des4 des des des }

trumpet = \transpose bes c \relative c''' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  \partial 2..
  as8 r as bes bes c4 |
  des as8 f~ f4 r | r2 \tuplet 3/2 {des'4 es des} | c a8 f~ f4 r | r1 |
  bes4 as8 f~ f4 r | r e8 f r ces' r bes | \tuplet 3/2 { bes4 f ges~ } ges r | r1 |
  f4 e8 es~ es4 r | r2 \tuplet 3/2 { f4 a c } | es2~ es4 r8 des~ | des2 r2 |
  c4 b8 bes~ bes4 r | r bes es r8 des | c bes4.~ bes4 r8 c | r c~ c4 c c |
  des as8 f~ f4 r | r2 \tuplet 3/2 {des'4 es des} | c a8 f~ f4 r | r1 |
  bes4 as8 f~ f4 r | r e8 f r ces' r bes | \tuplet 3/2 { bes4 f ges~ } ges r | r1 |
  es'2 des4 c8 es~ | es2 r4. des8 | r c4. f,8 as4 c8~ | c2 r4 bes |
  des2 bes4 des | f2 f2 | des1 | r1 |
  R1*32
  \slash
  \repeat volta 3 {
    as4^"1. Fills (Solo Voc), 2. Solo Sax, 3. Thema (frei)" as as as \repeat unfold 12 \slTp as as \endSlash \tuplet 3/2 {r4 r des-.^"3rd time"}  \tuplet 3/2 {des-. des-. des-.} \tuplet 3/2 {des-. des-. des-.} \tuplet 3/2 {f-. f-. f-.} as2 \slash
    as,4^"2. Solo" as as as \repeat unfold 11 \slTp \endSlash r8 des~^"3rd time" des4 bes des | f2 f2 | des4 r as'8 as g g | ges4 r8 f8~ f2^"repeat 3x" |
  }
  r8 des~ des4 bes des | r4 r8 des~ des4 f | as1~ | as4. es'8 r2 |
}

breaksTrumpet = {
  s2..
  s1*4  \break
  s1*7  \break
  s1*7  \break
  s1*7  \break
  s1*39 \break
  s1*4  \break
  s1*4  \break
  s1*4  \break
  s1*4  \break
  s1*4  \break
  s1*4  \break
  s1*4  \break
  s1*4  \break
}

altoSax = \transpose es c \relative c''   {
  \global
  \set Staff.instrumentName = #"Alto Sax"
  \partial 2..
  r8 r4 r2 |
  \slash
  \repeat volta 5 {
  des4^"1. Fills (Thema tp), 2. Fills (Thema voc), 3. Tacet, 4. Solo, 5. Fills (Thema tp)" des des des | \repeat unfold 12 \slAs des des \endSlash \tuplet 3/2 {r4 r as'-.^"5th time"}  \tuplet 3/2 {as-. as-. as-.} \tuplet 3/2 {as-. as-. as-.} \tuplet 3/2 {des-. des-. des-.} f2 \slash
  des,4^"4. Tacet" des des des | \repeat unfold 14 \slAs des des des des^"repeat 5x"
  }
  \repeat unfold 3 \slAs | des4 des r2 |
  \endSlash
}

breaksAlto = {
  s2..
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
  s1*4 \break
}

\book {
%   \bookOutputSuffix "tp"
  \score {
    <<
      \new ChordNames \trumpetChords
      \new Staff = "trumpet" <<
        \structureTp
        \breaksTrumpet
        \trumpet
      >>
    >>
  }
% }
% \book {
%   \bookOutputSuffix "as"
  \score {
    <<
      \new ChordNames \altoChords
      \new Staff = "altoSax" <<
        \structureAs
        \breaksAlto
        \altoSax
      >>
    >>
  }
}
