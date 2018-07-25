$PBExportHeader$w_caqh_update_mapping_fields.srw
forward
global type w_caqh_update_mapping_fields from window
end type
type cb_save from commandbutton within w_caqh_update_mapping_fields
end type
type cb_filter from commandbutton within w_caqh_update_mapping_fields
end type
type cb_sort from commandbutton within w_caqh_update_mapping_fields
end type
type st_1 from statictext within w_caqh_update_mapping_fields
end type
type cb_quit from commandbutton within w_caqh_update_mapping_fields
end type
type dw_fields from datawindow within w_caqh_update_mapping_fields
end type
type cb_run from commandbutton within w_caqh_update_mapping_fields
end type
end forward

global type w_caqh_update_mapping_fields from window
integer width = 4978
integer height = 2332
boolean titlebar = true
string title = "CAQH Added Fields"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_save cb_save
cb_filter cb_filter
cb_sort cb_sort
st_1 st_1
cb_quit cb_quit
dw_fields dw_fields
cb_run cb_run
end type
global w_caqh_update_mapping_fields w_caqh_update_mapping_fields

type variables

end variables

on w_caqh_update_mapping_fields.create
this.cb_save=create cb_save
this.cb_filter=create cb_filter
this.cb_sort=create cb_sort
this.st_1=create st_1
this.cb_quit=create cb_quit
this.dw_fields=create dw_fields
this.cb_run=create cb_run
this.Control[]={this.cb_save,&
this.cb_filter,&
this.cb_sort,&
this.st_1,&
this.cb_quit,&
this.dw_fields,&
this.cb_run}
end on

on w_caqh_update_mapping_fields.destroy
destroy(this.cb_save)
destroy(this.cb_filter)
destroy(this.cb_sort)
destroy(this.st_1)
destroy(this.cb_quit)
destroy(this.dw_fields)
destroy(this.cb_run)
end on

event open;//Start Code Change ---- 05.31.2006 #491 maha
//window and all code created maha 053106
end event

type cb_save from commandbutton within w_caqh_update_mapping_fields
integer x = 37
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked; dw_fields.update()
	commit using sqlca;

end event

type cb_filter from commandbutton within w_caqh_update_mapping_fields
integer x = 416
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;string null_str

SetNull(null_str)

dw_fields.SetFilter(null_str)

dw_fields.Filter()



end event

type cb_sort from commandbutton within w_caqh_update_mapping_fields
integer x = 786
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_fields.Setsort(null_str)

dw_fields.sort()


end event

type st_1 from statictext within w_caqh_update_mapping_fields
integer x = 64
integer y = 156
integer width = 3223
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "This utility is for replacing the existing CAQH mapping fields with the records in the import file."
boolean focusrectangle = false
end type

type cb_quit from commandbutton within w_caqh_update_mapping_fields
integer x = 4507
integer y = 36
integer width = 343
integer height = 92
integer taborder = 30
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

type dw_fields from datawindow within w_caqh_update_mapping_fields
integer x = 37
integer y = 264
integer width = 4887
integer height = 1936
integer taborder = 10
string title = "none"
string dataobject = "d_caqh_mapping_fields_imp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;//integer r
//integer tid
//
//r = this.getclickedrow()
//this.scrolltorow(r)
//this.setrow(r)
//this.selectrow(0,false)
//this.selectrow(r,true)
//
//tid = this.getitemnumber(r,"table_id")
//dw_fields.retrieve(tid)
end event

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

type cb_run from commandbutton within w_caqh_update_mapping_fields
integer x = 4133
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Re-Import"
end type

event clicked;integer t
integer tc
integer tid
long ll_fid
string ls_path
string docname[]
string docpath

ls_path = gs_temp_path + "caqh_mapping_fields_data.txt"

if not fileexists(ls_path) then
	if messagebox("File not found:" + ls_path,"Unable to file the caqh_mapping_fields_data.txt file.  Would you like to browse for it?", question!, yesno!, 1) = 1 then
		t = GetFileOpenName("Select File",    ls_path, docname[], "TXT",    + "Text Files (*.TXT),*.TXT," ,   gs_dir_path + "intellicred/", 18)
	end if
end if

dw_fields.reset()
t = dw_fields.importfile(ls_path)

//for tid = 1 to t
//	dw_fields.setitem(tid,"Record_num",tid)
//next

if t < 0 then
	messagebox("Import","Import Failed")
	return
else
	tc = messagebox("Import","Do you wish to replace the existing mapping fields", question!, yesno!, 1) 
	if tc = 2 then return
end if

delete from caqh_mapping_fields;

if dw_fields.update() > 0 then
	commit using sqlca;
	messagebox("Finished","Import completed")
else
	rollback using sqlca;
	messagebox("Finished","Import failed.")
end if


end event

