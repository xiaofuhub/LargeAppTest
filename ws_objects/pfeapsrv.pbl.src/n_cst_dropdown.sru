$PBExportHeader$n_cst_dropdown.sru
$PBExportComments$Extension DropDown Service
forward
global type n_cst_dropdown from pfc_n_cst_dropdown
end type
end forward

global type n_cst_dropdown from pfc_n_cst_dropdown
end type
global n_cst_dropdown n_cst_dropdown

forward prototypes
public function integer of_position (dragobject adrg_object, boolean ab_makevisible)
end prototypes

public function integer of_position (dragobject adrg_object, boolean ab_makevisible);
/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 03 November 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
MSKINNER                                    15 jAN 2005                                    Improve calculations for Group Header and Trailer Attributes. So the the drop down is better positioned
********************************************************************************************************************/

Integer li_x, li_y
Integer li_idx
Integer li_objheight
Integer li_parentx, li_parenty
Integer li_rc
Integer li_colx, li_coly, li_colheight
Integer li_detailheight
Integer li_dwx, li_dwy, li_dwborder, li_dwtitlebar, li_dwtitleborder
Integer li_headerheight
Integer li_groupheaderheight, li_grouptrailerheight
Integer li_groupheaderheightarray[], li_grouptrailerheightarray[]
Integer li_groupbreakarray[]
Long  ll_groupchange
Long  ll_testrow
Integer li_group, li_groupcnt, li_breakcnt
String ls_colname
String ls_headerheight, ls_trailerheight
Integer li_rowsafterfirst
Integer li_counter
Integer li_hsplit, li_hpos, li_hpos1, li_hpos2, li_hMaxPos1
Integer li_pointerx, li_pointery
Integer li_bordercheck
Long  ll_firstrowonpage
Long  ll_lastrowonpage
Long  ll_currrow
window lw_parent
datawindow ldw_object
dec ldec_zoom


// Validate the references. 
If IsNull(adrg_object) Or Not IsValid(adrg_object) Or &
	IsNull(iu_requestor) Or Not IsValid(iu_requestor) Then
	Return -1
End If


// Get the parent window. 
of_GetParentWindow(adrg_object, lw_parent)
If IsNull(lw_parent) Or Not IsValid(lw_parent) Then
	Return -1
End If


// Get the X/Y coordinates for the parent object holding this datawindow. 
of_GetParentPosition(adrg_object, li_parentx, li_parenty)


// Determine which type of processing is needed. 
If adrg_object.TypeOf() = datawindow! Then
	// Cast to the appropriate variable type. 
	ldw_object = adrg_object
	ldec_zoom = long(ldw_object.Describe( "datawindow.zoom"))/100		//2008.8.15 By Jervis Consider the affect of zoom 
	
	
	// Determine if this positioning is not supported. 
	If ldw_object.TitleBar Then
		// Not supported. 
		//iu_requestor.Visible = False 
		//Return -2 
		// Calculate Title Bar attributes. 
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.16.2006 By: LeiWei
		//$<reason> Performance tuning
			/*
			 li_dwtitlebar =100
		 	 li_dwtitleborder = 100 
		*/
		li_dwtitlebar = 90
		li_dwtitleborder = 10
		//---------------------------- APPEON END ----------------------------
	End If
	
	
	// Get the column name. 
	ls_colname = ldw_object.GetColumnName()
	
	
	// Get exact pointers. 
	li_pointerx = ldw_object.PointerX()
	li_pointery = ldw_object.PointerY()
	
	
	// Get the row values. 
	ll_firstrowonpage = Long(ldw_object.Describe ("DataWindow.FirstRowOnPage"))
	ll_lastrowonpage = Long(ldw_object.Describe("DataWindow.LastRowOnPage"))
	ll_currrow = ldw_object.GetRow()
	
	
	// Get the DataWindow X/Y coordinates, Border width, and Title width. 
	li_dwx = ldw_object.X
	li_dwy = ldw_object.Y
	If ldw_object.Border Then
		Choose Case ldw_object.BorderStyle
			Case StyleBox!
				If Not ldw_object.TitleBar Then
					li_dwborder = of_GetSystemSetting  (DWSTYLE_BOX)
				End If
			Case StyleShadowBox!
				If Not ldw_object.TitleBar Then
					li_dwborder = of_GetSystemSetting (DWSTYLE_SHADOWBOX)
				End If
			Case StyleLowered!
				li_dwborder = of_GetSystemSetting (DWSTYLE_LOWERED)
			Case StyleRaised!
				li_dwborder = of_GetSystemSetting (DWSTYLE_RAISED)
		End Choose
	End If
	
	
	// Get the X/Y point of the Left/Upper location for this column. 
	li_colx = Integer(ldw_object.Describe(ls_colname+".X")) * ldec_zoom
	li_coly = Integer(ldw_object.Describe(ls_colname+".Y")) * ldec_zoom
	
	
	// Get the Height for this column and for the the Detail portion. 
	li_colheight = Integer(ldw_object.Describe(ls_colname+".Height")) * ldec_zoom
	li_detailheight = Integer(ldw_object.Describe ("DataWindow.Detail.Height")) * ldec_zoom + of_GetSystemSetting(DWDETAIL_HEIGHT)
	
	
	// Get the height of the header band. 
	ls_headerheight = ldw_object.Describe("DataWindow.Header.Height") 
	If IsNumber(ls_headerheight) Then
		li_headerheight += Integer(ls_headerheight) * ldec_zoom
	End If
	
	
	// Get the band height(s) for group headers and trailers. 
	li_idx = 0
	Do
		li_idx ++
		ls_headerheight = ldw_object.Describe("DataWindow.Header."+String (li_idx)+".Height")
		ls_trailerheight = ldw_object.Describe ("DataWindow.Trailer."+String(li_idx)+".Height")
		If PosA(ls_headerheight, "!") = 0 Then
			li_groupheaderheightarray[li_idx] = Integer (ls_headerheight) * ldec_zoom
			li_grouptrailerheightarray[li_idx] = Integer (ls_trailerheight) * ldec_zoom
		End If
	Loop Until PosA(ls_headerheight, "!") > 0
	
	
	// Attempt to determine the number of group breaks visible prior to 
	// the clicked row. 
	li_groupcnt = UpperBound(li_groupheaderheightarray)
	For li_group = 1 To li_groupcnt
		ll_testrow = ll_firstrowonpage
		li_breakcnt = 0
		
		
		// Catch the "gap". 
		ll_groupchange = ldw_object.FindGroupChange(ll_firstrowonpage, li_group)
		If ll_firstrowonpage <> ll_groupchange Then li_breakcnt ++
		
		
		Do While ll_testrow >= 0 And ll_testrow <= ll_currrow
			ll_testrow = ldw_object.FindGroupChange(ll_testrow, li_group)
			If ll_testrow > 0 Then
				If ll_testrow <= ll_currrow Then li_breakcnt ++
			Else
				Exit
			End If
			ll_testrow ++
		Loop
		li_groupbreakarray[li_group] = li_breakcnt
	Next
	
	
	// Calculate the total Height for each Header/Trailer. 
	For li_idx = 1 To UpperBound(li_groupheaderheightarray)
		li_groupheaderheight += li_groupheaderheightarray[li_idx] * li_groupbreakarray[li_idx]
		If li_groupbreakarray[li_idx] > 1 Then
			li_grouptrailerheight += li_grouptrailerheightarray [li_idx] * (li_groupbreakarray[li_idx] - 1)
		End If
	Next
	
	
	// Determine the on-screen row. 
	li_rowsafterfirst = ll_currrow - ll_firstrowonpage
	If li_rowsafterfirst < 0 Then
		// Hide the object since the row is not visible on the screen. 
		iu_requestor.Visible = False
		Return -3
	End If
	
	
	// Get Horizontal Scrollbar and Horizontal Split Scrolling variables. 
	li_hsplit = Integer (ldw_object.Describe ("DataWindow.HorizontalScrollSplit")) * ldec_zoom
	li_hpos1 = Integer (ldw_object.Describe ("DataWindow.HorizontalScrollPosition")) * ldec_zoom
	li_hpos2 = Integer (ldw_object.Describe ("DataWindow.HorizontalScrollPosition2")) * ldec_zoom
	li_hMaxPos1 = Integer(ldw_object.Describe("DataWindow.HorizontalScrollMaximum"))	* ldec_zoom	//Added by Scofield on 2008-04-16
	
	//Start Change Code by Jervis 03.12.2008
	//Reason:the hsplitscroll property is unsupport in APB
	If  AppeonGetClientType() = 'WEB' Then
		//APB Bug,In PB, for grid style dw,the unit of DataWindow.HorizontalScrollPosition property is Units, But APB is Pixels
		//Must convert to Units
		if ldw_object.Describe("datawindow.Processing") = '1' then //Grid Style
			li_hpos = PixelsToUnits ( li_hpos1, XPixelsToUnits!  )
			if li_hMaxPos1 > 0 and li_hpos > li_hMaxPos1 then li_hpos = li_hMaxPos1			//Added by Scofield on 2008-04-16
		else
			//messagebox("",li_hpos1)
			//APB Bug,Sometime DataWindow.HorizontalScrollPosition value get error
			//li_hpos =  li_hpos1
			li_hpos = 0
		end if
	Else
		If ldw_object.HSplitScroll Then
			If li_hsplit > 4 And li_pointerx > li_hsplit Then
				li_hpos = li_hpos2 - li_hsplit - of_GetSystemSetting (DW_HSPLITBAR_WIDTH)
			Else
				li_hpos = li_hpos1
			End If
		Else
			li_hpos = li_hpos1
		End If
	End If
	//End Change code by jervis 03.12.2008
	
	
	
	// Determine the Height of the column holding the dropdown. 
	li_objheight = li_colheight
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 08.23.2006 By: LeiWei
	//$<reason> 
	/*
	 // Calculate the X and Y Coordinates (check that it does not go past borders). 
	 li_x = li_parentx + li_dwx + li_dwborder + li_dwtitleborder + & 
	  li_colx - li_hpos + of_GetSystemSetting(DWMISC_XPOSITION) 
	 li_y = li_parenty + li_dwy + li_dwborder + li_dwtitleborder +li_dwtitlebar + & 
	  li_coly + li_headerheight +  & 
	  li_groupheaderheight + li_grouptrailerheight + & 
	  (li_detailheight * li_rowsafterfirst ) + & 
	  li_colheight + of_GetSystemSetting(DWMISC_YPOSITION) //- Integer (ldw_object.Describe ("DataWindow.VerticalScrollPosition")) 
	*/
	
	Long ll_verpos
	ll_verpos = Integer (ldw_object.Describe ("DataWindow.VerticalScrollPosition")) * ldec_zoom
	If ll_verpos > 0 Then
		If ll_currrow > 1 Then
			ll_verpos = ll_verpos - (ll_currrow - 1) * li_detailheight
		End If
	End If
	If ll_verpos <= 0 Or ll_verpos >= li_detailheight Then ll_verpos = 0
	
	// Calculate the X and Y Coordinates (check that it does not go past borders). 
	li_x = li_parentx + li_dwx + li_dwborder + li_dwtitleborder + &
		li_colx - li_hpos + of_GetSystemSetting(DWMISC_XPOSITION)
	li_y = li_parenty + li_dwy + li_dwborder + li_dwtitleborder +li_dwtitlebar + &
		li_coly + li_headerheight +  &
		li_groupheaderheight + li_grouptrailerheight + &
		(li_detailheight * li_rowsafterfirst ) + &
		li_colheight + of_GetSystemSetting(DWMISC_YPOSITION) - ll_verpos
	
	//---------------------------- APPEON END ----------------------------
	
	
	
Else
	// Determine the Object Height of the control holding the dropdown. 
	li_objheight = adrg_object.Height
	
	
	// Calculate the preffered X and Y Coordinates. 
	li_x = li_parentx + adrg_object.X + of_GetSystemSetting(MISC_XPOSITION)
	li_y = li_parenty + adrg_object.Y + li_objheight + of_GetSystemSetting (MISC_YPOSITION)
End If


// Get the border check value. 
li_bordercheck = of_GetSystemSetting(BORDER_CHECK)


// Make sure the coordinates will not force the calendar past the Right border. 
If (lw_parent.WorkSpaceWidth() - iu_requestor.Width - li_bordercheck) > 0 Then
	If (li_x + iu_requestor.Width +li_bordercheck  > lw_parent.WorkSpaceWidth()) Then
		// Position it at the extreme right without going past border. 
		li_x = lw_parent.WorkSpaceWidth() - iu_requestor.Width - li_bordercheck
	End If
End If


// Make sure this coordinates will not force the calendar past the Bottom border. 
If (li_y - li_objheight - iu_requestor.Height) > 0 Then
	If (li_y + iu_requestor.Height +li_bordercheck > lw_parent.WorkSpaceHeight()) Then
		// Position on top of the field. 
		li_y = li_y - li_objheight - iu_requestor.Height
	End If
End If


// Position the requestor object to the calculated coordinates. 
iu_requestor.Move (li_x, li_y)


// If requested, make the dropdown object visible. 
If ab_makevisible Then
	iu_requestor.Visible = True
End If
Return 1

end function

on n_cst_dropdown.create
call super::create
end on

on n_cst_dropdown.destroy
call super::destroy
end on

