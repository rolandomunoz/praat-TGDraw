# Created by Rolando Munoz (2018-09-19)

include ../procedures/select_viewport.proc

form TextGrid & Spectrogram: Draw (segment duration)...
  sentence Draw_Tiers 1
  comment Get duration from...
  natural Tier_number 1
  optionmenu Count_intervals_whose_label: 2
    option is equal to
    option is not equal to
    option contains
    option does not contain
    option starts with
    option does not start with
    option ends with
    option does not end with
    option contains a word equal to
    option does not contain a word equal to
    option contains a word starting with
    option does not contain a word starting with
    option contains a word ending with
    option does not contain a word ending with
    option matches (regex)
  sentence the_text 
  boolean Scale_duration 0
  comment Spectrogram settings...
  real left_Time_range_(s) 0.0
  real right_Time_range_(s) 0.0 (=all)
  real left_Frequency_range_(Hz) 0.0
  real right_Frequency_range_(Hz) 5000
  real Dynamic_range_(Db) 50.0
  boolean Left_marks 0
endform

tg= selected("TextGrid")
spectrogram=selected("Spectrogram")
selectObject: tg

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

# Paint something
selectObject: spectrogram
@selectDrawArea
Paint: left_Time_range, right_Time_range, left_Frequency_range, right_Frequency_range, 100, "yes", dynamic_range, 6, 0, "no"
if left_marks
  Marks left every: 1, 1000, "yes", "yes", "yes"
endif
One mark left: right_Frequency_range, "yes", "yes", "no", ""
One mark left: left_Frequency_range, "yes", "yes", "no", ""
Text left: "yes", "Frequency (Hz)"

# Draw TextGrid
selectObject: tg

## Draw duration
tierTemp= Extract one tier: tier_number
tierTableTemp= Down to Table: "no", 16, "no", "no"
tierTable= nowarn Extract rows where column (text): "text", count_intervals_whose_label$, the_text$
Append column: "dur"
Formula: "dur", "fixed$((self[""tmax""]-self[""tmin""])*1000,0)"
durMaximum= Get maximum: "dur"

for iRow to object[tierTable].nrow
  dur= object[tierTable, iRow, "dur"]
  tmin= object[tierTable, iRow, "tmin"]
  tmax= object[tierTable, iRow, "tmax"]
  tmid= (tmax+tmin)*0.5
  heightCoefficient= if scale_duration then (dur/durMaximum)*0.8 else 0.8 fi
  y= right_Frequency_range*heightCoefficient
  Draw two-way arrow: tmin, y, tmax, y
  Text: tmid, "centre", y, "bottom", string$(dur) + " ms"
endfor
removeObject: tierTable, tierTableTemp, tierTemp

# Draw TextGrid
selectObject: tgDraw
@selectTextGrid
Draw: left_Time_range, right_Time_range, "yes", "yes", "yes"

removeObject: tgTier#, tgDraw
selectObject: tg, spectrogram
