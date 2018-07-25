$PBExportHeader$w_prac_note_142.srw
forward
global type w_prac_note_142 from window
end type
type cb_filter from commandbutton within w_prac_note_142
end type
type cb_sort from commandbutton within w_prac_note_142
end type
type dw_print from datawindow within w_prac_note_142
end type
type gb_1 from groupbox within w_prac_note_142
end type
type p_1 from picture within w_prac_note_142
end type
type st_1 from statictext within w_prac_note_142
end type
type cb_print from commandbutton within w_prac_note_142
end type
type cb_add from commandbutton within w_prac_note_142
end type
type tab_1 from tab within w_prac_note_142
end type
type tabpage_browse from userobject within tab_1
end type
type rb_both from radiobutton within tabpage_browse
end type
type rb_calls from radiobutton within tabpage_browse
end type
type rb_notes from radiobutton within tabpage_browse
end type
type dw_prac_notes from datawindow within tabpage_browse
end type
type gb_view from groupbox within tabpage_browse
end type
type tabpage_browse from userobject within tab_1
rb_both rb_both
rb_calls rb_calls
rb_notes rb_notes
dw_prac_notes dw_prac_notes
gb_view gb_view
end type
type tabpage_detail from userobject within tab_1
end type
type dw_detail from datawindow within tabpage_detail
end type
type tabpage_detail from userobject within tab_1
dw_detail dw_detail
end type
type tab_1 from tab within w_prac_note_142
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
end type
type cb_close from commandbutton within w_prac_note_142
end type
type cb_save from commandbutton within w_prac_note_142
end type
type dw_facil from datawindow within w_prac_note_142
end type
end forward

global type w_prac_note_142 from window
integer x = 73
integer y = 376
integer width = 3465
integer height = 2212
boolean titlebar = true
string title = "Notes"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32891346
cb_filter cb_filter
cb_sort cb_sort
dw_print dw_print
gb_1 gb_1
p_1 p_1
st_1 st_1
cb_print cb_print
cb_add cb_add
tab_1 tab_1
cb_close cb_close
cb_save cb_save
dw_facil dw_facil
end type
global w_prac_note_142 w_prac_note_142

type variables
integer ii_facid
long il_prac_id //maha 032210
boolean ib_change = False
string is_facil_filter
string is_type_filter
end variables

forward prototypes
public function integer of_filter ()
end prototypes

public function integer of_filter (); //Start Code Change ----07.08.2013 #V14 maha
string ls_filter

ls_filter = ""

if len(is_facil_filter ) > 0 then ls_filter = is_facil_filter 

if len(is_type_filter ) > 1 then
	if  len(ls_filter ) > 0 then 
		ls_filter = " and " + is_type_filter
	else
		 ls_filter = is_type_filter 
	end if
end if

tab_1.tabpage_browse.dw_prac_notes.setfilter(ls_filter)
tab_1.tabpage_browse.dw_prac_notes.filter()

return 1
end function

on w_prac_note_142.create
this.cb_filter=create cb_filter
this.cb_sort=create cb_sort
this.dw_print=create dw_print
this.gb_1=create gb_1
this.p_1=create p_1
this.st_1=create st_1
this.cb_print=create cb_print
this.cb_add=create cb_add
this.tab_1=create tab_1
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_facil=create dw_facil
this.Control[]={this.cb_filter,&
this.cb_sort,&
this.dw_print,&
this.gb_1,&
this.p_1,&
this.st_1,&
this.cb_print,&
this.cb_add,&
this.tab_1,&
this.cb_close,&
this.cb_save,&
this.dw_facil}
end on

on w_prac_note_142.destroy
destroy(this.cb_filter)
destroy(this.cb_sort)
destroy(this.dw_print)
destroy(this.gb_1)
destroy(this.p_1)
destroy(this.st_1)
destroy(this.cb_print)
destroy(this.cb_add)
destroy(this.tab_1)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_facil)
end on

event open;//long ll_prac_id
integer i
integer li_pos
integer li_set
string ls_name
string ls_parm
datawindowchild dwchild

//ll_prac_id = gl_prac_id
//Start Code Change ----03.15.2010 #V10 maha - changed to pass facility parm
//ll_prac_id = message.doubleparm//maha changed 031904
ls_parm = message.stringparm
li_pos = PosA(ls_parm,"*",1)
il_prac_id = long(MidA(ls_parm, 1,li_pos -1 ))
ii_facid = integer(MidA(ls_parm, li_pos + 1, LenA(ls_parm) - li_pos  ))
//dw_facil.setitem(1,"facility_facility_id",ii_facid) //Start Code Change ----09.13.2012 #V12 maha - removed because while the facility was set the filter never took place.
//i = dw_facil.find( "facility_id = " + string(ii_facid), 1, dw_facil.rowcount())
//dw_facil.GetChild( "facility_facility_id", dwchild )
//i = dwchild.find( "facility_id = " + string(ii_facid), 1, dw_facil.rowcount())

tab_1.tabpage_browse.dw_prac_notes.SetTransObject( SQLCA )

 //Start Code Change ----07.08.2013 #V14 maha - call log
 li_set = of_get_app_setting("set_call_log","I")

if li_set = 1 then
	tab_1.tabpage_browse.gb_view.visible = true
	tab_1.tabpage_browse.rb_notes.visible = true
	tab_1.tabpage_browse.rb_both.visible = true
	tab_1.tabpage_browse.rb_calls.visible = true
end if

i = tab_1.tabpage_browse.dw_prac_notes.retrieve(il_prac_id,gs_user_id )
st_1.text = "Provider Id: " + string(il_prac_id) //Start Code Change ----10.14.2008 #V85 maha

select full_name
into :ls_name
from v_full_name
where prac_id = :il_prac_id;

w_prac_note.title = "Notes for " + ls_name

//Start Code Change ----09.12.2012 #V12 maha - changed to new setting; added add only functionality
if w_mdi.of_security_access( 7340 ) < 2 then 
//if w_mdi.of_security_access( 40 ) < 2 then
	tab_1.tabpage_detail.dw_detail.enabled = false
	//tab_1.tabpage_detail.dw_facil.enabled = false
	cb_add.enabled = false
	cb_save.enabled = false
else
	if  w_mdi.of_security_access( 7350 ) = 0 then //add but no edit
		tab_1.tabpage_detail.dw_detail.enabled = false
	end if
end if


	
	
	
end event

event close;//Start Code Change ----10.14.2008 #V85 maha
integer res
string ls_status

tab_1.tabpage_detail.dw_detail.accepttext( )
ls_status = of_check_row_status(tab_1.tabpage_detail.dw_detail,1)
//messagebox("Status",ls_status)
if ls_status  = "newmod" or ls_status  = "mod" or ls_status  = "new" then
	res = messagebox("Save Data","Do you wish to save the data before closing?",question!,yesno!,1)
	if res = 1 then
		cb_save.triggerevent("clicked")
	end if
end if
end event

type cb_filter from commandbutton within w_prac_note_142
integer x = 1870
integer y = 16
integer width = 247
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Filter"
end type

event clicked;string null_str

SetNull(null_str)

tab_1.tabpage_browse.dw_prac_notes.SetFilter(null_str)

tab_1.tabpage_browse.dw_prac_notes.Filter()
end event

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-02
//$<add> 01.12.2006 By: LeiWei
//$<reason> Due to one slight defect in Appeon product, the position of this button is incorrect to some degree after migration.
//$<modification> Adjust the position for this button to make sure the presentation of this button looks the same as in PowerBuilder.
//If appeongetclienttype() <> 'PB' Then
//	this.y += 12
//End If
//---------------------------- APPEON END ----------------------------

end event

type cb_sort from commandbutton within w_prac_note_142
integer x = 2139
integer y = 16
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Sort"
end type

event clicked;string null_str

SetNull(null_str)

tab_1.tabpage_browse.dw_prac_notes.Setsort(null_str)

tab_1.tabpage_browse.dw_prac_notes.sort()
end event

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<add> 01.12.2006 By: LeiWei
//$<reason> Due to one slight defect in Appeon product, the position of this button is incorrect to some degree after migration.
//$<modification> Adjust the position for this button to make sure the presentation of this button looks the same as in PowerBuilder.
//If appeongetclienttype() <> 'PB' Then
//	this.y += 12
//End If
//---------------------------- APPEON END ----------------------------

end event

type dw_print from datawindow within w_prac_note_142
boolean visible = false
integer x = 709
integer y = 8
integer width = 110
integer height = 80
integer taborder = 30
string title = "none"
string dataobject = "d_pd_notes_browse_print"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_prac_note_142
integer x = 59
integer y = 136
integer width = 1193
integer height = 164
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 32891346
string text = "Select Facility:"
end type

type p_1 from picture within w_prac_note_142
boolean visible = false
integer x = 791
integer y = 8
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "Custom035!"
boolean focusrectangle = false
end type

type st_1 from statictext within w_prac_note_142
boolean visible = false
integer x = 1006
integer width = 841
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type cb_print from commandbutton within w_prac_note_142
integer x = 2651
integer y = 16
integer width = 247
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Print"
end type

event clicked;//Start Code Change ----10.03.2011 #V12 maha - modify to show print dialog box`
boolean lb_dialog = false

if gi_print_dialog = 1 then
	lb_dialog = true
end if

cb_save.triggerevent(clicked!)

//-------Begin Added by Alfee 01.05.2012 -----------
//<$Reason>The ShowPrintDialog argument specified in the Print function is unsupported 
//<$Reason>and will cause the Print function failed in a Web application.
if appeongetclienttype() <> "PB" then	//Web version
	if lb_dialog then
		if PrintSetup () <> 1 then return
	end if
	if tab_1.selectedtab = 1 then
		dw_print.dataobject = "d_pd_notes_browse_print"
		dw_print.settransobject(sqlca)
		tab_1.tabpage_browse.dw_prac_notes.sharedata( dw_print)
		//tab_1.tabpage_browse.dw_prac_notes.print(true)
		dw_print.print(true)
	else
		dw_print.dataobject = "d_pd_notes_browse_print"
		dw_print.settransobject(sqlca)
		tab_1.tabpage_detail.dw_detail.sharedata( dw_print)
		//tab_1.tabpage_detail.dw_detail.print(true)
		dw_print.print(true)
	end if
	return 
end if
//--------End Added -------------------------------------

if tab_1.selectedtab = 1 then
	dw_print.dataobject = "d_pd_notes_browse_print"
	dw_print.settransobject(sqlca)
	tab_1.tabpage_browse.dw_prac_notes.sharedata( dw_print)
	//tab_1.tabpage_browse.dw_prac_notes.print(true,lb_dialog)
	dw_print.print(true,lb_dialog)
else
	dw_print.dataobject = "d_pd_notes_browse_print"
	dw_print.settransobject(sqlca)
	tab_1.tabpage_detail.dw_detail.sharedata( dw_print)
//	tab_1.tabpage_detail.dw_detail.print(true,lb_dialog)
	dw_print.print(true,lb_dialog)
end if

//if tab_1.selectedtab = 1 then
//	tab_1.tabpage_browse.dw_prac_notes.print()
//else
//	tab_1.tabpage_detail.dw_detail.print()
//end if

//End Code Change ----10.03.2011
end event

type cb_add from commandbutton within w_prac_note_142
integer x = 2395
integer y = 16
integer width = 247
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;

tab_1.selecttab(2)

cb_save.triggerevent(clicked!)
tab_1.tabpage_detail.dw_detail.reset()

tab_1.tabpage_detail.dw_detail.insertrow(1)
ii_facid = dw_facil.getitemnumber( 1,'facility_facility_id')	//added by long.zhang appeon 03.20.2012 Alpha Test 3448 

//tab_1.tabpage_detail.dw_detail.setitem(1,"record_id",)
tab_1.tabpage_detail.dw_detail.setitem(1,"pd_notes_prac_id",il_prac_id)
//tab_1.tabpage_detail.dw_detail.setitem(1,"pd_notes_ent_date",today())
tab_1.tabpage_detail.dw_detail.setitem(1,"pd_notes_ent_date",datetime(today(),now())) //for a web bug - alfee 05.07.2009
tab_1.tabpage_detail.dw_detail.setitem(1,"pd_notes_user_id",gs_user_id)
tab_1.tabpage_detail.dw_detail.setitem(1,"pd_notes_facility_id",ii_facid)
tab_1.tabpage_detail.dw_detail.setitem(1,"note_type", 1)  //Start Code Change ----07.28.2014 #V14.2 maha - set the type value
tab_1.tabpage_detail.dw_detail.setfocus() //Start Code Change ----10.14.2008 #V85 maha

if  w_mdi.of_security_access( 7350 ) = 0 then //add but no edit
	tab_1.tabpage_detail.dw_detail.enabled = true
end if

end event

type tab_1 from tab within w_prac_note_142
event create ( )
event destroy ( )
integer x = 37
integer y = 20
integer width = 3378
integer height = 2064
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 32891346
boolean fixedwidth = true
boolean raggedright = true
integer selectedtab = 1
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
end type

on tab_1.create
this.tabpage_browse=create tabpage_browse
this.tabpage_detail=create tabpage_detail
this.Control[]={this.tabpage_browse,&
this.tabpage_detail}
end on

on tab_1.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_detail)
end on

event selectionchanged;datawindowchild dwchild
//Start Code Change ----03.15.2010 #V10 maha - moved to constructor event of the dW
if this.selectedtab = 2 then
//	tab_1.tabpage_detail.dw_facil.settransobject(sqlca)
//	tab_1.tabpage_detail.dw_facil.insertrow(1)
//	tab_1.tabpage_detail.dw_facil.GetChild( "facility_facility_id", dwchild )
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve( gs_user_id)
//	//tab_1.tabpage_detail.dw_facil.retrieve()
//	dwchild.insertrow(1)
//	dwchild.setitem(1,"facility_facility_id",0)
//	dwchild.setitem(1,"facility_facility_name","Global")
//Start Code Change ----09.13.2012 #V12 maha - moved buttons to upper level of screen
	cb_sort.visible = false
	cb_filter.visible = false
else
	cb_sort.visible = true
	cb_filter.visible = true
//End Code Change ----09.13.2012	
end if

end event

type tabpage_browse from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3342
integer height = 1936
long backcolor = 32891346
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
string picturename = "Justify!"
long picturemaskcolor = 553648127
rb_both rb_both
rb_calls rb_calls
rb_notes rb_notes
dw_prac_notes dw_prac_notes
gb_view gb_view
end type

on tabpage_browse.create
this.rb_both=create rb_both
this.rb_calls=create rb_calls
this.rb_notes=create rb_notes
this.dw_prac_notes=create dw_prac_notes
this.gb_view=create gb_view
this.Control[]={this.rb_both,&
this.rb_calls,&
this.rb_notes,&
this.dw_prac_notes,&
this.gb_view}
end on

on tabpage_browse.destroy
destroy(this.rb_both)
destroy(this.rb_calls)
destroy(this.rb_notes)
destroy(this.dw_prac_notes)
destroy(this.gb_view)
end on

type rb_both from radiobutton within tabpage_browse
boolean visible = false
integer x = 2912
integer y = 80
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 32891346
string text = "Both"
boolean checked = true
end type

event clicked;is_type_filter = ""
of_filter()
end event

type rb_calls from radiobutton within tabpage_browse
boolean visible = false
integer x = 2478
integer y = 80
integer width = 398
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 32891346
string text = "Contact Logs"
end type

event clicked;is_type_filter = " note_type = 2 "
of_filter()
end event

type rb_notes from radiobutton within tabpage_browse
boolean visible = false
integer x = 2162
integer y = 80
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 32891346
string text = "Notes"
end type

event clicked;is_type_filter = " note_type = 1 "
of_filter()
end event

type dw_prac_notes from datawindow within tabpage_browse
integer x = 5
integer y = 196
integer width = 3323
integer height = 1720
integer taborder = 20
string dataobject = "d_pd_notes_browse"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;long ll_recid
datawindowchild dwchild

//if this.getclickedrow() < 1 then return
//
//ll_recid = this.getitemnumber(row,"pd_notes_record_id")
//ib_change = false
//tab_1.tabpage_detail.dw_detail.settransobject(sqlca)
//tab_1.tabpage_detail.dw_detail.retrieve(ll_recid)
//tab_1.tabpage_detail.dw_detail.GetChild( "pd_notes_facility_id", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve( gs_user_id)
//tab_1.tabpage_detail.dw_facil.settransobject(sqlca)
//tab_1.tabpage_detail.dw_facil.insertrow(1)
//tab_1.tabpage_detail.dw_facil.GetChild( "facility_facility_id", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve( gs_user_id)
////tab_1.tabpage_detail.dw_facil.retrieve()
//dwchild.insertrow(1)
//dwchild.setitem(1,"facility_facility_id",0)
//dwchild.setitem(1,"facility_facility_name","Global")

tab_1.selecttab(2)
end event

event constructor;this.SetRowFocusIndicator ( p_1)  //Start Code Change ----12.04.2009 #V92 maha - changed indicator
end event

event clicked;integer r
long ll_recid

r = this.setrow(this.getclickedrow())

if r < 1 then return

ll_recid = this.getitemnumber(row,"pd_notes_record_id")
ib_change = false
tab_1.tabpage_detail.dw_detail.settransobject(sqlca)
tab_1.tabpage_detail.dw_detail.retrieve(ll_recid)

//Start Code Change ----09.12.2012 #V12 maha
if  w_mdi.of_security_access( 7350 ) = 0 then //add but no edit
	tab_1.tabpage_detail.dw_detail.enabled = false
end if
end event

type gb_view from groupbox within tabpage_browse
boolean visible = false
integer x = 2103
integer y = 16
integer width = 1221
integer height = 160
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 32891346
string text = "View"
end type

type tabpage_detail from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3342
integer height = 1936
long backcolor = 32891346
string text = "Detail"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
string picturename = "DataWindow5!"
long picturemaskcolor = 553648127
dw_detail dw_detail
end type

on tabpage_detail.create
this.dw_detail=create dw_detail
this.Control[]={this.dw_detail}
end on

on tabpage_detail.destroy
destroy(this.dw_detail)
end on

type dw_detail from datawindow within tabpage_detail
integer x = 9
integer y = 196
integer width = 3301
integer height = 1636
integer taborder = 10
string dataobject = "d_pd_notes_detail"
boolean livescroll = true
end type

event buttonclicked; //Start Code Change ----07.08.2013 #V14 maha
if dwo.name = "b_log" then
	long ll_id
	w_call_log lw_log
	ll_id = this.getitemnumber(1, "pd_notes_record_id")
	openwithparm  (lw_log, ll_id)
end if
end event

type cb_close from commandbutton within w_prac_note_142
integer x = 3163
integer y = 16
integer width = 247
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close (Parent)
end event

type cb_save from commandbutton within w_prac_note_142
integer x = 2907
integer y = 16
integer width = 247
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;long recid

if tab_1.tabpage_detail.dw_detail.rowcount() < 1 then return

if isnull(tab_1.tabpage_detail.dw_detail.getitemnumber(1,"pd_notes_record_id")) then
	select max(record_id)
	into :recid
	from pd_notes;
	
	if recid < 1 or isnull(recid) then recid = 0
	//messagebox("",recid)
	recid++

	tab_1.tabpage_detail.dw_detail.setitem(1,"pd_notes_record_id",recid)
else
	recid = tab_1.tabpage_detail.dw_detail.getitemnumber(1,"pd_notes_record_id")
end if

if ib_change = true then
	tab_1.tabpage_detail.dw_detail.setitem(1,"pd_notes_facility_id",ii_facid)
end if

tab_1.tabpage_detail.dw_detail.settransobject(sqlca)


gnv_appeondb.of_autocommitrollback( )

if tab_1.tabpage_detail.dw_detail.Update() = 1 then
	commit using sqlca;
else
	Rollback;
	if sqlca.SQLCode < 0 then
		messagebox("Rollback","Unable to Rollback changes",Exclamation!)
	end if
end if

gnv_appeondb.of_startqueue( )

tab_1.tabpage_detail.dw_detail.retrieve(recid)
tab_1.tabpage_browse.dw_prac_notes.retrieve(il_prac_id,gs_user_id) 

gnv_appeondb.of_commitqueue( )

//Start Code Change ----09.12.2012 #V12 maha
if  w_mdi.of_security_access( 7350 ) = 0 then //add but no edit
	tab_1.tabpage_detail.dw_detail.enabled = false
end if

end event

type dw_facil from datawindow within w_prac_note_142
integer x = 123
integer y = 188
integer width = 1097
integer height = 76
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_facility_users_notes"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_facid = integer(data)

//Start Code Change ----09.13.2012 #V12 maha
if ii_facid > 0 then
	is_facil_filter = "pd_notes_facility_id = " + String(ii_facid)
else
	is_facil_filter = ""
end if

 //Start Code Change ----07.08.2013 #V14 maha
 of_filter()
//tab_1.tabpage_browse.dw_prac_notes.setfilter(is_facil_filter)
//tab_1.tabpage_browse.dw_prac_notes.filter()
 //End Code Change ----07.08.2013
//End Code Change ----09.13.2012

ib_change = True
end event

event constructor;datawindowchild dwchild

this.settransobject(sqlca)
this.insertrow(1)
this.GetChild( "facility_facility_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( gs_user_id)
	//tab_1.tabpage_detail.dw_facil.retrieve()
dwchild.insertrow(1)
dwchild.setitem(1,"facility_facility_id",0)
dwchild.setitem(1,"facility_facility_name","Global")
this.setitem(1,"facility_facility_id", 0)
end event

