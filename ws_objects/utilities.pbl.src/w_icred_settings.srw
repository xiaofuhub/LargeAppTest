$PBExportHeader$w_icred_settings.srw
forward
global type w_icred_settings from window
end type
type cb_ctx_set from commandbutton within w_icred_settings
end type
type sle_webcomponent from singlelineedit within w_icred_settings
end type
type st_webcomponent from statictext within w_icred_settings
end type
type sle_downloadurl from singlelineedit within w_icred_settings
end type
type st_downloadurl from statictext within w_icred_settings
end type
type cb_brow4 from commandbutton within w_icred_settings
end type
type cb_contract_path from commandbutton within w_icred_settings
end type
type dw_users from datawindow within w_icred_settings
end type
type dw_departments from datawindow within w_icred_settings
end type
type cb_brow3 from commandbutton within w_icred_settings
end type
type cb_brow1 from commandbutton within w_icred_settings
end type
type cb_brow2 from commandbutton within w_icred_settings
end type
type cb_other_set from commandbutton within w_icred_settings
end type
type cb_2 from commandbutton within w_icred_settings
end type
type cb_1 from commandbutton within w_icred_settings
end type
type dw_1 from datawindow within w_icred_settings
end type
type dw_2 from datawindow within w_icred_settings
end type
end forward

global type w_icred_settings from window
integer x = 677
integer y = 48
integer width = 4635
integer height = 2652
boolean titlebar = true
string title = "Application Settings"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
cb_ctx_set cb_ctx_set
sle_webcomponent sle_webcomponent
st_webcomponent st_webcomponent
sle_downloadurl sle_downloadurl
st_downloadurl st_downloadurl
cb_brow4 cb_brow4
cb_contract_path cb_contract_path
dw_users dw_users
dw_departments dw_departments
cb_brow3 cb_brow3
cb_brow1 cb_brow1
cb_brow2 cb_brow2
cb_other_set cb_other_set
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_icred_settings w_icred_settings

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
		li_ans = MessageBox( "No Access", "When your users login they will have no access to physician data until you go to the User Setup and Grant access to specific departments for each user.", information!, OkCancel!, 1 )//(user painter->user setup) alfee 09.22.2011
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
		ls_user_id = of_ReviseExpValue(ls_user_id, "~~")//Nova 08.28.2009
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
	//MessageBox( "Department Security", "Department Security data updated.  Go to System->Painters->User Painter to edit access." )  //Start Code Change ----04.09.2008 #V8 maha - moved from outside of if statement
	MessageBox( "Department Security", "Department Security data updated.  Go to System->Setup->Security->User Setup to edit access." )  //alfee 09.22.2011
	
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

//Start Code Change ----07.25.2014 #V14.2 maha - copied/modified from the general settings window.
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
//End Code Change ----07.25.2014

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

end subroutine

on w_icred_settings.create
this.cb_ctx_set=create cb_ctx_set
this.sle_webcomponent=create sle_webcomponent
this.st_webcomponent=create st_webcomponent
this.sle_downloadurl=create sle_downloadurl
this.st_downloadurl=create st_downloadurl
this.cb_brow4=create cb_brow4
this.cb_contract_path=create cb_contract_path
this.dw_users=create dw_users
this.dw_departments=create dw_departments
this.cb_brow3=create cb_brow3
this.cb_brow1=create cb_brow1
this.cb_brow2=create cb_brow2
this.cb_other_set=create cb_other_set
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.cb_ctx_set,&
this.sle_webcomponent,&
this.st_webcomponent,&
this.sle_downloadurl,&
this.st_downloadurl,&
this.cb_brow4,&
this.cb_contract_path,&
this.dw_users,&
this.dw_departments,&
this.cb_brow3,&
this.cb_brow1,&
this.cb_brow2,&
this.cb_other_set,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.dw_2}
end on

on w_icred_settings.destroy
destroy(this.cb_ctx_set)
destroy(this.sle_webcomponent)
destroy(this.st_webcomponent)
destroy(this.sle_downloadurl)
destroy(this.st_downloadurl)
destroy(this.cb_brow4)
destroy(this.cb_contract_path)
destroy(this.dw_users)
destroy(this.dw_departments)
destroy(this.cb_brow3)
destroy(this.cb_brow1)
destroy(this.cb_brow2)
destroy(this.cb_other_set)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_2)
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

//---------Begin Modified by (Appeon)Harry 06.13.2013 for V141 ISG-CLX--------
If gnv_data.of_getitem("icred_settings", "set_cont", false) = "1" then
	cb_ctx_set.visible = true
Else
	cb_ctx_set.visible = false
End if
//---------End Modfiied ------------------------------------------------------

//Added by Alfee 12.04.2013 - commented for Scheduler - retry failed reports (AHN) - alfee 05.22.2015
//If appeongetclienttype () = "WEB" Then 
//	dw_1.modify ("set_76.protect = 1")
//	dw_1.modify ("set_76.background.color = 67108864")
//End If	

//---------Begin Added by (Appeon)Stephen 02.21.2014 --------
if gi_citrix = 1 then
	dw_1.modify("set_67.protect = 1")
	dw_1.modify("set_67.background.color = 536870912")
	dw_1.setitem(1, "set_67", 0)
end if
//---------End Added ------------------------------------------------------

//---------Begin Added by (Appeon)Harry 10.28.2014 for BugH081901--------
if of_get_app_setting("set_9", "I") <> 4 then
	dw_1.modify("showezmenu.visible='0' t_72.visible='0' ")
end if
//---------End Added ------------------------------------------------------

If  gb_show_EZMenu  Then
	dw_1.SetItem( 1, 'showezmenu'  , 1 )
//---------Begin Added by (Appeon)Harry  10.28.2014 for V142 ISG-CLX--------
else
	dw_1.SetItem( 1, 'showezmenu'  , 0 )
//---------End Added ------------------------------------------------------
End If

end event

type cb_ctx_set from commandbutton within w_icred_settings
boolean visible = false
integer x = 2629
integer y = 28
integer width = 773
integer height = 92
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Contracts Application Settings"
end type

event clicked;open(w_ctx_settings)  //(Appeon)Harry 07.03.2013 - V141 ISG-CLX
end event

type sle_webcomponent from singlelineedit within w_icred_settings
boolean visible = false
integer x = 3127
integer y = 2068
integer width = 1294
integer height = 80
integer taborder = 60
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
// $<description> Set Download URL for Web Component
//////////////////////////////////////////////////////////////////////
// $<add> Alfee 04.21.2012  (V12.1 Web Component)
//////////////////////////////////////////////////////////////////////

Long	ll_Row
String	ls_DownLoadURL

ll_Row = dw_1.RowCount()
if ll_Row <= 0 or ll_Row > dw_1.RowCount() then Return

ls_DownLoadURL = Trim(sle_webcomponent.Text)
if ls_DownLoadURL <> "" and RightA(ls_DownLoadURL,1) <> "/" then ls_DownLoadURL += "/"

dw_1.SetItem(ll_Row,"web_component_url",ls_DownLoadURL)

end event

type st_webcomponent from statictext within w_icred_settings
boolean visible = false
integer x = 2574
integer y = 2080
integer width = 535
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Web Component URL:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_downloadurl from singlelineedit within w_icred_settings
integer x = 3127
integer y = 1976
integer width = 1294
integer height = 80
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
if ls_DownLoadURL <> "" and RightA(ls_DownLoadURL,1) <> "/" then ls_DownLoadURL += "/"

dw_1.SetItem(ll_Row,"DownloadURL",ls_DownLoadURL)

end event

type st_downloadurl from statictext within w_icred_settings
integer x = 2642
integer y = 1992
integer width = 466
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

type cb_brow4 from commandbutton within w_icred_settings
integer x = 2309
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

type cb_contract_path from commandbutton within w_icred_settings
integer x = 2309
integer y = 2332
integer width = 251
integer height = 80
integer taborder = 110
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

type dw_users from datawindow within w_icred_settings
boolean visible = false
integer x = 32
integer y = 20
integer width = 274
integer height = 108
integer taborder = 30
string dataobject = "d_user_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_departments from datawindow within w_icred_settings
boolean visible = false
integer x = 361
integer width = 274
integer height = 136
integer taborder = 20
string dataobject = "d_all_departments"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_brow3 from commandbutton within w_icred_settings
integer x = 2309
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

ls_path =  f_browseforfolder('Please select a folder where you will be storing the practitioner picture.' ,handle(parent)) 


if f_validstr(ls_path)  then 
    dw_2.object.picture_path[1] = ls_path  +"\"
end if
end event

type cb_brow1 from commandbutton within w_icred_settings
integer x = 2309
integer y = 1972
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
//	dw_2.setitem(1,"intelliapp_app_path",path)
//END IF



string ls_path 

ls_path = f_browseforfolder('Please select a folder where you will be storing applications.' ,handle(parent))

if f_validstr(ls_path)  then 

dw_2.object.intelliapp_app_path[1] = ls_path  +"\"

end if

end event

type cb_brow2 from commandbutton within w_icred_settings
integer x = 2309
integer y = 2060
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

type cb_other_set from commandbutton within w_icred_settings
integer x = 3429
integer y = 28
integer width = 453
integer height = 92
integer taborder = 120
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

type cb_2 from commandbutton within w_icred_settings
integer x = 4229
integer y = 28
integer width = 302
integer height = 92
integer taborder = 140
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

type cb_1 from commandbutton within w_icred_settings
integer x = 3904
integer y = 28
integer width = 302
integer height = 92
integer taborder = 130
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

type dw_1 from datawindow within w_icred_settings
integer x = 46
integer y = 132
integer width = 4485
integer height = 1792
integer taborder = 10
string dataobject = "d_icred_set"
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

this.accepttext()

IF This.GetColumnName() = "set_10" THEN
	gi_test_mode = this.getitemnumber(1,'set_10')
end if

IF This.GetColumnName() = "set_29" THEN
	gi_scan_format = this.getitemnumber(1,'set_29')
end if

//Start Code Change ----10.08.2008 #V85 maha
IF This.GetColumnName() = "set_56" THEN
	//--------Begin Modified by  Nova 06.07.2010------------------------
	//	gi_email_type = this.getitemnumber(1,'set_56')
	gi_email_type = integer(data)
	//--------End Modified --------------------------------------------

end if
//End Code Change---10.08.2008

//Start Code Change ----02.25.2013 #V12 maha
IF This.GetColumnName() = "set_68" THEN
	li_value = this.getitemnumber(1,'set_68')
	if li_value = 2 then 
		gb_notes_at_top = false
	else
		gb_notes_at_top = true
	end if
end if
//End Code Change ----02.25.2013

//changing to department security setting
IF This.GetColumnName() = "set_37" THEN
	li_value = Integer( data )
	IF li_value = 1 THEN
		of_dept_security( ) //maha 012606 changed to function
	END IF
end if

IF This.GetColumnName() = "set_dashb" THEN
	ll_department =  this.getitemnumber(1,'set_dashb')
	choose case ll_department
		//Start Code Change ----02.16.2016 #V15 maha - changed for button bar color
		case 10 //lav
			gl_button_bar_color = 16769510
		case 80 //blue
			//gl_bg_color = 16773360
			gl_button_bar_color =  rgb(168, 205, 241)   //16774640 //16777215 //16114130  //(16445680 lighter blue)
		case 30 //yellow
			gl_button_bar_color =   rgb(255,255,175)  	//15794175
		case 40 //green
			gl_button_bar_color = 15792880
		case 50 //isg blue
			gl_button_bar_color = rgb(41,38,109)
		case 70 //gray
			gl_button_bar_color = rgb (225,225,225)
		case else
			gl_button_bar_color = 16774640
			//gl_bg_color = 15987699
		//End Code Change ----02.16.2016
	end choose
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

//-------Begin Added by Alfee 04.21.2012 (V12.1 Web Component) ------------
ls_DownLoadURL = This.GetItemString(ll_Row,"web_component_url")
if Not IsNull(ls_DownLoadURL) then
	sle_webcomponent.Text = ls_DownLoadURL
end if
//-------End Added -------------------------------------------------------------------

ls_DownLoadURL = This.GetItemString(ll_Row,"DownloadURL")
if IsNull(ls_DownLoadURL) then Return

sle_DownLoadURL.Text = ls_DownLoadURL



end event

event buttonclicked;if dwo.name = "b_ro" then 
	open(w_readonly_settings)
end if
end event

type dw_2 from datawindow within w_icred_settings
integer x = 50
integer y = 1948
integer width = 4480
integer height = 572
integer taborder = 40
string dataobject = "d_util_paths"
boolean livescroll = true
end type

event updateend;


GNV_app.of_set_contract_path(dw_2.object.contract_path[1] )
end event

event retrieveend;//------------------- APPEON BEGIN -------------------
//$<delete> Michael 02.14.20.2012
//$<reason> V12.1 meeting:wv_meeting_link field to be used for a webview link
/*
//Start Code Change ----12.21.2011 #V12 maha - repurposed the help_path field to be used for a webview link
if this.getitemstring(1,"help_path") = "Coming Soon" then this.setitem( 1,"help_path", "")
if gb_webview = false then 
	this.modify("help_path.visible = false")
	this.modify("wv_link_t.visible = false")
end if
*/
//------------------- APPEON END ---------------------

	
end event

event clicked;//Start Code Change ----02.05.2016 #V15 maha
string s

if dwo.name = "p_aff" then
	s =  this.object.affletter_link[1]
	::clipboard(s) //add :: before clipboard, modified by Appeon long.zhang 01.18.2017 ( V15.2 Bug # 5472 - Application Settings: Recruitment and affletter links are not copying to clipboard)
	Messagebox("Link","Link copied to clipboard.~r~r" + s)
elseif dwo.name = "p_rec" then
	s = this.object.recruit_link[1]        
	::clipboard(s) //add :: before clipboard, modified by Appeon long.zhang 01.18.2017 ( V15.2 Bug # 5472 - Application Settings: Recruitment and affletter links are not copying to clipboard)
	Messagebox("Link","Link copied to clipboard.~r~r" + s)
end if
end event

