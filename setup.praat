# Copyright 2018 Rolando Munoz Aramburú

if praatVersion < 6039
  appendInfoLine: "Draw TextGrid with"
  appendInfoLine: "Warning: This plug-in only works on Praat version 6.0.39 or later. Please, get a more recent version of Praat."
  appendInfoLine: "Praat website: http://www.fon.hum.uva.nl/praat/"
endif

## Dynamic menu
Add action command: "TextGrid", 1, "", 0, "", 0, "Draw (time)...", "Draw...", 1, "scripts/draw_tg&time.praat"
Add action command: "TextGrid", 1, "", 0, "", 0, "Draw (inside)...", "Draw...", 1, "scripts/draw_tg&in.praat"
Add action command: "TextGrid", 1, "", 0, "", 0, "Draw (outside)...", "Draw...", 1, "scripts/draw_tg&out.praat"


Add action command: "TextGrid", 1, "Spectrogram", 1, "", 0, "Draw -", "", 0, ""
Add action command: "TextGrid", 1, "Spectrogram", 1, "", 0, "Draw (with duration)...", "Draw -", 1, "scripts/draw_tg&spectrogram_by_time.praat"
Add action command: "TextGrid", 1, "Spectrogram", 1, "", 0, "Draw...", "Draw -", 1, "scripts/draw_tg&spectrogram.praat"

Add action command: "TextGrid", 1, "Pitch", 1, "", 0, "Draw -", "", 0, ""
Add action command: "TextGrid", 1, "Pitch", 1, "", 0, "Draw...", "Draw -", 1, "scripts/draw_tg&pitch.praat"

# Praat Picture
Add menu command: "TextGridEditor", "File", "Draw visible Spectrogram and TextGrid...", "", 0, "scripts/editor_draw_tg&spectrogram_selected.praat"

Add menu command: "Picture", "Select", "Select upper part (TextGrid)...", "Select inner viewport...", 0, "scripts/select_tg_upper_part.praat"
Add menu command: "Picture", "Select", "Select lower part (TextGrid)...", "Select inner viewport...", 0, "scripts/select_tg_lower_part.praat"

# Main command
#Add menu command: "Objects", "Praat", "Compare F0...", "FP tools", 1, "scripts/compare_f0.praat"
