$PBExportHeader$w_recru_doc_select.srw
forward
global type w_recru_doc_select from window
end type
type st_1 from statictext within w_recru_doc_select
end type
type dw_1 from datawindow within w_recru_doc_select
end type
type cb_cancel from commandbutton within w_recru_doc_select
end type
type cb_1 from commandbutton within w_recru_doc_select
end type
end forward

global type w_recru_doc_select from window
integer width = 2327
integer height = 1048
boolean titlebar = true
string title = "Select Document"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_1 st_1
dw_1 dw_1
cb_cancel cb_cancel
cb_1 cb_1
end type
global w_recru_doc_select w_recru_doc_select

type variables
long il_rec_id = 0
string is_file_name
end variables

forward prototypes
public function string of_syntax_5 (string as_val)
public function string of_syntax_lu (string as_val, string as_screen)
public function integer of_create_dw (string as_sql)
public function string of_syntax_20 (string as_val)
public function string of_syntax_not_addr (string as_screen, string as_val)
end prototypes

public function string of_syntax_5 (string as_val);string ls_sql

//---------Begin Modified by (Appeon)Stephen 12.25.2014 for DEA Demographics screen for webcraw- Allegheny--------
//ls_sql = "SELECT wc_id,  wc_description FROM wc_hdr   WHERE ( wc_hdr.wc_screen_id_link = 5 ) AND   ( wc_hdr.wc_screen_field_link_fixed_value = '" + as_val + "');"
ls_sql = "SELECT wc_id,  wc_description FROM wc_hdr   WHERE ( wc_hdr.wc_screen_id_link = 5 ) AND   ( wc_hdr.wc_screen_field_link_fixed_value = '" + as_val + "' or wc_hdr.wc_screen_field_link_fixed_value='' or wc_hdr.wc_screen_field_link_fixed_value=null);"
//---------End Modfiied ------------------------------------------------------


return ls_sql
end function

public function string of_syntax_lu (string as_val, string as_screen);string ls_sql


ls_sql = "SELECT DISTINCT wc_hdr.wc_id, wc_description FROM wc_hdr,    wc_multi_entity_link,    address_lookup	WHERE ( wc_hdr.wc_id = wc_multi_entity_link.wc_id ) and  ( wc_multi_entity_link.wc_lookup_code = address_lookup.lookup_code ) and  ( ( wc_hdr.wc_screen_id_link = '" + as_screen +  "' ) AND  ( address_lookup.lookup_code = '"  + as_val +  "') ) ;"


return ls_sql
end function

public function integer of_create_dw (string as_sql);string ls_sql	
string ls_presentation_str
string ERRORS
string ls_dwsyntax_str
integer w
//messagebox("is_sql",is_sql)

ls_sql = as_sql
dw_1.settransobject(sqlca)
ls_presentation_str = "style(type=grid)"		
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution on export field " + ls_sql, 	"SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_sql)
//	MessageBox("ls_select_table",ls_select_table)
	
	RETURN -1
END IF

w = dw_1.Create( ls_dwsyntax_str, ERRORS)
if w < 1 then
	messagebox("Error on create of duplicate Crawler list",errors)
end if

dw_1.settransobject(sqlca)
//Start Code Change ---- 05.16.2007 #V7 maha
dw_1.retrieve()
//dw_1.object.wc_hdr_wc_id_t.text = "ID"
//dw_1.object.wc_hdr_wc_description_t.text = "Web Crawler Name"
//End Code Change---05.16.2007

return 1
end function

public function string of_syntax_20 (string as_val);string ls_sql

ls_sql = "SELECT wc_id,  wc_description FROM wc_hdr   WHERE ( wc_hdr.wc_screen_id_link = 20 );"


return ls_sql
end function

public function string of_syntax_not_addr (string as_screen, string as_val);//Start Code Change ----01.02.2008 #V8 maha // added for other ids or other screens that don't use address lookups

string ls_sql

ls_sql = "SELECT wc_id,  wc_description FROM wc_hdr   WHERE ( wc_hdr.wc_screen_id_link = " + as_screen + " ) AND   ( wc_hdr.wc_screen_field_link_fixed_value = '" + as_val + "');"


return ls_sql
end function

on w_recru_doc_select.create
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_cancel=create cb_cancel
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.dw_1,&
this.cb_cancel,&
this.cb_1}
end on

on w_recru_doc_select.destroy
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_cancel)
destroy(this.cb_1)
end on

event open;//====================================================================
//$<Event>: open
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 11.05.2015 (V15.1-Additional TDL type of Recruitment Task)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_col, li_cnt
string ls_mes
str_import_cur lstr_message

lstr_message = message.powerobjectparm
ls_mes = lstr_message.s_name
lstr_message.dw_rep.sharedata(dw_1)
li_col = integer(dw_1.describe("datawindow.column.count"))
for li_cnt = 1 to li_col
	dw_1.modify("#"+string(li_cnt)+".tabsequence=0")
next
if dw_1.rowcount() > 0 then
	dw_1.selectrow(1, true)
	il_rec_id = dw_1.getitemnumber(1, "rec_id")
end if

this.title = this.title + " for: " + ls_mes



end event

type st_1 from statictext within w_recru_doc_select
integer x = 23
integer y = 60
integer width = 2245
integer height = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Please select the document you want to convert from the following document(s)."
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_recru_doc_select
integer y = 192
integer width = 2309
integer height = 564
integer taborder = 10
string title = "none"
string dataobject = "d_recruit_image_list"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;integer r

r = this.getclickedrow()

if r < 1 then return

this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)
il_rec_id = dw_1.getitemnumber(r, "rec_id")
is_file_name = dw_1.getitemstring(r, "file_name")
end event

event doubleclicked;cb_1.triggerevent(clicked!)
end event

type cb_cancel from commandbutton within w_recru_doc_select
integer x = 1202
integer y = 780
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,0)
end event

type cb_1 from commandbutton within w_recru_doc_select
integer x = 841
integer y = 780
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
boolean default = true
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 11.11.2015 (V15.1-Additional TDL type of Recruitment Task)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_return

ls_return = string(il_rec_id) + "$$"+is_file_name
closewithreturn(parent,ls_return)


end event

