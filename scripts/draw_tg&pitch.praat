# Created by Rolando Munoz (2018-09-19)

include ../procedures/select_viewport.proc

form TextGrid & Spectrogram: Draw...
  sentence Draw_Tiers 1
  comment Pitch settings...
  real left_Time_range_(s) 0.0
  real right_Time_range_(s) 0.0 (=all)
  real left_Frequency_range_(Hz) 80
  real right_Frequency_range_(Hz) 600
  boolean Left_marks 0
endform

tg= selected("TextGrid")
pitch= selected("Pitch")

tierList#= {'draw_Tiers$'}
nTiers= size(tierList#)
tgTier#= zero# (nTiers)

for i to nTiers
  selectObject: tg
  tgTier# [i]= Extract one tier: tierList# [i]
endfor

selectObject: tgTier#
tgDraw= Merge
@textGrid2viewport: nTiers

# Paint something
selectObject: pitch
@selectDrawArea
Draw: left_Time_range, right_Time_range, left_Frequency_range, right_Frequency_range, "no"

if left_marks
  Marks left every: 1, 20, "yes", "yes", "yes"
endif
One mark left: right_Frequency_range, "yes", "yes", "no", ""
One mark left: left_Frequency_range, "yes", "yes", "no", ""
Text left: "yes", "Frequency (Hz)"

# Draw TextGrid
selectObject: tgDraw
@selectTextGrid
Draw: left_Time_range, right_Time_range, "yes", "yes", "yes"

removeObject: tgTier#, tgDraw
selectObject: tg, pitch
