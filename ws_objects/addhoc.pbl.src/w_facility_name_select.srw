$PBExportHeader$w_facility_name_select.srw
$PBExportComments$(Appeon)Toney 06.10.2013 - V141 ISG-CLX
forward
global type w_facility_name_select from window
end type
type cb_search from commandbutton within w_facility_name_select
end type
type rb_all from radiobutton within w_facility_name_select
end type
type rb_other from radiobutton within w_facility_name_select
end type
type rb_contracted from radiobutton within w_facility_name_select
end type
type rb_our from radiobutton within w_facility_name_select
end type
type sle_search from singlelineedit within w_facility_name_select
end type
type cb_1 from commandbutton within w_facility_name_select
end type
type cb_cancel from commandbutton within w_facility_name_select
end type
type cb_ok from commandbutton within w_facility_name_select
end type
type dw_facility_select from u_dw within w_facility_name_select
end type
type gb_1 from groupbox within w_facility_name_select
end type
type gb_2 from groupbox within w_facility_name_select
end type
end forward

global type w_facility_name_select from window
integer width = 2277
integer height = 1384
boolean titlebar = true
string title = "Company Select List"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_search cb_search
rb_all rb_all
rb_other rb_other
rb_contracted rb_contracted
rb_our rb_our
sle_search sle_search
cb_1 cb_1
cb_cancel cb_cancel
cb_ok cb_ok
dw_facility_select dw_facility_select
gb_1 gb_1
gb_2 gb_2
end type
global w_facility_name_select w_facility_name_select

type variables
string is_type  
end variables

on w_facility_name_select.create
this.cb_search=create cb_search
this.rb_all=create rb_all
this.rb_other=create rb_other
this.rb_contracted=create rb_contracted
this.rb_our=create rb_our
this.sle_search=create sle_search
this.cb_1=create cb_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_facility_select=create dw_facility_select
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cb_search,&
this.rb_all,&
this.rb_other,&
this.rb_contracted,&
this.rb_our,&
this.sle_search,&
this.cb_1,&
this.cb_cancel,&
this.cb_ok,&
this.dw_facility_select,&
this.gb_1,&
this.gb_2}
end on

on w_facility_name_select.destroy
destroy(this.cb_search)
destroy(this.rb_all)
destroy(this.rb_other)
destroy(this.rb_contracted)
destroy(this.rb_our)
destroy(this.sle_search)
destroy(this.cb_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_facility_select)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;String	ls_Value,ls_facility
long		ll_Find,ll_Pos


dw_facility_select.SetTransObject(SQLCA)
dw_facility_select.Retrieve()

ls_Value = Trim(Message.StringParm)
is_type = left(ls_Value,5)
ls_value = mid(ls_value,6)
if Not (IsNull(ls_Value) or Trim(ls_Value) = "") then

	if is_type = 'code&' then
		if Right(ls_Value,1) <> "," then ls_Value += ","
		
		do 
			ll_Pos = Pos(ls_Value,"',")
			ls_facility = Left(ls_Value,ll_Pos)
			ls_Value = Mid(ls_Value,ll_Pos + 2)
			
			ll_Pos = Pos(ls_facility,"''")
			do while ll_Pos > 0
				ls_facility = Replace(ls_facility,ll_Pos,2,"~~'")
				ll_Pos = Pos(ls_facility,"''",ll_Pos + 2)
			loop
			
			ll_Find = dw_facility_select.Find("facility_id = " + ls_facility,1,dw_facility_select.RowCount())
			if ll_Find > 0 then
				dw_facility_select.SetItem(ll_Find,"selected",1)
			end if
		loop while ls_Value <> ""
		
	elseif is_type = 'name&' then
		if Right(ls_Value,1) <> "," then ls_Value += ","
		
		do 
			ll_Pos = Pos(ls_Value,"',")
			ls_facility = Left(ls_Value,ll_Pos)
			ls_Value = Mid(ls_Value,ll_Pos + 2)
			
			ll_Pos = Pos(ls_facility,"''")
			do while ll_Pos > 0
				ls_facility = Replace(ls_facility,ll_Pos,2,"~~'")
				ll_Pos = Pos(ls_facility,"''",ll_Pos + 2)
			loop
			
			ll_Find = dw_facility_select.Find("facility_name = " + ls_facility,1,dw_facility_select.RowCount())
			if ll_Find > 0 then
				dw_facility_select.SetItem(ll_Find,"selected",1)
			end if
		loop while ls_Value <> ""
	end if
end if

dw_facility_select.SetSort("selected D,facility_id A")
dw_facility_select.Sort()

end event

type cb_search from commandbutton within w_facility_name_select
integer x = 1865
integer y = 96
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Search"
boolean default = true
end type

event clicked;String 	ls_Orig_SQL,ls_Where,ls_Type
String 	ls_SearchText
long		ll_Pos

ls_Orig_SQL = dw_facility_select.GetSQLSelect()

ls_SearchText = Lower(Trim(sle_Search.Text))

ll_Pos = Pos(ls_SearchText,"'")
do while ll_Pos > 0
	ls_SearchText = Replace(ls_SearchText,ll_Pos,1,"''")
	ll_Pos = Pos(ls_SearchText,"'",ll_Pos + 2)
loop

if rb_our.Checked then
	ls_Type = 'A'
elseif rb_contracted.Checked then
	ls_Type = 'B'
elseif rb_other.Checked then
	ls_Type = 'O'
elseif rb_all.Checked then
	ls_Type = ''
end if

dw_facility_select.Reset()

ls_Where = " where (lower(app_facility.facility_name) like '%" + ls_SearchText + "%')"

if ls_Type <> '' then
	ls_Where += " and (app_facility.contact_type2='" + ls_Type + "')"
end if

dw_facility_select.SetSQLSelect(ls_Orig_SQL + ls_Where)
dw_facility_select.Retrieve()
dw_facility_select.SetSQLSelect(ls_Orig_SQL)

sle_Search.SetFocus()

end event

type rb_all from radiobutton within w_facility_name_select
integer x = 699
integer y = 160
integer width = 338
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "All"
boolean checked = true
end type

type rb_other from radiobutton within w_facility_name_select
integer x = 699
integer y = 72
integer width = 338
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "Other"
end type

type rb_contracted from radiobutton within w_facility_name_select
integer x = 69
integer y = 160
integer width = 571
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "Contracted Company"
end type

type rb_our from radiobutton within w_facility_name_select
integer x = 69
integer y = 72
integer width = 416
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "Our Company"
end type

type sle_search from singlelineedit within w_facility_name_select
integer x = 1138
integer y = 100
integer width = 718
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_facility_name_select
integer x = 18
integer y = 1176
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Select All"
end type

event clicked;long	ll_Cycle,ll_RowCnts,ls_Value[]

ll_RowCnts = dw_facility_select.RowCount()

if this.text = "&Select All" then
	for ll_Cycle = 1 to ll_RowCnts
		ls_Value[ll_Cycle] = 1
	next
	dw_facility_select.Object.selected.Primary = ls_Value
	this.text = "&Deselect All"
else
	for ll_Cycle = 1 to ll_RowCnts
		ls_Value[ll_Cycle] = 0
	next
	dw_facility_select.Object.selected.Primary = ls_Value
	this.text = "&Select All"
end if

end event

type cb_cancel from commandbutton within w_facility_name_select
integer x = 1906
integer y = 1176
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,"")

end event

type cb_ok from commandbutton within w_facility_name_select
integer x = 1527
integer y = 1176
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&OK"
end type

event clicked;long		ll_Find,ll_RowCnts,ll_Pos
String	ls_AllSelect,ls_facility

ll_RowCnts = dw_facility_select.RowCount()

do 
	ll_Find = dw_facility_select.Find("selected = 1",ll_Find + 1,ll_RowCnts)
	if ll_Find <= 0 then Exit
	
	if is_type = 'code&' then
		ls_facility = String(dw_facility_select.GetItemNumber(ll_Find,"facility_id"))
	else
		ls_facility = dw_facility_select.GetItemString(ll_Find,"facility_name")
	end if
	
	ll_Pos = Pos(ls_facility,"'")
	do while ll_Pos > 0
		//---------Begin Modified by (Appeon)Harry 04.24.2014 for  Bug # 4010--------
		//ls_facility = Replace(ls_facility,ll_Pos,1,"''")
		ls_facility = Replace(ls_facility,ll_Pos,1,"~'")
		//---------End Modfiied ------------------------------------------------------
		ll_Pos = Pos(ls_facility,"'",ll_Pos + 2)
	loop
	
	if is_type = 'code&' then
		ls_AllSelect += String(ls_facility) + ","
	else
		ls_AllSelect += "'" + String(ls_facility) + "',"
	end if
loop while ll_Find < ll_RowCnts

if ls_AllSelect = "" then ls_AllSelect = ","

CloseWithReturn(Parent,ls_AllSelect)

end event

type dw_facility_select from u_dw within w_facility_name_select
integer x = 18
integer y = 272
integer width = 2231
integer height = 880
integer taborder = 30
string title = "none"
string dataobject = "d_facility_name_select"
boolean hscrollbar = true
end type

event clicked;call super::clicked;long	ll_Selected

if Row > 0 and Row <= This.RowCount() then
	This.SetRow(Row)
	ll_Selected = This.GetItemNumber(Row,"Selected")
	This.SetItem(Row,"Selected",1 - ll_Selected)
end if

end event

event doubleclicked;This.Trigger Event Clicked(XPos,YPos,Row,dwo)
end event

event constructor;call super::constructor;of_SetSort(True)
inv_sort.of_SetColumnHeader(True)

end event

type gb_1 from groupbox within w_facility_name_select
integer x = 18
integer width = 1047
integer height = 252
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "Company Category"
end type

type gb_2 from groupbox within w_facility_name_select
integer x = 1097
integer width = 1152
integer height = 252
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "Company Name Search"
end type

