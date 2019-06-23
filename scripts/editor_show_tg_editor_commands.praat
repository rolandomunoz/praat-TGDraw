# Created by Rolando Munoz (2019-06)

form TextGridEditor preferences
  boolean Show_TextGridEditor_commands 0
endform

writeFileLine: "../temp/show_tg_editor_commands.txt", string$(show_TextGridEditor_commands)
writeInfoLine: "tgDraw... Please, restart Praat to see any change."
