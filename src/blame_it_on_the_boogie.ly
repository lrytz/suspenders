#(ly:set-option 'relative-includes #t)
\version "2.18.2"
\include "lib.ly"

\header {
  title = "Blame it on the Boogie"
  tagline = ""
}

\paper {
  markup-system-spacing #'padding = #3 %space after title
  ragged-last = ##t % don't stretch last line
}

global = {
  \time 4/4
  \clef "violin"
  \key es \major
  \set Score.skipBars = ##t % combine multi-rests
  \accidentalStyle "modern-voice-cautionary" % print some reduntant accidentals in parenthesis, e.g. (#)
}

structure = {
  \tempo 4 = 112
  % \partial 4. s4.
  s1*8 \bar "||" % intro

  s1*8 \bar "||" % verse simple
  s1*8 \bar "||" % chorus

  \pSegno
  s1*8 \bar "||" % verse (segno)
  s1*8 \bar "||" % chorus (to coda)
  \rightBreakMark \markupBox "To Coda"

  s1*0^\markup \fontsize #2 "Bridge"
  s1*8 \bar "||" % bridge
  s1*8 \bar "||" % chorus
  s1*4 % intro (dal segno)
  \rightBreakMark \markupBox "D.S. al Coda"

  s1*0^\markup {
    \fontsize #4
    \right-align
    \musicglyph #"scripts.coda"
  }
  s1*4 % breaks
  \leftMark \markupBox "On Cue"
  s1*8 \bar "||" % chorus
  s1*5 \bar "|."
}

remarks = \lyricmode {
}

turnChords = \chordmode {
}

chorusChords = \chordmode {
}

altoChords = \transpose es c {
  % s1*8
  % s1*12
  % s1*10 \turnChords % voc
  % s1*12 % voc
  % s1*12 % voc breaks
  % \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  % \chorusChords
  % \unset Score.proportionalNotationDuration
}

trumpetChords = \transpose bes c {
  % s1*8
  % s1*12 % horns
  % s1*12 % voc
  % s1*12 % voc
  % s1*12 % voc breaks
  % \set Score.proportionalNotationDuration = #(ly:make-moment 1 8 )
  % \chorusChords
  % \unset Score.proportionalNotationDuration
}

slT = \absolute {a''4}
slS = \absolute {d''4}
slbT = \repeat unfold 4 \slT
slbS = \repeat unfold 4 \slS

introTp = \relative c' {
  r1 | r8 c''8 r4 r2 | r8. es16 r4 r8. es,16 r4 | r16 es' as, bes c es c es r4 r16 d8. |
}

chorusTp = \relative c'' \repeat unfold 2 {
  r4 r16 bes'16 c8 es16 es r8 r4 | r1 | r4 r8 des r16 des16 r8 r4 | r4 r8 es r2
}

trumpet = \transpose bes e \relative c' {
  \global
  \set Staff.instrumentName = #"Trumpet"

  R1*4
  \introTp

  % verse simple
  es''4 r4 r2 | R1*2 | es,8. es16 r8 es~ es4 r | R1*3 | es8. es16 r8 es~ es4 r |

  % chorus
  \chorusTp

  % verse
  R1*2 | r2 r16 bes c8 es f | es8. es16 r8 es~ es4 r |
  r1 | r2 r4 es16 es r8 | r1 | es8. es16 r8 es~ es4 r 

  \chorusTp

  % bridge
  \repeat unfold 4 { g4 r g r | as r r8 as r16 as8. }
  \chorusTp
  \introTp

  %coda
  \repeat volta 2 R1*4

  %ending
  \chorusTp
  \introTp es'4 r r2
}

breaks = {
  s1*8 % intro

  s1*8 % verse simple
  s1*8 \break % chorus

  s1*8 % verse (segno)
  s1*8 \break % chorus (to coda)

  s1*8 % bridge
  s1*8 % chorus
  s1*4 \break % intro (dal segno)

  s1*4 % breaks
  s1*8 % chorus
}

introAs = \relative c {
  r1 | r8 f''8 r4 r2 | r8. es16 r4 r8. es,16 r4 | r16 es'' as, bes c es c as' r4 r16 b,8. |
}

chorusAs = \relative c'' \repeat unfold 2 {
  r4 r16 g'16 g8 bes16 bes r8 r4 | r1 | r4 r8 as r16 as16 r8 r4 | r4 r8 bes r2
}

altoSax = \transpose es e \relative c {
  \global
  \set Staff.instrumentName = #"Alto Sax"

  R1*4
  \introAs

  % verse simple
  c'''4 r4 r2 | R1*2 | as,8. as16 r8 g~ g4 r | R1*3 | bes8. bes16 r8 bes~ bes4 r |

  \chorusAs

  % verse
  R1*2 | r2 r16 bes c8 es f | as,8. as16 r8 g~ g4 r |
  r1 | r2 r4 bes16 bes r8 | r1 | bes8. bes16 r8 bes~ bes4 r 

  \chorusAs

  %bridge
  \repeat unfold 4 { bes4 r c r | c r r8 d r16 d8. }
  \chorusAs
  \introAs

  %coda
  \repeat volta 2 R1*4

  %ending
  \chorusAs
  \introAs c'4 r4 r2
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
    system-system-spacing #'basic-distance = #11 % increase space
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
    system-system-spacing #'basic-distance = #9 % increase space
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
    system-system-spacing #'basic-distance = #11
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
