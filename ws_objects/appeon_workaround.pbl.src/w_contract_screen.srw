$PBExportHeader$w_contract_screen.srw
forward
global type w_contract_screen from window
end type
type cb_advanced from commandbutton within w_contract_screen
end type
type cb_select from commandbutton within w_contract_screen
end type
type cb_5 from commandbutton within w_contract_screen
end type
type dw_3 from datawindow within w_contract_screen
end type
type cb_3 from commandbutton within w_contract_screen
end type
type cb_4 from commandbutton within w_contract_screen
end type
type cb_2 from commandbutton within w_contract_screen
end type
type cb_1 from commandbutton within w_contract_screen
end type
type dw_1 from datawindow within w_contract_screen
end type
type dw_2 from datawindow within w_contract_screen
end type
end forward

global type w_contract_screen from window
integer width = 4064
integer height = 2160
boolean titlebar = true
string title = "Contract Screen"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_advanced cb_advanced
cb_select cb_select
cb_5 cb_5
dw_3 dw_3
cb_3 cb_3
cb_4 cb_4
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_contract_screen w_contract_screen

type variables
integer ii_return

end variables

on w_contract_screen.create
this.cb_advanced=create cb_advanced
this.cb_select=create cb_select
this.cb_5=create cb_5
this.dw_3=create dw_3
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.cb_advanced,&
this.cb_select,&
this.cb_5,&
this.dw_3,&
this.cb_3,&
this.cb_4,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.dw_2}
end on

on w_contract_screen.destroy
destroy(this.cb_advanced)
destroy(this.cb_select)
destroy(this.cb_5)
destroy(this.dw_3)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()
dw_3.settransobject(sqlca)


end event

type cb_advanced from commandbutton within w_contract_screen
integer x = 1595
integer y = 1968
integer width = 512
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Advanced Update..."
end type

event clicked;Open(w_ScreenSyntaxUpdate)

end event

type cb_select from commandbutton within w_contract_screen
integer x = 5
integer y = 1968
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select All"
end type

event clicked;long i
If cb_select.text = '&Select All' Then
	cb_select.text = '&Deselect All'
	For i = 1 To dw_1.rowcount()
		dw_1.setitem(i,'ck',1)
   Next
Else
	cb_select.text = '&Select All'
	For i = 1 To dw_1.rowcount()
		dw_1.setitem(i,'ck',0)
   Next
End If

end event

type cb_5 from commandbutton within w_contract_screen
integer x = 3291
integer y = 1968
integer width = 352
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Update SQLs"
end type

event clicked;long ll_rowcount,ll_i,ll_screen_id,ll_rowcount1,ll_j,ll_ck
string ls_sql,ls_dataobject
ll_rowcount = dw_1.rowcount()
//---------Begin Added by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
string  ls_err_text,ls_screenstyle,ls_griddataobject,ls_fixfield,ls_dw_opsyntax,ls_lookuplist
ll_ck = dw_1.Find( "ck=1",1, ll_rowcount )
If ll_ck<=0 Then
	MessageBox(gnv_app.iapp_object.DisplayName,"Please check at least one view and one screen.")
	Return
End If

//Added By Ken.Guo 10/11/2012
If MessageBox("Warning!!!","Are you sure you want to reset the screen syntax for all views?",Question!,YesNo!,2) <> 1 Then
	Return
End If
//---------End Added ------------------------------------------------------------------


for ll_i = 1 to ll_rowcount
	ll_ck = dw_1.getitemnumber(ll_i,'ck')
	If ll_ck = 1 Then
		ls_dataobject = dw_1.getitemstring(ll_i,'dataobject')
		ll_screen_id = dw_1.getitemnumber(ll_i,'screen_id')
		//---------Begin Modified by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------		
		  /*
		dw_2.dataobject = ls_dataobject
		dw_2.settransobject(sqlca)
		ls_sql = dw_2.Describe("datawindow.syntax")
		dw_1.setitem(ll_i,'dw_sql',ls_sql)	
		  */
		ls_ScreenStyle = dw_1.getitemString(ll_i,'screen_style')
		ls_griddataobject = dw_1.getitemString(ll_i,'grid_dataobject')
		ls_fixField = dw_1.GetItemString( ll_i, 'fix_field' )
		
		ls_err_text = ls_err_text +  string( ll_screen_id )  + ','
		If ls_ScreenStyle = 'G' Then
			dw_2.dataobject = ls_griddataobject
		Else
			dw_2.dataobject = ls_dataobject
		End If
		dw_2.settransobject(sqlca)
		ls_sql = dw_2.Describe("datawindow.syntax")
				
		/*****************************************************///added by gavins 20120519
		if gf_get_opsyntax(ls_sql,ls_fixField,ls_dw_opsyntax,ls_lookuplist) < 0 then ls_dw_opsyntax = ls_sql
		dw_1.setitem(ll_i,'lookup_list',ls_lookuplist)
		
		If ls_ScreenStyle = 'G' Then
			dw_1.setitem(ll_i,'grid_sql',ls_sql)
			dw_1.setitem(ll_i,'grid_opsql',ls_dw_opsyntax)
		Else
			dw_1.setitem(ll_i,'dw_sql',ls_sql)
			dw_1.setitem(ll_i,'dw_opsql',ls_dw_opsyntax)			
		End If
		//---------End Modfiied ------------------------------------------------------------------

		
		//Start Change By Jervis 08.04.2007
		//APB Bug
		//dw_1.setitem(ll_i,'modify_date',today()) 
		dw_1.setitem(ll_i,'modify_date',datetime(today(),now()))
		//End Change
		
		ll_rowcount1 = dw_3.retrieve(ll_screen_id)
		
		for ll_j = 1 to ll_rowcount1
			//---------Begin Modified by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
			  /*
				dw_3.setitem(ll_j,'dw_sql',ls_sql)
				dw_3.setitem(ll_j,'modify_date',datetime(today(),now()))	
			  */
			If ls_ScreenStyle = 'G' Then
				dw_3.setitem(ll_j,'grid_sql',ls_sql)
				dw_3.setitem(ll_j,'grid_opsql',ls_dw_opsyntax)
			Else
				dw_3.setitem(ll_j,'dw_sql',ls_sql)
				dw_3.setitem(ll_j,'dw_opsql',ls_dw_opsyntax)	
			End If
			dw_3.setitem(ll_j,'modify_date',datetime(today(),now()))
			dw_3.setitem(ll_j,'lookup_list',ls_lookuplist)			 
			//---------End Modfiied ------------------------------------------------------------------			
		next
		dw_3.update()
	End If
next		
if dw_1.update() = 1  then
	commit;
	//messagebox('Save','OK')
	messagebox('Save','Successful!')
else
	rollback;
end if
//---------Begin Added by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
gnv_debug.of_output( true, 'Reset Screen=' +  ls_err_text	)
//---------End Added ------------------------------------------------------------------
	
end event

type dw_3 from datawindow within w_contract_screen
boolean visible = false
integer x = 1106
integer y = 304
integer width = 1527
integer height = 924
integer taborder = 40
string title = "none"
string dataobject = "d_contract_screen_list_all"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_contract_screen
boolean visible = false
integer x = 951
integer y = 2088
integer width = 402
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Update All SQLs"
end type

event clicked;long ll_rowcount,ll_i,ll_screen_id,ll_rowcount1,ll_j,ll_find
string ls_sql,ls_dataobject
ll_rowcount = dw_1.rowcount()

for ll_i = 1 to ll_rowcount
	ls_dataobject = dw_1.getitemstring(ll_i,'dataobject')
	ll_screen_id = dw_1.getitemnumber(ll_i,'screen_id')
	
	dw_2.dataobject = ls_dataobject
	dw_2.settransobject(sqlca)
	ls_sql = dw_2.Describe("datawindow.syntax")
	dw_1.setitem(ll_i,'dw_sql',ls_sql)
	dw_1.setitem(ll_i,'modify_date',today())
	
	ll_rowcount1 = dw_3.retrieve(ll_screen_id)
	
	for ll_j = 1 to ll_rowcount1
		dw_3.setitem(ll_j,'dw_sql',ls_sql)
		dw_3.setitem(ll_j,'modify_date',today())
	next
	dw_3.update()
	
next		
if dw_1.update() = 1  then
	commit;
	//messagebox('Save','Ok')
	messagebox('Save','Successful!')
else
	rollback;
end if
	
end event

type cb_4 from commandbutton within w_contract_screen
integer x = 3675
integer y = 1968
integer width = 352
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)

end event

type cb_2 from commandbutton within w_contract_screen
boolean visible = false
integer x = 489
integer y = 2088
integer width = 357
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Delete Screen"
end type

event clicked;long ll_btn
string ls_new_sql
dw_1.accepttext()
if dw_1.getrow() <= 0 then return
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.12.2007 By: Machongmin
//$<reason> Fix a defect.
//ll_btn=messagebox('Delete','Delete(Yes/No)?',Question!,YesNo!)
ll_btn=messagebox('Delete','Are you sure you want to delete the selected screen?',Question!,YesNo!)
//---------------------------- APPEON END ----------------------------
if ll_btn=1 then
	dw_1.deleterow(0)
	if dw_1.update() = 1 then
	   commit;
      //messagebox('Delete','Ok')
    	messagebox('Delete','Successful!')
		dw_1.setfocus()
   else
	   rollback;
	   messagebox('Delete','Error: ' + sqlca.sqlerrtext )
		ls_new_sql = dw_1.getsqlselect()
		dw_1.setsqlselect(ls_new_sql)
		dw_1.reset()
		dw_1.retrieve()		
   end if
end if

end event

type cb_1 from commandbutton within w_contract_screen
boolean visible = false
integer x = 41
integer y = 2088
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Add Screen"
end type

event clicked;openwithparm(w_contract_screen_add,'A')
ii_return = message.doubleparm
if ii_return = 1 then
	dw_1.retrieve()
end if

end event

type dw_1 from datawindow within w_contract_screen
integer y = 12
integer width = 4018
integer height = 1928
integer taborder = 10
string title = "none"
string dataobject = "d_contract_screen_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;//long ll_view_id,ll_screen_id
//dw_1.accepttext()
//if dw_1.getrow() > 0 then
//	ll_view_id = dw_1.getitemnumber(dw_1.getrow(),'data_view_id')
//	ll_screen_id = dw_1.getitemnumber(dw_1.getrow(),'screen_id')
//	
//	openwithparm(w_contract_screen_add,string(ll_view_id) + '+' + string(ll_screen_id))
//	ii_return = message.doubleparm
//	if ii_return = 1 then
//		dw_1.retrieve()
//	end if
//end if

end event

event clicked;If row > 0 Then
	This.SelectRow(0, FALSE)
	This.scrolltorow(row)
	This.SelectRow(row, TRUE)
End If

end event

event rowfocuschanged;This.SelectRow(0, FALSE)
This.SelectRow(currentrow, TRUE)

end event

type dw_2 from datawindow within w_contract_screen
integer x = 750
integer y = 360
integer width = 686
integer height = 400
integer taborder = 20
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

