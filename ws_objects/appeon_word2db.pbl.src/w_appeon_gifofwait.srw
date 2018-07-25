$PBExportHeader$w_appeon_gifofwait.srw
forward
global type w_appeon_gifofwait from window
end type
type hpb_1 from hprogressbar within w_appeon_gifofwait
end type
type st_1 from statictext within w_appeon_gifofwait
end type
type p_1 from picture within w_appeon_gifofwait
end type
end forward

global type w_appeon_gifofwait from window
integer width = 1632
integer height = 316
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
hpb_1 hpb_1
st_1 st_1
p_1 p_1
end type
global w_appeon_gifofwait w_appeon_gifofwait

type variables
Boolean ib_EnableCancel //(Appeon)Harry 06.05.2013 - V141 ISG-CLX
end variables

forward prototypes
public function integer of_settext (string as_describe)
public function integer of_setminposition (long al_minposition)
public function integer of_setmaxposition (long al_maxposition)
public function integer of_setposition (long al_position)
public function integer of_setstep (long al_step)
public function integer of_skipnextposition (long al_setp)
public subroutine of_enablecancel (boolean ab_value)
public function string of_gettext ()
end prototypes

public function integer of_settext (string as_describe);//////////////////////////////////////////////////////////////////////
// $<function>of_settext
// $<arguments>
// $		as_describe
// $<returns> integer
// $<description> Set text
//////////////////////////////////////////////////////////////////////
// $<add> 10.23.2007 by Evan
//////////////////////////////////////////////////////////////////////

st_1.Text = as_Describe

Return 1
end function

public function integer of_setminposition (long al_minposition);//////////////////////////////////////////////////////////////////////
// $<function>of_setminposition
// $<arguments>
// $		al_minposition
// $<returns> integer
// $<description> Set min position
//////////////////////////////////////////////////////////////////////
// $<add> 10.23.2007 by Evan
//////////////////////////////////////////////////////////////////////

hpb_1.MinPosition = al_MinPosition

Return 1
end function

public function integer of_setmaxposition (long al_maxposition);//////////////////////////////////////////////////////////////////////
// $<function>of_setmaxposition
// $<arguments>
// $		al_maxposition
// $<returns> integer
// $<description> Set max position
//////////////////////////////////////////////////////////////////////
// $<add> 10.23.2007 by Evan
//////////////////////////////////////////////////////////////////////

hpb_1.MaxPosition = al_MaxPosition

Return 1
end function

public function integer of_setposition (long al_position);//////////////////////////////////////////////////////////////////////
// $<function>of_setposition
// $<arguments>
// $		al_position
// $<returns> integer
// $<description> Set position
//////////////////////////////////////////////////////////////////////
// $<add> 10.23.2007 by Evan
//////////////////////////////////////////////////////////////////////

hpb_1.Position = al_Position

Return 1
end function

public function integer of_setstep (long al_step);//////////////////////////////////////////////////////////////////////
// $<function>of_setstep
// $<arguments>
// $		al_step
// $<returns> integer
// $<description> Set step
//////////////////////////////////////////////////////////////////////
// $<add> 10.23.2007 by Evan
//////////////////////////////////////////////////////////////////////

hpb_1.SetStep = al_Step

Return 1
end function

public function integer of_skipnextposition (long al_setp);//////////////////////////////////////////////////////////////////////
// $<function>of_skipnextposition()
// $<arguments>
// $		al_setp
// $<returns> integer
// $<description> Skip next position
//////////////////////////////////////////////////////////////////////
// $<add> 10.23.2007 by Evan
//////////////////////////////////////////////////////////////////////

//---------Begin Modified by (Appeon)Harry 06.05.2013 for V141 ISG-CLX--------
//Added By Ken.Guo 2009-04-21. Do loop step.
If hpb_1.Position + al_Setp > hpb_1.maxposition Then
	hpb_1.Position = 0
End If
//---------End Modfiied ------------------------------------------------------

hpb_1.Position += al_Setp

Return 1
end function

public subroutine of_enablecancel (boolean ab_value);// (Appeon)Harry 06.05.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////
// $<function>w_appeon_gifofwaitof_enablecancel()
// $<arguments>
//		value	boolean	ab_value		
// $<returns> (none)
// $<description>
// $<description> If ib_EnableCancel = True, then user can close the window by press Esc key
//////////////////////////////////////////////////////////////////////
// $<add> 2010-07-14 by Ken.Guo
//////////////////////////////////////////////////////////////////////

ib_EnableCancel = ab_value
end subroutine

public function string of_gettext ();//====================================================================
// Function: of_gettext
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 04/01/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
// (Appeon)Harry 01.21.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================
String  		ls_return


ls_return  = st_1.Text 

Return ls_return
end function

event open;//BEGIN---Add by Evan 12/08/2008
if AppeonGetClientType() = "PB" then
	p_1.PictureName = gs_current_path + "\searchapp.gif"
end if
//END---Add by Evan 12/08/2008

IF LenA(Message.StringParm) > 0 THEN
	st_1.Text = Message.StringParm
END IF

// Add by Davis 10.18.2006
Timer(1)

SetPointer( HourGlass! )
end event

on w_appeon_gifofwait.create
this.hpb_1=create hpb_1
this.st_1=create st_1
this.p_1=create p_1
this.Control[]={this.hpb_1,&
this.st_1,&
this.p_1}
end on

on w_appeon_gifofwait.destroy
destroy(this.hpb_1)
destroy(this.st_1)
destroy(this.p_1)
end on

event timer;// Add by Davis 10.18.2006
hpb_1.stepit( )
end event

event closequery;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.07.2007 By: Machongmin
//$<reason> Fix a defect.
this.hpb_1.position = 100
//---------------------------- APPEON END ----------------------------
end event

event key;// (Appeon)Harry 06.05.2013 - V141 ISG-CLX
If Key = KeyEscape! and ib_EnableCancel Then
	If Messagebox('IntelliSoft','Do you want to cancel the action?',Question!,YesNo!) = 1 Then
		Close(This)
	End If
End If

end event

type hpb_1 from hprogressbar within w_appeon_gifofwait
integer x = 41
integer y = 192
integer width = 1554
integer height = 64
unsignedinteger maxposition = 100
unsignedinteger position = 10
integer setstep = 10
end type

type st_1 from statictext within w_appeon_gifofwait
integer x = 224
integer y = 64
integer width = 1993
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Opening document..."
boolean focusrectangle = false
end type

type p_1 from picture within w_appeon_gifofwait
integer x = 41
integer y = 20
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "searchapp.gif"
boolean focusrectangle = false
end type

