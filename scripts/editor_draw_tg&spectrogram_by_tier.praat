# Created by Rolando Munoz (2018-09-19)

include ../procedures/select_viewport.proc

form Paint visible spectrogram and TextGrid (by tier)
  comment Picture window:
  boolean Erase_first 1
  comment TextGrid:
  sentence Draw_Tiers 1
  boolean Show_boundaries 1
  comment Spectrogram:
  real Dynamic_range_(Db) 50.0
  comment Margin:
  optionmenu Writename_at_top 3
  option no
  option far
  option near
  boolean Garnish 1
  optionmenu Shade 2
  option no
  option current selection
  option buffer
  boolean Left_marks 0
endform

tempPath$ = "../temp/setting_editor.txt"
editorInfo$ = nocheck Editor info
if editorInfo$ == ""
  temp$ = readFile$(tempPath$)
  tgOriginal = extractNumber(temp$, "editor:")
  editor: tgOriginal
    editorInfo$ = Editor info
endif

tgOriginal = extractNumber(editorInfo$, "Editor name:")
tgOriginal$ = extractLine$(editorInfo$, "Data name:")
tgOriginal$ = replace$(tgOriginal$, "_", "\_ ", 0)
writeFile: tempPath$, "editor: 'tgOriginal'"
tmin_selection = Get start of selection
tmax_selection = Get end of selection
endeditor

originalSelection# = selected#()
# Get Spetrogram
editor: tgOriginal
  spectrogram = Extract visible spectrogram
endeditor
spectrogram_tmin = Get start time
spectrogram_tmax = Get end time

# Get TextGrid
selectObject: tgOriginal
tg = Extract part: spectrogram_tmin, spectrogram_tmax, 1

## Prepare TextGrid to draw
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
if erase_first
  Erase all
endif

## Paint Spectrogram
selectObject: spectrogram

@selectDrawArea
Paint: 0, 0, 0, 0, 100, "yes", dynamic_range, 6, 0, "no"
if left_marks
  Marks left every: 1, 1000, "yes", "yes", "yes"
endif

info_spectrogram$ = Info
lowest_frequency = extractNumber(info_spectrogram$, "Lowest frequency:")
highest_frequency = extractNumber(info_spectrogram$, "Highest frequency:")
if garnish
  One mark left: lowest_frequency, "yes", "yes", "no", ""
  One mark left: highest_frequency, "yes", "yes", "no", ""
  Text left: "yes", "Frequency (Hz)"
endif

## Draw TextGrid
selectObject: tgDraw
@selectTierArea
if shade == 2
  Paint rectangle: "{0.8, 0.8, 0.8}", tmin_selection, tmax_selection, highest_frequency, lowest_frequency
elsif shade == 3
  timeIntervals = Read Table from comma-separated file: "../temp/time_interval.txt"
  for i to object[timeIntervals].nrow
    drawSelectionTimes_tmin = object[timeIntervals, i, "tmin"]
    drawSelectionTimes_tmax = object[timeIntervals, i, "tmax"]
    Paint rectangle: "{0.8, 0.8, 0.8}", drawSelectionTimes_tmin, drawSelectionTimes_tmax, highest_frequency, lowest_frequency
  endfor
  removeObject: timeIntervals  
endif

selectObject: tgDraw
@selectTextGrid
Draw: 0, 0, show_boundaries, 0, garnish

### Margin
if writename_at_top == 2
  Text top: "yes", tgOriginal$
elsif writename_at_top == 3
  Text top: "no", tgOriginal$
endif

removeObject: tgTier#, tgDraw, tg, spectrogram
selectObject: originalSelection#
