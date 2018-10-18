# Written by Rolando Munoz (2018-10-18)

form Select outer viewport (Grid layout)
  comment Grid area (columns and rows):
  natural  left_Grid 2
  natural right_Grid 3
  comment Select:
  natural left_Select 1
  natural right_Select 1
endform

nCol = left_Grid
nRow = right_Grid

xPosition = left_Select
yPosition = right_Select

if xPosition > nCol or yPosition > nRow
  writeInfoLine: "Select outer viewport (Grid layout)"
  appendInfoLine: "Out of range"
  exitScript()
endif

rowMin = 0
rowMax = 12

colMin = 0
colMax = 12

colLength = colMax/nCol
rowLength = rowMax/nRow

xMinPosition = (xPosition - 1) * colLength
xMaxPosition = xPosition * colLength

yMinPosition = (yPosition - 1) * rowLength
yMaxPosition = yPosition * rowLength

# Select all
Select outer viewport: xMinPosition, xMaxPosition, yMinPosition, yMaxPosition
