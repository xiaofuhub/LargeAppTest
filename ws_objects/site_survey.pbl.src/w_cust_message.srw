$PBExportHeader$w_cust_message.srw
forward
global type w_cust_message from window
end type
type p_3 from picture within w_cust_message
end type
type p_2 from picture within w_cust_message
end type
type p_1 from picture within w_cust_message
end type
type ln_1 from line within w_cust_message
end type
type ln_2 from line within w_cust_message
end type
end forward

global type w_cust_message from window
integer width = 2592
integer height = 704
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
event ue_ok ( )
event ue_cancel ( )
event ue_yes ( )
event ue_no ( )
event ue_retry ( )
event ue_abort ( )
event ue_ignore ( )
event ue_showhelp ( )
p_3 p_3
p_2 p_2
p_1 p_1
ln_1 ln_1
ln_2 ln_2
end type
global w_cust_message w_cust_message

type variables
public:
constant integer 		Firstbutton_x = 2171
constant integer 		Firstbutton_Y = 520
constant integer 		Movewidth = 360
constant integer 		Size = 353
integer		ii_buttonclicked
u_cst_message_struct iu_message


end variables

forward prototypes
public function string f_replace_rn (string as_string)
end prototypes

event ue_ok();ii_buttonclicked=1
closewithreturn(this,ii_buttonclicked)
end event

event ue_cancel();ii_buttonclicked=2
closewithreturn(this,ii_buttonclicked)
end event

event ue_yes();ii_buttonclicked=3
closewithreturn(this,ii_buttonclicked)
end event

event ue_no();ii_buttonclicked=4
closewithreturn(this,ii_buttonclicked)
end event

event ue_retry();ii_buttonclicked=5
closewithreturn(this,ii_buttonclicked)

end event

event ue_abort();ii_buttonclicked=6
closewithreturn(this,ii_buttonclicked)
end event

event ue_ignore();ii_buttonclicked=7
closewithreturn(this,ii_buttonclicked)
end event

event ue_showhelp();String  lstr_url,ls_downurl
Integer li_pos
inet linet_help
IF appeongetclienttype() = 'WEB' THEN
	
	//	lstr_url = appeongetieurl()
	//	li_pos = Pos(lstr_url, '?')
	//	IF li_pos > 0 THEN
	//		lstr_url = Left(lstr_url, li_pos - 1)
	//	END IF
	//	
	//	// Remove 'application.htm' from the end 
	//	li_pos = Pos(lstr_url, 'application.htm')
	//	IF li_pos > 0 THEN
	//		lstr_url = Left(lstr_url, li_pos - 1)
	//	END IF
	//	
	//	// Add '/' to the end if missing
	//	IF Right(lstr_url, 1) <> '/' THEN
	//		lstr_url = lstr_url + '/'
	//	END IF
	//	
	//
	SELECT Top 1 downloadurl Into :ls_downurl From icred_settings;
	IF LenA(ls_downurl) > 0 THEN
		linet_help = Create inet
		IF iu_message.msgfind = '0' THEN
			linet_help.HyperLinkToURL(ls_downurl+'help\html\'+'index.htm')
		ELSE
			linet_help.HyperLinkToURL(ls_downurl+'help\html\'+Trim(iu_message.msgid) +'.htm')
		END IF
		Destroy linet_help
	ELSE
		MessageBox("Error","Tring get help file path Failed.")
	END IF
ELSE
	IF iu_message.msgfind = '0' THEN
		ShowHelp(Gs_Current_Directory+"\help\Intellihelp.chm", Index!)
	ELSE
		ShowHelp(Gs_Current_Directory+"\help\Intellihelp.chm", Keyword!, Trim(iu_message.msgid))
	END IF
END IF







end event

public function string f_replace_rn (string as_string);//long li_pos
//do
//  li_pos=pos(as_string,'~r~n')
//  as_string=replace(as_string,li_pos,4,'+"~r~n"+')
//loop until li_pos=0
//
return as_string
end function

on w_cust_message.create
this.p_3=create p_3
this.p_2=create p_2
this.p_1=create p_1
this.ln_1=create ln_1
this.ln_2=create ln_2
this.Control[]={this.p_3,&
this.p_2,&
this.p_1,&
this.ln_1,&
this.ln_2}
end on

on w_cust_message.destroy
destroy(this.p_3)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.ln_1)
destroy(this.ln_2)
end on

event open;Integer i , j,ll_count
u_dyn_struct parm[]
u_dyn_cb uo_placed[3]

//add picturename
p_1.picturename=gs_current_path+"\"+"helpicon.gif"
p_2.picturename=gs_current_path+"\"+"copy.gif"
//get message
if isvalid(message.powerobjectparm) then iu_message=message.powerobjectparm
//button
CHOOSE CASE iu_message.msgbutton
	CASE 'OK'
		parm[1].code = 1
		parm[1].Label = '&OK'
		parm[1].Clicked = 'ue_ok'
	CASE 'OKCancel'
		parm[1].code = 1
		parm[1].Label = '&OK'
		parm[1].Clicked = 'ue_ok'
		
		parm[2].code = 2
		parm[2].Label = '&Cancel'
		parm[2].Clicked = 'ue_cancel'
	CASE 'YesNo'
		parm[1].code = 3
		parm[1].Label = '&Yes'
		parm[1].Clicked = 'ue_yes'
		
		parm[2].code = 4
		parm[2].Label = '&No'
		parm[2].Clicked = 'ue_No'
	CASE 'YesNoCancel'
		parm[1].code = 3
		parm[1].Label = '&Yes'
		parm[1].Clicked = 'ue_yes'
		
		parm[2].code = 4
		parm[2].Label = '&No'
		parm[2].Clicked = 'ue_No'
		
		parm[3].code = 2
		parm[3].Label = '&Cancel'
		parm[3].Clicked = 'ue_cancel'
	CASE 'RetryCancel'
		parm[1].code = 5
		parm[1].Label = '&Retry'
		parm[1].Clicked = 'ue_retry'
		
		parm[2].code = 2
		parm[2].Label = '&Cancel'
		parm[2].Clicked = 'ue_cancel'
	CASE 'AbortRetryIgnore'
		parm[1].code = 5
		parm[1].Label = '&Retry'
		parm[1].Clicked = 'ue_retry'
		
		parm[2].code = 6
		parm[2].Label = '&Abort'
		parm[2].Clicked = 'ue_abort'
		
		parm[3].code = 7
		parm[3].Label = '&Ignore'
		parm[3].Clicked = 'ue_Ignore'
	CASE ELSE
		/*statementblock*/
END CHOOSE
//icon
Choose Case iu_message.msgicon
		Case 'Information'
			p_3.picturename =gs_current_path+"\"+ 'info.gif' 
		Case 'StopSign'
			p_3.picturename =gs_current_path+"\"+ 'error.gif' 
		Case 'Exclamation'
			p_3.picturename =gs_current_path+"\"+ 'warning.gif' 
		Case 'Question'
			p_3.picturename =gs_current_path+"\"+ 'quest.bmp' 
		case else
			p_3.visible=false
End Choose
//default
Choose Case iu_message.msgdefaultbutton
		Case 1
			parm[1].default=true
		Case 2
			parm[2].default=true
		Case 3
			parm[3].default=true
End Choose

j = Firstbutton_x
ll_count = UpperBound(parm)
FOR i = ll_count To 1 Step -1
	parm[i].win = This
	parm[i].size = Size
	OpenUserObjectWithParm(uo_placed[i],parm[i] , j , Firstbutton_Y)
	j = j -Movewidth
NEXT




end event

type p_3 from picture within w_cust_message
integer x = 78
integer y = 84
integer width = 146
integer height = 128
boolean originalsize = true
boolean focusrectangle = false
end type

type p_2 from picture within w_cust_message
integer x = 174
integer y = 540
integer width = 110
integer height = 96
boolean originalsize = true
end type

type p_1 from picture within w_cust_message
integer x = 50
integer y = 540
integer width = 110
integer height = 96
boolean originalsize = true
boolean map3dcolors = true
end type

event clicked;Parent.TriggerEvent("ue_showhelp")
end event

type ln_1 from line within w_cust_message
integer linethickness = 4
integer beginx = 14
integer beginy = 500
integer endx = 2583
integer endy = 500
end type

type ln_2 from line within w_cust_message
long linecolor = 16777215
integer linethickness = 4
integer beginx = 14
integer beginy = 504
integer endx = 2583
integer endy = 504
end type

