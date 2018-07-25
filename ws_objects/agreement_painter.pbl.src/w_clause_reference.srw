$PBExportHeader$w_clause_reference.srw
$PBExportComments$Create by Jack 11/03/2006
forward
global type w_clause_reference from w_main
end type
type cb_cancel from commandbutton within w_clause_reference
end type
type cb_ok from commandbutton within w_clause_reference
end type
type tab_1 from u_tab_agreement_clause_reference within w_clause_reference
end type
type tab_1 from u_tab_agreement_clause_reference within w_clause_reference
end type
end forward

global type w_clause_reference from w_main
integer width = 4110
integer height = 2292
string title = "Clause Library Browse"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean center = true
boolean ib_isupdateable = false
event pfc_cst_go ( )
event pfc_clear ( )
event pfc_addrow ( )
event pfc_cst_add_clause ( )
event type long pfc_deleterow ( )
event pfc_cst_rules ( )
event pfc_cst_properties ( )
event pfc_cst_rights ( )
event pfc_cst_expandall ( )
event pfc_cst_collapseall ( )
event pfc_cst_autonumbering ( )
event pfc_cst_select ( )
event pfc_cst_autonum1 ( )
event pfc_cst_autonum2 ( )
event pfc_cst_autonum3 ( )
event pfc_cst_autonum4 ( )
event pfc_cst_autonum5 ( )
event pfc_cst_clause_reference ( )
cb_cancel cb_cancel
cb_ok cb_ok
tab_1 tab_1
end type
global w_clause_reference w_clause_reference

type variables
long il_handle,il_ctx_acp_folder_id,il_ctx_acp_clause_id,il_parent_folder_id,il_category
long il_first = 1
long il_folder[]
string is_type,is_types,is_clause_name
string is_data = '',is_data_delete,is_filter
str_folder istr_folder
datastore ids_template_clause
datastore ids_folder
datastore ids_clause
datastore ids_clause_rely
datastore ids_next_handle
datastore ids_search_clause_text
datawindowchild idw_child
end variables

forward prototypes
public function integer of_ltrimword ()
public function integer of_rtrimword ()
public function integer of_autonum (string as_num)
public function integer of_check_numbering ()
end prototypes

event pfc_cst_go();tab_1.tabpage_browse.cb_go.triggerevent(clicked!)

end event

event pfc_clear();tab_1.tabpage_browse.cb_clear.triggerevent(clicked!)

end event

event pfc_addrow();tab_1.of_add_folder()

end event

event pfc_cst_add_clause();tab_1.of_add_clause()


end event

event type long pfc_deleterow();tab_1.of_deleterow()
Return 1

end event

event pfc_cst_rules();tab_1.of_rely()

end event

event pfc_cst_properties();tab_1.of_properties()


end event

event pfc_cst_rights();Open(w_security_roles_painter)

end event

event pfc_cst_expandall();long ll_tvi
ll_tvi = tab_1.tabpage_browse.tv_clause.FindItem(RootTreeItem!, 0)
tab_1.tabpage_browse.tv_clause.ExpandAll(ll_tvi)

end event

event pfc_cst_collapseall();long ll_tvi

ll_tvi = tab_1.tabpage_browse.tv_clause.finditem(roottreeitem!, 0)
ll_tvi = tab_1.tabpage_browse.tv_clause.FindItem(ChildTreeItem!,ll_tvi)

Do While ll_tvi > 0 
	tab_1.tabpage_browse.tv_clause.collapseitem(ll_tvi)
	ll_tvi = tab_1.tabpage_browse.tv_clause.finditem(NextTreeItem!, ll_tvi)
Loop


end event

event pfc_cst_autonumbering();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-26 By: Rodger Wu (auto num)
Open( w_ctx_template_autonum )
//---------------------------- APPEON END ----------------------------

end event

event pfc_cst_select();If tab_1.of_open_word_file() = 1 Then
	tab_1.selecttab(2)
End If


end event

event pfc_cst_autonum1();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_autonum1 of w_clause_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Insert symbol for auto numbering
//////////////////////////////////////////////////////////////////////
// $<add> 03.07.2007 by Alfee (Contract Logix Clause Painter)
//////////////////////////////////////////////////////////////////////

of_autonum('1')


end event

event pfc_cst_autonum2();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_autonum2 of w_clause_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Insert symbol for auto numbering
//////////////////////////////////////////////////////////////////////
// $<add> 03.07.2007 by Alfee (Contract Logix Clause Painter)
//////////////////////////////////////////////////////////////////////

of_autonum('2')


end event

event pfc_cst_autonum3();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_autonum3 of w_clause_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Insert symbol for auto numbering
//////////////////////////////////////////////////////////////////////
// $<add> 03.07.2007 by Alfee (Contract Logix Clause Painter)
//////////////////////////////////////////////////////////////////////

of_autonum('3')


end event

event pfc_cst_autonum4();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_autonum4 of w_clause_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Insert symbol for auto numbering
//////////////////////////////////////////////////////////////////////
// $<add> 03.07.2007 by Alfee (Contract Logix Clause Painter)
//////////////////////////////////////////////////////////////////////

of_autonum('4')


end event

event pfc_cst_autonum5();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_autonum3 of w_clause_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Insert symbol for auto numbering
//////////////////////////////////////////////////////////////////////
// $<add> 03.24.2007 by Alfee (Contract Logix Clause Painter)
//////////////////////////////////////////////////////////////////////

of_autonum('5')


end event

event pfc_cst_clause_reference();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_clause_reference of w_clause_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Insert clause reference in document
//////////////////////////////////////////////////////////////////////
// $<add> 03.24.2007 by Alfee (Contract Logix Clause Painter)
//////////////////////////////////////////////////////////////////////
Long ll_clause_id
Oleobject lole_word
	
//Open(w_clause_reference)
ll_clause_id = Message.DoubleParm
IF ll_clause_id > 0 THEN
	IF tab_1.tabpage_clause.ole_1.object.DocType < 1 THEN RETURN 
	lole_word = tab_1.tabpage_clause.ole_1.object.activedocument
	lole_word.ActiveWindow.Selection.InsertAfter("clause_"+String(ll_clause_id))
	Destroy lole_word
END IF


end event

public function integer of_ltrimword ();integer li_count, i, li_length, j, li_asc, li_todelete[], k
string ls_content, ls_char
boolean lb_deleteit

li_count = tab_1.tabpage_clause.ole_1.object.ActiveDocument.Paragraphs.count
for i = 1 to li_count
	ls_content = tab_1.tabpage_clause.ole_1.object.ActiveDocument.Paragraphs[i].range.text
	ls_content = trim( ls_content )
	
	li_length = Len( ls_content )
	lb_deleteit = True
	for j = 1 to li_length
		ls_char = Mid( ls_content, j, 1 )
		//li_asc = ASC( ls_char )
		
		if pos("~n~t~v~r~f", ls_char ) > 0 then
			continue;
		else
			lb_deleteit = False
			exit
		end if
	next
	
	if lb_deleteit then
		k++
		li_todelete[k] = i
	else
		exit;
	end if
next

li_count = Upperbound( li_todelete )
for i = li_count to 1 step -1
	j = li_todelete[i]
	tab_1.tabpage_clause.ole_1.object.ActiveDocument.Paragraphs[j].range.delete()
next

return li_count;
end function

public function integer of_rtrimword ();integer li_count, i, li_length, j, li_asc, k
string ls_content, ls_char
boolean lb_deleteit

li_count = tab_1.tabpage_clause.ole_1.object.ActiveDocument.Paragraphs.count
for i = li_count to 1 step -1
	ls_content = tab_1.tabpage_clause.ole_1.object.ActiveDocument.Paragraphs[i].range.text
	ls_content = trim( ls_content )
	
	li_length = Len( ls_content )
	lb_deleteit = True
	for j = 1 to li_length
		ls_char = Mid( ls_content, j, 1 )
		//li_asc = ASC( ls_char )
		
		if pos("~n~t~v~r~f", ls_char ) > 0 then
			continue;
		else
			lb_deleteit = False
			exit
		end if
	next
	
	if lb_deleteit then
		tab_1.tabpage_clause.ole_1.object.ActiveDocument.Paragraphs[i].range.delete()
		k++;
	else
		exit;
	end if
next

return k;
end function

public function integer of_autonum (string as_num);//////////////////////////////////////////////////////////////////////
// $<function>of_autonum()
// $<arguments>
//		value	string
// $<returns> 1 - sucessed; -1 - failed
// $<description>Insert a symbol in word document for auto numbering
//////////////////////////////////////////////////////////////////////
// $<add> 03.07.2007 by Alfee (Contract Logix Clause Painter)
//////////////////////////////////////////////////////////////////////
Oleobject lole_word

IF tab_1.tabpage_clause.ole_1.object.DocType < 1 THEN RETURN -1
lole_word = tab_1.tabpage_clause.ole_1.object.activedocument

CHOOSE CASE Lower(as_num)
	CASE '1' //##
		lole_word.ActiveWindow.Selection.InsertAfter('##')
	CASE '2' //#.0
		lole_word.ActiveWindow.Selection.InsertAfter('#.0')		
	CASE '3' //#.#
		lole_word.ActiveWindow.Selection.InsertAfter('#.#')	
	CASE '4' //example
		open(w_clause_autonum_example)
	CASE '5' //@@
		lole_word.ActiveWindow.Selection.InsertAfter('@@')			
END CHOOSE

RETURN 1
end function

public function integer of_check_numbering ();//////////////////////////////////////////////////////////////////////
// $<function>w_clause_painter.of_check_numbering()
// $<arguments>	(none)	
// $<returns> integer
// $<description>Check the numbering in clause document
//////////////////////////////////////////////////////////////////////
// $<add> 03.07.2006 by Alfee (Contract Logix Agreement Clause Painter)
//////////////////////////////////////////////////////////////////////
//WdFindWrap
Constant int wdFindAsk = 2 
Constant int wdFindContinue = 1 
Constant int wdFindStop = 0 
//WdReplace
Constant int wdReplaceAll = 2 
Constant int wdReplaceNone = 0 
Constant int wdReplaceOne = 1 

String is_chapter[] = {"##","@@"}
String is_paragraph = "#.0"
String is_section = "#.#"
Boolean lb_found_chapter[] = {false,false}
Boolean lb_found_paragraph = false 
Boolean lb_found_section = false
Boolean lb_found = false
Long ll_pos_chapter, ll_pos_paragraph,ll_pos_section
Oleobject lole_word

if tab_1.tabpage_clause.ole_1.object.DocType < 1 then return -1
lole_word = tab_1.tabpage_clause.ole_1.object.activedocument

//Check whether existing #.# but without #.0, or existing #.# but without ## above it
//Find section (#.#)
lole_word.content.select()
lole_word.activewindow.selection.find.ClearFormatting()
lb_found_section =  lole_word.activewindow.selection.find.Execute(is_section, false, true, false, false, false, true, wdFindStop, false, "", wdReplaceNone )
If lb_found_section Then 
	ll_pos_section = lole_word.activewindow.selection.start
End If

//Find & check paragraph (#.0)
lole_word.content.select()
lole_word.activewindow.selection.find.ClearFormatting()
lb_found_paragraph = lole_word.activewindow.selection.find.Execute(is_paragraph, false, true, false, false, false, true, wdFindStop, false, "", wdReplaceNone )
ll_pos_paragraph = lole_word.activewindow.selection.start
If lb_found_section Then // If section(#.#) found
	If Not lb_found_paragraph Then  //If paragraph(#.0) not found
		lole_word.Range(0,0).select() //by alfee at 03.13.2007			
  	 	//MessageBox("Alert","The auto number " + is_paragraph +" is missed!",Exclamation!)
   	MessageBox("Alert","The auto number " + is_paragraph +" is missing!",Exclamation!)
		Return -1
	Else //If paragraph(#.0) found
		If ll_pos_section < ll_pos_paragraph Then
			lole_word.Range(0,0).select() //by alfee at 03.13.2007						
			MessageBox("Alert","The auto number format is out of order!",Exclamation!)
			Return -1
	 	End If
	End If
End If

//Find chapter (## or @@) if paragraph #.0 found
If lb_found_paragraph then 
 	lole_word.content.select()
	lole_word.activewindow.selection.find.ClearFormatting()
	lb_found_chapter[1] = lole_word.activewindow.selection.find.Execute(is_chapter[1], false, true, false, false, false, true, wdFindStop, false, "", wdReplaceNone )	
	If Not lb_found_chapter[1] Then //If ## not found
 	 	lole_word.content.select()
		lole_word.activewindow.selection.find.ClearFormatting()
		lb_found_chapter[2] = lole_word.activewindow.selection.find.Execute(is_chapter[2], false, true, false, false, false, true, wdFindStop, false, "", wdReplaceNone )				
		If not lb_found_chapter[2] Then //If @@ also not found
			lole_word.Range(0,0).select() //by alfee at 03.13.2007
  			//MessageBox("Alert","The auto number " + is_chapter[1] +" is missed!",Exclamation!)
   		MessageBox("Alert","The auto number " + is_chapter[1] +" is missing!",Exclamation!)
			Return -1
		End if
	End If
	If lb_found_chapter[1] or lb_found_chapter[2] Then // If any chapter(## or @@) found
	 	ll_pos_chapter = lole_word.activewindow.selection.start
		If ll_pos_paragraph < ll_pos_chapter Then
			lole_word.Range(0,0).select() //by alfee at 03.13.2007			
			MessageBox("Alert","The auto number format is out of order!",Exclamation!)
			Return -1
	 	End If	
	End If	
End If
	
//Check whether existing #.1 - #.9 
lole_word.content.select()
lole_word.activewindow.selection.find.ClearFormatting()
lb_found = lole_word.activewindow.selection.find.Execute("#.[1-9]", false, true, true, false, false, true, wdFindStop, false, "", wdReplaceNone )	
If lb_found Then 
	MessageBox("Alert","#.1-9 is an invalid auto number format!",Exclamation!)
	Return -1
End If

lole_word.Range(0,0).select()
Return 1
end function

on w_clause_reference.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.tab_1
end on

on w_clause_reference.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.tab_1)
end on

event close;//tab_1.of_close()
//w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
//w_mdi.of_menu_security( w_mdi.MenuName )
//
end event

event pfc_save;//tab_1.of_save()
Return 1
end event

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event>openw_clause_painter()
// $<arguments>(None)
// $<returns> long
// $<description>This window is designed by Jack
// $<description>Clause Library Painter
//////////////////////////////////////////////////////////////////////
// $<add> 12.08.2006 by Jack (Clause Library Painter)
//////////////////////////////////////////////////////////////////////

//This.move(1,1)

//--------Added by alfee 05.04.2007-----------------------
If tab_1.tabpage_browse.dw_browse.rowcount() > 0 Then
	tab_1.tabpage_browse.dw_browse.SetSort("clause_name A")
	tab_1.tabpage_browse.dw_browse.Sort()
End If
//--------End Added --------------------------------------
end event

event pfc_preopen;call super::pfc_preopen;
long ll_i
string ls_scale

This.of_SetResize(True)

This.inv_resize.of_SetOrigSize (This.workspacewidth(),This.workspaceheight())
ls_scale = this.inv_resize.scale

For ll_i =  1 To upperbound(This.CONTrol)
   This.inv_resize.of_Register (This.CONTrol[ll_i],ls_scale)
Next


end event

event activate;//long ll_handle
//
//If w_mdi.menuname <> 'm_pfe_cst_clause_painter' Then 
//	ll_handle = handle(w_mdi)
//	w_mdi.ChangeMenu( m_pfe_cst_clause_painter )
//	w_mdi.SetToolbarPos ( 2, 1, 200, False )
//	w_mdi.of_menu_security( w_mdi.MenuName )
//	gnv_appeondll.of_settoolbarpos(ll_handle)
//
////	If w_mdi.of_security_access( 6803 ) = 0 Then
////		m_pfe_cst_clause_painter.m_edit.m_rights.toolbaritemvisible = False
////	Else
////		m_pfe_cst_clause_painter.m_edit.m_rights.toolbaritemvisible = True
////	End If
//	m_pfe_cst_clause_painter.m_file.m_save.enabled = False
//	m_pfe_cst_clause_painter.m_file.m_properties.enabled = False
//	m_pfe_cst_clause_painter.m_file.m_addclause.enabled = False
//	m_pfe_cst_clause_painter.m_edit.m_delete1.enabled = False
//	m_pfe_cst_clause_painter.m_view.m_rules.enabled = False	
//End If



end event

event closequery;//
end event

type cb_cancel from commandbutton within w_clause_reference
integer x = 3721
integer y = 2104
integer width = 343
integer height = 92
integer taborder = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;ClosewithReturn(Parent, 0)
end event

type cb_ok from commandbutton within w_clause_reference
integer x = 3383
integer y = 2104
integer width = 343
integer height = 92
integer taborder = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;Long ll_row, ll_clause_id
String ls_clause_name, ls_rtn, ls_clause_id

ll_row = tab_1.tabpage_browse.dw_browse.GetRow()

If ll_row > 0 Then
	ll_clause_id = tab_1.tabpage_browse.dw_browse.GetItemNumber(ll_row, "ctx_acp_clause_id")
	ls_clause_id = String(ll_clause_id)
	//----Modified by alfee 04.17.2007------------
	/*IF len(ls_clause_id) < 6 THEN
		ls_clause_id = Fill('*', 6 - Len(ls_clause_id)) + ls_clause_id
	END IF
	ls_clause_name = 	tab_1.tabpage_browse.dw_browse.GetItemString(ll_row, "clause_name")
	ls_rtn = "<<|"+ls_clause_id + "-" + ls_clause_name+"|>>"
	*/
	ls_clause_name = 	tab_1.tabpage_browse.dw_browse.GetItemString(ll_row, "clause_name")
	ls_rtn = ls_clause_id + "-" + ls_clause_name
	//-----End Modified----------------------------
	ClosewithReturn(Parent, ls_rtn)
Else
	//MessageBox("Browse","Please select a clause at first!")
	MessageBox("Browse","Please select a clause first!")
End If
end event

type tab_1 from u_tab_agreement_clause_reference within w_clause_reference
integer height = 2116
integer taborder = 11
boolean bringtotop = true
end type

