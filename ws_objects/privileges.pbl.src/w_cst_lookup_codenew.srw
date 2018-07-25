$PBExportHeader$w_cst_lookup_codenew.srw
forward
global type w_cst_lookup_codenew from w_main
end type
type cb_save from u_cb within w_cst_lookup_codenew
end type
type cb_close from u_cb within w_cst_lookup_codenew
end type
type sle_desc from singlelineedit within w_cst_lookup_codenew
end type
type sle_code from singlelineedit within w_cst_lookup_codenew
end type
type st_2 from statictext within w_cst_lookup_codenew
end type
type st_1 from statictext within w_cst_lookup_codenew
end type
type gb_1 from groupbox within w_cst_lookup_codenew
end type
end forward

global type w_cst_lookup_codenew from w_main
integer width = 1723
integer height = 640
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
cb_save cb_save
cb_close cb_close
sle_desc sle_desc
sle_code sle_code
st_2 st_2
st_1 st_1
gb_1 gb_1
end type
global w_cst_lookup_codenew w_cst_lookup_codenew

type variables
string is_lookname
n_cst_code_lookup_audit inv_audit
gs_code_lookup   istr_lookup
end variables

on w_cst_lookup_codenew.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.cb_close=create cb_close
this.sle_desc=create sle_desc
this.sle_code=create sle_code
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.sle_desc
this.Control[iCurrent+4]=this.sle_code
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.gb_1
end on

on w_cst_lookup_codenew.destroy
call super::destroy
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.sle_desc)
destroy(this.sle_code)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 03.28.2011
//////////////////////////////////////////////////////////////////////

is_lookname = message.stringparm

if is_lookname = 'Priv Clinical Area' then
	this.title = 'Add Lookup - Clinical Area'
else
	this.title = 'Add Lookup - Subsection'
end if

this.move(w_mdi.pointerx(),w_mdi.pointery() - this.height / 2)


end event

type cb_save from u_cb within w_cst_lookup_codenew
integer x = 1010
integer y = 436
integer width = 325
integer taborder = 30
boolean bringtotop = true
string text = "&Ok"
boolean default = true
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 03.28.2011
//////////////////////////////////////////////////////////////////////

long ll_lookup_code , ll_cnt, li_retval
string ls_code, ls_desc

ls_code = trim(sle_code.text)
ls_desc = trim(sle_desc.text)
if isnull(ls_code) or trim(ls_code) = '' then
	messagebox('IntelliSoftGroup','Required value missing for code. ' + 'Please enter a value.')
	sle_code.setfocus()
	return
end if
if isnull(ls_desc) or trim(ls_desc) = '' then
	messagebox('IntelliSoftGroup','Required value missing for description. ' + 'Please enter a value.')
	sle_desc.setfocus()
	return
end if	

select count(1)
   into :ll_cnt
  from code_lookup
 where lookup_name = :is_lookname
    and (code = :ls_code or description = :ls_desc);

if  ll_cnt > 0 then
	messagebox('Update error','Code or Description is not unique. ')
	return
end if
	 
ll_lookup_code = gnv_app.of_get_id("LOOKUP")

insert into code_lookup(lookup_code, lookup_name, code, description)
  values(:ll_lookup_code, :is_lookname, :ls_code, :ls_desc);

if SQLCA.SQLCode = 0 then
	COMMIT;
	istr_lookup.lookup_code = ll_lookup_code
	istr_lookup.description = ls_desc
	Closewithreturn(Parent, istr_lookup)
else
	ROLLBACK;
	MessageBox("Save "+is_lookname, "Failed to save "+ is_lookname +".~r~n" + SQLCA.SQLErrText, StopSign!)
end if



end event

type cb_close from u_cb within w_cst_lookup_codenew
integer x = 1349
integer y = 436
integer width = 325
integer taborder = 40
boolean bringtotop = true
string text = "&Cancel"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 03.28.2011
//////////////////////////////////////////////////////////////////////

Close(Parent)
end event

type sle_desc from singlelineedit within w_cst_lookup_codenew
integer x = 357
integer y = 256
integer width = 1271
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_code from singlelineedit within w_cst_lookup_codenew
integer x = 357
integer y = 128
integer width = 759
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_cst_lookup_codenew
integer x = 27
integer y = 268
integer width = 315
integer height = 116
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Description:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_cst_lookup_codenew
integer x = 183
integer y = 144
integer width = 160
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Code:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_cst_lookup_codenew
integer x = 23
integer y = 20
integer width = 1646
integer height = 396
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Please enter the Code and Description "
end type

