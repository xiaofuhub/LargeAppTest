$PBExportHeader$w_import_progressbar.srw
forward
global type w_import_progressbar from window
end type
type cb_break from commandbutton within w_import_progressbar
end type
type st_complete from statictext within w_import_progressbar
end type
type cb_close from commandbutton within w_import_progressbar
end type
type st_remain from statictext within w_import_progressbar
end type
type st_table from statictext within w_import_progressbar
end type
type st_importid from statictext within w_import_progressbar
end type
type st_count from statictext within w_import_progressbar
end type
type st_temp from statictext within w_import_progressbar
end type
type dw_step from datawindow within w_import_progressbar
end type
type hpb_progress from hprogressbar within w_import_progressbar
end type
type ln_1 from line within w_import_progressbar
end type
type ln_2 from line within w_import_progressbar
end type
type ln_3 from line within w_import_progressbar
end type
end forward

global type w_import_progressbar from window
integer width = 2071
integer height = 1044
boolean titlebar = true
string title = "Importing..."
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_break cb_break
st_complete st_complete
cb_close cb_close
st_remain st_remain
st_table st_table
st_importid st_importid
st_count st_count
st_temp st_temp
dw_step dw_step
hpb_progress hpb_progress
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
end type
global w_import_progressbar w_import_progressbar

type prototypes
function long MessageBoxA(long hWnd, string lpText, string lpCaption, ulong uType) library "user32.dll" alias for "MessageBoxA;Ansi" //Add by Evan 05.03.2011
end prototypes

type variables
long il_RemainTableCount
boolean ib_break = false  //add by stephen 01.16.2013 --V12.3 Import Logging modifications
end variables

forward prototypes
public function integer of_settablecount (integer ai_count)
public function integer of_skipnextstep ()
public function integer of_resetstep ()
public function integer of_setremaincount (integer al_count)
public function integer of_setimportid (long al_importid)
public function integer of_settablename (string as_table)
public function integer of_reduceremaincount ()
public function integer of_skipnextposition ()
public function integer of_setmaxposition (integer ai_maxposition)
public function integer of_setposition (integer ai_position)
public function integer of_setimportprocessdesc (string as_description)
public function integer of_setcomplete ()
public function long of_messagebox (string as_caption, string as_text, long al_type)
public function integer of_setpraccount (integer ai_count)
public function integer of_setremainprac (integer al_count)
public function integer of_setpracname (string as_prac)
public function integer of_setauditprocessdesc (string as_description)
public function integer of_auditnextstep ()
end prototypes

public function integer of_settablecount (integer ai_count);st_count.Text = "Import table count:   " + String(ai_Count)

Return 1
end function

public function integer of_skipnextstep ();if dw_step.GetRow() < dw_step.RowCount() then
	dw_step.object.pic_flag[dw_step.GetRow()] = 2  //Finish Step
	dw_step.ScrollNextRow()
	dw_step.object.pic_flag[dw_step.GetRow()] = 1  //Current Step
	hpb_progress.Position = 0
else
	dw_step.object.pic_flag[dw_step.RowCount()] = 2 //Finish Step
	hpb_progress.Position = hpb_progress.MaxPosition
end if
this.SetRedraw(true)
//MessageBox("","")

Return 1
end function

public function integer of_resetstep ();integer li_pic_flag[8]

this.SetRedraw(false)

dw_step.Reset()
dw_step.object.pic_flag[1,8] = li_pic_flag[]

dw_step.object.step_desc[1] = "1. Get import data"
dw_step.object.step_desc[2] = "2. Create compute fields"
dw_step.object.step_desc[3] = "3. Format import data"
dw_step.object.step_desc[4] = "4. Import data into IntelliSoft table"
dw_step.object.step_desc[5] = "5. Generate error file"
dw_step.object.step_desc[6] = "6. Send email"
dw_step.object.step_desc[7] = "7. Save error file"
dw_step.object.step_desc[8] = "8. Update log"

dw_step.object.pic_flag[1] = 1
hpb_progress.Position = 0

this.SetRedraw(true)

Return 1
end function

public function integer of_setremaincount (integer al_count);il_RemainTableCount = al_Count
st_remain.Text = "Remain table count: " + String(al_Count)

Return 1
end function

public function integer of_setimportid (long al_importid);st_importid.Text = "Current import ID: " + String(al_ImportID)

Return 1
end function

public function integer of_settablename (string as_table);st_table.Text = "Current import table: " + as_Table

Return 1
end function

public function integer of_reduceremaincount ();il_RemainTableCount --
of_SetRemainCount(il_RemainTableCount)

Return 1
end function

public function integer of_skipnextposition ();hpb_progress.Position += 1
//MessageBox("","")

Return 1
end function

public function integer of_setmaxposition (integer ai_maxposition);hpb_progress.MaxPosition = ai_MaxPosition

Return 1
end function

public function integer of_setposition (integer ai_position);hpb_progress.Position = ai_Position

Return 1
end function

public function integer of_setimportprocessdesc (string as_description);
string ls_Text

if LenA(as_Description) > 0 then
	ls_Text = "4. Import data into IntelliSoft table ---> " + as_Description + "..."
else
	ls_Text = "4. Import data into IntelliSoft table"
end if

dw_step.object.step_desc[4] = ls_Text
hpb_progress.Position = 0

dw_step.SetRedraw(true)
//MessageBox("","")

Return 1
end function

public function integer of_setcomplete ();cb_close.Enabled = true
this.Title = "Import"

st_complete.Show()
st_remain.Hide()
st_table.Hide()
st_importid.Hide()
st_count.Hide()

of_SkipNextStep()

Return 1
end function

public function long of_messagebox (string as_caption, string as_text, long al_type);//Add by Evan 05.03.2011

long ll_Wnd
long ll_Return

ll_Wnd = Handle(this)
ll_Return = MessageBoxA(ll_Wnd, as_Text, as_Caption, al_Type)

Return ll_Return // 6-YES, 7-NO
end function

public function integer of_setpraccount (integer ai_count);//////////////////////////////////////////////////////////////////////
// $<Function> of_setpraccount
// $<arguments>
// $<returns> long
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.16.2013 by Stephen
//////////////////////////////////////////////////////////////////////

st_count.Text = "Import provider count:   " + String(ai_Count)

Return 1
end function

public function integer of_setremainprac (integer al_count);//////////////////////////////////////////////////////////////////////
// $<Function> of_setremainprac
// $<arguments>
// $<returns> long
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.16.2013 by Stephen
//////////////////////////////////////////////////////////////////////

il_RemainTableCount = al_Count
st_remain.Text = "Remain provider count: " + String(al_Count)

Return 1
end function

public function integer of_setpracname (string as_prac);//////////////////////////////////////////////////////////////////////
// $<Function> of_setpracname
// $<arguments>
// $<returns> long
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.16.2013 by Stephen
//////////////////////////////////////////////////////////////////////

st_table.Text = "Current provider name: " + as_prac

Return 1
end function

public function integer of_setauditprocessdesc (string as_description);//////////////////////////////////////////////////////////////////////
// $<Function> of_setauditprocessdesc
// $<arguments>
// $<returns> integer
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.21.2013 by Stephen
//////////////////////////////////////////////////////////////////////

string ls_Text

if LenA(as_Description) > 0 then
	ls_Text = "2. Import data into IntelliSoft table ---> " + as_Description + "..."
else
	ls_Text = "2. Import data into IntelliSoft table"
end if

dw_step.object.step_desc[2] = ls_Text

dw_step.SetRedraw(true)

Return 1
end function

public function integer of_auditnextstep ();//////////////////////////////////////////////////////////////////////
// $<Function> of_auditnextstep
// $<arguments>
// $<returns> integer
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.21.2013 by Stephen
//////////////////////////////////////////////////////////////////////

if dw_step.GetRow() < dw_step.RowCount() then
	dw_step.object.pic_flag[dw_step.GetRow()] = 2  //Finish Step
	dw_step.ScrollNextRow()
	dw_step.object.pic_flag[dw_step.GetRow()] = 1  //Current Step
else
	dw_step.object.pic_flag[dw_step.RowCount()] = 2 //Finish Step
end if
this.SetRedraw(true)
//MessageBox("","")

Return 1
end function

on w_import_progressbar.create
this.cb_break=create cb_break
this.st_complete=create st_complete
this.cb_close=create cb_close
this.st_remain=create st_remain
this.st_table=create st_table
this.st_importid=create st_importid
this.st_count=create st_count
this.st_temp=create st_temp
this.dw_step=create dw_step
this.hpb_progress=create hpb_progress
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.Control[]={this.cb_break,&
this.st_complete,&
this.cb_close,&
this.st_remain,&
this.st_table,&
this.st_importid,&
this.st_count,&
this.st_temp,&
this.dw_step,&
this.hpb_progress,&
this.ln_1,&
this.ln_2,&
this.ln_3}
end on

on w_import_progressbar.destroy
destroy(this.cb_break)
destroy(this.st_complete)
destroy(this.cb_close)
destroy(this.st_remain)
destroy(this.st_table)
destroy(this.st_importid)
destroy(this.st_count)
destroy(this.st_temp)
destroy(this.dw_step)
destroy(this.hpb_progress)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
end on

event closequery;if not cb_close.Enabled then 
	Return 1
end if
end event

type cb_break from commandbutton within w_import_progressbar
boolean visible = false
integer x = 1202
integer y = 848
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Break"
end type

event clicked;ib_break = true
end event

type st_complete from statictext within w_import_progressbar
boolean visible = false
integer x = 370
integer y = 60
integer width = 1440
integer height = 88
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
string text = "Process import data completed!"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_import_progressbar
integer x = 1609
integer y = 848
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Close"
boolean default = true
end type

event clicked;Close(Parent)
end event

type st_remain from statictext within w_import_progressbar
integer x = 59
integer y = 132
integer width = 663
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "Remain table count: 0"
boolean focusrectangle = false
end type

type st_table from statictext within w_import_progressbar
integer x = 791
integer y = 132
integer width = 1271
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "Current import table: "
boolean focusrectangle = false
end type

type st_importid from statictext within w_import_progressbar
integer x = 791
integer y = 32
integer width = 1271
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "Current import ID: 0"
boolean focusrectangle = false
end type

type st_count from statictext within w_import_progressbar
integer x = 59
integer y = 32
integer width = 663
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "Import table count:   0"
boolean focusrectangle = false
end type

type st_temp from statictext within w_import_progressbar
integer width = 2121
integer height = 212
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean focusrectangle = false
end type

type dw_step from datawindow within w_import_progressbar
integer x = 14
integer y = 240
integer width = 2021
integer height = 420
integer taborder = 10
string title = "none"
string dataobject = "d_import_prog_step"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;if AppeonGetClientType() = 'PB' Then
	this.object.p_1.filename = gs_current_path + "\CHECK.BMP"
	this.object.p_2.filename = gs_current_path + "\rightarrow.bmp"	
end if
end event

type hpb_progress from hprogressbar within w_import_progressbar
integer x = 23
integer y = 684
integer width = 2011
integer height = 104
unsignedinteger maxposition = 100
integer setstep = 1
end type

type ln_1 from line within w_import_progressbar
long linecolor = 268435456
integer linethickness = 4
integer beginx = -9
integer beginy = 216
integer endx = 2126
integer endy = 216
end type

type ln_2 from line within w_import_progressbar
long linecolor = 268435456
integer linethickness = 4
integer beginx = -9
integer beginy = 816
integer endx = 2062
integer endy = 816
end type

type ln_3 from line within w_import_progressbar
long linecolor = 1073741824
integer linethickness = 4
integer beginx = -9
integer beginy = 820
integer endx = 2062
integer endy = 820
end type

