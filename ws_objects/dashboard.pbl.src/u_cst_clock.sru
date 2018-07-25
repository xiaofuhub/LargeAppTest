$PBExportHeader$u_cst_clock.sru
forward
global type u_cst_clock from userobject
end type
type st_day from statictext within u_cst_clock
end type
type st_week from statictext within u_cst_clock
end type
type st_time from statictext within u_cst_clock
end type
type st_date from statictext within u_cst_clock
end type
type dw_clock from datawindow within u_cst_clock
end type
type rr_1 from roundrectangle within u_cst_clock
end type
type st_background from statictext within u_cst_clock
end type
end forward

global type u_cst_clock from userobject
integer width = 1225
integer height = 544
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_day st_day
st_week st_week
st_time st_time
st_date st_date
dw_clock dw_clock
rr_1 rr_1
st_background st_background
end type
global u_cst_clock u_cst_clock

type variables
Long il_hour_length = 65
Long il_minute_length = 90
Long il_second_length = 130
Long il_second_length_ext = 40
Long il_origin_x // = 279 ;
Long il_origin_y // = 252;

//String is_Weeks[] = {"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"}
String is_Weeks[] = {"Sun","Mon","Tue","Wed","Thu","Fri","Sat"}
String is_months[] = {"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"}
end variables

forward prototypes
public subroutine of_refresh_time ()
public subroutine of_set_picture (string as_file_name)
public subroutine of_set_face_color (long al_color)
end prototypes

public subroutine of_refresh_time ();Integer li_hour,li_minute,li_second
Long ll_h_x,ll_h_y
Long ll_m_x,ll_m_y
Long ll_s_x,ll_s_y,ll_s_x_ext,ll_s_y_ext
String ls_time
Integer li_h_degree,li_m_degree,li_s_degree,li_s_degree_ext
time lt_now
date ld_today
Integer li_day_num,li_month

lt_now = Now()
ld_today = today()
ls_time = String(lt_now,'hhmmss')
li_hour = Long(MidA(ls_time,1,2))
If li_hour >= 12 Then li_hour = li_hour - 12

li_minute = Long(MidA(ls_time,3,2))
li_second = Long(MidA(ls_time,5,2))

li_h_degree = (li_hour + li_minute/60) * 30
li_m_degree = (li_minute + li_second/60) * 6
li_s_degree = li_second * 6

ll_h_x = il_origin_x + il_hour_length * Sin(li_h_degree*pi(2)/360)
ll_h_y = il_origin_y - il_hour_length * Cos(li_h_degree*pi(2)/360)

ll_m_x = il_origin_x + il_minute_length * Sin(li_m_degree*pi(2)/360)
ll_m_y = il_origin_y - il_minute_length * Cos(li_m_degree*pi(2)/360)

ll_s_x = il_origin_x + il_second_length * Sin(li_s_degree*pi(2)/360)
ll_s_y = il_origin_y - il_second_length * Cos(li_s_degree*pi(2)/360)

li_s_degree_ext = li_s_degree + 180
If li_s_degree_ext >= 360 Then li_s_degree_ext = li_s_degree_ext - 360

ll_s_x_ext = il_origin_x + il_second_length_ext * Sin((li_s_degree_ext)*pi(2)/360)
ll_s_y_ext = il_origin_y - il_second_length_ext * Cos((li_s_degree_ext)*pi(2)/360)

//This.SetRedraw(False)

dw_clock.SetRedraw(False)
dw_clock.Modify(  ' origin.x = '+String(il_origin_x - 20) + &
						' origin.y = '+String(il_origin_y - 18) + &
						' l_hour.x1 = '+String(il_origin_x) + &
						' l_hour.y1 = '+String(il_origin_y) + & 						
						' l_hour.x2 = '+String(ll_h_x) + &
						' l_hour.y2 = '+String(ll_h_y) + & 
						' l_min.x1 = '+String(il_origin_x) + &
						' l_min.y1 = '+String(il_origin_y) + &						
						' l_min.x2 = '+String(ll_m_x) + &
						' l_min.y2 = '+String(ll_m_y) + &
						' l_sec.x2 = '+String(ll_s_x) + &
						' l_sec.y2 = '+String(ll_s_y) + &
						' l_sec.x1 = '+String(ll_s_x_ext) + &
						' l_sec.y1 = '+String(ll_s_y_ext))

dw_clock.SetRedraw(True)

//st_date.text = String(ld_today,'mm/dd/yyyy')
st_time.text = String(lt_now,'HH:mm:ss')

li_day_num = DayNumber(ld_today)
If st_week.text <> is_Weeks[li_day_num] Then
	st_week.text = is_Weeks[li_day_num]
End If

li_month = Month(ld_today)
If st_date.text <> is_months[li_month] Then
	st_date.text = is_months[li_month]
End If
If st_day.text <> String(day(ld_today)) Then
	st_day.text = String(day(ld_today))
End If

//This.SetRedraw(True)

end subroutine

public subroutine of_set_picture (string as_file_name);dw_clock.Modify("p_face.filename = '"+as_file_name+"'")
end subroutine

public subroutine of_set_face_color (long al_color);st_background.backcolor = al_color
rr_1.fillcolor = al_color
st_week.backcolor = al_color
st_date.backcolor = al_color
st_day.backcolor = al_color
st_time.backcolor = al_color

end subroutine

on u_cst_clock.create
this.st_day=create st_day
this.st_week=create st_week
this.st_time=create st_time
this.st_date=create st_date
this.dw_clock=create dw_clock
this.rr_1=create rr_1
this.st_background=create st_background
this.Control[]={this.st_day,&
this.st_week,&
this.st_time,&
this.st_date,&
this.dw_clock,&
this.rr_1,&
this.st_background}
end on

on u_cst_clock.destroy
destroy(this.st_day)
destroy(this.st_week)
destroy(this.st_time)
destroy(this.st_date)
destroy(this.dw_clock)
destroy(this.rr_1)
destroy(this.st_background)
end on

type st_day from statictext within u_cst_clock
integer x = 873
integer y = 64
integer width = 247
integer height = 196
integer textsize = -28
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 134217744
string text = "30"
alignment alignment = center!
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_week from statictext within u_cst_clock
integer x = 654
integer y = 80
integer width = 238
integer height = 92
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 134217744
string text = "Tue"
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_time from statictext within u_cst_clock
integer x = 645
integer y = 308
integer width = 480
integer height = 104
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 134217744
string text = "20:08:08"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_date from statictext within u_cst_clock
integer x = 654
integer y = 168
integer width = 238
integer height = 92
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 134217744
string text = "OCT"
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_clock from datawindow within u_cst_clock
integer x = 87
integer y = 44
integer width = 517
integer height = 452
integer taborder = 10
string dataobject = "d_clock"
boolean border = false
end type

event constructor;il_origin_x = Long(This.describe('l_x.x1')) 
il_origin_y = Long(This.describe('l_y.y1'))
end event

type rr_1 from roundrectangle within u_cst_clock
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 134217744
integer x = 23
integer y = 28
integer width = 1166
integer height = 480
integer cornerheight = 40
integer cornerwidth = 40
end type

type st_background from statictext within u_cst_clock
integer x = 27
integer y = 56
integer width = 1157
integer height = 428
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 134217744
boolean focusrectangle = false
end type

