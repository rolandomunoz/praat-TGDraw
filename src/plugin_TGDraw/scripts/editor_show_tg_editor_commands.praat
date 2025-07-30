show_tg_editor_commands = readFile("../temp/show_tg_editor_commands.txt")

beginPause: "TGDraw: TextGridEditor preferences"
    boolean: "Show commands in TextGridEditor", show_tg_editor_commands
clicked = endPause: "Cancel", "Apply", "Ok", 3

if clicked > 1
    writeFileLine: "../temp/show_tg_editor_commands.txt", string$(show_commands_in_TextGridEditor)
    writeInfoLine: "TGDraw... Please, restart Praat to see any change."
    if clicked == 2
        runScript: "editor_show_tg_editor_commands.praat"
    endif
endif