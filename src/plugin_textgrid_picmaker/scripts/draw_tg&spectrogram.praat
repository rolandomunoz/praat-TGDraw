# Created by Rolando Munoz (2018-09-19)

include ../procedures/select_viewport.proc

form TextGrid & Spectrogram: Draw...
  sentence Draw_Tiers 1
  comment Spectrogram settings...
  real left_Time_range_(s) 0.0
  real right_Time_range_(s) 0.0 (=all)
  real left_Frequency_range_(Hz) 0.0
  real right_Frequency_range_(Hz) 5000
  real Dynamic_range_(Db) 50.0
  boolean Show_boundaries 1
  boolean Use_text_styles 1
  boolean Garnish 1
endform

tg= selected("TextGrid")
spectrogram=selected("Spectrogram")

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

# Draw
if garnish
  Text left: "yes", "Frequency (Hz)"
endif

# Paint something
selectObject: spectrogram
@selectDrawArea
Paint: left_Time_range, right_Time_range, left_Frequency_range, right_Frequency_range, 100, "yes", dynamic_range, 6, 0, "no"

if garnish
  Marks left every: 1, 1000, "yes", "yes", "no"
  One mark left: right_Frequency_range, "yes", "yes", "no", ""
  One mark left: left_Frequency_range, "yes", "yes", "no", ""
endif

# Draw TextGrid
selectObject: tgDraw
@selectTextGrid
Draw: left_Time_range, right_Time_range, show_boundaries, use_text_styles, garnish

removeObject: tgTier#, tgDraw
selectObject: tg, spectrogram
