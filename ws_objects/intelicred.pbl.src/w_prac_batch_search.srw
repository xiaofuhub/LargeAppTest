$PBExportHeader$w_prac_batch_search.srw
forward
global type w_prac_batch_search from window
end type
type st_select from statictext within w_prac_batch_search
end type
type cb_default from commandbutton within w_prac_batch_search
end type
type cb_batch from commandbutton within w_prac_batch_search
end type
type st_batch from statictext within w_prac_batch_search
end type
type cb_2 from commandbutton within w_prac_batch_search
end type
type dw_1 from datawindow within w_prac_batch_search
end type
end forward

global type w_prac_batch_search from window
integer x = 585
integer y = 932
integer width = 2665
integer height = 420
windowtype windowtype = response!
long backcolor = 33551856
st_select st_select
cb_default cb_default
cb_batch cb_batch
st_batch st_batch
cb_2 cb_2
dw_1 dw_1
end type
global w_prac_batch_search w_prac_batch_search

type variables
integer ii_screen
long il_batch_id
end variables

on w_prac_batch_search.create
this.st_select=create st_select
this.cb_default=create cb_default
this.cb_batch=create cb_batch
this.st_batch=create st_batch
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.st_select,&
this.cb_default,&
this.cb_batch,&
this.st_batch,&
this.cb_2,&
this.dw_1}
end on

on w_prac_batch_search.destroy
destroy(this.st_select)
destroy(this.cb_default)
destroy(this.cb_batch)
destroy(this.st_batch)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;integer f
string ls_batch
il_batch_id = message.doubleparm

dw_1.settransobject(sqlca)
dw_1.retrieve()

datawindowchild dwchild
dw_1.GetChild("batch_id", dwchild)
dwchild.SetTransObject(Sqlca)
dwchild.InsertRow(1)
dwchild.SetItem(1, "batch_id", -999)
dwchild.SetItem(1, "batch_name", "")
dw_1.SetItem(1, "batch_id", -999)

if il_batch_id > 0 then
	f = dwchild.find( "batch_id = " + string(il_batch_id), 1, dwchild.rowcount())
	if f > 0 then
		ls_batch = dwchild.getitemstring(f,"batch_name")
		st_batch.text = "Default Batch - " + ls_batch
		st_select.visible = true   //Start Code Change ----11.02.2015 #V15 maha
	else
		st_batch.text = "Please select an existing batch or Click Batch Search to create a batch."
		cb_default.enabled = false
	end if
end if
		
//Start Code Change ----03.01.2010 #V10 maha - added security from batch select buttons
if w_mdi.of_security_access(2000) = 0 then
	cb_batch.enabled = false
end if
//End Code Change---03.01.2010


end event

type st_select from statictext within w_prac_batch_search
boolean visible = false
integer x = 64
integer y = 160
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Batch"
boolean focusrectangle = false
end type

type cb_default from commandbutton within w_prac_batch_search
integer x = 1463
integer y = 228
integer width = 521
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Use &Default"
boolean default = true
end type

event clicked;closewithreturn(parent,il_batch_id  )
end event

type cb_batch from commandbutton within w_prac_batch_search
integer x = 923
integer y = 228
integer width = 521
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Batch Search"
boolean default = true
end type

event clicked;gs_batch_search lstr_batch

open(w_batch_prac_select_new)

//------------------- APPEON BEGIN -------------------
//$<modify> Stephen 09.19.2011
//$<reason> The My Batch 1 / My Batch 2 button in Practitioner Folder can’t work -BugS090702
/*
il_batch_id = message.doubleparm
closewithreturn(parent,il_batch_id)
*/
lstr_batch = message.powerobjectparm
closewithreturn(parent,lstr_batch)
//------------------- APPEON END -------------------
end event

type st_batch from statictext within w_prac_batch_search
integer x = 256
integer y = 60
integer width = 2034
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
string text = "Please select an existing batch or Click Batch Search to create a batch."
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_prac_batch_search
integer x = 1998
integer y = 228
integer width = 521
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;closewithreturn(parent,"C")
end event

type dw_1 from datawindow within w_prac_batch_search
integer x = 55
integer y = 228
integer width = 841
integer height = 84
integer taborder = 30
string dataobject = "d_d_batch_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//ii_screen = integer(data)
//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 01.13.2006 By: Liuhongxin
//$<reason> Fix a defect.
if Long(data) = -999 then return 0
//---------------------------- APPEON END ----------------------------

closewithreturn(parent,long(data))
end event

