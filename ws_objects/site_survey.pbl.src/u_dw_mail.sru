$PBExportHeader$u_dw_mail.sru
$PBExportComments$(Appeon)Eugene 06.25.2013 - V141 ISG-CLX
forward
global type u_dw_mail from u_dw
end type
end forward

global type u_dw_mail from u_dw
end type
global u_dw_mail u_dw_mail

type variables
Integer ii_main_folder_id
end variables

forward prototypes
public function boolean of_multiselect ()
end prototypes

public function boolean of_multiselect ();Long ll_row,i

ll_row = This.GetSelectedRow(0)
Do While ll_row > 0
	ll_row = This.GetSelectedRow(ll_row)
	i++
	If i > 1 Then Return True
Loop
Return False
end function

on u_dw_mail.create
call super::create
end on

on u_dw_mail.destroy
call super::destroy
end on

event clicked;//Override Ancestor Script
long ll_Row
Long ll_x1,ll_x2,ll_x3
long ll_pointerx,ll_pointery

ll_pointerx = This.pointerX()
ll_pointery = This.pointerY()

//Sort data by first column's(include 3 flags) 
If dwo.name = 'multi_flags_t' Then
	ll_x1 = Long(This.Describe("p_lowimport.x"))
	ll_x2 = Long(This.Describe("p_attachment.x"))
	ll_x3 = Long(This.Describe("p_lock.x"))
	If ll_pointerx > ll_x3 Then
		Super::EVENT Clicked(xpos,ypos,row,this.object.read_status_sort_t )
	ElseIf ll_pointerx > ll_x2 Then
		Super::EVENT Clicked(xpos,ypos,row,this.object.attachment_sort_t )
	ElseIf ll_pointerx > ll_x1 Then
		Super::EVENT Clicked(xpos,ypos,row,this.object.mail_importance_t )
	End If
	Return 1
End If

//forbid resize first column's width
IF ll_pointery < Long(This.Describe("DataWindow.Header.Height")) &
	And ll_pointerx > Long(This.Describe("multi_flags_t.x")) + Long(This.Describe("multi_flags_t.width")) - 50 &
	And ll_pointerx < Long(This.Describe("multi_flags_t.x")) + Long(This.Describe("multi_flags_t.width")) + 50 Then
		Return 1
End If

Super::EVENT Clicked(xpos,ypos,row,dwo )

If row = 0 Then Return 

If  KeyDown(KeyShift!) or  KeyDown(KeyControl!) Then Return 

ll_Row = this.GetSelectedRow(0)
If ll_row > 0 Then
	this.SetRow(ll_Row)
	Parent.Dynamic Event ue_rowfocuschanged(This, ll_row)
End If
end event

event constructor;call super::constructor;This.of_setrowselect(True)
This.inv_rowselect.of_setstyle( This.inv_rowselect.EXTENDED)

this.of_SetSort(true)
This.inv_sort.of_SetColumnHeader(true)
this.SetTransObject(SQLCA)
this.Modify("DataWindow.ReadOnly='yes'")
This.of_setupdateable(False)

end event

event rbuttonup;window iw_parent_mail
If row > 0 Then
	m_mail_item lm_mail_item
	lm_mail_item = Create m_mail_item
	This.of_getparentwindow(iw_parent_mail)
	lm_mail_item.iw_email_folder = iw_parent_mail
	
	If of_multiselect() Then
		//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
//		lm_mail_item.m_reply.enabled = False
//		lm_mail_item.m_replytoall.enabled = False
//		lm_mail_item.m_forward.enabled = False		
//		lm_mail_item.m_line0.enabled = False
//		lm_mail_item.m_properties.enabled = False
		gnv_app.of_modify_menu_attr( lm_mail_item.m_reply,'enabled', False)
		gnv_app.of_modify_menu_attr( lm_mail_item.m_replytoall,'enabled', False)
		gnv_app.of_modify_menu_attr( lm_mail_item.m_forward,'enabled', False)		
		gnv_app.of_modify_menu_attr( lm_mail_item.m_line0,'enabled', False)
		gnv_app.of_modify_menu_attr( lm_mail_item.m_properties,'enabled', False)
		//---------End Modfiied ------------------------------------------------------
	Else
		If This.GetItemNumber(row,'read_status') = 0 Then
			lm_mail_item.m_markasunread.visible = False
		Else
			lm_mail_item.m_markasread.visible = False
		End If	
		
		If This.GetItemNumber(row,'locked') = 0 Then
			lm_mail_item.m_markasunlock.visible = False
		Else
			lm_mail_item.m_markaslock.visible = False
		End If	
		
	End If
	
	Choose Case ii_main_folder_id
		Case 2
			lm_mail_item.m_movetofolder.m_inbox.visible = False
		Case 3
			lm_mail_item.m_movetofolder.m_sentitem.visible = False
		Case 4
			lm_mail_item.m_movetofolder.m_drafts.visible = False			
		Case 5
			lm_mail_item.m_movetofolder.m_favoriteitems.visible = False						
		Case 6
			lm_mail_item.m_movetofolder.m_historyitems.visible = False									
		Case 7
			lm_mail_item.m_movetofolder.m_deleteditems.visible = False	
		Case 8
			lm_mail_item.m_delete.visible = False
			lm_mail_item.m_movetofolder.visible = False
			lm_mail_item.m_markasunread.visible = False
			lm_mail_item.m_markasread.visible = False
			lm_mail_item.m_markasunlock.visible = False
			lm_mail_item.m_markaslock.visible = False
			lm_mail_item.m_line0.visible = False
			lm_mail_item.m_line1.visible = False
			lm_mail_item.m_resetsearchresult.visible = True
	End Choose

	//---------Begin Added by (Appeon)Alfee 07.25.2013 for V141 ISG-CLX--------
	If Not gb_contract_module And gi_email_type = 1 Then //IC + Outlook  
			lm_mail_item.m_delete.visible = True
			lm_mail_item.m_reply.visible = False
			lm_mail_item.m_replytoall.visible = False
			lm_mail_item.m_forward.visible = False			
			lm_mail_item.m_movetofolder.visible = False
			lm_mail_item.m_markasunread.visible = False
			lm_mail_item.m_markasread.visible = False
			lm_mail_item.m_markasunlock.visible = False
			lm_mail_item.m_markaslock.visible = False
			lm_mail_item.m_line0.visible = False
			lm_mail_item.m_line1.visible = False
			lm_mail_item.m_resetsearchresult.visible = False
	End If
	//---------End Added ------------------------------------------------------------------
	
	lm_mail_item.popmenu( w_mdi.PointerX(), w_mdi.PointerY())
End If

end event

event rbuttondown;//Override Ancestor Script
end event

event doubleclicked;call super::doubleclicked;Long ll_row,ll_rowlist[]

//Return for Outlook setting in IntelliCred
IF NOT gb_contract_module AND gi_email_type = 1 THEN RETURN 0  //For BugA082101 - (Appeon)Alfee 09.23.2013 - V141 ISG-CLX

ll_row = row
If ll_row <= 0 Then Return 

//If This.GetItemNumber(ll_row,'read_status') = 0 Then
//	This.SetItem(ll_row,'read_status',1)
//	If This.update() <> 1 Then
//		Messagebox('Save Error','Failed to set the read mark, please refresh the data then try again.')
//	End If
//	Parent.Dynamic Function of_refresh_label()
//End If
Parent.Dynamic Event pfc_cst_reply() 

Return 1
end event

event rowfocuschanged;call super::rowfocuschanged;If  KeyDown(KeyShift!) or  KeyDown(KeyControl!) Then Return 
Parent.Dynamic event ue_rowfocuschanged(This, currentrow)
end event

