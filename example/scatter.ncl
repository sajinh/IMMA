load "$SysE/lib/ncl/helper_libs.ncl"

err = NhlGetErrorObjectId() 
 setvalues err 
  "errLevel" : "Fatal" ; only report Fatal errors 
end setvalues 

year = "1880"
files = systemfunc("ls data/processed/"+year+"/ASC/out.??")
nfiles = dimsizes(files)
rows = new(nfiles,"float")
do i = 0,nfiles-1
  fnm = files(i)
 rows(i) = numAsciiRow(fnm)
end do
max_row = tointeger(max(rows))
mon=ispan(1,12,1)
nmon = dimsizes(mon)
seas_sst = new( (/max_row,nmon/), "float")

do i=0,nfiles-1
  fnm = files(i)
  nrow = tointeger(rows(i))
  data = asciiread(fnm,(/nrow,4/),"float")
  seas_sst(:nrow-1,i) = (data(:,0))
  delete(data)
end do

wks = open_wks("x11","scatter","rainbow")
res = True
res@xyMarkLineMode      = "Markers"
res@xyMarkers           = 16                     ; choose type of marker
res@xyMarkerColor       = "red"                  ; Marker color
res@xyMarkerSizeF       = 0.005                  ; Marker size (default 0.01)
res@xyDashPattern      = 1                      ; solid line 
;res@xyLineThickness    = 1 
plot = gsn_csm_xy(wks,mon,seas_sst,res)
