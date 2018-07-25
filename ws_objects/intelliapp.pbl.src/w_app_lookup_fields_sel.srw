$PBExportHeader$w_app_lookup_fields_sel.srw
forward
global type w_app_lookup_fields_sel from window
end type
type cbx_description from checkbox within w_app_lookup_fields_sel
end type
type cbx_code from checkbox within w_app_lookup_fields_sel
end type
type cbx_email_address from checkbox within w_app_lookup_fields_sel
end type
type cbx_contact_name from checkbox within w_app_lookup_fields_sel
end type
type cbx_fax from checkbox within w_app_lookup_fields_sel
end type
type cbx_phone from checkbox within w_app_lookup_fields_sel
end type
type cbx_country from checkbox within w_app_lookup_fields_sel
end type
type cbx_zip from checkbox within w_app_lookup_fields_sel
end type
type cbx_state from checkbox within w_app_lookup_fields_sel
end type
type cbx_city from checkbox within w_app_lookup_fields_sel
end type
type cbx_street2 from checkbox within w_app_lookup_fields_sel
end type
type cbx_street1 from checkbox within w_app_lookup_fields_sel
end type
type cbx_entity_name from checkbox within w_app_lookup_fields_sel
end type
type st_1 from statictext within w_app_lookup_fields_sel
end type
type cb_cancel from commandbutton within w_app_lookup_fields_sel
end type
type cb_ok from commandbutton within w_app_lookup_fields_sel
end type
end forward

global type w_app_lookup_fields_sel from window
integer width = 901
integer height = 1164
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cbx_description cbx_description
cbx_code cbx_code
cbx_email_address cbx_email_address
cbx_contact_name cbx_contact_name
cbx_fax cbx_fax
cbx_phone cbx_phone
cbx_country cbx_country
cbx_zip cbx_zip
cbx_state cbx_state
cbx_city cbx_city
cbx_street2 cbx_street2
cbx_street1 cbx_street1
cbx_entity_name cbx_entity_name
st_1 st_1
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_app_lookup_fields_sel w_app_lookup_fields_sel

type variables
string is_Return = "Cancel!"
end variables

on w_app_lookup_fields_sel.create
this.cbx_description=create cbx_description
this.cbx_code=create cbx_code
this.cbx_email_address=create cbx_email_address
this.cbx_contact_name=create cbx_contact_name
this.cbx_fax=create cbx_fax
this.cbx_phone=create cbx_phone
this.cbx_country=create cbx_country
this.cbx_zip=create cbx_zip
this.cbx_state=create cbx_state
this.cbx_city=create cbx_city
this.cbx_street2=create cbx_street2
this.cbx_street1=create cbx_street1
this.cbx_entity_name=create cbx_entity_name
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={this.cbx_description,&
this.cbx_code,&
this.cbx_email_address,&
this.cbx_contact_name,&
this.cbx_fax,&
this.cbx_phone,&
this.cbx_country,&
this.cbx_zip,&
this.cbx_state,&
this.cbx_city,&
this.cbx_street2,&
this.cbx_street1,&
this.cbx_entity_name,&
this.st_1,&
this.cb_cancel,&
this.cb_ok}
end on

on w_app_lookup_fields_sel.destroy
destroy(this.cbx_description)
destroy(this.cbx_code)
destroy(this.cbx_email_address)
destroy(this.cbx_contact_name)
destroy(this.cbx_fax)
destroy(this.cbx_phone)
destroy(this.cbx_country)
destroy(this.cbx_zip)
destroy(this.cbx_state)
destroy(this.cbx_city)
destroy(this.cbx_street2)
destroy(this.cbx_street1)
destroy(this.cbx_entity_name)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.03.2010
//////////////////////////////////////////////////////////////////////

if Message.StringParm = "C" then
	cbx_description.Show()
	cbx_code.Show()
	cbx_entity_name.Hide()
	cbx_street1.Hide()
	cbx_street2.Hide()
	cbx_city.Hide()
	cbx_state.Hide()
	cbx_zip.Hide()
	cbx_country.Hide()
	cbx_phone.Hide()
	cbx_fax.Hide()
	cbx_contact_name.Hide()
	cbx_email_address.Hide()
end if
end event

event close;//////////////////////////////////////////////////////////////////////
// $<event> close
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.03.2010
//////////////////////////////////////////////////////////////////////

CloseWithReturn(this, is_Return)
end event

type cbx_description from checkbox within w_app_lookup_fields_sel
boolean visible = false
integer x = 270
integer y = 284
integer width = 361
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Description"
end type

type cbx_code from checkbox within w_app_lookup_fields_sel
boolean visible = false
integer x = 270
integer y = 188
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Code"
end type

type cbx_email_address from checkbox within w_app_lookup_fields_sel
integer x = 270
integer y = 908
integer width = 411
integer height = 64
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Email Address"
end type

type cbx_contact_name from checkbox within w_app_lookup_fields_sel
integer x = 270
integer y = 836
integer width = 421
integer height = 64
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Contact Name"
end type

type cbx_fax from checkbox within w_app_lookup_fields_sel
integer x = 270
integer y = 764
integer width = 343
integer height = 64
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Fax"
end type

type cbx_phone from checkbox within w_app_lookup_fields_sel
integer x = 270
integer y = 692
integer width = 343
integer height = 64
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Phone"
end type

type cbx_country from checkbox within w_app_lookup_fields_sel
integer x = 270
integer y = 620
integer width = 343
integer height = 64
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Country"
end type

type cbx_zip from checkbox within w_app_lookup_fields_sel
integer x = 270
integer y = 548
integer width = 343
integer height = 64
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Zip"
end type

type cbx_state from checkbox within w_app_lookup_fields_sel
integer x = 270
integer y = 476
integer width = 343
integer height = 64
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "State"
end type

type cbx_city from checkbox within w_app_lookup_fields_sel
integer x = 270
integer y = 404
integer width = 343
integer height = 64
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "City"
end type

type cbx_street2 from checkbox within w_app_lookup_fields_sel
integer x = 270
integer y = 332
integer width = 343
integer height = 64
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Street 2"
end type

type cbx_street1 from checkbox within w_app_lookup_fields_sel
integer x = 270
integer y = 260
integer width = 343
integer height = 64
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Street 1"
end type

type cbx_entity_name from checkbox within w_app_lookup_fields_sel
integer x = 270
integer y = 188
integer width = 407
integer height = 64
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Entity Name"
end type

type st_1 from statictext within w_app_lookup_fields_sel
integer x = 18
integer y = 16
integer width = 873
integer height = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Select Each Field that you wish to map and Click OK"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_app_lookup_fields_sel
integer x = 453
integer y = 1032
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.03.2010
//////////////////////////////////////////////////////////////////////

Close(Parent)
end event

type cb_ok from commandbutton within w_app_lookup_fields_sel
integer x = 101
integer y = 1032
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.03.2010
//////////////////////////////////////////////////////////////////////

string ls_Fields

if cbx_description.Checked then ls_Fields += "description,"
if cbx_code.Checked then ls_Fields += "code,"
//
if cbx_entity_name.Checked then ls_Fields += "entity_name,"
if cbx_street1.Checked then ls_Fields += "street1,"
if cbx_street2.Checked then ls_Fields += "street2,"
if cbx_city.Checked then ls_Fields += "city,"
if cbx_state.Checked then ls_Fields += "state,"
if cbx_zip.Checked then ls_Fields += "zip,"
if cbx_country.Checked then ls_Fields += "country,"
if cbx_phone.Checked then ls_Fields += "phone,"
if cbx_fax.Checked then ls_Fields += "fax,"
if cbx_contact_name.Checked then ls_Fields += "contact_name,"
if cbx_email_address.Checked then ls_Fields += "email_address,"

if ls_Fields = "" then
	MessageBox("Prompt", "Please select each field that you wish to map.")
	Return -1
end if

is_Return = Left(ls_Fields, Len(ls_Fields) - 1)
Close(Parent)
end event

