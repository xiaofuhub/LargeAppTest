$PBExportHeader$pfc_cst_u_band_report.sru
$PBExportComments$(Appeon)Toney 06.10.2013 - V141 ISG-CLX
forward
global type pfc_cst_u_band_report from u_dw
end type
end forward

global type pfc_cst_u_band_report from u_dw
integer width = 494
integer height = 360
integer taborder = 10
event ue_regenerate ( )
event ue_afterdrag ( )
event ue_postopen ( )
event ue_key pbm_dwnkey
event ue_calc_tab_position ( )
event ue_mouse_move pbm_dwnmousemove
end type
global pfc_cst_u_band_report pfc_cst_u_band_report

type prototypes
Function ulong SetCapture(ulong hWnd) Library "USER32.DLL"
Function BOOLEAN ReleaseCapture() Library "USER32.DLL"
end prototypes

type variables

datawindow idw_syntax
long   cil_HighLightColor=15793151
string   is_BandType,is_objects[],is_null[]
string   is_OrgObj,is_CurObj,is_lastdwoname

boolean    ib_draging=FALSE,ib_MoveSelf=FALSE

w_report_data_design   iw_parentwin

pfc_cst_u_report_data_design iuo_parent

long    il_LineOrgX,il_LineOrgY
private  :
boolean   ib_mousesel//,ib_capture
//ulong     iu_cputime,iu_delay
end variables

forward prototypes
public function integer of_getobjects (ref string as_objlist[], string as_objtype, string as_band, boolean ab_visibleonly)
public function integer of_unselectobj (string as_name)
public function integer of_selectobject (string as_name)
public subroutine of_getgroupobjects (string as_groupobjects[])
public function integer of_setdesign (string as_objname)
public subroutine of_populatedw ()
public function integer of_show_invisible (boolean ab_show)
public function integer of_setdesign (boolean ab_true)
public function integer of_set_dw_properties (string as_column_name)
public function integer of_modifytextproperties (string as_property)
public function integer of_settextdisplayproperties ()
public subroutine of_setuserobject (pfc_cst_u_report_data_design auo_obj)
end prototypes

event ue_regenerate();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-05 By: Andy
string  ls_modify,ls_Array[]
Long    ll_row
string  ls_modify1

this.settransobject(SQLCA)
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05/14/2008 By: Ken.Guo
//$<reason> Added By Ken.Guo. Workaround APB Bug26761.
Long ll_cnt,i
//If Upper(is_BandType) <> 'DETAIL' Then
	ll_cnt = Long(this.object.datawindow.Column.Count)
	For i = 1 to ll_cnt
		This.Modify("#"+String(i)+".TabSequence = '0'")
	Next
//End If
//---------------------------- APPEON END ----------------------------

CHOOSE CASE  Upper(is_BandType)
	CASE 'HEADER'
		ls_Modify = "datawindow.detail.height=0~tdatawindow.summary.height=0~tdatawindow.footer.height=0"
		ls_Modify1 = "datawindow.header.1.height=0~tdatawindow.trailer.1.height=0"
	CASE 'DETAIL'
		ls_Modify = "datawindow.header.height=0~tdatawindow.summary.height=0~tdatawindow.footer.height=0"
		ls_Modify1 = "datawindow.header.1.height=0~tdatawindow.trailer.1.height=0"
	CASE 'SUMMARY'
		ls_Modify = "datawindow.detail.height=0~tdatawindow.header.height=0~tdatawindow.footer.height=0"
		ls_Modify1 = "datawindow.header.1.height=0~tdatawindow.trailer.1.height=0"
	CASE 'FOOTER'
		ls_Modify = "datawindow.detail.height=0~tdatawindow.summary.height=0~tdatawindow.header.height=0"
		ls_Modify1 = "datawindow.header.1.height=0~tdatawindow.trailer.1.height=0"
	CASE 'HEADERGROUP','HEADER.1'
		ls_Modify = "datawindow.header.height=0~tdatawindow.detail.height=0~tdatawindow.summary.height=0~tdatawindow.footer.height=0"
		ls_Modify1 = "datawindow.trailer.1.height=0"
	CASE 'TRAILERGROUP','TRAILER.1'
		ls_Modify = "datawindow.header.height=0~tdatawindow.detail.height=0~tdatawindow.summary.height=0~tdatawindow.footer.height=0"
		ls_Modify1 = "datawindow.header.1.height=0"	
	CASE ELSE
		RETURN 
END CHOOSE
//Start add By Jervis 03.25.2008
ls_Modify += " DataWindow.Detail.Height.AutoSize=No" 
//End add By Jervis 03.25.2008



this.modify(ls_Modify)
this.modify(ls_Modify1)
////$<add> 01.12.2008 by Andy
//if Long( this.Describe("Datawindow.Header.1.Height")) > 0 then
//	this.modify("Datawindow.Header.1.Height=0")	
//end if
//if Long( this.Describe("Datawindow.Trailer.1.Height")) > 0 then
//	this.modify("Datawindow.Trailer.1.Height=0")	
//end if
////end of add 01.12.2008
is_objects = ls_Array
is_CurObj = ''
is_OrgObj = ''

of_getobjects(is_objects[],'*',is_BandType,FALSE)

ll_row = this.insertrow(0)
//
if is_BandType="HEADERGROUP" or is_BandType="TRAILERGROUP" or is_BandType="HEADER.1" or is_BandType="TRAILER.1" then this.groupcalc()
this.bringtotop = TRUE
	
of_setdesign(true)

of_populatedw()

//---------------------------- APPEON END ----------------------------





end event

event ue_afterdrag();
long   ll_y,ll_x,ll_x1,ll_x2,ll_y1,ll_y2,ll_pos
string   ls_Band,ls_Modify,ls_Move,ls,ls_x,ls_y,ls_x1,ls_x2,ls_y1,ls_y2,ls_buff,ls_char1,ls_char2

IF is_CurObj = '' THEN return

IF this.describe(is_CurObj+".type") <> 'line' THEN 
	ls_Move = is_CurObj+".y = "+this.describe(is_CurObj+".y")
	ls_move+= "~t"+is_CurObj+".x = "+this.describe(is_CurObj+".x")
	
	ls_Move += "~t"+is_CurObj+".width = "+this.describe(is_CurObj+".width")
	ls_move += "~t"+is_CurObj+".height = "+this.describe(is_CurObj+".height")	

	this.modify(ls_move)
ELSE	
	ll_x = this.pointerx()
	ll_y = this.pointery()
	ls_y1 = this.describe(is_CurObj+".y1")
	ls_y2 = this.describe(is_CurObj+".y2")
	ls_x1 = this.describe(is_CurObj+".x1")
	ls_x2 = this.describe(is_CurObj+".x2")
			
	ll_x = ll_x - il_lineorgx 
	ll_y = ll_y - il_lineorgy
			
	ll_pos = pos(ls_y1,"~t")
	if ll_pos > 0 then
		ls_buff = left(ls_y1,ll_pos -1)
		if left(ls_buff,1) = "'" or left(ls_buff,1) = '"' then 
			ls_char1 = left(ls_buff,1)
			ls_buff = right(ls_buff,len(ls_buff) -1)
		end if 
		ll_y1 = long(ls_buff)
	else
		ll_y1 = long(ls_y1)
	end if 
	
	ll_pos = pos(ls_y2,"~t")
	if ll_pos > 0 then
		ls_buff = left(ls_y2,ll_pos -1)
		if left(ls_buff,1) = "'" or left(ls_buff,1) = '"' then 
			ls_char2 = left(ls_buff,1)
			ls_buff = right(ls_buff,len(ls_buff) -1)
		end if 
		ll_y2 = long(ls_buff)
	else
		ll_y2 = long(ls_y2)
	end if 

	if ll_y1 < ll_y2 then 
		if ll_y1 + ll_y < 0 then 
			ll_y = 0 - ll_y1
		end if 
	else
		if ll_y2 + ll_y < 0 then 
			ll_y = 0 - ll_y2
		end if 
	end if 
	
	if ll_x1 < ll_x2 then 
		if ll_x1 + ll_x < 0 then 
			ll_x = 0 - ll_x1
		end if 
	else
		if ll_x2 + ll_x < 0 then 
			ll_x = 0 - ll_x2
		end if 
	end if 
	
	ll_pos = pos(ls_y1,"~t")
	if ll_pos > 0 then 
		ls_y1 = ls_char1 + String(ll_y1 + ll_y ) + right(ls_y1,len(ls_y1) - ll_pos +1)
	else
		ls_y1 = String(ll_y1 + ll_y )
	end if 
	
	ll_pos = pos(ls_y2,"~t")
	if ll_pos > 0 then 
		ls_y2 = ls_char2 + String(ll_y2 + ll_y ) + right(ls_y2,len(ls_y2) - ll_pos +1)
	else
		ls_y2 = String(ll_y2 + ll_y )
	end if 
	
	ls = string(long(this.describe(is_CurObj+".x1")) + ll_x)
	ls_move = is_CurObj+".x1="+ls
	ls = ls_y1
	ls_move +="~t"+is_CurObj+".y1="+ls
	ls = string(long(this.describe(is_CurObj+".x2")) + ll_x)
	ls_move +="~t"+ is_CurObj+".x2="+ls
	ls = ls_y2
	ls_move +="~t"+is_CurObj+".y2="+ls
				
	this.modify(ls_move)
END IF

iw_parentwin.event ue_setmodify(ls_move)



end event

event ue_postopen();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-05 By: Andy
this.of_getparentwindow(iw_parentwin) 
//---------------------------- APPEON END ----------------------------
end event

event ue_key;
string   ls_Modify,ls,ls_y1,ls_y2,ls_buff,ls_char1,ls_char2
long   ll,ll_pos,ll_x1,ll_x2,ll_y1,ll_y2

//keyflags: 0----none
//				1---shift key
//				2---ctrl key
//				3--shift&ctrl key

if iuo_parent.ib_set_tab_order OR iuo_parent.il_dw_style = 1 then return 1

IF upperbound(iw_Parentwin.istr_SelectObj[]) > 0 THEN
	CHOOSE CASE key
		CASE keyleftarrow!, keyrightarrow!,keydownarrow!,keyuparrow!
			iw_ParentWin.post event Key(key,keyflags)
	END CHOOSE
	return 1
END IF

IF is_CurObj = '' THEn return 1

IF keyflags = 0  THEN
	
	CHOOSE CASE key 
		CASE keyleftarrow!
			IF this.describe(is_CurObj+".type") <> 'line' THEN 
				ll = long(this.describe(is_CurObj+".x")) - 4
				IF ll > 0 THEN
					ls_Modify = is_CurObj + ".x = " + string(ll)
				END IF
			else
				ll_x1 = long(this.describe(is_CurObj+".x1"))
				ll_x2 = long(this.describe(is_CurObj+".x2"))
				if ll_x1 - 4 >=0 and ll_x2 - 4 >=0 then 
					ls = string(long(this.describe(is_CurObj+".x1")) - 4)
					ls_Modify = is_CurObj+".x1="+ls
					ls = string(long(this.describe(is_CurObj+".x2")) - 4)
					ls_Modify +="~t"+ is_CurObj+".x2="+ls
				end if 
			end if
		CASE keyrightarrow!
			IF this.describe(is_CurObj+".type") <> 'line' THEN 
				ls_Modify = is_CurObj + ".x = " + string(long(this.describe(is_CurObj+".x")) + 4)
			else
				ls = string(long(this.describe(is_CurObj+".x1")) + 4)
				ls_Modify = is_CurObj+".x1="+ls
				ls = string(long(this.describe(is_CurObj+".x2")) + 4)
				ls_Modify +="~t"+ is_CurObj+".x2="+ls
			end if
		CASE keyuparrow!
			IF this.describe(is_CurObj+".type") <> 'line' THEN 
				ll = long(this.describe(is_CurObj+".y")) - 4
				IF ll > 0 THEN
					ls_Modify = is_CurObj + ".y = " + string(ll)
				END IF
				ls_Modify = is_CurObj + ".y = " + string(long(this.describe(is_CurObj+".y")) - 4)
			else
				ls_y1 = this.describe(is_CurObj+".y1")
				ls_y2 = this.describe(is_CurObj+".y2")
				
				ll_pos = pos(ls_y1,"~t")
				if ll_pos > 0 then
					ls_buff = left(ls_y1,ll_pos -1)
					if left(ls_buff,1) = "'" or left(ls_buff,1) = '"' then 
						ls_char1 = left(ls_buff,1)
						ls_buff = right(ls_buff,len(ls_buff) -1)
					end if 
					ll_y1 = long(ls_buff)
					ls_y1 = ls_char1 +  String(ll_y1 -4)  + right(ls_y1,len(ls_y1) - ll_pos +1)
				else
					ll_y1 = long(this.describe(is_CurObj+".y1"))
					ls_y1 = string( ll_y1 - 4)
				end if 
				
				ll_pos = pos(ls_y2,"~t")
				if ll_pos > 0 then
					ls_buff = left(ls_y2,ll_pos -1)
					if left(ls_buff,1) = "'" or left(ls_buff,1) = '"' then 
						ls_char2 = left(ls_buff,1)
						ls_buff = right(ls_buff,len(ls_buff) -1)
					end if 
					ll_y2 = long(ls_buff)
					ls_y2 = ls_char2 +  String(ll_y2 -4)  + right(ls_y2,len(ls_y2) - ll_pos +1)
				else
					ll_y2 = long(this.describe(is_CurObj+".y2"))
					ls_y2 = string( ll_y2 - 4)
				end if 
				if ll_y1 -4 >= 0 and ll_y2 -4 >= 0 then 
					ls_Modify = is_CurObj+".y1="+ls_y1
					ls_Modify +="~t"+ is_CurObj+".y2="+ls_y2
				end if 
			end if
		CASE keydownarrow!
			IF this.describe(is_CurObj+".type") <> 'line' THEN 
				ls_Modify = is_CurObj + ".y = " + string(long(this.describe(is_CurObj+".Y")) + 4)
			else
				ls_y1 = this.describe(is_CurObj+".y1")
				ls_y2 = this.describe(is_CurObj+".y2")
				
				ll_pos = pos(ls_y1,"~t")
				if ll_pos > 0 then
					ls_buff = left(ls_y1,ll_pos -1)
					if left(ls_buff,1) = "'" or left(ls_buff,1) = '"' then 
						ls_char1 = left(ls_buff,1)
						ls_buff = right(ls_buff,len(ls_buff) -1)
					end if 
					ll_y1 = long(ls_buff)
					ls = ls_char1 +  String(ll_y1 +4)  + right(ls_y1,len(ls_y1) - ll_pos +1)
				else
					ls = string(long(this.describe(is_CurObj+".y1")) + 4)
				end if 
				ls_Modify = is_CurObj+".y1="+ls
				ll_pos = pos(ls_y2,"~t")
				if ll_pos > 0 then
					ls_buff = left(ls_y2,ll_pos -1)
					if left(ls_buff,1) = "'" or left(ls_buff,1) = '"' then 
						ls_char2 = left(ls_buff,1)
						ls_buff = right(ls_buff,len(ls_buff) -1)
					end if 
					ll_y2 = long(ls_buff)
					ls = ls_char2 +  String(ll_y2 +4)  + right(ls_y2,len(ls_y2) - ll_pos +1)
				else
					ls = string(long(this.describe(is_CurObj+".y2")) + 4)
				end if 
				ls_Modify +="~t"+ is_CurObj+".y2="+ls
			end if
		CASE else
			return 1
	END CHOOSE
	IF isnull(ls_Modify) OR ls_Modify = '' THEN return 1
	this.modify(ls_modify)
	iw_parentwin.event ue_setmodify(ls_modify)
	
ELSEIF keyflags = 1 THEN 
	CHOOSE CASE key 
		CASE keyleftarrow!
			IF this.describe(is_CurObj+".type") <> 'line' THEN 
				ll = long(this.describe(is_CurObj+".width")) - 4
				IF ll > 0 THEN
					ls_Modify = is_CurObj + ".width = " + string(ll)
				END IF
			else
				ll_x2 = long(this.describe(is_CurObj+".x2"))
				if  ll_x2 - 4 >=0 then 
					ls = string(long(this.describe(is_CurObj+".x2")) - 4)
					ls_Modify = is_CurObj+".x2="+ls
				end if 
			end if
		CASE keyrightarrow!
			IF this.describe(is_CurObj+".type") <> 'line' THEN 
				ls_Modify = is_CurObj + ".width = " + string(long(this.describe(is_CurObj+".width")) + 4)
			else
				ls = string(long(this.describe(is_CurObj+".x2")) + 4)
				ls_Modify = is_CurObj+".x2="+ls
			end if
		CASE keyuparrow!
			IF this.describe(is_CurObj+".type") <> 'line' THEN 
				ll = long(this.describe(is_CurObj+".height")) - 4
				IF ll > 0 THEN
					ls_Modify = is_CurObj + ".height = " + string(ll)
				END IF
			else
				ls_y2 = this.describe(is_CurObj+".y2")
				ll_pos = pos(ls_y2,"~t")
				if ll_pos > 0 then
						ls_buff = left(ls_y2,ll_pos -1)
						if left(ls_buff,1) = "'" or left(ls_buff,1) = '"' then 
							ls_char2 = left(ls_buff,1)
							ls_buff = right(ls_buff,len(ls_buff) -1)
						end if 
						ll_y2 = long(ls_buff)
						ls = ls_char2 +  String(ll_y2 -4)  + right(ls_y2,len(ls_y2) - ll_pos +1)
				else
					ls = string(long(this.describe(is_CurObj+".y2")) - 4)
				end if
				//$<modify> 01.08.2008 by: Andy
				//ls_Modify = is_CurObj+".y2="+ls
				ls_Modify = is_CurObj+".y1="+ls+" "+is_CurObj+".y2="+ls
				//end of modify 01.08.2008
			end if
		CASE keydownarrow!
			IF this.describe(is_CurObj+".type") <> 'line' THEN 
				ls_Modify = is_CurObj + ".height = " + string(long(this.describe(is_CurObj+".height")) + 4)
			else
				ls_y2 = this.describe(is_CurObj+".y2")
				ll_pos = pos(ls_y2,"~t")
				if ll_pos > 0 then
						ls_buff = left(ls_y2,ll_pos -1)
						if left(ls_buff,1) = "'" or left(ls_buff,1) = '"' then 
							ls_char2 = left(ls_buff,1)
							ls_buff = right(ls_buff,len(ls_buff) -1)
						end if 
						ll_y2 = long(ls_buff)
						ls = ls_char2 +  String(ll_y2 +4)  + right(ls_y2,len(ls_y2) - ll_pos +1)
				else
					ls = string(long(this.describe(is_CurObj+".y2")) + 4)
				end if 
				//$<modify> 01.08.2008 by: Andy
				//ls_Modify = is_CurObj+".y2="+ls
				ls_Modify = is_CurObj+".y1="+ls+" "+is_CurObj+".y2="+ls
				//end of modify 01.08.2008
			end if
		CASE ELSE
			return 1
	END CHOOSE
	IF isnull(ls_Modify) OR ls_Modify = '' THEN return 1
	this.modify(ls_modify)
	iw_parentwin.event ue_setmodify(ls_modify)
ELSEIF keyflags = 2 then 	
	CHOOSE CASE key
		CASE keyleftarrow!, keyrightarrow!,keydownarrow!,keyuparrow!,keya!
			iw_ParentWin.post event Key(key,keyflags)
	END CHOOSE
	return 1
ELSEIF keyflags = 3 then 	
	CHOOSE CASE key
		CASE keyleftarrow!, keyrightarrow!,keydownarrow!,keyuparrow!,keyA!
			iw_ParentWin.post event Key(key,keyflags)
	END CHOOSE
	return 1
END IF

return 1




end event

event ue_mouse_move;IF iuo_parent.il_dw_style = 1 THEN RETURN

Integer i
String ls_field_id
Long ll_x
Long ll_new_width
Long ll_y
Long ll_orig_x
Long ll_orig_y
Long ll_y_diff
Long ll_x_diff
Long ll_new_height
Long ll_curr_scroll_pos
String ls_Modify
string	ls_name
long	   ll_find,ll_object_id
string   ls_col_name

IF iuo_parent.ii_obj_select_cnt = 0 OR iuo_parent.ib_set_tab_order THEN
	RETURN
END IF

string ls_selected_object,ls_selected_object_name
ls_selected_object = This.GetObjectAtPointer()
ls_selected_object_name = Mid(ls_selected_object, 1, Pos(ls_selected_object, "	" ) -1 )

IF NOT iuo_parent.ib_resize_height AND NOT iuo_parent.ib_resize_width AND iuo_parent.ib_mouse_down AND Len(iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt]) > 0 AND iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] <> "dw"  AND	iuo_parent.ib_control_down = False THEN		
	SetPointer(Cross!)
	ll_y_diff = (This.Pointery() - iuo_parent.il_last_object_y[1] ) + (iuo_parent.il_last_object_y[1] - iuo_parent.il_ancor_y )
	ll_x_diff = (This.Pointerx() - iuo_parent.il_last_object_x[1] ) + (iuo_parent.il_last_object_x[1] - iuo_parent.il_ancor_x )

	FOR i = 1 TO iuo_parent.ii_obj_select_cnt
		ll_y = iuo_parent.il_last_object_y[i] + ll_y_diff 
		ll_x = iuo_parent.il_last_object_x[i] + ll_x_diff

		IF this.Describe( iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".type") = "line" THEN	
			ls_Modify += iuo_parent.is_last_object[i] + ".y1 = '" + String( ll_y ) + "' " + iuo_parent.is_last_object[i] + ".y2 = '" + String( ll_y ) + "' " 
		Else
			ls_Modify += iuo_parent.is_last_object[i] + ".y = '" + String( ll_y ) + "' " 
		End If
		
		IF this.Describe( iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".type") = "line" THEN	
			ls_Modify += iuo_parent.is_last_object[i] + ".x1 = '" + String( ll_x ) + "' " + iuo_parent.is_last_object[i] + ".x2 = '" + String( iuo_parent.il_x2 + ll_x_diff) + "' " 
		Else
			ls_Modify += iuo_parent.is_last_object[i] + ".x = '" + String( ll_x ) + "' " 
				
		End If
		
	END FOR
ELSEIF (this.Pointerx() > iuo_parent.il_last_object_x[1] + iuo_parent.il_last_object_width[1] - 20) AND (this.Pointerx() < iuo_parent.il_last_object_x[1] + iuo_parent.il_last_object_width[1]-2) THEN
	iuo_parent.ib_resize_width = True
	SetPointer(SizeWE!)
ELSEIF (this.Pointery() > iuo_parent.il_last_object_y[1] + iuo_parent.il_last_object_height[1] - 10) AND (this.PointerY() < iuo_parent.il_last_object_y[1] + iuo_parent.il_last_object_height[1]-2) THEN
	iuo_parent.ib_resize_height = True
	SetPointer(SizeNS!)
ELSEIF iuo_parent.ib_resize_width AND iuo_parent.ib_mouse_down THEN
	SetPointer(SizeWE!)
	ll_x_diff = Pointerx() - (iuo_parent.il_last_object_x[1] + iuo_parent.il_last_object_width[1])
	ll_new_width = iuo_parent.il_last_object_width[1] + ll_x_diff
	iuo_parent.il_last_object_width[1] = ll_new_width
	ls_Modify = iuo_parent.is_last_object[1] + ".width = '" + String( ll_new_width ) + "' "

ELSEIF iuo_parent.ib_resize_height AND iuo_parent.ib_mouse_down THEN
	SetPointer(SizeNS!)
	ll_y_diff = Pointery() - (iuo_parent.il_last_object_y[1] + iuo_parent.il_last_object_height[1])
	ll_new_height = iuo_parent.il_last_object_height[1] + ll_y_diff
	iuo_parent.il_last_object_height[1] = ll_new_height
	ls_Modify = iuo_parent.is_last_object[1] + ".height = '" + String( ll_new_height ) + "'" 
	
ELSE
	iuo_parent.ib_resize_width = False
	iuo_parent.ib_resize_height = False
END IF

this.modify( ls_Modify )
iw_parentwin.event ue_setmodify( ls_Modify )
		
iuo_parent.uo_design.st_xy.Text = "  X:" + String(iuo_parent.il_last_object_x[1]) +&
   								"  Y:" + String(iuo_parent.il_last_object_y[1]) +&
	   							"  Width:" + String(iuo_parent.il_last_object_width[1]) +&
		   						"  Height:" + String(iuo_parent.il_last_object_height[1])
									
									


end event

public function integer of_getobjects (ref string as_objlist[], string as_objtype, string as_band, boolean ab_visibleonly); //////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetObjects (FORMAT 2)
//
//	Access:    		Public
//
//	Arguments:
//   as_objtype:  	The type of objects to get (* for all, others defined
//							by the object .TYPE attribute)
//   as_band:  		The dw band to get objects from (* for all) 
//							Valid bands: header, detail, footer, summary
//							header.#, trailer.#
//   ab_visibleonly: TRUE  - get only the visible objects,
//							 FALSE - get visible and non-visible objects
//
//	Returns:  		Integer
//   					The number of objects in the array
//
//////////////////////////////////////////////////////////////////////////////
string	ls_ObjString, ls_ObjHolder
integer	li_Start=1, li_Tab, li_Count=0

/* Get the Object String */
ls_ObjString = this.Describe("Datawindow.Objects")

as_band = upper(as_band)
as_objtype = upper(as_objtype)

/* Get the first tab position. */
li_Tab =  Pos(ls_ObjString, "~t", li_Start)
Do While li_Tab > 0
	ls_ObjHolder = Mid(ls_ObjString, li_Start, (li_Tab - li_Start))

	// Determine if object is the right type and in the right band
	If (upper(this.Describe(ls_ObjHolder + ".type")) = as_ObjType Or as_ObjType = "*") And &
		(upper(this.Describe(ls_ObjHolder + ".band")) = as_Band Or as_Band = "*") And &
		(this.Describe(ls_ObjHolder + ".visible") = "1" Or Not ab_VisibleOnly) Then
			li_Count ++
			as_ObjList[li_Count] = ls_ObjHolder
	End if

	/* Get the next tab position. */
	li_Start = li_Tab + 1
	li_Tab =  Pos(ls_ObjString, "~t", li_Start)
Loop 

// Check the last object
ls_ObjHolder = Mid(ls_ObjString, li_Start, Len(ls_ObjString))

// Determine if object is the right type and in the right band
If (upper(this.Describe(ls_ObjHolder + ".type")) = as_ObjType or as_ObjType = "*") And &
	(upper(this.Describe(ls_ObjHolder + ".band")) = as_Band or as_Band = "*") And &
	(this.Describe(ls_ObjHolder + ".visible") = "1" Or Not ab_VisibleOnly) Then
		li_Count ++
		as_ObjList[li_Count] = ls_ObjHolder
End if

Return li_Count


end function

public function integer of_unselectobj (string as_name);
string ls_modify
long ll_find
string ls_r,ls_type
datawindow   ldw_syntax

IF as_Name = '' THEn return -1
ls_type = this.describe(as_name+'.type')

ldw_Syntax = iw_Parentwin.uo_design.uo_band.dw_Syntax
//IF ls_type = 'text' THEN //Add by Evan 07/21/2008
//	this.modify(as_Name+".background.color='67108864'")
IF this.describe(as_name+".type") <> 'line' THEN //Delete by Evan 07/21/2008
//ELSEIF ls_type <> 'line' THEN //Add by Evan 07/21/2008
	this.modify(as_Name+".background.color='"+ldw_Syntax.describe(as_Name+".background.color")+"'")
	this.modify(as_Name+".background.mode='"+ldw_Syntax.describe(as_Name+".background.mode")+"'")
	this.modify(as_Name+".brush.color='"+ldw_Syntax.describe(as_Name+".brush.color")+"'")
	this.modify(as_Name+".brush.hatch='"+ldw_Syntax.describe(as_Name+".brush.hatch")+"'")
else
	this.modify(as_Name+".background.color='"+ldw_Syntax.describe(as_Name+".background.color")+"'")
	this.modify(as_Name+".background.mode='"+ldw_Syntax.describe(as_Name+".background.mode")+"'")
	this.modify(as_Name+".pen.color='"+ldw_Syntax.describe(as_Name+".pen.color")+"'")
end if
return 1
end function

public function integer of_selectobject (string as_name);
string ls_modify='',ls_name,ls_type,ls_band
string ls_r
int lx,ly,lw,lh
string ls1

IF this.describe(as_name+".type") <> 'line' THEN 
	IF this.describe(as_name+".brush.hatch") = '7' THEN
		this.modify(as_name+".brush.hatch='6'~t"+as_name+".brush.color='"+string(cil_HighLightColor)+"'")
	ELSE
		this.modify(as_name+".Background.Mode='0'~t"+as_name+".background.color='"+string(cil_HighLightColor)+"'")
	END IF
else
	ls_modify = this.modify(as_name+".pen.color = '" + string(cil_HighLightColor) + "'")
end if
return 1


end function

public subroutine of_getgroupobjects (string as_groupobjects[]);String ls_header_1[],ls_header_2[],ls_trailer_1[],ls_trailer_2[]
long i

this.of_getobjects(ls_header_1[],'*','header.1',FALSE)
this.of_getobjects(ls_header_2[],'*','header.2',FALSE)
this.of_getobjects(ls_trailer_1[],'*','trailer.1',FALSE)
this.of_getobjects(ls_trailer_2[],'*','trailer.2',FALSE)

For i=1 To upperbound(ls_header_1[])
	as_groupobjects[upperbound(as_groupobjects[])+1]=ls_header_1[i] 
Next	
For i=1 To upperbound(ls_header_2[])
	as_groupobjects[upperbound(as_groupobjects[])+1]=ls_header_2[i]
Next
For i=1 To upperbound(ls_trailer_1[])
	as_groupobjects[upperbound(as_groupobjects[])+1]=ls_trailer_1[i]
Next
For i=1 To upperbound(ls_trailer_2[])
	as_groupobjects[upperbound(as_groupobjects[])+1]=ls_trailer_2[i]
Next
end subroutine

public function integer of_setdesign (string as_objname);//long  ll,row
//string  ls_modify,ls_ColTYpe,ls_Type,ls_EditStyle
//int  li,li_temp
//datetime  ldt_temp
//time  lt_temp
//any  la
//
//if iuo_parent.il_dw_style = 1 then return 1
//
//IF this.describe(as_ObjName+".moveable") ='0' THEN
//	ls_Modify+="~t"+ as_ObjName+".moveable=1"+"~t"+ as_ObjName+".resizeable=1"
//END IF
//
//this.modify(ls_Modify)
//ls_Modify = ''

return 1
end function

public subroutine of_populatedw ();//====================================================================
// Event: pfc_cst_u_band.of_populatedw()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	integer	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 06,2007
//--------------------------------------------------------------------
// Modify History:
//	
//====================================================================

LONG LL_I,ll_count
string ls_dddw_name
string ls_colname
String ls_coltag
Integer li_value
String ls_DataColumn	

DataWindowChild dwchild
n_ds lnds_user
n_cst_string lnv_string
String ls_objects,ls_arr_objects[],ls_type
String ls_column_visible,ls_str,ls_column_ID

// Set design datawindow background color as button face
//this.Modify("datawindow.color=67108864") //Add by Evan 07/18/2008; Delete 09/27/2008

// Set display properties of text objects
//of_SetTextDisplayProperties() //Add by Evan 07/25/2008; Delete 09/27/2008

ls_objects = this.Describe("datawindow.objects")
ll_count = lnv_string.of_parsetoarray( ls_objects, "~t", ls_arr_objects)

//LL_COLUMN_COUNT = LONG(This.Describe("DataWindow.Column.Count"))
//IF LL_COLUMN_COUNT = 0 THEN RETURN

FOR LL_I = 1 TO ll_count
	IF lower(Describe(ls_arr_objects[ll_i] + ".Band")) =  lower(this.is_bandType) then
		ls_type = lower(Describe(ls_arr_objects[ll_i] + ".type"))
		ls_colname = Describe(ls_arr_objects[ll_i] + ".Name")

		//<modify> 04.11.2008 by Andy
		//Reason:Backup expression if there is a expression in visible property,not button only.
		//       (fixed issue 1 from Issues for Tracy.doc)
		//if ls_type = "button" then 
		If this.Describe(ls_arr_objects[ll_i] + ".visible") <> '0' And this.Describe(ls_arr_objects[ll_i] + ".visible") <> '1' Then
			iuo_parent.is_button_object[upperbound(iuo_parent.is_button_object) + 1] = ls_colname
			iuo_parent.is_button_visible[upperbound(iuo_parent.is_button_visible) + 1] = this.Describe(ls_arr_objects[ll_i] + ".visible")
			this.Modify(ls_arr_objects[ll_i] + ".visible = 1")
		end if
		//end if
		//end modify 04.11.2008
		
		IF ls_type = "compute" or ls_type = "column" then
			// Grid style
			IF iuo_parent.il_dw_style = 1 THEN	this.Modify( ls_colname + "_t.border = '6'" )
			this.Modify( ls_colname + ".border = '5'" )
		end if
		
		if ls_type = "column" then
			//visible
			ls_column_visible= this.Describe(ls_colname +".Visible")

			IF ls_column_visible = "0" THEN
				this.Modify(ls_colname + ".visible = 1")
				this.Modify(ls_colname + "_t.visible = 1")
				//$<add> 01.11.2008 by: Andy
				iuo_parent.uo_band.dw_header.Modify(ls_colname + "_t.visible = 1")
				
				this.Modify(ls_colname + ".color = '8421504'") 
				this.Modify(ls_colname + ".background.color = '12632256'")
				this.Modify(ls_colname + "_t.color = '8421504'")
				//$<add> 01.11.2008 by: Andy
				iuo_parent.uo_band.dw_header.Modify(ls_colname + "_t.color = '8421504'")
			ELSE
				//BEGIN---Delete by Evan 09/27/2008
				/*
				this.Modify(ls_colname + ".color = '0'")
				this.Modify(ls_colname + "_t.color = '0'")
				this.Modify(ls_colname + "_t.background.color = '67108864'") //Add by Evan 07/21/2008
		
				//$<add> 01.11.2008 by: Andy
				iuo_parent.uo_band.dw_header.Modify(ls_colname + "_t.color = '0'")
				iuo_parent.uo_band.dw_header.Modify(ls_colname + "_t.background.color = '67108864'") //Add by Evan 07/23/2008
				*/
				//END---Delete by Evan 09/27/2008
				ls_str = this.Describe(ls_colname + ".TabSequence")
				If ls_str <> '0' Then
					this.Modify(ls_colname + ".background.color = '16777215'")
				End If				
			END IF
			//end of visible
			
			//columnid/protect
			ls_column_ID = this.Describe( ls_colname + ".ID" )
			this.Modify( ls_colname + "_t.tag = '" + ls_column_ID + "'" )
			this.Modify( ls_colname + ".protect = 1" )
			//end of columnid/protect	

			//dddw
			IF Describe(ls_arr_objects[ll_i] + ".Edit.Style") = 'dddw' then				
				ls_dddw_name = lower(Describe(ls_arr_objects[ll_i] + ".DDDW.Name"))							
				IF ls_dddw_name = "d_dddw_code_lookup" OR ls_dddw_name = "d_dddw_code_lookup_action_type" THEN
					ls_coltag = Lower(Describe(ls_arr_objects[ll_i] + ".TAG"))
					li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lnds_user)
						
					IF li_value <> 1 THEN
						gnv_app.of_setcontraccache_code_lookup( ls_coltag )
						li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lnds_user)
					END IF
				ELSE
					li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_dddw_name,lnds_user)
				END IF
						
				IF li_value = 1 THEN
					getchild( ls_colname, dwchild)
					dwchild.Reset( )
					lnds_user.rowscopy( 1, 1000, primary!, dwchild, 1, primary!)
					long ll_find
					string ls_displaycolumn
					ls_displaycolumn = This.Describe(ls_colname + ".dddw.displaycolumn")
					ll_find = dwchild.find(ls_displaycolumn + " = '(NONE)'",1,dwchild.rowcount())
					If ll_find > 0 Then
						dwchild.setitem(ll_find,ls_displaycolumn,'')
					End If
					ls_DataColumn = This.Describe(ls_colname + ".dddw.DataColumn")
					dwchild.SetFilter( "isnull(" + ls_DataColumn + ") or " + ls_DataColumn + " > 0 " )
					dwchild.Filter( )
				END IF
			END IF
			//end of dddw
			
		end if
		//end of column
		
	END IF
NEXT

Return

end subroutine

public function integer of_show_invisible (boolean ab_show);//====================================================================
// Event: pfc_cst_u_band.of_show_invisible()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	integer	ab_show	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 08,2007
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Integer li_rc
Integer i
String ls_fld

iuo_parent.dw_properties.SetFilter("")
iuo_parent.dw_properties.Filter( )
li_rc = iuo_parent.dw_properties.RowCount()

FOR i = 1 TO li_rc

	ls_fld = iuo_parent.dw_properties.GetItemString( i, "sys_fields_field_name" )
	IF lower(Describe(ls_fld + ".Band")) =  lower(is_bandType) then
		If iuo_parent.dw_properties.GetItemString( i, "data_view_fields_visible" ) = "N" Then
			IF NOT ab_show THEN
				Modify( ls_fld + ".Visible = 1")
				Modify( ls_fld + "_t.Visible = 1")
				//$<add> 01.11.2008 by: Andy
				iuo_parent.uo_band.dw_header.Modify( ls_fld + "_t.Visible = 1")
			ELSE
				Modify( ls_fld + ".Visible = 0")
				Modify( ls_fld + "_t.Visible = 0")
				//$<add> 01.11.2008 by: Andy
				iuo_parent.uo_band.dw_header.Modify( ls_fld + "_t.Visible = 0")			
			END IF
		End If
	end if
	
END FOR

RETURN 1
end function

public function integer of_setdesign (boolean ab_true);//====================================================================
// Event: pfc_cst_u_band.of_setdesign()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//     boolean ab_true
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 06,2007
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//long  ll,row
//string  ls_modify,ls_ColTYpe,ls_Type,ls_EditStyle
//int  li,li_temp
//datetime  ldt_temp
//time  lt_temp
//any  la
//string ls_groupobj[]
//
//if iuo_parent.il_dw_style = 1 then return 1
//
//of_getgroupobjects(ls_groupobj[])
//
//FOR ll = 1 TO upperbound(ls_groupobj)
//
//	if ab_true then
//		IF this.describe(ls_groupobj[ll]+".moveable") ='0' THEN
//			ls_Modify+="~t"+ ls_groupobj[ll]+".moveable=1"+"~t"+ ls_groupobj[ll]+".resizeable=1" 
//		END IF
//	else
//		IF this.describe(ls_groupobj[ll]+".moveable") ='1' THEN
//			ls_Modify+="~t"+ ls_groupobj[ll]+".moveable=0"+"~t"+ ls_groupobj[ll]+".resizeable=0" 
//		END IF
//	end if
//	
//	this.modify(ls_Modify)
//	ls_Modify = ''
//NEXT
//
//FOR ll = 1 TO upperbound(is_Objects)
//
//	if ab_true then
//		IF this.describe(is_Objects[ll]+".moveable") ='0' THEN
//			ls_Modify+="~t"+ is_Objects[ll]+".moveable=1"+"~t"+ is_Objects[ll]+".resizeable=1" 
//		END IF
//	else
//		IF this.describe(is_Objects[ll]+".moveable") ='1' THEN
//			ls_Modify+="~t"+ is_Objects[ll]+".moveable=0"+"~t"+ is_Objects[ll]+".resizeable=0" 
//		END IF
//	end if
//
//	this.modify(ls_Modify)
//	ls_Modify = ''
//NEXT

return 1
end function

public function integer of_set_dw_properties (string as_column_name);String ls_edit_style
String ls_str
String ls_column_name,ls_display
String ls_b_name   
String ls_modify

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-12 By: Andy
iuo_parent.dw_properties.Accepttext( )
IF Right(is_CurObj,2) = "_t" THEN
	ls_column_name = Left(is_CurObj,LEN(is_CurObj) - 2)
ELSE
	ls_column_name = is_CurObj
END IF

ls_edit_style = Describe(ls_column_name + ".Edit.Style")
CHOOSE CASE as_column_name
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Modify> 2007-11-15 By: Andy
	//$<Reason> Fix a defect.
	//label border
	CASE "fields_label_border"
		ls_modify = ls_column_name + "_t.Border = '" + String(iuo_parent.dw_properties.GetItemString(1, "fields_label_border")) + "'"
		
	//field border
	CASE "fields_border"
		/*
		ls_modify = ls_column_name + ".Border = '5'"
		modify(ls_modify)
		*/
		ls_modify = ls_column_name + ".Border = '" + String(iuo_parent.dw_properties.GetItemString(1, "fields_border")) + "'"
		iw_parentwin.event ue_setmodify(ls_modify)
					
		RETURN 1		
	//---------------------------- APPEON END ----------------------------	
	
	CASE "data_view_fields_visible"
		// Visible
		IF iuo_parent.dw_properties.GetItemString(1, "data_view_fields_visible") = "N" THEN
			//$<modify> 04.22.2008 by Andy
			//$<Reason> fixed BugA040903 (Modify failed if column label is not exists)
			//ls_modify = ls_column_name + ".color = '8421504' " + ls_column_name + ".background.color = '12632256' " + ls_column_name + "_t.color = '8421504'"
			ls_modify = ls_column_name + ".color = '8421504' " + ls_column_name + ".background.color = '12632256' " + ls_column_name + ".background.mode = '0' "
			modify(ls_modify)
			iw_parentwin.event ue_setmodify(ls_modify)
			
			ls_modify = ls_column_name + "_t.color = '8421504' " + ls_column_name + "_t.background.color = '12632256' " + ls_column_name + "_t.background.mode = '0' "
			modify(ls_modify)
			iw_parentwin.event ue_setmodify(ls_modify)
			
		//	iuo_parent.uo_band.dw_header.Modify( ls_column_name + "_t.color = '8421504'" )
			iuo_parent.uo_band.dw_header.Modify( ls_modify )
			
			//ls_modify += " " + ls_column_name + ".visible = '0' " + ls_column_name + "_t.visible = '0'"
			ls_modify = ls_column_name + ".visible = '0' "
			modify(ls_modify)
			iw_parentwin.event ue_setmodify(ls_modify)
					
			ls_modify = ls_column_name + "_t.visible = '0'"
			modify(ls_modify)
			iw_parentwin.event ue_setmodify(ls_modify)
			iuo_parent.uo_band.dw_header.Modify( ls_modify )
			//end modify 04.22.2008
			
			ls_b_name = 'b_' + ls_column_name
			ls_modify = ls_b_name + ".visible = '0'"
		ELSE
			//$<modify> 04.22.2008 by Andy
			//ls_modify = ls_column_name + ".color = '0' " + ls_column_name + "_t.color = '0' " + ls_column_name + ".background.color = '16777215'" 
			ls_modify = ls_column_name + ".color = '0' " + ls_column_name + ".background.color = '16777215' " + ls_column_name + ".background.mode = '1'" 
			modify(ls_modify)
			iw_parentwin.event ue_setmodify(ls_modify)
			
			ls_modify = ls_column_name + "_t.color = '0' " + ls_column_name + "_t.background.color = '16777215' " + ls_column_name + "_t.background.mode = '1' "
			modify(ls_modify)
			iw_parentwin.event ue_setmodify(ls_modify)
			
//			iuo_parent.uo_band.dw_header.Modify( ls_column_name + "_t.color = '0' " )
			iuo_parent.uo_band.dw_header.Modify( ls_modify )
			
			//ls_modify += " " + ls_column_name + ".visible = '1' " + ls_column_name + "_t.visible = '1'"
			ls_modify = ls_column_name + ".visible = '1' "
			modify(ls_modify)
			iw_parentwin.event ue_setmodify(ls_modify)
			
			ls_modify = ls_column_name + "_t.visible = '1'"
			modify(ls_modify)
			iw_parentwin.event ue_setmodify(ls_modify)
			//end modify 04.22.2008
			
			ls_b_name = 'b_' + ls_column_name
			ls_modify = ls_b_name + ".visible = '1'"
		END IF

	CASE "data_view_fields_field_label"
		// Field Label
		//ls_modify = ls_column_name + "_t.text = '" + String(iuo_parent.dw_properties.GetItemString(1, "data_view_fields_field_label")) + "'"
		//$<Modify> 04.17.2008 by: nova
		ls_modify = ls_column_name + "_t.text = ~"" + String(iuo_parent.dw_properties.GetItemString(1, "data_view_fields_field_label")) + "~""
		//$<ADD> 07.23.2008 by Andy
		iuo_parent.uo_band.dw_header.Modify( ls_modify )
	CASE "data_view_fields_label_justification"
		// Label Justification
		ls_modify = ls_column_name + "_t.Alignment = '" + String(iuo_parent.dw_properties.GetItemNumber(1, "data_view_fields_label_justification")) + "'" 
	CASE "data_view_fields_field_order"
		// Field Order
		ls_modify = ls_column_name + ".tabsequence = '" + String(iuo_parent.dw_properties.GetItemNumber(1, "data_view_fields_field_order")) + "'"
	CASE "data_view_fields_required"
		// Required
		//$<modify> 04.22.2008 by Andy
		IF iuo_parent.dw_properties.GetItemString(1, "data_view_fields_required") = "Y" THEN
			//ls_modify = ls_column_name + "_t.font.underline = '1' " +  ls_column_name + "." + ls_edit_style + ".Required = 'Yes'"
			ls_modify = ls_column_name + "." + ls_edit_style + ".Required = 'Yes'"
			modify(ls_modify)
			iw_parentwin.event ue_setmodify(ls_modify)
			
			ls_modify = ls_column_name + "_t.font.underline = '1' "
		ELSE
			//ls_modify = ls_column_name + "_t.font.underline = '0' " + ls_column_name + "." + ls_edit_style + ".Required = 'No'"
			ls_modify = ls_column_name + "." + ls_edit_style + ".Required = 'No'"
			modify(ls_modify)
			iw_parentwin.event ue_setmodify(ls_modify)
			
			ls_modify = ls_column_name + "_t.font.underline = '0' "
		END IF
		//end modify 04.22.2008
	CASE "data_view_fields_justification"
		// Justification
		ls_modify = ls_column_name + ".Alignment = '" + String(iuo_parent.dw_properties.GetItemNumber(1, "data_view_fields_justification")) + "'"
	CASE "sys_fields_drop_down_width"
		// Drop Down Width
		IF ls_edit_style = "dddw" THEN
			ls_modify = ls_column_name + ".dddw.PercentWidth = " + String(iuo_parent.dw_properties.GetItemNumber(1, "sys_fields_drop_down_width"))
		END IF
	CASE "sys_fields_field_case"
		// Field Case
		IF ls_edit_style = "edit" OR ls_edit_style = "dddw" OR ls_edit_style = "ddlb" THEN
			ls_str = String(iuo_parent.dw_properties.GetItemString(1, "sys_fields_field_case"))
			CHOOSE CASE upper(ls_str)
				CASE "L"
					ls_str = "lower"
				CASE "U"
					ls_str = "upper"
				CASE "A"
					ls_str = "any"
				CASE "F"
					ls_str = "first"
				CASE ELSE
					ls_str = "lower"
			END CHOOSE
			ls_modify = ls_column_name + "." + ls_edit_style + ".Case = '" + ls_str + "'"
		END IF
	CASE "sys_fields_field_mask"
		ls_modify = ls_column_name + ".format = '" + String(iuo_parent.dw_properties.GetItemString(1, "sys_fields_field_mask")) + "'"
//		IF ls_edit_style = "editmask" Or ls_edit_style = "edit" THEN
//			If Not isnull(iuo_parent.dw_properties.GetItemString(1, "sys_fields_field_mask")) And trim(iuo_parent.dw_properties.GetItemString(1, "sys_fields_field_mask")) <> '' And trim(iuo_parent.dw_properties.GetItemString(1, "sys_fields_field_mask")) <> 'null' Then
//				ls_modify = ls_column_name + ".EditMask.Mask = '" + String(iuo_parent.dw_properties.GetItemString(1, "sys_fields_field_mask")) + "'"
//			Else
//				ls_modify = ls_column_name + ".edit.format = ''"
//			End If
//		End If
//		//---------------------------- APPEON END ----------------------------
	CASE "data_view_fields_display_only"
		// Display Only
		IF ls_edit_style = "edit" THEN
			if upper(iuo_parent.dw_properties.GetItemString(1, "data_view_fields_display_only")) = "Y" then
				ls_display = 'Yes'
			else
				ls_display = 'No'
			end if
			ls_modify = ls_column_name + ".edit.displayonly = '" + ls_display + "'"
		END IF
	CASE "sys_fields_lookup_field"
		// Lookup Field
		IF iuo_parent.dw_properties.GetItemString(1, "sys_fields_lookup_field") = "N"  THEN
			iuo_parent.dw_properties.SetItem( 1, "sys_fields_lookup_type", "" )
			iuo_parent.dw_properties.SetItem( 1, "sys_fields_lookup_code", "" )
			iuo_parent.dw_properties.SetItem( 1, "sys_fields_lookup_field_name", "" )
			
			ls_modify = ls_column_name + ".edit.AutoHScroll = Yes " + ls_column_name + ".edit.NilIsNull = Yes"
		END IF
	CASE "sys_fields_lookup_code"
		//<modify> 01.09.2008 by: Andy
		String useasborder
		if iuo_parent.il_dw_style = 1 OR iuo_parent.ii_screen_id = 2 then 
			useasborder = 'No'
		else
			useasborder = 'Yes'
		end if
		
		// Lookup Table
		ls_modify = ls_column_name + ".dddw.VscrollBar = Yes " + ls_column_name + ".dddw.AutoHScroll = Yes " + ls_column_name + ".dddw.useasborder = " + useasborder + " " + &
						ls_column_name + ".dddw.NilIsNull= Yes " + ls_column_name + ".dddw.name = 'd_dddw_code_lookup' " + ls_column_name + ".dddw.datacolumn = 'lookup_code' " + &
						ls_column_name + ".dddw.displaycolumn = 'code' " + ls_column_name + ".dddw.PercentWidth = 300 " + &
						ls_column_name + ".tag = '" + String(iuo_parent.dw_properties.GetItemString(1, "sys_fields_lookup_code")) + "'"
		//end of modify 01.09.2008
		
		iuo_parent.dw_properties.SetItem( 1, "sys_fields_default_value", "" )
		iuo_parent.dw_properties.SetItem( 1, "sys_fields_lookup_field", "Y" )
		iuo_parent.dw_properties.SetItem( 1, "sys_fields_lookup_field_name", "code" )
		iuo_parent.dw_properties.SetItem( 1, "sys_fields_drop_down_width", 300 )
	CASE "sys_fields_lookup_field_name"
		// Lookup Field Name
		ls_modify = ls_column_name + ".dddw.displaycolumn = '" + String(iuo_parent.dw_properties.GetItemString(1, "sys_fields_lookup_field_name")) + "'"
	CASE "sys_fields_default_value"
		If Not isnull(iuo_parent.dw_properties.GetItemString(1, "sys_fields_default_value")) And iuo_parent.dw_properties.GetItemString(1, "sys_fields_default_value") <> '' Then
			ls_modify = ls_column_name + ".Initial = '" + String(iuo_parent.dw_properties.GetItemString(1, "sys_fields_default_value")) + "'"
		Else
			ls_modify = ls_column_name + ".Initial = 'null'" //".Initial = ''" modify by jervis 01.07.2009
		End If
	CASE "fields_label_textcolor"   //Add by Evan 07/18/2008
		ls_modify = ls_column_name + "_t.color = " + String(iuo_parent.dw_properties.GetItemNumber(1, "fields_label_textcolor"))
	CASE "fields_label_textbkcolor" //Add by Evan 07/18/2008
		ls_modify = ls_column_name + "_t.background.mode='2' "
		ls_modify += ls_column_name + "_t.background.color = " + String(iuo_parent.dw_properties.GetItemNumber(1, "fields_label_textbkcolor"))
	case 'fields_vscrollbar'		//Add by Jervis 12/10/2008
		IF ls_edit_style = "edit" OR ls_edit_style = "dddw" OR ls_edit_style = "ddlb" THEN
			ls_str = iuo_parent.dw_properties.GetItemString(1, as_column_name)
			if ls_str = 'Y' then
				ls_modify = ls_column_name + "." + ls_edit_style + ".VScrollBar = Yes " + ls_column_name + "." + ls_edit_style + ".AutoHScroll = No " 
			else
				ls_modify = ls_column_name + "." + ls_edit_style + ".VScrollBar = No " + ls_column_name + "." + ls_edit_style + ".AutoHScroll = Yes " 
			end if
			
		END IF
	CASE ELSE
		RETURN 0
END CHOOSE

modify(ls_modify)
iw_parentwin.event ue_setmodify(ls_modify)

//$<add> 03.26.2008 by Andy
//$Reason:Auto set view fields alias if find out.
String ls_Val
Long   ll_Cnt, ll_R=0

IF as_column_name = "data_view_fields_visible" OR as_column_name = "data_view_fields_field_label" THEN
	ls_Val = iuo_parent.dw_properties.GetItemString(1,as_column_name)
	IF as_column_name = "data_view_fields_visible" THEN
		IF ls_Val = 'N' THEN ls_Val = '0' ELSE ls_Val = '1'  
	END IF
	
	ll_Cnt = iuo_parent.dw_fields_alias.RowCount( )
	DO WHILE (1=1)
		ll_R = iuo_parent.dw_fields_alias.Find("c_name='" + ls_column_name + "'",ll_R,ll_Cnt)
		if ll_R < 1 then EXIT
		IF as_column_name = "data_view_fields_visible" THEN
			iuo_parent.dw_fields_alias.SetItem(ll_R,"visible",Long(ls_Val))
		ELSE
			iuo_parent.dw_fields_alias.SetItem(ll_R,"c_alias",Left(ls_Val,255))
		END IF
		ll_R ++
		if ll_R > ll_Cnt THEN EXIT
	LOOP
END IF
//End Add 03.26.2008

RETURN 1
//---------------------------- APPEON END ----------------------------
end function

public function integer of_modifytextproperties (string as_property);string ls_Object
string ls_Modify
datawindow ldw_prop

// Get text object name
ldw_prop = iuo_parent.dw_properties_text
ls_Object = ldw_prop.object.name[1]

// Get modify expression
choose case as_Property
	case "text"
		ls_Modify = ls_Object + ".text = '" + ldw_prop.object.text[1] + "'"
	case "visible"
		ls_Modify = ls_Object + ".visible = '" + ldw_prop.object.visible[1] + "'"
	case "text_color"
		ls_Modify = ls_Object + ".color = '" + String(ldw_prop.object.text_color[1]) + "'"
	case "background_color"
		ls_Modify  = ls_Object + ".background.mode = '2' "
		ls_Modify += ls_Object + ".background.color = '" + String(ldw_prop.object.background_color[1]) + "'"
	case "alignment"
		ls_Modify = ls_Object + ".alignment = '" + ldw_prop.object.alignment[1] + "'"
	case "border"
		ls_Modify = ls_Object + ".border = '" + ldw_prop.object.border[1] + "'"
	case else
		Return 0
end choose

// Modify text object property
this.Modify(ls_Modify)
iw_ParentWin.Event ue_SetModify(ls_Modify)

Return 1
end function

public function integer of_settextdisplayproperties ();string ls_Modify
string ls_ObjectsStr
string ls_Objects[]
integer i, li_ObjectCount
n_cst_string lnv_string

// Get objects
ls_ObjectsStr = this.Describe("datawindow.objects")
lnv_string.of_ParseToArray(ls_ObjectsStr, "~t", ls_Objects[])
li_ObjectCount = UpperBound(ls_Objects[])

// Set text object show properties
for i = 1 to li_ObjectCount
	if this.Describe(ls_Objects[i] + ".type") = "text" then
		ls_Modify = ls_Objects[i] + ".color = '0' "
		ls_Modify += ls_Objects[i] + ".background.mode = '2' "
		ls_Modify += ls_Objects[i] + ".background.color = '67108864'"
		this.Modify(ls_Modify)
	end if
next

Return 1
end function

public subroutine of_setuserobject (pfc_cst_u_report_data_design auo_obj);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-07 By: Andy
iuo_parent = auo_obj
//---------------------------- APPEON END ----------------------------
end subroutine

event getfocus;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-05 By: Andy
//this.modify('datawindow.'+is_bandtype+'.color=15793151')
//---------------------------- APPEON END ----------------------------

end event

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.04.2008 By: Andy
This.of_SetUpdateable(False)

//$<add> 2007-11-05 By: Andy
Event post ue_postopen()
//---------------------------- APPEON END ----------------------------
end event

event rbuttondown;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-05 By: Andy
//if iuo_parent.il_dw_style = 1 then return 1
//if iuo_parent.ib_set_tab_order then return
//$<add> 2008-03-17 By: nova
//reaseon BugN031402
//If iuo_parent.il_select_view <> 1001 And (iuo_parent.ii_screen_id = 1 Or iuo_parent.ii_screen_id = 2) Then
//	return
//end if
iw_parentwin.dynamic event ue_rbuttondown()
//---------------------------- APPEON END ----------------------------
end event

event doubleclicked;//BEGIN---Delete by Evan 07/24/2008
/*
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-13 By: Andy

IF isNull(is_CurObj) or is_CurObj = "" THEN
	Return
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.18.2007 By: Jack
//$<reason> 
If isvalid(m_pfe_cst_contract_data_design) Then
	If m_pfe_cst_contract_data_design.m_view.m_fieldproperties.enabled = False Then Return
End If
//---------------------------- APPEON END ----------------------------

//IF is_last_object[1] <> "" AND Right(is_last_object[1],2) <> "_t" THEN
iuo_parent.of_field_property_sheet()
//END IF
*/

iuo_parent.TriggerEvent("ue_properties")
//END---Delete by Evan 07/24/2008

end event

event losefocus;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-05 By: Andy
GraphicObject which_control
datawindow	ldw

if iuo_parent.ib_set_tab_order then return
which_control = GetFocus()

if  not IsValid(which_control) or isnull(which_control) then return
if TypeOf(which_control) = datawindow! then
	ldw = which_control
	if lower(ldw.classname())<>'dw_rulers' then
		this.of_unselectobj(is_CurObj)
	end if
end if
//---------------------------- APPEON END ----------------------------
end event

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-6 By: Andy
//iuo_parent.il_sel
String ls_weight
String ls_italic
String ls_underline
String ls_selected_object
String ls_alignment
String ls_text
String ls_selected_object_name
String ls_field_id
String ls_last_field_temp[]
Integer i
Integer li_field_id[]
long	 ll_Row,ll_Count
string ls_Type

ls_selected_object = This.GetObjectAtPointer()
ls_selected_object_name = Mid(ls_selected_object, 1, Pos(ls_selected_object, "	" ) -1 )
//messagebox("dwo.name",string(iuo_parent.il_select_view)+'/'+string(iuo_parent.ii_screen_id))
IF iuo_parent.ib_set_tab_order THEN
	IF Left( ls_selected_object_name, 4 ) = "tab_" THEN
		string ls_Retval
		ls_retval = This.Modify( Mid( iuo_parent.is_last_tab_label_name, 5,100) + ".TabSequence = '" + iuo_parent.uo_band.sle_tab.text + "'" )
		This.Modify( iuo_parent.is_last_tab_label_name + ".text = '" + iuo_parent.uo_band.sle_tab.text + "'")
		
		iw_parentwin.event ue_setmodify( Mid( iuo_parent.is_last_tab_label_name, 5,100) + ".TabSequence = '" + iuo_parent.uo_band.sle_tab.text + "'" )
		
		//sle_tab.Text = This.Describe( ls_selected_object_name + ".tabsequence" ) 
		iuo_parent.uo_band.sle_tab.Text = Describe( Mid( ls_selected_object_name, 5, 100 ) + ".TabSequence" )			
	   iuo_parent.is_last_tab_label_name = ls_selected_object_name
		
		iuo_parent.ib_clicked = True	// Add by Jack 05/17/2007	
		This.Event ue_calc_tab_position()
	END IF
	RETURN 
END IF

long   ll_x,ll_Y

IF iw_ParentWin.is_AddObjectType <>'' THEN
	ib_Draging = FALSE
	ll_x = PointerX()//iw_ParentWin. 
	ll_y = PointerY()//iw_ParentWin. 
	iw_ParentWin.post wf_AddObject(iw_ParentWin.is_AddObjectType,ll_x,ll_Y)
	//$<add> 01.08.2008 by: Andy
	//$Reason:BugN122710
	iuo_parent.ib_multi_select = False
	iuo_parent.is_last_object[] = ls_last_field_temp[]
	iuo_parent.il_ancor_x = 0
	iuo_parent.il_ancor_y = 0	
	iuo_parent.ii_obj_select_cnt = 0
	RETURN
	//end of add 01.08.2008
END IF

IF iuo_parent.ii_obj_select_cnt = 1 THEN
	IF ls_selected_object_name <> iuo_parent.is_last_object[1] THEN
		iuo_parent.ib_resize_height = False
		iuo_parent.ib_resize_width = False
	END IF
END IF

IF (ls_selected_object_name = "" AND iuo_parent.ii_obj_select_cnt > 0) THEN
	iuo_parent.ib_multi_select = False
	iuo_parent.is_last_object[] = ls_last_field_temp[]
	iuo_parent.il_ancor_x = 0
	iuo_parent.il_ancor_y = 0	
	iuo_parent.ii_obj_select_cnt = 0
	RETURN 0
END IF

IF iuo_parent.ib_multi_select THEN
	iuo_parent.ii_obj_select_cnt ++
ELSE
	iuo_parent.ii_obj_select_cnt = 1
END IF

IF iuo_parent.ii_obj_select_cnt = 1 THEN
	iuo_parent.il_ancor_x = Pointerx()
	iuo_parent.il_ancor_y = Pointery()
END IF
iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] = ls_selected_object_name

//BEGIN---Add by Evan 07/24/2008
ls_Type = this.Describe( iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".type")
choose case ls_Type
	case "text"
		if IsValid(w_contract_text_properties) then
			iuo_parent.dw_properties_text.Event ue_Retrieve(iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt])
		end if
	case else
end choose
//END---Add by Evan 07/24/2008

IF ls_Type/*This.Describe( iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".type")*/ = "line" THEN //Modify by Evan 07/24/2008
	iuo_parent.il_last_object_y[iuo_parent.ii_obj_select_cnt] = Long( This.Describe( iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".y1") )
	iuo_parent.il_last_object_x[iuo_parent.ii_obj_select_cnt] = Long( This.Describe( iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".x1") )
	//$<add> 01.08.2008 by: Andy
	iuo_parent.il_x2 = Long( This.Describe( iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".x2"))
	//end of add 01.08.2008
	iuo_parent.il_last_object_width[iuo_parent.ii_obj_select_cnt] = Long( This.Describe( iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".width") )
	iuo_parent.il_last_object_height[iuo_parent.ii_obj_select_cnt] = Long( This.Describe( iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".height"))	
Else
	iuo_parent.il_last_object_y[iuo_parent.ii_obj_select_cnt] = Long( This.Describe( iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".y") )
	iuo_parent.il_last_object_x[iuo_parent.ii_obj_select_cnt] = Long( This.Describe( iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".x") )
	iuo_parent.il_last_object_width[iuo_parent.ii_obj_select_cnt] = Long( This.Describe( iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".width") )
	iuo_parent.il_last_object_height[iuo_parent.ii_obj_select_cnt] = Long( This.Describe( iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".height"))
End If


iuo_parent.uo_design.st_xy.Text = "  X:" + String(iuo_parent.il_last_object_x[iuo_parent.ii_obj_select_cnt]) +&
									"  Y:" + String(iuo_parent.il_last_object_y[iuo_parent.ii_obj_select_cnt]) +&
									"  Width:" + String(iuo_parent.il_last_object_width[iuo_parent.ii_obj_select_cnt]) +&
									"  Height:" + String(iuo_parent.il_last_object_height[iuo_parent.ii_obj_select_cnt])
														

iuo_parent.uo_design.st_object_name.Text = iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt]

IF Right(iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt], 2) = "_t" THEN
	ls_field_id = Describe( iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".tag" )
ELSE
	ls_field_id = Describe( iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".id" )
END IF
If ls_field_id="?" Or ls_field_id="!" Or ls_field_id="" Then ls_field_id="0"
IF Pos( iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt], "obj" ) = 0 THEN//AND ls_selected_object_name <> "detail_band" 
	iuo_parent.dw_properties.SetFilter("data_view_fields_field_id = " + ls_field_id )
	iuo_parent.dw_properties.Filter()
	if IsValid(w_contract_field_properties) then w_contract_field_properties.of_ShowColor() //Add by Evan 07/24/2008
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 05.06.2007 By: Jack
	//$<reason> Fix a defect.
	datawindowchild dwchild
	If isvalid(w_contract_field_properties) Then
		ll_Row = w_contract_field_properties.dw_properties.GetRow()			//Added by Scofield on 2007-09-11
		ll_Count = w_contract_field_properties.dw_properties.RowCount()	//Added by Scofield on 2007-09-11
		if ll_Row > 0 and ll_Row <= ll_Count then									//Added by Scofield on 2007-09-11
			IF w_contract_field_properties.dw_properties.GetItemString(ll_Row,"sys_fields_lookup_field" ) = "Y" THEN
				w_contract_field_properties.cb_DataFill.Enabled = true		//Added by Scofield on 2007-10-25
				w_contract_field_properties.dw_properties.GetChild( "sys_fields_default_value", dwchild )
				dwchild.SetTransObject( SQLCA )
				dwchild.Retrieve( w_contract_field_properties.dw_properties.GetItemString( w_contract_field_properties.dw_properties.GetRow(), "sys_fields_lookup_code" ))
			else
				w_contract_field_properties.cb_DataFill.Enabled = false		//Added by Scofield on 2007-10-25
			END IF
		end if
	End If
	//---------------------------- APPEON END ----------------------------
END IF

ls_text = This.Describe( ls_selected_object_name + ".text" )

IF ls_text <> "?" AND ls_text <> "!" THEN
	//$<add> 04.17.2008 By: nova
	//$<reason> Fix a defect.
	if left(ls_text,1) = '"' then ls_text = Mid(ls_text,2)
	if Right(ls_text,1) = '"' then ls_text = Left(ls_text,len(ls_text) - 1)

	iuo_parent.uo_design.dw_1.SetText( ls_text )
END IF

ls_alignment = This.Describe(iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".alignment")

iuo_parent.uo_design.st_left.BorderStyle = StyleRaised!
iuo_parent.uo_design.st_right.BorderStyle = StyleRaised!
iuo_parent.uo_design.st_center.BorderStyle = StyleRaised!

IF ls_alignment = "0" THEN
	iuo_parent.uo_design.st_left.BorderStyle = StyleLowered!
ELSEIF ls_alignment = "1" THEN
	iuo_parent.uo_design.st_right.BorderStyle = StyleLowered!
ELSE
	iuo_parent.uo_design.st_center.BorderStyle = StyleLowered!
END IF

ls_weight = This.Describe(iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".font.weight")
IF ls_weight = "400" THEN
	iuo_parent.uo_design.st_bold.BorderStyle = StyleRaised!
ELSE
	iuo_parent.uo_design.st_bold.BorderStyle = StyleLowered!
END IF

ls_italic = This.Describe(iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".font.italic")
IF ls_italic = "0" OR ls_italic = "?" THEN
	iuo_parent.uo_design.st_italic.BorderStyle = StyleRaised!
ELSE
	iuo_parent.uo_design.st_italic.BorderStyle = StyleLowered!
END IF

//Modify 06/22/2007 by: Andy
//IF Right(is_last_object[ii_obj_select_cnt],2) = "_t" THEN
IF Right(iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt],2) = "_t" or &
	describe(iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".type") = "compute" THEN
//end of modify
	ls_underline = This.Describe(iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + ".font.underline")
ELSE
	ls_underline = This.Describe(iuo_parent.is_last_object[iuo_parent.ii_obj_select_cnt] + "_t.font.underline")
END IF
IF ls_underline = "0" OR ls_underline = "?" THEN
	iuo_parent.uo_design.st_underline.BorderStyle = StyleRaised!
ELSE
	iuo_parent.uo_design.st_underline.BorderStyle = StyleLowered!
END IF

//---------------------------- APPEON END ----------------------------
end event

on pfc_cst_u_band_report.create
call super::create
end on

on pfc_cst_u_band_report.destroy
call super::destroy
end on

event lbuttondown;call super::lbuttondown;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-06 By: Andy

//$<add> 2008-03-18 By: nova
//Commented by Scofield on 2009-03-24
/*
If iuo_parent.il_select_view <> 1001 And (iuo_parent.ii_screen_id = 1 Or iuo_parent.ii_screen_id = 2) Then  
		return 1
end if
*/
//$<add> 2008-03-18 end
long				ll_x,ll_y
String			ls_Dwo, ls

if iuo_parent.ib_set_tab_order then return

ls_Dwo = this.GetObjectatPointer()
ls_dwo = left(ls_dwo, pos(ls_dwo, '~t') - 1)

if ls_dwo = '' OR isnull(ls_dwo) Then ib_mousesel = true

IF flags = 1 Then
	ib_Draging = TRUE
	IF upperbound(iw_ParentWIn.istr_SelectObj[]) > 0 Then
		iw_parentwin.dynamic event ue_SelectMultiObject("clear",this,'') 

	END IF
	
	IF ls_dwo = '' Then
		this.of_unselectObj(is_OrgObj)
		is_CurObj = ''
	Else
		is_CurObj = ls_Dwo
		//iu_cputime = cpu()
		
		IF ls_dwo <> is_OrgObj Then 
			Of_unselectObj(is_OrgObj)
		END IF
		
		IF Describe(ls_dwo+".type") = 'line' Then
			il_lineorgx = this.pointerx()
			il_lineorgy = this.pointery()
		END IF
		
		Of_SelectObject(is_CurObj)
		
	END IF
		
	iw_ParentWin.is_CurSelectObj = ls_dwo
ELSEIF flags = 5 OR flags = 9 Then 
	
	IF ls_dwo <> '' Then
		is_CurObj = ls_Dwo
		of_unselectObj(is_CurObj)
		iw_parentwin.dynamic event ue_SelectMultiObject("mouse",this,ls_dwo)
	End IF
END IF

IF iuo_parent.il_dw_style = 1 THEN RETURN

iuo_parent.ib_mouse_down = True
Integer i
Integer li_found = 0

IF flags <> 9 AND iuo_parent.ib_multi_select THEN
	ls_dwo = This.GetObjectAtPointer()
	ls_dwo = Mid(ls_dwo, 1, Pos(ls_dwo, "	" ) -1 )
	FOR i = 1 TO iuo_parent.ii_obj_select_cnt 
		IF iuo_parent.is_last_object[i] = ls_dwo THEN
			li_found = 1
		END IF
	END FOR
	IF li_found = 0 THEN
		iuo_parent.ib_multi_select = False
	ELSE
	   iuo_parent.il_ancor_x = Pointerx()
		iuo_parent.il_ancor_y = Pointery()
	END IF
END IF

IF flags = 9 THEN
	iuo_parent.ib_control_down = True
	iuo_parent.ib_multi_select = True
ELSE
	iuo_parent.ib_control_down = False
	IF iuo_parent.ib_multi_select THEN
		FOR i = 1 TO iuo_parent.ii_obj_select_cnt	
			iuo_parent.il_last_object_y[i] = Long( This.Describe( iuo_parent.is_last_object[i] + ".y") )
			iuo_parent.il_last_object_x[i] = Long( This.Describe( iuo_parent.is_last_object[i] + ".x") )
		END FOR
	ELSE
		//iuo_parent.il_ancor_x = Pointerx()
		//iuo_parent.il_ancor_y = Pointery()
		//w_prac_data_design.title = String(iuo_parent.il_ancor_y)		
	END IF
	
	//FOR i = 1 TO iuo_parent.ii_obj_select_cnt	
	//
END IF


//---------------------------- APPEON END ----------------------------
end event

event lbuttonup;call super::lbuttonup;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-06 By: Andy

Long	ll_count

if iuo_parent.ib_set_tab_order then return

ib_mousesel = false

If is_CurObj <> '' AND ib_Draging THEN
	is_OrgObj = is_CurObj 

//	ll_count = cpu()
//	If ll_count - iu_cputime > 100  then
//		Event post ue_afterdrag()
//	end If
END If

ib_Draging = FALSE

IF iuo_parent.il_dw_style = 1 THEN RETURN

iuo_parent.ib_mouse_down = False

iuo_parent.ib_resize_height = False
iuo_parent.ib_resize_width = False
//---------------------------- APPEON END ----------------------------


end event

