$PBExportHeader$w_sql_query_select.srw
forward
global type w_sql_query_select from window
end type
type cb_delete from commandbutton within w_sql_query_select
end type
type dw_1 from datawindow within w_sql_query_select
end type
type cb_close from commandbutton within w_sql_query_select
end type
type cb_save from commandbutton within w_sql_query_select
end type
type cb_get from commandbutton within w_sql_query_select
end type
end forward

global type w_sql_query_select from window
integer width = 4302
integer height = 1692
boolean titlebar = true
string title = "Saved Queries"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_delete cb_delete
dw_1 dw_1
cb_close cb_close
cb_save cb_save
cb_get cb_get
end type
global w_sql_query_select w_sql_query_select

type variables
long il_sql

end variables

on w_sql_query_select.create
this.cb_delete=create cb_delete
this.dw_1=create dw_1
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_get=create cb_get
this.Control[]={this.cb_delete,&
this.dw_1,&
this.cb_close,&
this.cb_save,&
this.cb_get}
end on

on w_sql_query_select.destroy
destroy(this.cb_delete)
destroy(this.dw_1)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_get)
end on

event open;string ls_parm
string ls_from
integer nr
long lid
datetime ldt_now

ls_parm = message.stringparm
ls_from = MidA(ls_parm,1,1)


choose case ls_from
	case "U"  //user selects
		dw_1.dataobject = "d_sql_query_list"
		dw_1.settransobject(sqlca)
		dw_1.retrieve(gs_user_id )
	case "N"  //add new
		this.title = "Saved Queries - Enter Query name and click SAVE"
		dw_1.dataobject = "d_sql_query_list"
		dw_1.settransobject(sqlca)
		dw_1.retrieve(gs_user_id )
		nr = dw_1.insertrow(0)
		dw_1.scrolltorow( nr)   //Start Code Change ----01.18.2017 #V153 maha
		dw_1.setitem(nr,"user_id",gs_user_id)
		dw_1.setitem(nr,"query_sql",MidA(ls_parm,3))
		select max(list_id) into:lid from sql_query_list;
		if IsNull(lid) then lid = 0 //Add by Evan 2008-03-17
		lid++
		dw_1.setitem(nr,"list_id",lid)
		ldt_now = datetime(today(),now())
		dw_1.setitem(nr,"create_date",ldt_now)
	case "A" //all from support
		dw_1.dataobject = "d_sql_query_list_all"
		dw_1.settransobject(sqlca)
		dw_1.retrieve( )
end choose







end event

type cb_delete from commandbutton within w_sql_query_select
integer x = 3214
integer y = 24
integer width = 343
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;integer i

i = messagebox("Delete","Are you sure?",question!,yesno!,1)

if i = 1 then dw_1.deleterow(0)


end event

type dw_1 from datawindow within w_sql_query_select
integer x = 9
integer y = 124
integer width = 4274
integer height = 1484
integer taborder = 10
string title = "none"
string dataobject = "d_sql_query_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-07-11 By: Scofield
//$<Reason> If row is not valid then return.

if Row <= 0 then Return

This.SetRow(Row)
This.SelectRow(0,false)
This.SelectRow(Row,true)

il_sql = This.GetItemNumber(Row,"list_id")

//integer i
//
//i = this.getclickedrow( )
//
//this.setrow(i)
//this.selectrow(0,false)
//this.selectrow(i,true)
//
//il_sql = this.getitemnumber( this.getrow(), "list_id")

//---------------------------- APPEON END ----------------------------

end event

event doubleclicked;cb_get.triggerevent(clicked!)
end event

type cb_close from commandbutton within w_sql_query_select
integer x = 3931
integer y = 24
integer width = 343
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;closewithreturn(parent,"Cancel")
end event

type cb_save from commandbutton within w_sql_query_select
integer x = 3570
integer y = 24
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "S&ave"
end type

event clicked;dw_1.update()
end event

type cb_get from commandbutton within w_sql_query_select
integer x = 2857
integer y = 24
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select"
end type

event clicked;string ls_sql

if dw_1.getrow() <= 0 then Return //Add by Evan 2008-03-17
ls_sql = dw_1.getitemstring(dw_1.getrow(),"query_sql")

closewithreturn(parent,ls_sql)
end event

