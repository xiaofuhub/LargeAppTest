$PBExportHeader$w_contract_screen_add.srw
forward
global type w_contract_screen_add from window
end type
type dw_3 from datawindow within w_contract_screen_add
end type
type cb_3 from commandbutton within w_contract_screen_add
end type
type cb_2 from commandbutton within w_contract_screen_add
end type
type cb_1 from commandbutton within w_contract_screen_add
end type
type dw_1 from datawindow within w_contract_screen_add
end type
type dw_2 from datawindow within w_contract_screen_add
end type
end forward

global type w_contract_screen_add from window
integer width = 3086
integer height = 1260
boolean titlebar = true
string title = "Contract Screen Add"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_3 dw_3
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_contract_screen_add w_contract_screen_add

type variables
string is_add
integer ii_return
end variables

on w_contract_screen_add.create
this.dw_3=create dw_3
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.dw_3,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.dw_2}
end on

on w_contract_screen_add.destroy
destroy(this.dw_3)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;string ls_parm
long ll_view_id,ll_screen_id

ls_parm = message.stringparm
dw_1.settransobject(sqlca)
dw_3.settransobject(sqlca)

if ls_parm = 'A' then
	is_add = 'A'
	select max(screen_id) into :ll_screen_id from ctx_screen;
	if isnull(ll_screen_id) or ll_screen_id = 0 then
		ll_screen_id = 1
	else
		ll_screen_id = ll_screen_id + 1
	end if
	
	dw_1.insertrow(0)
	dw_1.setitem(1,'data_view_id',1001)
	dw_1.setitem(1,'screen_id',ll_screen_id)
	dw_1.setitem(1,'create_date',today())
	dw_1.setitem(1,'modify_date',today())
else
	is_add = 'M'
	ll_view_id = long(MidA(ls_parm,1,PosA(ls_parm,'+') - 1))
	ll_screen_id = long(MidA(ls_parm,PosA(ls_parm,'+') + 1,LenA(ls_parm)))
	dw_1.retrieve(ll_view_id,ll_screen_id)
	dw_3.retrieve(ll_screen_id)
end if
dw_1.setfocus()
dw_1.setcolumn('tab_name')

end event

type dw_3 from datawindow within w_contract_screen_add
boolean visible = false
integer x = 1490
integer y = 216
integer width = 686
integer height = 400
integer taborder = 30
string title = "none"
string dataobject = "d_contract_screen_list_all"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_contract_screen_add
boolean visible = false
integer x = 23
integer y = 928
integer width = 585
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update syntax to all view"
end type

event clicked;string ls_dataobject,ls_sql,ls_tab_name,ls_dw_name,ls_sql1,ls_sql2
long ll_screen_id,ll_view_id,ll_row
dw_1.accepttext()
ll_row = dw_1.getrow()
ll_view_id = dw_1.getitemnumber(ll_row,'data_view_id')
ll_screen_id = dw_1.getitemnumber(ll_row,'screen_id')
ls_dataobject = dw_1.getitemstring(ll_row,'dataobject')
ls_tab_name = dw_1.getitemstring(ll_row,'tab_name')
ls_dw_name = dw_1.getitemstring(ll_row,'dw_name')

//---------Begin Added by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
string  ls_style
ls_style = dw_1.getitemstring(ll_row,'screen_style')
If ls_style = 'G' Then ls_dataobject = dw_1.GetItemString( ll_Row, 'grid_dataobject' )
//---------End Added ------------------------------------------------------------------


dw_2.dataobject = ls_dataobject
dw_2.settransobject(sqlca)
ls_sql = dw_2.Describe("datawindow.syntax")
IF ls_sql = "" or ls_sql = "!" or ls_sql = "?" THEN 
   messagebox('Error','Datawindow syntax error!')
   return
end if
//---------Begin Modified by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
  /*
    update ctx_screen 
	set dw_sql = :ls_sql,
		modify_date = getdate()
	where screen_id = :ll_screen_id
	;  
  */
 If ls_style = 'G' Then
		update ctx_screen 
	set grid_sql = :ls_sql,
		modify_date = getdate()
	where screen_id = :ll_screen_id
	;
Else
	
	update ctx_screen 
	set dw_sql = :ls_sql,
		modify_date = getdate()
	where screen_id = :ll_screen_id
	;
End If
//---------End Modfiied ------------------------------------------------------------------



commit;


messagebox('Save',LenA(ls_sql))
end event

type cb_2 from commandbutton within w_contract_screen_add
integer x = 1458
integer y = 928
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Colse"
end type

event clicked;CloseWithReturn(parent,ii_return)
end event

type cb_1 from commandbutton within w_contract_screen_add
integer x = 901
integer y = 932
integer width = 343
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;string ls_dataobject,ls_sql,ls_tab_name,ls_dw_name,ls_sql1,ls_sql2
long ll_screen_id,ll_view_id,ll_row,i
dw_1.accepttext()
ll_row = dw_1.getrow()
ll_view_id = dw_1.getitemnumber(ll_row,'data_view_id')
ll_screen_id = dw_1.getitemnumber(ll_row,'screen_id')
ls_dataobject = dw_1.getitemstring(ll_row,'dataobject')
ls_tab_name = dw_1.getitemstring(ll_row,'tab_name')
ls_dw_name = dw_1.getitemstring(ll_row,'dw_name')

//---------Begin Added by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
string ls_style
ls_style = dw_1.GetItemString( ll_Row, 'screen_style' )//added by gavins 20120313 grid
If ls_style = 'G' Then ls_dataobject =  dw_1.getitemstring(ll_row,'grid_dataobject')
//---------End Added ------------------------------------------------------------------


dw_2.dataobject = ls_dataobject
dw_2.settransobject(sqlca)
ls_sql = dw_2.Describe("datawindow.syntax")
IF ls_sql = "" or ls_sql = "!" or ls_sql = "?" THEN 
   messagebox('Error','Datawindow syntax error!')
   return
end if
//---------Begin Modified by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
  /*
     dw_1.setitem(ll_row,'dw_sql',ls_sql) 
  */
 If ls_style = 'G' Then
	dw_1.setitem(ll_row,'grid_sql',ls_sql)
Else
	dw_1.setitem(ll_row,'dw_sql',ls_sql)
End If
//---------End Modfiied ------------------------------------------------------------------

dw_1.setitem(ll_row,'modify_date',datetime(today(),now()))

if is_add = 'M' then
	for i = 1 to dw_3.rowcount()
		//---------Begin Modified by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------		
		  /*
			dw_3.setitem(i,'dw_sql',ls_sql)	
		  */
		 If ls_style = 'G' Then
			dw_3.setitem(i,'grid_sql',ls_sql)
		Else
			dw_3.setitem(i,'dw_sql',ls_sql)
		End If
		//---------End Modfiied ------------------------------------------------------------------		
		dw_3.setitem(i,'modify_date',datetime(today(),now()))
	next	
	dw_3.update()
end if
	
if dw_1.update() = 1 then
	ii_return = 1
	//messagebox('Save','Ok')
	messagebox('Save','Successful!')
else
	rollback;
	messagebox('Save','Error: ' + sqlca.sqlerrtext)
	dw_1.setfocus()
	dw_1.setcolumn('tab_name')
	ii_return = 0
	return
end if
if is_add = 'A' then
	dw_1.reset()
	select max(screen_id) into :ll_screen_id from ctx_screen;
	if isnull(ll_screen_id) or ll_screen_id = 0 then
		ll_screen_id = 1
	else
		ll_screen_id = ll_screen_id + 1
	end if
	
	ll_row = dw_1.insertrow(0)
	dw_1.setitem(ll_row,'data_view_id',1001)
	dw_1.setitem(ll_row,'screen_id',ll_screen_id)
	dw_1.setitem(ll_row,'tab_name',ls_tab_name)
	dw_1.setitem(ll_row,'create_date',today())
	dw_1.setitem(ll_row,'modify_date',today())
	dw_1.setfocus()
	dw_1.setcolumn('tab_name')
else
	closewithreturn(parent,ii_return)
end if

end event

type dw_1 from datawindow within w_contract_screen_add
integer y = 8
integer width = 2994
integer height = 872
integer taborder = 10
string title = "none"
string dataobject = "d_contract_screen_add"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_contract_screen_add
integer x = 142
integer y = 296
integer width = 686
integer height = 400
integer taborder = 20
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

