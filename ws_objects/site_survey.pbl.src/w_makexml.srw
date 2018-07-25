$PBExportHeader$w_makexml.srw
forward
global type w_makexml from w_response
end type
type cb_7 from commandbutton within w_makexml
end type
type cb_6 from commandbutton within w_makexml
end type
type cb_5 from commandbutton within w_makexml
end type
type cb_4 from commandbutton within w_makexml
end type
type cb_3 from commandbutton within w_makexml
end type
type cb_2 from commandbutton within w_makexml
end type
type cb_1 from commandbutton within w_makexml
end type
type cb_import from commandbutton within w_makexml
end type
type dw_1 from u_dw within w_makexml
end type
end forward

global type w_makexml from w_response
integer height = 1668
long backcolor = 33551856
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
cb_import cb_import
dw_1 dw_1
end type
global w_makexml w_makexml

on w_makexml.create
int iCurrent
call super::create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_import=create cb_import
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_7
this.Control[iCurrent+2]=this.cb_6
this.Control[iCurrent+3]=this.cb_5
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_import
this.Control[iCurrent+9]=this.dw_1
end on

on w_makexml.destroy
call super::destroy
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_import)
destroy(this.dw_1)
end on

type cb_7 from commandbutton within w_makexml
integer x = 1486
integer y = 1392
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked;ShowHelp("Intellihelp.chm", Keyword!, "OCX Issue")
end event

type cb_6 from commandbutton within w_makexml
integer x = 9
integer y = 1244
integer width = 197
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked;//change n_cst_message to n_cst_xml_message - alfee 02.25.2010

n_cst_xml_message lnvo_message

lnvo_message = Create n_cst_xml_message

//get message file
lnvo_message.of_get_messagexml()
//get message 
lnvo_message.of_get_error_message("OCX Issue",'%1S%','test.txt','test.txt','test.txt')
//Destroy lds_xmlmessage
Destroy lnvo_message
end event

type cb_5 from commandbutton within w_makexml
integer x = 1243
integer y = 1244
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;//change n_cst_message to n_cst_xml_message - alfee 02.25.2010

n_cst_xml_message lnvo_message

lnvo_message = Create n_cst_xml_message
//get message file
lnvo_message.of_get_messagexml()
//get message 

lnvo_message.of_get_error_message("Email Send",'','test.txt','test.txt','test.txt')
//Destroy lds_xmlmessage
Destroy lnvo_message
end event

type cb_4 from commandbutton within w_makexml
integer x = 901
integer y = 1244
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;
dw_1.DeleteRow(0)
end event

type cb_3 from commandbutton within w_makexml
integer x = 558
integer y = 1244
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

event clicked;long ll_newrow

ll_newrow = dw_1.InsertRow(0)
dw_1.ScrollToRow(ll_newrow)
end event

type cb_2 from commandbutton within w_makexml
integer x = 1929
integer y = 1244
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

type cb_1 from commandbutton within w_makexml
integer x = 1586
integer y = 1244
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Exportxml"
end type

event clicked;long ll_ret

string ls_err


dw_1.saveas(Gs_Current_Directory + "\messages.txt",Text!,false)

end event

type cb_import from commandbutton within w_makexml
integer x = 215
integer y = 1244
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Importxml"
end type

event clicked;String xml_path
Long ll_ret
n_appeon_download lnv_download



IF appeongetclienttype() = 'WEB' THEN
	xml_path = gs_temp_path + "messages.txt"
	IF lnv_download.of_downloadfile("", xml_path) <> 0 THEN
		MessageBox("error","downloda failed!")
	END IF
ELSE
	xml_path = Gs_Current_Directory + "\messages.txt"
END IF


IF FileExists(xml_path) = True THEN
	
	dw_1.ImportFile(xml_path)
	
ELSE
	MessageBox("error","import error")
END IF

end event

type dw_1 from u_dw within w_makexml
integer width = 2478
integer height = 1216
integer taborder = 10
string dataobject = "d_cst_messages"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event dberror;call super::dberror;messagebox(sqlerrtext,sqlsyntax)
end event

