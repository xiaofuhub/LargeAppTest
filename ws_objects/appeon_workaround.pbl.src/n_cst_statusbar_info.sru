$PBExportHeader$n_cst_statusbar_info.sru
$PBExportComments$(Appeon)Toney 06.05.2013 - V141 ISG-CLX
forward
global type n_cst_statusbar_info from nonvisualobject
end type
end forward

global type n_cst_statusbar_info from nonvisualobject autoinstantiate
end type

type variables
Boolean			ib_Red_Process = false  //(Appeon)Alfee 01.26.2014 - V142 ISG-CLX
String				is_Store_Process_Info //(Appeon)Alfee 01.26.2014 - V142 ISG-CLX
end variables

forward prototypes
public subroutine of_display (string as_text)
public function string of_get_info ()
public function string of_describe_statusbar (string as_id, string as_attribute)
public subroutine of_modify_statusbar_color (integer ai_color)
public subroutine of_preset_process_info ()
public subroutine of_restore_process_info (string as_type)
public subroutine of_display (string as_text, string as_type)
end prototypes

public subroutine of_display (string as_text);
//---------Begin Modified by (Appeon)Alfee 01.26.2014 for V142 ISG-CLX-----------------
of_display( as_text, '0' )

//String ls_column_name = 'Process'
//
//If Not isvalid (w_mdi) Then Return  //for scheduler - (Appeon)Alfee 06.25.2013 - V141 ISG-CLX
//
//If isvalid(w_mdi.inv_statusbar) Then //Added By Ken.Guo 2011-03-28.
//	If as_text = '' or isnull(as_text) Then
//		w_mdi.inv_statusbar.of_modify(ls_column_name,'Ready')
//	Else
//		w_mdi.inv_statusbar.of_modify(ls_column_name,as_text)
//	End If
//End If
//---------End Modfiied -------------------------------------------------------------------------
end subroutine

public function string of_get_info ();String ls_column_name = 'Process'

IF NOT IsValid (w_mdi) THEN RETURN ""  //(Appeon)Alfee 08.07.2013 - V141 ISG-CLX
IF NOT IsValid (w_mdi.inv_statusbar) THEN RETURN "" //(Appeon)Alfee 08.07.2013 - V141 ISG-CLX

Return w_mdi.inv_statusbar.of_get_info(ls_column_name)


end function

public function string of_describe_statusbar (string as_id, string as_attribute);string			ls_rc = ''

If Not isvalid (w_mdi) Then Return ls_rc  //for scheduler - (Appeon)Alfee 01.26.2013 - V142 ISG-CLX

If isvalid(w_mdi.inv_statusbar) Then
	w_mdi.inv_statusbar.of_describe( as_id, as_attribute )
End If



Return ls_rc
end function

public subroutine of_modify_statusbar_color (integer ai_color);String ls_column_name = 'Process'

If Not isvalid (w_mdi) Then Return  //for scheduler - (Appeon)Alfee 01.26.2013 - V142 ISG-CLX

If isvalid(w_mdi.inv_statusbar) Then
	w_mdi.inv_statusbar.of_modify("Process.Color = " + string( ai_color ) )
End If
end subroutine

public subroutine of_preset_process_info ();
If Not isvalid (w_mdi) Then Return  //for scheduler - (Appeon)Alfee 01.26.2013 - V142 ISG-CLX
If Not isvalid (w_mdi.inv_statusbar) Then Return  //for scheduler - (Appeon)Alfee 01.26.2013 - V142 ISG-CLX

is_Store_Process_Info = of_Get_info( )
w_mdi.inv_statusbar.of_modify("Process.color=255 Process.Font.Weight='700'")
ib_Red_Process = True
end subroutine

public subroutine of_restore_process_info (string as_type);
If Not isvalid (w_mdi) Then Return  //for scheduler - (Appeon)Alfee 01.26.2013 - V142 ISG-CLX
If Not isvalid (w_mdi.inv_statusbar) Then Return  //for scheduler - (Appeon)Alfee 01.26.2013 - V142 ISG-CLX

If as_type = '0' then
	
	If len( is_Store_Process_Info ) > 0 Then
		If of_Get_info( ) =  is_Store_Process_Info  Then Return
		w_mdi.inv_statusbar.of_modify("Process", is_Store_Process_Info )
	else
		If of_Get_info( ) =  "Ready"  Then Return
		w_mdi.inv_statusbar.of_modify("Process", "Ready" )
	end if
	w_mdi.inv_statusbar.of_modify("Process.color=0 Process.Font.Weight='400'")
	ib_Red_Process = False
Else
	If len( is_Store_Process_Info ) > 0 Then w_mdi.inv_statusbar.of_modify("Process", is_Store_Process_Info )
End If
end subroutine

public subroutine of_display (string as_text, string as_type);String ls_column_name = 'Process', ls_color

If Not isvalid (w_mdi) Then Return  //for scheduler - (Appeon)Alfee 01.26.2013 - V142 ISG-CLX

If as_Type = '0' Then//red
	If isvalid(w_mdi.inv_statusbar) Then //Added By Ken.Guo 2011-03-28.
		If as_text = '' or isnull(as_text) Or as_Text = 'Ready' Then
//			w_mdi.inv_statusbar.of_modify(ls_column_name,'Ready')
			of_restore_process_info( as_type )
		Else
			If Not ib_Red_Process  Then of_Preset_process_info( )
			w_mdi.inv_statusbar.of_modify(ls_column_name,as_text)
		End If
	End If
ElseIf as_type = '1' Then//black
	If isvalid(w_mdi.inv_statusbar) Then //Added By Ken.Guo 2011-03-28.
		If ib_Red_Process then return
		If as_text = '' or isnull(as_text) Then
			w_mdi.inv_statusbar.of_modify(ls_column_name,'Ready')
		Else
			is_Store_Process_Info = as_text
			w_mdi.inv_statusbar.of_modify(ls_column_name,as_text)
		End If
	End If
	
End If
end subroutine

on n_cst_statusbar_info.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_statusbar_info.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

