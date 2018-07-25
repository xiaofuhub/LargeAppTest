$PBExportHeader$w_security_quest_lookup.srw
forward
global type w_security_quest_lookup from window
end type
type cb_1 from commandbutton within w_security_quest_lookup
end type
type cb_del from commandbutton within w_security_quest_lookup
end type
type cb_add from commandbutton within w_security_quest_lookup
end type
type cb_save from commandbutton within w_security_quest_lookup
end type
type cb_close from commandbutton within w_security_quest_lookup
end type
type dw_1 from datawindow within w_security_quest_lookup
end type
end forward

global type w_security_quest_lookup from window
integer width = 3561
integer height = 1896
boolean titlebar = true
string title = "Security Questions"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
cb_del cb_del
cb_add cb_add
cb_save cb_save
cb_close cb_close
dw_1 dw_1
end type
global w_security_quest_lookup w_security_quest_lookup

on w_security_quest_lookup.create
this.cb_1=create cb_1
this.cb_del=create cb_del
this.cb_add=create cb_add
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.cb_del,&
this.cb_add,&
this.cb_save,&
this.cb_close,&
this.dw_1}
end on

on w_security_quest_lookup.destroy
destroy(this.cb_1)
destroy(this.cb_del)
destroy(this.cb_add)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.dw_1)
end on

event open; //Start Code Change ----12.10.2015 #V15 maha - new window
 string ls_path
 n_appeon_download lnv_download //BugA083001 - Alfee 08.30.2016
 
dw_1.settransobject(sqlca)
dw_1.retrieve()
debugbreak()
ls_path = gs_current_path + "\Intellicred\security question data.txt"  //Start Code Change ----10.03.2016 #V152 maha - changed path to avoid issue with temp file

if dw_1.rowcount() = 0 then
	//ls_path = gs_dir_path + "security question data.txt"
	
	
	if not fileexists(ls_path) and appeongetclienttype() = 'WEB' then
		lnv_download.of_downloadfile("", ls_path)  //BugA083001  - Alfee 08.30.2016
	end if
	
	if fileexists(ls_path) then
		//messagebox("",ls_path)
		dw_1.importfile( ls_path)
	end if
end if


	
	
end event

type cb_1 from commandbutton within w_security_quest_lookup
integer x = 18
integer y = 20
integer width = 425
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Find Import File"
end type

event clicked;string ls_path

string docpath, docname[]

integer i, li_cnt, li_rtn, li_filenum

 debugbreak()

li_rtn = GetFileOpenName("Select File", &
   docpath, docname[], "DOC", &
   + "Text Files (*.TXT),*.TXT," &
   + "Doc Files (*.DOC),*.DOC," &
   + "All Files (*.*), *.*", &
   gs_current_directory, 18)
	
IF li_rtn < 1 THEN return

ls_path = docname[1]

if fileexists(ls_path) then
	//messagebox("",ls_path)
	dw_1.importfile(ls_path)
end if
end event

type cb_del from commandbutton within w_security_quest_lookup
integer x = 2048
integer y = 16
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;integer qid
integer r
long ll_cnt

r = dw_1.getrow( )

if r > 0 then
	ll_cnt = dw_1.getitemnumber(r,"user_count")
	if qid > 0 then
		messagebox("Delete","There are " + string(ll_cnt) + " user security questions connected to this record.  It cannot be deleted.  To disallow future selection, set to inactive.")
	else
		dw_1.deleterow(r)
	end if
end if

end event

type cb_add from commandbutton within w_security_quest_lookup
integer x = 1701
integer y = 16
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;integer nr

nr = dw_1.insertrow(0)

dw_1.setrow(nr)
dw_1.scrolltorow(nr)

dw_1.setitem(nr,"active_status", 1)
dw_1.setitem(nr,"add_date", datetime(today(),Now()))

end event

type cb_save from commandbutton within w_security_quest_lookup
integer x = 1353
integer y = 16
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;integer r
long qid

dw_1.accepttext() //BugA071101 - alfee 07.26.2016

//see if any new
for r = 1 to dw_1.rowcount()
	if isnull(dw_1.getitemnumber(r,"quest_id")) then
		qid = -1
		exit
	end if
next

//question_desc is required. Added by Appeon long.zhang 07.18.2016 (BugA071101)
for r = 1 to dw_1.rowcount()
	if isnull(dw_1.GetItemString(r,"question_desc")) then
		Messagebox('Save','Question Desc is required.')
		Return -1
	end if
next

//if any new get max and set the id for those missing
if qid = -1 then
	select max(quest_id) into :qid from security_quest_lookup;
	if isnull(qid) then qid = 0
	
	for r = 1 to dw_1.rowcount()
		if isnull(dw_1.getitemnumber(r,"quest_id")) then
			qid++
			dw_1.setitem(r,"quest_id", qid)
		end if		
	next
end if

dw_1.update()
end event

type cb_close from commandbutton within w_security_quest_lookup
integer x = 3195
integer y = 16
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_security_quest_lookup
integer y = 124
integer width = 3547
integer height = 1688
integer taborder = 10
string title = "none"
string dataobject = "d_security_quest_browse"
boolean vscrollbar = true
boolean livescroll = true
end type

