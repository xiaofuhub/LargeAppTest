$PBExportHeader$w_npdb_specialty_matching.srw
forward
global type w_npdb_specialty_matching from window
end type
type cb_6 from commandbutton within w_npdb_specialty_matching
end type
type cb_5 from commandbutton within w_npdb_specialty_matching
end type
type rb_code from radiobutton within w_npdb_specialty_matching
end type
type rb_both from radiobutton within w_npdb_specialty_matching
end type
type dw_2 from datawindow within w_npdb_specialty_matching
end type
type cb_4 from commandbutton within w_npdb_specialty_matching
end type
type cb_3 from commandbutton within w_npdb_specialty_matching
end type
type cb_2 from commandbutton within w_npdb_specialty_matching
end type
type cb_1 from commandbutton within w_npdb_specialty_matching
end type
type cb_save from commandbutton within w_npdb_specialty_matching
end type
type dw_1 from datawindow within w_npdb_specialty_matching
end type
type cb_close from commandbutton within w_npdb_specialty_matching
end type
type gb_1 from groupbox within w_npdb_specialty_matching
end type
end forward

global type w_npdb_specialty_matching from window
integer width = 3301
integer height = 2416
boolean titlebar = true
string title = "NPDB Lookup Codes"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_6 cb_6
cb_5 cb_5
rb_code rb_code
rb_both rb_both
dw_2 dw_2
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
cb_save cb_save
dw_1 dw_1
cb_close cb_close
gb_1 gb_1
end type
global w_npdb_specialty_matching w_npdb_specialty_matching

type variables
boolean ib_got = false
string is_code
string is_description
end variables

on w_npdb_specialty_matching.create
this.cb_6=create cb_6
this.cb_5=create cb_5
this.rb_code=create rb_code
this.rb_both=create rb_both
this.dw_2=create dw_2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_save=create cb_save
this.dw_1=create dw_1
this.cb_close=create cb_close
this.gb_1=create gb_1
this.Control[]={this.cb_6,&
this.cb_5,&
this.rb_code,&
this.rb_both,&
this.dw_2,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.cb_save,&
this.dw_1,&
this.cb_close,&
this.gb_1}
end on

on w_npdb_specialty_matching.destroy
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.rb_code)
destroy(this.rb_both)
destroy(this.dw_2)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_save)
destroy(this.dw_1)
destroy(this.cb_close)
destroy(this.gb_1)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve( )
dw_2.settransobject(sqlca)
dw_2.retrieve( )



end event

type cb_6 from commandbutton within w_npdb_specialty_matching
integer x = 1975
integer y = 36
integer width = 293
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Undo"
end type

event clicked;integer res
res = messagebox("Undo","This will undo all changes made after the last Save.  Continue?", question!,yesno!,2 )

if res = 1 then
	dw_2.retrieve()
end if
end event

type cb_5 from commandbutton within w_npdb_specialty_matching
integer x = 2272
integer y = 36
integer width = 293
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Help"
end type

event clicked;messagebox("To use this utility","1) Click Match on Descriptions to update npdb codes where the descriptions exactly match.~n 2) To update records manually, doubleclick the NPDB Specialty Codes record you want, then click the Practitioner Specialty Record you wish to update.~n 3) Click save to save changes.  Click Undo to undo all changes after the last save." )
end event

type rb_code from radiobutton within w_npdb_specialty_matching
integer x = 827
integer y = 56
integer width = 498
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "NPDB code only"
boolean checked = true
end type

type rb_both from radiobutton within w_npdb_specialty_matching
integer x = 55
integer y = 52
integer width = 741
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "NPDB Code and description"
end type

type dw_2 from datawindow within w_npdb_specialty_matching
integer x = 23
integer y = 168
integer width = 1545
integer height = 2084
integer taborder = 20
boolean titlebar = true
string title = "Practitioner Specialties"
string dataobject = "d_npdb_specialty_lookups"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;if ib_got then
	if row > 0 then
		if rb_both.checked then
			this.setitem(row,"description", is_description)
		end if
		this.setitem(row,"ic_c", is_code)
		ib_got = false
	end if
end if
end event

type cb_4 from commandbutton within w_npdb_specialty_matching
integer x = 1408
integer y = 36
integer width = 562
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Match on Descriptions"
end type

event clicked;integer i
integer s
integer cnt
string ls_npdb
string ls_spec
string ls_sql
n_cst_npdb lnv_npdb

i = messagebox("Match","This will scan the list of NPDB codes and match them to the Specialty NPDB codes by descriptions.  Continue?" ,question!,yesno!,1)
if i = 2 then return

debugbreak()
for i = 1 to dw_1.rowcount() 
	ls_npdb = dw_1.getitemstring(i,"npdb_list_code_description")
	for s = 1 to dw_2.rowcount()
		ls_spec = dw_2.getitemstring(s,"description")
		if ls_npdb = ls_spec then
			dw_2.setitem(s,"ic_c",dw_1.getitemstring(i,"npdb_list_code"))
			cnt++
			
		end if
	next
next
messagebox("Matches", string (cnt) + " matches found.")
//dw_2.update()


end event

type cb_3 from commandbutton within w_npdb_specialty_matching
boolean visible = false
integer x = 1033
integer y = 2200
integer width = 343
integer height = 92
integer taborder = 30
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

dw_1.Setsort(null_str)

dw_1.sort()
end event

type cb_2 from commandbutton within w_npdb_specialty_matching
boolean visible = false
integer x = 1422
integer y = 2196
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

dw_1.SetFilter(null_str)

dw_1.Filter()
end event

type cb_1 from commandbutton within w_npdb_specialty_matching
boolean visible = false
integer x = 1792
integer y = 2200
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;dw_1.insertrow(1)
end event

type cb_save from commandbutton within w_npdb_specialty_matching
integer x = 2574
integer y = 36
integer width = 293
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_2.update()
end event

type dw_1 from datawindow within w_npdb_specialty_matching
integer x = 1627
integer y = 168
integer width = 1545
integer height = 2084
integer taborder = 10
boolean titlebar = true
string title = "NPDB Specialty Codes"
string dataobject = "d_npdb_list_d_specialties"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;
if row > 0 then
	ib_got = true
	is_code = this.getitemstring(row,"npdb_list_code")
	is_description = this.getitemstring(row,"npdb_list_code_description")
	this.selectrow(0,false)
	this.selectrow(row,true)
end if
end event

type cb_close from commandbutton within w_npdb_specialty_matching
integer x = 2875
integer y = 36
integer width = 293
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close (parent)
end event

type gb_1 from groupbox within w_npdb_specialty_matching
integer x = 23
integer width = 1312
integer height = 136
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Update"
end type

