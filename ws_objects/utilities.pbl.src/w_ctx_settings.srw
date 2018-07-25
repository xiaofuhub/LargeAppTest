$PBExportHeader$w_ctx_settings.srw
forward
global type w_ctx_settings from window
end type
type sle_downloadurl from singlelineedit within w_ctx_settings
end type
type st_downloadurl from statictext within w_ctx_settings
end type
type cb_brow4 from commandbutton within w_ctx_settings
end type
type cb_contract_path from commandbutton within w_ctx_settings
end type
type dw_users from datawindow within w_ctx_settings
end type
type dw_departments from datawindow within w_ctx_settings
end type
type cb_brow3 from commandbutton within w_ctx_settings
end type
type cb_brow1 from commandbutton within w_ctx_settings
end type
type cb_brow2 from commandbutton within w_ctx_settings
end type
type dw_2 from datawindow within w_ctx_settings
end type
type cb_other_set from commandbutton within w_ctx_settings
end type
type cb_2 from commandbutton within w_ctx_settings
end type
type cb_1 from commandbutton within w_ctx_settings
end type
type gb_1 from groupbox within w_ctx_settings
end type
type dw_1 from datawindow within w_ctx_settings
end type
end forward

global type w_ctx_settings from window
integer x = 677
integer y = 48
integer width = 2674
integer height = 2588
boolean titlebar = true
string title = "Application Settings"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
sle_downloadurl sle_downloadurl
st_downloadurl st_downloadurl
cb_brow4 cb_brow4
cb_contract_path cb_contract_path
dw_users dw_users
dw_departments dw_departments
cb_brow3 cb_brow3
cb_brow1 cb_brow1
cb_brow2 cb_brow2
dw_2 dw_2
cb_other_set cb_other_set
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
dw_1 dw_1
end type
global w_ctx_settings w_ctx_settings

forward prototypes
public function integer of_dept_security ()
public function integer of_pre_update ()
public subroutine of_synchronize_data ()
end prototypes

public function integer of_dept_security ();Integer li_value
Integer li_ans
Integer li_access
Integer li_rec_cnt
Long ll_department
long ll_security_dept_code
long ll_ec
long ll_e
long ll_new
long ll_find
String ls_user_id
string ls_find
n_ds lds_existing
n_ds lds_new

//


		SELECT Count( user_id )
		INTO :li_rec_cnt
		FROM security_user_department;
		IF SQLCA.SQLCODE = -1 THEN
			MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
			RETURN -1
		END IF
		
select max(user_depart_id) into :ll_security_dept_code from security_user_department;
if isnull(ll_security_dept_code) then ll_security_dept_code = 0
		
li_ans = MessageBox( "Department Security", "Are you sure you want to turn the department security feature on?",  question!, YesNo!, 1 )
		
//maha 012606 datastores for testing for and adding records
lds_existing = CREATE n_ds
lds_existing.dataobject = "d_dept_security_all"
lds_existing.settransobject(sqlca)

lds_new = CREATE n_ds
lds_new.dataobject = "d_dept_security_all"
lds_new.settransobject(sqlca)
//debugbreak()
		//if going to turn on then need to scan through departments and create user department security table
IF li_ans = 1 THEN
	Integer li_dept_cnt
	Integer li_user_cnt
	Integer d
	Integer u
	
	gi_dept_security = 1  //Start Code Change ----04.09.2008 #V8 maha - set variable when making this change
	
	li_ans = MessageBox("Access", "Do you want the default department access for all new created records to be turned on?", Question!, YesNo!, 1 )
		IF li_ans = 1 THEN
		li_access = 1
	ELSE
		li_access = 0
	END IF
	
	IF li_access = 0 THEN
		li_ans = MessageBox( "No Access", "When your users login they will have no access to physician data until you go to the User Painter and Grant access to specific departments for each user.", information!, OkCancel!, 1 )
		IF li_ans = 2 THEN
			RETURN -1
		END IF
	END IF
	
	dw_departments.SetTransObject( SQLCA )
	li_dept_cnt = dw_departments.Retrieve( )
	
	dw_users.SetTransObject( SQLCA )
	li_user_cnt = dw_users.Retrieve( )
	
	ll_ec = lds_existing.retrieve() 
	
	//Loop through all users and department and setup department security
	FOR u = 1 TO li_user_cnt
		ls_user_id = dw_users.GetItemString( u, "user_id" )
		FOR d = 1 TO li_dept_cnt
			//ll_security_dept_code ++
			ll_department = dw_departments.GetItemNumber( d, "lookup_code" )
			ls_find = "user_id = '" + ls_user_id + "' and department_id = " + string(ll_department)
			ll_find = lds_existing.Find ( ls_find, 1, ll_ec )
			
			if ll_find = 0 then
				ll_security_dept_code ++
				ll_new = lds_new.insertrow(0)
				lds_new.setitem(ll_new,"user_depart_id",ll_security_dept_code)
				lds_new.setitem(ll_new,"user_id",ls_user_id)
				lds_new.setitem(ll_new,"department_id",ll_department)
				lds_new.setitem(ll_new,"access_rights",li_access)
			elseif ll_find < 0 then
				messagebox("Find error",ls_find)
				return -1
			end if		
			
					
		END FOR
			
	END FOR
			//debugbreak()
	ll_find = lds_new.update()
	if ll_find < 1 then
		rollback;
	else
		COMMIT USING SQLCA;
	end if
	MessageBox( "Department Security", "Department Security data updated.  Go to System->Painters->User Painter to edit access." )  //Start Code Change ----04.09.2008 #V8 maha - moved from outside of if statement

	
else //Start Code Change ----04.09.2008 #V8 maha - reset the value is user says no.
	dw_1.setitem(1,"set_37", 0)
			
END IF
		
destroy lds_existing
destroy lds_new
		

return 1
end function

public function integer of_pre_update ();//Start Code Change ---- 03.01.2006 #303 maha
//function created maha 030106 for \\ checking of path
string s
integer i
string ls_field

dw_2.accepttext()
if dw_2.getitemstatus( 1, 0, primary!) = datamodified! then
	for i = 1 to 5
		choose case i
			case 1
				ls_field = "intelliapp_app_path"
			case 2
				ls_field = "imaging_path"
			case 3
				ls_field = "picture_path"
			case 4
				ls_field = "letter_save_path"
			case 5
				ls_field = "contract_path"
		end choose
		//if dw_2.getitemstatus( 1, i, primary!) = datamodified! then
			s = dw_2.getitemstring(1,ls_field)
			//messagebox("out",s)
			s = of_check_path(s,1)
			//messagebox("in",s)
			dw_2.setitem(1,ls_field,s)
		//end if
	next
end if

//Start Code Change ----07.28.2014 #V14.2 maha - copied/modified from the general settings window.
If dw_1.getitemstatus(1, 'showezmenu',primary!) = NewModified! Or  dw_1.getitemstatus(1, 'showezmenu',primary!) = DataModified!	Then//added by gavins 20130313
		integer r
		r = dw_1.GetitemNumber( 1,'showezmenu')
		If r = 1 Then
			gb_show_EZMenu  = True
		Else
			gb_show_EZMenu = False
		End If
		if gb_show_EZMenu then
//			gnv_user_option.of_Set_option_value(gs_user_id, "EZMENU_SHOW","1" )
			gnv_user_option.of_Set_option_value("intellisoft-super-master", "EZMENU_SHOW","1" )//modify by gavins 20130524
		else
			gnv_user_option.of_Set_option_value("intellisoft-super-master", "EZMENU_SHOW","0" ) //(Appeon)Harry 05.28.2014 - V142 ISG-CLX  modify "Contractlogix" to "intellisoft"
//			gnv_user_option.of_Set_option_value(gs_user_id, "EZMENU_SHOW","0" )
		end if		
		gnv_user_option.of_save( )

		If isvalid(w_mdi) Then 
			w_mdi.of_showezmenu( gb_show_EZMenu )
			w_mdi.event ue_RefreshEZMenu( )
		End If
end if
//End Code Change ----07.28.2014

return 1
//End Code Change---03.01.2006
end function

public subroutine of_synchronize_data ();//////////////////////////////////////////////////////////////////////
// $<function>w_icred_settings::of_synchronize_data()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> After modified data, synchronize it.
//////////////////////////////////////////////////////////////////////
// $<add> 08.27.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

gnv_session.ii_session_refresh_frequency  = dw_1.getitemnumber(1,'session_refresh_frequency') //Added By Ken.Guo 08.27.2008


//Begin - Added By Mark Lee 12/05/2012
gi_test_mode = dw_1.getitemnumber(1,'set_10')

gi_scan_format = dw_1.getitemnumber(1,'set_29')

gi_email_type = dw_1.getitemnumber(1,'set_56')
//End - Added By Mark Lee 12/05/2012


end subroutine

on w_ctx_settings.create
this.sle_downloadurl=create sle_downloadurl
this.st_downloadurl=create st_downloadurl
this.cb_brow4=create cb_brow4
this.cb_contract_path=create cb_contract_path
this.dw_users=create dw_users
this.dw_departments=create dw_departments
this.cb_brow3=create cb_brow3
this.cb_brow1=create cb_brow1
this.cb_brow2=create cb_brow2
this.dw_2=create dw_2
this.cb_other_set=create cb_other_set
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.dw_1=create dw_1
this.Control[]={this.sle_downloadurl,&
this.st_downloadurl,&
this.cb_brow4,&
this.cb_contract_path,&
this.dw_users,&
this.dw_departments,&
this.cb_brow3,&
this.cb_brow1,&
this.cb_brow2,&
this.dw_2,&
this.cb_other_set,&
this.cb_2,&
this.cb_1,&
this.gb_1,&
this.dw_1}
end on

on w_ctx_settings.destroy
destroy(this.sle_downloadurl)
destroy(this.st_downloadurl)
destroy(this.cb_brow4)
destroy(this.cb_contract_path)
destroy(this.dw_users)
destroy(this.dw_departments)
destroy(this.cb_brow3)
destroy(this.cb_brow1)
destroy(this.cb_brow2)
destroy(this.dw_2)
destroy(this.cb_other_set)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-03-17 By: Scofield
//$<Reason> Insert a blank row for addresser.

DataWindowChild	ldw_Child

dw_1.GetChild('set_addresser',ldw_Child)
ldw_Child.InsertRow(1)
//---------------------------- APPEON END ----------------------------

dw_2.settransobject(sqlca)
dw_2.retrieve()

//---------Begin Added by (Appeon)Harry 08.20.2014 for BugH081901--------
if of_get_app_setting("set_9", "I") <> 4 then
	dw_1.modify("showezmenu.visible='0' t_72.visible='0' ")
end if
//---------End Added ------------------------------------------------------

If  gb_show_EZMenu  Then
	dw_1.SetItem( 1, 'showezmenu'  , 1 )
//---------Begin Added by (Appeon)Harry 09.04.2014 for V142 ISG-CLX--------
else
	dw_1.SetItem( 1, 'showezmenu'  , 0 )
//---------End Added ------------------------------------------------------
End If

end event

event closequery;// (Appeon)Harry 07.03.2013 - V141 ISG-CLX
if isvalid (w_icred_settings) then
	w_icred_settings.dw_1.retrieve()
end if
end event

type sle_downloadurl from singlelineedit within w_ctx_settings
integer x = 485
integer y = 2328
integer width = 2016
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;//////////////////////////////////////////////////////////////////////
// $<event>  Modified()
// $<arguments> None
// $<returns>   Long
// $<description> Set DownloadURL colomn value
//////////////////////////////////////////////////////////////////////
// $<add> 2008-11-13 by Scofield
//////////////////////////////////////////////////////////////////////

String	ls_DownLoadURL
long		ll_Row

ll_Row = dw_1.RowCount()
if ll_Row <= 0 or ll_Row > dw_1.RowCount() then Return

ls_DownLoadURL = Trim(sle_DownLoadURL.Text)
if ls_DownLoadURL <> "" and Right(ls_DownLoadURL,1) <> "/" then ls_DownLoadURL += "/"

dw_1.SetItem(ll_Row,"DownloadURL",ls_DownLoadURL)

end event

type st_downloadurl from statictext within w_ctx_settings
integer x = 55
integer y = 2344
integer width = 416
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Download URL:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_brow4 from commandbutton within w_ctx_settings
boolean visible = false
integer x = 2286
integer y = 2148
integer width = 251
integer height = 80
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Browse"
end type

event clicked;
// mskinner 19 aug 2005 -- begin
//string docname, named, path
//
//integer value
//
//value = GetFilesaveName("Select Directory and enter 'Path' as file name",&
//+ docname, named, "DOC", &
//	+ "text Files (*.txt),*.txt")
//
//
//IF value = 1 THEN
//	path = mid(docname,1,pos(docname,named,1) - 1)
//	dw_2.setitem(1,"picture_path",path)
//END IF


string ls_path 

ls_path =  f_browseforfolder('This is used primarily for Citrix setups. Please select a folder where letters wil be saved when run.' ,handle(parent)) 


if f_validstr(ls_path)  then 
    dw_2.object.letter_save_path[1] = ls_path  +"\"
end if
end event

type cb_contract_path from commandbutton within w_ctx_settings
boolean visible = false
integer x = 2286
integer y = 2240
integer width = 251
integer height = 80
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Browse"
end type

event clicked;/******************************************************************************************************************
**  [PUBLIC]   : event CLICKED!
**==================================================================================================================
**  Purpose   	: Gets the path from the user,sets the contract path
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 19 August 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

string ls_path 

ls_path =  f_browseforfolder('Please select a folder where you will be storing contract image files.' ,handle(parent))

if f_validstr(ls_path)  then 
   dw_2.object.contract_path[1] = ls_path  +"\"
	// set the path
   //GNV_app.of_set_contract_path(ls_path  +"\" )
end if
end event

type dw_users from datawindow within w_ctx_settings
boolean visible = false
integer x = 41
integer y = 16
integer width = 279
integer height = 108
integer taborder = 30
string dataobject = "d_user_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_departments from datawindow within w_ctx_settings
boolean visible = false
integer x = 325
integer y = 16
integer width = 224
integer height = 108
integer taborder = 20
string dataobject = "d_all_departments"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_brow3 from commandbutton within w_ctx_settings
boolean visible = false
integer x = 2286
integer y = 2056
integer width = 251
integer height = 80
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Browse"
end type

event clicked;
// mskinner 19 aug 2005 -- begin
//string docname, named, path
//
//integer value
//
//value = GetFilesaveName("Select Directory and enter 'Path' as file name",&
//+ docname, named, "DOC", &
//	+ "text Files (*.txt),*.txt")
//
//
//IF value = 1 THEN
//	path = mid(docname,1,pos(docname,named,1) - 1)
//	dw_2.setitem(1,"picture_path",path)
//END IF


string ls_path 

ls_path =  f_browseforfolder('Please select a folder where you will be storing the practitioner picture.' ,handle(parent)) 


if f_validstr(ls_path)  then 
    dw_2.object.picture_path[1] = ls_path  +"\"
end if
end event

type cb_brow1 from commandbutton within w_ctx_settings
boolean visible = false
integer x = 2286
integer y = 1872
integer width = 251
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Browse"
end type

event clicked;//string docname, named, path
//
//integer value
//
//value = GetFilesaveName("Select Directory and enter 'Path' as file name",&
//+ docname, named, "DOC", &
//	+ "text Files (*.txt),*.txt")
//
//
//IF value = 1 THEN
//	path = mid(docname,1,pos(docname,named,1) - 1)
//	dw_2.setitem(1,"intelliapp_app_path",path)
//END IF



string ls_path 

ls_path = f_browseforfolder('Please select a folder where you will be storing applications.' ,handle(parent))

if f_validstr(ls_path)  then 

dw_2.object.intelliapp_app_path[1] = ls_path  +"\"

end if

end event

type cb_brow2 from commandbutton within w_ctx_settings
boolean visible = false
integer x = 2286
integer y = 1964
integer width = 251
integer height = 80
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Browse"
end type

event clicked;//string docname, named, path
//
//integer value
//
//value = GetFilesaveName("Select Directory and enter 'Path' as file name",&
//+ docname, named, "DOC", &
//	+ "text Files (*.txt),*.txt")
//
//
//IF value = 1 THEN
//	path = mid(docname,1,pos(docname,named,1) - 1)
//	dw_2.setitem(1,"imaging_path",path)
//END IF



string ls_path 

ls_path = f_browseforfolder('Please select a folder where you will be storing practitioner image files.' ,handle(parent))


if f_validstr(ls_path)  then 

dw_2.object.imaging_path[1] = ls_path  +"\"

end if


end event

type dw_2 from datawindow within w_ctx_settings
boolean visible = false
integer x = 50
integer y = 1852
integer width = 2249
integer height = 488
integer taborder = 40
string dataobject = "d_util_paths"
boolean border = false
boolean livescroll = true
end type

event updateend;


GNV_app.of_set_contract_path(dw_2.object.contract_path[1] )
end event

type cb_other_set from commandbutton within w_ctx_settings
integer x = 1477
integer y = 28
integer width = 453
integer height = 88
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Support Settings"
end type

event clicked;Open(w_utilities_support)

end event

type cb_2 from commandbutton within w_ctx_settings
integer x = 2277
integer y = 28
integer width = 302
integer height = 88
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
boolean cancel = true
end type

event clicked;gds_settings.retrieve()
close(parent)
end event

type cb_1 from commandbutton within w_ctx_settings
integer x = 1952
integer y = 28
integer width = 302
integer height = 88
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;//Start Code Change ---- 03.01.2006 #304 maha
of_pre_update()
//End Code Change---03.01.2006
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 04.03.2006 By: Liang QingShi
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------
dw_1.update()
dw_2.update()
commit using sqlca;

dw_2.retrieve()

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 04.03.2006 By: Liang QingShi
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gds_settings.retrieve()
gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------


of_synchronize_data() //Added By Ken.Guo 08.27.2008

gnv_data.of_retrieve("icred_settings")

end event

type gb_1 from groupbox within w_ctx_settings
integer x = 41
integer y = 2264
integer width = 2542
integer height = 188
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Program Paths"
end type

type dw_1 from datawindow within w_ctx_settings
integer x = 46
integer y = 136
integer width = 2533
integer height = 2096
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_ctx_set"
boolean vscrollbar = true
boolean livescroll = true
end type

event itemchanged;Integer li_value
Integer li_ans
Integer li_access
Integer li_rec_cnt
Long ll_department
Integer ll_security_dept_code
String ls_user_id


//Added By Ken.Guo 2010-08-18. Popup Warning Message and Set Default Group Template.
Long ll_default_id
DatawindowChild ldwc_group_templates
this.accepttext( )					//Added By Mark Lee 12/05/2012
dw_1.getChild('group_email_template',ldwc_group_templates)
Choose Case dwo.name
	Case 'email_alarm_type'
		If data = '2' Then //Group Email Alarm
			If Messagebox('Email Alarm Settings','If you change to Group Alarms that any Date Alarm Emails settings will not be used, but instead the Grouped Email Alarm Template message will be used. ~r~n~r~nAre you sure to make the big change?', Question!, Yesno!) = 2 Then
				This.Post SetItem(Row,'email_alarm_type',1)
			Else
				If Isnull(This.GetItemNumber(Row,'group_email_template') ) Then
					If ldwc_group_templates.RowCount() = 0 Then
						If Messagebox('Email Alarm Settings','There is no Group Email Alarm Template yet, do you want to create it now?', Question!, yesno!)  = 1 Then
							OpenWithParm(w_email_add,'Group_Add')
							If Message.Doubleparm > 0 Then
								ldwc_group_templates.SetTransObject(SQLCA)
								ldwc_group_templates.Retrieve()
								This.SetItem(Row,'group_email_template',Message.Doubleparm)
								This.Post SetColumn('group_email_template')
							End If
						End If
					Else
						Select email_id Into :ll_default_id from wf_email Where email_name = :gs_default_group_name;
						If ldwc_group_templates.Find('Email_id = ' + String(ll_default_id), 1,ldwc_group_templates.RowCount() ) > 0 Then
							This.SetItem(Row,'group_email_template',ll_default_id)
						Else
							Messagebox('Email Alarm Settings','Plase select a Group Email Alarm Template.')	
							This.Post SetColumn('group_email_template')
						End If
					End If
				End If
			End If				
		End If
		//Begin - Added By Mark Lee 08/09/12
	Case 'https'
		If data = '1' Then
			Messagebox('Access Alarm Settings','Please make sure IntelliSoft web site supports HTTPS.~r~n If the web site doesn’t support HTTPS, ~r~n you will not be able to access the entire IntelliSoft system any more.')	
		End If
		//End - Added By Mark Lee 08/09/12
	//Begin - Added By Mark Lee 11/05/2012
	Case 'set_56'
		If data = '1' Then
			this.event buttonclicked( row,0, this.object.b_email_setting)
		End If
	//End - Added By Mark Lee 11/05/2012		
	Case ''
End Choose

//Modified By Mark Lee 12/05/2012
//IF This.GetColumnName() = "set_10" THEN
//	gi_test_mode = this.getitemnumber(1,'set_10')
//end if
//
//IF This.GetColumnName() = "set_29" THEN
//	gi_scan_format = this.getitemnumber(1,'set_29')
//end if
//
////Start Code Change ----10.08.2008 #V85 maha
//IF This.GetColumnName() = "set_56" THEN
//	gi_email_type = this.getitemnumber(1,'set_56')
//end if
////End Code Change---10.08.2008


//changing to department security setting
IF This.GetColumnName() = "set_37" THEN
	li_value = Integer( data )
	IF li_value = 1 THEN
		of_dept_security( ) //maha 012606 changed to function
		
//		SELECT Count( user_id )
//		INTO :li_rec_cnt
//		FROM security_user_department;
//		IF SQLCA.SQLCODE = -1 THEN
//			MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
//			RETURN -1
//		END IF
//	
//		IF li_rec_cnt > 0 THEN
//			li_ans = MessageBox( "Data Exists", "There seems to be data allready in the security_department_table.  Do you want to delete and recreate table?", StopSign!, YesNo!, 2 )
//			IF li_ans = 2 THEN
//				RETURN -1
//			END IF
//		END IF
//	
//		DELETE 
//		FROM security_user_department;
//		IF SQLCA.SQLCODE = -1 THEN
//			MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
//			RETURN -1
//		END IF
//		
//		li_ans = MessageBox( "Department Security", "Are you sure you want to turn the department security feature on?",  StopSign!, YesNo!, 1 )
//		//if going to turn on then need to scan through departments and create user department security table
//		IF li_ans = 1 THEN
//			Integer li_dept_cnt
//			Integer li_user_cnt
//			Integer d
//			Integer u
//			
//			li_ans = MessageBox("Access", "Would you like the default access for all departments to be turned on?", Question!, YesNo!, 1 )
//
//			IF li_ans = 1 THEN
//				li_access = 1
//			ELSE
//				li_access = 0
//			END IF
//			
//			IF li_access = 0 THEN
//				li_ans = MessageBox( "No Access", "When your users login they will have no access to physician data until you go to the User Painter and Grant access to specific departments for each user.", StopSign!, OkCancel!, 1 )
//				IF li_ans = 2 THEN
//					RETURN -1
//				END IF
//			END IF
//			
//			dw_departments.SetTransObject( SQLCA )
//			dw_departments.Retrieve( )
//			li_dept_cnt = dw_departments.RowCount( )
//			dw_users.SetTransObject( SQLCA )
//			dw_users.Retrieve( )
//			li_user_cnt = dw_users.RowCount( )
//			
//			//Loop through all users and department and setup department security
//			FOR u = 1 TO li_user_cnt
//				ls_user_id = dw_users.GetItemString( u, "user_id" )
//				FOR d = 1 TO li_dept_cnt
//					ll_security_dept_code ++
//					ll_department = dw_departments.GetItemNumber( d, "lookup_code" )
//					
//					INSERT INTO security_user_department  
//		         ( user_depart_id,   
//      		     user_id,   
//		           department_id,   
//      		     access_rights )  
//				   VALUES ( :ll_security_dept_code,   
//				            :ls_user_id,   
//				            :ll_department,   
//					         :li_access )  ;
//					IF SQLCA.SQLCODE = -1 THEN
//						MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
//						RETURN -1
//					END IF
//				END FOR
//			END FOR
//			COMMIT USING SQLCA;
//			
//		END IF
//		
//		MessageBox( "Department Security", "Department Security table created.  Go to System->Painters->User Painter to edit access." )
//		
	ELSE
		
	END IF
end if

end event

event retrieveend;//////////////////////////////////////////////////////////////////////
// $<event>  RetrieveEnd()
// $<arguments> long RowCount
// $<returns>   Long
// $<description> Refresh Download URL text
//////////////////////////////////////////////////////////////////////
// $<add> 2008-11-13 by Scofield
//////////////////////////////////////////////////////////////////////

String	ls_DownLoadURL
long		ll_Row

ll_Row = This.RowCount()
if ll_Row <= 0 or ll_Row > this.RowCount() then Return

ls_DownLoadURL = This.GetItemString(ll_Row,"DownloadURL")
if IsNull(ls_DownLoadURL) then Return

sle_DownLoadURL.Text = ls_DownLoadURL

end event

event buttonclicked;If dwo.name = 'b_group_help' Then
	Messagebox('Email Alarm Output Type Help',+&
	'One per Alarm: '+&
	'~r~nIt will create a separate email for each Date Alarm. ~r~n' + &
	'~r~nGroup Alarms into Single Email: '+&
	'~r~nIt will create a single email to each user, and it will put a list of date alarms within the body of email. ')
End If


If dwo.name = 'b_pdfway' Then
	Messagebox('PDF Engine Help',+&
		"Engine 1: No need to install PDF printer.~r~n" + & 
		"Engine 2: Need to install PDF printer but with high definition.")
End If

//Added By Mark Lee 11/05/2012
If dwo.name = 'b_email_setting' Then
	Messagebox('Email Sending Help',+&
		"Easymail: Need to register emsmtp.dll file (default).~r~n" + & 
		"Outlook: Only support plain text email content.~r~n                Security warning message will pop up when sending emails.")
End If
end event

