$PBExportHeader$w_priv_prac_detail.srw
forward
global type w_priv_prac_detail from window
end type
type dw_1 from u_dw within w_priv_prac_detail
end type
type cb_save from commandbutton within w_priv_prac_detail
end type
type cb_1 from commandbutton within w_priv_prac_detail
end type
end forward

global type w_priv_prac_detail from window
integer width = 3694
integer height = 1900
boolean titlebar = true
string title = "Privilege Detail"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_save cb_save
cb_1 cb_1
end type
global w_priv_prac_detail w_priv_prac_detail

type variables
boolean ib_mod = false
end variables

on w_priv_prac_detail.create
this.dw_1=create dw_1
this.cb_save=create cb_save
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_save,&
this.cb_1}
end on

on w_priv_prac_detail.destroy
destroy(this.dw_1)
destroy(this.cb_save)
destroy(this.cb_1)
end on

event open;long ll_rec
string s

//Start Code Change ----10.27.2015 #V15 maha - allow for privilege editing
//ll_rec = message.doubleparm
s = message.stringparm
ll_rec = long(mid(s,1,pos(s,"*",1) -1))
if mid(s,pos(s,"*",1) + 1) = "Data" then
	if w_mdi.of_security_access( 7799 ) = 0 then  
		dw_1.enabled = true
		cb_save.visible = true
	end if
end if
//End Code Change ----10.27.2015 

dw_1.settransobject(sqlca)
dw_1.retrieve(ll_rec)

end event

type dw_1 from u_dw within w_priv_prac_detail
integer y = 120
integer width = 3680
integer height = 1696
integer taborder = 30
boolean enabled = false
string dataobject = "d_priv_prac_record_detail"
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;ib_mod = true
end event

type cb_save from commandbutton within w_priv_prac_detail
boolean visible = false
integer x = 2857
integer y = 16
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_1.accepttext()

of_add_audit_priv_prac( "Prac", dw_1,0)

dw_1.update()
end event

type cb_1 from commandbutton within w_priv_prac_detail
integer x = 3269
integer y = 16
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked; //Start Code Change ----10.27.2015 #V15 maha
 string s
 
 if ib_mod then
	s = "MOD"
else
	s = "NOT"
end if
 
closewithreturn(parent, s)
//close(parent)
end event

