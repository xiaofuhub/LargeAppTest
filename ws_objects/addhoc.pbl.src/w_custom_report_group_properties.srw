$PBExportHeader$w_custom_report_group_properties.srw
forward
global type w_custom_report_group_properties from window
end type
type tab_1 from tab within w_custom_report_group_properties
end type
type tabpage_1 from userobject within tab_1
end type
type st_1 from statictext within tabpage_1
end type
type cbx_suppress from checkbox within tabpage_1
end type
type cbx_newpage from checkbox within tabpage_1
end type
type cbx_resetpage from checkbox within tabpage_1
end type
type cbx_autosize from checkbox within tabpage_1
end type
type em_height from editmask within tabpage_1
end type
type tabpage_1 from userobject within tab_1
st_1 st_1
cbx_suppress cbx_suppress
cbx_newpage cbx_newpage
cbx_resetpage cbx_resetpage
cbx_autosize cbx_autosize
em_height em_height
end type
type tab_1 from tab within w_custom_report_group_properties
tabpage_1 tabpage_1
end type
type cb_cancel from commandbutton within w_custom_report_group_properties
end type
type cb_ok from commandbutton within w_custom_report_group_properties
end type
end forward

global type w_custom_report_group_properties from window
integer width = 1125
integer height = 1196
boolean titlebar = true
string title = "Group Properties"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
tab_1 tab_1
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_custom_report_group_properties w_custom_report_group_properties

type variables
integer ii_Group
DataWindow idw_Syntax
string is_Return = "Cancel!"
end variables

forward prototypes
public function string of_groupdescribe (integer ai_group, string as_property)
public function integer of_getproperty (integer ai_group)
public function integer of_setproperty (integer ai_group)
public function integer of_groupmodify (ref string as_groupsyntax, string as_property, string as_value)
end prototypes

public function string of_groupdescribe (integer ai_group, string as_property);//////////////////////////////////////////////////////////////////////
// $<function> of_groupdescribe
// $<arguments>
//		integer	ai_group
//		string	as_property
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.28.2010
//////////////////////////////////////////////////////////////////////

string ls_Char
string ls_Value
string ls_DWSyntax
string ls_GroupSyntax
long i, ll_StartPos, ll_EndPos

// Get specify group syntax
ls_DWSyntax = idw_Syntax.Describe("datawindow.syntax")
choose case ai_Group
	case 1
		ll_StartPos = Pos(ls_DWSyntax, "group(level=1")
	case 2
		ll_StartPos = Pos(ls_DWSyntax, "group(level=2")
	case 3
		ll_StartPos = Pos(ls_DWSyntax, "group(level=3")
	case else
		Return ""
end choose
ll_EndPos = Pos(ls_DWSyntax, "~r~n", ll_StartPos)
ls_GroupSyntax = Mid(ls_DWSyntax, ll_StartPos, ll_EndPos - ll_StartPos)

// Get property's value
ll_StartPos = Pos(ls_GroupSyntax, as_Property)
if ll_StartPos < 1 then Return ""

ll_StartPos += Len(as_Property)
for i = 1 to 100	
	ls_Char = Mid(ls_GroupSyntax, ll_StartPos, 1)
	if ls_Char = ' ' or ls_Char = '~t' then
		exit
	else
		ls_Value += ls_Char
	end if
	ll_StartPos ++
next

Return ls_Value
end function

public function integer of_getproperty (integer ai_group);//////////////////////////////////////////////////////////////////////
// $<function> of_getproperty
// $<arguments>
//		integer	ai_group
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.28.2010
//////////////////////////////////////////////////////////////////////

tab_1.tabpage_1.em_height.Text = of_GroupDescribe(ai_Group, "header.height=")
if tab_1.tabpage_1.em_height.Text = "" then
	tab_1.tabpage_1.em_height.Text = "0"
end if

if of_GroupDescribe(ai_Group, "header.height.autosize=") = "yes" then
	tab_1.tabpage_1.cbx_autosize.Checked = true
end if
if of_GroupDescribe(ai_Group, "resetpagecount=") = "yes" then
	tab_1.tabpage_1.cbx_resetpage.Checked = true
end if
if of_GroupDescribe(ai_Group, "newpage=") = "yes" then
	tab_1.tabpage_1.cbx_newpage.Checked = true
end if
if of_GroupDescribe(ai_Group, "header.suppress=") = "yes" then
	tab_1.tabpage_1.cbx_suppress.Checked = true
end if

Return 1
end function

public function integer of_setproperty (integer ai_group);//////////////////////////////////////////////////////////////////////
// $<function> of_setproperty
// $<arguments>
//		integer	ai_group
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.28.2010
//////////////////////////////////////////////////////////////////////

string ls_Value
string ls_DWSyntax
string ls_GroupSyntax
long ll_StartPos, ll_EndPos
long ll_GroupStartPos, ll_GroupEndPos

/////////////////////////////////////////////////////////////////////////////////////////
// Get specify group syntax
ls_DWSyntax = idw_Syntax.Describe("datawindow.syntax")
choose case ai_Group
	case 1
		ll_GroupStartPos = Pos(ls_DWSyntax, "group(level=1")
	case 2
		ll_GroupStartPos = Pos(ls_DWSyntax, "group(level=2")
	case 3
		ll_GroupStartPos = Pos(ls_DWSyntax, "group(level=3")
	case else
		Return 1
end choose
ll_GroupEndPos = Pos(ls_DWSyntax, "~r~n", ll_GroupStartPos)
ls_GroupSyntax = Mid(ls_DWSyntax, ll_GroupStartPos, ll_GroupEndPos - ll_GroupStartPos)

/////////////////////////////////////////////////////////////////////////////////////////
// Set property's value

//header.height
ll_StartPos = Pos(ls_GroupSyntax, "header.height=")
ll_EndPos = Pos(ls_GroupSyntax, ' ', ll_StartPos)
if tab_1.tabpage_1.em_height.Text = "" then
	ls_Value = "header.height=0"
else
	ls_Value = "header.height=" + tab_1.tabpage_1.em_height.Text
end if
ls_GroupSyntax = Replace(ls_GroupSyntax, ll_StartPos, ll_EndPos - ll_StartPos, ls_Value)

//header.height.autosize
//of_GroupModify(ls_GroupSyntax, "header.height.autosize=", String(tab_1.tabpage_1.cbx_autosize.Checked))

//resetpagecount
//of_GroupModify(ls_GroupSyntax, "resetpagecount=", String(tab_1.tabpage_1.cbx_resetpage.Checked))

//newpage
of_GroupModify(ls_GroupSyntax, "newpage=", String(tab_1.tabpage_1.cbx_newpage.Checked))

//header.suppress
//of_GroupModify(ls_GroupSyntax, "header.suppress=", String(tab_1.tabpage_1.cbx_suppress.Checked))

ls_DWSyntax = Replace(ls_DWSyntax, ll_GroupStartPos, ll_GroupEndPos - ll_GroupStartPos, ls_GroupSyntax)
idw_Syntax.Create(ls_DWSyntax)

Return 1
end function

public function integer of_groupmodify (ref string as_groupsyntax, string as_property, string as_value);//////////////////////////////////////////////////////////////////////
// $<function> of_groupmodify
// $<arguments>
//		ref string	as_groupsyntax
//		string	as_property
//		string	as_value
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.29.2010
//////////////////////////////////////////////////////////////////////

long ll_StartPos, ll_EndPos

ll_StartPos = Pos(as_GroupSyntax, as_Property)
if ll_StartPos < 1 then
	if as_Value = "true" then
		ll_StartPos = Pos(as_GroupSyntax, "header.height=")
		ll_EndPos = Pos(as_GroupSyntax, ' ', ll_StartPos) + 1
		as_Value = as_Property + "yes "
		as_GroupSyntax = Replace(as_GroupSyntax, ll_EndPos, 0, as_Value)
	end if
else
	if as_Value = "false" then
		ll_EndPos = Pos(as_GroupSyntax, ' ', ll_StartPos) + 1
		as_GroupSyntax = Replace(as_GroupSyntax, ll_StartPos, ll_EndPos - ll_StartPos, "")
	end if
end if

Return 1
end function

on w_custom_report_group_properties.create
this.tab_1=create tab_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={this.tab_1,&
this.cb_cancel,&
this.cb_ok}
end on

on w_custom_report_group_properties.destroy
destroy(this.tab_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.28.2010
//////////////////////////////////////////////////////////////////////

idw_Syntax = Message.PowerObjectParm
ii_Group = Integer(idw_Syntax.Tag)
this.Title = "Header Group " + String(ii_Group)+ " Properties"

of_GetProperty(ii_Group)
end event

event close;CloseWithReturn(this, is_Return)
end event

type tab_1 from tab within w_custom_report_group_properties
event create ( )
event destroy ( )
integer x = 18
integer y = 16
integer width = 1079
integer height = 948
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1042
integer height = 832
long backcolor = 33551856
string text = "General"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_1 st_1
cbx_suppress cbx_suppress
cbx_newpage cbx_newpage
cbx_resetpage cbx_resetpage
cbx_autosize cbx_autosize
em_height em_height
end type

on tabpage_1.create
this.st_1=create st_1
this.cbx_suppress=create cbx_suppress
this.cbx_newpage=create cbx_newpage
this.cbx_resetpage=create cbx_resetpage
this.cbx_autosize=create cbx_autosize
this.em_height=create em_height
this.Control[]={this.st_1,&
this.cbx_suppress,&
this.cbx_newpage,&
this.cbx_resetpage,&
this.cbx_autosize,&
this.em_height}
end on

on tabpage_1.destroy
destroy(this.st_1)
destroy(this.cbx_suppress)
destroy(this.cbx_newpage)
destroy(this.cbx_resetpage)
destroy(this.cbx_autosize)
destroy(this.em_height)
end on

type st_1 from statictext within tabpage_1
integer x = 27
integer y = 48
integer width = 233
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Height:"
boolean focusrectangle = false
end type

type cbx_suppress from checkbox within tabpage_1
boolean visible = false
integer x = 23
integer y = 616
integer width = 590
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
string text = "Suppress Group Header"
end type

type cbx_newpage from checkbox within tabpage_1
integer x = 23
integer y = 304
integer width = 654
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
string text = "New Page on Group Break"
end type

type cbx_resetpage from checkbox within tabpage_1
boolean visible = false
integer x = 23
integer y = 368
integer width = 466
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
string text = "Reset Page Count"
end type

type cbx_autosize from checkbox within tabpage_1
boolean visible = false
integer x = 23
integer y = 244
integer width = 407
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
string text = "Autosize Height"
end type

type em_height from editmask within tabpage_1
integer x = 23
integer y = 112
integer width = 1006
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "#####"
boolean autoskip = true
boolean spin = true
string displaydata = "~t/"
string minmax = "~~99999"
end type

type cb_cancel from commandbutton within w_custom_report_group_properties
integer x = 750
integer y = 992
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_custom_report_group_properties
integer x = 393
integer y = 992
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&OK"
boolean default = true
end type

event clicked;is_Return = "OK!"
of_SetProperty(ii_Group)

Close(Parent)
end event

