$PBExportHeader$w_export_copy.srw
forward
global type w_export_copy from w_response
end type
type st_2 from statictext within w_export_copy
end type
type cb_1 from u_cb within w_export_copy
end type
type em_num from editmask within w_export_copy
end type
type st_1 from statictext within w_export_copy
end type
type dw_select from u_dw within w_export_copy
end type
type gb_1 from groupbox within w_export_copy
end type
type cb_new from u_cb within w_export_copy
end type
type cb_quit from u_cb within w_export_copy
end type
type cb_copy from u_cb within w_export_copy
end type
type st_exp from statictext within w_export_copy
end type
type dw_to from datawindow within w_export_copy
end type
type dw_from from u_dw within w_export_copy
end type
type cbx_1 from checkbox within w_export_copy
end type
type gb_2 from groupbox within w_export_copy
end type
type sle_time from singlelineedit within w_export_copy
end type
end forward

global type w_export_copy from w_response
integer x = 759
integer y = 64
integer width = 1257
integer height = 2176
string title = "Copy Export Fields"
long backcolor = 33551856
st_2 st_2
cb_1 cb_1
em_num em_num
st_1 st_1
dw_select dw_select
gb_1 gb_1
cb_new cb_new
cb_quit cb_quit
cb_copy cb_copy
st_exp st_exp
dw_to dw_to
dw_from dw_from
cbx_1 cbx_1
gb_2 gb_2
sle_time sle_time
end type
global w_export_copy w_export_copy

type variables
Integer il_export_id
Integer il_table_id
long il_recid
Boolean lb_insert = False

Boolean lb_new = False

Integer il_export_type  ////(Appeon)Harry 08.20.2014 - BugS081501 
end variables

forward prototypes
public subroutine of_dw_select_setfilter ()
end prototypes

public subroutine of_dw_select_setfilter ();//(Appeon)Harry 08.20.2014 - BugS081501 
DataWindowChild child
dw_select.getchild("export_id",child)
If gb_contract_version Then
	child.setfilter("export_type in (3,4)")
Else
	If gb_contract_module Then
		If il_export_type = 1 or il_export_type = 2 Then
			child.setfilter("export_type in (1,2,5,6)")
		ElseIf il_export_type = 3 or il_export_type = 4 Then
			child.setfilter("export_type in (3,4,5,6)")
		Else
			child.setfilter('')
		End If
	End If
End If

child.filter()
end subroutine

on w_export_copy.create
int iCurrent
call super::create
this.st_2=create st_2
this.cb_1=create cb_1
this.em_num=create em_num
this.st_1=create st_1
this.dw_select=create dw_select
this.gb_1=create gb_1
this.cb_new=create cb_new
this.cb_quit=create cb_quit
this.cb_copy=create cb_copy
this.st_exp=create st_exp
this.dw_to=create dw_to
this.dw_from=create dw_from
this.cbx_1=create cbx_1
this.gb_2=create gb_2
this.sle_time=create sle_time
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.em_num
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_select
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.cb_new
this.Control[iCurrent+8]=this.cb_quit
this.Control[iCurrent+9]=this.cb_copy
this.Control[iCurrent+10]=this.st_exp
this.Control[iCurrent+11]=this.dw_to
this.Control[iCurrent+12]=this.dw_from
this.Control[iCurrent+13]=this.cbx_1
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.sle_time
end on

on w_export_copy.destroy
call super::destroy
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.em_num)
destroy(this.st_1)
destroy(this.dw_select)
destroy(this.gb_1)
destroy(this.cb_new)
destroy(this.cb_quit)
destroy(this.cb_copy)
destroy(this.st_exp)
destroy(this.dw_to)
destroy(this.dw_from)
destroy(this.cbx_1)
destroy(this.gb_2)
destroy(this.sle_time)
end on

event open;call super::open;integer i
string exportname

il_export_id = message.doubleparm

//---------Begin Modified by (Appeon)Harry 08.20.2014 for BugS081501 --------
//select export_name into :exportname from export_header where export_id = :il_export_id;
select export_name,export_type into :exportname,:il_export_type from export_header where export_id = :il_export_id;
//---------End Modfiied ------------------------------------------------------
st_exp.text = exportname
//---------Begin Added by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
this.title = this.title + "-"+exportname

//Please default the After # to the current field/record number that was selected when Copy Fields was clicked 
em_num.text = string(w_export_painter.tab_1.tabpage_field_data.dw_fld_list.GetRow())  
//---------End Added ------------------------------------------------------------------

dw_from.settransobject(sqlca)

dw_to.settransobject(sqlca)


post of_dw_select_setfilter() //(Appeon)Harry 08.20.2014 - BugS081501 


end event

type st_2 from statictext within w_export_copy
integer x = 110
integer y = 404
integer width = 905
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Duplicate Field(s)                       times."
boolean focusrectangle = false
end type

type cb_1 from u_cb within w_export_copy
integer x = 329
integer y = 1996
integer width = 279
integer height = 84
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "S&ort"
end type

event clicked;call super::clicked;//---------Begin Added by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
string ls_null
Setnull(ls_null)
//dw_from.inv_sort.of_setsort( ls_null)
//dw_from.inv_sort.of_sort()

dw_from.inv_sort.of_setstyle( dw_from.inv_sort.APPEONDRAGDROP )
dw_from.event pfc_sortdlg()
//---------End Added ------------------------------------------------------------------


end event

type em_num from editmask within w_export_copy
integer x = 997
integer y = 480
integer width = 174
integer height = 72
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

event modified;//<add> 08/22/2007 by: Andy
cbx_1.checked = false
end event

type st_1 from statictext within w_export_copy
integer x = 832
integer y = 488
integer width = 174
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "After #"
boolean focusrectangle = false
end type

type dw_select from u_dw within w_export_copy
integer x = 96
integer y = 212
integer width = 1033
integer height = 80
integer taborder = 10
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
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.28.2007 By: Jack
//$<reason> Fix a defect.

datawindowchild child
this.getchild("export_id",child)
If gb_contract_version Then
	child.setfilter("export_type in (3,4)")
	child.filter()
Else
	child.setfilter('')
	child.filter()
End If
//---------------------------- APPEON END ----------------------------

end event

event itemchanged;call super::itemchanged;integer cnt
integer li_exp
li_exp = Integer( data )

//if li_exp = il_export_id then
//	messagebox("Warning","You selected the same export.")
//end if
dw_from.Retrieve( li_exp )

//---------Begin Added by (Appeon)Harry 08.20.2014 for BugS081501--------
datawindowchild child
integer li_export_type
integer li_findrow
this.getchild("export_id",child)
li_findrow = child.find( "export_id=" + data, 1, child.rowcount())
li_export_type = child.getitemnumber(li_findrow,'export_type')
if li_export_type = 5 or li_export_type = 6 then
	if il_export_type = 1 or il_export_type = 2 then
		dw_from.setfilter("export_fields_module_type = 1")
	elseif il_export_type = 3 or il_export_type = 4 then
		dw_from.setfilter("export_fields_module_type = 3")
	else
		dw_from.setfilter("")
	end if
	dw_from.filter( )
end if
//---------End Added ------------------------------------------------------







//tab_1.tabpage_field_data.dw_fld_list.ShareData( tab_1.tabpage_field_data.dw_detail )


end event

type gb_1 from groupbox within w_export_copy
integer x = 46
integer y = 140
integer width = 1157
integer height = 176
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Export from which to Copy Fields"
end type

type cb_new from u_cb within w_export_copy
integer x = 23
integer y = 1996
integer width = 279
integer height = 84
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Select &All"
end type

event clicked;Integer i
Integer li_nr

for i = 1 to dw_from.rowcount()
	dw_from.setitem(i,"selected",1)
next

end event

type cb_quit from u_cb within w_export_copy
integer x = 923
integer y = 1996
integer width = 279
integer height = 84
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Canc&el"
boolean cancel = true
end type

event clicked;Parent.Event pfc_close()
end event

type cb_copy from u_cb within w_export_copy
integer x = 622
integer y = 1996
integer width = 279
integer height = 84
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Copy"
boolean cancel = true
end type

event clicked;//maha app 102405 made various modifications for order setting

integer i
integer ic
long recid
integer ord = 0
integer ck
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.10.2007 By: Jack
//$<reason> 
/*
dw_from.rowscopy(i, i, primary!, dw_to, 10000, 	primary!)
*/
integer j
string ls_export_field_name,ls_export_field_name1
boolean lb_duplicates = False
//---------------------------- APPEON END ----------------------------
integer li_module_type_temp //(Appeon)Harry 08.20.2014 - BugS081501 
Long ll_intcred_table //(Appeon)Harry 08.20.2014 - BugS081501 

ic  = dw_from.rowcount()
if ic < 1 then return

select max(rec_id) into :recid from export_fields;
if LenA(em_num.text) > 0 then //if after # populated
	ord = integer(em_num.text)
	ord++
	ck = 1
	dw_to.retrieve(il_export_id )
end if

if cbx_1.checked then //add to end
	select max(export_order) into :ord from export_fields where export_id = :il_export_id;
	if isnull(ord) then ord = 0
	//---------Begin Added by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
	dw_to.Retrieve(il_export_id ) //Fixed bug - jervis 09.09.2010	
	//---------End Added ------------------------------------------------------------------
end if
//---------Begin Modified by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
  /*
	for i = 1 to ic //copy columns
		if dw_from.getitemnumber(i,"selected") = 1 then
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 04.10.2007 By: Jack
			//$<reason> 
			/*
			dw_from.rowscopy(i, i, primary!, dw_to, 10000, 	primary!)
			*/
			ls_export_field_name = dw_from.getitemstring(i,'export_field_name')
			lb_duplicates = False		
			For j = 1 To w_export_painter.tab_1.tabpage_field_data.dw_fld_list.rowcount()
				ls_export_field_name1 = w_export_painter.tab_1.tabpage_field_data.dw_fld_list.getitemstring(j,'export_field_name')
				//Modify 08/22/2007 by:Andy add:lower(...)
				If lower(ls_export_field_name1) = lower(ls_export_field_name) Then
					lb_duplicates = True
				End If
			Next
		//	If Not lb_duplicates Then //Start Code Change ----10.23.2008 #V85 maha - removed because it should be possible to copy duplicate names
				//<add> 08/22/2007 by: Andy
				if LenA(em_num.text) > 0 then
					dw_from.rowscopy(i, i, primary!, dw_to, ord, 	primary!)
					ord++
				else
					dw_from.rowscopy(i, i, primary!, dw_to, 10000, 	primary!)
				end if
				//end of add
	//		End If	
			//---------------------------- APPEON END ----------------------------
		end if
	next
	
	for i = 1 to dw_to.rowcount()
		if dw_to.getitemstatus( i, 0, primary!) = NewModified! then 
			dw_to.setitem(i,"export_id",il_export_id)
			recid++
			dw_to.setitem(i,"rec_id",recid)
		end if
	
		if cbx_1.checked then  //add to end
			ord++
			dw_to.setitem(i,"export_order",ord)
		elseif ck = 1 then
			//Modify 08/22/2007 by: Andy Reason:reset order
			//dw_to.setitem(i,"export_order",ord)
			//ord++
			dw_to.setitem(i,"export_order",i)
		else
	//Start Code Change ---- 01.23.2006 #209 maha
	//		ord++
	//		dw_to.setitem(i,"export_order",ord)
	//End Code Change---01.23.2005 
		end if
	
	next      
  */
Integer li_pos
String ls_num
long ll_recordnum
Integer li_time
For li_time = 1 To Integer(sle_time.Text) //Add Copy field time - jervis 09.09.2010
	For i = 1 To ic //copy columns
		If dw_from.GetItemNumber(i,"selected") = 1 Then
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 04.10.2007 By: Jack
			//$<reason> 
						/*
						dw_from.rowscopy(i, i, primary!, dw_to, 10000, 	primary!)
			*/
			ls_export_field_name = dw_from.GetItemString(i,'export_field_name')
			lb_duplicates = False
			//For j = 1 To w_export_painter.tab_1.tabpage_field_data.dw_fld_list.rowcount()
			For j = 1 To dw_to.RowCount() // jervis 07.08.2009
				ls_export_field_name1 = dw_to.GetItemString(j,'export_field_name')
				//Modify 08/22/2007 by:Andy add:lower(...)
				If Lower(ls_export_field_name1) = Lower(ls_export_field_name) Then
					lb_duplicates = True
					//Rename duplicate column
					li_pos = lastpos(ls_export_field_name,"_")
					
					If li_pos  > 0 Then
						ls_num = Mid(ls_export_field_name,li_pos + 1)
						If IsNumber(ls_num) Then
							ls_export_field_name = Mid(ls_export_field_name,1,li_pos) + String(Integer(ls_num) + 1)
						Else
							ls_export_field_name = ls_export_field_name + "_1"
						End If
					Else
						ls_export_field_name = ls_export_field_name + "_1"
					End If
					
					//Reset the value of Record# field - jervis 09.21.2010
					ll_recordnum = dw_to.getitemnumber( j,"intcred_record_number")
					
					j = 0
				End If
			Next
			
			//Reset the value of Record# field - jervis 09.21.2010
			if isnull(ll_recordnum) then ll_recordnum = 0
			ll_recordnum++
			
			//	If Not lb_duplicates Then //Start Code Change ----10.23.2008 #V85 maha - removed because it should be possible to copy duplicate names
			//<add> 08/22/2007 by: Andy
			If Len(em_num.Text) > 0 Then
				dw_from.RowsCopy(i, i, primary!, dw_to, ord, 	primary!)
				If lb_duplicates Then 
					if ord > dw_to.RowCount() then //Fixed bug - jervis 09.09.2010
						dw_to.SetItem(dw_to.RowCount(),'export_field_name',ls_export_field_name) 
						dw_to.SetItem( dw_to.RowCount(),"intcred_record_number", ll_recordnum)
					else
						dw_to.SetItem(ord,'export_field_name',ls_export_field_name) //Rename when duplicate names- jervis 06.23.2009
						dw_to.SetItem( ord,"intcred_record_number", ll_recordnum)
					end if
				end if
				ord++
			Else
				dw_from.RowsCopy(i, i, primary!, dw_to, 10000, 	primary!)
				If lb_duplicates Then 
					dw_to.SetItem(dw_to.RowCount(),'export_field_name',ls_export_field_name)
					dw_to.SetItem( dw_to.RowCount(),"intcred_record_number", ll_recordnum)
				end if
			End If
			//end of add
			//		End If	
			//---------------------------- APPEON END ----------------------------
		End If
	Next
	
	For i = 1 To dw_to.RowCount()
		If dw_to.GetItemStatus( i, 0, primary!) = NewModified! Then
			dw_to.SetItem(i,"export_id",il_export_id)
			recid++
			dw_to.SetItem(i,"rec_id",recid)
			//---------Begin Added by (Appeon)Harry 08.20.2014 for BugS081501 --------
			If il_export_type < 5 Then
				dw_to.SetItem(i,"export_fields_module_type",il_export_type)
			Else
				li_module_type_temp = dw_to.getitemnumber(i, "export_fields_module_type")
				
				If IsNull (li_module_type_temp) Then
					ll_intcred_table = dw_to.getitemnumber(i, "intcred_table")
					If Not IsNull (ll_intcred_table) and ll_intcred_table < 1000 Then
						li_module_type_temp = 1
					Else
						li_module_type_temp = 3
					End If
				End If
				
				If li_module_type_temp < 3 Then
					dw_to.SetItem(i,"export_fields_module_type",1)
				Else
					dw_to.SetItem(i,"export_fields_module_type",3)
				End If
			End If
			//---------End Added ------------------------------------------------------
		End If
		
		If cbx_1.Checked Then //add to end
			//---------Begin Modified by (Appeon)Harry 11.07.2013 for V141 ISG-CLX  BugH101501--------
			//ord++
			//dw_to.SetItem(i,"export_order",ord)
			If  i >= ord  then			
				if ord <= 0 then ord = 1 //(Appeon)Harry 04.23.2014 - V142 ISG-CLX
				dw_to.SetItem(i,"export_order",ord)
				ord ++
			end  if
			//---------End Modfiied ------------------------------------------------------
		ElseIf ck = 1 Then
			//Modify 08/22/2007 by: Andy Reason:reset order
			//dw_to.setitem(i,"export_order",ord)
			//ord++
			dw_to.SetItem(i,"export_order",i)
		Else
			//Start Code Change ---- 01.23.2006 #209 maha
			//		ord++
			//		dw_to.setitem(i,"export_order",ord)
			//End Code Change---01.23.2005 
		End If
		
	Next
Next
//---------End Modfiied ------------------------------------------------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.09.2006 By: owen chen
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
dw_to.update()
commit using sqlca;
*/
gnv_appeondb.of_startqueue( )

dw_to.update()
commit using sqlca;

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

Parent.Event pfc_close()
end event

type st_exp from statictext within w_export_copy
integer x = 123
integer y = 44
integer width = 1006
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
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_to from datawindow within w_export_copy
boolean visible = false
integer x = 1390
integer y = 44
integer width = 818
integer height = 1864
string dataobject = "d_export_flds_list_copy"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_from from u_dw within w_export_copy
integer x = 5
integer y = 592
integer width = 1239
integer height = 1384
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_export_flds_list_copy"
end type

event constructor;call super::constructor;this.of_setupdateable(false) 
//---------Begin Added by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
this.of_setsort( true)
//---------End Added ------------------------------------------------------------------

end event

type cbx_1 from checkbox within w_export_copy
integer x = 110
integer y = 480
integer width = 695
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Add to End of Field List"
end type

event clicked;//<add> 08/22/2007 by: Andy
String ls_null

setnull(ls_null)
//---------Begin Modified by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
  /*
	em_num.text = ls_null      
  */
if this.checked then	//jervis 09.09.2010
	em_num.text = ls_null
	em_num.enabled = false
else
	em_num.enabled = true
end if 
//---------End Modfiied ------------------------------------------------------------------

//end of add
end event

type gb_2 from groupbox within w_export_copy
integer x = 46
integer y = 324
integer width = 1157
integer height = 252
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Setting"
end type

type sle_time from singlelineedit within w_export_copy
integer x = 530
integer y = 396
integer width = 270
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "1"
borderstyle borderstyle = stylelowered!
end type

