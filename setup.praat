# Written by Rolando Munoz
# Copyright 2018-2019

if praatVersion < 6039
  appendInfoLine: "Draw TextGrid with"
  appendInfoLine: "Warning: This plug-in only works on Praat version 6.0.39 or later. Please, get a more recent version of Praat."
  appendInfoLine: "Praat website: http://www.fon.hum.uva.nl/praat/"
endif

writeFileLine: "temp/time_interval.txt", "tmin,tmax"
show_tg_editor_commands = readFile("temp/show_tg_editor_commands.txt")

# Static menu
Add menu command: "Objects", "Goodies", "tgDraw", "", 0, ""
Add menu command: "Objects", "Goodies", "TextGridEditor preferences...", "tgDraw", 1, "scripts/editor_show_tg_editor_commands.praat"

# Dynamic menu
if show_tg_editor_commands
  Add action command: "TextGrid", 1, "", 0, "", 0, "View & Edit alone (no warn)", "View & Edit alone", 0, "scripts/view_and_edit_alone.praat"
endif

Add action command: "TextGrid", 1, "", 0, "", 0, "Draw (time)...", "Draw...", 1, "scripts/draw_tg&time.praat"
Add action command: "TextGrid", 1, "", 0, "", 0, "Draw (inside)...", "Draw...", 1, "scripts/draw_tg&in.praat"
Add action command: "TextGrid", 1, "", 0, "", 0, "Draw (outside)...", "Draw...", 1, "scripts/draw_tg&out.praat"

Add action command: "TextGrid", 1, "Spectrogram", 1, "", 0, "Draw -", "", 0, ""
Add action command: "TextGrid", 1, "Spectrogram", 1, "", 0, "Draw (with duration)...", "Draw -", 1, "scripts/draw_tg&spectrogram_by_time.praat"
Add action command: "TextGrid", 1, "Spectrogram", 1, "", 0, "Draw...", "Draw -", 1, "scripts/draw_tg&spectrogram.praat"

## Pitch
Add action command: "TextGrid", 1, "Pitch", 1, "", 0, "Draw separately by tier...", "Draw separately...", 1, "scripts/draw_separately_pitch_by_tier.praat"
Add action command: "TextGrid", 1, "Pitch", 1, "", 0, "Speckle separately by tier...", "Speckle separately...", 1, "scripts/speckle_separately_pitch_by_tier.praat"

# Praat Picture
Add menu command: "Picture", "Select", "Select outer viewport (Grid layout)...", "Select outer viewport...", 0, "scripts/select_outer_viewport_by_grid_layout.praat"
Add menu command: "Picture", "Select", "TextGrid area", "", 0, ""
Add menu command: "Picture", "Select", "Select upper part...", "TextGrid area", 1, "scripts/select_tg_upper_part.praat"
Add menu command: "Picture", "Select", "Select lower part...", "TextGrid area", 1, "scripts/select_tg_lower_part.praat"

# TextGridEditor
if show_tg_editor_commands
  Add menu command: "TextGridEditor", "Select", "Save selection time...", "", 0, "scripts/editor_save_selection.praat"
  Add menu command: "TextGridEditor", "Spectrum", "Paint visible spectrogram and TextGrid (by tier)...", "", 0, "scripts/editor_draw_tg&spectrogram_by_tier.praat"
  Add menu command: "TextGridEditor", "Pitch", "Draw visible pitch contour and TextGrid (by tier)...", "", 0, "scripts/editor_draw_tg&pitch_by_tier.praat"
  Add menu command: "TextGridEditor", "Pitch", "Draw visible intonation (by tier)...", "", 0, "scripts/editor_draw_intonation_by_tier.praat"
endif
