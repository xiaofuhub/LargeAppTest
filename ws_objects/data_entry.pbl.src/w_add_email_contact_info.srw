$PBExportHeader$w_add_email_contact_info.srw
forward
global type w_add_email_contact_info from w_response
end type
type cb_new from commandbutton within w_add_email_contact_info
end type
type cb_save from commandbutton within w_add_email_contact_info
end type
type cb_sall from commandbutton within w_add_email_contact_info
end type
type cb_delete from commandbutton within w_add_email_contact_info
end type
type tab_1 from tab within w_add_email_contact_info
end type
type tabpage_browse from userobject within tab_1
end type
type dw_browse from datawindow within tabpage_browse
end type
type tabpage_browse from userobject within tab_1
dw_browse dw_browse
end type
type tabpage_detail from userobject within tab_1
end type
type dw_detail from datawindow within tabpage_detail
end type
type tabpage_detail from userobject within tab_1
dw_detail dw_detail
end type
type tab_1 from tab within w_add_email_contact_info
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
end type
type cb_1 from commandbutton within w_add_email_contact_info
end type
type cb_2 from commandbutton within w_add_email_contact_info
end type
end forward

global type w_add_email_contact_info from w_response
integer x = 645
integer y = 352
integer width = 2651
integer height = 2452
string title = "Email Contacts"
long backcolor = 33551856
event type integer ue_changetab ( )
cb_new cb_new
cb_save cb_save
cb_sall cb_sall
cb_delete cb_delete
tab_1 tab_1
cb_1 cb_1
cb_2 cb_2
end type
global w_add_email_contact_info w_add_email_contact_info

type variables
datawindow idw_detail
datawindow idw_browse
long il_record
end variables

event type integer ue_changetab();tab_1.selecttab(2)

return 1
end event

on w_add_email_contact_info.create
int iCurrent
call super::create
this.cb_new=create cb_new
this.cb_save=create cb_save
this.cb_sall=create cb_sall
this.cb_delete=create cb_delete
this.tab_1=create tab_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_new
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_sall
this.Control[iCurrent+4]=this.cb_delete
this.Control[iCurrent+5]=this.tab_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_2
end on

on w_add_email_contact_info.destroy
call super::destroy
destroy(this.cb_new)
destroy(this.cb_save)
destroy(this.cb_sall)
destroy(this.cb_delete)
destroy(this.tab_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;//Start Code Change ----02.10.2009 #V92 maha
//added browse window and delete functionality as well as save button.
idw_detail = tab_1.tabpage_detail.dw_detail
idw_browse = tab_1.tabpage_browse.dw_browse
idw_browse.SetTransObject( SQLCA )
idw_browse.retrieve()
idw_detail.SetTransObject( SQLCA )
idw_detail.InsertRow( 1 )
//tab_1.selecttab( 2)

this.postevent( "ue_changetab")


end event

event pfc_preclose;call super::pfc_preclose;//alfee 05.19.2010

Long i, ll_cnt

ll_cnt = idw_browse.RowCount()
FOR i = 1 to ll_cnt
	idw_browse.SetItemStatus(i, 0, Primary!, NotModified!)	
NEXT

RETURN 1
end event

type cb_new from commandbutton within w_add_email_contact_info
integer x = 1198
integer y = 2204
integer width = 393
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "New"
end type

event clicked;
event ue_changetab( )  //changes to tab 2

if isnull(idw_detail.getItemnumber( 1, "lookup_code")) then //if not already a new record
	idw_detail.insertrow(1)
end if
end event

type cb_save from commandbutton within w_add_email_contact_info
integer x = 1824
integer y = 2204
integer width = 393
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;//-----Begin Modified by alfee 05.19.2010 ---------------
//<$Reason>for selecting more than one email address
Long i, ll_cnt
String ls_email_addresses, ls_temp

//Save it first
if cb_1.event Clicked() = -1 then return -1

//Return the selected email addresses
ll_cnt = idw_browse.RowCount()
FOR i = 1 to ll_cnt
	IF idw_browse.GetItemNumber(i,"selected") = 1 THEN
		ls_temp = Trim(idw_browse.GetItemString(i, "email_address"))
		IF LenA(ls_temp) > 0 THEN		
			IF LenA(ls_email_addresses) > 0 THEN ls_email_addresses += "; "
			ls_email_addresses += ls_temp
		END IF
	END IF
NEXT

CloseWithReturn( Parent, ls_email_addresses )

//Long ll_lookup_code
//
//idw_detail.AcceptText()
//
//IF IsNull( idw_detail.GetItemString( 1, "entity_name" ) ) THEN
//	MessageBox("Required Field", "Organization name must be filled in." )
//	idw_detail.SetColumn( "entity_name" )
//	idw_detail.SetFocus( )
//	Return -1
//END IF
//
//IF IsNull( idw_detail.GetItemString( 1, "contact_name" ) ) THEN
//	MessageBox("Required Field", "Contact name must be filled in." )
//	idw_detail.SetColumn( "email_address" )
//	idw_detail.SetFocus( )
//	Return -1
//END IF
//
//IF IsNull( idw_detail.GetItemString( 1, "email_address" ) ) THEN
//	MessageBox("Required Field", "Email Address must be filled in." )
//	idw_detail.SetColumn( "email_address" )
//	idw_detail.SetFocus( )
//	Return -1
//END IF
//
//ll_lookup_code = gnv_app.of_get_id("LOOKUP")
//idw_detail.SetItem( 1, "lookup_code", ll_lookup_code)
//idw_detail.SetItem( 1, "code", Mid( idw_detail.GetItemString( 1, "email_address" ) , 1, 15))
//idw_detail.Update( )
//CloseWithReturn( Parent, idw_detail.GetItemString( 1, "email_address" ) )
//--------End Modified ------------------------------------

end event

type cb_sall from commandbutton within w_add_email_contact_info
integer y = 2204
integer width = 393
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;long i
integer v


if this.text = 'Select All' then
	v = 1
	this.text = 'Deselect All'
else
	v = 0
	this.text = 'Select All'
end if

for i = 1 to idw_browse.rowcount()
	idw_browse.setitem(i,"selected",v)
next
end event

type cb_delete from commandbutton within w_add_email_contact_info
integer x = 398
integer y = 2204
integer width = 393
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Selected"
end type

event clicked;integer i

i = messagebox("Delete","Are you sure you wish to delete the selected Records?",question!,Yesno!,2)

if i = 2 then return

for i =  idw_browse.rowcount() to 1 step -1
	if idw_browse.getitemnumber(i,"selected") = 1 then idw_browse.deleterow(i)
next

idw_detail.reset()
end event

type tab_1 from tab within w_add_email_contact_info
integer x = 18
integer y = 12
integer width = 2597
integer height = 2180
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
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

event selectionchanged;choose case newindex
	case 1
		cb_sall.visible = true
		cb_delete.visible = true
	case 2
		cb_sall.visible = False
		cb_delete.visible = False
end choose
end event

type tabpage_browse from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2560
integer height = 2064
long backcolor = 80269524
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_browse dw_browse
end type

on tabpage_browse.create
this.dw_browse=create dw_browse
this.Control[]={this.dw_browse}
end on

on tabpage_browse.destroy
destroy(this.dw_browse)
end on

type dw_browse from datawindow within tabpage_browse
integer x = 9
integer y = 12
integer width = 2542
integer height = 2040
integer taborder = 20
string title = "none"
string dataobject = "d_email_contacts_browse"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;long i

i = this.getclickedrow()
this.setrow(i)
this.scrolltorow(i)
this.selectrow(0,false)
this.selectrow(i,true)
end event

event doubleclicked;il_record = this.getitemnumber(this .getrow(), "lookup_code")
idw_detail.retrieve(il_record)
tab_1.selecttab(2)

end event

type tabpage_detail from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2560
integer height = 2064
long backcolor = 16777215
string text = "Detail"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
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
integer width = 2565
integer height = 2068
integer taborder = 20
string title = "none"
string dataobject = "d_add_email_contact_info"
boolean border = false
boolean livescroll = true
end type

type cb_1 from commandbutton within w_add_email_contact_info
integer x = 800
integer y = 2204
integer width = 393
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;Long ll_lookup_code

idw_detail.AcceptText()

//if idw_detail.rowcount() > 0 then
if idw_detail.rowcount() > 0 and idw_detail.modifiedcount() > 0 then	//alfee 05.19.2010
	IF IsNull( idw_detail.GetItemString( 1, "entity_name" ) ) THEN
		MessageBox("Required Field", "Organization name must be filled in." )
		idw_detail.SetColumn( "entity_name" )
		idw_detail.SetFocus( )
		Return -1
	END IF
	
	IF IsNull( idw_detail.GetItemString( 1, "contact_name" ) ) THEN
		MessageBox("Required Field", "Contact name must be filled in." )
		idw_detail.SetColumn( "email_address" )
		idw_detail.SetFocus( )
		Return -1
	END IF
	
	IF IsNull( idw_detail.GetItemString( 1, "email_address" ) ) THEN
		MessageBox("Required Field", "Email Address must be filled in." )
		idw_detail.SetColumn( "email_address" )
		idw_detail.SetFocus( )
		Return -1
	END IF
	
	if isnull(idw_detail.getItemnumber( 1, "lookup_code")) then
		ll_lookup_code = gnv_app.of_get_id("LOOKUP")
		idw_detail.SetItem( 1, "lookup_code", ll_lookup_code)
		idw_detail.SetItem( 1, "code", MidA( idw_detail.GetItemString( 1, "email_address" ) , 1, 15))
	end if
	
	idw_detail.Update( )
end if

idw_browse.update()



end event

type cb_2 from commandbutton within w_add_email_contact_info
integer x = 2222
integer y = 2204
integer width = 393
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

