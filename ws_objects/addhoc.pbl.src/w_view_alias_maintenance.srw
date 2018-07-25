$PBExportHeader$w_view_alias_maintenance.srw
forward
global type w_view_alias_maintenance from w_main
end type
type cb_missing from commandbutton within w_view_alias_maintenance
end type
type cb_expand from commandbutton within w_view_alias_maintenance
end type
type dw_6 from datawindow within w_view_alias_maintenance
end type
type cb_close from commandbutton within w_view_alias_maintenance
end type
type cb_save from commandbutton within w_view_alias_maintenance
end type
type cb_import from commandbutton within w_view_alias_maintenance
end type
type dw_select_view from u_dw within w_view_alias_maintenance
end type
type dw_fields_alias from u_dw within w_view_alias_maintenance
end type
type dw_view_alias from u_dw within w_view_alias_maintenance
end type
type dw_1 from datawindow within w_view_alias_maintenance
end type
type tv_view from u_tvs_rpt within w_view_alias_maintenance
end type
type gb_1 from groupbox within w_view_alias_maintenance
end type
type dw_5 from datawindow within w_view_alias_maintenance
end type
end forward

global type w_view_alias_maintenance from w_main
integer width = 3186
integer height = 2320
string title = "View Alias Maintenance"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
long backcolor = 33551856
cb_missing cb_missing
cb_expand cb_expand
dw_6 dw_6
cb_close cb_close
cb_save cb_save
cb_import cb_import
dw_select_view dw_select_view
dw_fields_alias dw_fields_alias
dw_view_alias dw_view_alias
dw_1 dw_1
tv_view tv_view
gb_1 gb_1
dw_5 dw_5
end type
global w_view_alias_maintenance w_view_alias_maintenance

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-21 By: Andy
Long il_OrigModule = 0
Blob iblb_data
Boolean ib_upLoad = False
//---------------------------- APPEON END ----------------------------
long il_data_view_id  //maha 05.232017

end variables

forward prototypes
public function integer of_getargs (u_tvs_rpt atv_args, long al_parent, integer ai_level, ref any aa_arg[20])
public function integer of_upload_image (string as_fullname)
public function integer of_update_image ()
public subroutine of_expandcollapseall (commandbutton acb_args, u_tvs_rpt atv_args)
end prototypes

public function integer of_getargs (u_tvs_rpt atv_args, long al_parent, integer ai_level, ref any aa_arg[20]);//====================================================================
// Event: w_custom_report.of_getargs()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//    value       treeview atv_args
// 	value    	long   	al_parent 	
// 	value    	integer	ai_level  	
// 	reference	any    	aa_arg[20]	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: 12.20.2007
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//				
//====================================================================
Integer				li_Index
TreeViewItem		ltvi_Item

// check arguments
If (al_parent < 0) or IsNull(al_parent) Then Return -1
If (ai_level < 1) or IsNull(ai_level) Then Return -1

// Determine level 
li_Index = UpperBound(atv_args.inv_attrib)
If ai_Level > li_Index Then
	Return -1
Else
	li_Index = ai_Level
End If

if al_Parent <> 0 then
	If atv_args.GetItem(al_Parent, ltvi_Item) = -1 Then Return -1
end if

CHOOSE CASE ai_level
	CASE 1
		//do nothing
		
	CASE 2
		aa_arg[1] = ltvi_Item.data
		//$<add> 02.21.2008 by Andy
		aa_arg[2] = 0
END CHOOSE

Return 1

end function

public function integer of_upload_image (string as_fullname);//====================================================================
// Event: w_view_alias_maintenance.of_upload_image()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	fullname	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Dec 21,2007
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

integer li_FileNum, li_loops, ll_i

long ll_flen, ll_Ret

blob lblb_data

// Set a wait cursor
SetPointer(HourGlass!)

If not fileexists(as_fullname) then return -1

// Open processs window
//openwithparm( w_appeon_gifofwait, "Uploading Image to Database..." )
	
// Get the file length, and open the file
ll_flen = FileLength(as_fullname)

// Open the file
li_FileNum = FileOpen(as_fullname, StreamMode!, Read!, LockRead!)

// Determine how many times to call FileRead
IF ll_flen > 32765 THEN
	IF Mod(ll_flen, 32765) = 0 THEN
		li_loops = ll_flen/32765
	ELSE
		li_loops = (ll_flen/32765) + 1
	END IF
ELSE
	li_loops = 1
END IF

// Read the file
FOR ll_i = 1 to li_loops
    ll_Ret = FileRead(li_FileNum, lblb_data)
    iblb_data = iblb_data + lblb_data
NEXT

// Close the file
FileClose(li_FileNum)

ib_upLoad = True
// Close process window
//IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

Return 1

end function

public function integer of_update_image ();//====================================================================
// Event: w_view_alias_maintenance.of_update_image()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Dec 21,2007
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long   ll_Row
String ls_v_name

IF NOT ib_upLoad THEN RETURN 1
ll_Row = dw_view_alias.GetRow( )

if ll_Row > 0 then 
	ls_v_name = dw_view_alias.GetItemString(ll_Row,"v_name")	
	
	UPDATEBLOB  view_alias
		 SET v_image = :iblb_data
	  WHERE v_name = :ls_v_name;
	IF SQLCA.SQLCODE <> 0 THEN
		RETURN -1
	END IF
END IF

ib_upLoad = False
RETURN 1

end function

public subroutine of_expandcollapseall (commandbutton acb_args, u_tvs_rpt atv_args);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-21 By: Andy
Long   ll_Root,ll_FirstRoot
String ls_Type

if lower(acb_args.text) = '&expand all' then
	acb_args.text = 'C&ollapse All'
	ls_Type = 'expandall'
else
	acb_args.text = '&Expand All'
	ls_Type = 'collapseall'
end if

ll_Root = atv_args.FindItem(RootTreeItem!, 0)
ll_FirstRoot = ll_Root
DO WHILE (1=1)
	if ll_Root < 1 then exit
	
	if lower(ls_Type) = 'expandall' then
		atv_args.ExpandAll ( ll_Root )
	else
		atv_args.collapseItem ( ll_Root )
		//delete all child
		//atv_args.of_reset( ll_Root )
	end if
	
	ll_Root = atv_args.FindItem(NextTreeItem!, ll_Root)
LOOP 

atv_args.selectItem(ll_FirstRoot)
atv_args.setfocus()
//---------------------------- APPEON END ----------------------------
end subroutine

on w_view_alias_maintenance.create
int iCurrent
call super::create
this.cb_missing=create cb_missing
this.cb_expand=create cb_expand
this.dw_6=create dw_6
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_import=create cb_import
this.dw_select_view=create dw_select_view
this.dw_fields_alias=create dw_fields_alias
this.dw_view_alias=create dw_view_alias
this.dw_1=create dw_1
this.tv_view=create tv_view
this.gb_1=create gb_1
this.dw_5=create dw_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_missing
this.Control[iCurrent+2]=this.cb_expand
this.Control[iCurrent+3]=this.dw_6
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.cb_import
this.Control[iCurrent+7]=this.dw_select_view
this.Control[iCurrent+8]=this.dw_fields_alias
this.Control[iCurrent+9]=this.dw_view_alias
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.tv_view
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.dw_5
end on

on w_view_alias_maintenance.destroy
call super::destroy
destroy(this.cb_missing)
destroy(this.cb_expand)
destroy(this.dw_6)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_import)
destroy(this.dw_select_view)
destroy(this.dw_fields_alias)
destroy(this.dw_view_alias)
destroy(this.dw_1)
destroy(this.tv_view)
destroy(this.gb_1)
destroy(this.dw_5)
end on

event open;call super::open;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-21 By: Andy
Long ll_Root,ll_FistRoot

tv_view.event pfc_populate( 0)
//Expand All
ll_Root = tv_view.FindItem(RootTreeItem!, 0)
ll_FistRoot = ll_Root
DO WHILE (1=1)
	IF ll_Root < 1 THEN  EXIT	
	tv_view.ExpandAll(ll_Root)//expandItem
	ll_Root = tv_view.FindItem(NextTreeItem!, ll_Root)	
LOOP

if ll_FistRoot > 0 then 
	tv_view.selectitem( ll_FistRoot )
END IF
tv_view.setfocus( )
//---------------------------- APPEON END ----------------------------
end event

event pfc_postupdate;call super::pfc_postupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-21 By: Andy
Long ll_Module,ll_Row,ll_handle
Long ll_Root,ll_data
TreeViewItem ltvi,ltvi_prt
String ls_v_alias,ls_data,ls_v_name

ll_Row = dw_view_alias.GetRow()
if ll_Row > 0 then
	ll_Module = dw_view_alias.GetItemNumber(ll_Row,"module")
	ls_v_alias= dw_view_alias.GetItemString(ll_Row,"v_alias")
	ls_v_name = dw_view_alias.GetItemString(ll_Row,"v_name")
	
	if ll_Module <> il_OrigModule then 
		//Move the TreeViewItem to new Module
		ll_handle = tv_view.Finditem( CurrentTreeItem!, 0)
		if ll_handle > 0 then
			if tv_view.getitem( ll_handle, ltvi) = 1 then
				
				//Find Root that it's data equal to new module. 
				DO WHILE (1=1)
					ll_Root = tv_view.FindItem(RootTreeItem!, 0)
					IF ll_Root < 1 then exit
					if tv_view.getitem( ll_Root, ltvi_prt) = 1 then
						ll_data = ltvi_prt.data
						if ll_data = ll_Module then 
							exit
						end if
					end if										
				LOOP 
				
				if ll_Root > 0 then
					//Delete Item from the old root.
					tv_view.DeleteItem ( ll_handle )
					//Insert Item to the new root.
					If tv_view.FindItem(ChildTreeItem!, ll_Root) = -1 Then
						tv_view.Expanditem( ll_Root )
						ll_handle = tv_view.FindItem(ChildTreeItem!, ll_Root)
						DO WHILE ll_handle > 0
							if tv_view.getitem( ll_handle, ltvi) = 1 then
								ls_data = ltvi.data
								if ls_data = ls_v_name then 
									exit
								end if
							end if
							ll_handle = tv_view.FindItem(NextTreeItem!, ll_handle)										
						LOOP
					else
						ltvi.label = ls_v_alias
						ll_handle  = tv_view.InsertItemLast( ll_Root, ltvi )						
					end if
					if ll_handle > 0 then
						tv_view.SelectItem ( ll_handle )
					end if
				end if
				
			end if
		end if
	end if	
end if

Return 1
//---------------------------- APPEON END ----------------------------
end event

type cb_missing from commandbutton within w_view_alias_maintenance
integer x = 1326
integer y = 60
integer width = 640
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Find Missing Alias Tables"
end type

event clicked;open(w_view_alias_missing)
end event

type cb_expand from commandbutton within w_view_alias_maintenance
integer x = 2043
integer y = 60
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "C&ollapse All"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-21 By: Andy
of_expandcollapseall(this,tv_view)
//---------------------------- APPEON END ----------------------------

end event

type dw_6 from datawindow within w_view_alias_maintenance
integer x = 1230
integer y = 732
integer width = 1906
integer height = 100
integer taborder = 30
boolean enabled = false
boolean titlebar = true
string title = "Fields Alias"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_close from commandbutton within w_view_alias_maintenance
integer x = 2793
integer y = 60
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;//$<add> 2007-12-20 By: Andy
Close(Parent)
end event

type cb_save from commandbutton within w_view_alias_maintenance
integer x = 2418
integer y = 60
integer width = 343
integer height = 92
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

event clicked;//$<add> 2007-12-21 By: Andy

dw_view_alias.SetItem(dw_view_alias.getrow(),"new_rec" , 0)

Parent.event pfc_save( )


end event

type cb_import from commandbutton within w_view_alias_maintenance
boolean visible = false
integer x = 1929
integer y = 60
integer width = 457
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Import Fields Alias"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.14.2008 by Andy
Long ll_data_view_id,ll_Row,ll_ScreenCnt
n_cst_update_view_fields_alias lnvo_Update
String ls_v_name,ls_Screen,ls_ScreenArray[]
datastore lds_view_fields_alias
n_cst_string lnvo_string
Long ll_i,ll_Cnt,ll_dwCnt,ll_Find
String ls_screenID,ls_c_name,ls_c_alias

ll_Row = dw_view_alias.GetRow()
if ll_Row < 1 then return
lnvo_Update = Create n_cst_update_view_fields_alias

lds_view_fields_alias = create datastore
lds_view_fields_alias.dataobject = 'd_view_fields_alias'
lds_view_fields_alias.settransobject(SQLCA)

//Get relative data.
ll_data_view_id = dw_select_view.GetItemNumber(1,"data_view_id")
ls_v_name = dw_view_alias.GetItemString(ll_Row,"v_name")
ls_Screen = dw_view_alias.GetItemString(ll_Row,"screen")
ls_Screen = ls_Screen + ','
lnvo_string.of_parsetoarray( ls_Screen, ',', ls_ScreenArray )
ll_ScreenCnt = UpperBound(ls_ScreenArray)

//Get fields alias.
FOR ll_i = 1 to ll_ScreenCnt
	ls_screenID = ls_ScreenArray[ll_i]
	//ls_screenID is a dataobject name
	if Not IsNumber(ls_screenID) then
		//ls_screenID is a dataobject name	
		lnvo_Update.of_get_view_fields_alias(il_OrigModule,0,ls_screenID,ls_v_name,lds_view_fields_alias)
	else
		//ls_screenID is a screen id
		lnvo_Update.of_get_view_fields_alias(il_OrigModule,ll_data_view_id,ls_screenID,ls_v_name,lds_view_fields_alias)		
	end if 
NEXT

//if don't find alias out, then set a default value.
lnvo_Update.of_after_getaliasformscreen(lds_view_fields_alias)

//Set field alias.
ll_Cnt   = lds_view_fields_alias.Rowcount( )
ll_dwCnt = dw_fields_alias.Rowcount( )
FOR ll_i = 1 to ll_Cnt
	ls_c_name = lds_view_fields_alias.GetItemString(ll_i,"c_name")
	ll_Find = dw_fields_alias.Find("c_name='" + ls_c_name + "'",1,ll_dwCnt)	
	if ll_Find < 1 then
		//if field alias is not exist, then insert it.
		lds_view_fields_alias.Rowscopy( ll_i, ll_i, Primary!, dw_fields_alias, dw_fields_alias.Rowcount() + 1, Primary!)		
	else
		//if field alias is null(''), then replace it.
		ls_c_alias = dw_fields_alias.GetItemString(ll_Find,"c_alias")
		if IsNull(ls_c_alias) then ls_c_alias = ""
		if trim(ls_c_alias) = "" then
			dw_fields_alias.SetItem(ll_Find,"c_alias",lds_view_fields_alias.GetItemString(ll_i,"c_alias"))
		end if
	end if
next

destroy lnvo_Update
destroy lds_view_fields_alias
//---------------------------- APPEON END ----------------------------
end event

type dw_select_view from u_dw within w_view_alias_maintenance
integer x = 55
integer y = 72
integer width = 942
integer height = 76
integer taborder = 10
string dataobject = "d_select_view_list_rpt"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-21 By: Andy
this.of_setupdateable( false )
InsertRow(0)
//---------------------------- APPEON END ----------------------------

end event

event itemchanged;call super::itemchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-24 By: Andy
Long   ll_Row  //, ll_data_view_id
String ls_v_name 

ll_Row = dw_view_alias.GetRow( )
if ll_Row < 1 then return

ls_v_name = dw_view_alias.GetItemString(ll_Row,"v_name")
il_data_view_id = long(data)

dw_fields_alias.retrieve(ls_v_name, il_data_view_id)
//---------------------------- APPEON END ----------------------------

end event

type dw_fields_alias from u_dw within w_view_alias_maintenance
integer x = 1230
integer y = 828
integer width = 1906
integer height = 1364
integer taborder = 20
string dataobject = "d_view_fields_alias_edit"
boolean hscrollbar = true
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

type dw_view_alias from u_dw within w_view_alias_maintenance
integer x = 1230
integer y = 308
integer width = 1906
integer height = 420
integer taborder = 20
string dataobject = "d_view_alias"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-21 By: Andy
Integer li_rtn,ll_Ret
String  ls_Path,ls_FileName

if Lower(String(dwo.name)) = 'b_upload' then 
	//---------Begin Modified by (Appeon)Toney 06.14.2013 for V141 ISG-CLX--------	
	  /*
		li_rtn = GetFileOpenName("Select File", &
			 ls_Path, ls_FileName, ".bmp", &
			 "Bitmap (*.bmp),*.bmp,GIF (*.gif),*.gif,JPEG (*.jpg;*.jpeg),*.jpg;*.jpeg" )
		 ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008			
	  */
	gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
	li_rtn = GetFileOpenName("Select File", &
		 ls_Path, ls_FileName, ".bmp", &
		 "Bitmap (*.bmp),*.bmp,GIF (*.gif),*.gif,JPEG (*.jpg;*.jpeg),*.jpg;*.jpeg" )
	gf_save_dir_path(ls_Path) //Added by Ken.Guo on 2009-03-10	 
	//---------End Modfiied ------------------------------------------------------------------	
	IF li_rtn < 1 THEN RETURN
	
	this.SetItem(Row,"p_name",ls_FileName)
	//Upload image
	ll_Ret = of_upload_image(ls_Path)
	if ll_Ret = 1 then 
		this.SetItem(Row,"datalen",1)
	end if
end if

if Lower(String(dwo.name)) = 'b_missing' then 
	long ll_id
	integer m
	string ls_view
	
		
	ls_view = this.getitemstring( row, "v_name")
	m = this.getitemnumber( row, "module")
	choose case m
		case 3  //other
			m = 0
		case else
			m = il_data_view_id
	end choose
			
	if gs_dbtype = "ASA" then
		select table_id into :ll_id from sys.systable where table_name = :ls_view;
	else
		ll_id = 0
	end if
	
	of_view_alias_add_missing_fields(ls_view, ll_id, m)
	dw_fields_alias.retrieve(ls_view, il_data_view_id)
end if
	
	return 1
end event

event pfc_update;call super::pfc_update;//$<add> 2007-12-21 By: Andy
Return of_update_image()
end event

event retrieveend;call super::retrieveend;//$<add> 01.25.2008 by Andy
String ls_sflag
Long   ll_Row

this.Modify("b_1.enabled=true")

if rowcount = 0 then return
ll_Row = this.GetRow()
if ll_Row < 1 then return 

ls_sflag = this.GetItemString(ll_Row,"sflag")
if IsNull(ls_sflag) then ls_sflag = 'N'
if Upper(ls_sflag) = 'Y' then 
	this.Modify("b_1.enabled=false")
else
	this.Modify("b_1.enabled=true")
end if
end event

type dw_1 from datawindow within w_view_alias_maintenance
integer x = 23
integer y = 208
integer width = 1170
integer height = 100
integer taborder = 10
boolean enabled = false
boolean titlebar = true
string title = "View List"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type tv_view from u_tvs_rpt within w_view_alias_maintenance
integer x = 23
integer y = 304
integer width = 1170
integer height = 1888
integer taborder = 10
string facename = "Segoe UI"
long backcolor = 33551856
end type

event constructor;call super::constructor;String ls_dataobject1, ls_dataobject2

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 12.08.2016
//<$>reason:for Issue id 5351 - SQL Server 2014 and 2016 Partial Contained Databases and High Availability Groups

////--------------------------- APPEON BEGIN ---------------------------
////$<add> 2007-12-20 By: Andy
//this.of_register( 1, "module", "name", "", "d_view_module_all", SQLCA, "")
//this.of_register( 2, "v_name", "v_alias", ":al_module,:al_view_id", "d_view_names", SQLCA, "")
////---------------------------- APPEON END ----------------------------
IF gs_dbtype = "SQL" THEN
	ls_dataobject1 = "d_view_module_all_sql"
	ls_dataobject2 = "d_view_names_sql"
ELSE
	ls_dataobject1 = "d_view_module_all_asa"
	ls_dataobject2 = "d_view_names_asa"
END IF
this.of_register( 1, "module", "name", "", ls_dataobject1, SQLCA, "")
this.of_register( 2, "v_name", "v_alias", ":al_module,:al_view_id", ls_dataobject2, SQLCA, "")
//------------------- APPEON END -------------------
end event

event selectionchanged;call super::selectionchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-21 By: Andy
Integer      li_level
Long         ll_module,ll_Root,ll_Cnt,ll_Row
Long         ll_data_view_id
String       ls_v_name,ls_Filter
datawindowchild ldwc
TreeViewItem ltvi,ltvi_Prt

if this.getItem(newhandle,ltvi) = 1 then
	li_level  = ltvi.level	
	if li_level = 1 then
		ll_module = ltvi.data
		dw_view_alias.Reset( )
		dw_fields_alias.Reset( )		
	elseif li_level = 2 then
		ls_v_name = ltvi.data
		ll_Root = this.Finditem( ParentTreeItem!, newhandle)
		if ll_Root > 0 then 
			if this.getItem(ll_Root,ltvi_Prt) = 1 then
				ll_module = ltvi_Prt.data
			end if
		end if		
	end if
	
	//Filter data for data_view_id
	if ll_module <> il_OrigModule then 
		il_OrigModule = ll_module
		if ll_module = 1 then 
			ls_Filter = "Upper(type_c)='C'"
			ll_data_view_id = 1001
		elseif ll_module = 2 then
			ls_Filter = "Upper(type_c)='P'"
			ll_data_view_id = 1
		else
			ls_Filter = "1=2"
			ll_data_view_id = 0
		end if		
		if dw_select_view.GetChild("data_view_id",ldwc) = 1 then 
			ldwc.SetTransObject( SQLCA )
			ldwc.SetFilter( ls_Filter )
			ldwc.Filter( )
		end if
		dw_select_view.setitem(1,"data_view_id",ll_data_view_id)
	end if
	
	if li_level = 2 then
		//Retrieve view alias
		ll_Cnt = dw_view_alias.Retrieve(ls_v_name)
		//if view alias not exists, then add it.
		if ll_Cnt < 1 then 
			ll_Row = dw_view_alias.InsertRow(0)
			dw_view_alias.SetItem(ll_Row,"module", ll_module)
			dw_view_alias.SetItem(ll_Row,"v_name", ls_v_name)
			dw_view_alias.SetItem(ll_Row,"sflag" , "N")
			dw_view_alias.SetItem(ll_Row,"new_rec" , 1)
			//Set row status New!
			dw_view_alias.SetItemStatus( ll_Row, 0, Primary!, NotModified!	)
		end if
		ll_data_view_id = dw_select_view.GetItemNumber( 1 , "data_view_id")
		dw_fields_alias.Retrieve( ls_v_name, ll_data_view_id )
	end if
	
end if
//---------------------------- APPEON END ----------------------------
il_data_view_id = ll_data_view_id   //Start Code Change ----05.23.2017 #V154 maha
end event

event selectionchanging;call super::selectionchanging;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-21 By: Andy
Integer li_Ret,ll_R

li_Ret = of_updatespending( )
if li_Ret = 1 then
	ll_R = messagebox(gnv_app.iapp_object.DisplayName,'Do you want to save changes?',question!,yesnocancel!)
	IF ll_R = 1 THEN
		IF event pfc_save() < 0 THEN
			return 1
		END IF
	ELSEIF ll_R = 3 THEN
		return 1
	END IF
end if
//---------------------------- APPEON END ----------------------------
end event

event doubleclicked;//do nothing
end event

event begindrag;//do nothing
end event

event dragdrop;//do nothing
end event

type gb_1 from groupbox within w_view_alias_maintenance
integer x = 23
integer width = 1042
integer height = 184
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select View"
end type

type dw_5 from datawindow within w_view_alias_maintenance
integer x = 1230
integer y = 208
integer width = 1906
integer height = 100
integer taborder = 30
boolean enabled = false
boolean titlebar = true
string title = "View Alias"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

