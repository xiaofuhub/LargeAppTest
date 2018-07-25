$PBExportHeader$w_email_signature.srw
forward
global type w_email_signature from window
end type
type ole_signature from u_email_edit within w_email_signature
end type
type cbx_blind from checkbox within w_email_signature
end type
type cb_close from commandbutton within w_email_signature
end type
type cb_save from commandbutton within w_email_signature
end type
type cbx_enabled from checkbox within w_email_signature
end type
type st_1 from statictext within w_email_signature
end type
end forward

global type w_email_signature from window
integer width = 2528
integer height = 1944
boolean titlebar = true
string title = "Email Signature"
boolean controlmenu = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
ole_signature ole_signature
cbx_blind cbx_blind
cb_close cb_close
cb_save cb_save
cbx_enabled cbx_enabled
st_1 st_1
end type
global w_email_signature w_email_signature

on w_email_signature.create
this.ole_signature=create ole_signature
this.cbx_blind=create cbx_blind
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cbx_enabled=create cbx_enabled
this.st_1=create st_1
this.Control[]={this.ole_signature,&
this.cbx_blind,&
this.cb_close,&
this.cb_save,&
this.cbx_enabled,&
this.st_1}
end on

on w_email_signature.destroy
destroy(this.ole_signature)
destroy(this.cbx_blind)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cbx_enabled)
destroy(this.st_1)
end on

event open;long ll_Flag
string ls_blind  //(Appeon)Alfee 06.26.2013 - V141 ISG-CLX

gw_popup[UpperBound(gw_popup[]) + 1] = This //(Appeon)Harry 03.18.2014 - V142 ISG-CLX

gnv_reg_ocx.of_check_ocx( 1,'', True) //1: office //Added by Ken.Guo on 2008-11-06

SELECT flag,blind_flag INTO :ll_Flag,:ls_blind FROM security_user_mailsetting WHERE user_id = :gs_user_id; //Add blind_flag - (Appeon)Alfee 06.26.2013 - V141 ISG-CLX

if IsNull(ll_Flag) or ll_Flag = 0 then
	cbx_enabled.Checked = false
else
	cbx_enabled.Checked = True
end if

//---------Begin Added by (Appeon)Alfee 06.26.2013 for V141 ISG-CLX--------
if ls_blind = '1' then
	cbx_blind.checked = true
else
	cbx_blind.checked = false
end if

if gb_contract_module then  
	cbx_blind.backcolor = gl_bg_color
	cbx_blind.visible = true 
	if not gb_contract_version then cbx_blind.text = cbx_blind.text + " (CTX)"	
end if	
//---------End Added ------------------------------------------------------------------

ole_signature.of_Open(gs_user_id)

ole_signature.Object.ActiveDocument.ActiveWindow.DocumentMap = False //(Appeon)Alfee 06.26.2013 - V141 ISG-CLX
end event

event close;ole_Signature.of_Close()
end event

event activate;//Added By Ken.Guo 2011-11-30. Workaround Office OCX's bug - (Appeon)Alfee 06.26.2013 - V141 ISG-CLX
If isvalid(ole_signature ) Then
	ole_signature.object.activate(true)
End If
end event

type ole_signature from u_email_edit within w_email_signature
integer x = 37
integer y = 100
integer width = 2450
integer height = 1612
integer taborder = 20
string binarykey = "w_email_signature.win"
end type

type cbx_blind from checkbox within w_email_signature
boolean visible = false
integer x = 37
integer y = 1748
integer width = 1115
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Blind copy myself by default"
end type

type cb_close from commandbutton within w_email_signature
integer x = 2117
integer y = 1732
integer width = 329
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;ole_signature.of_close()
Close(Parent)

end event

type cb_save from commandbutton within w_email_signature
integer x = 1705
integer y = 1732
integer width = 329
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
boolean default = true
end type

event clicked;long		ll_Cnt,ll_Flag
Blob		lblb_SigData
string		ls_blind  //(Appeon)Alfee 06.26.2013 - V141 ISG-CLX

SELECT Count(*)
  INTO :ll_Cnt
  FROM security_user_mailsetting
 WHERE user_id = :gs_user_id;

if cbx_enabled.Checked then
	ll_Flag = 1
else
	ll_Flag = 0
end if

//---------Begin Added by (Appeon)Alfee 06.26.2013 for V141 ISG-CLX--------
if cbx_blind.checked then
	ls_blind = '1'
else
	ls_blind = '0'
end if
//---------End Added ------------------------------------------------------------------

if ll_Cnt <= 0 then
	INSERT INTO security_user_mailsetting(user_id) VALUES(:gs_user_id);
end if

UPDATE security_user_mailsetting SET flag = :ll_Flag,blind_flag = :ls_blind WHERE user_id = :gs_user_id; //Add blind_flag - (Appeon)Alfee 06.26.2013 for V141 ISG-CLX

ole_signature.of_getblob(lblb_SigData)
UPDATEBLOB security_user_mailsetting SET signature = :lblb_SigData WHERE user_id = :gs_user_id;

COMMIT;

end event

type cbx_enabled from checkbox within w_email_signature
integer x = 2185
integer y = 12
integer width = 302
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Enabled"
end type

type st_1 from statictext within w_email_signature
integer x = 37
integer y = 24
integer width = 411
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Email Signature"
boolean focusrectangle = false
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
06w_email_signature.bin 
2A00000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000c62e5f7001d175c500000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d300000000c62e5f7001d175c5c62e5f7001d175c50000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
28ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd00003766000029a700dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd00003766000029a700dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
16w_email_signature.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
