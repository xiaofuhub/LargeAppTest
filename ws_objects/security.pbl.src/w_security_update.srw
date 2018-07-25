$PBExportHeader$w_security_update.srw
forward
global type w_security_update from window
end type
type st_5 from statictext within w_security_update
end type
type dw_check_mod from datawindow within w_security_update
end type
type sle_4 from singlelineedit within w_security_update
end type
type st_4 from statictext within w_security_update
end type
type dw_rights from datawindow within w_security_update
end type
type sle_3 from singlelineedit within w_security_update
end type
type st_3 from statictext within w_security_update
end type
type st_2 from statictext within w_security_update
end type
type st_1 from statictext within w_security_update
end type
type sle_2 from singlelineedit within w_security_update
end type
type sle_1 from singlelineedit within w_security_update
end type
type cb_import from commandbutton within w_security_update
end type
type cb_2 from commandbutton within w_security_update
end type
type cb_rights from commandbutton within w_security_update
end type
type dw_imp_mod from datawindow within w_security_update
end type
type dw_imp_sub from datawindow within w_security_update
end type
type dw_imp_action from datawindow within w_security_update
end type
type dw_roles from datawindow within w_security_update
end type
end forward

global type w_security_update from window
integer x = 1330
integer y = 1080
integer width = 2926
integer height = 1656
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 80269524
st_5 st_5
dw_check_mod dw_check_mod
sle_4 sle_4
st_4 st_4
dw_rights dw_rights
sle_3 sle_3
st_3 st_3
st_2 st_2
st_1 st_1
sle_2 sle_2
sle_1 sle_1
cb_import cb_import
cb_2 cb_2
cb_rights cb_rights
dw_imp_mod dw_imp_mod
dw_imp_sub dw_imp_sub
dw_imp_action dw_imp_action
dw_roles dw_roles
end type
global w_security_update w_security_update

type variables
integer ii_mods
end variables

on w_security_update.create
this.st_5=create st_5
this.dw_check_mod=create dw_check_mod
this.sle_4=create sle_4
this.st_4=create st_4
this.dw_rights=create dw_rights
this.sle_3=create sle_3
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_2=create sle_2
this.sle_1=create sle_1
this.cb_import=create cb_import
this.cb_2=create cb_2
this.cb_rights=create cb_rights
this.dw_imp_mod=create dw_imp_mod
this.dw_imp_sub=create dw_imp_sub
this.dw_imp_action=create dw_imp_action
this.dw_roles=create dw_roles
this.Control[]={this.st_5,&
this.dw_check_mod,&
this.sle_4,&
this.st_4,&
this.dw_rights,&
this.sle_3,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_2,&
this.sle_1,&
this.cb_import,&
this.cb_2,&
this.cb_rights,&
this.dw_imp_mod,&
this.dw_imp_sub,&
this.dw_imp_action,&
this.dw_roles}
end on

on w_security_update.destroy
destroy(this.st_5)
destroy(this.dw_check_mod)
destroy(this.sle_4)
destroy(this.st_4)
destroy(this.dw_rights)
destroy(this.sle_3)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.cb_import)
destroy(this.cb_2)
destroy(this.cb_rights)
destroy(this.dw_imp_mod)
destroy(this.dw_imp_sub)
destroy(this.dw_imp_action)
destroy(this.dw_roles)
end on

event open;integer sub
integer act
integer mod
integer rit



//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=dba;PWD=sql',DelimitIdentifier='No'"
SQLCA.AutoCommit = false
	
//CONNECT USING SQLCA;

select max(sub_module_id)
into :sub
from security_sub_module;

select max(action_id)
into :act
from security_rights_action;

select max(module_id)
into :mod
from security_modules;

select max(rights_id)
into :rit
from security_roles_rights;

sle_1.text = string(sub)
sle_2.text = string(act)
sle_3.text = string(mod)
sle_4.text = string(rit)



//dw_1.settransobject(sqlca)
//dw_1.retrieve()
end event

event close;SQLCA.AutoCommit = true

//disCONNECT USING SQLCA;

end event

type st_5 from statictext within w_security_update
integer x = 64
integer y = 40
integer width = 1303
integer height = 128
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Adding Security Items"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_check_mod from datawindow within w_security_update
integer x = 832
integer y = 256
integer width = 133
integer height = 460
integer taborder = 30
string dataobject = "d_new_mod"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer r





r = this.getclickedrow()
this.setrow(r)
this.selectrow(0,false) 
this.selectrow(r,true) 
end event

type sle_4 from singlelineedit within w_security_update
integer x = 2021
integer y = 1124
integer width = 247
integer height = 92
integer taborder = 90
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_security_update
integer x = 1760
integer y = 1144
integer width = 247
integer height = 76
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Rights id"
boolean focusrectangle = false
end type

type dw_rights from datawindow within w_security_update
integer x = 5
integer y = 912
integer width = 1467
integer height = 460
integer taborder = 110
string dataobject = "d_newrole_rights"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_3 from singlelineedit within w_security_update
integer x = 2016
integer y = 744
integer width = 247
integer height = 92
integer taborder = 70
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_security_update
integer x = 1719
integer y = 768
integer width = 256
integer height = 76
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Module id"
boolean focusrectangle = false
end type

type st_2 from statictext within w_security_update
integer x = 1755
integer y = 1020
integer width = 247
integer height = 76
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Action id"
boolean focusrectangle = false
end type

type st_1 from statictext within w_security_update
integer x = 1719
integer y = 892
integer width = 265
integer height = 76
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Sub_mod id"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_security_update
integer x = 2016
integer y = 1000
integer width = 247
integer height = 92
integer taborder = 80
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_security_update
integer x = 2016
integer y = 868
integer width = 247
integer height = 92
integer taborder = 60
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_import from commandbutton within w_security_update
integer x = 763
integer y = 760
integer width = 302
integer height = 108
integer taborder = 120
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "import"
end type

event clicked;integer m
integer mc
integer s
integer sc
integer a
integer ac
integer c
integer cc
integer check
integer modid

if FileExists(gs_dir_path + "IntelliCred\security_mod_1101.txt") = true then
		if FileExists(gs_dir_path + "IntelliCred\security_submod_1101.txt") = true then
			if FileExists(gs_dir_path + "IntelliCred\security_actions_1101.txt") = true then
				
						
			dw_imp_mod.SetTransObject( SQLCA	)
			dw_imp_mod.reset()
			mc = dw_imp_mod.importfile( gs_dir_path + "IntelliCred\security_mod_1101.txt" )
			
			dw_imp_sub.SetTransObject( SQLCA	)
			dw_imp_sub.reset()
			sc = dw_imp_sub.importfile( gs_dir_path + "IntelliCred\security_submod_1101.txt" )
			
			dw_imp_action.SetTransObject( SQLCA	)
			dw_imp_action.reset()
			ac = dw_imp_action.importfile( gs_dir_path + "IntelliCred\security_actions_1101.txt" )

			else
				messagebox("Problem with file. ","Check to see that file security_actions_1101.txt exists in the " + gs_dir_path + "IntelliCred folder.")
				ii_mods = 0
				return
			end if
		else
		messagebox("Problem with file. ","Check to see that file security_submod_1101.txt exists in the " + gs_dir_path + "IntelliCred folder.")
		ii_mods = 0
		return
		end if
else
	messagebox("Problem with file. ","Check to see that file security_mod_1101.txt exists in the " + gs_dir_path + "IntelliCred folder.")
	ii_mods = 0
	return
end if

dw_check_mod.SetTransObject( SQLCA	)
cc = dw_check_mod.retrieve()

//for m = mc to 1 step -1 //remove import data currently in database
//	check = 0
//	modid = dw_imp_mod.getitemnumber(m,"module_id")
//	for c = 1 to cc
//		if dw_check_mod.getitemnumber(c,"module_id") = modid then
//			check = 1
//			continue
//		end if
//	next
//	if check = 1 then
//		dw_imp_mod.deleterow(m)
//		sc = dw_imp_sub.rowcount()
//		for s = sc to 1 step -1
//			if dw_imp_sub.getitemnumber(s,"module_id") = modid then
//				dw_imp_sub.deleterow(s)
//			end if
//		next
//		ac = dw_imp_action.rowcount()
//		for a = ac to 1 step -1
//			if dw_imp_action.getitemnumber(a,"module_id") = modid then
//				dw_imp_action.deleterow(a)
//			end if
//		next
//	end if
//next
delete from security_roles_rights where action_id > 900 and action_id not in (1300,1000);
commit using sqlca;
delete from security_rights_action where action_id = 1600;
commit using sqlca;
delete from security_rights_action where module_id > 19;
commit using sqlca;
delete from security_sub_module where module_id > 19; 
commit using sqlca;
delete from security_modules where module_id > 19; 


ii_mods = dw_imp_mod.rowcount()

if ii_mods > 0 then
	cb_rights.triggerevent(clicked!)
end if
//messagebox("data remaining",dw_imp_mod.rowcount() )
end event

type cb_2 from commandbutton within w_security_update
integer x = 2034
integer y = 1252
integer width = 247
integer height = 108
integer taborder = 40
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_rights from commandbutton within w_security_update
integer x = 1262
integer y = 752
integer width = 311
integer height = 108
integer taborder = 50
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "create rights"
end type

event clicked;		integer r
		integer ritid
		integer i
		integer rc
		integer actid
		integer crow
		integer a
		integer setting

dw_imp_action.settransobject(sqlca)
dw_imp_mod.settransobject(sqlca)
dw_imp_sub.settransobject(sqlca)

if dw_imp_mod.update() <> 1 then
	rollback using sqlca;
	messagebox("Save error","Unable to save module files")
else
	if dw_imp_sub.update() <> 1 then
		rollback using sqlca;
		messagebox("Save error","Unable to save submodule files")
	else
		if dw_imp_action.update() <> 1 then
			rollback using sqlca;
			messagebox("Save error","Unable to save actions files files")
		else	
			if dw_imp_action.rowcount() > 0 then
				dw_roles.settransobject(sqlca)
				rc = dw_roles.retrieve()
				ritid = integer(sle_4.text)
				ritid= ritid + 1
		
				for a = 1 to dw_imp_action.rowcount()		
					actid = dw_imp_action.getitemnumber(a,"action_id")
					setting =  dw_imp_action.getitemnumber(a,"dddw_type")
					for r = 1 to rc
						ritid= ritid + 1
						i = dw_rights.insertrow(0)
						dw_rights.setitem(i,"role_id",dw_roles.getitemnumber(r,"role_id"))
						dw_rights.setitem(i,"rights_id",ritid)
						dw_rights.setitem(i,"action_id",actid)
						dw_rights.setitem(i,"value_id",setting)
						
						sle_4.text = string(ritid)
					next
				next
					dw_rights.settransobject(sqlca)
					if dw_rights.update() <> 1 then
						rollback using sqlca;
						messagebox("Save error","Unable to save rights records")
					else
						update ids set rights_id = :ritid;
						update icred_settings set set_18 = 1;
						commit using sqlca;
						
					end if
			end if
		end if
	end if
end if


end event

type dw_imp_mod from datawindow within w_security_update
integer x = 46
integer y = 256
integer width = 658
integer height = 448
integer taborder = 20
string dataobject = "d_new_mod"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer r





r = this.getclickedrow()
this.setrow(r)
this.selectrow(0,false) 
this.selectrow(r,true) 
end event

event rowfocuschanged;integer subid

//subid = this.getitemnumber(currentrow,"sub_module_id")
//dw_2.settransobject(sqlca)
//dw_2.retrieve(subid)
end event

type dw_imp_sub from datawindow within w_security_update
integer x = 1120
integer y = 252
integer width = 530
integer height = 464
integer taborder = 130
string dataobject = "d_new_sub"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_imp_action from datawindow within w_security_update
integer x = 1714
integer y = 252
integer width = 608
integer height = 440
integer taborder = 10
string dataobject = "d_scrty_actions_ret"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//integer r
//
//if this.rowcount() < 1 then return
//r = this.getclickedrow()
//this.setrow(r)
//this.selectrow(0,false) 
//this.selectrow(r,true) 
//
//integer actid
//
//actid = this.getitemnumber(r,"action_id")
//dw_4.settransobject(sqlca)
//dw_4.retrieve(actid)
//dw_6.settransobject(sqlca)
//dw_6.retrieve(actid)
end event

type dw_roles from datawindow within w_security_update
integer x = 18
integer y = 736
integer width = 699
integer height = 148
integer taborder = 100
string dataobject = "d_roles"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

