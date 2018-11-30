# Created by Rolando Munoz (2018-11-21)

include ../procedures/select_viewport.proc

form Draw intonation (by tier)
  comment Picture window:
  boolean Erase_first 1
  comment TextGrid:
  sentence Draw_tiers 1
  boolean Show_boundaries 1
  comment Spectrogram:
  real Dynamic_range 50.0
  comment Pitch:
  boolean Speckle 0
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
  spectrogram = Extract visible spectrogram
endeditor
tmin = Get start time
tmax = Get end time

if smooth
  selectObject: pitch
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
@selectDrawArea
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

@selectDrawArea
@selectGrid: 1, 2
selectObject: pitch
if speckle
  Speckle: 0, 0, pitch_floor, pitch_ceiling, "no"
else
  Draw: 0, 0, pitch_floor, pitch_ceiling, "no"
endif
One mark left: pitch_floor, "yes", "yes", "no", ""
One mark left: pitch_ceiling, "yes", "yes", "no", ""
One mark left: (pitch_ceiling + pitch_floor)/2, "yes", "yes", "no", ""

Text left: "yes", "F0 (Hz)"
Line width: 2
Draw line: tmin, pitch_floor, tmax, pitch_floor
Line width: 1

@selectDrawArea
@selectGrid: 2, 2
selectObject: spectrogram
spectrogramInfo$ = Info
spectrogramLowestFrequency = extractNumber(spectrogramInfo$,"Lowest frequency: ")
spectrogramHighestFrequency = extractNumber(spectrogramInfo$, "Highest frequency: ")
Paint: 0, 0, 0, 0, 100, "yes", dynamic_range, 6, 0, "no"

One mark right: spectrogramLowestFrequency, "yes", "yes", "no", ""
One mark right: spectrogramHighestFrequency, "yes", "yes", "no", ""
Text right: "yes", "Frequency (Hz)"

@selectTextGrid
selectObject: tgDraw
Draw: 0, 0, show_boundaries, "no", "yes"

if writename_at_top == 2
  Text top: "yes", tgOriginal$
elsif writename_at_top == 3
  Text top: "no", tgOriginal$
endif

removeObject: tg, pitch, spectrogram, tgDraw, tgTier#
selectObject: originalSelection#
editor: tgOriginal
