# Created by Rolando Munoz (Jun 2019)

show_tg_editor_commands = readFile("../temp/show_tg_editor_commands.txt")

beginPause: "TextGridEditor preferences"
  boolean: "TextGridEditor commands", show_tg_editor_commands
clicked = endPause: "Cancel", "Apply", "Ok", 3

if clicked > 1
  writeFileLine: "../temp/show_tg_editor_commands.txt", string$(textGridEditor_commands)
  writeInfoLine: "TextGrid Draw... Please, restart Praat to see any change."
  if clicked == 2
    runScript: "editor_show_tg_editor_commands.praat"
  endif
endif