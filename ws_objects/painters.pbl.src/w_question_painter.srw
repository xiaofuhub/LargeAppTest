$PBExportHeader$w_question_painter.srw
forward
global type w_question_painter from window
end type
type p_1 from picture within w_question_painter
end type
type tab_1 from tab within w_question_painter
end type
type tabpage_question from userobject within tab_1
end type
type st_notfound from statictext within tabpage_question
end type
type cb_sort from commandbutton within tabpage_question
end type
type rb_down from radiobutton within tabpage_question
end type
type rb_up from radiobutton within tabpage_question
end type
type cb_filter from commandbutton within tabpage_question
end type
type st_1 from statictext within tabpage_question
end type
type sle_find from singlelineedit within tabpage_question
end type
type cb_find from commandbutton within tabpage_question
end type
type dw_quest from datawindow within tabpage_question
end type
type gb_2 from groupbox within tabpage_question
end type
type tabpage_question from userobject within tab_1
st_notfound st_notfound
cb_sort cb_sort
rb_down rb_down
rb_up rb_up
cb_filter cb_filter
st_1 st_1
sle_find sle_find
cb_find cb_find
dw_quest dw_quest
gb_2 gb_2
end type
type tabpage_templates from userobject within tab_1
end type
type dw_temp_detail from datawindow within tabpage_templates
end type
type cb_tempdel from commandbutton within tabpage_templates
end type
type cb_tempadd from commandbutton within tabpage_templates
end type
type dw_items from datawindow within tabpage_templates
end type
type dw_temp_select from datawindow within tabpage_templates
end type
type gb_1 from groupbox within tabpage_templates
end type
type tabpage_templates from userobject within tab_1
dw_temp_detail dw_temp_detail
cb_tempdel cb_tempdel
cb_tempadd cb_tempadd
dw_items dw_items
dw_temp_select dw_temp_select
gb_1 gb_1
end type
type tab_1 from tab within w_question_painter
tabpage_question tabpage_question
tabpage_templates tabpage_templates
end type
type cb_close from commandbutton within w_question_painter
end type
type cb_save from commandbutton within w_question_painter
end type
type cb_delete from commandbutton within w_question_painter
end type
type cb_add from commandbutton within w_question_painter
end type
end forward

global type w_question_painter from window
integer width = 3483
integer height = 2076
boolean titlebar = true
string title = "Questions Lookup"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
p_1 p_1
tab_1 tab_1
cb_close cb_close
cb_save cb_save
cb_delete cb_delete
cb_add cb_add
end type
global w_question_painter w_question_painter

type variables
long il_temp_id
integer ii_ret = 0
end variables

on w_question_painter.create
this.p_1=create p_1
this.tab_1=create tab_1
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.Control[]={this.p_1,&
this.tab_1,&
this.cb_close,&
this.cb_save,&
this.cb_delete,&
this.cb_add}
end on

on w_question_painter.destroy
destroy(this.p_1)
destroy(this.tab_1)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.cb_add)
end on

event open;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.07.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
datawindowchild dwchild

tab_1.tabpage_question.dw_quest.retrieve()
tab_1.tabpage_templates.dw_temp_select.retrieve()
tab_1.tabpage_templates.dw_temp_select.insertrow(1)


tab_1.tabpage_question.dw_quest.GetChild( "quest_type", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Question Type")
dwchild.InsertRow( 1 )

tab_1.tabpage_templates.dw_temp_detail.GetChild( "temp_type", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Template Type")
dwchild.InsertRow( 1 )
*/
datawindowchild dwchild

tab_1.tabpage_question.dw_quest.retrieve()
tab_1.tabpage_templates.dw_temp_select.retrieve()
tab_1.tabpage_templates.dw_temp_select.insertrow(1)
//------------------- APPEON BEGIN -------------------
//$<modify> Evan 05.08.2009
//$<reason> Corrected BugE011904
tab_1.tabpage_templates.dw_temp_select.GetChild("temp_id", dwchild)
dwchild.InsertRow(1)
//------------------- APPEON END ---------------------

tab_1.tabpage_question.dw_quest.GetChild( "quest_type", dwchild )
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('Question Type') + "'", dwchild)
dwchild.InsertRow( 1 )

tab_1.tabpage_templates.dw_temp_detail.GetChild( "temp_type", dwchild )
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('Template Type') + "'", dwchild)
dwchild.InsertRow( 1 )

//---------------------------- APPEON END ----------------------------

if message.stringparm = "RECRUIT" then
	tab_1.tabpage_question.dw_quest.setfilter("quest_type = -108") //(Appeon)Stephen 03.25.2016 -MODIFY '-107' TO '-108' Recruitment Qualification Questions are still showing numbers
	tab_1.tabpage_question.dw_quest.filter()
end if
	






end event

type p_1 from picture within w_question_painter
boolean visible = false
integer x = 699
integer y = 16
integer width = 82
integer height = 60
boolean originalsize = true
string picturename = "arrowhead.png"
boolean focusrectangle = false
end type

type tab_1 from tab within w_question_painter
integer y = 44
integer width = 3465
integer height = 1928
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_question tabpage_question
tabpage_templates tabpage_templates
end type

on tab_1.create
this.tabpage_question=create tabpage_question
this.tabpage_templates=create tabpage_templates
this.Control[]={this.tabpage_question,&
this.tabpage_templates}
end on

on tab_1.destroy
destroy(this.tabpage_question)
destroy(this.tabpage_templates)
end on

type tabpage_question from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3429
integer height = 1812
long backcolor = 33551856
string text = "Questions"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_notfound st_notfound
cb_sort cb_sort
rb_down rb_down
rb_up rb_up
cb_filter cb_filter
st_1 st_1
sle_find sle_find
cb_find cb_find
dw_quest dw_quest
gb_2 gb_2
end type

on tabpage_question.create
this.st_notfound=create st_notfound
this.cb_sort=create cb_sort
this.rb_down=create rb_down
this.rb_up=create rb_up
this.cb_filter=create cb_filter
this.st_1=create st_1
this.sle_find=create sle_find
this.cb_find=create cb_find
this.dw_quest=create dw_quest
this.gb_2=create gb_2
this.Control[]={this.st_notfound,&
this.cb_sort,&
this.rb_down,&
this.rb_up,&
this.cb_filter,&
this.st_1,&
this.sle_find,&
this.cb_find,&
this.dw_quest,&
this.gb_2}
end on

on tabpage_question.destroy
destroy(this.st_notfound)
destroy(this.cb_sort)
destroy(this.rb_down)
destroy(this.rb_up)
destroy(this.cb_filter)
destroy(this.st_1)
destroy(this.sle_find)
destroy(this.cb_find)
destroy(this.dw_quest)
destroy(this.gb_2)
end on

type st_notfound from statictext within tabpage_question
boolean visible = false
integer x = 1111
integer y = 12
integer width = 471
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
string text = "Record not Found"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_sort from commandbutton within tabpage_question
integer x = 2464
integer y = 76
integer width = 343
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)

tab_1.tabpage_question.dw_quest.Setsort(null_str)

tab_1.tabpage_question.dw_quest.sort( )
end event

type rb_down from radiobutton within tabpage_question
integer x = 1659
integer y = 128
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Down"
boolean checked = true
end type

type rb_up from radiobutton within tabpage_question
integer x = 1659
integer y = 68
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Up"
end type

type cb_filter from commandbutton within tabpage_question
integer x = 2098
integer y = 76
integer width = 343
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;string null_str

SetNull(null_str)

tab_1.tabpage_question.dw_quest.Setfilter(null_str)

tab_1.tabpage_question.dw_quest.filter( )
end event

type st_1 from statictext within tabpage_question
integer x = 18
integer y = 12
integer width = 503
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Search Questions"
boolean focusrectangle = false
end type

type sle_find from singlelineedit within tabpage_question
integer x = 41
integer y = 80
integer width = 1184
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_find from commandbutton within tabpage_question
integer x = 1243
integer y = 76
integer width = 343
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Find"
end type

event clicked;long s
long e
long c
long f
string ls_f



if LenA(sle_find.text) < 1 then 
	return
else
	ls_f = lower(sle_find.text)
end if

st_notfound.visible = false

c = tab_1.tabpage_question.dw_quest.getrow() 
e = tab_1.tabpage_question.dw_quest.rowcount()
s = 1

if rb_down.checked then	
	f = tab_1.tabpage_question.dw_quest.find("lower(full_quest) like '%" + ls_f + "%'",c + 1, e)
elseif rb_up.checked then
	f = tab_1.tabpage_question.dw_quest.find("lower(full_quest) like '%" + ls_f + "%'",c - 1, s)
end if

if f > 0 then
	tab_1.tabpage_question.dw_quest.scrolltorow(f)
	tab_1.tabpage_question.dw_quest.setrow(f)
//Start Code Change ----03.24.2008 #V8 maha	- removed auto direction switch
//	if f = e then 
//		rb_up.checked = true
//		rb_down.checked = false
//	elseif f = 1 then
//		rb_down.checked = true
//		rb_up.checked = false
//	end if
else
	st_notfound.visible = true
end if


	



end event

type dw_quest from datawindow within tabpage_question
integer y = 212
integer width = 3429
integer height = 1600
integer taborder = 20
string title = "none"
string dataobject = "d_question_de"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;//Added by Nova.zhang on 12.15.2008
IF appeongetclienttype() = 'WEB' THEN this.dataobject = 'd_question_de_web' //for size adjusted 


this.settransobject(sqlca)
this.setrowfocusindicator( p_1) //Start Code Change ----12.04.2009 #V92 maha - changed indicator
end event

type gb_2 from groupbox within tabpage_question
integer x = 1618
integer y = 8
integer width = 411
integer height = 192
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Direction"
end type

type tabpage_templates from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3429
integer height = 1812
long backcolor = 33551856
string text = "Templates"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_temp_detail dw_temp_detail
cb_tempdel cb_tempdel
cb_tempadd cb_tempadd
dw_items dw_items
dw_temp_select dw_temp_select
gb_1 gb_1
end type

on tabpage_templates.create
this.dw_temp_detail=create dw_temp_detail
this.cb_tempdel=create cb_tempdel
this.cb_tempadd=create cb_tempadd
this.dw_items=create dw_items
this.dw_temp_select=create dw_temp_select
this.gb_1=create gb_1
this.Control[]={this.dw_temp_detail,&
this.cb_tempdel,&
this.cb_tempadd,&
this.dw_items,&
this.dw_temp_select,&
this.gb_1}
end on

on tabpage_templates.destroy
destroy(this.dw_temp_detail)
destroy(this.cb_tempdel)
destroy(this.cb_tempadd)
destroy(this.dw_items)
destroy(this.dw_temp_select)
destroy(this.gb_1)
end on

type dw_temp_detail from datawindow within tabpage_templates
integer x = 1957
integer y = 32
integer width = 1458
integer height = 160
integer taborder = 30
string title = "none"
string dataobject = "d_quest_temp_detail"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type cb_tempdel from commandbutton within tabpage_templates
integer x = 1458
integer y = 64
integer width = 402
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Template"
end type

event clicked;
integer i
integer ic

if il_temp_id < 1 then return

//if messagebox("Delete Template","A",question!,yesno!,2) = 1 then
if messagebox("Delete Template","Are you sure you wish to delete this template?",question!,yesno!,2) = 1 then //Modified By Ken.Guo 01/04/2008	
	//delete from dba.quest_temp_items where temp_id = il_temp_id;
	ic = tab_1.tabpage_templates.dw_items.rowcount()
	for i = ic to 1 step -1
		tab_1.tabpage_templates.dw_items.deleterow(i)
	next
	tab_1.tabpage_templates.dw_temp_detail.deleterow(1)
	ii_ret = 1
	cb_save.triggerevent(clicked!)
end if
	
	
end event

type cb_tempadd from commandbutton within tabpage_templates
integer x = 1093
integer y = 64
integer width = 357
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Template"
end type

event clicked;dw_temp_detail.insertrow(1)
dw_temp_detail.setfocus()  //Start Code Change ----07.07.2009 #V92 maha
ii_ret = 1

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 05.08.2009
//$<reason> Corrected BugE011904
long ll_Null
SetNull(ll_Null)
dw_temp_select.SetItem(1, "temp_id", ll_Null)
dw_items.Reset()
//------------------- APPEON END ---------------------
end event

type dw_items from datawindow within tabpage_templates
integer y = 224
integer width = 3429
integer height = 1588
integer taborder = 30
string title = "none"
string dataobject = "d_quest_items"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type dw_temp_select from datawindow within tabpage_templates
integer x = 37
integer y = 72
integer width = 1006
integer height = 84
integer taborder = 20
string title = "none"
string dataobject = "d_quest_templates"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_temp_id = long(data)
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 02.07.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
tab_1.tabpage_templates.dw_temp_detail.retrieve(il_temp_id)
tab_1.tabpage_templates.dw_items.retrieve(il_temp_id)
*/
gnv_appeondb.of_startqueue( )

tab_1.tabpage_templates.dw_temp_detail.retrieve(il_temp_id)
tab_1.tabpage_templates.dw_items.retrieve(il_temp_id)

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

//tab_1.tabpage_templates.dw_items.insertrow(1)
end event

event constructor;this.settransobject(sqlca)
//this.retrieve()
end event

type gb_1 from groupbox within tabpage_templates
integer x = 9
integer y = 8
integer width = 1879
integer height = 188
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Template"
end type

type cb_close from commandbutton within w_question_painter
integer x = 3095
integer y = 24
integer width = 347
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(parent)
end event

type cb_save from commandbutton within w_question_painter
integer x = 2007
integer y = 24
integer width = 347
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;long i
long ll_qid
long ll_tid
long ll_iid
datawindowchild dwchild
boolean lb_Changes = false // Add by Evan 05.08.2009

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01/22/2008 By: Ken.Guo
//$<reason> If quest_id is null, Need Return
Long ll_row
tab_1.tabpage_templates.dw_temp_detail.AcceptText() //execute AcceptText before save data.
tab_1.tabpage_templates.dw_items.AcceptText()
tab_1.tabpage_question.dw_quest.AcceptText()
ll_row = tab_1.tabpage_templates.dw_items.Rowcount()
For i = 1 To ll_row
	If Isnull(tab_1.tabpage_templates.dw_items.GetItemNumber(i,'quest_id') ) Then
		Messagebox('IntelliSoftGroup','Required value missing for "Quest Id" on row '+String(i)+'.  Please choose a value.')		
		tab_1.tabpage_templates.dw_items.SetFocus()
		tab_1.tabpage_templates.dw_items.ScrollToRow(i)
		tab_1.tabpage_templates.dw_items.SetRow(i)
		tab_1.tabpage_templates.dw_items.SetColumn('quest_id')
		Return
	End If
Next
//---------------------------- APPEON END ----------------------------


if tab_1.tabpage_templates.dw_temp_detail.rowcount() > 0 then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 05.06.2006 By: Liang QingShi
	//$<reason> Fix a defect.
	string ls_temp_name
	tab_1.tabpage_templates.dw_temp_detail.accepttext()
	ls_temp_name = tab_1.tabpage_templates.dw_temp_detail.getitemstring(tab_1.tabpage_templates.dw_temp_detail.getrow(),'temp_name')
	if isnull(trim(ls_temp_name)) or trim(ls_temp_name) = '' then
		messagebox('IntelliSoftGroup','Required value missing for Template Name.  Please enter a value.') //Start Code Change ----07.07.2009 #V92 maha - corrected message
		tab_1.tabpage_templates.dw_temp_detail.setfocus()
		tab_1.tabpage_templates.dw_temp_detail.setcolumn('temp_name')
		return
	end if
	//---------------------------- APPEON END ----------------------------

	if isnull(tab_1.tabpage_templates.dw_temp_detail.getitemnumber(1,"temp_id")) then
		select max(temp_id)into :ll_tid from quest_temp;
		if isnull(ll_tid) then ll_tid = 0
		ll_tid++
		tab_1.tabpage_templates.dw_temp_detail.setitem(1,"temp_id",ll_tid)
		il_temp_id = ll_tid
	end if
end if 

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 05.08.2009
//$<reason> Corrected BugE011904
if tab_1.tabpage_templates.dw_temp_detail.ModifiedCount() + tab_1.tabpage_templates.dw_temp_detail.DeletedCount() > 0 then
	lb_Changes = true
end if
//------------------- APPEON END ---------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 02.07.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
tab_1.tabpage_templates.dw_temp_detail.update()
select max(quest_id)into :ll_qid from question_lookup;
*/
gnv_appeondb.of_startqueue( )

tab_1.tabpage_templates.dw_temp_detail.update()
select max(quest_id) into :ll_qid from question_lookup;

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

if isnull(ll_qid) then ll_qid = 0

for i = 1 to tab_1.tabpage_question.dw_quest.rowcount()
	if isnull(tab_1.tabpage_question.dw_quest.getitemnumber(i,"quest_id")) then
		ll_qid++
		tab_1.tabpage_question.dw_quest.setitem(i,"quest_id",ll_qid)
	end if
next

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<modify> 02.07.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
/*
tab_1.tabpage_question.dw_quest.update()
select max(qt_id)into :ll_iid from quest_temp_items;
*/
gnv_appeondb.of_startqueue( )

tab_1.tabpage_question.dw_quest.update()
select max(qt_id) into :ll_iid from quest_temp_items;

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

if isnull(ll_iid) then ll_iid = 0
if tab_1.tabpage_templates.dw_items.rowcount() > 0 then
	for i = 1 to tab_1.tabpage_templates.dw_items.rowcount()
		if isnull(tab_1.tabpage_templates.dw_items.getitemnumber(i,"qt_id")) then
			ll_iid++
			tab_1.tabpage_templates.dw_items.setitem(i,"qt_id",ll_iid)
		end if
	next
end if 

tab_1.tabpage_templates.dw_items.update()

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 05.08.2009
//$<reason> Corrected BugE011904	
/*
//if necessary reretrieve the template list
if ii_ret = 1 then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 05.05.2006 By: Liang QingShi
	//$<reason> Fix a defect.
	tab_1.tabpage_templates.dw_temp_select.reset()
	tab_1.tabpage_templates.dw_temp_select.insertrow(0)
	//---------------------------- APPEON END ----------------------------
	tab_1.tabpage_templates.dw_temp_select.GetChild( "temp_id", dwchild )
	dwchild.settransobject(sqlca)
	dwchild.retrieve()
	
	dwchild.insertrow(1)
	ii_ret = 0
end if
*/
long ll_temp_id
if lb_Changes then
	tab_1.tabpage_templates.dw_temp_select.GetChild("temp_id", dwchild)
	dwchild.settransobject(sqlca)
	dwchild.retrieve()
	dwchild.insertrow(1)
	ll_Row = tab_1.tabpage_templates.dw_temp_detail.GetRow()
	if ll_Row > 0 then
		ll_temp_id = tab_1.tabpage_templates.dw_temp_detail.getitemnumber(ll_Row, "temp_id")
		tab_1.tabpage_templates.dw_temp_select.SetItem(1, "temp_id", ll_temp_id)
		tab_1.tabpage_templates.dw_temp_select.SetRedraw(true)
	else
		tab_1.tabpage_templates.dw_temp_select.reset()
		tab_1.tabpage_templates.dw_temp_select.insertrow(0)
	end if
end if
if ii_ret = 1 then ii_ret = 0
//------------------- APPEON END ---------------------
end event

type cb_delete from commandbutton within w_question_painter
integer x = 2734
integer y = 24
integer width = 347
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;if tab_1.selectedtab = 1 then
	parent.tab_1.tabpage_question.dw_quest.deleterow(parent.tab_1.tabpage_question.dw_quest.getrow())
else
	parent.tab_1.tabpage_templates.dw_items.deleterow(parent.tab_1.tabpage_templates.dw_items.getrow())
end if
end event

type cb_add from commandbutton within w_question_painter
integer x = 2373
integer y = 24
integer width = 347
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;integer r
gs_variable_array ls_array
long ll_id[]
long ll_qid
integer i
integer t
integer tc
integer ck = 0
//cb_save.triggerevent(clicked!)  //Commented by Ken.Guo Appeon 01/22/2008


if tab_1.selectedtab = 1 then
	r = tab_1.tabpage_question.dw_quest.insertrow(0)
	tab_1.tabpage_question.dw_quest.scrolltorow(r)
	tab_1.tabpage_question.dw_quest.setrow(r)
elseif tab_1.selectedtab = 2 then
	if il_temp_id < 1 then
		messagebox("No Template selected","Please select or add a template")
		return
	else	
		openwithparm(w_question_select,'Painter')
		ls_array = message.powerobjectparm
		if not isvalid(ls_array) then return -1
		ll_id = ls_array.as_number
		//debugbreak()
		for i = 1 to upperbound(ll_id)
			ll_qid = ll_id[i]
			ck = 0
			for t = 1 to tab_1.tabpage_templates.dw_items.rowcount()
				if ll_qid = tab_1.tabpage_templates.dw_items.getitemnumber(t,"quest_id") then
					ck = 1
					continue
				end if
			next
			if ck = 1 then
				continue
			else
				r = tab_1.tabpage_templates.dw_items.insertrow(0)
				tab_1.tabpage_templates.dw_items.scrolltorow(r)
				tab_1.tabpage_templates.dw_items.setrow(r)
				tab_1.tabpage_templates.dw_items.setitem( r, "temp_id",il_temp_id)
				tab_1.tabpage_templates.dw_items.setitem( r, "sort_order",r)
				tab_1.tabpage_templates.dw_items.setitem( r, "quest_id",ll_qid)
			end if
		next
	end if
	
	
end if
	
	
end event

