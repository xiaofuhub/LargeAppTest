$PBExportHeader$w_custom_report_manage.srw
forward
global type w_custom_report_manage from w_popup
end type
type cb_save from commandbutton within w_custom_report_manage
end type
type cb_sort from commandbutton within w_custom_report_manage
end type
type cb_export from commandbutton within w_custom_report_manage
end type
type cb_close from commandbutton within w_custom_report_manage
end type
type dw_1 from datawindow within w_custom_report_manage
end type
end forward

global type w_custom_report_manage from w_popup
integer width = 3502
integer height = 2248
long backcolor = 33551856
cb_save cb_save
cb_sort cb_sort
cb_export cb_export
cb_close cb_close
dw_1 dw_1
end type
global w_custom_report_manage w_custom_report_manage

on w_custom_report_manage.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.cb_sort=create cb_sort
this.cb_export=create cb_export
this.cb_close=create cb_close
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.cb_sort
this.Control[iCurrent+3]=this.cb_export
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.dw_1
end on

on w_custom_report_manage.destroy
call super::destroy
destroy(this.cb_save)
destroy(this.cb_sort)
destroy(this.cb_export)
destroy(this.cb_close)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.settransobject(sqlca)
//dw_1.retrieve()
dw_1.retrieve(gs_user_id)  //Modified by (Appeon)Harry 08.03.2016 for BugH072803--------
end event

type cb_save from commandbutton within w_custom_report_manage
integer x = 2021
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Save"
end type

event clicked;dw_1.update()
end event

type cb_sort from commandbutton within w_custom_report_manage
integer x = 2373
integer y = 36
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_1.SetSort(null_str)

dw_1.Sort( )
end event

type cb_export from commandbutton within w_custom_report_manage
integer x = 2729
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Export"
end type

event clicked;//dw_1.saveas() //Commented by (Appeon)Gavin 12.07.2017 for V16.1  Export and excel


//Added by (Appeon)Gavin 12.07.2017 for V16.1  Export and excel
Integer li_Rc
String   ls_Path, ls_File, ls_FType

If appeongetclienttype() = 'WEB' Then  //Text (*.txt),*.txt,  Excel (*.xlsx),*.xlsx,  Excel 97-2003 (*.xls),*.xls, CSV (*.csv),*.csv,
	ls_FType = "Text with headers (*.txt),*.txt,Excel with headers (*.xlsx),*.xlsx,Excel with headers 97-2003 (*.xls),*.xls,HTML Table (*.html),*.html,XML (*.xml),*.xml,PDF (*.pdf),*.pdf,CSV with headers (*.csv),*.csv"
	li_rc = GetFileSaveName ( "SaveAs ", ls_path, ls_file, "txt",ls_FType ,gs_dir_path+"intellicred\",  32770)
	
	If li_Rc = 1 Then
		Choose Case right( ls_file,4 )
			case '.xls'
				dw_1.SaveAs( ls_path, EXcel!, true )
			case 'xlsx' //excel 2007 and 2010...//Added by (Appeon)Gavin 12.07.2017 for V16.1  Export and excel				  
				n_cst_excel lnv_excel
				lnv_excel = create n_cst_excel
				lnv_excel.of_saveas_excel( dw_1,ls_path,true, true )
				destroy lnv_excel
			case '.txt'
				dw_1.SaveAs( ls_path, Text!, true )
			case '.pdf'
				dw_1.SaveAs( ls_path, PDF!, true )
			case 'html'
				dw_1.SaveAs( ls_path, HTMLTable!, true )
			case '.xml'
				dw_1.SaveAs( ls_path, XML!, true )
			case '.csv'
				dw_1.SaveAs( ls_path, CSV!, true )
		end choose
	End If
Else
	n_cst_datawindow   ln_dw
	
	ln_dw.of_Saveas( dw_1, "", 1 )
End If
end event

type cb_close from commandbutton within w_custom_report_manage
integer x = 3072
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_custom_report_manage
integer y = 152
integer width = 3465
integer height = 1988
integer taborder = 10
string title = "none"
string dataobject = "d_cust_report_list_manage"
boolean vscrollbar = true
boolean livescroll = true
end type

