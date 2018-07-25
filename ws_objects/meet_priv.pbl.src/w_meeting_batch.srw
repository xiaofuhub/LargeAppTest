$PBExportHeader$w_meeting_batch.srw
forward
global type w_meeting_batch from w_master
end type
type st_3 from statictext within w_meeting_batch
end type
type st_2 from statictext within w_meeting_batch
end type
type st_1 from statictext within w_meeting_batch
end type
type dw_list from datawindow within w_meeting_batch
end type
type cb_close from commandbutton within w_meeting_batch
end type
type cb_add from commandbutton within w_meeting_batch
end type
type cb_del from commandbutton within w_meeting_batch
end type
type cb_save from commandbutton within w_meeting_batch
end type
type cb_run from commandbutton within w_meeting_batch
end type
type dw_existing from datawindow within w_meeting_batch
end type
type dw_detail from u_dw within w_meeting_batch
end type
end forward

global type w_meeting_batch from w_master
integer width = 3918
integer height = 2304
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
st_3 st_3
st_2 st_2
st_1 st_1
dw_list dw_list
cb_close cb_close
cb_add cb_add
cb_del cb_del
cb_save cb_save
cb_run cb_run
dw_existing dw_existing
dw_detail dw_detail
end type
global w_meeting_batch w_meeting_batch

forward prototypes
public function integer of_filter_lookup (string as_data)
end prototypes

public function integer of_filter_lookup (string as_data);//Start Code Change ----08.31.2011 #V11 maha - added called from RFC and itemchanged
datawindowchild dwchild
long ll_facil
integer res
string f
//debugbreak()

if as_data = "607"  then
	dw_detail.Modify( "lookup_code.dddw.name = 'd_dddw_credentialing_committees_batch'")
	dw_detail.Modify( "lookup_code.dddw.datacolumn = 'committee_id'")			
	dw_detail.Modify(  "lookup_code.dddw.displaycolumn = 'committee_name'")
	res = dw_detail.GetChild("lookup_code", dwchild)
	res = dwchild.SetTransObject( SQLCA )
	ll_facil =  dw_detail.GetItemNumber( dw_detail.getrow(), "facility") 
	res = dwchild.Retrieve( )
	f = " facility_id = " + string(ll_facil) 
	res = dwchild.setfilter ( f )
	dwchild.filter()
else
	dw_detail.Modify( "lookup_code.dddw.name = 'd_dddw_code_lookup'")
	dw_detail.Modify( "lookup_code.dddw.datacolumn = 'lookup_code'")			
	dw_detail.Modify(  "lookup_code.dddw.displaycolumn = 'description'")
	dw_detail.GetChild("lookup_code", dwchild)
	dwchild.SetTransObject( SQLCA )
	choose case as_data
		case "605"
			gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name)='" + upper("department") + "'" , dwchild)
		case "606"
			gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name)='" + upper("section") + "'" , dwchild)
		case "-78"
			gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name)='" + upper("committee") + "'" , dwchild)
	end choose
end if

return 1
end function

event open;call super::open;//Start Code Change ----05.15.2011 #V12 maha - created
dw_list.settransobject(sqlca)
dw_detail.settransobject(sqlca)
dw_existing.settransobject(sqlca)

dw_list.retrieve()


end event

on w_meeting_batch.create
int iCurrent
call super::create
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.dw_list=create dw_list
this.cb_close=create cb_close
this.cb_add=create cb_add
this.cb_del=create cb_del
this.cb_save=create cb_save
this.cb_run=create cb_run
this.dw_existing=create dw_existing
this.dw_detail=create dw_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_list
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.cb_add
this.Control[iCurrent+7]=this.cb_del
this.Control[iCurrent+8]=this.cb_save
this.Control[iCurrent+9]=this.cb_run
this.Control[iCurrent+10]=this.dw_existing
this.Control[iCurrent+11]=this.dw_detail
end on

on w_meeting_batch.destroy
call super::destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_list)
destroy(this.cb_close)
destroy(this.cb_add)
destroy(this.cb_del)
destroy(this.cb_save)
destroy(this.cb_run)
destroy(this.dw_existing)
destroy(this.dw_detail)
end on

event pfc_save;//unextend ancestor script
//------------------- APPEON BEGIN -------------------
//$<add> Michael 09.21.2011
//$<reason> Fixed a bug #2651 required fields
if cb_save.event clicked( ) = -1 then 
	return -1
else
	return 1
end if
//------------------- APPEON END ---------------------
end event

type st_3 from statictext within w_meeting_batch
integer y = 148
integer width = 827
integer height = 88
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Meeting Batches"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_2 from statictext within w_meeting_batch
integer x = 832
integer y = 148
integer width = 3072
integer height = 88
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "   Detail"
boolean border = true
boolean focusrectangle = false
end type

type st_1 from statictext within w_meeting_batch
integer x = 832
integer y = 1428
integer width = 3072
integer height = 88
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "   Existing Meetings"
boolean border = true
boolean focusrectangle = false
end type

type dw_list from datawindow within w_meeting_batch
integer y = 232
integer width = 827
integer height = 1988
integer taborder = 40
string title = "Meeting Batches"
string dataobject = "d_meeting_batch_browse"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;integer r 

r =  this.getclickedrow()
if r  < 1 then return //Add by Michael 09.27.2011 Fixed a bug of r=0
this.setrow(r)
end event

event rowfocuschanged;long ll_batch
long ll_type

if currentrow < 1 then return //Add by Michael 09.27.2011 Fixed a bug of currentrow=0
this.selectrow(0, false)
this.selectrow( currentrow, true)

ll_batch = this.getitemnumber(currentrow,"batch_id")

dw_detail.retrieve(ll_batch)
ll_type = dw_detail.getitemnumber(1,"meeting_type")
of_filter_lookup(string(ll_type))

dw_existing.retrieve(ll_batch,gs_user_id)
end event

type cb_close from commandbutton within w_meeting_batch
integer x = 3543
integer y = 28
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

type cb_add from commandbutton within w_meeting_batch
integer x = 1865
integer y = 28
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;//Modify by Michael 09.21.2011 Fixed a bug #2651 required fields
//cb_save.triggerevent(clicked!)
if cb_save.event clicked( ) = -1 then return 

dw_detail.reset()
dw_detail.insertrow(1)
end event

type cb_del from commandbutton within w_meeting_batch
integer x = 2231
integer y = 28
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;integer res
long r
long ll_id
long m

if dw_detail.rowcount() = 0 then return //Add by Michael 09.26.2011 Fixed a bug of Batch Meetings - Bug id 2666


//Start Code Change ----07.20.2012 #V12 maha - mod to allow deleting connected meetings
open(w_meet_delete_message) 
//res = messagebox("Delete","Are you sure you wish to delete the record?  Created meetings will not be deleted",question!,yesno!,2)
//debugbreak()

res = message.doubleparm

if res = 0 then  //if 0 then cancel
	return
elseif res = 2 then
	m = dw_existing.rowcount()
	for r = 1 to m
		ll_id = dw_existing.getitemnumber(1,"meeting_id")
		delete from attendence where meeting_id = :ll_id;
		dw_existing.deleterow(1)
		commit using sqlca;
	next
	dw_existing.update()
end if

//delete the batch record
dw_detail.deleterow(0)
cb_save.event clicked( ) //Add by Michael 09.26.2011 Fixed a bug of Batch Meetings - Bug id 2666
//End Code Change ----07.20.2012

end event

type cb_save from commandbutton within w_meeting_batch
integer x = 2583
integer y = 28
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

event clicked;long li_id
long ll_row
//------------------- APPEON BEGIN -------------------
//$<add> Michael 09.21.2011
//$<reason> Fixed a bug #2651 required fields
if dw_detail.getitemstatus(1, 0, primary!) =  NotModified! then return 1
dw_detail.accepttext( )
ll_row = dw_detail.getrow()
if ll_row >0  then
	IF Isnull(dw_detail.getitemstring(ll_row,"batch_name")) OR Trim(dw_detail.getitemstring(ll_row,"batch_name")) = "" THEN
		Messagebox("Error", "Required information for Batch Name.")
		dw_detail.setfocus( )
		dw_detail.setcolumn("batch_name")
		Return -1
	END IF
	
	IF Isnull(dw_detail.getitemnumber(ll_row,"creation_type")) THEN
		Messagebox("Error", "Required information for Creation Type.")
		dw_detail.setfocus( )
		dw_detail.setcolumn("creation_type")
		Return -1
	END IF
	
	IF Isnull(dw_detail.getitemnumber(ll_row,"frequency")) THEN
		Messagebox("Error", "Required information for Frequency.")
		dw_detail.setfocus( )
		dw_detail.setcolumn("frequency")
		Return -1
	END IF
	
	IF Isnull(dw_detail.getitemnumber(ll_row,"active_status")) THEN
		Messagebox("Error", "Required information for Active Status.")
		dw_detail.setfocus( )
		dw_detail.setcolumn("active_status")
		Return -1
	END IF
	
	IF Isnull(dw_detail.getitemnumber(ll_row,"day_of_week")) THEN
		Messagebox("Error", "Required information for Day Of Week.")
		dw_detail.setfocus( )
		dw_detail.setcolumn("day_of_week")
		Return -1
	END IF
	
	IF Isnull(dw_detail.getitemnumber(ll_row,"days_advance")) THEN
		Messagebox("Error", "Required information for Max days from now.")
		dw_detail.setfocus( )
		dw_detail.setcolumn("days_advance")
		Return -1
	END IF
	
	IF Isnull(dw_detail.getitemnumber(ll_row,"facility")) THEN
		Messagebox("Error", "Required information for Facility.")
		dw_detail.setfocus( )
		dw_detail.setcolumn("facility")
		Return -1
	END IF
	
	IF Isnull(dw_detail.getitemnumber(ll_row,"meeting_type")) THEN
		Messagebox("Error", "Required information for MeetingType.")
		dw_detail.setfocus( )
		dw_detail.setcolumn("meeting_type")
		Return -1
	END IF
	
	IF Isnull(dw_detail.getitemstring(ll_row,"subject")) OR Trim(dw_detail.getitemstring(ll_row,"subject")) = "" THEN
		Messagebox("Error", "Required information for Subject.")
		dw_detail.setfocus( )
		dw_detail.setcolumn("subject")
		Return -1
	END IF
	
	IF Isnull(dw_detail.getitemstring(ll_row,"start_time")) OR Trim(dw_detail.getitemstring(ll_row,"start_time")) = "" THEN
		Messagebox("Error", "Required information for Start Time.")
		dw_detail.setfocus( )
		dw_detail.setcolumn("start_time")
		Return -1
	end if
END IF
//------------------- APPEON END ---------------------

if dw_detail.getitemstatus(1, 0, primary!) =  NewModified! then
	select max(batch_id ) into :li_id from meeting_batch_add;
	if isnull(li_id) then li_id = 0
	li_id++
	dw_detail.setitem(1,"batch_id", li_id)
end if

dw_detail.update() 

//------------------- APPEON BEGIN -------------------
//$<add> Michael 09.26.2011
//$<reason> Fixed a bug of Batch Meetings - Bug id 2666
parent.setredraw( false)
dw_list.retrieve()
dw_list.setfocus()
dw_list.scrolltorow(dw_list.rowcount())
dw_list.setrow(dw_list.rowcount())
dw_list.selectrow(dw_list.rowcount(),true)
parent.setredraw( true)
//------------------- APPEON END ---------------------

end event

type cb_run from commandbutton within w_meeting_batch
integer x = 1490
integer y = 28
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;n_cst_meeting_creation lnv_meet
integer res
long ll_batch
datetime ldt_last

lnv_meet = create n_cst_meeting_creation

if dw_detail.rowcount() = 0 then return //Start Code Change ----09.09.2011.2011 #V12 maha

ll_batch = dw_detail.getitemnumber(dw_detail.getrow(),"batch_id")


res = lnv_meet.of_create_meetings( ll_batch,"USER",ldt_last)

if res = 1 then
	dw_detail.setitem(1,"last_created",ldt_last)
	dw_existing.retrieve(ll_batch,gs_user_id)
end if


destroy lnv_meet
end event

type dw_existing from datawindow within w_meeting_batch
integer x = 832
integer y = 1520
integer width = 3072
integer height = 700
integer taborder = 10
string title = "Existing Meetings"
string dataobject = "d_meetings_list_from_batch"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_detail from u_dw within w_meeting_batch
integer x = 832
integer y = 236
integer width = 3072
integer height = 1188
integer taborder = 40
boolean bringtotop = true
string title = "Detail"
string dataobject = "d_meeting_batch_detail"
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;//Start Code Change ----08.31.2011 #V11 maha 
if dwo.name = "meeting_type" then
	of_filter_lookup(data)
end if

end event

event constructor;call super::constructor;//------------------- APPEON BEGIN -------------------
//$<add> Michael 09.21.2011
//$<reason> Start Time field is  a drop down to pick the time
datawindowchild dwchild
dw_detail.GetChild("start_time", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("time")
//------------------- APPEON END ---------------------
This.of_SetDropDownCalendar( TRUE )//Add by Michael 09.23.2011 --- Fixed a bug (Start From and Last Created) do not have the normal Date selection screen

end event

