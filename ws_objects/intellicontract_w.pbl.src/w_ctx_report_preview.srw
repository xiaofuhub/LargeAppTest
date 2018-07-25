$PBExportHeader$w_ctx_report_preview.srw
$PBExportComments$[intellicontract_w]
forward
global type w_ctx_report_preview from w_response
end type
type cb_5 from uo_cb_output within w_ctx_report_preview
end type
type cb_4 from commandbutton within w_ctx_report_preview
end type
type cb_2 from u_cb within w_ctx_report_preview
end type
type dw_1 from u_dw within w_ctx_report_preview
end type
end forward

global type w_ctx_report_preview from w_response
integer width = 3410
integer height = 1936
string title = "Report Viewer"
long backcolor = 33551856
cb_5 cb_5
cb_4 cb_4
cb_2 cb_2
dw_1 dw_1
end type
global w_ctx_report_preview w_ctx_report_preview

type variables


long il_retive_parm
end variables

on w_ctx_report_preview.create
int iCurrent
call super::create
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_2=create cb_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_5
this.Control[iCurrent+2]=this.cb_4
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_1
end on

on w_ctx_report_preview.destroy
call super::destroy
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event pfc_postopen;call super::pfc_postopen;

il_retive_parm  =  Message.doubleparm



this.dw_1.event pfc_retrieve( )
end event

type cb_5 from uo_cb_output within w_ctx_report_preview
integer x = 2542
integer y = 1708
integer width = 425
integer height = 92
integer taborder = 50
end type

event constructor;call super::constructor;

 idw =  dw_1
end event

event clicked;m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent( idw)
NewMenu.m_options.m_mailall.visible = false
NewMenu.m_options.m_printall.visible = false
NewMenu.m_options.m_printcurrent.text = 'Print'
NewMenu.m_options.m_mailcurrent.text = 'Mail'
NewMenu.m_options.PopMenu(this.x, + this.y - 190)
//NewMenu.m_options.PopMenu(NewMenu.parentwindow.x + NewMenu.parentwindow.x  + 850, NewMenu.parentwindow.y + NewMenu.parentwindow.y + 175)

end event

type cb_4 from commandbutton within w_ctx_report_preview
boolean visible = false
integer x = 37
integer y = 1728
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "none"
end type

event clicked;integer li_rc
inet linet_main
n_cst_internet luo_data  // as defined above

linet_main = CREATE inet
luo_data = CREATE n_cst_internet

SetPointer(HourGlass!)
li_rc = &
  linet_main.GetURL("http://www.mbskinner.com", luo_data)
SetPointer(Arrow!)
IF li_rc = 1 THEN
   MessageBox("Data from Real's HowTo", luo_data.is_data)
ELSE
   MessageBox("Data from Real's HowTo", "Oops rc:" + string(li_rc))
END IF

DESTROY luo_data
DESTROY linet_main


end event

type cb_2 from u_cb within w_ctx_report_preview
integer x = 3013
integer y = 1708
integer taborder = 30
string text = "&Close"
end type

event clicked;call super::clicked;
close(parent)
end event

type dw_1 from u_dw within w_ctx_report_preview
event ue_mail_current ( )
integer width = 3369
integer height = 1684
integer taborder = 10
boolean titlebar = true
string title = "Report Preview"
string dataobject = "rpt_contract_profile"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event ue_mail_current();

Super::EVENT ue_save_pdf_for_mailing( )

//releasecapture( )

Super::EVENT ue_mail('QA Profile','' )


end event

event pfc_retrieve;call super::pfc_retrieve;


return this.retrieve( il_retive_parm )
end event

event other;call super::other;if Message.WordParm = 61458 then // Add by Evan 2008-01-29
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

