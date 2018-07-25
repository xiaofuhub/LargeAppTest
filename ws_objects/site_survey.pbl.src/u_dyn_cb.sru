$PBExportHeader$u_dyn_cb.sru
$PBExportComments$User Object command button that is opened dynamically
forward
global type u_dyn_cb from userobject
end type
type cb_button from commandbutton within u_dyn_cb
end type
end forward

global type u_dyn_cb from userobject
integer width = 338
integer height = 148
long backcolor = 79416533
long tabtextcolor = 33554432
event lbuttondown pbm_lbuttondown
cb_button cb_button
end type
global u_dyn_cb u_dyn_cb

type variables

w_cust_message iw_parent
string is_clicked_event
integer ii_object_number
end variables

event lbuttondown;//
////put my self into drag mode
//iw_parent.ii_UDO_nmbr	=	ii_object_number
//iw_parent.iu_being_dragged = this
//Drag(Begin!)
//
//



end event

event rbuttondown;//string txt
//int posi
//// see if there is a '&' in the text string and remove it
//txt = cb_button.text
//posi = pos(txt,'&')
//if posi > 0 then txt = replace(txt,posi,1,'')
//// ask user if ok to delete
//if messagebox(txt+' Control',"Ok to delete?",question!,yesno!,1) = 2 then return
//iw_parent.iu_being_dragged = this
//iw_parent.Postevent("ue_close_udo")
end event

event constructor;// get the information about what kind a button we are supposed to be
u_dyn_struct parm
parm = message.powerobjectparm
ii_object_number = parm.code // set the object code
//iw_frame = parentwindow(parm.win) // who's my frame
iw_parent = parm.win  // who's my sheet
is_clicked_event = parm.clicked  // when clicked what event do I trigger
cb_button.width = parm.size  // how big am I
cb_button.text = parm.label  // what my name
cb_button.default=parm.default
//cb_button.setfocus( )
this.width = cb_button.width + 2.5*cb_button.x

end event

on u_dyn_cb.create
this.cb_button=create cb_button
this.Control[]={this.cb_button}
end on

on u_dyn_cb.destroy
destroy(this.cb_button)
end on

type cb_button from commandbutton within u_dyn_cb
integer y = 20
integer width = 334
integer height = 96
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
end type

on clicked;// tell my sheet to run the event named in is_clicked_event
iw_parent.triggerevent(is_clicked_event)
end on

