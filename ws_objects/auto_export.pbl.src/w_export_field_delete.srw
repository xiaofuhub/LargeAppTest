$PBExportHeader$w_export_field_delete.srw
forward
global type w_export_field_delete from w_response
end type
type cb_new from u_cb within w_export_field_delete
end type
type cb_quit from u_cb within w_export_field_delete
end type
type cb_copy from u_cb within w_export_field_delete
end type
type dw_del from u_dw within w_export_field_delete
end type
end forward

global type w_export_field_delete from w_response
integer x = 759
integer y = 64
integer width = 1349
integer height = 2120
string title = "Export Field Delete"
long backcolor = 33551856
cb_new cb_new
cb_quit cb_quit
cb_copy cb_copy
dw_del dw_del
end type
global w_export_field_delete w_export_field_delete

type variables
Integer il_export_id
Integer il_table_id
long il_recid
Boolean lb_insert = False

Boolean lb_new = False
end variables

on w_export_field_delete.create
int iCurrent
call super::create
this.cb_new=create cb_new
this.cb_quit=create cb_quit
this.cb_copy=create cb_copy
this.dw_del=create dw_del
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_new
this.Control[iCurrent+2]=this.cb_quit
this.Control[iCurrent+3]=this.cb_copy
this.Control[iCurrent+4]=this.dw_del
end on

on w_export_field_delete.destroy
call super::destroy
destroy(this.cb_new)
destroy(this.cb_quit)
destroy(this.cb_copy)
destroy(this.dw_del)
end on

event open;call super::open;//Start Code Change ----09.17.2012 #V12 maha - created window
integer i
string exportname

il_export_id = message.doubleparm

dw_del.settransobject(sqlca)
dw_del.retrieve(il_export_id)




end event

type cb_new from u_cb within w_export_field_delete
integer x = 18
integer y = 1900
integer width = 325
integer height = 84
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Select &All"
end type

event clicked;call super::clicked;Integer i
Integer li_nr

for i = 1 to dw_del.rowcount()
	dw_del.setitem(i,"selected",1)
next
end event

type cb_quit from u_cb within w_export_field_delete
integer x = 942
integer y = 1900
integer width = 279
integer height = 84
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;Parent.Event pfc_close()
end event

type cb_copy from u_cb within w_export_field_delete
integer x = 494
integer y = 1900
integer width = 421
integer height = 84
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Delete Selected"
boolean cancel = true
end type

event clicked;integer i
integer ic
long recid
integer ord = 0
integer ck



ic  = dw_del.rowcount()
if ic < 1 then return

ck = messagebox("Export Field Delete","Are you sure you wish the delete the selected fields?", question!,yesno!,2)

if ck = 2 then return

for i = ic to 1 step -1  //copy columns
	if dw_del.getitemnumber(i,"selected") = 1 then
		dw_del.deleterow(i)
	end if
next


dw_del.update()
commit using sqlca;


end event

type dw_del from u_dw within w_export_field_delete
integer width = 1335
integer height = 1884
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_export_flds_list_copy"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.of_setupdateable(false) 
end event

