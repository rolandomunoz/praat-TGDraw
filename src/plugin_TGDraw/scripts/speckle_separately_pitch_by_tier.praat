# Created by Rolando Munoz (2018-09-19)

form TextGrid & Pitch: Draw separately by tier...
  sentence Draw_Tiers 1
  real left_Time_range_(s) 0.0
  real right_Time_range_(s) 0.0 (=all)
  real left_Frequency_range_(Hz) 0.0
  real right_Frequency_range_(Hz) 500.0
  boolean Show_boundaries 1
  boolean Use_text_styles 1
  boolean Garnish 1
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

# Paint something
selectObject: pitch
selectObject: tgDraw, pitch
Speckle separately: left_Time_range, right_Time_range, left_Frequency_range, right_Frequency_range, show_boundaries, use_text_styles, garnish

selectObject: tg, pitch
removeObject: tgTier#, tgDraw
