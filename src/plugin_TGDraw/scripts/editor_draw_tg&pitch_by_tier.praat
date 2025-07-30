# Created by Rolando Munoz (2018-09-19)

include ../procedures/select_viewport.proc

form Draw visible pitch contour and TextGrid (by tier)
  comment Picture window:
  boolean Erase_first 1
  comment TextGrid:
  sentence Draw_tiers 1
  boolean Show_boundaries 1
  comment Pitch:
  boolean Speckle 1
  boolean Smooth 1
  boolean Adjust_margin 1
  comment Margin:
  optionmenu Writename_at_top 3
  option no
  option far
  option near
  optionmenu Shade 2
  option no
  option current selection
  option buffer
  boolean Garnish 1
endform

tempPath$ = "../temp/setting_editor.txt"
editorInfo$ = nocheck Editor info
if editorInfo$ == ""
  temp$ = readFile$(tempPath$)
  tgOriginal = extractNumber(temp$, "editor:")
  editor: tgOriginal
    editorInfo$ = Editor info
endif

editorInfo$ = Editor info
tgOriginal = extractNumber(editorInfo$, "Editor name:")
tgOriginal$ = extractLine$(editorInfo$, "Data name:")
tgOriginal$ = replace$(tgOriginal$, "_", "\_ ", 0)
pitch_floor = extractNumber(editorInfo$, "Pitch floor:")
pitch_ceiling = extractNumber(editorInfo$, "Pitch ceiling:")
writeFile: tempPath$, "editor: 'tgOriginal'"
tmin_selection = Get start of selection
tmax_selection = Get end of selection
endeditor

# Selection: save first selected file
originalSelection# = selected#()

editor: tgOriginal
  pitch = Extract visible pitch contour
endeditor
tmin = Get start time
tmax = Get end time
if smooth
  # Calculate Hirst
  pitch_old = pitch
  pitch = Smooth: 20
  removeObject: pitch_old
endif

selectObject: tgOriginal
tg = Extract part: tmin, tmax, 1

# TextGrid: Prepare new TextGrid
tierList#= {'draw_tiers$'}
nTiers= size(tierList#)
tgTier#= zero# (nTiers)

for i to nTiers
  selectObject: tg
  tgTier# [i]= Extract one tier: tierList# [i]
endfor

selectObject: tgTier#
tgDraw= Merge
@textGrid2viewport: nTiers

if erase_first
  Erase all
endif

## Draw TextGrid
Axes: tmin, tmax, 0, 1
selectObject: tgDraw
if shade == 2
  Paint rectangle: "{0.8, 0.8, 0.8}", tmin_selection, tmax_selection, 0, 1
elsif shade == 3
  #@selectTextGrid
  timeIntervals = Read Table from comma-separated file: "../temp/time_interval.txt"
  for i to object[timeIntervals].nrow
    drawSelectionTimes_tmin = object[timeIntervals, i, "tmin"]
    drawSelectionTimes_tmax = object[timeIntervals, i, "tmax"]
    Paint rectangle: "{0.8, 0.8, 0.8}", drawSelectionTimes_tmin, drawSelectionTimes_tmax, 0, 1
  endfor
  removeObject: timeIntervals  
endif

selectObject: pitch
if adjust_margin
  pitch_ceiling = Get maximum: 0, 0, "Hertz", "Parabolic"
  pitch_ceiling = pitch_ceiling*1.25
endif

selectObject: tgDraw, pitch
if speckle
  Speckle separately: 0, 0, 50, pitch_ceiling, show_boundaries, 0, garnish
else
  Draw separately: 0, 0, 50, pitch_ceiling, show_boundaries, 0, garnish
endif

if writename_at_top == 2
  Text top: "yes", tgOriginal$
elsif writename_at_top == 3
  Text top: "no", tgOriginal$
endif

removeObject: tg, pitch, tgDraw, tgTier#
selectObject: originalSelection#
editor: tgOriginal
