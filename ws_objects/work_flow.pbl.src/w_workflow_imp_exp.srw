$PBExportHeader$w_workflow_imp_exp.srw
forward
global type w_workflow_imp_exp from window
end type
type cb_imp from commandbutton within w_workflow_imp_exp
end type
type cb_exp from commandbutton within w_workflow_imp_exp
end type
type cb_1 from commandbutton within w_workflow_imp_exp
end type
type dw_list from datawindow within w_workflow_imp_exp
end type
type dw_trigger_comp from datawindow within w_workflow_imp_exp
end type
type dw_steps from datawindow within w_workflow_imp_exp
end type
type dw_trig_stat from datawindow within w_workflow_imp_exp
end type
type dw_2 from datawindow within w_workflow_imp_exp
end type
type dw_hdr from datawindow within w_workflow_imp_exp
end type
end forward

global type w_workflow_imp_exp from window
integer width = 2126
integer height = 2108
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_imp cb_imp
cb_exp cb_exp
cb_1 cb_1
dw_list dw_list
dw_trigger_comp dw_trigger_comp
dw_steps dw_steps
dw_trig_stat dw_trig_stat
dw_2 dw_2
dw_hdr dw_hdr
end type
global w_workflow_imp_exp w_workflow_imp_exp

on w_workflow_imp_exp.create
this.cb_imp=create cb_imp
this.cb_exp=create cb_exp
this.cb_1=create cb_1
this.dw_list=create dw_list
this.dw_trigger_comp=create dw_trigger_comp
this.dw_steps=create dw_steps
this.dw_trig_stat=create dw_trig_stat
this.dw_2=create dw_2
this.dw_hdr=create dw_hdr
this.Control[]={this.cb_imp,&
this.cb_exp,&
this.cb_1,&
this.dw_list,&
this.dw_trigger_comp,&
this.dw_steps,&
this.dw_trig_stat,&
this.dw_2,&
this.dw_hdr}
end on

on w_workflow_imp_exp.destroy
destroy(this.cb_imp)
destroy(this.cb_exp)
destroy(this.cb_1)
destroy(this.dw_list)
destroy(this.dw_trigger_comp)
destroy(this.dw_steps)
destroy(this.dw_trig_stat)
destroy(this.dw_2)
destroy(this.dw_hdr)
end on

type cb_imp from commandbutton within w_workflow_imp_exp
integer x = 169
integer y = 20
integer width = 288
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Import"
end type

type cb_exp from commandbutton within w_workflow_imp_exp
integer x = 475
integer y = 20
integer width = 288
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Export"
end type

event clicked;string docpath, docname

integer i, li_cnt, li_rtn, li_filenum

 

li_rtn = GetFileOpenName("Select File",    docpath, docname,   "Text File (*.TXT),*.TXT,"  ,   "Text Files (*.*), *.*",    "C:\Program Files\Sybase")
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008
end event

type cb_1 from commandbutton within w_workflow_imp_exp
integer x = 795
integer y = 20
integer width = 288
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;Close( parent)
end event

type dw_list from datawindow within w_workflow_imp_exp
integer x = 37
integer y = 140
integer width = 1051
integer height = 1688
integer taborder = 30
string title = "none"
string dataobject = "d_wf_imp_select"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_trigger_comp from datawindow within w_workflow_imp_exp
integer x = 1170
integer y = 1164
integer width = 686
integer height = 268
integer taborder = 30
string title = "none"
string dataobject = "d_wf_imp_trigger_parm_comp"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_steps from datawindow within w_workflow_imp_exp
integer x = 1175
integer y = 528
integer width = 686
integer height = 300
integer taborder = 20
string title = "none"
string dataobject = "wf_imp_steps"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject( sqlca)
end event

type dw_trig_stat from datawindow within w_workflow_imp_exp
integer x = 1166
integer y = 852
integer width = 699
integer height = 292
integer taborder = 30
string title = "none"
string dataobject = "d_wf_imp_trigger_parm_status"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_workflow_imp_exp
integer x = 1184
integer y = 1592
integer width = 686
integer height = 180
integer taborder = 20
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_hdr from datawindow within w_workflow_imp_exp
integer x = 1175
integer y = 208
integer width = 686
integer height = 304
integer taborder = 10
string title = "none"
string dataobject = "d_wf_imp_hdr"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

