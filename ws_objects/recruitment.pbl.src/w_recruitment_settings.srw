$PBExportHeader$w_recruitment_settings.srw
forward
global type w_recruitment_settings from w_response
end type
type cb_save from commandbutton within w_recruitment_settings
end type
type cb_close from commandbutton within w_recruitment_settings
end type
type dw_detail from u_dw within w_recruitment_settings
end type
end forward

global type w_recruitment_settings from w_response
integer width = 2235
integer height = 1588
string title = "Recruiting Web Settings"
long backcolor = 33551856
cb_save cb_save
cb_close cb_close
dw_detail dw_detail
end type
global w_recruitment_settings w_recruitment_settings

type variables
long il_loc_id
end variables

on w_recruitment_settings.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_detail=create dw_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.dw_detail
end on

on w_recruitment_settings.destroy
call super::destroy
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.dw_detail)
end on

event open;call super::open;//Start Code Change ----05.08.2013 #V14 maha - created

integer r
r = dw_detail.retrieve()

if r = 0 then dw_detail.insertrow(1)


 //Start Code Change ----08.10.2015 #V15 maha
IF gi_imaging = 0 THEN
	dw_detail.modify("b_types.Visible = False")
ELSE
	IF w_mdi.of_security_access( 1370 ) = 0 THEN
		dw_detail.modify("b_types.Visible = False")
	ELSE
		dw_detail.modify("b_types.Visible = True")
	END IF
END IF
 //End Code Change ----08.10.2015
 
 
 
end event

type cb_save from commandbutton within w_recruitment_settings
integer x = 1472
integer y = 24
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;parent.triggerevent("pfc_save")
end event

type cb_close from commandbutton within w_recruitment_settings
integer x = 1851
integer y = 24
integer width = 343
integer height = 92
integer taborder = 20
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

type dw_detail from u_dw within w_recruitment_settings
integer x = 5
integer y = 136
integer width = 2217
integer height = 1372
integer taborder = 10
string dataobject = "d_recruit_settings"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.settransobject(sqlca)
end event

event buttonclicked;call super::buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	value    long        row
// 	value    long        actionreturncode
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.05.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_user_id

if dwo.name = 'b_email' then
		ls_user_id = this.getitemstring( 1,'office_email')
		if not isNull(ls_user_id) then
			//openWithParm(w_email_account_edit,"PERSONAL|" + ls_user_id)
			OpenWithParm(w_email_account_edit,"RECRUIT|" + ls_user_id) //alfee 10.24.2015
		end if	
end if

 //Start Code Change ----08.10.2015 #V15 maha
if dwo.name = 'b_types' then
	open(w_image_type_painter)
end if
end event

