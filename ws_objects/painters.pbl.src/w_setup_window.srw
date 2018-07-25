$PBExportHeader$w_setup_window.srw
forward
global type w_setup_window from window
end type
type cb_close from commandbutton within w_setup_window
end type
type cb_1 from commandbutton within w_setup_window
end type
type cb_profile_screen_design from commandbutton within w_setup_window
end type
type cb_fax_templates from commandbutton within w_setup_window
end type
type cb_dtl_setup from commandbutton within w_setup_window
end type
type cb_questions from commandbutton within w_setup_window
end type
type cb_profile_design from commandbutton within w_setup_window
end type
type cb_expiring_data_settings from commandbutton within w_setup_window
end type
type cb_lookup from commandbutton within w_setup_window
end type
type cb_letter_storage from commandbutton within w_setup_window
end type
type cb_letter_setup from commandbutton within w_setup_window
end type
type cb_document_type_setup from commandbutton within w_setup_window
end type
type cb_screen_design from commandbutton within w_setup_window
end type
type cb_checklist_setup from commandbutton within w_setup_window
end type
type cb_email_templates from commandbutton within w_setup_window
end type
type cb_group_practice from commandbutton within w_setup_window
end type
type cb_user_setup from commandbutton within w_setup_window
end type
type cb_role_setup from commandbutton within w_setup_window
end type
type cb_facility_setup from commandbutton within w_setup_window
end type
type cb_view_setup from commandbutton within w_setup_window
end type
type gb_1 from groupbox within w_setup_window
end type
type gb_2 from groupbox within w_setup_window
end type
type gb_3 from groupbox within w_setup_window
end type
type gb_4 from groupbox within w_setup_window
end type
type gb_5 from groupbox within w_setup_window
end type
type gb_6 from groupbox within w_setup_window
end type
type gb_7 from groupbox within w_setup_window
end type
type gb_8 from groupbox within w_setup_window
end type
type gb_9 from groupbox within w_setup_window
end type
end forward

global type w_setup_window from window
integer width = 2089
integer height = 1680
boolean titlebar = true
string title = "Setup"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_1 cb_1
cb_profile_screen_design cb_profile_screen_design
cb_fax_templates cb_fax_templates
cb_dtl_setup cb_dtl_setup
cb_questions cb_questions
cb_profile_design cb_profile_design
cb_expiring_data_settings cb_expiring_data_settings
cb_lookup cb_lookup
cb_letter_storage cb_letter_storage
cb_letter_setup cb_letter_setup
cb_document_type_setup cb_document_type_setup
cb_screen_design cb_screen_design
cb_checklist_setup cb_checklist_setup
cb_email_templates cb_email_templates
cb_group_practice cb_group_practice
cb_user_setup cb_user_setup
cb_role_setup cb_role_setup
cb_facility_setup cb_facility_setup
cb_view_setup cb_view_setup
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_5 gb_5
gb_6 gb_6
gb_7 gb_7
gb_8 gb_8
gb_9 gb_9
end type
global w_setup_window w_setup_window

on w_setup_window.create
this.cb_close=create cb_close
this.cb_1=create cb_1
this.cb_profile_screen_design=create cb_profile_screen_design
this.cb_fax_templates=create cb_fax_templates
this.cb_dtl_setup=create cb_dtl_setup
this.cb_questions=create cb_questions
this.cb_profile_design=create cb_profile_design
this.cb_expiring_data_settings=create cb_expiring_data_settings
this.cb_lookup=create cb_lookup
this.cb_letter_storage=create cb_letter_storage
this.cb_letter_setup=create cb_letter_setup
this.cb_document_type_setup=create cb_document_type_setup
this.cb_screen_design=create cb_screen_design
this.cb_checklist_setup=create cb_checklist_setup
this.cb_email_templates=create cb_email_templates
this.cb_group_practice=create cb_group_practice
this.cb_user_setup=create cb_user_setup
this.cb_role_setup=create cb_role_setup
this.cb_facility_setup=create cb_facility_setup
this.cb_view_setup=create cb_view_setup
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_6=create gb_6
this.gb_7=create gb_7
this.gb_8=create gb_8
this.gb_9=create gb_9
this.Control[]={this.cb_close,&
this.cb_1,&
this.cb_profile_screen_design,&
this.cb_fax_templates,&
this.cb_dtl_setup,&
this.cb_questions,&
this.cb_profile_design,&
this.cb_expiring_data_settings,&
this.cb_lookup,&
this.cb_letter_storage,&
this.cb_letter_setup,&
this.cb_document_type_setup,&
this.cb_screen_design,&
this.cb_checklist_setup,&
this.cb_email_templates,&
this.cb_group_practice,&
this.cb_user_setup,&
this.cb_role_setup,&
this.cb_facility_setup,&
this.cb_view_setup,&
this.gb_1,&
this.gb_2,&
this.gb_3,&
this.gb_4,&
this.gb_5,&
this.gb_6,&
this.gb_7,&
this.gb_8,&
this.gb_9}
end on

on w_setup_window.destroy
destroy(this.cb_close)
destroy(this.cb_1)
destroy(this.cb_profile_screen_design)
destroy(this.cb_fax_templates)
destroy(this.cb_dtl_setup)
destroy(this.cb_questions)
destroy(this.cb_profile_design)
destroy(this.cb_expiring_data_settings)
destroy(this.cb_lookup)
destroy(this.cb_letter_storage)
destroy(this.cb_letter_setup)
destroy(this.cb_document_type_setup)
destroy(this.cb_screen_design)
destroy(this.cb_checklist_setup)
destroy(this.cb_email_templates)
destroy(this.cb_group_practice)
destroy(this.cb_user_setup)
destroy(this.cb_role_setup)
destroy(this.cb_facility_setup)
destroy(this.cb_view_setup)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_6)
destroy(this.gb_7)
destroy(this.gb_8)
destroy(this.gb_9)
end on

type cb_close from commandbutton within w_setup_window
integer x = 878
integer y = 1392
integer width = 379
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

type cb_1 from commandbutton within w_setup_window
integer x = 1161
integer y = 1196
integer width = 800
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reference Lookup"
end type

type cb_profile_screen_design from commandbutton within w_setup_window
integer x = 1161
integer y = 772
integer width = 800
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Profile Screen Design"
end type

event clicked;OpenSheet(w_prac_report_design, w_mdi, 4, original!)	
end event

type cb_fax_templates from commandbutton within w_setup_window
integer x = 1161
integer y = 424
integer width = 800
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Fax Templates"
end type

event clicked;open(w_fax_template_painter)
end event

type cb_dtl_setup from commandbutton within w_setup_window
integer x = 123
integer y = 96
integer width = 800
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "To-Do-List Setup"
end type

event clicked;OpenSheet(w_todolist_painter, w_mdi, 6, Original!)
end event

type cb_questions from commandbutton within w_setup_window
integer x = 1161
integer y = 1088
integer width = 800
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Question Setup"
end type

event clicked;open(w_question_painter)
end event

type cb_profile_design from commandbutton within w_setup_window
integer x = 1166
integer y = 660
integer width = 800
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Provider Profile Design"
end type

event clicked;Open( w_profile_view_manager )
end event

type cb_expiring_data_settings from commandbutton within w_setup_window
integer x = 123
integer y = 528
integer width = 800
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Expiring Data Settings"
end type

event clicked;Open( w_exp_letter_painter )
end event

type cb_lookup from commandbutton within w_setup_window
integer x = 1161
integer y = 980
integer width = 800
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Lookup Setup"
end type

event clicked;Open( w_lookup_maint )
end event

type cb_letter_storage from commandbutton within w_setup_window
integer x = 1161
integer y = 96
integer width = 800
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Letter Storage Area "
end type

event clicked;open(w_area_painter)
end event

type cb_letter_setup from commandbutton within w_setup_window
integer x = 1161
integer y = 208
integer width = 800
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Letter Setup"
end type

event clicked;open(w_letter_painter)
end event

type cb_document_type_setup from commandbutton within w_setup_window
integer x = 123
integer y = 420
integer width = 800
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Document (Image) Type Setup"
end type

event clicked;open(w_image_type_painter)
end event

type cb_screen_design from commandbutton within w_setup_window
integer x = 114
integer y = 1176
integer width = 800
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Screen Design"
end type

event clicked;OpenSheet(w_prac_data_design, w_mdi, 6, Original!)
end event

type cb_checklist_setup from commandbutton within w_setup_window
integer x = 123
integer y = 312
integer width = 800
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Checklist Setup"
end type

event clicked;open(w_app_audit_setup)
end event

type cb_email_templates from commandbutton within w_setup_window
integer x = 1161
integer y = 316
integer width = 800
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Email Templates"
end type

event clicked;open(w_email_painter)
end event

type cb_group_practice from commandbutton within w_setup_window
integer x = 123
integer y = 204
integer width = 800
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Group Practice"
end type

event clicked;open(w_group_practice)
end event

type cb_user_setup from commandbutton within w_setup_window
integer x = 114
integer y = 852
integer width = 800
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "User Setup"
end type

event clicked;//---------Begin Modified by (Appeon)Eugene 06.20.2013 for V141 ISG-CLX--------
//open(w_security_user_painter)
If gb_contract_version Then
	Open(w_security_user_painter_ctx)
Else
	Open(w_security_user_painter)
End If
//---------End Modfiied ------------------------------------------------------


end event

type cb_role_setup from commandbutton within w_setup_window
integer x = 114
integer y = 744
integer width = 800
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Role Setup"
end type

event clicked;open(w_security_roles_painter)
end event

type cb_facility_setup from commandbutton within w_setup_window
integer x = 293
integer y = 1656
integer width = 800
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Facility Setup"
end type

event clicked;open(w_facility_setup_intelliapp)
//open(w_facility_setup)
end event

type cb_view_setup from commandbutton within w_setup_window
integer x = 114
integer y = 1068
integer width = 800
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Setup"
end type

event clicked;open(w_data_views_manager)
end event

type gb_1 from groupbox within w_setup_window
integer x = 3214
integer y = 964
integer width = 882
integer height = 784
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 32891346
string text = "Automation"
end type

type gb_2 from groupbox within w_setup_window
integer x = 1120
integer y = 40
integer width = 882
integer height = 500
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Communication"
end type

type gb_3 from groupbox within w_setup_window
integer x = 3227
integer y = 108
integer width = 882
integer height = 324
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 32891346
string text = "Data Transfer"
end type

type gb_4 from groupbox within w_setup_window
integer x = 1129
integer y = 912
integer width = 882
integer height = 400
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Lookups"
end type

type gb_5 from groupbox within w_setup_window
integer x = 3173
integer y = 456
integer width = 882
integer height = 504
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 32891346
string text = "PRIV/QA/OFE"
end type

type gb_6 from groupbox within w_setup_window
integer x = 1129
integer y = 596
integer width = 882
integer height = 312
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Profiles"
end type

type gb_7 from groupbox within w_setup_window
integer x = 82
integer y = 1000
integer width = 882
integer height = 308
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Screen Setup"
end type

type gb_8 from groupbox within w_setup_window
integer x = 82
integer y = 24
integer width = 882
integer height = 628
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "System Configuration"
end type

type gb_9 from groupbox within w_setup_window
integer x = 82
integer y = 680
integer width = 882
integer height = 300
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Security"
end type

