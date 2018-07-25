$PBExportHeader$u_cst_gadget_notes.sru
forward
global type u_cst_gadget_notes from u_cst_gadget
end type
end forward

global type u_cst_gadget_notes from u_cst_gadget
string tag = "u_gadget_9.Notes"
event ue_add ( )
event type integer ue_edit ( long al_row )
event type integer ue_close_note ( long al_note_id )
event type integer ue_delete_row ( long al_row )
event type integer ue_show_hide ( long al_row )
end type
global u_cst_gadget_notes u_cst_gadget_notes

type variables
w_dashboard_notes iw_notes[]
Integer j = 0,k = 1
Long il_x,il_y
end variables

forward prototypes
public function integer of_hide_all ()
public function integer of_show_all ()
public function integer of_settings ()
public function long of_get_back_color ()
public function integer of_refresh_ui (w_dashboard_notes aw_notes)
public function integer of_refresh_ui (w_dashboard_notes aw_notes[])
public subroutine of_highlight_row (long al_row)
public function integer of_show (long al_row)
public function w_dashboard_notes of_find_note_win (long al_row)
public function integer of_hide (long al_row)
public function integer of_delete_all (boolean ab_show_message)
end prototypes

event ue_add();//////////////////////////////////////////////////////////////////////
// $<event>u_cst_gadget_notes::ue_add()
// $<arguments>(None)
// $<returns> 
// $<description>
// $<description> Add a note.
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-06 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_row
Integer li_default_height_space,li_default_width_space
Long ll_back_color
str_notes lstr_notes

li_default_height_space = 140
li_default_width_space = 500

//Calculate  X,Y for new notes.
If il_x >= w_mdi.width - 1000 Then 
	K = 1
	j = 0
End If
If il_y >= w_mdi.height - 1000 Then 
	j = 0
	K++
End If
J++

il_x = li_default_width_space*K + 50 * j
il_y = 500 + j * li_default_height_space


//Get back color
ll_back_color = of_get_back_color()

//Insert row and set data
li_row = Dw_content.InsertRow(1)
dw_content.SetRow(li_row)
dw_content.ScrollToRow(li_row)
of_highlight_row(li_row)
Dw_content.SetItem(li_row,'user_id',gs_user_id)
Dw_content.SetItem(li_row,'tab_id',iuo_tabpge_gadget.istr_current_tab.sl_tab_id)
Dw_content.SetItem(li_row,'notes','')
Dw_content.SetItem(li_row,'notes_x',il_x)
Dw_content.SetItem(li_row,'notes_y',il_y)
Dw_content.SetItem(li_row,'notes_width',450) //Default width
Dw_content.SetItem(li_row,'notes_height',136) //Default height
Dw_content.SetItem(li_row,'back_color',ll_back_color)
Dw_content.SetItem(li_row,'create_date',today())
Dw_content.SetItem(li_row,'is_hide',0)
Dw_content.SetItem(li_row,'is_alwaysontop',1)
Dw_content.SetItem(li_row,'is_alarm',0)

//Save data
gnv_appeondb.of_autocommitrollback()
If Dw_content.update() = 1 Then
	lstr_notes.sl_note_id = dw_content.GetItemNumber(li_row,'id')
	lstr_notes.sdw_note_list = dw_content
Else
	//Restore it if failed to save
	Messagebox('Add error','Failed to add a note, please call support.')
	dw_content.DeleteRow(li_row)
	dw_content.ResetUpdate() //Clear update flag
	Return 
End If

OpenWithParm(iw_notes[UpperBound(iw_notes[])+1],lstr_notes,w_dashboard)

//Extend height by refresh UI. 
iuo_tabpge_gadget.of_refresh_ui()

//Set Edit to ON
iw_notes[UpperBound(iw_notes[])].of_edit_on()
end event

event type Integer ue_edit(long al_row);//////////////////////////////////////////////////////////////////////
// $<event>u_cst_gadget_notes::ue_edit()
// $<arguments>
//		value	long	al_row		
// $<returns> 
// $<description> Make note's edit status to On
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////
w_dashboard_notes lw_note

Long i,ll_note_id

If al_row < 1 Then Return 0

lw_note = of_find_note_win(al_row)
If isvalid(lw_note) Then
	lw_note.of_edit_on()
Else
	Return -1
End If
Return 1

end event

event type integer ue_close_note(long al_note_id);//////////////////////////////////////////////////////////////////////
// $<event>u_cst_gadget_notes::ue_close_note()
// $<arguments>
//		value	long	al_note_id		
// $<returns> integer
// $<description>
// $<description> Close the note by note's id
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer i
For i = 1 To UpperBound(iw_notes[])
	If Not isvalid(iw_notes[i]) Then Continue
	If iw_notes[i].istr_notes.sl_note_id = al_note_id Then
		Close(iw_notes[i])
		Exit
	End If
Next
Return 1
end event

event type integer ue_delete_row(long al_row);//////////////////////////////////////////////////////////////////////
// $<event>ue_delete_rowu_cst_gadget_notes()
// $<arguments>
//		value	long	al_row		
// $<returns> integer
// $<description>
// $<description> Delete selected note 
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_note_id
String ls_note,ls_note_mess

If al_row < 1 Then Return 0
ll_note_id = Dw_content.GetItemNumber(al_row,'id')
ls_note = Dw_content.GetItemString(al_row,'notes')
If LenA(ls_note) > 10 Then
	ls_note_mess = MidA(ls_note,1,10)+'...'
Else
	ls_note_mess = ls_note
End If

//Verify it
If ls_note <> '' Then
	If Messagebox('Delete','Are you sure you want to delete the "'+ls_note_mess+'" note?',Question!,YesNo!) = 2 Then 
		Return 0
	End If
End If

//Delete it
Dw_content.DeleteRow(al_row)
of_highlight_row(Dw_content.GetRow())
//Save data
gnv_appeondb.of_autocommitrollback()
If Dw_content.Update() = 1 Then
	Trigger Event ue_close_note(ll_note_id)  
Else
	Messagebox('Delete error','Failed to delete the note, please call support.')
	Trigger Event ue_retrieve() //Restore data
	Return -1
End If

//Compress height by refresh UI. 
iuo_tabpge_gadget.of_refresh_ui()

Return 1
end event

event type Integer ue_show_hide(long al_row);If al_row = 0 Then Return 0

If dw_content.GetItemNumber(al_row,'is_hide') = 1 Then
	of_show(al_row)
Else
	of_hide(al_row)
End If

Return 1
end event

public function integer of_hide_all ();
Long  i 
Integer li_hide[]
If dw_content.Rowcount() = 0 Then Return 0

For i = 1 to dw_content.Rowcount()
	li_hide[i] = 1
Next
dw_content.object.is_hide[1,dw_content.Rowcount()] = li_hide[]
gnv_appeondb.of_autocommitrollback()
If dw_content.update( ) = 1 Then
	dw_content.Modify("b_visible.Text='Show'")
	of_refresh_ui(iw_notes[])	
Else
	Messagebox('Save Error','Failed to hide all notes, please call support.')
	Event ue_retrieve() //Restore data
	Return -1
End If
	
Return 1
end function

public function integer of_show_all ();
Long  i 
Integer li_hide[]
If dw_content.Rowcount() = 0 Then Return 0

For i = 1 to dw_content.Rowcount()
	li_hide[i] = 0
Next
dw_content.object.is_hide[1,dw_content.Rowcount()] = li_hide[]
gnv_appeondb.of_autocommitrollback()
If dw_content.update( ) = 1 Then
	dw_content.Modify("b_visible.Text='Hide'")
	of_refresh_ui(iw_notes[])	
Else
	Messagebox('Save Error','Failed to show all notes, please call support.')
	Event ue_retrieve() //Restore data
	Return -1
End If
	
Return 1
end function

public function integer of_settings ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_gadget::of_settings()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description>Open gadget's Settings window, and set notes' properties.
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-06 by Ken.Guo
//////////////////////////////////////////////////////////////////////

//Override Ancestor Script

Str_gadget lstr_gadget
Long ll_back_color,ll_back_color_array[]
Boolean lb_rows_changed = False,lb_back_color_changed = False
Integer i

//Get backcolor properties
If dw_content.RowCount() = 0 Then 
	istr_current_gadget.al_temp1 = RGB(255,255,128) //Default color
Else
	ll_back_color = dw_content.GetItemNumber(1,'back_color') //Use NO.1 note's backcolor
	If isnull(ll_back_color) Then ll_back_color = RGB(255,255,128) //Default color
	istr_current_gadget.al_temp1 = ll_back_color
End If

//Open Settings window
OpenwithParm(w_dashboard_gadget_notes_config,istr_current_gadget)
lstr_gadget = Message.powerobjectparm

//If No changes
If lstr_gadget = istr_current_gadget Then Return 1

//Verify Changes
If lstr_gadget.gadget_rows_number <> istr_current_gadget.gadget_rows_number Then
	lb_rows_changed = True
End If
If lstr_gadget.al_temp1 <> istr_current_gadget.al_temp1 Then
	lb_back_color_changed = True
End If

istr_current_gadget = lstr_gadget
ll_back_color = lstr_gadget.al_temp1

//Apply the changes for Rows Number
If lb_rows_changed Then
	of_set_properties()
	of_update_to_db()
	iuo_tabpge_gadget.of_refresh_ui()
End If

//Apply the changes for BackColor
If lb_back_color_changed Then
	If dw_content.RowCount() = 0 Then Return 0//Don't set color if no rows.
	For i = 1 To dw_content.RowCount()
		ll_back_color_array[i] = ll_back_color
	Next
	dw_content.object.back_color[1,dw_content.rowcount()] = ll_back_color_array[]
	//Save to DB
	gnv_appeondb.of_autocommitrollback()
	If dw_content.update() <> 1 Then
		Messagebox('Save error','Failed to save the backcolor settings.')
		Return -1
	Else
		//Apply to UI for all notes.
		of_refresh_ui(iw_notes[])
	End If
End If

Return 1
end function

public function long of_get_back_color ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_gadget_notesof_get_back_color()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description> Get note's back color
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_back_color
//Get backcolor properties
If dw_content.RowCount() = 0 Then 
	ll_back_color = RGB(255,255,128) //Default color
Else
	ll_back_color = dw_content.GetItemNumber(1,'back_color') //Use NO.1 note's backcolor
	If isnull(ll_back_color) Then ll_back_color = RGB(255,255,128) //Default color
End If

Return ll_back_color
end function

public function integer of_refresh_ui (w_dashboard_notes aw_notes);//////////////////////////////////////////////////////////////////////
// $<function>u_cst_gadget_notesof_refresh_ui()
// $<arguments>
//		value	w_dashboard_notes	aw_notes		
// $<returns> integer
// $<description>
// $<description> Refresh the note's UI
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If isvalid(aw_notes) Then
	aw_notes.of_set_properties()
End If

Return 1
end function

public function integer of_refresh_ui (w_dashboard_notes aw_notes[]);Long i
For i = 1 To UpperBound(aw_notes[])
	If Not isvalid(aw_notes[i]) Then Continue
	of_refresh_ui(aw_notes[i])
Next
Return 1
end function

public subroutine of_highlight_row (long al_row);//////////////////////////////////////////////////////////////////////
// $<function>u_cst_gadget_notesof_highlight_row()
// $<arguments>
//		value	long	al_row		
// $<returns> (none)
// $<description>
// $<description> Highlight current row
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If dw_content.Getrow() > 0 Then
	dw_content.SetRow(al_row)
	dw_content.SelectRow(0,False)
	dw_content.SelectRow(al_row,True)
	If dw_content.GetItemNumber(al_row,'is_hide') = 1 Then
		dw_content.Modify("b_visible.Text='Show'")
	Else
		dw_content.Modify("b_visible.Text='Hide'")
	End If
End If


end subroutine

public function integer of_show (long al_row);//////////////////////////////////////////////////////////////////////
// $<function>u_cst_gadget_notes::of_show()
// $<arguments>
//		value	long	al_row		
// $<returns> integer
// $<description>
// $<description> Show the note.
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_hide
w_dashboard_notes lw_note

If al_row = 0 Then Return 0

li_hide = dw_content.GetItemNumber(al_row,'is_hide')
If li_hide = 0 Then Return 1  //It has hided
	
dw_content.SetItem(al_row,'is_hide',0)

//Save to DB
gnv_appeondb.of_autocommitrollback( )
If dw_content.update() = 1 Then
	//Refresh UI
	dw_content.Modify("b_visible.Text='Hide'")
	lw_note = of_find_note_win(al_row)
	If isvalid(lw_note) Then
		of_refresh_ui(lw_note)
	Else
		Return -1
	End If
Else
	Messagebox('Save error','Failed to hide the note, please call support.')
	Trigger Event ue_retrieve() //Restore Data
	Return -2
End If


Return 1
end function

public function w_dashboard_notes of_find_note_win (long al_row);//////////////////////////////////////////////////////////////////////
// $<function>u_cst_gadget_notes::of_find_note_win()
// $<arguments>
//		value	long	al_row		
// $<returns> w_dashboard_notes
// $<description>
// $<description> Locate target note window by row number
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer i
Long ll_note_id
w_dashboard_notes lw_note

If al_row = 0 Then Return lw_note
ll_note_id = dw_content.GetItemNumber(al_row,'id')
For i = 1 To UpperBound(iw_notes[])
	If Not isvalid(iw_notes[i]) Then Continue
	If iw_notes[i].istr_notes.sl_note_id = ll_note_id Then
		lw_note = iw_notes[i]
		Exit
	End If
Next
Return lw_note
end function

public function integer of_hide (long al_row);//////////////////////////////////////////////////////////////////////
// $<function>u_cst_gadget_notes::of_hide()
// $<arguments>
//		value	long	al_row		
// $<returns> integer
// $<description>
// $<description> Hide the note.
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_hide
w_dashboard_notes lw_note

If al_row = 0 Then Return 0

li_hide = dw_content.GetItemNumber(al_row,'is_hide')
If li_hide = 1 Then Return 1  //It has hided
	
dw_content.SetItem(al_row,'is_hide',1)

//Save to DB
gnv_appeondb.of_autocommitrollback( )
If dw_content.update() = 1 Then
	//Refresh UI
	dw_content.Modify("b_visible.Text='Show'")
	lw_note = of_find_note_win(al_row)
	If isvalid(lw_note) Then
		of_refresh_ui(lw_note)
	Else
		Return -1
	End If
Else
	Messagebox('Save error','Failed to hide the note, please call support.')
	Trigger Event ue_retrieve() //Restore Data
	Return -2
End If


Return 1
end function

public function integer of_delete_all (boolean ab_show_message);Long ll_note_id[]
String ls_note
Long ll_cnt,i
ll_cnt = dw_content.Rowcount()
If ll_cnt = 0 Then Return 0

If ab_show_message Then
	If Messagebox('Delete','Are you sure you want to delete all notes?',Question!,YesNo!) = 2 Then 
		Return 0
	End If
End If

//Delete all row
For i = 1 to ll_cnt  
	ll_note_id[i] = Dw_content.GetItemNumber(1,'id')
	dw_content.DeleteRow(1)
Next

//Save data
gnv_appeondb.of_autocommitrollback()
If Dw_content.Update() = 1 Then
	//Close notes window
	For i = 1 To UpperBound(ll_note_id[])
		Trigger Event ue_close_note(ll_note_id[i])
	Next 
Else
	Messagebox('Delete error','Failed to delete all notes, please call support.')
	Trigger Event ue_retrieve() //Restore data if failed to save.
	Return -1
End If

//Compress height by refresh UI
iuo_tabpge_gadget.of_refresh_ui()

Return 1
end function

on u_cst_gadget_notes.create
call super::create
end on

on u_cst_gadget_notes.destroy
call super::destroy
end on

event ue_do;call super::ue_do;//////////////////////////////////////////////////////////////////////
// $<event>u_cst_gadget_notes::ue_do()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> Open all notes.
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer i
Str_notes lstr_notes

If This.visible = False Then Return 0

Trigger Event ue_close() 

For i = 1 To dw_content.Rowcount()
	lstr_notes.sl_note_id = dw_content.GetItemNumber(i,'id')
	lstr_notes.sdw_note_list = dw_content
	OpenWithParm(iw_notes[i],lstr_notes,w_dashboard)
Next
This.Setfocus()
Return 1

end event

event ue_close;call super::ue_close;//////////////////////////////////////////////////////////////////////
// $<event>u_cst_gadget_notes::ue_close()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>
// $<description> Close all notes.
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-06 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer i
For i = 1 To UpperBound(iw_notes[])
	If isvalid(iw_notes[i]) Then Close(iw_notes[i])
Next
end event

type dw_content from u_cst_gadget`dw_content within u_cst_gadget_notes
event type integer ue_delete ( long al_row )
event ue_retrieve ( )
event ue_highlight_row ( long al_row )
event ue_hide ( long al_row )
string dataobject = "d_dashb_gadget_notes"
end type

event type integer dw_content::ue_delete(long al_row);Parent.Event ue_delete_row(al_row)
Return 1
end event

event dw_content::ue_retrieve();Parent.Trigger Event ue_retrieve()
end event

event dw_content::ue_highlight_row(long al_row);of_highlight_row(al_row)
end event

event dw_content::ue_hide(long al_row);Parent.of_hide(al_row)
end event

event dw_content::buttonclicked;call super::buttonclicked;//////////////////////////////////////////////////////////////////////
// $<event>u_cst_gadget_notes.dw_content::buttonclicked()
// $<arguments>
//		value	long    	row             		
//		value	long    	actionreturncode		
//		value	dwobject	dwo             		
// $<returns> long
// $<description>
// $<description> Button event.
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-12 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Choose Case dwo.name
	Case 'b_add'
		Parent.Trigger Event ue_add()
	Case 'b_del'
		Parent.Trigger Event ue_delete_row(This.GetRow())
	Case 'b_edit'
		Parent.Trigger Event ue_edit(This.GetRow())
	Case 'b_visible'
		Parent.Trigger Event ue_show_hide(This.GetRow())
End Choose
end event

event dw_content::rowfocuschanged;call super::rowfocuschanged;of_highlight_row(getrow())
end event

event dw_content::doubleclicked;call super::doubleclicked;Parent.Trigger Event ue_edit(GetRow())
end event

event dw_content::clicked;call super::clicked;of_highlight_row(getrow())
end event

type ln_split from u_cst_gadget`ln_split within u_cst_gadget_notes
end type

type st_1 from u_cst_gadget`st_1 within u_cst_gadget_notes
end type

type st_title from u_cst_gadget`st_title within u_cst_gadget_notes
end type

type pb_close from u_cst_gadget`pb_close within u_cst_gadget_notes
end type

event pb_close::clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event>u_cst_gadget_notes.pb_close::clicked()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description> Close all notes.
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-06 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Event ue_close()
end event

type pb_max from u_cst_gadget`pb_max within u_cst_gadget_notes
end type

type pb_edit from u_cst_gadget`pb_edit within u_cst_gadget_notes
end type

event pb_edit::clicked;//Override ancestor script
//m_dashboard_gadget_notes

m_dashboard_gadget_notes m_notes
m_notes = Create m_dashboard_gadget_notes
m_notes.Popmenu(w_mdi.PointerX(),w_mdi.PointerY())

end event

