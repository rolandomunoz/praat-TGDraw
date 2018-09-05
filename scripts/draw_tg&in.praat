form TextGrid: Draw...
  real left_Time_range_(s) 0.0
  real right_Time_range_(s) 0.0 (=all)
  boolean Show_boundaries 1
  boolean Use_text_styles 1
  boolean Garnish 1
endform

tg= selected("TextGrid")
selectObject: tg

info$= Picture info

nTiers= Get number of tiers
drawHeight= 2
tierHeight= nTiers*0.5
totalHeight= tierHeight + 2

# Draw
xmin= extractNumber(info$, "Inner viewport left:")
xmax= extractNumber(info$, "Inner viewport right:")
width= xmax - xmin

ymin= extractNumber(info$, "Inner viewport top:")
ymax= extractNumber(info$, "Inner viewport bottom:")
height= ymax- ymin

Draw: left_Time_range, right_Time_range, show_boundaries, use_text_styles, garnish

temp= (height/totalHeight)*tierHeight
Select inner viewport: xmin, xmax, ymin, ymax - temp
selectObject: tg 
