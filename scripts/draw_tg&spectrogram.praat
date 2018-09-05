form TextGrid & Spectrogram: Draw...
  comment Spectrogram settings...
  real left_Time_range_(s) 0.0
  real right_Time_range_(s) 0.0 (=all)
  real left_Frequency_range_(Hz) 0.0
  real right_Frequency_range_(Hz) 5000
  real Dynamic_range_(Db) 50.0
  boolean Left_marks 0
endform

tg= selected("TextGrid")
spectrogram=selected("Spectrogram")
selectObject: tg

info$= Picture info

nTiers= Get number of tiers
tierHeight= nTiers*0.5
totalHeight= tierHeight + 2
drawHeight= totalHeight - tierHeight

# Draw
xmin= extractNumber(info$, "Inner viewport left:")
xmax= extractNumber(info$, "Inner viewport right:")
width= xmax - xmin

ymin= extractNumber(info$, "Inner viewport top:")
ymax= extractNumber(info$, "Inner viewport bottom:")
height= ymax- ymin

temp= (height/totalHeight)*tierHeight
Select inner viewport: xmin, xmax, ymin, ymax - temp
# Paint something
selectObject: spectrogram
Paint: left_Time_range, right_Time_range, left_Frequency_range, right_Frequency_range, 100, "yes", dynamic_range, 6, 0, "no"
if left_marks
  Marks left every: 1, 1000, "yes", "yes", "yes"
endif
One mark left: right_Frequency_range, "yes", "yes", "no", ""
One mark left: left_Frequency_range, "yes", "yes", "no", ""
Text left: "yes", "Frequency (Hz)"

# Draw TextGrid
Select inner viewport: xmin, xmax, ymin, ymax
selectObject: tg 
Draw: left_Time_range, right_Time_range, "yes", "yes", "yes"

selectObject: tg, spectrogram
