$PBExportHeader$w_ocr_import_applications.srw
forward
global type w_ocr_import_applications from w_master
end type
type cb_del from commandbutton within w_ocr_import_applications
end type
type cb_save from commandbutton within w_ocr_import_applications
end type
type cb_add from commandbutton within w_ocr_import_applications
end type
type cb_2 from commandbutton within w_ocr_import_applications
end type
type cb_1 from commandbutton within w_ocr_import_applications
end type
type cb_close from commandbutton within w_ocr_import_applications
end type
type dw_1 from u_dw within w_ocr_import_applications
end type
end forward

global type w_ocr_import_applications from w_master
integer width = 3634
integer height = 2136
string title = "OCR Applications"
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_del cb_del
cb_save cb_save
cb_add cb_add
cb_2 cb_2
cb_1 cb_1
cb_close cb_close
dw_1 dw_1
end type
global w_ocr_import_applications w_ocr_import_applications

type variables
long il_appid, il_ocr_id
boolean ib_new = false
end variables

on w_ocr_import_applications.create
int iCurrent
call super::create
this.cb_del=create cb_del
this.cb_save=create cb_save
this.cb_add=create cb_add
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_close=create cb_close
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_del
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_add
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.dw_1
end on

on w_ocr_import_applications.destroy
call super::destroy
destroy(this.cb_del)
destroy(this.cb_save)
destroy(this.cb_add)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_close)
destroy(this.dw_1)
end on

event open;//====================================================================
//$<Event>: open
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.27.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_id   //maha 07.29.2014
long c        //maha 07.29.2014
long r

c = dw_1.retrieve()

//Start Code Change ----07.29.2014 #V14.2 maha - added to find row if opened from the treeview
ll_id =  message.doubleparm 

if ll_id > 0 and c > 0 then
	r = dw_1.find(" app_id = " + string(ll_id),1, c)
	if r > 0 then
		dw_1.setrow(r)
	end if
end if
	
	
end event

event resize;//====================================================================
//$<Event>: resize
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.27.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

dw_1.width = newwidth - 19 //50 - alfee 10.22.2014
dw_1.height = newheight - 150
end event

event closequery;call super::closequery;//====================================================================
//$<Event>: closequery
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.28.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_ret

if dw_1.modifiedcount() > 0 then
	li_ret = messagebox("Prompt", "Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	if li_ret = 1 then
		if cb_save.triggerevent(clicked!) = 1 then return 0
	end if
	if li_ret = 2 then return 0
	return 1
end if

return 0
end event

type cb_del from commandbutton within w_ocr_import_applications
integer x = 713
integer y = 28
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.27.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_id
string ls_path
dwitemstatus lds_new

if dw_1.accepttext() = -1 then return
if dw_1.GetRow() < 1 then Return
lds_new = dw_1.getitemstatus(dw_1.GetRow(), 0, primary!)
if lds_new = new! then 
	dw_1.deleterow(dw_1.GetRow())
	return
end if

ll_id = dw_1.getitemnumber(dw_1.GetRow(), "ocr_id")
if MessageBox("Delete", "Are you sure you want to delete the selected record?", Question!, YesNo!, 2) = 2 then
	Return 
end if
dw_1.deleterow(0)

ls_path = gs_temp_path +"ocr_imp\"
ls_path = ls_path + "ocr_imp_"+string(ll_id) +".txt"
if fileexists(ls_path) then filedelete(ls_path)

gnv_appeondb.of_StartQueue()
delete from ocr_appl_fields where ocr_id = :ll_id using sqlca ;
dw_1.update()
gnv_appeondb.of_CommitQueue()
commit using sqlca;
end event

type cb_save from commandbutton within w_ocr_import_applications
integer x = 9
integer y = 28
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.27.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_row, ll_ocr_id
long ll_app_id
string ls_ocr_name
dwitemstatus lds_new

if dw_1.accepttext() = -1 then return -1
for ll_row = 1 to dw_1.rowcount()
	lds_new = dw_1.getitemstatus(ll_row, 0, primary!)	
	ls_ocr_name = dw_1.getitemstring(ll_row, "ocr_name")
	ll_app_id = dw_1.getitemnumber(ll_row, "app_id")
	
	if isnull(ls_ocr_name) or ls_ocr_name = "" or lds_new = new! then
		MessageBox("Required Data Missing", "You must fill in the Ocr Name." )
		dw_1.scrolltorow(ll_row)
		dw_1.setcolumn("ocr_name")
		dw_1.setfocus()
		return -1
	end if
	
	if isnull(ll_app_id) or ll_app_id = 0 or lds_new = new! then
		MessageBox("Required Data Missing", "Please first select Application !" )
		dw_1.scrolltorow(ll_row)
		dw_1.setcolumn("app_id")
		dw_1.setfocus()
		return -1
	end if
	
	if lds_new = newmodified! then
		if isnull(ll_ocr_id) or ll_ocr_id = 0 then
			select max(ocr_id) into :ll_ocr_id from ocr_appl using sqlca;
			if isnull(ll_ocr_id) then ll_ocr_id = 0
		end if
		ll_ocr_id = ll_ocr_id + 1
		dw_1.setitem(ll_row, "ocr_id", ll_ocr_id)
		dw_1.setitem(ll_row, "create_date", datetime(today(), now()))
		dw_1.setitem(ll_row, "create_user", gs_user_id)
	elseif lds_new = datamodified! then
		dw_1.setitem(ll_row, "mod_date", datetime(today(), now()))
		dw_1.setitem(ll_row, "mod_user", gs_user_id)
	end if
next

if dw_1.Update() = 1 then
	Commit;
else
	Rollback;
	MessageBox("Error", "Failed to save data.", StopSign!)
	Return -1
end if
ib_new = false
return 1
end event

type cb_add from commandbutton within w_ocr_import_applications
integer x = 361
integer y = 28
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.27.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_row

if dw_1.accepttext() = -1 then return 
ll_row = dw_1.insertrow(0)
dw_1.setfocus()
dw_1.scrolltorow(ll_row)
dw_1.setcolumn('ocr_name')
ib_new = true

end event

type cb_2 from commandbutton within w_ocr_import_applications
integer x = 1856
integer y = 28
integer width = 526
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Open for &Processing"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.11.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_row
long ll_ocr_id ,ll_app_id, ll_imp_id
str_parm lstr_parm

ll_row = dw_1.getrow()
if ll_row < 1 then return

dw_1.accepttext()
if dw_1.modifiedcount() > 0 or ib_new then
	messagebox("Prompt", "Please save your changes first.")
	return
end if

ll_ocr_id = dw_1.getitemnumber(ll_row, "ocr_id")
ll_app_id = dw_1.getitemnumber(ll_row, "app_id")
select import_id into :ll_imp_id from ocr_appl where ocr_id = :ll_ocr_id using sqlca;
if isnull(ll_imp_id) or ll_imp_id = 0 then
	messagebox("Prompt", "Please create the associated import information for this record first .")
	return
end if

lstr_parm.l_wf_id = ll_ocr_id
lstr_parm.l_doc_id = ll_app_id
openwithparm(w_ocr_data_process, lstr_parm)

end event

type cb_1 from commandbutton within w_ocr_import_applications
integer x = 1349
integer y = 28
integer width = 489
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Open for &Mapping"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.28.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_row
str_parm lstr_parm

ll_row = dw_1.getrow()
if ll_row < 1 then return

dw_1.accepttext()
if dw_1.modifiedcount() > 0 or ib_new then
	messagebox("Prompt", "Please save your changes first.")
	return
end if
lstr_parm.l_wf_id = dw_1.getitemnumber(ll_row, "ocr_id")
lstr_parm.l_doc_id = dw_1.getitemnumber(ll_row, "app_id")
openwithparm(w_ocr_data_setup, lstr_parm)

end event

type cb_close from commandbutton within w_ocr_import_applications
integer x = 3241
integer y = 28
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.28.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
close(parent)
end event

type dw_1 from u_dw within w_ocr_import_applications
integer y = 140
integer width = 3589
integer height = 1884
integer taborder = 70
string dataobject = "d_ocr_appl"
richtexttoolbaractivation richtexttoolbaractivation = richtexttoolbaractivationnever!
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.28.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if currentrow < 1 then return
this.selectrow(0,false)
this.selectrow(currentrow, true)
end event

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.28.2014 (Using image OCR to import data into IntelliCred 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
This.of_SetUpdateAble( False )
end event

event clicked;call super::clicked;if row > 0 then event rowfocuschanged(row)
end event

