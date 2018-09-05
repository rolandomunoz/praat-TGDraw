form TextGrid: Draw...
  real left_Time_range_(s) 0.0
  real right_Time_range_(s) 0.0 (=all)
  boolean Show_boundaries 1
  boolean Use_text_styles 1
  boolean Garnish 1
  comment TextGrid settings...
  comment Get duration info from tier:
  natural Tier_number 1
  optionmenu Count_intervals_whose_label: 1
    option is equal to
    option is not equal to
    option contains
    option does not contain
    option starts with
    option does not start with
    option ends with
    option does not end with
    option contains a word equal to
    option does not contain a word equal to
    option contains a word starting with
    option does not contain a word starting with
    option contains a word ending with
    option does not contain a word ending with
    option matches (regex)
  sentence the_text a
  boolean Scale_duration 0
endform

tg= selected("TextGrid")
tgDuration= Get total duration
right_Time_range= if right_Time_range > 0 then right_Time_range else tgDuration fi

info$= Picture info
viewport_xmin= extractNumber(info$, "Inner viewport left:")
viewport_xmax= extractNumber(info$, "Inner viewport right:")
viewport_ymin= extractNumber(info$, "Inner viewport top:")
viewport_ymax= extractNumber(info$, "Inner viewport bottom:")
viewport_width= viewport_xmax - viewport_xmin
viewport_height= viewport_ymax- viewport_ymin

selectObject: tg

nTiers= Get number of tiers
tgDuration= Get total duration
tierTemp= Extract one tier: tier_number
tierTableTemp= Down to Table: "no", 16, "no", "no"
tierTable= nowarn Extract rows where column (text): "text", count_intervals_whose_label$, the_text$
Append column: "dur"
Formula: "dur", "fixed$((self[""tmax""]-self[""tmin""])*1000,0)"
durMaximum= Get maximum: "dur"

axes_drawHeight= 2
axes_tierHeight= nTiers*0.5
axes_totalHeight= axes_tierHeight + axes_drawHeight

# Draw
selectObject: tg
Draw: left_Time_range, right_Time_range, show_boundaries, use_text_styles, garnish

# Select draw area
viewport_y= (viewport_height/axes_totalHeight)*axes_tierHeight

Select inner viewport: viewport_xmin, viewport_xmax, viewport_ymin, (viewport_ymax - viewport_y)
if garnish
  Text left: "no", "Time (ms)"
endif
Axes: left_Time_range, right_Time_range, 0, 1

for iRow to object[tierTable].nrow
  dur= object[tierTable, iRow, "dur"]
  tmin= object[tierTable, iRow, "tmin"]
  tmax= object[tierTable, iRow, "tmax"]
  tmid= (tmax+tmin)*0.5
  y= if scale_duration then (dur/durMaximum)*0.85 else 0.85 fi
  Draw two-way arrow: tmin, y, tmax, y
  Text: tmid, "centre", y, "bottom", string$(dur)
endfor

# Select all picture
Select inner viewport: viewport_xmin, viewport_xmax, viewport_ymin, viewport_ymax

removeObject: tierTable, tierTableTemp, tierTemp
selectObject: tg
