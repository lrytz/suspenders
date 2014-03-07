\version "2.18.0"

\header {
  title = "All Of Me"
  tagline = ""
}

global = {
  \time 4/4
  \key des \major
  \clef "violin"
  \set Score.skipBars = ##t % combine multi-rests
}

% function that returns music
lyricsAbove = #(define-music-function
  (parser location lyrics)
  (ly:music?)
  #{
    \new Lyrics \with { \override VerticalAxisGroup.staff-affinity = #DOWN } $lyrics
  #})

% function that does not return music
markupBox = #(define-scheme-function
  (parser location text)
  (markup?)
  #{
    \markup { \box { #text } }
  #})

% right-aligned mark
rightMark = #(define-music-function
  (parser location text)
  (markup?)
  #{
    \once \override Score.RehearsalMark.self-alignment-X = #RIGHT
    \mark #text
  #})

% right-aligned mark in an end-of-line bar
rightBreakMark = #(define-music-function
  (parser location text)
  (markup?)
  #{
    \once \override Score.RehearsalMark.break-visibility = #end-of-line-visible
    \once \override Score.RehearsalMark.self-alignment-X = #RIGHT
    \mark #text
  #})



structureTp = {
  \tempo 4 = 176
  \partial 2..
  s2..
  \bar "||"
  s1*32 \bar "||" % instrumental
  s1*0^"Vocals" s1*32 % theme voc (fills clarinet)
  s1*32 % solo voc (fills trombone)
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
  \chordmode { es1:7 as:7 des s }
}

slTp = \relative c''' { as4 as as as }
slAs = \relative c'' { des4 des des des }

trumpet = \transpose bes c \relative c''' {
  \global
  \set Staff.instrumentName = #"Trumpet"
  \partial 2..
  as8 r as bes bes c4 |
  des as8 f~ f4 r | r2 \tuplet 3/2 {des'4 es des} | c a8 f~ f4 r | r1 |
  bes4 as8 f~ f4 r | r e8 f r ces' r bes | \tuplet 3/2 { as4 f ges~ } ges r | r1 |
  f4 e8 es~ es4 r | r2 \tuplet 3/2 { f4 a c } | es2~ es4 r8 des~ | des2 r2 |
  c4 b8 bes~ bes4 r | r bes es r8 des | c bes4.~ bes4 r8 c | r c~ c4 c c |
  des as8 f~ f4 r | r2 \tuplet 3/2 {des'4 es des} | c a8 f~ f4 r | r1 |
  bes4 as8 f~ f4 r | r e8 f r ces' r bes | \tuplet 3/2 { as4 f ges~ } ges r | r1 |
  es'2 des4 c8 es~ | es2 r4. des8 | r c4. f,8 as4 c8~ | c2 r4 bes |
  des2 bes4 des | f2 f2 | des1 | r1 |
  R1*32
  \slash
  \repeat volta 3 {
    \repeat unfold 13 \slTp as4 as \endSlash \tuplet 3/2 {r4 r des-.^"3rd time only"}  \tuplet 3/2 {des-. des-. des-.} \tuplet 3/2 {des-. des-. des-.} \tuplet 3/2 {f-. f-. f-.} as2 \slash
    \repeat unfold 12 \slTp \endSlash r8 des,~^"3rd time only" des4 bes des | f2 f2 | des4 r as'8 as g g | ges4 r8 f8~ f2 \rightBreakMark "Repeat 3x"
  }
  r8 des~ des4 bes des | r4 r8 des~ des4 f | as1~ | as4. es'8 r2 |
}

remarksTrumpet = \lyricmode {
  \skip 2..
  \skip 1*64
  \markupBox "1. Fills (Solo Voc), 2. Tacet (Solo Sax), 3. Thema (frei)" \skip 2
  \skip 1*15
  \markupBox "2. Solo"
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
  \repeat unfold 13 \slAs des4 des \endSlash \tuplet 3/2 {r4 r as'-.^"5th time only"}  \tuplet 3/2 {as-. as-. as-.} \tuplet 3/2 {as-. as-. as-.} \tuplet 3/2 {des-. des-. des-.} f2 \slash
  \repeat unfold 16 \slAs
  \rightBreakMark "Repeat 5x"
  }
  \repeat unfold 3 \slAs | des,4 des r2 |
  \endSlash
}

remarksAlto = \lyricmode {
  \skip 2..
  \markup \box { \column {
    \line { 1. Fills (Thema tp), 2. Fills (Thema voc),}
    \line { 3. Tacet, 4. Solo, 5. Fills (Thema tp) }
  } } \skip 2
  \skip 1*15
  \markupBox "4. Tacet"
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
  \bookOutputSuffix "tp"
  \paper {
    system-system-spacing #'basic-distance = #11 % fit on page
  }
  \score {
    <<
      \lyricsAbove \remarksTrumpet
      \new ChordNames \trumpetChords
      \new Staff = "trumpet" <<
        \structureTp
        \breaksTrumpet
        \trumpet
      >>
    >>
  }
}
\book {
  \bookOutputSuffix "as"
  \paper {
    markup-system-spacing #'padding = #3
  }
  \markup { \vspace #1 } % space after title
  \score {
    <<
      \lyricsAbove \remarksAlto
      \new ChordNames \altoChords
      \new Staff = "altoSax" <<
        \structureAs
        \breaksAlto
        \altoSax
      >>
    >>
  }
}
