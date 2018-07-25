$PBExportHeader$w_export_code_equiv.srw
forward
global type w_export_code_equiv from w_response
end type
type cb_all from u_cb within w_export_code_equiv
end type
type dw_select from u_dw within w_export_code_equiv
end type
type gb_1 from groupbox within w_export_code_equiv
end type
type cb_save from u_cb within w_export_code_equiv
end type
type cb_2 from u_cb within w_export_code_equiv
end type
type dw_detail from datawindow within w_export_code_equiv
end type
type st_1 from statictext within w_export_code_equiv
end type
type st_2 from statictext within w_export_code_equiv
end type
type st_name from statictext within w_export_code_equiv
end type
type gb_2 from groupbox within w_export_code_equiv
end type
type dw_table from datawindow within w_export_code_equiv
end type
type cb_1 from commandbutton within w_export_code_equiv
end type
type dw_equiv from datawindow within w_export_code_equiv
end type
end forward

global type w_export_code_equiv from w_response
integer x = 219
integer y = 148
integer width = 3264
integer height = 2320
string title = "Edit Export Codes"
long backcolor = 33551856
cb_all cb_all
dw_select dw_select
gb_1 gb_1
cb_save cb_save
cb_2 cb_2
dw_detail dw_detail
st_1 st_1
st_2 st_2
st_name st_name
gb_2 gb_2
dw_table dw_table
cb_1 cb_1
dw_equiv dw_equiv
end type
global w_export_code_equiv w_export_code_equiv

type variables
Integer il_export_id
Integer il_table_id
Integer il_field_id

long il_lookup_code

Boolean lb_new = False

string is_lookup_name
string is_lookup_type

end variables

on w_export_code_equiv.create
int iCurrent
call super::create
this.cb_all=create cb_all
this.dw_select=create dw_select
this.gb_1=create gb_1
this.cb_save=create cb_save
this.cb_2=create cb_2
this.dw_detail=create dw_detail
this.st_1=create st_1
this.st_2=create st_2
this.st_name=create st_name
this.gb_2=create gb_2
this.dw_table=create dw_table
this.cb_1=create cb_1
this.dw_equiv=create dw_equiv
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_all
this.Control[iCurrent+2]=this.dw_select
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.dw_detail
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_name
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.dw_table
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.dw_equiv
end on

on w_export_code_equiv.destroy
call super::destroy
destroy(this.cb_all)
destroy(this.dw_select)
destroy(this.gb_1)
destroy(this.cb_save)
destroy(this.cb_2)
destroy(this.dw_detail)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_name)
destroy(this.gb_2)
destroy(this.dw_table)
destroy(this.cb_1)
destroy(this.dw_equiv)
end on

event open;call super::open;string ls_exp_name
integer f
DataWindowChild dwchild
Integer li_found
//dw_select.SetFocus()

il_export_id = message.doubleparm

if il_export_id > 0 then
	select export_name into :ls_exp_name from export_header where export_id = :il_export_id;
	st_name.text = ls_exp_name
else
	st_name.text = "not selected"
end if

//dw_name.retrieve()
dw_table.retrieve()

//if il_export_id > 1 then
//	dw_select.GetChild( "export_id", dwchild )
//	li_found = dwchild.Find( "export_id = " + string(il_export_id) , 1, dwchild.Rowcount() )
//	messagebox("li_found",li_found)
//	IF li_found > 0 THEN
//		dwchild.Scrolltorow(li_found)
//	END IF
//end if
//dw_select.scrolltorow(f)
end event

type cb_all from u_cb within w_export_code_equiv
integer x = 1984
integer y = 272
integer width = 293
integer height = 84
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Select &All"
boolean default = true
end type

event clicked;call super::clicked;//Add by jerivs 09.22.2009

long ll_count,ll_i,r
long ll_lookup_code

ll_count = dw_detail.RowCount( )

if il_export_id < 1 then 
	messagebox("Select Error","Please select an Export")
	return
else
	for ll_i = 1 to ll_count
		ll_lookup_code = dw_detail.getitemnumber(ll_i,"lookup_code")
		if dw_equiv.Find("lookup_code = " + string(ll_lookup_code),1,dw_equiv.Rowcount( )) = 0 then
			r = dw_equiv.insertrow(0)
			dw_equiv.setitem(r,"export_id",il_export_id)
			dw_equiv.setitem(r,"lookup_table",is_lookup_name)
			dw_equiv.setitem(r,"lookup_code",ll_lookup_code)
			dw_equiv.setitem(r,"code",dw_detail.getitemstring(ll_i,"code"))
			dw_equiv.SetItem(r,"equiv_code",dw_detail.getitemstring(ll_i,"code"))
		end if
	next
end if
end event

type dw_select from u_dw within w_export_code_equiv
integer x = 969
integer y = 104
integer width = 1061
integer height = 92
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_export_selector"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )


end event

event itemchanged;call super::itemchanged;
il_export_id = Integer( data )

	dw_equiv.SetTransObject(SQLCA)
	dw_equiv.Retrieve(il_export_id,is_lookup_name)
//tab_1.tabpage_export_hdr.dw_export_file.Retrieve( il_export_id )
//
//tab_1.tabpage_field_data.dw_fld_list.Retrieve( il_export_id )
//
//tab_1.tabpage_field_data.dw_fld_list.ShareData( tab_1.tabpage_field_data.dw_detail )


end event

type gb_1 from groupbox within w_export_code_equiv
integer x = 923
integer y = 36
integer width = 1120
integer height = 200
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Export File"
end type

type cb_save from u_cb within w_export_code_equiv
integer x = 2304
integer y = 272
integer width = 293
integer height = 84
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Save"
boolean default = true
end type

event clicked;Integer li_retval

li_retval = Parent.Event pfc_Save()

IF li_retval < 0 THEN
	Return
END IF
end event

type cb_2 from u_cb within w_export_code_equiv
integer x = 2930
integer y = 272
integer width = 279
integer height = 84
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;Parent.Event pfc_close()
end event

type dw_detail from datawindow within w_export_code_equiv
integer x = 5
integer y = 372
integer width = 1957
integer height = 1864
integer taborder = 40
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;integer r



if row > 0 then
	if il_export_id < 1 then 
		messagebox("Select Error","Please select an Export")
		return
	else
		//---------Begin Modified by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
		  /*
			r = dw_equiv.insertrow(0)
			dw_equiv.setitem(r,"export_id",il_export_id)
			dw_equiv.setitem(r,"lookup_table",is_lookup_name)
			dw_equiv.setitem(r,"lookup_code",il_lookup_code)
			dw_equiv.setitem(r,"code",this.getitemstring(row,"code"))				
		  */
		if dw_equiv.Find("lookup_code = " + string(il_lookup_code),1,dw_equiv.Rowcount( )) = 0 then //jerivs 09.22.2009
			r = dw_equiv.insertrow(0)
			dw_equiv.setitem(r,"export_id",il_export_id)
			dw_equiv.setitem(r,"lookup_table",is_lookup_name)
			dw_equiv.setitem(r,"lookup_code",il_lookup_code)
			dw_equiv.setitem(r,"code",this.getitemstring(row,"code"))
			dw_equiv.SetItem(r,"equiv_code",this.getitemstring(row,"code"))	//jerivs 09.22.2009
		end if		 
		//---------End Modfiied ------------------------------------------------------------------
	end if
end if

end event

event clicked;integer r

r = this.getclickedrow()  
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.28.2006 By: Cao YongWang
//$<reason> Fix a defect.
If not r > 0 Then return
//---------------------------- APPEON END ----------------------------
this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)

il_lookup_code = this.getitemnumber(r,"lookup_code")

end event

type st_1 from statictext within w_export_code_equiv
integer x = 37
integer y = 296
integer width = 1573
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Double-click lookup table items to add to equiv Table"
boolean focusrectangle = false
end type

type st_2 from statictext within w_export_code_equiv
integer x = 37
integer y = 28
integer width = 398
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Export Name:"
boolean focusrectangle = false
end type

type st_name from statictext within w_export_code_equiv
integer x = 37
integer y = 120
integer width = 855
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_export_code_equiv
integer x = 2094
integer y = 36
integer width = 1125
integer height = 200
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Lookup table"
end type

type dw_table from datawindow within w_export_code_equiv
integer x = 2144
integer y = 104
integer width = 997
integer height = 96
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_exp_lookup_select"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)

end event

event itemchanged;
String ls_lookup_type

IF Parent.Event pfc_save() < 0 THEN
	Return
END IF

Integer i, li_rc, currentrow, li_found

//dw_detail.SetRedraw(False)

//is_lookup_name = This.GetText()
is_lookup_name = data

datawindowchild dwchild
This.GetChild("lookup_name", dwchild)

li_found = dwchild.Find("lookup_name = '" + is_lookup_name + "'", 1, 1000)

IF li_found > 0 THEN
	ls_lookup_type = Upper(dwchild.GetItemString(li_found, "type"))	
	IF ls_lookup_type = "A" THEN
		is_lookup_type = "A"
		dw_detail.DataObject = "d_address_lookup_exp"
	ELSE
		is_lookup_type = "C"
		dw_detail.DataObject = "d_code_lookup_exp"
	END IF

	dw_detail.SetTransObject(SQLCA)

	dw_detail.Retrieve(is_lookup_name)

	dw_detail.ScrollToRow(1)
	dw_detail.SetRow(1)
	
	dw_equiv.SetTransObject(SQLCA)
	dw_equiv.Retrieve(il_export_id,is_lookup_name)	
END IF

dw_detail.SetFocus()

dw_detail.SetRedraw(True)

dw_detail.Enabled = True

IF Upper(is_lookup_type) = "A" THEN
	 SELECT Max( lookup_code )  
    INTO :il_lookup_code  
    FROM address_lookup  ;
ELSE
	 SELECT Max( lookup_code )  
    INTO :il_lookup_code  
    FROM code_lookup  ;
END IF
IF IsNull( il_lookup_code ) THEN
	il_lookup_code = 0
END IF

IF ls_lookup_type = "A" THEN
	dw_detail.GetChild( "state", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( "state" )

	dw_detail.GetChild( "country", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( "country" )	
END IF
end event

type cb_1 from commandbutton within w_export_code_equiv
integer x = 2615
integer y = 272
integer width = 293
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;dw_equiv.deleterow(dw_equiv.getrow())
end event

type dw_equiv from datawindow within w_export_code_equiv
integer x = 1970
integer y = 372
integer width = 1275
integer height = 1864
integer taborder = 50
string dataobject = "d_exp_equiv_exp_table"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

