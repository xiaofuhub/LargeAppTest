$PBExportHeader$w_show_screen_print.srw
forward
global type w_show_screen_print from pfc_w_response
end type
type dw_properties from u_dw within w_show_screen_print
end type
type dw_select_section from u_dw within w_show_screen_print
end type
type dw_3 from u_dw within w_show_screen_print
end type
type dw_2 from u_dw within w_show_screen_print
end type
type dw_1 from u_dw within w_show_screen_print
end type
type st_1 from statictext within w_show_screen_print
end type
type p_1 from picture within w_show_screen_print
end type
end forward

global type w_show_screen_print from pfc_w_response
integer width = 4041
integer height = 2432
string title = "Screen Shot"
dw_properties dw_properties
dw_select_section dw_select_section
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
st_1 st_1
p_1 p_1
end type
global w_show_screen_print w_show_screen_print

type variables
str_intellireport istr_parm

str_intellireport is_ContractScreen[]
str_intellireport is_CredScreen[]

constant Long il_borderWidth = 25

pfc_cst_nv_data_entry_functions inv_data_entry

end variables

forward prototypes
public subroutine of_init ()
public subroutine of_create_dynamic_dw ()
public function integer of_show_invisible (datawindow adw_detail, boolean ab_show)
end prototypes

public subroutine of_init ();//====================================================================
// Event: w_show_screen_print.of_init()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Andy		Date: Jan 23,2008
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//================IntelliContract Screen====================
is_ContractScreen[3].ll_x      = 55  
is_ContractScreen[3].ll_y      = 396
is_ContractScreen[3].ll_width  = 1021
is_ContractScreen[3].ll_height = 1200

is_ContractScreen[4].ll_x      = 55 
is_ContractScreen[4].ll_y      = 1720
is_ContractScreen[4].ll_width  = 1021
is_ContractScreen[4].ll_height = 556

is_ContractScreen[5].ll_x      = 1129  
is_ContractScreen[5].ll_y      = 396
is_ContractScreen[5].ll_width  = 2743
is_ContractScreen[5].ll_height = 356

is_ContractScreen[6].ll_x      = 1129  
is_ContractScreen[6].ll_y      = 880
is_ContractScreen[6].ll_width  = 2735
is_ContractScreen[6].ll_height = 252

is_ContractScreen[7].ll_x      = 1125  
is_ContractScreen[7].ll_y      = 1264
is_ContractScreen[7].ll_width  = 2735
is_ContractScreen[7].ll_height = 336

is_ContractScreen[9].ll_x      = 1129 
is_ContractScreen[9].ll_y      = 1756
is_ContractScreen[9].ll_width  = 2735
is_ContractScreen[9].ll_height = 510

is_ContractScreen[19].ll_x      = 96 
is_ContractScreen[19].ll_y      = 888
is_ContractScreen[19].ll_width  = 3739
is_ContractScreen[19].ll_height = 568

is_ContractScreen[20].ll_x      = 96  
is_ContractScreen[20].ll_y      = 1572
is_ContractScreen[20].ll_width  = 1819
is_ContractScreen[20].ll_height = 648

is_ContractScreen[21].ll_x      = 1994 
is_ContractScreen[21].ll_y      = 1568
is_ContractScreen[21].ll_width  = 1842
is_ContractScreen[21].ll_height = 648

is_ContractScreen[23].ll_x      = 923 
is_ContractScreen[23].ll_y      = 440
is_ContractScreen[23].ll_width  = 2930
is_ContractScreen[23].ll_height = 932

is_ContractScreen[24].ll_x      = 923  
is_ContractScreen[24].ll_y      = 1496
is_ContractScreen[24].ll_width  = 2930
is_ContractScreen[24].ll_height = 292

is_ContractScreen[25].ll_x      = 923 
is_ContractScreen[25].ll_y      = 1896
is_ContractScreen[25].ll_width  = 2930
is_ContractScreen[25].ll_height = 352

is_ContractScreen[26].ll_x      = 114 
is_ContractScreen[26].ll_y      = 452
is_ContractScreen[26].ll_width  = 1893
is_ContractScreen[26].ll_height = 460

is_ContractScreen[27].ll_x      = 2060  
is_ContractScreen[27].ll_y      = 380
is_ContractScreen[27].ll_width  = 1783
is_ContractScreen[27].ll_height = 536

is_ContractScreen[28].ll_x      = 114  
is_ContractScreen[28].ll_y      = 1052
is_ContractScreen[28].ll_width  = 2644
is_ContractScreen[28].ll_height = 1052

is_ContractScreen[29].ll_x      = 2834  
is_ContractScreen[29].ll_y      = 1052
is_ContractScreen[29].ll_width  = 1010
is_ContractScreen[29].ll_height = 1052

is_ContractScreen[31].ll_x      = 59  
is_ContractScreen[31].ll_y      = 392
is_ContractScreen[31].ll_width  = 3785
is_ContractScreen[31].ll_height = 1720

is_ContractScreen[33].ll_x      = 87
is_ContractScreen[33].ll_y      = 780
is_ContractScreen[33].ll_width  = 3744
is_ContractScreen[33].ll_height = 1380

is_ContractScreen[49].ll_x      = 0  
is_ContractScreen[49].ll_y      = 0
is_ContractScreen[49].ll_width  = 0
is_ContractScreen[49].ll_height = 0

//================IntelliCred Screen====================
//$<add> 01.24.2008 by Andy

is_CredScreen[1].ll_x      = 907 
is_CredScreen[1].ll_y      = 455
is_CredScreen[1].ll_width  = 2700
is_CredScreen[1].ll_height = 1588

is_CredScreen[2].ll_x      = 907 
is_CredScreen[2].ll_y      = 455 
is_CredScreen[2].ll_width  = 2700
is_CredScreen[2].ll_height = 1136

is_CredScreen[3].ll_x      = 907  
is_CredScreen[3].ll_y      = 455 
is_CredScreen[3].ll_width  = 2700
is_CredScreen[3].ll_height = 1588

is_CredScreen[4].ll_x      = 907  
is_CredScreen[4].ll_y      = 455 
is_CredScreen[4].ll_width  = 2700
is_CredScreen[4].ll_height = 1588

is_CredScreen[5].ll_x      = 907  
is_CredScreen[5].ll_y      = 455 
is_CredScreen[5].ll_width  = 2700
is_CredScreen[5].ll_height = 1588

is_CredScreen[6].ll_x      = 907  
is_CredScreen[6].ll_y      = 455 
is_CredScreen[6].ll_width  = 2700
is_CredScreen[6].ll_height = 1588

is_CredScreen[7].ll_x      = 907  
is_CredScreen[7].ll_y      = 455 
is_CredScreen[7].ll_width  = 2700
is_CredScreen[7].ll_height = 1588

is_CredScreen[8].ll_x      = 907  
is_CredScreen[8].ll_y      = 455 
is_CredScreen[8].ll_width  = 2700
is_CredScreen[8].ll_height = 1588

is_CredScreen[9].ll_x      = 907  
is_CredScreen[9].ll_y      = 455 
is_CredScreen[9].ll_width  = 2700
is_CredScreen[9].ll_height = 1588

is_CredScreen[10].ll_x      = 907  
is_CredScreen[10].ll_y      = 455 
is_CredScreen[10].ll_width  = 2700
is_CredScreen[10].ll_height = 1136

is_CredScreen[11].ll_x      = 907  
is_CredScreen[11].ll_y      = 455 
is_CredScreen[11].ll_width  = 2700
is_CredScreen[11].ll_height = 1588

is_CredScreen[12].ll_x      = 907  
is_CredScreen[12].ll_y      = 455 
is_CredScreen[12].ll_width  = 2700
is_CredScreen[12].ll_height = 1588

is_CredScreen[13].ll_x      = 907  
is_CredScreen[13].ll_y      = 455 
is_CredScreen[13].ll_width  = 2700
is_CredScreen[13].ll_height = 1588

is_CredScreen[15].ll_x      = 907  
is_CredScreen[15].ll_y      = 455 
is_CredScreen[15].ll_width  = 2700
is_CredScreen[15].ll_height = 1588

is_CredScreen[16].ll_x      = 907  
is_CredScreen[16].ll_y      = 455 
is_CredScreen[16].ll_width  = 2700
is_CredScreen[16].ll_height = 1588

is_CredScreen[17].ll_x      = 907  
is_CredScreen[17].ll_y      = 455 
is_CredScreen[17].ll_width  = 2700
is_CredScreen[17].ll_height = 1588

is_CredScreen[18].ll_x      = 907  
is_CredScreen[18].ll_y      = 455 
is_CredScreen[18].ll_width  = 2700
is_CredScreen[18].ll_height = 1588

is_CredScreen[19].ll_x      = 907  
is_CredScreen[19].ll_y      = 455 
is_CredScreen[19].ll_width  = 2700
is_CredScreen[19].ll_height = 1136

is_CredScreen[20].ll_x      = 907  
is_CredScreen[20].ll_y      = 455 
is_CredScreen[20].ll_width  = 2700
is_CredScreen[20].ll_height = 1588

is_CredScreen[22].ll_x      = 907  
is_CredScreen[22].ll_y      = 455 
is_CredScreen[22].ll_width  = 2700
is_CredScreen[22].ll_height = 1588

is_CredScreen[23].ll_x      = 907  
is_CredScreen[23].ll_y      = 455 
is_CredScreen[23].ll_width  = 2700
is_CredScreen[23].ll_height = 1588

is_CredScreen[24].ll_x      = 907  
is_CredScreen[24].ll_y      = 455 
is_CredScreen[24].ll_width  = 2700
is_CredScreen[24].ll_height = 1588

is_CredScreen[25].ll_x      = 907  
is_CredScreen[25].ll_y      = 455 
is_CredScreen[25].ll_width  = 2700
is_CredScreen[25].ll_height = 1588

is_CredScreen[26].ll_x      = 907  
is_CredScreen[26].ll_y      = 455 
is_CredScreen[26].ll_width  = 2700
is_CredScreen[26].ll_height = 1588

is_CredScreen[32].ll_x      = 907  
is_CredScreen[32].ll_y      = 455 
is_CredScreen[32].ll_width  = 2700
is_CredScreen[32].ll_height = 1588

is_CredScreen[65].ll_x      = 907  
is_CredScreen[65].ll_y      = 455 
is_CredScreen[65].ll_width  = 2700
is_CredScreen[65].ll_height = 1588

is_CredScreen[103].ll_x      = 907  
is_CredScreen[103].ll_y      = 455 
is_CredScreen[103].ll_width  = 2700
is_CredScreen[103].ll_height = 1588

is_CredScreen[105].ll_x      = 907  
is_CredScreen[105].ll_y      = 455 
is_CredScreen[105].ll_width  = 2700
is_CredScreen[105].ll_height = 1588

is_CredScreen[107].ll_x      = 907  
is_CredScreen[107].ll_y      = 455 
is_CredScreen[107].ll_width  = 2700
is_CredScreen[107].ll_height = 1588

is_CredScreen[70].ll_x      = 907  
is_CredScreen[70].ll_y      = 455 
is_CredScreen[70].ll_width  = 2700
is_CredScreen[70].ll_height = 1588

is_CredScreen[71].ll_x      = 907  
is_CredScreen[71].ll_y      = 455 
is_CredScreen[71].ll_width  = 2700
is_CredScreen[71].ll_height = 1588

is_CredScreen[72].ll_x      = 907  
is_CredScreen[72].ll_y      = 455 
is_CredScreen[72].ll_width  = 2700
is_CredScreen[72].ll_height = 1588

dw_select_section.x = 82
dw_select_section.y = 430
dw_select_section.width = 795
dw_select_section.height= 1696
	
//================create inv_data_entry====================
//$<add> 01.24.2008 by Andy
if istr_parm.ll_module = 2 then 
	inv_data_entry = CREATE pfc_cst_nv_data_entry_functions
	inv_data_entry.of_setup_cache()	
	app_filler.ids_screen_fields_cache.ShareData( inv_data_entry.ids_screen_fields )
	inv_data_entry.of_refresh_cache()	
	dw_select_section.Retrieve( istr_parm.ll_data_view_id )		
end if

end subroutine

public subroutine of_create_dynamic_dw ();//====================================================================
// Event: w_show_screen_print.of_create_dynamic_dw()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	integer	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Andy		Date: Jan 23,2008
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String ls_screen,ls_ScreenArray[]
Long   ll_ScreenCnt,ll_i,ll_screenID
n_cst_string lnvo_string
String ls_dwsyntax,ls_screenID,ls_ERRORS
datawindow ldw
Long   ll_Find

if istr_parm.ll_module > 2 then return

ls_screen = istr_parm.ls_screen
ls_Screen = ls_Screen + ','
lnvo_string.of_parsetoarray( ls_Screen, ',', ls_ScreenArray )
ll_ScreenCnt = UpperBound(ls_ScreenArray)

FOR ll_i = 1 to ll_ScreenCnt
	//Only support 3 dw
	if ll_i > 3 then continue
	
	ls_screenID = ls_ScreenArray[ll_i]
	if Not IsNumber(ls_screenID) then continue
	ll_screenID = Long(ls_screenID)
	
	if ll_i = 1 then
		ldw = dw_1			
	elseif ll_i = 2 then 
		ldw = dw_2
	elseif ll_i = 3 then
		ldw = dw_3
	end if
	
	if istr_parm.ll_module = 1 then
		//$<modify> 05.20.2008 by Andy 
		//$<Reason> fixed BugG052001(add:if statement)
		//---------Begin Modified by (Appeon)Toney 06.13.2013 for V141 ISG-CLX--------		
		  /*
			IF AppeonGetClientType() = "WEB" THEN
				SELECT dw_sql
				INTO :ls_dwsyntax
				FROM ctx_screen 
				WHERE data_view_id = :istr_parm.ll_data_view_id 
				AND screen_id = :ll_screenID;
			ELSE
				ls_dwsyntax = f_get_screen_sql(istr_parm.ll_data_view_id,ll_screenID)
			END IF				
		  */
		string ls_screen_style
		IF AppeonGetClientType() = "WEB" THEN
			SELECT ( case when screen_style = 'G' Then grid_sql else dw_sql end ) 
			INTO :ls_dwsyntax
			FROM ctx_screen 
			WHERE data_view_id = :istr_parm.ll_data_view_id 
			AND screen_id = :ll_screenID;
		ELSE
				/********************************************///added by gavins 20120313 grid
				SELECT screen_style
					INTO :ls_Screen_style
					FROM ctx_screen 
					WHERE data_view_id = :istr_parm.ll_data_view_id 
					AND screen_id = :ll_screenID;
				/********************************************/		
				If ls_Screen_style = 'G' Then
					ls_dwsyntax = f_get_screen_gridsql(istr_parm.ll_data_view_id,ll_screenID,false)  //add false argu -jervis 10.11.2011
				Else
					ls_dwsyntax = f_get_screen_sql(istr_parm.ll_data_view_id,ll_screenID,false) //add false argu - jervis 10.11.2011
				End If
		END IF		 
		//---------End Modfiied ------------------------------------------------------------------
		//end 05.20.2008
		ldw.Create( ls_dwsyntax, ls_ERRORS)
		ldw.x      = is_ContractScreen[ll_screenID].ll_x
		ldw.y      = is_ContractScreen[ll_screenID].ll_y
		ldw.width  = is_ContractScreen[ll_screenID].ll_width
		ldw.height = is_ContractScreen[ll_screenID].ll_height
		ldw.modify( "datawindow.Color='" + string(RGB(220,224,248)) + "'" )
	elseif istr_parm.ll_module = 2 then
		//$<add> 01.24.2008 by Andy
		dw_properties.Retrieve( istr_parm.ll_data_view_id, ll_screenID )		
		inv_data_entry.of_create_dynamic_dw(0, istr_parm.ll_data_view_id, ll_screenID, ldw, ldw, true, 0, true )
		this.of_show_invisible(ldw,true)
		
		ldw.x      = is_CredScreen[ll_screenID].ll_x
		ldw.y      = is_CredScreen[ll_screenID].ll_y
		ldw.width  = is_CredScreen[ll_screenID].ll_width
		ldw.height = is_CredScreen[ll_screenID].ll_height
		
		IF ll_screenID = 2 or ll_screenID = 10 or ll_screenID = 19 THEN
			ldw.modify( "datawindow.Color='" + string(RGB(220,224,248)) + "'" )
			if ll_screenID = 2 then ldw.VScrollbar = TRUE
		END IF
		
		ll_Find = dw_select_section.Find("screen_id=" + string(ll_screenID),1,dw_select_section.RowCount())
		if ll_Find > 0 then
			dw_select_section.scrolltorow( ll_Find )
			dw_select_section.setrow(ll_Find)
			dw_select_section.selectrow( 0, false)
			dw_select_section.selectrow( ll_Find, true)
		end if
		//ldw.modify("datawindow.HorizontalScrollPosition=0")
		ldw.HScrollBar = false		
		ldw.Border	   = false		
	end if
		
	ldw.visible = true
	if ldw.RowCount() < 1 then ldw.insertrow(0)	
NEXT

if istr_parm.ll_module = 2 then 
	dw_select_section.visible = true	
end if

end subroutine

public function integer of_show_invisible (datawindow adw_detail, boolean ab_show);Integer li_rc
Integer i
String ls_fld

dw_properties.SetFilter("")
dw_properties.Filter( )
li_rc = dw_properties.RowCount()

FOR i = 1 TO li_rc
	IF dw_properties.GetItemString( i, "data_view_fields_visible" ) = "Y" THEN
		CONTINUE
	END IF
	ls_fld = dw_properties.GetItemString( i, "sys_fields_field_name" )
	IF NOT ab_show THEN
		adw_detail.Modify( ls_fld + ".Visible = 1")	
		adw_detail.Modify( ls_fld + "_t.Visible = 1")	
	ELSE
		adw_detail.Modify( ls_fld + ".Visible = 0")	
		adw_detail.Modify( ls_fld + "_t.Visible = 0")			
	END IF
END FOR

RETURN 1
end function

on w_show_screen_print.create
int iCurrent
call super::create
this.dw_properties=create dw_properties
this.dw_select_section=create dw_select_section
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.st_1=create st_1
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_properties
this.Control[iCurrent+2]=this.dw_select_section
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.p_1
end on

on w_show_screen_print.destroy
call super::destroy
destroy(this.dw_properties)
destroy(this.dw_select_section)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.p_1)
end on

event open;call super::open;//$<add> 01.22.2008 by Andy
istr_parm = message.powerobjectparm
if Not isValid(istr_parm) or IsNull(istr_parm) then return

this.setredraw(false)
p_1.setredraw(false)

p_1.PictureName = istr_parm.ls_FileName
p_1.OriginalSize= true
st_1.text = "Screen Shot for " + istr_parm.ls_v_alias
p_1.x = il_borderWidth
p_1.y = il_borderWidth * 2 + st_1.height
this.width = p_1.x + p_1.width  + il_borderWidth * 2
this.height= p_1.y + p_1.height + il_borderWidth * 3 + st_1.height

of_init()
of_create_dynamic_dw()
this.setredraw(true)
p_1.setredraw(true)

end event

event close;call super::close;//$<add> 01.24.2008 by Andy
if istr_parm.ll_module = 2 then 
	if IsValid(inv_data_entry) then 
		inv_data_entry.ids_screen_fields.sharedataoff( )
		destroy inv_data_entry
	end if
end if
end event

event closequery;//do nothing
end event

type dw_properties from u_dw within w_show_screen_print
boolean visible = false
integer x = 23
integer y = 480
integer width = 690
integer height = 1204
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_sys_field_properties"
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateable(False)
end event

type dw_select_section from u_dw within w_show_screen_print
boolean visible = false
integer x = 1431
integer y = 428
integer width = 699
integer height = 400
integer taborder = 20
boolean enabled = false
string title = "none"
string dataobject = "d_data_view_screens_list"
boolean hscrollbar = true
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;This.of_SetUpdateable(False)
end event

type dw_3 from u_dw within w_show_screen_print
boolean visible = false
integer x = 256
integer y = 1284
integer width = 686
integer height = 400
integer taborder = 30
boolean enabled = false
string title = "none"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetUpdateable(False)

end event

type dw_2 from u_dw within w_show_screen_print
boolean visible = false
integer x = 256
integer y = 720
integer width = 686
integer height = 400
integer taborder = 20
boolean enabled = false
string title = "none"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetUpdateable(False)

end event

type dw_1 from u_dw within w_show_screen_print
boolean visible = false
integer x = 256
integer y = 252
integer width = 2629
integer height = 1484
integer taborder = 10
boolean enabled = false
string title = "none"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetUpdateable(False)
This.of_SetReqColumn(TRUE)
end event

event itemfocuschanged;//
end event

type st_1 from statictext within w_show_screen_print
integer x = 23
integer y = 24
integer width = 1390
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type p_1 from picture within w_show_screen_print
integer x = 23
integer y = 104
integer width = 3717
integer height = 1256
string pointer = "No!"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

