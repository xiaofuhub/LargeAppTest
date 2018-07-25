$PBExportHeader$u_calendar_ancestor.sru
forward
global type u_calendar_ancestor from u_base
end type
end forward

global type u_calendar_ancestor from u_base
end type
global u_calendar_ancestor u_calendar_ancestor

type variables
String	is_PreColName,is_PreColColor
String	is_Month[] = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"}
Boolean	ib_DispAlarm,ib_DispAction

n_cst_string	inv_String

DataWindow		idw_Disp_List[]
DataStore   	ids_cal_notify_disp_list

CONSTANT LONG DEFAULTDATEINITX  = 0
CONSTANT LONG DEFAULTDATEINITY  = 0

CONSTANT LONG DWINDENTDEPTH   = 8
CONSTANT LONG TEXTINDENTDEPTH = 15

CONSTANT LONG DATEHORISPACE = 0

CONSTANT LONG VERSCROLLBARWIDTH = 80

CONSTANT LONG ACTIONITEMFILTERSPACE = 30

CONSTANT LONG LOWERBLUE = 16773091
CONSTANT LONG DARKBLUE  = 14794661
CONSTANT LONG SELCOLOR  = 16248294

CONSTANT LONG PUREWHITE = RGB(255,255,255)

CONSTANT STRING ALARMFILTEREXP  = "Entry_Type < 20"
CONSTANT STRING ACTIONFILTEREXP = "Entry_Type > 20"

CONSTANT STRING DATELABELMARK   = "Date_Label_"
CONSTANT STRING BACKGDPICMARK   = "Date_Title_"
CONSTANT STRING AREABKMARK      = "Date_BackGD_"
CONSTANT STRING VERLINEMARK     = "Vertical_"
CONSTANT STRING HEADVERLMARK    = "Head_Verline_"
CONSTANT STRING WEEKDAYMARK     = "Week_Day_"

CONSTANT STRING ACTIONITEMFILTERNAME = "actionitemfilter_"
CONSTANT STRING ARRANGEMODE          = "arrange"

CONSTANT STRING DISPITEMDWMARK  = "dw_disp_list_"

end variables

forward prototypes
public function long of_fill_data (date ad_startdate, long al_daycnts)
public subroutine of_init_data (datastore ads_cal_notify_disp_list)
public subroutine of_refreshfiltername (string as_filtername1, string as_filtername2, string as_filtername3)
public function string of_getfilternamesyntax (string as_filtername1, string as_filtername2, string as_filtername3)
end prototypes

public function long of_fill_data (date ad_startdate, long al_daycnts);//====================================================================
// Function: of_Fill_Data()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    date    ad_StartDate
// 	value    long    al_DayCnts
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-12-23
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_UserFilter_Exp,ls_CTXFilter_Exp,ls_ActionFilter_Exp,ls_DateFilter_Exp,ls_ArrangeMode
String	ls_User_id,ls_SingleUser,ls_Email_id,ls_Filter_Exp,ls_Find_Exp
long		ll_Cycle,ll_FoundPos,ll_CommaPos,ll_ArrangeMode

n_cst_string	lcst_StrProcess

ib_DispAlarm  = Parent.Dynamic of_GetAlarmDispStatus()
ib_DispAction = Parent.Dynamic of_GetActionDispStatus()

if Not ib_DispAlarm and Not ib_DispAction then Return -1

ls_CTXFilter_Exp    = Parent.Dynamic of_GetCTXFilter_Exp()
ls_ActionFilter_Exp = Parent.Dynamic of_GetActionFilter_Exp()

ls_ActionFilter_Exp = lcst_StrProcess.of_GlobalReplace(ls_ActionFilter_Exp,"action_user in","Trim(action_user) in")

ls_DateFilter_Exp = "Date('" + String(ad_StartDate) + "') <= Date(alm_due_date) and Date(alm_due_date) <= Date('" + String(RelativeDate(ad_StartDate,al_DayCnts - 1)) + "')"

idw_Disp_List[al_DayCnts].Reset()

if ib_DispAlarm then
	ls_User_id = Parent.Dynamic of_GetUserID()
	
	if Not IsNull(ls_User_id) and Trim(ls_User_id) <> "" then
		ls_User_id += ","
		ll_CommaPos = Pos(ls_User_id,",")
		do while ll_CommaPos > 0
			ls_SingleUser = Trim(Left(ls_User_id,ll_CommaPos - 1))
			ls_User_id = Trim(Mid(ls_User_id,ll_CommaPos + 1))
			ll_CommaPos = Pos(ls_User_id,",")
			
			if Not IsNull(ls_SingleUser) and Trim(ls_SingleUser) <> "" then
				ls_Email_id = gnv_data.of_GetItem("security_users","email_id","user_id = '" + ls_SingleUser + "'")
				if Not IsNull(ls_Email_id) and Trim(ls_Email_id) <> "" then
					if ls_UserFilter_Exp <> "" then ls_UserFilter_Exp += " or "
					ls_UserFilter_Exp += "(action_user like '%" + ls_Email_id + "%')"
				end if
			end if
		loop
		
		if ls_UserFilter_Exp <> "" then ls_UserFilter_Exp = "(" + ls_UserFilter_Exp + ")"
	end if
	
	ls_Filter_Exp = ALARMFILTEREXP + " and " + ls_DateFilter_Exp
	if ls_CTXFilter_Exp <> "" then ls_Filter_Exp += " and " + ls_CTXFilter_Exp
	if ls_UserFilter_Exp <> "" then ls_Filter_Exp += " and " + ls_UserFilter_Exp
	
	ids_cal_notify_disp_list.SetFilter(ls_Filter_Exp)
	ids_cal_notify_disp_list.Filter()
	
	//copy alarm item data to the last datawindow
	ids_cal_notify_disp_list.RowsCopy(1,ids_cal_notify_disp_list.RowCount(),Primary!,idw_Disp_List[al_DayCnts],1,Primary!)
end if

ll_ArrangeMode = long(gnv_data.of_GetItem("icred_settings","CalArrangeMode",false))
if ll_ArrangeMode = 0 then
	ls_ArrangeMode = "start_date"
else
	ls_ArrangeMode = "alm_due_date"
end if

ls_DateFilter_Exp = "Date('" + String(ad_StartDate) + "') <= Date(" + ls_ArrangeMode + ") and Date(" + ls_ArrangeMode + ") <= Date('" + String(RelativeDate(ad_StartDate,al_DayCnts - 1)) + "')"

if ib_DispAction then
	ls_Filter_Exp = ACTIONFILTEREXP + " and " + ls_DateFilter_Exp
	if ls_CTXFilter_Exp <> "" then ls_Filter_Exp += " and " + ls_CTXFilter_Exp
	if ls_ActionFilter_Exp <> "" then ls_Filter_Exp += " and " + ls_ActionFilter_Exp
	
	ids_cal_notify_disp_list.SetFilter(ls_Filter_Exp)
	ids_cal_notify_disp_list.Filter()
	
	//copy action item data to the last datawindow
	ids_cal_notify_disp_list.RowsCopy(1,ids_cal_notify_disp_list.RowCount(),Primary!,idw_Disp_List[al_DayCnts],idw_Disp_List[al_DayCnts].RowCount() + 1,Primary!)
end if

idw_Disp_List[al_DayCnts].SetSort("entry_type A," + ls_ArrangeMode + " A,Start_Time A,disp_value A")
idw_Disp_List[al_DayCnts].Sort()

for ll_Cycle = 1 to al_DayCnts - 1
	idw_Disp_List[ll_Cycle].Reset()
	
	ls_Find_Exp  = "(entry_type < 20 and Date(alm_due_date) = Date('" + String(RelativeDate(ad_StartDate,ll_Cycle - 1)) + "')) or "
	ls_Find_Exp += "(entry_type > 20 and Date(" + ls_ArrangeMode + ") = Date('" + String(RelativeDate(ad_StartDate,ll_Cycle - 1)) + "'))"
	
	ll_FoundPos = idw_Disp_List[al_DayCnts].Find(ls_Find_Exp,1,idw_Disp_List[al_DayCnts].RowCount())
	do while ll_FoundPos > 0
		idw_Disp_List[al_DayCnts].RowsMove(ll_FoundPos,ll_FoundPos,Primary!,idw_Disp_List[ll_Cycle],idw_Disp_List[ll_Cycle].RowCount() + 1,Primary!)
		ll_FoundPos = idw_Disp_List[al_DayCnts].Find(ls_Find_Exp,ll_FoundPos,idw_Disp_List[al_DayCnts].RowCount())
	loop
next

Return 1

end function

public subroutine of_init_data (datastore ads_cal_notify_disp_list);String	ls_ObjName
long		ll_Cycle,ll_ObjCnts,ll_ItemNum

ids_cal_notify_disp_list = ads_cal_notify_disp_list

ll_ObjCnts = UpperBound(This.Control)
for ll_Cycle = 1 to ll_ObjCnts
	ls_ObjName = This.Control[ll_Cycle].ClassName()
	if Pos(ls_ObjName,DISPITEMDWMARK) > 0 then
		ll_ItemNum = long(Right(ls_ObjName,2))
		idw_Disp_List[ll_ItemNum] = This.Control[ll_Cycle]
		idw_Disp_List[ll_ItemNum].DataObject = "d_cal_notify_disp_list"
		idw_Disp_List[ll_ItemNum].SetTransObject(SQLCA)
	end if
next

end subroutine

public subroutine of_refreshfiltername (string as_filtername1, string as_filtername2, string as_filtername3);
end subroutine

public function string of_getfilternamesyntax (string as_filtername1, string as_filtername2, string as_filtername3);String	ls_Syntax,ls_TransName1,ls_TransName2,ls_TransName3

ls_TransName1 = as_FilterName1
ls_TransName1 = inv_String.of_GlobalReplace(ls_TransName1,"~~","~~~~")
ls_TransName1 = inv_String.of_GlobalReplace(ls_TransName1,"~'","~~'")

ls_TransName2 = as_FilterName2
ls_TransName2 = inv_String.of_GlobalReplace(ls_TransName2,"~~","~~~~")
ls_TransName2 = inv_String.of_GlobalReplace(ls_TransName2,"~'","~~'")

ls_TransName3 = as_FilterName3
ls_TransName3 = inv_String.of_GlobalReplace(ls_TransName3,"~~","~~~~")
ls_TransName3 = inv_String.of_GlobalReplace(ls_TransName3,"~'","~~'")

ls_Syntax += "t_actionitemfilter_1.Text = '" + ls_TransName1 + "' "
ls_Syntax += "t_actionitemfilter_2.Text = '" + ls_TransName2 + "' "
ls_Syntax += "t_actionitemfilter_3.Text = '" + ls_TransName3 + "' "
			 
Return ls_Syntax

end function

on u_calendar_ancestor.create
call super::create
end on

on u_calendar_ancestor.destroy
call super::destroy
end on

