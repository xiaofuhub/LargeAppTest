$PBExportHeader$w_lookup_add.srw
forward
global type w_lookup_add from window
end type
type cb_clip from commandbutton within w_lookup_add
end type
type cb_close from commandbutton within w_lookup_add
end type
type cb_save from commandbutton within w_lookup_add
end type
type sle_1 from singlelineedit within w_lookup_add
end type
type dw_1 from datawindow within w_lookup_add
end type
type st_message from statictext within w_lookup_add
end type
end forward

global type w_lookup_add from window
integer x = 1189
integer y = 556
integer width = 1979
integer height = 1660
boolean titlebar = true
string title = "Lookup Add"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
cb_clip cb_clip
cb_close cb_close
cb_save cb_save
sle_1 sle_1
dw_1 dw_1
st_message st_message
end type
global w_lookup_add w_lookup_add

type variables
string is_lookup_name
string is_lookup
long il_code
boolean ib_view = false  //Start Code Change ----9.24.2015 #V15 maha
string is_drag_field_name  //Start Code Change ----9.24.2015 #V15 maha
string is_value   //Start Code Change ----9.24.2015 #V15 maha
u_dw idw_detail   //Start Code Change ----9.24.2015 #V15 maha









end variables

forward prototypes
public function integer of_check_data ()
public subroutine of_addright (long al_category, string as_lookname)
end prototypes

public function integer of_check_data ();integer res
string ls_code = "*"
string ls_value
long ll_luc
integer cnt

//Start Code Change ---- 12.13.2005 # maha
dw_1.accepttext()
//End Code Change---12.13.2005 
//check for required data
if is_lookup = "A" then
	if isnull(dw_1.getitemstring(1,"entity_name")) then
		messagebox("Missing Required Data","Name data is missing.")
		return -1
	elseif isnull(dw_1.getitemstring(1,"street1")) then
		messagebox("Missing Required Data","Street1 data is missing.")
		return -1
	elseif isnull(dw_1.getitemstring(1,"city")) then
		messagebox("Missing Required Data","City data is missing.")
		return -1
//	elseif isnull(dw_1.getitemstring(1,"state")) then
//		messagebox("Missing Required Data","State data is missing.")
//		return -1
//	elseif isnull(dw_1.getitemstring(1,"zip")) then
//		messagebox("Missing Required Data","Zip code data is missing.")
//		return -1
	end if
	ls_value = dw_1.getitemstring(1,"entity_name")
	//---------Begin Modified by (Appeon)Harry 12.20.2013 V141 for BugH120501 of IntelliContract History Issues--------
		//Start Code Change ----04.07.2014 #V14.2 maha - removed
//	ls_code = dw_1.getitemstring(1, 'code')
//	select count(*) into :cnt from address_lookup where code = :ls_code and lookup_name = :is_lookup_name and lookup_code <> :il_code;
	//---------End Modfiied ------------------------------------------------------
elseif is_lookup = "C" then
	if isnull(dw_1.getitemstring(1,"code")) then
		messagebox("Missing Required Data","Please enter a lookup code")
		return -1		//Added by Scofield on 2007-08-31
	elseif isnull(dw_1.getitemstring(1,"description")) then
		messagebox("Missing Required Data","Please enter a lookup description")
		return -1		//Added by Scofield on 2007-08-31
	end if
	//---------Begin Modified by (Appeon)Harry 12.20.2013 V141 for BugH120501 of IntelliContract History Issues--------
	ls_code = dw_1.getitemstring(1, 'code')
	select count(*) into :cnt from code_lookup where code = :ls_code and lookup_name = :is_lookup_name and lookup_code <> :il_code;
	//---------End Modfiied ------------------------------------------------------
end if

//---------Begin Modified by (Appeon)Harry 04.08.2014 for Bug 3993 created for Case# 00047152: Bug report -------
/*
//---------Begin Modified by (Appeon)Harry 12.20.2013 V141 for BugH120501 of IntelliContract History Issues--------
if cnt > 0 then
	messagebox("Duplicate Record","A lookup with this code is already in the database.")
	return -1
end if
//---------End Modfiied ------------------------------------------------------
*/
if il_code = 0 and cnt > 0 then
	res = messagebox("Duplicate Record","A " + ls_code + " lookup record with this code is already in the database. Do you wish to continue adding?",question!,yesno!,2)
	if res = 2 then 	return -1
end if
//---------End Modfiied ------------------------------------------------------

//see if lookup currently exists
if il_code = 0 then ////Start Code Change ----10.04.2011 #V12 maha - only check if a new record
	if is_lookup = "A" then
		select count(*) into :cnt from address_lookup where upper(entity_name) = upper(:ls_value) and lookup_name = :is_lookup_name;
		if cnt > 0 then
			res = messagebox("Duplicate Record","A "  + is_lookup_name +" lookup record with this Entity Name is already in the database.  Do you wish to continue adding?",question!,yesno!,2)
			if res = 2 then 	return -1 //Start Code Change ----10.26.2009 #V10 maha - added option to allow the duplicate
		end if
	elseif is_lookup = "C" then
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-01
		//$<modify> 03.23.2006 By: LeiWei
		//$<reason> Performance tuing
		//$<modification> Write script to retrieve data from a cache instead of from the database.
	
		/*
		select count(*) into :cnt from code_lookup where upper(description) = upper(:ls_value) and lookup_name = :is_lookup_name;
		if cnt > 0 then
		*/
		If gnv_data.of_getitem("code_lookup","lookup_code","upper(description) = '" +upper(ls_value) +"'"+&
			" and lookup_name = '" + upper(is_lookup_name) + "'") <> "" Then
		//---------------------------- APPEON END ----------------------------
			messagebox("Duplicate Record","A lookup with this description is already in the database.")
			return -1
		end if
	end if
//End Code Change ----10.04.2011
end if





return 1
	
end function

public subroutine of_addright (long al_category, string as_lookname);//Copied from w_lookup_maint by Alfee in 01.19.2008
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-11 By: Scofield
//$<Reason> Update ctx_acp_contract_management_right table when add contract category
long		ll_RoleId
long		ll_Cycle,ll_Count

DataStore	lds_Security_Role

lds_Security_Role = Create DataStore
lds_Security_Role.DataObject = "d_dddw_security_roles"
lds_Security_Role.SetTransObject(SQLCA)
lds_Security_Role.Retrieve()

ll_Count = lds_Security_Role.RowCount()

gnv_appeondb.of_startqueue( )

for ll_Cycle = 1 to ll_Count
	ll_RoleId = lds_Security_Role.GetItemNumber(ll_Cycle,'role_id')
	if as_LookName = 'Contract Category' then
		INSERT INTO ctx_acp_contract_management_right(role_id,category,types,rights )
			  VALUES (:ll_RoleId,:al_category,1,'11');
			  
		INSERT INTO ctx_acp_contract_management_right(role_id,category,types,rights )
			  VALUES (:ll_RoleId,:al_category,3,'31');
			  
		INSERT INTO ctx_acp_contract_management_right(role_id,category,types,rights )
			  VALUES (:ll_RoleId,:al_category,4,'41');
	elseif as_LookName = 'Contract Clause Category' then
		INSERT INTO ctx_acp_contract_management_right(role_id,category,types,rights )
			  VALUES (:ll_RoleId,:al_category,2,'21');
	end if
next

gnv_appeondb.of_commitqueue( )

COMMIT USING SQLCA;

Destroy lds_Security_Role
//---------------------------- APPEON END ----------------------------

end subroutine

on w_lookup_add.create
this.cb_clip=create cb_clip
this.cb_close=create cb_close
this.cb_save=create cb_save
this.sle_1=create sle_1
this.dw_1=create dw_1
this.st_message=create st_message
this.Control[]={this.cb_clip,&
this.cb_close,&
this.cb_save,&
this.sle_1,&
this.dw_1,&
this.st_message}
end on

on w_lookup_add.destroy
destroy(this.cb_clip)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.sle_1)
destroy(this.dw_1)
destroy(this.st_message)
end on

event open; //Start Code Change ----09.24.2015 #V15 maha - modified code to user a structure org code below
integer li_pos
string s
gs_pass_ids lst_ids


lst_ids = Message.powerobjectParm

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 12.25.2015
//<$>reason:Can not add or edit lookup in DE, so separate lookup name from s_ids[1], for BugL122501.

//li_pos = pos(s,"#",1)
//is_lookup_name = MidA(s,3)
//is_lookup_name = lst_ids.s_ids[2]
If  Upperbound(lst_ids.s_ids[]) = 3 Then is_lookup_name = lst_ids.s_ids[3]
is_lookup = lst_ids.s_ids[1]
idw_detail = lst_ids.dw

//if MidA(s,  li_pos + 1 )  = "ALL" then
//	il_code = 0
//else
//	il_code = long (is_lookup_name)
//end if
if lst_ids.s_ids[2]  = "ALL" then
	il_code = 0
else
	il_code = long (lst_ids.s_ids[2])
end if
//------------------- APPEON END -------------------

if is_lookup = "C" then
	dw_1.dataobject = "d_code_lookup_add_add_search"
	sle_1.visible = false
	dw_1.visible = true
	this.title = "Code Add/Edit"
	//---------Begin Modified by (Appeon)Harry 06.05.2013 for V141 ISG-CLX--------
	//this.height = 500
	this.height = 600
	st_message.visible = true
	st_message.text = "Note:To set additional attributes of the " + is_lookup_name + &
							" lookup, please go to System->Setup->Lookup Lists(Button) and select the " + is_lookup_name + &
							" lookup table."
	dw_1.height = 180
	//---------End Modfiied ------------------------------------------------------
elseif  is_lookup = "A" then
	dw_1.visible = true
	sle_1.visible = false
	dw_1.dataobject = "d_address_lookup_add"
	this.title = "Entity Lookup Add/Edit"
	//---------Begin Modified by (Appeon)Harry 06.05.2013 for V141 ISG-CLX--------
	st_message.visible = false
	this.height = 1580
	dw_1.height = 1380
	cb_clip.visible = true  //Start Code Change ----10.04.2011 #V12 maha
	//---------End Modfiied ------------------------------------------------------
//Start Code Change ----01.13.2015 #V14.2 maha - for view entity
elseif  is_lookup = "V" then  //entity view
	dw_1.visible = true
	sle_1.visible = false
	dw_1.dataobject = "d_address_lookup_add"
	this.title = "View Entity"
	//---------Begin Modified by (Appeon)Harry 06.05.2013 for V141 ISG-CLX--------
	st_message.visible = false
	this.height = 1580
	dw_1.height = 1380
	cb_clip.visible = true
	ib_view = true
//End Code Change ----01.13.2015
end if
//messagebox("is_lookup_name",is_lookup_name)
//messagebox("is_lookup",is_lookup)

dw_1.SetTransObject( SQLCA )
if il_code > 0 then
	dw_1.retrieve(il_code)
else
	dw_1.insertrow(1)
	dw_1.setitem(1,"lookup_name",is_lookup_name)
end if

dw_1.SetFocus()
dw_1.SetColumn('code')
//End Code Change ----10.04.2011

//Start code change 11.30.2006 henry. if adding for contract category, then set the default view
If upper(is_lookup_name) = 'CONTRACT CATEGORY' Then dw_1.setitem(1,"ic_n",1001)
//End code change 11.30.2006

if not gb_contract_version then  //(Appeon)Harry 09.16.2015 - for Bug_id#4730
	//Start Code Change ----01.05.2015 #V14.2 maha - add security for open from view entity
	IF w_mdi.of_security_access( 1300 ) = 0 THEN
		cb_save.visible = FALSE
		dw_1.enabled = FALSE  
		cb_close.text = "Close"
	END IF
	//End Code Change ----01.05.2015
end if




////Start Code Change ----10.04.2011 #V12 maha - added for edit option
//integer li_pos
//string s
//
//s = Message.StringParm
//li_pos = pos(s,"#",1)
////is_lookup_name = MidA(s,3)
//is_lookup_name = MidA(s,3, li_pos - 3)
//is_lookup = MidA(s,1,1)
//
//if MidA(s,  li_pos + 1 )  = "ALL" then
//	il_code = 0
//else
//	il_code = long (MidA(s,  li_pos + 1 ))
//end if
//
//if is_lookup = "C" then
//	dw_1.dataobject = "d_code_lookup_add_add_search"
//	sle_1.visible = false
//	dw_1.visible = true
//	this.title = "Code Add/Edit"
//	//---------Begin Modified by (Appeon)Harry 06.05.2013 for V141 ISG-CLX--------
//	//this.height = 500
//	this.height = 600
//	st_message.visible = true
//	st_message.text = "Note:To set additional attributes of the " + is_lookup_name + &
//							" lookup, please go to System->Setup->Lookup Lists(Button) and select the " + is_lookup_name + &
//							" lookup table."
//	dw_1.height = 180
//	//---------End Modfiied ------------------------------------------------------
//elseif  is_lookup = "A" then
//	dw_1.visible = true
//	sle_1.visible = false
//	dw_1.dataobject = "d_address_lookup_add"
//	this.title = "Entity Lookup Add/Edit"
//	//---------Begin Modified by (Appeon)Harry 06.05.2013 for V141 ISG-CLX--------
//	st_message.visible = false
//	this.height = 1580
//	dw_1.height = 1380
//	cb_clip.visible = true  //Start Code Change ----10.04.2011 #V12 maha
//	//---------End Modfiied ------------------------------------------------------
////Start Code Change ----01.13.2015 #V14.2 maha - for view entity
//elseif  is_lookup = "V" then  //entity view
//	dw_1.visible = true
//	sle_1.visible = false
//	dw_1.dataobject = "d_address_lookup_add"
//	this.title = "View Entity"
//	//---------Begin Modified by (Appeon)Harry 06.05.2013 for V141 ISG-CLX--------
//	st_message.visible = false
//	this.height = 1580
//	dw_1.height = 1380
//	cb_clip.visible = true
//	ib_view = true
////End Code Change ----01.13.2015
//end if
////messagebox("is_lookup_name",is_lookup_name)
////messagebox("is_lookup",is_lookup)
//
//dw_1.SetTransObject( SQLCA )
//if il_code > 0 then
//	dw_1.retrieve(il_code)
//else
//	dw_1.insertrow(1)
//	dw_1.setitem(1,"lookup_name",is_lookup_name)
//end if
//
//dw_1.SetFocus()
//dw_1.SetColumn('code')
////End Code Change ----10.04.2011
//
////Start code change 11.30.2006 henry. if adding for contract category, then set the default view
//If upper(is_lookup_name) = 'CONTRACT CATEGORY' Then dw_1.setitem(1,"ic_n",1001)
////End code change 11.30.2006
//
//if not gb_contract_version then  //(Appeon)Harry 09.16.2015 - for Bug_id#4730
//	//Start Code Change ----01.05.2015 #V14.2 maha - add security for open from view entity
//	IF w_mdi.of_security_access( 1300 ) = 0 THEN
//		cb_save.visible = FALSE
//		dw_1.enabled = FALSE  
//		cb_close.text = "Close"
//	END IF
//	//End Code Change ----01.05.2015
//end if
//
//
//
end event

type cb_clip from commandbutton within w_lookup_add
boolean visible = false
integer x = 50
integer y = 36
integer width = 631
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Put Data on Clipboard"
end type

event clicked;//Start Code Change ----01.13.2015 #V14.2 maha - added
string s = ""
string v
integer i

for i = 4 to 15
	v = dw_1.getitemstring(1,i)
	//messagebox(string(i),v)
	if len(v) > 0 then
		s = s + "~r" + v
	end if
next

clipboard(s)
messagebox("On Clipboard",s)

end event

type cb_close from commandbutton within w_lookup_add
integer x = 1678
integer y = 36
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 12.28.2015
//<$>reason:One child (w_lookup_add_child) is not response type. BugL122801. 
//closewithreturn(parent,"cancel")
If Parent.WindowType = Response! Then
	closewithreturn(parent,"cancel")
Else
	Close(parent)
End If
//------------------- APPEON END -------------------
end event

type cb_save from commandbutton within w_lookup_add
integer x = 1413
integer y = 36
integer width = 247
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
boolean default = true
end type

event clicked;integer res
string ls_code = "*"
string ls_value
long ll_luc
Integer		li_value //(Appeon)Harry 03.12.2014 - V142 ISG-CLX

res = of_check_data()

if res = -1 then return -1 

//Start Code Change ----10.04.2011 #V12 maha - modified for edit
if il_code > 0 then
	ll_luc = il_code
	
else
	gnv_appeondb.of_startqueue( )
	
	
	select lookup_code_id into :ll_luc from ids;
	
	update ids set lookup_code_id = lookup_code_id + 1;
	
	gnv_appeondb.of_commitqueue( )

	ll_luc++
	dw_1.setitem(1,"lookup_code",ll_luc)
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.26.2007 By: Jack
	//$<reason> Fix a defect.
	If is_lookup = "C" Then
		dw_1.setitem(1,'type','C')
	End If
	//---------------------------- APPEON END ----------------------------
	
	//Start code by jervis 12-4-2008
	//Set display value for 'Contract Action Type' and 'Action Type'
	if is_lookup_name = 'Contract Action Type' or is_lookup_name = 'Action Type' then
		dw_1.SetItem(1,'custom_1',dw_1.GetItemString(1,"description"))
	end if
	//End code By Jervis 12-4-2008
	
	gnv_appeondb.of_autocommit( )
end if
	
res = dw_1.update()
if res < 0 then 
	messagebox("Update Failure", "Unable to Save lookup")
	return -1
else
	//Start Code change --11.30.2006 Added by henry.
	gnv_appeondb.of_startqueue()
	commit using sqlca;

	//Refresh cachedata
	//Start Code Change ----03.29.2016 #V15 maha - modified to include update of the address lookup
	if is_lookup = "A" or is_lookup = "V"  then //(Appeon)Stephen 05.13.2016 -add "or is_lookup = "V"" ---Bug ID #5152 for Case # 00062936: RE: Case # 00062713: Issue with Mapping 
		gnv_data.of_retrieve('address_lookup')
	else
		gnv_data.of_retrieve( "code_lookup" )
		gnv_data.of_retrieve( "code_lookup_2" )
		update code_lookup set modify_date = getdate() where lookup_name = :is_lookup_name; 
	end if
	//End Code Change ----03.29.2016
	gnv_appeondb.of_commitqueue()
	//End code changes -- 11.30.2006
	
	//---------Begin Added by (Appeon)Harry 03.12.2014 for V142 ISG-CLX--------
	//Begin - Added By Mark Lee 01/04/2013	 this is must after code_lookup retrieve data 	//	Contract Action Status
	li_value = gnv_app.inv_dwcache.of_IsRegistered (is_lookup_name)    
	IF li_value = 1 THEN
		gnv_app.of_setcontraccache_code_lookup( is_lookup_name )
	End If
	//End - Added By Mark Lee 01/04/2013
	//---------End Added ------------------------------------------------------

	//----------Begin Added by Alfee 01.19.2008--------------------
	//<$Reason> Update ctx_acp_contract_management_right table
	if ((is_lookup_name = 'Contract Category') or (is_lookup_name = 'Contract Clause Category')) then
		of_AddRight(ll_luc, is_lookup_name)
	end if
	//----------END Added------------------------------------------	
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 12.28.2015
	//<$>reason:One child (w_lookup_add_child) is not response type. BugL122801. 
	//closewithreturn(parent,ll_luc)
	If Parent.WindowType = Response! Then
		closewithreturn(parent,ll_luc)
	Else
		Close(parent)
	End If
	//------------------- APPEON END -------------------
	
end if
//---------------------------- APPEON END ----------------------------

end event

type sle_1 from singlelineedit within w_lookup_add
boolean visible = false
integer x = 1211
integer y = 16
integer width = 73
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_lookup_add
integer y = 144
integer width = 1961
integer height = 1428
integer taborder = 10
string dragicon = "droparrow.ico"
string dataobject = "d_address_lookup_add"
boolean livescroll = true
end type

event buttonclicked;//Start Code Change ----10.04.2011 #V12 maha

String	ls_Phone,ls_fax,ls_RetParm

if row > 0 and row <= This.RowCount() then
	if dwo.name = 'b_phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
		This.SetColumn('phone')
	elseif dwo.name = 'b_fax' then
		ls_fax = This.GetItemString(row,'fax')
		if IsNull(ls_fax) then ls_fax = ""
		OpenWithParm(w_phonedetail,"Fax:" + ls_fax)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'fax',ls_RetParm)
		end if
		This.SetColumn('fax')
	end if
end if
end event

event itemchanged;// (Appeon)Harry 06.05.2013 - V141 ISG-CLX
//Add by jervis 10.20.2009 
if is_lookup = 'C' and dwo.name = 'code' then
	this.SetItem(row,'description',data)
end if
end event

event itemfocuschanged;//---------Begin Added by (Appeon)Harry 04.08.2014 for Bug 3993--------
DataWindowChild dwchild
if dwo.name = 'country' then
	dw_1.GetChild( "country", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( "country" )		
end if
//---------End Added ------------------------------------------------------
end event

type st_message from statictext within w_lookup_add
boolean visible = false
integer y = 308
integer width = 1966
integer height = 180
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Note:To set additional asdfffffffffffffffffffffffffffffffffffffffffffffffffffffttributes of the  lookup please go to System->Lookup Painter and select the Clause Approval Status lookup table."
boolean focusrectangle = false
end type

