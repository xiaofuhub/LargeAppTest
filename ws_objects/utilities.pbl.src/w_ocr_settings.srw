$PBExportHeader$w_ocr_settings.srw
forward
global type w_ocr_settings from w_response
end type
type dw_1 from datawindow within w_ocr_settings
end type
type cb_cancel from commandbutton within w_ocr_settings
end type
type cb_ok from commandbutton within w_ocr_settings
end type
end forward

global type w_ocr_settings from w_response
integer width = 1650
integer height = 948
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
event ue_syscommand pbm_syscommand
dw_1 dw_1
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_ocr_settings w_ocr_settings

type variables
n_cst_image_cp_ocr inv_ocr
String is_parm
end variables

event ue_syscommand;If message.wordparm = 61536 Then
	cb_cancel.Trigger Event Clicked()
End If

end event

on w_ocr_settings.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
end on

on w_ocr_settings.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;call super::open;
dw_1.SetTransobject(SQLCA)
dw_1.Retrieve()

If Upper(is_parm) = 'NO PDF' Then
	dw_1.Modify("ocr_engine_pdf.color = '" + String(RGB(128,128,128)) + "' ocr_engine_pdf.protect = '1'" )
End If


end event

event pfc_preopen;call super::pfc_preopen;is_parm = Message.Stringparm
end event

type dw_1 from datawindow within w_ocr_settings
integer y = 28
integer width = 1582
integer height = 748
integer taborder = 10
string title = "none"
string dataobject = "d_ocr_settings"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;String ls_mesg
ls_mesg =  'Engine 1: Excellent performance and recognition rate, but for a very few PDF files, the OCR result may be entirely wrong. ' + &
			  '~r~n~r~nEngine 2: It is recommended in most cases to use the Engine 1 option.  The Engine 2 option should only be used for .pdf files where there has been an issue with the results of the OCR using Engine 1.' + &
			  '~r~n~r~nNote: This option is only useful for Searchable PDF file, for other image files such as image PDF, TIF, JPG etc, it will always use the Engine 2. '
If dwo.name = 'b_help' Then
	Messagebox('OCR Engine Help',ls_mesg)
End If
end event

type cb_cancel from commandbutton within w_ocr_settings
integer x = 1179
integer y = 792
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,0)
end event

type cb_ok from commandbutton within w_ocr_settings
integer x = 823
integer y = 792
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;dw_1.AcceptText()

If dw_1.modifiedcount( ) > 0 Then
	If dw_1.Update() = 1 Then
		gnv_data.of_retrieve('icred_settings')
	Else
		Messagebox('Error','Failed to save the OCR Settings.')
	End If
End If

CloseWithReturn(Parent,1)

//Integer li_ocr_language,li_ocr_mode,li_ocr_engine_pdf
//
//Choose Case ddlb_ocr_language.text
//	Case 'English'
//		li_ocr_language = 0 
//	Case 'German' 
//		li_ocr_language = 1
//	Case 'Fraktur'
//		li_ocr_language = 2
//	Case 'Italian'
//		li_ocr_language = 3
//	Case 'Dutch'
//		li_ocr_language = 4
//	Case 'Portuguese'
//		li_ocr_language = 5
//	Case 'Spanish'
//		li_ocr_language = 6
//End Choose
//
//If rb_mode_fast.checked Then
//	li_ocr_mode = 0
//ElseIf rb_mode_normal.checked Then
//	li_ocr_mode = 1
//ElseIf rb_mode_excellent.checked Then
//	li_ocr_mode = 2
//End If
//
//If rb_engine1.checked Then
//	li_ocr_engine_pdf = 1
//Else
//	li_ocr_engine_pdf = 2
//End If
//
//inv_ocr.of_set_ocr_settings(li_ocr_language , li_ocr_mode , li_ocr_engine_pdf)
//
//CloseWithReturn(Parent,1)
//
end event

