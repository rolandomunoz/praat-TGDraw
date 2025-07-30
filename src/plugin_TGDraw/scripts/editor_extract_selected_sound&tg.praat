form Extract selected
  comment Extract Sound & TextGrid
  real Margin 0.1
  boolean Conserve_time 1
  comment Include:
  boolean Spectrogram 1
  boolean Pitch 1
  boolean Formant 0
  boolean Intensity 0
endform

# Extract Sound & TextGrid
tmin= Get start of selection
tmax= Get end of selection
Select: tmin-margin, tmax+margin

if conserve_time
  sd= Extract selected sound (preserve times)
  tg= Extract selected TextGrid (preserve times)
else
  sd= Extract selected sound (time from 0)
  tg= Extract selected TextGrid (time from 0)
endif
Select: tmin, tmax

# Get setting values from the Editor window
editorInfo$= Editor info
tgInfo$= TextGrid info
tgName$= extractLine$(tgInfo$, "Object name: ")
left_Pitch_range= extractNumber(editorInfo$, "Pitch floor: ")
right_Pitch_range= extractNumber(editorInfo$, "Pitch ceiling: ")
spectrogram_maximum_frequency= extractNumber(editorInfo$, "Spectrogram view to: ")
spectrogram_windows_length= extractNumber(editorInfo$, "Spectrogram window length: ")

# Use Object window
endeditor

selectObject: tg
Rename: tgName$ + "_extracted"
selectObject: sd
Rename: tgName$

objectID$ = string$(sd) + "," + string$(tg)

if spectrogram
  selectObject: sd
  spectrogram = To Spectrogram: spectrogram_windows_length, spectrogram_maximum_frequency, 0.002, 20, "Gaussian"
  objectID$ = objectID$ + "," + string$(spectrogram)
endif

if pitch
  selectObject: sd
  pitch= To Pitch: 0, left_Pitch_range, right_Pitch_range
  objectID$ = objectID$ + "," + string$(pitch)
endif

if formant
  selectObject: sd
  formant = To Formant (burg): 0, 5, 5500, 0.025, 50
  objectID$ = objectID$ + "," + string$(formant)
endif

if intensity
  selectObject: sd
  intensity= To Intensity: 100, 0, "yes"
  objectID$ = objectID$ + "," + string$(intensity)
endif

object# = {'objectID$'}

selectObject: object#
