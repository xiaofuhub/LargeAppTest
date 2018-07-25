$PBExportHeader$n_cst_resize_prac.sru
forward
global type n_cst_resize_prac from n_cst_resize
end type
end forward

global type n_cst_resize_prac from n_cst_resize
end type
global n_cst_resize_prac n_cst_resize_prac

forward prototypes
protected function integer of_resize (integer ai_newwidth, integer ai_newheight)
end prototypes

protected function integer of_resize (integer ai_newwidth, integer ai_newheight);//////////////////////////////////////////////////////////////////////////////
//	Protected Function:		of_Resize
//	Arguments:					ai_newwidth		The new width of the parent object.
//									ai_newheight	The new height of the parent object.
//	Returns:  					integer
//									1 if it succeeds and -1 if an error occurs.
//	Description:  				Moves or resizes objects that were registered with the service.
//									Performs the actions that were requested via the
//									of_SetOrigSize() and of_Register functions.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History					Version
//									5.0		Initial version
// 									6.0		Changed to support for weighted movement and sizing of controls.
// 									6.0		Changed to use new constants.
//									8.0		Changed from Move for drawing objects to setting X and Y
//////////////////////////////////////////////////////////////////////////////
//	Copyright © 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
//Note: For the line control: the width and height variables are
//										used to hold EndX and EndY attributes.
//////////////////////////////////////////////////////////////////////////////
//Temporary controls to get to attributes
dragobject		ldrg_cntrl
oval				loval_cntrl
line				lln_cntrl
rectangle		lrec_cntrl
roundrectangle	lrrec_cntrl

//Local variables
integer			li_upperbound
integer			li_cnt
integer			li_x, li_y, li_width, li_height
integer			li_deltawidth, li_deltaheight
real				lr_ratiowidth, lr_ratioheight
real				lr_move_deltax, lr_move_deltay
real				lr_resize_deltawidth, lr_resize_deltaheight

//Confirm that the user object has already been initialized
If il_parentprevheight=-1 And il_parentprevwidth=-1 Then
	Return -1
End If

//Check the parameters
If IsNull(ai_newwidth) or IsNull(ai_newheight) Then
	return -1
End If

//Prevent the contents of the windows from resizing past the min width/height
If ai_newwidth < il_parentminimumwidth   Then ai_newwidth = il_parentminimumwidth
If ai_newheight < il_parentminimumheight Then ai_newheight = il_parentminimumheight

//Set the deltas/ratios for the width and height as compared to the previous size
li_deltawidth  = ai_newwidth  - il_parentprevwidth 
li_deltaheight = ai_newheight - il_parentprevheight
If il_parentprevwidth=0 Then il_parentprevwidth=1
If il_parentprevheight=0 Then il_parentprevheight=1	
lr_ratiowidth  = ai_newwidth  / il_parentprevwidth
lr_ratioheight = ai_newheight / il_parentprevheight

//Only continue if the size has changed
If li_deltawidth=0 And li_deltaheight=0 Then Return 1

//Set the new previous size
il_parentprevwidth = ai_newwidth
il_parentprevheight = ai_newheight

///////////////////////////////////////////////////////////////////////////////////////////////
// Loop through all registered controls - Moving and resizing as appropriate
///////////////////////////////////////////////////////////////////////////////////////////////

//Loop trough all controls
li_upperbound = UpperBound (inv_registered[])
For li_cnt = 1 to li_upperbound
	
	//Initialize variables
	li_x = 0
	li_y = 0 
	li_width = 0
	li_height = 0
	lr_move_deltax = 0	
	lr_move_deltay = 0
	lr_resize_deltawidth = 0	
	lr_resize_deltaheight = 0	
	SetNull(ldrg_cntrl)
	SetNull(loval_cntrl)
	SetNull(lln_cntrl)
	SetNull(lrec_cntrl)
	SetNull(lrrec_cntrl)
	
	If IsValid(inv_registered[li_cnt].wo_control) Then
		
		//Get attribute information from the appropriate control
		Choose Case inv_registered[li_cnt].s_typeof
			Case DRAGOBJECT
				ldrg_cntrl = inv_registered[li_cnt].wo_control
				li_x = ldrg_cntrl.X
				li_y = ldrg_cntrl.Y
				li_width = ldrg_cntrl.Width
				li_height = ldrg_cntrl.Height
			Case LINE
				// For the line control, the width and height variables 
				// are used to hold EndX and EndY attributes
				lln_cntrl = inv_registered[li_cnt].wo_control
				li_x = lln_cntrl.BeginX
				li_y = lln_cntrl.BeginY
				li_width = lln_cntrl.EndX
				li_height = lln_cntrl.EndY
			Case OVAL
				loval_cntrl = inv_registered[li_cnt].wo_control
				li_x = loval_cntrl.X
				li_y = loval_cntrl.Y
				li_width = loval_cntrl.Width
				li_height = loval_cntrl.Height	
			Case RECTANGLE
				lrec_cntrl = inv_registered[li_cnt].wo_control
				li_x = lrec_cntrl.X
				li_y = lrec_cntrl.Y
				li_width = lrec_cntrl.Width
				li_height = lrec_cntrl.Height
			Case ROUNDRECTANGLE
				lrrec_cntrl = inv_registered[li_cnt].wo_control			
				li_x = lrrec_cntrl.X
				li_y = lrrec_cntrl.Y
				li_width = lrrec_cntrl.Width
				li_height = lrrec_cntrl.Height				
			Case Else
				Return -1
		End Choose
		
		//Correct for any rounding or moving/resizing of objects trough
		//any other means
		If abs(inv_registered[li_cnt].r_x - li_x) > ii_rounding Then
			inv_registered[li_cnt].r_x = li_x
		End If				
		If abs(inv_registered[li_cnt].r_y - li_y) > ii_rounding Then
			inv_registered[li_cnt].r_y = li_y
		End If		
		If abs(inv_registered[li_cnt].r_width - li_width) > ii_rounding And &
		   li_width > inv_registered[li_cnt].i_widthmin Then
			inv_registered[li_cnt].r_width = li_width
		End If							
		If abs(inv_registered[li_cnt].r_height - li_height) > ii_rounding And &
		   li_height > inv_registered[li_cnt].i_heightmin Then
			inv_registered[li_cnt].r_height = li_height
		End If			
		
		//Define the deltas for this control:  Move and Resize
		If inv_registered[li_cnt].b_scale Then
			lr_move_deltax = (inv_registered[li_cnt].r_x * lr_ratiowidth) - inv_registered[li_cnt].r_x
			lr_move_deltay = (inv_registered[li_cnt].r_y * lr_ratioheight) - inv_registered[li_cnt].r_y
			lr_resize_deltawidth = (inv_registered[li_cnt].r_width * lr_ratiowidth) - inv_registered[li_cnt].r_width
			lr_resize_deltaheight = (inv_registered[li_cnt].r_height * lr_ratioheight) - inv_registered[li_cnt].r_height
		Else
			// Prevent the weighted value from being overriden.
			If inv_registered[li_cnt].b_movex And inv_registered[li_cnt].i_movex = 0 Then
				inv_registered[li_cnt].i_movex = 100
			End If
			If inv_registered[li_cnt].b_movey And inv_registered[li_cnt].i_movey = 0 Then
				inv_registered[li_cnt].i_movey = 100
			End If
			If inv_registered[li_cnt].b_scalewidth And inv_registered[li_cnt].i_scalewidth=0 Then
				inv_registered[li_cnt].i_scalewidth = 100
			End If
			If inv_registered[li_cnt].b_scaleheight And inv_registered[li_cnt].i_scaleheight=0 Then
				inv_registered[li_cnt].i_scaleheight = 100
			End If			
			
			// Support for weighted movement and sizing of controls.
			If inv_registered[li_cnt].b_movex Then 
				lr_move_deltax = li_deltawidth * inv_registered[li_cnt].i_movex / 100
			End If
			If inv_registered[li_cnt].b_movey Then 
				lr_move_deltay = li_deltaheight * inv_registered[li_cnt].i_movey / 100
			End If
			If inv_registered[li_cnt].b_scalewidth Then 
				lr_resize_deltawidth = li_deltawidth * inv_registered[li_cnt].i_scalewidth / 100
			End If
			If inv_registered[li_cnt].b_scaleheight Then 
				lr_resize_deltaheight = li_deltaheight * inv_registered[li_cnt].i_scaleheight /100
			End If
		End If

		//If appropriate move the control along the X and Y attribute.
		If lr_move_deltax <> 0 Or lr_move_deltay <> 0 Then	
			//Save the 'exact' X and Y attributes.
			inv_registered[li_cnt].r_x = inv_registered[li_cnt].r_x + lr_move_deltax		
			inv_registered[li_cnt].r_y = inv_registered[li_cnt].r_y + lr_move_deltay
			Choose Case inv_registered[li_cnt].s_typeof
				Case DRAGOBJECT
					//ldrg_cntrl.Move (inv_registered[li_cnt].r_x, inv_registered[li_cnt].r_y)
					ldrg_cntrl.x = inv_registered[li_cnt].r_x
					ldrg_cntrl.y = inv_registered[li_cnt].r_y
				Case LINE
					//X moving
					lln_cntrl.BeginX = inv_registered[li_cnt].r_x
					inv_registered[li_cnt].r_width = inv_registered[li_cnt].r_width + lr_move_deltax					
					lln_cntrl.EndX = inv_registered[li_cnt].r_width
					//Y moving
					lln_cntrl.BeginY = inv_registered[li_cnt].r_y
					inv_registered[li_cnt].r_height = inv_registered[li_cnt].r_height + lr_move_deltay
					lln_cntrl.EndY = inv_registered[li_cnt].r_height					
				Case OVAL
					loval_cntrl.X = inv_registered[li_cnt].r_x
					loval_cntrl.Y = inv_registered[li_cnt].r_y
				Case RECTANGLE
					lrec_cntrl.X = inv_registered[li_cnt].r_x
					lrec_cntrl.Y = inv_registered[li_cnt].r_y
				Case ROUNDRECTANGLE
					lrrec_cntrl.X = inv_registered[li_cnt].r_x
					lrrec_cntrl.Y = inv_registered[li_cnt].r_y
			End Choose	
		End If /* Move */
		
		//If appropriate Resize the Width And Height of the control.
		//Performing one Resize instead of changing Width and Height individually.
		If lr_resize_deltawidth <> 0 Or lr_resize_deltaheight <> 0 Then		
			//Save the 'exact' Width and Height attributes.
			inv_registered[li_cnt].r_width = inv_registered[li_cnt].r_width + lr_resize_deltawidth	
			inv_registered[li_cnt].r_height = inv_registered[li_cnt].r_height + lr_resize_deltaheight		
			Choose Case inv_registered[li_cnt].s_typeof
				Case DRAGOBJECT
					//ldrg_cntrl.Resize (inv_registered[li_cnt].r_width, inv_registered[li_cnt].r_height)
					ldrg_cntrl.width = inv_registered[li_cnt].r_width
					ldrg_cntrl.height = inv_registered[li_cnt].r_height
					li_width = ldrg_cntrl.Width
					li_height = ldrg_cntrl.Height
				Case LINE
					lln_cntrl.EndX = inv_registered[li_cnt].r_width
				Case OVAL
					//loval_cntrl.Resize (inv_registered[li_cnt].r_width, inv_registered[li_cnt].r_height)
					loval_cntrl.width = inv_registered[li_cnt].r_width
					loval_cntrl.height = inv_registered[li_cnt].r_height
					li_width = loval_cntrl.Width
					li_height = loval_cntrl.Height					
				Case RECTANGLE
					//lrec_cntrl.Resize (inv_registered[li_cnt].r_width, inv_registered[li_cnt].r_height)
					lrec_cntrl.width = inv_registered[li_cnt].r_width
					lrec_cntrl.height = inv_registered[li_cnt].r_height
					li_width = lrec_cntrl.Width
					li_height = lrec_cntrl.Height	
				Case ROUNDRECTANGLE
					//lrrec_cntrl.Resize (inv_registered[li_cnt].r_width, inv_registered[li_cnt].r_height)
					lrrec_cntrl.width = inv_registered[li_cnt].r_width
					lrrec_cntrl.height = inv_registered[li_cnt].r_height
					li_width = lrrec_cntrl.Width
					li_height = lrrec_cntrl.Height					
			End Choose		
			
			//Determine if the object does not support the requested Width or Height.
			//Used to determine if the object was resized by any other means.
			If li_width > inv_registered[li_cnt].r_width Then
				inv_registered[li_cnt].i_widthmin = li_width
			Else
				inv_registered[li_cnt].i_widthmin = 0
			End If
			If li_height > inv_registered[li_cnt].r_height Then
				inv_registered[li_cnt].i_heightmin = li_height
			Else
				inv_registered[li_cnt].i_heightmin = 0
			End If					
		End If /* Resize */

	End If /* If IsValid(inv_registered[li_cnt].wo_control) Then */
Next /* For li_cnt = 1 to li_upperbound */

Return 1
end function

on n_cst_resize_prac.create
call super::create
end on

on n_cst_resize_prac.destroy
call super::destroy
end on

