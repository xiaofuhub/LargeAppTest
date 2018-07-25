$PBExportHeader$w_app_delete_message.srw
forward
global type w_app_delete_message from window
end type
type st_5 from statictext within w_app_delete_message
end type
type st_4 from statictext within w_app_delete_message
end type
type rb_cancel from radiobutton within w_app_delete_message
end type
type rb_orph from radiobutton within w_app_delete_message
end type
type rb_delete from radiobutton within w_app_delete_message
end type
type rb_conn from radiobutton within w_app_delete_message
end type
type cb_2 from commandbutton within w_app_delete_message
end type
type st_what from statictext within w_app_delete_message
end type
type st_3 from statictext within w_app_delete_message
end type
type st_2 from statictext within w_app_delete_message
end type
type st_1 from statictext within w_app_delete_message
end type
type gb_1 from groupbox within w_app_delete_message
end type
end forward

global type w_app_delete_message from window
integer x = 1056
integer y = 484
integer width = 2199
integer height = 1404
boolean titlebar = true
string title = "Delete Application/Payor"
windowtype windowtype = response!
long backcolor = 33551856
st_5 st_5
st_4 st_4
rb_cancel rb_cancel
rb_orph rb_orph
rb_delete rb_delete
rb_conn rb_conn
cb_2 cb_2
st_what st_what
st_3 st_3
st_2 st_2
st_1 st_1
gb_1 gb_1
end type
global w_app_delete_message w_app_delete_message

type variables
long il_appid
end variables

on w_app_delete_message.create
this.st_5=create st_5
this.st_4=create st_4
this.rb_cancel=create rb_cancel
this.rb_orph=create rb_orph
this.rb_delete=create rb_delete
this.rb_conn=create rb_conn
this.cb_2=create cb_2
this.st_what=create st_what
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.st_5,&
this.st_4,&
this.rb_cancel,&
this.rb_orph,&
this.rb_delete,&
this.rb_conn,&
this.cb_2,&
this.st_what,&
this.st_3,&
this.st_2,&
this.st_1,&
this.gb_1}
end on

on w_app_delete_message.destroy
destroy(this.st_5)
destroy(this.st_4)
destroy(this.rb_cancel)
destroy(this.rb_orph)
destroy(this.rb_delete)
destroy(this.rb_conn)
destroy(this.cb_2)
destroy(this.st_what)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;long cnt1
long cnt2
long cnt3
long cnt4
long cnt5  //maha 05.21.2014
integer e = 0
debugbreak()
il_appid = message.doubleparm

if il_appid < 1 then
	e = 1
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-01
	//$<modify> 01.13.2006 By: Wang Chao
	//$<reason> The GOTO statement is unsupported currently.
	//$<modification> Directly copy the script associated with the label here.
	//goto error
	If e = 1 Then
		CloseWithReturn(This, 1)
	End If
	//---------------------------- APPEON END ----------------------------
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 04.03.2006 By: Rodger Wu
//$<reason> Performance Tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
select count(app_id) into :cnt1 from sys_multi_app where app_id = :il_appid;
select count(app_id) into :cnt2 from net_dev_action_items where app_id = :il_appid;
select count(app_id) into :cnt3 from net_dev_ids where app_id = :il_appid;
*/
gnv_appeondb.of_StartQueue()
select count(app_id) into :cnt1 from sys_multi_app where app_id = :il_appid;
select count(app_id) into :cnt2 from net_dev_action_items where app_id = :il_appid;
select count(app_id) into :cnt3 from net_dev_ids where app_id = :il_appid;
select count(app_id) into :cnt4 from pd_appl_tracking where app_id = :il_appid;  //Start Code Change ----01.08.2014 #V14 maha - added
select count(app_id) into :cnt5 from app_template_items where app_id = :il_appid; //Start Code Change ----05.21.2014 #V14.2 maha
gnv_appeondb.of_CommitQueue()
//---------------------------- APPEON END ----------------------------

if cnt1 < 1 and cnt2 < 1 and cnt3 < 1 and cnt4 < 1 and cnt5 < 1 then  //Start Code Change ----05.21.2014 #V14 maha
	e = 1
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-02
	//$<modify> 01.13.2006 By: Wang Chao
	//$<reason> The GOTO statement is unsupported currently.
	//$<modification> Directly copy the script associated with the label here.
	//goto error
	If e = 1 Then
		CloseWithReturn(This, 2)  //Start Code Change ----06.30.2016 #V152 maha -  changed value to 2
	End If
	//---------------------------- APPEON END ----------------------------
else
	st_1.text = "There are " + string(cnt1) + " Multiapp Template records connected to this Application/Payor."
	st_2.text = "There are " + string(cnt2) + " Application Action Items connected to this Application/Payor."
	st_3.text = "There are " + string(cnt3) + " IDs records connected to this Application/Payor."
	st_4.text = "There are " + string(cnt4) + " Application Tracking records connected to this Application/Payor."
	st_5.text = "There are " + string(cnt5) + " Application Template records connected to this Application/Payor."  //Start Code Change ----05.21.2014 #V14 maha
end if


 //Start Code Change ----03.13.2015 #V15 maha
 if w_mdi.of_security_access (7791) = 0 then
	rb_delete.visible = false
end if

end event

type st_5 from statictext within w_app_delete_message
integer x = 50
integer y = 484
integer width = 2107
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "There are  Template records connected to this Application."
boolean focusrectangle = false
end type

type st_4 from statictext within w_app_delete_message
integer x = 50
integer y = 376
integer width = 2107
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "There are  Tracking records connected to this Application."
boolean focusrectangle = false
end type

type rb_cancel from radiobutton within w_app_delete_message
integer x = 233
integer y = 1004
integer width = 1490
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "CANCEL deleting the Application/Payor."
boolean checked = true
end type

type rb_orph from radiobutton within w_app_delete_message
boolean visible = false
integer x = 50
integer y = 1420
integer width = 1865
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Leave these records as they are, and CONTINUE deleting Application/Payor."
end type

type rb_delete from radiobutton within w_app_delete_message
integer x = 233
integer y = 924
integer width = 1490
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "DELETE all of these records and the Application/Payor."
end type

type rb_conn from radiobutton within w_app_delete_message
integer x = 233
integer y = 836
integer width = 1490
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "CONNECT them to a different Application/Payor."
end type

type cb_2 from commandbutton within w_app_delete_message
integer x = 846
integer y = 1152
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Continue"
end type

event clicked;integer c
integer res
integer ret
string ls_mess
string ls_app
long ll_newid

if rb_conn.checked then
	c = 1
	
elseif rb_delete.checked then
	c = 2
elseif rb_orph.checked then
	c = 3
elseif rb_cancel.checked then
	c = 4
else
	messagebox("Action?","Please Choose an action.")
	return 
end if

//select count(app_id) into :cnt1 from sys_multi_app where app_id = :il_appid;
//select count(app_id) into :cnt2 from net_dev_action_items where app_id = :il_appid;
//select count(app_id) into :cnt3 from net_dev_ids where app_id = :il_appid;


choose case c
	case 1
		open(w_select_application)
		ll_newid = message.doubleparm
		if ll_newid < 1 then
			return
		elseif ll_newid = il_appid then
			messagebox("Action?","You have selected the same application.  Please select and other application or another option")
			return
		else
			ls_mess = "Are you sure you wish to connect these records to the new Application/Payor?"
			res = messagebox("Update?",ls_mess,question!,yesno!,2)
			if res = 2 then
				return
			else
				update sys_multi_app set app_id = :ll_newid where app_id = :il_appid;
				update net_dev_action_items set app_id = :ll_newid where app_id = :il_appid;
				update net_dev_ids set app_id = :ll_newid where app_id = :il_appid;
				update pd_appl_tracking set app_id = :ll_newid where app_id = :il_appid;
				update app_template_items set app_id = :ll_newid where app_id = :il_appid;  //Start Code Change ----05.21.2014 #V14.2 maha
				commit using sqlca;
				closewithreturn(parent, 1)
			end if
		end if
	case 2
		ls_mess = "Are you sure you wish to delete all of these connected records?"
		res = messagebox("Delete?",ls_mess,question!,yesno!,2)
		if res = 2 then
			return
		else
			delete from sys_multi_app where app_id = :il_appid;
			delete from net_dev_action_items where app_id = :il_appid;
			delete from net_dev_ids where app_id = :il_appid;	
			delete from pd_appl_tracking where app_id = :il_appid;	
			delete from app_template_items where app_id = :il_appid;	//Start Code Change ----05.21.2014 #V14.2 maha
			commit using sqlca;
			closewithreturn(parent, 1)
		end if
	case 3  //not a selectable option (orphan)
		ls_mess = "Are you sure you wish to delete the Application/Payor and leave all of these connected records as they are?~rIf you do so, you will have to delete or update them individually later."
		res = messagebox("Delete?",ls_mess,question!,yesno!,2)
		if res = 2 then
			return
		else
			//Start Code Change ---- 04.27.2006 #430 maha
			//delete from sys_multi_app where app_id = :il_appid;
			//delete from net_dev_action_items where app_id = :il_appid;
			//delete from net_dev_ids where app_id = :il_appid;	
			//commit using sqlca;
			//End Code Change---04.27.2006
			//closewithreturn(parent, 1)
		end if		
	case 4
		closewithreturn(parent, -1)
		
end choose





//closewithreturn(parent, ret )
end event

type st_what from statictext within w_app_delete_message
integer x = 55
integer y = 684
integer width = 2107
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "What do you wish to do with these records?"
boolean focusrectangle = false
end type

type st_3 from statictext within w_app_delete_message
integer x = 50
integer y = 272
integer width = 2107
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "There are  IDs records connected to this Application."
boolean focusrectangle = false
end type

type st_2 from statictext within w_app_delete_message
integer x = 50
integer y = 152
integer width = 2107
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "There are  Action Items records connected to this Application."
boolean focusrectangle = false
end type

type st_1 from statictext within w_app_delete_message
integer x = 50
integer y = 44
integer width = 2107
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "There are  Multiapp records connected to this Application/Payor."
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_app_delete_message
integer x = 41
integer y = 780
integer width = 2094
integer height = 340
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Option"
end type

