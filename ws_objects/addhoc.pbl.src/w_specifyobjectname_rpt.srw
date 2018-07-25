$PBExportHeader$w_specifyobjectname_rpt.srw
$PBExportComments$(Appeon)Toney 06.11.2013 - V141 ISG-CLX
forward
global type w_specifyobjectname_rpt from window
end type
type st_warning from statictext within w_specifyobjectname_rpt
end type
type cb_cancel from commandbutton within w_specifyobjectname_rpt
end type
type cb_ok from commandbutton within w_specifyobjectname_rpt
end type
type sle_objectname from singlelineedit within w_specifyobjectname_rpt
end type
type st_name from statictext within w_specifyobjectname_rpt
end type
type sle_prefix from singlelineedit within w_specifyobjectname_rpt
end type
end forward

global type w_specifyobjectname_rpt from window
integer width = 1202
integer height = 508
boolean titlebar = true
string title = "Please specify the new object name"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_warning st_warning
cb_cancel cb_cancel
cb_ok cb_ok
sle_objectname sle_objectname
st_name st_name
sle_prefix sle_prefix
end type
global w_specifyobjectname_rpt w_specifyobjectname_rpt

type variables
u_cst_dw_band   idw_band

CONSTANT STRING is_Prefix = "object"

end variables

forward prototypes
public function string of_objnameverify (string as_name)
end prototypes

public function string of_objnameverify (string as_name);String	ls_SingleLetter,ls_Objects
long		ll_Cycle,ll_Length

CONSTANT STRING TABCHAR = "~t"
CONSTANT STRING ERROR_NOTVALID   = "This object name is not valid."
CONSTANT STRING ERROR_NAMEREPEAT = "This object name already exists."

as_Name = Lower(as_Name)

ls_SingleLetter = LeftA(as_Name,1)
if Not (ls_SingleLetter >= 'a' and ls_SingleLetter <= 'z') then
	Return ERROR_NOTVALID
end if

ll_Length = LenA(as_Name)
for ll_Cycle = 2 to ll_Length
	ls_SingleLetter = MidA(as_Name,ll_Cycle,1)
	if Not (ls_SingleLetter >= 'a' and ls_SingleLetter <= 'z' or ls_SingleLetter >= '0' and ls_SingleLetter <= '9' or ls_SingleLetter = '_') then
		Return ERROR_NOTVALID
	end if
next

ls_Objects = TABCHAR + idw_band.Describe("DataWindow.Objects") + TABCHAR
if PosA(ls_Objects,TABCHAR + as_Name + TABCHAR) > 0 then
	Return ERROR_NAMEREPEAT
end if

Return ""

end function

on w_specifyobjectname_rpt.create
this.st_warning=create st_warning
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.sle_objectname=create sle_objectname
this.st_name=create st_name
this.sle_prefix=create sle_prefix
this.Control[]={this.st_warning,&
this.cb_cancel,&
this.cb_ok,&
this.sle_objectname,&
this.st_name,&
this.sle_prefix}
end on

on w_specifyobjectname_rpt.destroy
destroy(this.st_warning)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.sle_objectname)
destroy(this.st_name)
destroy(this.sle_prefix)
end on

event open;String	ls_NewObjName

idw_band = Message.PowerObjectParm
ls_NewObjName = idw_band.is_NewObjName

if LeftA(ls_NewObjName,LenA(is_Prefix)) = is_Prefix then
	sle_Prefix.Text = is_Prefix
	sle_ObjectName.Text = MidA(ls_NewObjName,LenA(is_Prefix) + 1)
else
	sle_Prefix.Text = ""
	sle_ObjectName.Text = ls_NewObjName
end if

sle_ObjectName.SelectText(LenA(sle_ObjectName.Text) + 1,0)

end event

type st_warning from statictext within w_specifyobjectname_rpt
boolean visible = false
integer x = 101
integer y = 200
integer width = 992
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 134217857
long backcolor = 33551856
string text = "This object name already exists."
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_specifyobjectname_rpt
integer x = 750
integer y = 284
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,"")
end event

type cb_ok from commandbutton within w_specifyobjectname_rpt
integer x = 366
integer y = 284
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&OK"
boolean default = true
end type

event clicked;String	ls_ObjName,ls_Error

ls_ObjName = Lower(sle_Prefix.Text) + Lower(Trim(sle_ObjectName.Text))

ls_Error = of_ObjNameVerify(ls_ObjName)
if Not (IsNull(ls_Error) or Trim(ls_Error) = "") then
	st_Warning.Text = ls_Error
	st_Warning.Visible = true
	sle_ObjectName.SetFocus()
	Return
end if

CloseWithReturn(Parent,ls_ObjName)

end event

type sle_objectname from singlelineedit within w_specifyobjectname_rpt
integer x = 411
integer y = 92
integer width = 672
integer height = 72
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean border = false
textcase textcase = lower!
borderstyle borderstyle = stylelowered!
end type

type st_name from statictext within w_specifyobjectname_rpt
integer x = 101
integer y = 96
integer width = 165
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Name:"
boolean focusrectangle = false
end type

type sle_prefix from singlelineedit within w_specifyobjectname_rpt
integer x = 265
integer y = 80
integer width = 827
integer height = 92
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8421504
long backcolor = 16777215
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

