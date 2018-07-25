$PBExportHeader$w_prac_signature.srw
forward
global type w_prac_signature from window
end type
type cb_2 from commandbutton within w_prac_signature
end type
type cb_1 from commandbutton within w_prac_signature
end type
type dw_p_data from datawindow within w_prac_signature
end type
type p_prac_signature from picture within w_prac_signature
end type
end forward

global type w_prac_signature from window
integer width = 1600
integer height = 832
boolean titlebar = true
string title = "Electronic Signature"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_p_data dw_p_data
p_prac_signature p_prac_signature
end type
global w_prac_signature w_prac_signature

type variables
Long il_prac
end variables

forward prototypes
public function integer of_get_signature_data (long al_prac, long al_facil)
end prototypes

public function integer of_get_signature_data (long al_prac, long al_facil);//===============================
//$<Function> E-Sign :of_get_signature_data()
// $<arguments>
// 	value    long      al_prac
//	value	   long 	 al_facil						
// $<returns> integer
// $<description> set prac signature and information
// $<add> (Appeon) long.zhang 07.14.2011
////Copied from intellicred_comp.pbl@w_prac_data_1.of_get_photo_data() and Modified by long.zhang 06.14.2011
//===============================
string ls_signature_name

if al_prac > 0 then
	ls_signature_name = f_signature_download(al_prac)
	if 	ls_signature_name = "None" then
		p_prac_signature.PictureName = "nophoto3.jpg"
	else
		if FileExists(ls_signature_name) then
			p_prac_signature.PictureName = ls_signature_name
		end if
	end if
	dw_p_data.retrieve(al_prac, al_facil )
else
	p_prac_signature.visible = false
	dw_p_data.visible= false
end if

return 1

end function

on w_prac_signature.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_p_data=create dw_p_data
this.p_prac_signature=create p_prac_signature
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_p_data,&
this.p_prac_signature}
end on

on w_prac_signature.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_p_data)
destroy(this.p_prac_signature)
end on

event open;// E-Sign Begin added by long.zhang 06.14.2011
string ls_prac
long ll_facility,ll_pos

ls_prac= Message.StringParm
ll_pos=PosA(ls_prac,"-")

il_prac=Long(Mida(ls_prac,1,ll_pos - 1))
ll_facility=long(Mida(ls_prac,ll_pos + 1))

SetPointer(HourGlass!)
of_get_signature_data(il_prac,ll_facility)
SetPointer(Arrow!)

end event

event resize;//E-sign Begin added by long.zhang 06.17.2011
//p_prac_signature.height = this.height - 173
//p_prac_signature.width = this.width - 1075
//dw_p_data.x = p_prac_signature .width  + p_prac_signature.x + 23

end event

type cb_2 from commandbutton within w_prac_signature
integer x = 992
integer y = 576
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

event clicked;close( parent)
end event

type cb_1 from commandbutton within w_prac_signature
integer x = 466
integer y = 576
integer width = 489
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Get Signature File"
end type

event clicked;// E-sign : Begin added by long.zhang 06.15.2011
//Copied from intellicred_comp.pbl@w_prac_data_1. p_prac_photo.doubleclicked() event and modified by long.zhang 06.15.2011

String	ls_PicPath,ls_FullName,ls_PicName,ls_Postfix,ls_CurDirectory
long		ll_Rtn,ll_FileNo,ll_ReadCnts,ll_Cnts, ll_prac
Blob		lblb_ImageData,lblb_Buffer
datawindow dw_prac_list

ll_prac = il_prac
if ll_prac < 1 then
	messagebox("Import Signature","Please select Practitioner first.")
	return
end if
debugbreak()
if p_prac_signature.PictureName <> "nophoto3.jpg" then
	if MessageBox("Import Signature", "Reimporting electronic signature will replace the existing electronic signature, do you want to continue?", Question!, YesNo!) = 2 then
		Return
	end if
end if
ls_CurDirectory = GetCurrentDirectory()

ll_Rtn = GetFileOpenName("Open",ls_FullName,ls_PicName,"bmp","Bitmap Files (*.bmp),*.bmp,JPG Files (*.jpg),*.jpg,GIF Files (*.GIF),*.gif")
if ll_Rtn <> 1 then Return

ChangeDirectory(ls_CurDirectory)

ls_Postfix = Mid(ls_PicName,LastPos(ls_PicName,".") + 1)

ll_FileNo = FileOpen(ls_FullName,StreamMode!,Read!,LockReadWrite!)
if ll_FileNo <= 0 then Return

ll_ReadCnts = FileRead(ll_FileNo,lblb_Buffer)
do while ll_ReadCnts > 0
	lblb_ImageData += lblb_Buffer
	ll_ReadCnts = FileRead(ll_FileNo,lblb_Buffer)
loop

FileClose(ll_FileNo)

if Len(lblb_ImageData) <= 0 then Return

SELECT COUNT(*) INTO :ll_Cnts FROM pd_signature WHERE pd_signature.prac_id = :ll_prac ;
if ll_Cnts <= 0 then
	INSERT INTO pd_signature (prac_id) VALUES (:ll_prac) ;
	commit using sqlca;
end if

SELECT COUNT(*) INTO :ll_Cnts FROM pd_signature WHERE pd_signature.prac_id = :ll_prac ;

UPDATE pd_signature SET image_type = :ls_Postfix WHERE pd_signature.prac_id = :ll_prac ;
UPDATEBLOB pd_signature SET image_data = :lblb_ImageData WHERE pd_signature.prac_id = :ll_prac ;
debugbreak()
ls_picname = ls_fullname
	
if 	ls_picname = "None" then
	p_prac_signature.PictureName = "nophoto3.jpg"
else
	if FileExists(ls_PicName) then
		p_prac_signature.PictureName = ls_picname
	end if
end if

end event

type dw_p_data from datawindow within w_prac_signature
integer x = 206
integer y = 28
integer width = 1019
integer height = 232
integer taborder = 10
string title = "none"
string dataobject = "d_personal_data_cred"
boolean border = false
boolean livescroll = true
end type

event constructor;//E-Sign added by long.zhang 06.15.2011
if gs_cust_type = 'I' then
	this.dataobject = "d_sk_personal_data"
else
	this.dataobject = "d_personal_data_cred"
end if

this.settransobject(sqlca)
end event

event doubleclicked;// E-sign: Begin added by long.zhang 06.15.2011 
string s
IF this.rowcount( ) < 1 THEN Return -1
s = this.getitemstring(1,"v_mailing_address_e_mail_address")
if  gi_email_type = 0 then //Start Code Change ----12.11.2012 #V12 maha
	open(w_general_email_send)
	w_general_email_send.sle_sendto.text = s
end if

end event

type p_prac_signature from picture within w_prac_signature
integer x = 18
integer y = 264
integer width = 1527
integer height = 292
string picturename = "nophoto3.jpg"
boolean border = true
boolean focusrectangle = false
end type

event doubleclicked;// E-sign : Begin added by long.zhang 06.15.2011
//Copied from intellicred_comp.pbl@w_prac_data_1. p_prac_photo.doubleclicked() event and modified by long.zhang 06.15.2011

String	ls_PicPath,ls_FullName,ls_PicName,ls_Postfix,ls_CurDirectory
long		ll_Rtn,ll_FileNo,ll_ReadCnts,ll_Cnts, ll_prac
Blob		lblb_ImageData,lblb_Buffer
datawindow dw_prac_list

ll_prac = il_prac
if ll_prac < 1 then
	messagebox("Import Signature","Please select Practitioner first.")
	return
end if
debugbreak()
if this.PictureName <> "nophoto3.jpg" then
	if MessageBox("Import Signature", "Reimporting electronic signature will replace the existing electronic signature, do you want to continue?", Question!, YesNo!) = 2 then
		Return
	end if
end if
ls_CurDirectory = GetCurrentDirectory()

ll_Rtn = GetFileOpenName("Open",ls_FullName,ls_PicName,"bmp","Bitmap Files (*.bmp),*.bmp,JPG Files (*.jpg),*.jpg,GIF Files (*.GIF),*.gif")
if ll_Rtn <> 1 then Return

ChangeDirectory(ls_CurDirectory)

ls_Postfix = Mid(ls_PicName,LastPos(ls_PicName,".") + 1)

ll_FileNo = FileOpen(ls_FullName,StreamMode!,Read!,LockReadWrite!)
if ll_FileNo <= 0 then Return

ll_ReadCnts = FileRead(ll_FileNo,lblb_Buffer)
do while ll_ReadCnts > 0
	lblb_ImageData += lblb_Buffer
	ll_ReadCnts = FileRead(ll_FileNo,lblb_Buffer)
loop

FileClose(ll_FileNo)

if Len(lblb_ImageData) <= 0 then Return

SELECT COUNT(*) INTO :ll_Cnts FROM pd_signature WHERE pd_signature.prac_id = :ll_prac ;
if ll_Cnts <= 0 then
	INSERT INTO pd_signature (prac_id) VALUES (:ll_prac) ;
	commit using sqlca;
end if

SELECT COUNT(*) INTO :ll_Cnts FROM pd_signature WHERE pd_signature.prac_id = :ll_prac ;

UPDATE pd_signature SET image_type = :ls_Postfix WHERE pd_signature.prac_id = :ll_prac ;
UPDATEBLOB pd_signature SET image_data = :lblb_ImageData WHERE pd_signature.prac_id = :ll_prac ;
debugbreak()
ls_picname = ls_fullname
	
if 	ls_picname = "None" then
	this.PictureName = "nophoto3.jpg"
else
	if FileExists(ls_PicName) then
		this.PictureName = ls_picname
	end if
end if

end event

event rbuttondown;// E-Sign : added  by long.zhang  06.15.2011
//copied from intellicred_comp.pbl w_prac_data_1 p_prac_photo.rbuttondown() event and modified by long.zhang 06.15.2011

string ls_image_type
String	ls_PicName,ls_Postfix, ls_PicPath
blob lblb_image_data

if MessageBox("Delete Signature", "Are you sure you want to delete the electronic signature?", Question!, YesNo!) = 2 then
	Return
end if

SetNull(ls_image_type)
lblb_image_data = Blob(' ')
debugbreak()

SELECT image_type INTO :ls_Postfix from pd_signature WHERE pd_signature.prac_id = :il_prac ;
ls_PicPath = TRIM(gnv_data.of_getitem("ids","picture_path",false))
ls_PicName = ls_PicPath + "p_" + String( il_prac ) + "." + ls_Postfix

UPDATE pd_signature SET image_type = :ls_image_type WHERE pd_signature.prac_id = :il_prac;
if SQLCA.SQLCode <> 0 then
	MessageBox("Error", "Failed to delete the electronic signature.", StopSign!)
	Return
end if

UPDATEBLOB pd_signature SET image_data = :lblb_image_data WHERE pd_signature.prac_id = :il_prac;
if SQLCA.SQLCode <> 0 then
	MessageBox("Error", "Failed to delete the electronic signature.", StopSign!)
	Return
end if
p_prac_signature.picturename = 'nophoto3.jpg'
dw_p_data.reset()
filedelete(ls_PicName)

end event

