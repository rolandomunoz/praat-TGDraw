# Setup script

if praatVersion < 6000
    appendInfoLine: "plug-in: TextGrid PicMaker"
    appendInfoLine: "Warning: "Please, update Praat to a more recent release. The plug-in was is not tested for 'praatVersion$'
    appendInfoLine: "Praat website: http://www.fon.hum.uva.nl/praat/"
elsif praatVersion == 6215
    appendInfoLine: "plug-in: TextGrid Picmaker"
    appendInfoLine: "Warning: The TextGridEditor commands does not not work well for 'praatVersion$'. Please, get a more recent release."
    appendInfoLine: "Praat website: http://www.fon.hum.uva.nl/praat/"
elsif praatVersion >= 6219 and praatVersion < 6223
    appendInfoLine: "plug-in: TextGrid PicMaker"
    appendInfoLine: "Warning: The TextGridEditor commands does not not work well for 'praatVersion$'. Please, get a more recent release."
    appendInfoLine: "Praat website: http://www.fon.hum.uva.nl/praat/"
endif

writeFileLine: "temp/time_interval.txt", "tmin,tmax"
show_tg_editor_commands = readFile("temp/show_tg_editor_commands.txt")

# Static menu
Add menu command: "Objects", "Goodies", "TextGrid picmaker", "", 0, ""
Add menu command: "Objects", "Goodies", "TextGridEditor preferences...", "TextGrid PictureMaker", 1, "scripts/editor_show_tg_editor_commands.praat"

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
    if praatVersion < 6215
        Add menu command: "TextGridEditor", "Select", "Save selection time...", "", 0, "scripts/editor_save_selection.praat"
        Add menu command: "TextGridEditor", "Spectrum", "Paint visible spectrogram and TextGrid (by tier)...", "", 0, "scripts/editor_draw_tg&spectrogram_by_tier.praat"
    else
        Add menu command: "TextGridEditor", "Time", "Save selection time...", "", 0, "scripts/editor_save_selection.praat"
        Add menu command: "TextGridEditor", "Spectrogram", "Paint visible spectrogram and TextGrid (by tier)...", "", 0, "scripts/editor_draw_tg&spectrogram_by_tier.praat"
    endif
    Add menu command: "TextGridEditor", "Pitch", "Draw visible pitch contour and TextGrid (by tier)...", "", 0, "scripts/editor_draw_tg&pitch_by_tier.praat"
    Add menu command: "TextGridEditor", "Pitch", "Draw visible intonation (by tier)...", "", 0, "scripts/editor_draw_intonation_by_tier.praat"
endif