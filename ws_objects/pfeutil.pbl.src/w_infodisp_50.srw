$PBExportHeader$w_infodisp_50.srw
$PBExportComments$[nvo_printing] Displays information about the current operation.
forward
global type w_infodisp_50 from window
end type
type p_1 from picture within w_infodisp_50
end type
type progress_bar from u_progress within w_infodisp_50
end type
type st_1 from statictext within w_infodisp_50
end type
type st_build from statictext within w_infodisp_50
end type
type st_ldr from statictext within w_infodisp_50
end type
type st_3 from statictext within w_infodisp_50
end type
type cb_2 from commandbutton within w_infodisp_50
end type
type st_current from statictext within w_infodisp_50
end type
type st_complete from statictext within w_infodisp_50
end type
type st_count from statictext within w_infodisp_50
end type
type st_information from statictext within w_infodisp_50
end type
type pb_1 from picturebutton within w_infodisp_50
end type
end forward

global type w_infodisp_50 from window
integer width = 1815
integer height = 600
boolean titlebar = true
string title = "Status"
long backcolor = 81373358
event ue_cancel_requested ( )
event ue_meter_on ( )
event ue_stop ( )
p_1 p_1
progress_bar progress_bar
st_1 st_1
st_build st_build
st_ldr st_ldr
st_3 st_3
cb_2 cb_2
st_current st_current
st_complete st_complete
st_count st_count
st_information st_information
pb_1 pb_1
end type
global w_infodisp_50 w_infodisp_50

type variables
string is_genrtr
long   iL_count
string is_work_order
long il_current_row
string is_netdate,is_currentdate
boolean ib_cancel
dec {2}  ic_pct_complete
long il_min,il_max
datastore ids_datastore
end variables

forward prototypes
public function boolean of_get_value ()
public subroutine of_start_ani ()
public subroutine of_stop_ani ()
public subroutine wf_set_min_max (long al_min, long al_max)
public subroutine wf_step_pbar (long al_step)
public subroutine wf_step (long al_step)
end prototypes

event ue_stop();
//messagebox('sdfasdf','asfsadfsda')


//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 10.12.2006 By: LeiWei
//$<reason> Fix a defect.
/*
uo_1.of_stop()
uo_1.visible = false
*/
p_1.visible = false
//---------------------------- APPEON END ----------------------------

end event

public function boolean of_get_value ();return ib_cancel
end function

public subroutine of_start_ani ();
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 10.12.2006 By: LeiWei
//$<reason> Fix a defect.
/*




string gs_filename,ls_path
//ls_path = 'C:\Program Files\Harbor Management Consultants\ppw\graphics'
gs_filename = 'copyfile.AVI'
//gs_filename = ls_path + '\gears.AVI'


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.16.2006 By: Cao YongWang
//$<reason> Make sure the copyfile.AVI file exists, download the file from web server if not
If appeongetclienttype() <> 'PB' Then
	n_appeon_download lnv_download
	gs_filename = 'c:\intellicred\copyfile.avi'
	lnv_download.of_downloadfile( '', gs_filename)
End If
//---------------------------- APPEON END ----------------------------

//st_complete.visible = false
//st_3.visible = false
//st_1.visible = false
//st_information.visible = false
//st_ldr.visible = false
//

// Open the AVI file in the Animate control.
uo_1.Of_Open(gs_filename)

// This will play the AVI forever.
// There are 26 frames in this demo AVI file.
// 1st parameter is the starting frame,
// 2nd parameter is the ending frame,
// 3rd parameter is the number of times to play the AVI. -1 plays indefinately.

uo_1.visible = true


uo_1.Of_Play(1, 26, -1)
//uo_1.of_play(1, 8, -1)
*/

p_1.picturename = "infodisp.gif"
p_1.originalsize = TRUE
p_1.visible = TRUE

//---------------------------- APPEON END ----------------------------

end subroutine

public subroutine of_stop_ani ();


st_complete.visible = true
st_3.visible = true
st_1.visible = true
st_information.visible = true
st_ldr.visible = true

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 10.12.2006 By: LeiWei
//$<reason> Fix a defect.
/*
uo_1.Visible = false
*/
p_1.visible = false
//---------------------------- APPEON END ----------------------------

end subroutine

public subroutine wf_set_min_max (long al_min, long al_max);////wf_set_min_maxal_min
//
////progress_bar.object.setStep(al_max)
//
//   //progress_bar.object.Scrolling = 1
//
//
////	progress_bar.Visible = true
////	progress_bar.object.value = al_min
////   progress_bar.object.min = al_min
////   progress_bar.object.Max = al_max
////
//
//
//
//progress_bar.of_set_min_max(al_min,al_max)
//
//progress_bar.of_reset()

il_min = al_min
il_max = al_max

progress_bar.Visible = true
ic_pct_complete = 0.0

progress_bar.uf_set_position (ic_pct_complete)
end subroutine

public subroutine wf_step_pbar (long al_step);

//////////////////////////////////////////////////////////////////////
// Update the progress meter each time the timer event is triggered.
// When the progress meter is at 100%, stop triggering the timer evetn.
//////////////////////////////////////////////////////////////////////

if IsNull(il_max) or il_max = 0 then il_max = 1 //Add by Evan 11/04/2008
ic_pct_complete = ic_pct_complete + (1/il_max) * 100



progress_bar.uf_set_position (ic_pct_complete)

if ic_pct_complete > 99.0  then 
	progress_bar.Visible = false
end if


end subroutine

public subroutine wf_step (long al_step);

//////////////////////////////////////////////////////////////////////
// Update the progress meter each time the timer event is triggered.
// When the progress meter is at 100%, stop triggering the timer evetn.
//////////////////////////////////////////////////////////////////////

if IsNull(il_max) or il_max = 0 then il_max = 1 //Add by Evan 11/04/2008
ic_pct_complete = ic_pct_complete + (al_step/il_max) * 100



progress_bar.uf_set_position (ic_pct_complete)

if ic_pct_complete > 99.0  then 
	progress_bar.Visible = false
end if


end subroutine

on w_infodisp_50.create
this.p_1=create p_1
this.progress_bar=create progress_bar
this.st_1=create st_1
this.st_build=create st_build
this.st_ldr=create st_ldr
this.st_3=create st_3
this.cb_2=create cb_2
this.st_current=create st_current
this.st_complete=create st_complete
this.st_count=create st_count
this.st_information=create st_information
this.pb_1=create pb_1
this.Control[]={this.p_1,&
this.progress_bar,&
this.st_1,&
this.st_build,&
this.st_ldr,&
this.st_3,&
this.cb_2,&
this.st_current,&
this.st_complete,&
this.st_count,&
this.st_information,&
this.pb_1}
end on

on w_infodisp_50.destroy
destroy(this.p_1)
destroy(this.progress_bar)
destroy(this.st_1)
destroy(this.st_build)
destroy(this.st_ldr)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.st_current)
destroy(this.st_complete)
destroy(this.st_count)
destroy(this.st_information)
destroy(this.pb_1)
end on

event open;this.title = this.title + " " + sqlca.ServerName
st_information.TextColor = RGB(255, 255, 0) // YELLOW
st_information.BackColor = RGB(128, 0, 0)  // DARK RED
st_information.text = "Local: " + is_currentdate +" Corporate Version: " + is_netdate

of_start_ani()






end event

type p_1 from picture within w_infodisp_50
boolean visible = false
integer x = 293
integer y = 112
integer width = 1189
integer height = 160
boolean originalsize = true
string picturename = "infodisp.gif"
boolean focusrectangle = false
end type

type progress_bar from u_progress within w_infodisp_50
event destroy ( )
boolean visible = false
integer x = 18
integer y = 352
integer width = 1765
integer height = 68
integer taborder = 30
borderstyle borderstyle = stylelowered!
end type

on progress_bar.destroy
call u_progress::destroy
end on

type st_1 from statictext within w_infodisp_50
integer x = 18
integer y = 8
integer width = 1765
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "status text box 1"
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;this.text = ""
end event

type st_build from statictext within w_infodisp_50
boolean visible = false
integer x = 18
integer y = 644
integer width = 1765
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "update status text box"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event constructor;DATE 		ldt_date 			/* date holder										*/
TIME 		lt_time 				/* time holder										*/

DATE 		ldt_date2 			/* date holder										*/
TIME 		lt_time2 				/* time holder										*/
string ls_envir, ls_ppw_net, ls_ppw_local

n_cst_filesrvwin32 lnvo32

lnvo32 = CREATE n_cst_filesrvwin32

ls_envir = ProfileString( 'c:\Program Files\ppw.ini', 'envir', 'mode', '')

ls_ppw_local = ProfileString( 'c:\Program Files\ppw.ini', 'envir', 'ppwlocal', '')

CHOOSE CASE upper(ls_envir)
		
	CASE "TEST"
		
		ls_ppw_net = ProfileString( 'c:\Program Files\ppw.ini', 'envir', 'ppw_net_tst', '')
		
	CASE ELSE
		
		ls_ppw_net = ProfileString( 'c:\Program Files\ppw.ini', 'envir', 'ppw_net_prod', '')
		
END CHOOSE

lnvo32.of_GetLastWriteDateTime (ls_ppw_net, ldt_date, lt_time)

lnvo32.of_GetLastWriteDateTime (ls_ppw_local, ldt_date2, lt_time2)

is_netdate = string(datetime(ldt_date,lt_time),'MMMM dd, yyyy HH:mm' )

is_currentdate = string(datetime(ldt_date2,lt_time2),'MMMM dd, yyyy HH:mm' )

IF is_currentdate <> is_netdate THEN
	this.textcolor = rgb(255,0,0)
	if upper(ls_envir) = "TEST" then
		this.text = "Your Copy Of PrintPaperWork Requires Updating!" + " TEST"
	else
   	this.text = "Your Copy Of PrintPaperWork Requires Updating!"
	end if
Else
	if upper(ls_envir) = "TEST" then
		this.text = "PrintPaperWork: " + is_currentdate + " TEST"
	else
		this.text = "PrintPaperWork: " + is_currentdate
	end if
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lnvo32) then Destroy lnvo32
//---------------------------- APPEON END ----------------------------
end event

type st_ldr from statictext within w_infodisp_50
integer x = 1911
integer y = 160
integer width = 1701
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = " "
alignment alignment = center!
boolean focusrectangle = false
end type

event getfocus;//IF THIS.BORDER THEN
//	BorderStyle = StyleLowered!
//	TextColor = RGB(0, 255, 0)
//   BackColor = RGB(128, 0, 128)
//	ELSE
//	
//END IF

end event

type st_3 from statictext within w_infodisp_50
integer x = 2642
integer y = 232
integer width = 1701
integer height = 116
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "              "
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_infodisp_50
integer x = 2592
integer y = 968
integer width = 466
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;ib_cancel = true

st_count.Visible = false
st_complete.Visible = false
end event

type st_current from statictext within w_infodisp_50
boolean visible = false
integer x = 1902
integer y = 464
integer width = 2144
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_complete from statictext within w_infodisp_50
integer x = 2592
integer y = 368
integer width = 1701
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77971394
boolean enabled = false
string text = "            "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_count from statictext within w_infodisp_50
boolean visible = false
integer y = 576
integer width = 1765
integer height = 124
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77971394
boolean enabled = false
string text = "status count text box"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_information from statictext within w_infodisp_50
integer x = 18
integer y = 88
integer width = 1765
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "status information text box"
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;this.text = ""
end event

type pb_1 from picturebutton within w_infodisp_50
boolean visible = false
integer x = 585
integer y = 64
integer width = 590
integer height = 208
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "graphics\clean_harbors_logo.bmp"
end type

