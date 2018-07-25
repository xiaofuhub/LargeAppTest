$PBExportHeader$uo_clock.sru
$PBExportComments$Clock visualization by Dmitry Lukyanov <ldu@writeme.com>
forward
global type uo_clock from UserObject
end type
type em_1 from editmask within uo_clock
end type
type dw_1 from datawindow within uo_clock
end type
end forward

global type uo_clock from UserObject
int Width=494
int Height=444
boolean Border=true
BorderStyle BorderStyle=StyleShadowBox!
long BackColor=16777215
long PictureMaskColor=12632256
long TabTextColor=33554432
long TabBackColor=67108864
string PictureName="ShowWatch!"
string PowerTipText="Clock"
string Text="Clock"
event resize pbm_size
em_1 em_1
dw_1 dw_1
end type
global uo_clock uo_clock

type variables
private integer radius
private integer x0,y0
private time current_time

end variables

forward prototypes
private function integer f_xpoint (integer rr, integer angle60)
private function integer f_ypoint (integer rr, integer angle60)
public function boolean f_settime (time newtime)
private function string f_createhand (readonly string name, integer rr, integer angle60, integer ww, string color)
public function boolean f_settime (time newtime, boolean updateedit)
public function time f_gettime ()
private function boolean f_create ()
end prototypes

private function integer f_xpoint (integer rr, integer angle60);return x0 +rr*sin(Pi(angle60*2)/60)

end function

private function integer f_ypoint (integer rr, integer angle60);return y0 -rr*cos(Pi(angle60*2)/60)

end function

public function boolean f_settime (time newtime);return f_setTime(newtime,true)

end function

private function string f_createhand (readonly string name, integer rr, integer angle60, integer ww, string color);int xx,yy
string dwsynt

xx=x0 +rr*sin(Pi(angle60*2)/60)
yy=y0 -rr*cos(Pi(angle60*2)/60)

return 'create line(band=header x1="'+string(x0)+'" y1="'+string(y0)+'" x2="'+string(xx)+'" y2="'+string(yy)+'"  name='+name+' pen.style="0" pen.width="'+string(ww)+'" pen.color="'+color+'"  background.mode="1" background.color="553648127" )~r~n'

end function

public function boolean f_settime (time newtime, boolean updateedit);string dwsynt
string res
string name,color
int xx,yy,ww

dw_1.setRedraw(false)
dwsynt='destroy l_second~r~ndestroy l_minute~r~ndestroy l_hour'
dw_1.modify(dwsynt)

dwsynt=''
dwsynt+=f_createHand('l_hour',(radius -9)/2,mod(hour(newtime),12)*5+minute(newtime)/12,7,'33554432')
dwsynt+=f_createHand('l_minute',(radius -9)*3/4,minute(newtime),3,'274359156')
dwsynt+=f_createHand('l_second',radius -9,second(newtime),1,'1086902488')

res=dw_1.modify(dwsynt)
if updateedit and em_1.text<>string(newtime,em_1.mask) then em_1.text=string(newtime,em_1.mask)
current_time=newtime
dw_1.setRedraw(true)
return res=''

end function

public function time f_gettime ();return current_time

end function

private function boolean f_create ();string dwsynt
string error1
double a //the corner in radians

int i,xx,yy,ww,hh
string size

ww=UnitsToPixels(dw_1.width,XUnitsToPixels!)
hh=UnitsToPixels(dw_1.height,YUnitsToPixels!)

dwsynt='release 6;~r~n'
//dwsynt+='datawindow(units=1 timer_interval=0 color=76585128)~r~n'
dwsynt+='datawindow(units=1 timer_interval=0 color=16711808)~r~n'
dwsynt+='header(height='+string(hh)+' color="536870912" )~r~n'
dwsynt+='table(column=(type=long updatewhereclause=yes name=a dbname="a" ))~r~n'

ww=min(ww,hh)
ww -=2
if mod(ww,2)=0 then ww --
hh=ww

x0=ww/2+1
y0=x0

radius=ww/2 - 3 //radius

for i=0 to 59
	xx=f_xPoint(radius,i)
	yy=f_yPoint(radius,i)
	size='6'
	if mod(i,5)>0 then size='0'//name=t_1  
	dwsynt+='text(band=header alignment="0" text="" border="'+size+'" color="33554432" x="'+string(xx)+'" y="'+string(yy)+'" height="1" width="1"  font.face="Arial" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="1086902488" )~r~n'
next

//center point to hold 
//dwsynt+='text(band=header alignment="0" text="" border="0" color="33554432" x="'+string(x0)+'" y="'+string(y0)+'" height="1" width="1"  font.face="Arial" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="33554432" )~r~n'

dw_1.create(dwsynt,error1)

//messagebox("", error1 )

return error1=''

end function

on uo_clock.create
this.em_1=create em_1
this.dw_1=create dw_1
this.Control[]={this.em_1,&
this.dw_1}
end on

on uo_clock.destroy
destroy(this.em_1)
destroy(this.dw_1)
end on

type em_1 from editmask within uo_clock
event change pbm_enchange
int X=114
int Y=500
int Width=334
int Height=84
int TabOrder=10
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
string Mask="hh:mm:ss"
MaskDataType MaskDataType=TimeMask!
boolean Spin=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=RussianCharSet!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event change;if LenA(this.text)>=LenA(this.mask) then f_setTime(time(this.text),false)

end event

event modified;f_setTime(time(this.text),true)

end event

type dw_1 from datawindow within uo_clock
int Width=421
int Height=372
boolean Enabled=false
boolean LiveScroll=true
end type

event constructor;f_create()

end event

