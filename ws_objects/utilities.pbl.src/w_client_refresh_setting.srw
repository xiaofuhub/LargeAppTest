$PBExportHeader$w_client_refresh_setting.srw
forward
global type w_client_refresh_setting from w_response
end type
type cbx_registry from checkbox within w_client_refresh_setting
end type
type cbx_window_classic from checkbox within w_client_refresh_setting
end type
type cbx_checkdb_size from checkbox within w_client_refresh_setting
end type
type cbx_trusted_sites from checkbox within w_client_refresh_setting
end type
type cbx_scfs from checkbox within w_client_refresh_setting
end type
type dw_general_setting from datawindow within w_client_refresh_setting
end type
type ddlb_approve from dropdownlistbox within w_client_refresh_setting
end type
type ddlb_signature from dropdownlistbox within w_client_refresh_setting
end type
type st_4 from statictext within w_client_refresh_setting
end type
type st_3 from statictext within w_client_refresh_setting
end type
type st_2 from statictext within w_client_refresh_setting
end type
type st_1 from statictext within w_client_refresh_setting
end type
type gb_1 from groupbox within w_client_refresh_setting
end type
type gb_2 from groupbox within w_client_refresh_setting
end type
type cb_close from commandbutton within w_client_refresh_setting
end type
type cb_refreshnow from commandbutton within w_client_refresh_setting
end type
type cb_save from commandbutton within w_client_refresh_setting
end type
end forward

global type w_client_refresh_setting from w_response
string tag = "General Settings"
integer x = 214
integer y = 221
integer width = 1957
integer height = 1440
string title = "User Contracts Settings"
boolean controlmenu = false
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
cbx_registry cbx_registry
cbx_window_classic cbx_window_classic
cbx_checkdb_size cbx_checkdb_size
cbx_trusted_sites cbx_trusted_sites
cbx_scfs cbx_scfs
dw_general_setting dw_general_setting
ddlb_approve ddlb_approve
ddlb_signature ddlb_signature
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
gb_1 gb_1
gb_2 gb_2
cb_close cb_close
cb_refreshnow cb_refreshnow
cb_save cb_save
end type
global w_client_refresh_setting w_client_refresh_setting

type variables

private:
Boolean  ib_Modified = False
end variables

forward prototypes
public function integer wf_checkvalue ()
public function integer wf_run_now ()
end prototypes

public function integer wf_checkvalue ();string			ls_serti, ls_approve, ls_checkdb_size

//Begin - Added By Mark Lee 09/05/12
//ls_serti = ddlb_signature.Text
//ls_approve = ddlb_approve.Text
If dw_general_setting.rowcount( ) <= 0  Then
	Return 1
End If
ls_Serti = String(dw_general_setting.GetItemNumber(dw_general_setting.getrow(),'refresh_sertifi_time'))
ls_approve = String(dw_general_setting.GetItemNumber(dw_general_setting.getrow(),'refresh_approve_time'))
//End - Added By Mark Lee 09/05/12

If IsNull( ls_Serti ) Or Trim( ls_serti) = ''  Then 
	MessageBox( 'Error', "Please enter a value for 'Refresh Document Signature Data'" )
	Return 1
End If
If IsNull( ls_approve ) Or Trim( ls_approve ) = '' Then
	MessageBox( 'Error', "Please enter a value for 'Refresh Document Approval Data'" )
	Return 1
End If
If Not IsNumber( ls_Serti ) Then
	MessageBox( 'Error', "Please enter a number for 'Refresh Document Signature Data'" )
	Return 1
End If
If Not IsNumber( ls_approve ) Then
	MessageBox( 'Error', "Please enter a number for 'Refresh Document Approval Data'" )
	Return 1	
End If

Return 0
end function

public function integer wf_run_now ();//====================================================================
// Function: wf_run_now
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 09/04/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

If gnv_data.of_getitem( 'icred_settings', 'esign', False) = '1' Then
	gnv_sertifi.of_refresh_sertifi_status()
	gnv_echosign.of_refresh_sertifi_status() //Added By Jay Chen 10-18-2013
	// (Appeon)Harry 07.11.2016 - for docusign
	gnv_docusign.ib_ping_server = false 
	gnv_docusign.of_refresh_sertifi_status() 
	gnv_docusign.ib_ping_server = true
End If

gnv_webapprove.of_refresh_status( )

Return 1
end function

on w_client_refresh_setting.create
int iCurrent
call super::create
this.cbx_registry=create cbx_registry
this.cbx_window_classic=create cbx_window_classic
this.cbx_checkdb_size=create cbx_checkdb_size
this.cbx_trusted_sites=create cbx_trusted_sites
this.cbx_scfs=create cbx_scfs
this.dw_general_setting=create dw_general_setting
this.ddlb_approve=create ddlb_approve
this.ddlb_signature=create ddlb_signature
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.cb_close=create cb_close
this.cb_refreshnow=create cb_refreshnow
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_registry
this.Control[iCurrent+2]=this.cbx_window_classic
this.Control[iCurrent+3]=this.cbx_checkdb_size
this.Control[iCurrent+4]=this.cbx_trusted_sites
this.Control[iCurrent+5]=this.cbx_scfs
this.Control[iCurrent+6]=this.dw_general_setting
this.Control[iCurrent+7]=this.ddlb_approve
this.Control[iCurrent+8]=this.ddlb_signature
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.cb_close
this.Control[iCurrent+16]=this.cb_refreshnow
this.Control[iCurrent+17]=this.cb_save
end on

on w_client_refresh_setting.destroy
call super::destroy
destroy(this.cbx_registry)
destroy(this.cbx_window_classic)
destroy(this.cbx_checkdb_size)
destroy(this.cbx_trusted_sites)
destroy(this.cbx_scfs)
destroy(this.dw_general_setting)
destroy(this.ddlb_approve)
destroy(this.ddlb_signature)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.cb_close)
destroy(this.cb_refreshnow)
destroy(this.cb_save)
end on

event open;call super::open;String		ls_serti, ls_approve
Integer	li_i
String 	ls_tmp,ls_registry			//Added By Mark Lee 09/04/12
string ls_hide_tag
//get value
//Begin - Added By Mark Lee 09/04/12
//ls_serti =  gnv_data.of_GetItem( 'security_users', 'refresh_sertifi_time', 'user_id = "' + gs_user_id + '"' )
//ddlb_signature.Text = ls_Serti
//
//ls_approve =  gnv_data.of_GetItem( 'security_users', 'refresh_approve_time', 'user_id = "' + gs_user_id + '"' )
//ddlb_approve.Text = ls_approve
dw_general_setting.settransobject( sqlca)
dw_general_setting.retrieve(gs_user_id )

If dw_general_setting.rowcount( ) = 0 Then 
	dw_general_setting.insertrow( 0)
End If
//End - Added By Mark Lee 09/04/12


//check rights
If gnv_data.of_getitem( 'icred_settings', 'esign', False) = '1' Then
Else
	//Added By Mark Lee 09/04/12
//	ddlb_signature.Enabled = False
	dw_general_setting.modify("refresh_sertifi_time.protect=1 refresh_sertifi_time.background.color='553648127' ")
End If

ls_tmp = ''
//initial value
For li_i = 0 To 180 / 15
	//Begin - Added By Mark Lee 09/04/12
//	ddlb_signature.additem(  string(li_i * 15  ) )
//	ddlb_approve.additem(  string(li_i * 15  ) )
	ls_tmp = ls_tmp + string(li_i * 15  )+"	"+string(li_i * 15  )+"/"
	//End - Added By Mark Lee 09/04/12
Next

If not isnull(ls_tmp) and trim(ls_tmp) <> "" Then
	dw_general_setting.object.refresh_sertifi_time.values = ls_tmp
	dw_general_setting.object.refresh_approve_time.values = ls_tmp
End If

If 	gnv_user_option.of_get_option_value(gs_user_id, "restore_contract_state" ) = '1' Then
	cbx_scfs.checked = True
Else
	cbx_scfs.checked = False
End if

ls_tmp = gnv_user_option.of_get_option_value(gs_user_id, "trusted_sites" ) 
If  ls_tmp	= '1'  or isnull(ls_tmp) or trim(ls_tmp ) = '' Then
	cbx_trusted_sites.checked = True
Else
	cbx_trusted_sites.checked = False
End if

//Added By Ken.Guo 05/31/2013
ls_registry = gnv_user_option.of_get_option_value(gs_user_id, "check_registry")
If  ls_registry	= '1'  or isnull(ls_registry) or trim(ls_registry ) = '' Then
	cbx_registry.checked = True
Else
	cbx_registry.checked = False
End if

If 	gnv_user_option.of_get_option_value(gs_user_id, "database_free_disk_space" ) = '1' Then
	cbx_checkdb_size.checked = True
Else
	cbx_checkdb_size.checked = False
End if

//Added By Mark Lee 03/07/2013
If 	gnv_user_option.of_get_option_value(gs_user_id, "Use_Windows_Classic_theme" ) = '1' Then
	cbx_window_classic.checked = True
Else
	cbx_window_classic.checked = False
End if

//added by gavins 20130313
If  gb_show_EZMenu  Then
	dw_general_setting.SetItem( dw_general_setting.rowCount( ), 'showezmenu'  , 1 )
End If

//---------Begin Added by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
If gb_contract_version Then
	dw_general_setting.modify("set_autoresize.visible='1' t_3.visible='1' ")
Else
	dw_general_setting.modify("set_autoresize.visible='0' t_3.visible='0' ")
//	dw_general_setting.modify("showezmenu.visible='0'")	//alfee 06.24.2014  //Start Code Change ----07.24.2014 #V14.2 maha - removed
End If
//---------End Added ------------------------------------------------------

If gnv_user_option.of_Get_option_value( gs_user_id, "m_pfe_cst_master_menu.m_autoresize" )  = '1' Then
	dw_general_setting.SetItem( dw_general_setting.rowCount( ), 'set_autoresize'  , 1 )
Else
	dw_general_setting.SetItem( dw_general_setting.rowCount( ), 'set_autoresize'  , 0 )
End If
dw_general_setting.SetItemStatus( dw_general_setting.rowCount( ), 0, Primary!, NotModified! )

//Added By Ken.Guo 09/23/2013
If gnv_data.of_getitem( 'icred_settings', 'check_registry', False ) <> '1' Then
	cbx_registry.enabled = False
	cbx_registry.checked = False
End If
If gnv_data.of_getitem( 'icred_settings', 'check_trusted_sites', False ) <> '1' Then
	cbx_trusted_sites.enabled = False
	cbx_trusted_sites.checked = False
End If

//(Appeon) Add by Harry 07.13.2016 - for docusign
ls_hide_tag = gnv_user_option.of_Get_option_value( gs_user_id, "hide_docusign_tag" )
if isnull(ls_hide_tag) or ls_hide_tag = '' then ls_hide_tag = '0'
dw_general_setting.SetItem( dw_general_setting.rowCount( ), 'hide_docusign_tag'  , long(ls_hide_tag) )

end event

event closequery;call super::closequery;Integer		li_Msg

cb_close.SetFocus( )

//Added By Mark Lee 09/05/12
//If ib_Modified Then
If ib_Modified OR dw_general_setting.ModifiedCount() > 0 Then
	li_msg = of_MessageBox ("pfc_master_closequery_savechanges", &
					gnv_app.iapp_object.DisplayName, &
					"Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	Choose Case li_msg
		Case 1
			If wf_checkvalue( ) = 1 Then Return 1
			cb_save.Event clicked( )			
		Case 2
			// NO - Allow the window to be closed without saving changes
		Case 3
			Return 1
	End Choose
End If
end event

type cbx_registry from checkbox within w_client_refresh_setting
integer x = 105
integer y = 396
integer width = 1449
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 33554432
long backcolor = 33551856
string text = "Check Registry Permissions                                                      "
boolean lefttext = true
end type

event clicked;ib_Modified = true
end event

type cbx_window_classic from checkbox within w_client_refresh_setting
boolean visible = false
integer x = 137
integer y = 1768
integer width = 1687
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Use Windows Classic theme  "
boolean lefttext = true
end type

event clicked;ib_Modified = true
end event

type cbx_checkdb_size from checkbox within w_client_refresh_setting
boolean visible = false
integer x = 142
integer y = 1680
integer width = 1687
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Check if the system is less than 50MB free disk space for database"
boolean lefttext = true
end type

event clicked;ib_Modified = true
end event

type cbx_trusted_sites from checkbox within w_client_refresh_setting
integer x = 105
integer y = 316
integer width = 1449
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 33554432
long backcolor = 33551856
string text = "Check if the current URL is in IE~'s trusted sites                         "
boolean lefttext = true
end type

event clicked;ib_Modified = true
end event

type cbx_scfs from checkbox within w_client_refresh_setting
integer x = 105
integer y = 236
integer width = 1449
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 33554432
long backcolor = 33551856
string text = "Save contract folder state                                                         "
boolean lefttext = true
end type

event clicked;ib_Modified = true
end event

type dw_general_setting from datawindow within w_client_refresh_setting
integer x = 37
integer y = 552
integer width = 1856
integer height = 736
integer taborder = 60
string title = "none"
string dataobject = "d_general_setting"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;//Added By Mark Lee 09/04/12
If row > 0 Then 
	If dwo.name = 'b_refreshnow' Then
		parent.wf_run_now()
	End If
End If
end event

type ddlb_approve from dropdownlistbox within w_client_refresh_setting
boolean visible = false
integer x = 1399
integer y = 2076
integer width = 315
integer height = 344
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ib_Modified = true
end event

event modified;ib_Modified = true
end event

type ddlb_signature from dropdownlistbox within w_client_refresh_setting
boolean visible = false
integer x = 1394
integer y = 1944
integer width = 315
integer height = 468
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event modified;ib_Modified = true
end event

event selectionchanged;ib_Modified = true
end event

type st_4 from statictext within w_client_refresh_setting
boolean visible = false
integer x = 1051
integer y = 2092
integer width = 869
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Refresh Every [                        ] Minutes"
boolean focusrectangle = false
end type

type st_3 from statictext within w_client_refresh_setting
boolean visible = false
integer x = 1051
integer y = 1948
integer width = 869
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Refresh Every [                        ] Minutes"
boolean focusrectangle = false
end type

type st_2 from statictext within w_client_refresh_setting
boolean visible = false
integer x = 133
integer y = 2092
integer width = 928
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Refresh Document Approval Data                            "
boolean focusrectangle = false
end type

type st_1 from statictext within w_client_refresh_setting
boolean visible = false
integer x = 133
integer y = 1948
integer width = 928
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Refresh Document Signature Data                           "
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_client_refresh_setting
integer x = 55
integer y = 172
integer width = 1783
integer height = 336
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "General"
end type

type gb_2 from groupbox within w_client_refresh_setting
boolean visible = false
integer x = 78
integer y = 1856
integer width = 1911
integer height = 356
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Refresh Document Signature and Approval Data"
end type

type cb_close from commandbutton within w_client_refresh_setting
integer x = 1495
integer y = 48
integer width = 343
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;Close( parent )
end event

type cb_refreshnow from commandbutton within w_client_refresh_setting
boolean visible = false
integer x = 891
integer y = 2256
integer width = 343
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Run Now"
end type

event clicked;
If gnv_data.of_getitem( 'icred_settings', 'esign', False) = '1' Then
	gnv_sertifi.of_refresh_sertifi_status()
	gnv_echosign.of_refresh_sertifi_status() //Added By Jay Chen 10-18-2013
	// (Appeon)Harry 07.11.2016 - for docusign
	gnv_docusign.ib_ping_server = false 
	gnv_docusign.of_refresh_sertifi_status() 
	gnv_docusign.ib_ping_server = true
End If

gnv_webapprove.of_refresh_status( )
end event

type cb_save from commandbutton within w_client_refresh_setting
integer x = 1051
integer y = 48
integer width = 375
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save Settings"
boolean default = true
end type

event clicked;String			ls_serti, ls_approve,ls_hide_tag
integer 		li_rtn
String 		ls_save_contract_folder_state,	ls_trusted_sites, ls_set_prelod_ctx, ls_set_autoresize, ls_checkdb_size, ls_registry
dwItemStatus	ldws_set_prelod_ctx,	ldws_set_autoresize, ldws_set_showezmenu,ldws_hide_tag

// save data
//Begin - Added By Mark Lee 09/05/12
If ib_Modified = True Then	
	If ib_Modified = True Then
		If  cbx_scfs.checked = True Then
			ls_save_contract_folder_state 	= '1'
			gb_restore_contract_state = True
		Else
			ls_save_contract_folder_state 	= '0'
			gb_restore_contract_state = False
		End If
		
		gnv_user_option.of_Set_option_value(gs_user_id, "restore_contract_state",ls_save_contract_folder_state )
//		gnv_user_option.of_save( )	
		
		If isvalid(m_pfe_cst_master_menu) Then 
			gnv_app.of_modify_menu_attr( m_pfe_cst_master_menu.m_window.m_savecontractfolderstate,'Checked', gb_restore_contract_state)
		End If
		
		If  cbx_trusted_sites.checked = True Then
			ls_trusted_sites 	= '1'
		Else
			ls_trusted_sites 	= '0'
		End If
		gnv_user_option.of_Set_option_value(gs_user_id, "trusted_sites",ls_trusted_sites )

		//Added By Ken.Guo 05/31/2013
		If  cbx_registry.checked = True Then
			ls_registry 	= '1'
		Else
			ls_registry 	= '0'
		End If		
		gnv_user_option.of_Set_option_value(gs_user_id, "check_registry",ls_registry )
		
		//Added By Mark Lee 09/11/12
		If  cbx_checkdb_size.checked = True Then
			ls_checkdb_size 	= '1'
		Else
			ls_checkdb_size 	= '0'
		End If
		gnv_user_option.of_Set_option_value(gs_user_id, "database_free_disk_space",ls_checkdb_size )
		
		//Added By Mark Lee 03/07/2013  	//Added By Mark Lee 04/07/2013  do not need it ,this is useer control for dw title bar .
		If cbx_window_classic.checked = True Then 
			gnv_user_option.of_Set_option_value(gs_user_id, "Use_Windows_Classic_theme" ,'1') 
		Else
			gnv_user_option.of_Set_option_value(gs_user_id, "Use_Windows_Classic_theme", '0' ) 
		End if
		
		gnv_user_option.of_save( )	
		
		ib_Modified = false		
	End If

End If

If dw_general_setting.ModifiedCount() > 0 Then
	If wf_checkvalue( ) = 1 Then Return
	
//	set_prelod_ctx set_autoresize
	ldws_set_prelod_ctx = dw_general_setting.getitemstatus(dw_general_setting.getrow() , 'set_prelod_ctx', Primary!)
	ldws_set_autoresize = dw_general_setting.getitemstatus(dw_general_setting.getrow() , 'set_autoresize', Primary!)
	ldws_set_showezmenu= dw_general_setting.getitemstatus(dw_general_setting.getrow() , 'showezmenu', Primary!)
	ldws_hide_tag = dw_general_setting.getitemstatus(dw_general_setting.getrow() , 'hide_docusign_tag', Primary!)  //(Appeon) Add by Harry 07.13.2016 - for docusign
	li_rtn = dw_general_setting.update( )
	If SQLCA.SQLCODE <> 0 Then
		MessageBox( 'Error', "Failed to Save!" +  Sqlca.SQLErrText  )
		Return	
	End If	
	
	gnv_data.of_Retrieve( 'security_users' )
	
	If ldws_set_prelod_ctx = NewModified! Or ldws_set_prelod_ctx = DataModified!	Then
		ls_set_prelod_ctx = String(dw_general_setting.GetitemNumber( dw_general_setting.getrow(),'set_prelod_ctx'))
		If ls_set_prelod_ctx = '1' Then
			gb_PreloadCTX  = True
		Else
			gb_PreloadCTX = False
		End If
		If isvalid(m_pfe_cst_master_menu) Then 
			gnv_app.of_modify_menu_attr( m_pfe_cst_master_menu.m_window.m_preload,'Checked', gb_PreloadCTX)
		End If
	End If

	If ldws_set_autoresize = NewModified! Or ldws_set_autoresize = DataModified!	Then
		ls_set_autoresize = String(dw_general_setting.GetitemNumber( dw_general_setting.getrow(),'set_autoresize'))
		If ls_set_autoresize = '1' Then
			gb_autozoom  = True
		Else
			gb_autozoom = False
		End If
		If isvalid(m_pfe_cst_master_menu) Then 
			gnv_app.of_modify_menu_attr( m_pfe_cst_master_menu.m_window.m_autoresize,'Checked', gb_autozoom) //modified by gavins 20130107
		End If
		IF gb_autozoom THEN//modified by gavins 20130107
			gnv_user_option.of_Set_option_value( gs_user_id, "m_pfe_cst_master_menu.m_autoresize",'1' )
		ELSE
			gnv_user_option.of_Set_option_value( gs_user_id, "m_pfe_cst_master_menu.m_autoresize",'0' )
		END IF
		gnv_user_option.of_Save( )
	End If
	
	//(Appeon) Add by Harry 07.13.2016 - for docusign
	If ldws_hide_tag = NewModified! Or  ldws_hide_tag = DataModified!	Then
		ls_hide_tag = String(dw_general_setting.GetitemNumber( dw_general_setting.getrow(),'hide_docusign_tag'))
		if isnull(ls_hide_tag) then ls_hide_tag = '0'
		gnv_user_option.of_Set_option_value(gs_user_id, "hide_docusign_tag",ls_hide_tag)
		gnv_user_option.of_save( )
	End If
	
	If ldws_set_showezmenu = NewModified! Or  ldws_set_showezmenu = DataModified!	Then//added by gavins 20130313
		ls_set_autoresize = String(dw_general_setting.GetitemNumber( dw_general_setting.getrow(),'showezmenu'))
		If ls_set_autoresize = '1' Then
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
	End If

End If

//End - Added By Mark Lee 09/05/12
//If ib_Modified Then
//		
//	//check  value  is null or ''
//	ls_serti = ddlb_signature.Text
//	ls_approve = ddlb_approve.Text
//	
//	If wf_checkvalue( ) = 1 Then Return
//	
//	ib_Modified = false
//	
//	Update security_users Set refresh_sertifi_time = :ls_serti , refresh_approve_time = :ls_approve Where user_id = :gs_User_ID;
//	If SQLCA.SQLCODE <> 0 Then
//		MessageBox( 'Error', "Failed to Save!" +  Sqlca.SQLErrText  )
//		Return	
//	End If	
//		
//	gnv_data.of_Retrieve( 'security_users' )
//End If
end event

