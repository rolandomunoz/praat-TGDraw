# Created by Rolando Munoz (2018-09-19)

form Save selection time
  boolean Clear_history 0
endform

tmin = Get start of selection
tmax = Get end of selection

timeIntervalPath$ = "../temp/time_interval.txt"

appendFileLine: timeIntervalPath$, tmin, ",", tmax
if clear_history
  writeFileLine: timeIntervalPath$, "tmin,tmax"
else
  output$ = readFile$: timeIntervalPath$
  output$ = replace$(output$, ",", tab$, 0)
  writeInfoLine: output$
endif
