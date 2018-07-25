$PBExportHeader$w_get_additional_info_pages.srw
forward
global type w_get_additional_info_pages from w_response
end type
type dw_1 from datawindow within w_get_additional_info_pages
end type
type st_label from statictext within w_get_additional_info_pages
end type
type cb_ok from commandbutton within w_get_additional_info_pages
end type
end forward

global type w_get_additional_info_pages from w_response
integer x = 1024
integer y = 804
integer width = 1897
integer height = 780
string title = "Additional Information Pages"
long backcolor = 33551856
dw_1 dw_1
st_label st_label
cb_ok cb_ok
end type
global w_get_additional_info_pages w_get_additional_info_pages

on w_get_additional_info_pages.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_label=create st_label
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_label
this.Control[iCurrent+3]=this.cb_ok
end on

on w_get_additional_info_pages.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_label)
destroy(this.cb_ok)
end on

event open;call super::open;String ls_pages
Integer li_app_id

li_app_id = w_train_app.ii_app_id	

//Start Code Change ----05.07.2013 #V12 maha - change to DW
dw_1.settransobject(sqlca)
dw_1.retrieve(li_app_id)

//SELECT additional_info_pages
//INTO :ls_pages
//FROM app_hdr  
//WHERE app_hdr.app_id = :li_app_id 
//USING w_train_app.tr_training_data;
//IF w_train_app.tr_training_data.SQLCODE = -1 THEN
//	MessageBox("Database Error", SQLCA.SQLERRTEXT )
//	Return 0
//END IF
//sle_pages.Text = ls_pages

//End Code Change ----05.07.2013
end event

type dw_1 from datawindow within w_get_additional_info_pages
integer x = 41
integer y = 496
integer width = 1509
integer height = 84
integer taborder = 20
string title = "none"
string dataobject = "d_addtl_page_info"
boolean border = false
boolean livescroll = true
end type

type st_label from statictext within w_get_additional_info_pages
integer x = 41
integer y = 52
integer width = 1769
integer height = 360
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
string text = "Additional pages are pages of the app that are used when there are more data records than will fit on standard pages.  Additional pages will only print if there is data populated on them.  Type in the page numbers that are used for additional information.  Example  12,13,14"
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_get_additional_info_pages
integer x = 1550
integer y = 492
integer width = 297
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;String ls_pages
Integer li_app_id

//Start Code Change ----05.07.2013 #V12 maha - change to DW
//ls_pages = Trim( sle_pages.Text )
//li_app_id = w_train_app.ii_app_id
//UPDATE app_hdr  
//SET additional_info_pages = :ls_pages  
//WHERE app_hdr.app_id = :li_app_id
//USING w_train_app.tr_training_data;
//IF w_train_app.tr_training_data.SQLCODE = -1 THEN
//	MessageBox("Database Error", SQLCA.SQLERRTEXT )
//	Return 0
//END IF

dw_1.update()
//End Code Change ----05.07.2013

Close( Parent )
end event

