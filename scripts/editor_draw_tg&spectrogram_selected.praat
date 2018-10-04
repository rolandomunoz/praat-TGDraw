# Created by Rolando Munoz (2018-09-19)

include ../procedures/select_viewport.proc

form TextGrid & Spectrogram: Draw...
  sentence Draw_Tiers 1
  real Margin 0.1
  comment Spectrogram settings...
  real left_Frequency_range_(Hz) 0.0
  real right_Frequency_range_(Hz) 5000
  real Dynamic_range_(Db) 50.0
  boolean Left_marks 0
  boolean Erase
endform

endeditor
originalSelection# = selected#()

tgOriginal = selected("TextGrid")
tgOriginal$ = selected$("TextGrid")
tgOriginal$ = replace$(tgOriginal$, "_", "\_", 0)

@getID: "Sound"
sdOriginal = getID.return
if not sdOriginal
@getID: "LongSound"
  sdOriginal = getID.return
endif

originalSelection# = {tgOriginal, sdOriginal}
editor: tgOriginal

runScript: "editor_extract_selected_sound&tg.praat", margin, 1, 1, 0, 0, 0
endeditor

sd= selected("Sound")
tg= selected("TextGrid")
spectrogram=selected("Spectrogram")

tierList#= {'draw_Tiers$'}
nTiers= size(tierList#)
tgTier#= zero# (nTiers)

left_Time_range= 0.0
right_Time_range= 0.0

  
for i to nTiers
  selectObject: tg
  tgTier# [i]= Extract one tier: tierList# [i]
endfor

selectObject: tgTier#
tgDraw= Merge
@textGrid2viewport: nTiers

# Draw

if erase
  Erase all
endif

Text top: "no", tgOriginal$
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
selectObject: tgDraw
@selectTextGrid
Draw: left_Time_range, right_Time_range, "yes", "yes", "yes"

removeObject: tgTier#, tgDraw, sd, tg, spectrogram
editor: tgOriginal
selectObject: originalSelection#

procedure getID: .arg_objectType$
  .originalSelection# = selected#()
  .return = 0
  .nObjects = size(.originalSelection#)
  for .iObject to .nObjects
    selectObject: .originalSelection#[.iObject]
    .objectFullName$= selected$()
    .objectType$ = extractWord$(.objectFullName$, "")
    if .objectType$ == .arg_objectType$
      .return = .originalSelection#[.iObject]
      .iObject = .nObjects
    endif
  endfor
  selectObject: .originalSelection#
endproc

