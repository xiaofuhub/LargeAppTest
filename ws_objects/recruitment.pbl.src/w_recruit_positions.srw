$PBExportHeader$w_recruit_positions.srw
forward
global type w_recruit_positions from w_popup
end type
type cb_setup from commandbutton within w_recruit_positions
end type
type dw_stat_filt from u_dw within w_recruit_positions
end type
type dw_dates from u_dw within w_recruit_positions
end type
type dw_detail from u_dw within w_recruit_positions
end type
type cb_1 from commandbutton within w_recruit_positions
end type
type cb_2 from commandbutton within w_recruit_positions
end type
type cb_add from commandbutton within w_recruit_positions
end type
type cb_save from commandbutton within w_recruit_positions
end type
type cb_close from commandbutton within w_recruit_positions
end type
type cb_delete from commandbutton within w_recruit_positions
end type
type cb_3 from commandbutton within w_recruit_positions
end type
type rb_filled from radiobutton within w_recruit_positions
end type
type rb_close from radiobutton within w_recruit_positions
end type
type rb_open from radiobutton within w_recruit_positions
end type
type gb_3 from groupbox within w_recruit_positions
end type
type gb_2 from groupbox within w_recruit_positions
end type
type gb_1 from groupbox within w_recruit_positions
end type
type dw_browse from u_dw within w_recruit_positions
end type
end forward

global type w_recruit_positions from w_popup
integer width = 4215
integer height = 2656
string title = "Recruitment Positions"
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
cb_setup cb_setup
dw_stat_filt dw_stat_filt
dw_dates dw_dates
dw_detail dw_detail
cb_1 cb_1
cb_2 cb_2
cb_add cb_add
cb_save cb_save
cb_close cb_close
cb_delete cb_delete
cb_3 cb_3
rb_filled rb_filled
rb_close rb_close
rb_open rb_open
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_browse dw_browse
end type
global w_recruit_positions w_recruit_positions

type variables
long il_stat_filter = 0
date id_date_from
date id_date_to
end variables

forward prototypes
public function integer of_setfilter ()
public function integer of_modify_prop ()
end prototypes

public function integer of_setfilter (); //Start Code Change ----02.18.2015 #V15 maha - created
string s
string d
string ls_field
string ls_date
date ld_set
date ld_from
date ld_to
integer r

dw_dates.accepttext()
debugbreak()
if il_stat_filter <> 0 then
	s = "pos_status = " + string(il_stat_filter)
end if

if rb_open.checked then
	ls_field = "opened_date"
elseif rb_close.checked then
	ls_field = "closed_date"
elseif rb_filled.checked then
	ls_field = "filled_date"
end if	

ld_set = dw_dates.getitemdate(1,"from_date")

ld_from  = dw_dates.getitemdate(1,"from_date")
ld_to  = dw_dates.getitemdate(1,"to_date")


if not isnull(ld_from) then
	ls_date = ls_field + " >= date('" + string(ld_from) + "') and "
end if

ld_set = dw_dates.getitemdate(1,"to_date")

if not isnull(ld_set) then
	ls_date+=   ls_field + " <= date('" + string(ld_to) + "') and "
end if

ls_date = mid(ls_date,1,len(ls_date) - 5)


//combine
if len( s) > 5 then
	if len(ls_date) > 5 then
		s = s + " and " + ls_date
	end if
else
	s = ls_date
end if

r = dw_browse.setfilter(s)

if r < 0 then
	messagebox("Filter Failed", s)
else
	//messagebox("Filter OK", s)
end if

dw_browse.filter()


















return 1
end function

public function integer of_modify_prop ();//copied from w_recruitment_data_tabs
datastore lds_field_prop
long ll_rowcount
Integer ll_i
String ls_field_name
String ls_text
String ls_sqlselect
string s
Integer li_visible


lds_field_prop = create datastore
lds_field_prop.dataobject = 'd_sys_field_prop_recruiting'
lds_field_prop.settransobject( sqlca)

//debugbreak()
ls_sqlselect = lds_field_prop.Describe("DataWindow.Table.Select")

if lenA(ls_sqlselect) > 0 then
	ls_sqlselect += ' and table_id = -2 '
end if


lds_field_prop.Modify("DataWindow.Table.Select='"+ ls_sqlselect + "'")

ll_rowcount = lds_field_prop.retrieve( )

For ll_i = 1 to ll_rowcount
	ls_text = lds_field_prop.getitemstring( ll_i,'field_name_allias')
	ls_field_name = lds_field_prop.getitemstring( ll_i,'field_name')
	li_visible = lds_field_prop.getItemNumber(ll_i,"range_from")
	if li_visible = 0 then
		dw_detail.modify( ls_field_name+".visible = '0'")
		dw_detail.modify( ls_field_name+"_t.visible = '0'")
		continue
	else
		li_visible = 1				
	end if
		
	if li_visible = 1 then
		if lds_field_prop.getitemnumber( ll_i,'range_to') = 1 then //required
			if  lds_field_prop.getitemstring( ll_i,'lookup_field') = 'Y' then
				dw_detail.modify( ls_field_name+'.DDDW.Required=Yes')
			end if	
			dw_detail.modify( ls_field_name+".background.color = '8257535'")
		end if
		
		s = ls_field_name + '_t.text'
		if dw_detail.describe( s )  = "!" then	
		//if	dw_detail.describe( ls_field_name+".visible") <> "!" then
			messagebox("Failed",s)
		else
			dw_detail.modify( ls_field_name + "_t.text='"+ ls_text +"'")
		end if
	end if
next

destroy lds_field_prop

return 1
end function

on w_recruit_positions.create
int iCurrent
call super::create
this.cb_setup=create cb_setup
this.dw_stat_filt=create dw_stat_filt
this.dw_dates=create dw_dates
this.dw_detail=create dw_detail
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_add=create cb_add
this.cb_save=create cb_save
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_3=create cb_3
this.rb_filled=create rb_filled
this.rb_close=create rb_close
this.rb_open=create rb_open
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_browse=create dw_browse
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_setup
this.Control[iCurrent+2]=this.dw_stat_filt
this.Control[iCurrent+3]=this.dw_dates
this.Control[iCurrent+4]=this.dw_detail
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_add
this.Control[iCurrent+8]=this.cb_save
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.cb_delete
this.Control[iCurrent+11]=this.cb_3
this.Control[iCurrent+12]=this.rb_filled
this.Control[iCurrent+13]=this.rb_close
this.Control[iCurrent+14]=this.rb_open
this.Control[iCurrent+15]=this.gb_3
this.Control[iCurrent+16]=this.gb_2
this.Control[iCurrent+17]=this.gb_1
this.Control[iCurrent+18]=this.dw_browse
end on

on w_recruit_positions.destroy
call super::destroy
destroy(this.cb_setup)
destroy(this.dw_stat_filt)
destroy(this.dw_dates)
destroy(this.dw_detail)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_add)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_3)
destroy(this.rb_filled)
destroy(this.rb_close)
destroy(this.rb_open)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_browse)
end on

event open;call super::open;long  lid
long rc

dw_browse.settransobject(sqlca)
rc = dw_browse.retrieve()

if rc < 1 then return

dw_detail.settransobject(sqlca)

of_modify_prop()
end event

type cb_setup from commandbutton within w_recruit_positions
integer x = 2272
integer y = 36
integer width = 567
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Custom Field Setup"
end type

event clicked;
open(w_recruit_position_setup)

of_modify_prop()
end event

type dw_stat_filt from u_dw within w_recruit_positions
integer x = 101
integer y = 272
integer width = 1088
integer height = 80
integer taborder = 70
string dataobject = "d_req_pos_status"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;il_stat_filter = long(data)
end event

event constructor;call super::constructor;datawindowchild dwchild

this.settransobject(sqlca)
this.retrieve()

this.getchild( "lookup_code", dwchild )
dwchild.settransobject(sqlca)
dwchild.insertrow(1)
dwchild.setitem(1, "lookup_code", 0)
this.setitem(1, "lookup_code", 0)

this.of_setupdateable( false)
end event

type dw_dates from u_dw within w_recruit_positions
integer x = 2249
integer y = 260
integer width = 1463
integer height = 88
integer taborder = 60
string dataobject = "d_date_range_get_blue"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar( TRUE )
this.iuo_calendar.of_Register(this.iuo_calendar.DDLB)

this.of_setupdateable( false)

this.insertrow(1)
end event

type dw_detail from u_dw within w_recruit_positions
integer y = 1040
integer width = 4201
integer height = 1532
integer taborder = 40
boolean titlebar = true
string title = "Detail"
string dataobject = "d_recruit_position_detail"
boolean vscrollbar = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar( TRUE )
this.iuo_calendar.of_Register(this.iuo_calendar.DDLB)

end event

type cb_1 from commandbutton within w_recruit_positions
integer x = 3767
integer y = 260
integer width = 357
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Apply"
end type

event clicked;of_setfilter()
end event

type cb_2 from commandbutton within w_recruit_positions
integer x = 3314
integer y = 36
integer width = 480
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Candidates"
end type

event clicked; //Start Code Change ----03.18.2015 #V15 maha
long p
long c
long cn
long ll_candid

if dw_detail.rowcount() < 1 then
	messagebox("Candidates","There is no selected Postion")
	return
end if
debugbreak()
p = dw_detail.getitemnumber(1,"pos_id")

select count(rec_id) into :c from recruit_prac where recruit_pos = :p;

if c < 1 then
	messagebox("Candidates","There are no Candidates connected to the selected Postion")
	return
end if

open(w_recruitment_data_tabs )
w_recruitment_data_tabs.of_search_position(p)



end event

type cb_add from commandbutton within w_recruit_positions
integer x = 393
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
string text = "&Add"
end type

event clicked;cb_save.triggerevent(clicked!)
dw_detail.reset()
dw_detail.insertrow(1 )
end event

type cb_save from commandbutton within w_recruit_positions
integer x = 23
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;long ll_org_row
long ll_pos
long rc
long f

if dw_detail.rowcount( ) < 1 then return  //Start Code Change ----01.04.2016 #V15 maha

ll_pos = dw_detail.getitemnumber(1,"pos_id")

if isnull(ll_pos) then
	select max(pos_id) into : ll_pos from recruit_positions;
	if isnull(ll_pos) then ll_pos = 0
	ll_pos++
	dw_detail.setitem(1,"pos_id",ll_pos)
	
	dw_detail.update()
	
	rc = dw_browse.retrieve()
	f = dw_browse.find( "pos_id =" + string(ll_pos), 1, rc)
	if f > 0 then
		dw_browse.setrow(f)
		dw_browse.scrolltorow(f)
	end if
else
	dw_detail.update()
end if

end event

type cb_close from commandbutton within w_recruit_positions
integer x = 3817
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
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_delete from commandbutton within w_recruit_positions
integer x = 763
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
string text = "&Delete"
end type

event clicked; //Start Code Change ----03.18.2015 #V15 maha
integer res
long rc
long p
string ls_mes

if dw_detail.rowcount( ) = 0 then return
p = dw_detail.getitemnumber(1,"pos_id")

select count(rec_id) into :rc from recruit_prac where recruit_pos = :p;

if rc > 0 then
	openwithparm(w_recruit_pos_delete_mes, rc)
	ls_mes = message.stringparm
	if ls_mes = "Cancel" then return
end if

res = messagebox("Position Delete","Are you sure you want to delete this Position rather than making it inactive?",question!,yesno!,2)

if res = 1 then
	update recruit_prac set recruit_pos = null where recruit_pos = :p;
	commit using sqlca;
	dw_detail.deleterow(1)
	dw_detail.update()
	rc = dw_browse.retrieve()
	if rc > 0 then
		dw_browse.selectrow(1,true)
		p = dw_browse.getitemnumber(1,"pos_id")
		dw_detail.retrieve(p)
	end if
end if



end event

type cb_3 from commandbutton within w_recruit_positions
integer x = 2885
integer y = 36
integer width = 407
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Get WV Link"
end type

event clicked; //Start Code Change ----03.18.2015 #V15 maha
string ls_wv_link
string ls_rec_link
long p

if dw_detail.rowcount( ) = 0 then return
p = dw_detail.getitemnumber(1,"pos_id")

if isnull(p) or p = 0 then return
//Build the WV email link 

ls_wv_link = gnv_data.of_getitem('ids','wv_meeting_link',false)
if right(ls_wv_link,1) <> '/' then
	//---------Begin Modified by (Appeon)Stephen 04.05.2016 for V15 recruitment issues with Build 3/28/16--------
	//ls_rec_link+= "/"
	ls_wv_link+= "/"
	//---------End Modfiied ------------------------------------------------------

end if

ls_rec_link = ls_wv_link +'recruitment/index.cfm?pos_id='+string(p)


openwithparm(w_wv_link,ls_rec_link)
end event

type rb_filled from radiobutton within w_recruit_positions
integer x = 1957
integer y = 272
integer width = 261
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Filled"
end type

type rb_close from radiobutton within w_recruit_positions
integer x = 1650
integer y = 276
integer width = 261
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Closed"
end type

type rb_open from radiobutton within w_recruit_positions
integer x = 1303
integer y = 276
integer width = 302
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Opened"
boolean checked = true
end type

type gb_3 from groupbox within w_recruit_positions
integer x = 1225
integer y = 224
integer width = 2514
integer height = 144
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Date Filters"
end type

type gb_2 from groupbox within w_recruit_positions
integer x = 55
integer y = 224
integer width = 1147
integer height = 144
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Position Status"
end type

type gb_1 from groupbox within w_recruit_positions
integer x = 32
integer y = 168
integer width = 4151
integer height = 244
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filters"
end type

type dw_browse from u_dw within w_recruit_positions
integer y = 448
integer width = 4201
integer height = 588
integer taborder = 40
boolean titlebar = true
string title = "Browse"
string dataobject = "d_recruit_position_browse"
boolean hscrollbar = true
end type

event clicked;call super::clicked;integer r

r = this.getclickedrow()
this.setrow(r)
end event

event rowfocuschanged;call super::rowfocuschanged;long pid

if currentrow < 1 then
	dw_detail.reset()
	return
end if

this.selectrow(0,false)
this.selectrow(currentrow,true)

pid = this.getitemnumber(currentrow, "pos_id")
dw_detail.retrieve(pid)

end event

event constructor;call super::constructor;this.of_setupdateable( false)
end event

