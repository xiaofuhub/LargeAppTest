$PBExportHeader$u_cst_gadget_favorite_master.sru
forward
global type u_cst_gadget_favorite_master from u_cst_gadget
end type
end forward

global type u_cst_gadget_favorite_master from u_cst_gadget
string tag = "u_gadget_  .favorite "
event type integer ue_delete ( long al_data_id )
event type integer ue_add ( long al_data_id )
event type integer ue_add_2 ( string as_type,  long al_data_id )
event type integer ue_delete_2 ( string as_type,  long al_data_id )
end type
global u_cst_gadget_favorite_master u_cst_gadget_favorite_master

type variables
String is_favority_type //'COR','REPORT','WF'
end variables

forward prototypes
public function integer of_settings ()
public subroutine of_register (string as_type)
end prototypes

event type integer ue_delete(long al_data_id);//////////////////////////////////////////////////////////////////////
// $<event>ue_deleteu_cst_gadget_favorite_correspondence()
// $<arguments>
//		value	long	al_data_id		
// $<returns> integer
// $<description>
// $<description> Delete row by data_id
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-08 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_letter_id
Long ll_row
If isnull(al_data_id) Then Return 0

ll_row = dw_content.Find('dashboard_gadgets_favorite_data_id = '+ String(al_data_id),1,dw_content.rowcount())
If ll_row < 1 Then Return 0

dw_content.DeleteRow(ll_row)

Return 1
end event

event type integer ue_add(long al_data_id);Long ll_row
If isnull(al_data_id) Then Return 0

ll_row = dw_content.Find('dashboard_gadgets_favorite_data_id = '+ String(al_data_id),1,dw_content.rowcount())
If ll_row > 0 Then Return 1  //Existed

ll_row = dw_content.InsertRow(0)
dw_content.SetItem(ll_row,'dashboard_gadgets_favorite_user_id',gs_user_id)
dw_content.SetItem(ll_row,'dashboard_gadgets_favorite_data_id',al_data_id)
dw_content.SetItem(ll_row,'dashboard_gadgets_favorite_favorite_type',is_favority_type)

Return 1
end event

event type integer ue_add_2(string as_type, long al_data_id);Long ll_row
If isnull(al_data_id) Then Return 0

ll_row = dw_content.Find('dashboard_gadgets_favorite_data_id = '+ String(al_data_id) +&
	' And dashboard_gadgets_favorite_favorite_type = "'+as_type+'"',1,dw_content.rowcount())
If ll_row > 0 Then Return 1  //Existed

ll_row = dw_content.InsertRow(0)
dw_content.SetItem(ll_row,'dashboard_gadgets_favorite_user_id',gs_user_id)
dw_content.SetItem(ll_row,'dashboard_gadgets_favorite_data_id',al_data_id)
dw_content.SetItem(ll_row,'dashboard_gadgets_favorite_favorite_type',as_type)

Return 1
end event

event type integer ue_delete_2(string as_type, long al_data_id);//////////////////////////////////////////////////////////////////////
// $<event>u_cst_gadget_favorite_master::ue_delete_2()
// $<arguments>
//		value	string	as_type		
//		value	long  	al_id  		
// $<returns> integer
// $<description>
// $<description> Delete row by type and ID
//////////////////////////////////////////////////////////////////////
// $<add> 09.16.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////


Long ll_letter_id
Long ll_row
If isnull(al_data_id) Then Return 0

//--------Begin Modified by  Nova 06.02.2010------------------------
//ll_row = dw_content.Find('dashboard_gadgets_favorite_data_id = '+ String(al_data_id) +&
//	'And dashboard_gadgets_favorite_favorite_type = "'+ as_type + '"',1,dw_content.rowcount())
ll_row = dw_content.Find('dashboard_gadgets_favorite_data_id = '+ String(al_data_id) +&
	' And dashboard_gadgets_favorite_favorite_type = "'+ as_type + '"',1,dw_content.rowcount())
//--------End Modified --------------------------------------------

If ll_row < 1 Then Return 0

dw_content.DeleteRow(ll_row)

Return 1
end event

public function integer of_settings ();//Override Ancestor Script
//OpenwithParm(w_dashboard_gadget_favorite_..._cfg,This)

Return 1
end function

public subroutine of_register (string as_type);is_favority_type = as_type

//Check datawindow column
If LenA(dw_content.Describe("dashboard_gadgets_favorite_data_id.dbName")) <= 1 Then
	Messagebox('Register '+as_type,'Failed to register favorite object, please call support.')	
End If
end subroutine

on u_cst_gadget_favorite_master.create
call super::create
end on

on u_cst_gadget_favorite_master.destroy
call super::destroy
end on

event ue_save;call super::ue_save;//////////////////////////////////////////////////////////////////////
// $<event>ue_saveu_cst_gadget_favorite_correspondence()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> Save data for 'Favorite Correspondence'.
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-08 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If dw_content.Modifiedcount( ) + dw_content.Deletedcount( ) > 0 Then
	gnv_appeondb.of_autocommitrollback( )
	If dw_content.update( ) = 1 Then
		commit using sqlca;
	Else
		rollback using sqlca;
		Messagebox('Save error',"Failed to save 'Favorite Correspondence' data.")
		Trigger Event ue_retrieve() //Restore data
		Return -1
	End If
End If
//Trigger Event ue_retrieve() //Refresh letter name and Resort data.  //move to u_cst_tabpg_gadget.ue_retrieve_same_gadgets()
Return 1
end event

type dw_content from u_cst_gadget`dw_content within u_cst_gadget_favorite_master
event ue_delete ( )
end type

type ln_split from u_cst_gadget`ln_split within u_cst_gadget_favorite_master
end type

type st_1 from u_cst_gadget`st_1 within u_cst_gadget_favorite_master
end type

type st_title from u_cst_gadget`st_title within u_cst_gadget_favorite_master
end type

type pb_close from u_cst_gadget`pb_close within u_cst_gadget_favorite_master
end type

type pb_max from u_cst_gadget`pb_max within u_cst_gadget_favorite_master
end type

type pb_edit from u_cst_gadget`pb_edit within u_cst_gadget_favorite_master
end type

