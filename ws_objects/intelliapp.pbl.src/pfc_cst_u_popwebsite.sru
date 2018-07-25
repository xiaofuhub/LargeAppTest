$PBExportHeader$pfc_cst_u_popwebsite.sru
forward
global type pfc_cst_u_popwebsite from userobject
end type
type cb_extract from commandbutton within pfc_cst_u_popwebsite
end type
type cb_notes from commandbutton within pfc_cst_u_popwebsite
end type
type cb_steps from commandbutton within pfc_cst_u_popwebsite
end type
type sle_screen from singlelineedit within pfc_cst_u_popwebsite
end type
type pb_1 from picturebutton within pfc_cst_u_popwebsite
end type
type pb_2 from picturebutton within pfc_cst_u_popwebsite
end type
type cb_complete from commandbutton within pfc_cst_u_popwebsite
end type
type cb_prior from commandbutton within pfc_cst_u_popwebsite
end type
type cb_next from commandbutton within pfc_cst_u_popwebsite
end type
type cb_populate from commandbutton within pfc_cst_u_popwebsite
end type
type cb_getdata from commandbutton within pfc_cst_u_popwebsite
end type
type ddlb_page from dropdownlistbox within pfc_cst_u_popwebsite
end type
type st_select from statictext within pfc_cst_u_popwebsite
end type
type ole_browser from olecustomcontrol within pfc_cst_u_popwebsite
end type
type dw_data from u_dw within pfc_cst_u_popwebsite
end type
type uo_data_view from pcf_cst_prac_data_view within pfc_cst_u_popwebsite
end type
end forward

global type pfc_cst_u_popwebsite from userobject
integer width = 4462
integer height = 2288
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_init ( )
event ue_appchanged ( )
event ue_resize pbm_size
cb_extract cb_extract
cb_notes cb_notes
cb_steps cb_steps
sle_screen sle_screen
pb_1 pb_1
pb_2 pb_2
cb_complete cb_complete
cb_prior cb_prior
cb_next cb_next
cb_populate cb_populate
cb_getdata cb_getdata
ddlb_page ddlb_page
st_select st_select
ole_browser ole_browser
dw_data dw_data
uo_data_view uo_data_view
end type
global pfc_cst_u_popwebsite pfc_cst_u_popwebsite

type variables
long il_Page
long il_mapPage //maha 02.14.2012
long il_curr_row
long il_curr_app_id
long il_facility_id
long il_prac_id
integer ii_switch  = 0 //maha 03.06.2017
boolean ib_from_mapping = false //maha 02.14.2012
string is_table
datawindow idw_app_list
n_cst_app_population inv_html
end variables

forward prototypes
public function integer of_reset ()
public function integer of_next_prior_page (string as_dir)
public function integer of_fillfield (string as_objecttype, string as_data, string as_yesvalue, string as_command)
public function integer of_setpage (integer ai_page)
public function integer of_seterrorevent (oleobject aole_object)
public function integer of_get_screen_name ()
public function integer of_switch_interface ()
public function integer of_resize (long al_height, long al_width)
end prototypes

event ue_init();//====================================================================
// $<event> ue_init()
// $<arguments>
// $<returns> (None)
// $<description> V12.1 Website Population
// $<add> (Appeon) evan 11.03.2011
//====================================================================

string ls_site_url

// Set current page
dw_data.Retrieve(il_curr_app_id)
ddlb_page.SelectItem(1)
ddlb_page.Event SelectionChanged(1)

// Open website form
ls_site_url = Trim(idw_app_list.GetItemString(idw_app_list.GetRow(), "site_url"))
try
	if Len(ls_site_url) > 0 then
		ole_browser.Object.Navigate(ls_site_url)
	else
		ole_browser.Object.Navigate("http://blank.htm")
	end if
catch (runtimeerror e)
	MessageBox("Error", "Failed to open the url: " + ls_site_url, StopSign!)
end try
end event

event ue_appchanged();//====================================================================
// $<event> ue_appchanged()
// $<arguments>
// $<returns> (None)
// $<description> V12.1 Website Population
// $<add> (Appeon) evan 11.02.2011
//====================================================================

long ll_new_row
long ll_new_app_id

idw_app_list = w_intelliapp_popwebsite.tab_1.tabpage_1.dw_app_list
ll_new_row = idw_app_list.GetRow()
if ll_new_row < 1 then
	of_Reset()
	Return
end if

il_prac_id = idw_app_list.GetItemNumber(ll_new_row, "prac_id")
il_facility_id = idw_app_list.GetItemNumber(ll_new_row, "facility_id")
ll_new_app_id = idw_app_list.GetItemNumber(ll_new_row, "app_id")
if (ll_new_row <> il_curr_row) or (ll_new_app_id <> il_curr_app_id) then
	il_curr_row = ll_new_row
	il_curr_app_id = ll_new_app_id
	this.Event ue_Init()
	//Start Code Change ----02.14.2012 #V12 maha - code from mapping to set the page and retrieve data
	if ib_from_mapping = true then
		ddlb_page.selectitem( il_mappage)
		ddlb_page.Event SelectionChanged(il_mappage)
		cb_getdata.triggerevent(clicked!)
	end if
	//End Code Change ----02.14.2012
end if
end event

event ue_resize;//====================================================================
//$<Event>: ue_resize
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-08-02 (V141 Web Population Part 3)
//--------------------------------------------------------------------
//$<Modify History>: for BugA103002 - commented by alfee 10.30.2013
//====================================================================
//pb_2.x = this.x + newwidth - pb_2.width - 200
//pb_1.x = pb_2.x - pb_1.width - 50


end event

public function integer of_reset ();//====================================================================
// $<function> of_reset()
// $<arguments>
// $<returns> integer
// $<description> V12.1 Website Population
// $<add> (Appeon) evan 11.03.2011
//====================================================================

try
	ole_browser.Object.Navigate("http://blank.htm")
catch (runtimeerror e)
end try

Return 1
end function

public function integer of_next_prior_page (string as_dir);//------------------- APPEON BEGIN -------------------
//$<modify> Evan 01.06.2012
//$<reason> Correct issues

integer li_Index

li_Index = il_page + 1

if as_dir = "U" then
	li_Index += 1
elseif as_dir = "D" then
	li_Index -= 1
end if

ddlb_page.SelectItem(li_Index)
ddlb_page.Event SelectionChanged(li_Index)

if isvalid(w_app_page_steps_child) then //Start Code Change ----10.17.2013 #V14 maha
	w_app_page_steps_child.dw_1.retrieve( il_curr_app_id, il_page)
end if
 
/*
//Start Code Change ----12.09.2011 #V12 maha - added for next/prior buttons
if as_dir = "U"  then
	il_page = il_page + 1
elseif  as_dir = "D"  then
	il_page = il_page - 1
end if
 
 ddlb_page.selectitem(  il_Page)
 
 if il_page < 2 then 
	cb_prior.enabled = false
else
	cb_prior.enabled = true
end if

dw_data.SetFilter("page = " + String(il_Page))
dw_data.Filter()
*/
//------------------- APPEON END ---------------------

return 1
end function

public function integer of_fillfield (string as_objecttype, string as_data, string as_yesvalue, string as_command);//====================================================================
// $<function> of_FillField()
// $<arguments>
//			string	as_ObjectType
//			string	as_Data
//			string	as_YesValue
//			string	as_Command
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 01.13.2012
//====================================================================

string ls_Temp[]
string ls_Boolean
string ls_SetStatement
oleobject lole_window
n_cst_string lnv_string

// Get filled data
as_Data = lnv_string.of_GlobalReplace(as_Data, "'", "\'")
lnv_string.of_ParseToArray(as_Command, '|', ls_Temp)

// Determine value of checkbox and radio-buttons
if (as_YesValue = as_Data) or &
	(Pos(Upper(as_YesValue), "NOT NULL") > 0 and Len(as_Data) > 0) or &
	(Pos(Upper(as_YesValue), "IS NULL") > 0 and (Len(as_Data) = 0 or IsNull(as_Data))) &
then
	ls_Boolean = "true"
else
	ls_Boolean = "false"
end if

// Build scripts of setting value
if ls_Temp[1] = "ID" then
	choose case as_ObjectType
		//---------Begin Added by (Appeon)Stephen 2013-08-02 for V141 Web Population Part 3--------
		case "S", "B" //add "B" - alfee 10.28.2013			
			ls_SetStatement =  "var objElement = " + ls_Temp[2]  + "; " + &
			                            " if(objElement.click){objElement.click();}"
		//---------End Added ------------------------------------------------------
		case "T"
			ls_SetStatement = ls_Temp[2] + ".value = '" + as_Data + "'; "
			
		case "C", "R"
			ls_SetStatement = ls_Temp[2] + ".checked = " + ls_Boolean + "; "
			//------------------- APPEON BEGIN -------------------
			//$<Add> Stephen 11.21.2012
			//$<reason> Problems mapping web form for Women's Care Florida.
			if ls_Boolean = "true" then
				ls_SetStatement =ls_SetStatement + "var objElement = " + ls_Temp[2]  + "; " + &
				 " if(objElement.onclick){objElement.fireEvent('onclick');}"
			end if			
			//------------------- APPEON END -------------------
		case "D"
			//------------------- APPEON BEGIN -------------------
			//$<modify> Stephen 11.21.2012
			//$<reason> Problems mapping web form for Women's Care Florida.
			/*
			ls_SetStatement = &
			"var objElement = " + ls_Temp[2]  + "; " + &
			"var objOptions = objElement.options; " + &
			"for (var j = 0; j < objOptions.length; j++) " + &
			"{ " + &
			"  var strText = objOptions[j].text; " + &
			"  if (strText.toUpperCase() == '" + Upper(as_Data) + "') " + &
			"	{ " + &
				"     objElement.value = objOptions[j].value; " + &
			"	} " + &
			*/
			ls_SetStatement = &
			"var objElement = " + ls_Temp[2]  + "; " + &
			"var objOptions = objElement.options; " + &
			"for (var j = 0; j < objOptions.length; j++) " + &
			"{ " + &
			"  var strText = objOptions[j].text; " + &
			"  if (strText.toUpperCase() == '" + Upper(as_Data) + "') " + &
			"	{ " + &
			"    if(objElement.onfocus){"    +&				
			"     objElement.fireEvent('onfocus');};"    +&	
			"     objElement.value = objOptions[j].value; " + &
			"     if(objElement.onchange){"    +&			
			"     objElement.fireEvent('onchange');};"    +&	
			"	} " + &
			"} "
			//------------------- APPEON BEGIN -------------------
	end choose
else
	choose case as_ObjectType
		//---------Begin Added by (Appeon)Stephen 2013-08-02 for V141 Web Population Part 3--------
		case "S", "B" //add "B" - alfee 10.28.2013				
			ls_SetStatement =  " if(objElements[i].click){objElements[i].click();}"
		//---------End Added ------------------------------------------------------
		case "T"
			ls_SetStatement =	"objElements[i].value = '" + as_Data + "'; "
			
		case "C", "R"
			ls_SetStatement =	"objElements[i].checked = " + ls_Boolean + "; "
			//------------------- APPEON BEGIN -------------------
			//$<Add> Stephen 11.21.2012
			//$<reason> Problems mapping web form for Women's Care Florida.
			if ls_Boolean = "true" then
				ls_SetStatement +=  " if(objElements[i].onclick){objElements[i].fireEvent('onclick');}"
			end if			
			//------------------- APPEON END -------------------
		case "D"
			//------------------- APPEON BEGIN -------------------
			//$<modify> Stephen 11.21.2012
			//$<reason> Problems mapping web form for Women's Care Florida.
			/*
						ls_SetStatement = &
			"var objOptions = objElements[i].options; " + &
			"for (var j = 0; j < objOptions.length; j++) " + &
			"{ " + &
			"  var strText = objOptions[j].text; " + &
			"  if (strText.toUpperCase() == '" + Upper(as_Data) + "') " + &
			"	{ " + &			
			"     objElements[i].value = objOptions[j].value; " + &
			"	} " + &

			*/
			ls_SetStatement = &
			"var objOptions = objElements[i].options; " + &
			"for (var j = 0; j < objOptions.length; j++) " + &
			"{ " + &
			"  var strText = objOptions[j].text; " + &
			"  if (strText.toUpperCase() == '" + Upper(as_Data) + "') " + &
			"	{ " + &			
			"    if(objElements[i].onfocus){"    +&				
			"     objElements[i].fireEvent('onfocus');};"    +&	
			"     objElements[i].value = objOptions[j].value; " + &
			"     if(objElements[i].onchange){"    +&			
			"     objElements[i].fireEvent('onchange');};"    +&	
			"	} " + &
			"} "
			//------------------- APPEON END -------------------
	end choose
	
	ls_SetStatement = &
	"var objElements = " + ls_Temp[2] + "; " + &
	"for (var i = 0; i < objElements.length; i++) " + &
	"{ " + &
	"  if (i == " + ls_Temp[3] + ") " + &
	"  { " + &
			ls_SetStatement + &
	"  } " + &
	"} "
end if

as_Command = &
'try ' + &
'{ ' + &
	ls_SetStatement + &
'} ' + &
'catch (e) ' + &
'{ ' + &
'	alert(e + "\r\n Error Script: " + "' + ls_SetStatement + '"); ' + &
'}'

ole_browser.setfocus() //(Appeon)Stephen 2013-08-27 -  V141 Web Population Part 3
// Execute scripts
lole_window = ole_browser.Object.document.parentWindow
//---------Begin Modified by (Appeon)Stephen 11.10.2015 for Bug id 4838 - Cannot populate Web Pop Site--------
//lole_window.execScript(as_Command, "JScript")
lole_window.eval(as_Command, "JScript")
//---------End Modfiied ------------------------------------------------------

Return 1
end function

public function integer of_setpage (integer ai_page);//Start Code Change ----02.14.2012 #V12 maha
il_mappage = ai_page + 1
ib_from_mapping = true


return 1
end function

public function integer of_seterrorevent (oleobject aole_object);//////////////////////////////////////////////////////////////////////
// $<function> of_seterrorevent
// $<arguments>
//		oleobject	aole_object
// $<returns> integer
// $<description> Set window's error event
//////////////////////////////////////////////////////////////////////
// $<add> 06.21.2012 by Evan
//////////////////////////////////////////////////////////////////////

long i, ll_Len
string ls_Script
oleobject lole_frame

ls_Script = &
"function window_onerror() {return true;} " + &
"var bErrorEvent = false; " + &
"try " + &
"{ " + &
"  var nLen = window.onerror.toString().length; " + &
"  if (nLen> 0) bErrorEvent = true; " + &
"} " + &
"catch (e) " + &
"{ " + &
"} " + &
"if (bErrorEvent == false) window.onerror = window_onerror; "

try
	//---------Begin Modified by (Appeon)Stephen 11.10.2015 for Bug id 4838 - Cannot populate Web Pop Site--------
	aole_object.document.parentWindow.execScript(ls_Script, "JScript")
	//aole_object.document.parentWindow.eval(ls_Script, "JScript")
	//---------End Modfiied ------------------------------------------------------
	ll_Len = aole_object.document.frames.length
	if ll_Len > 0 then
		for i = 0 to ll_Len - 1
			lole_frame = aole_object.document.frames[i]
			of_SetErrorEvent(lole_frame)
		next
	end if
catch (RuntimeError e)
end try

Return 1
end function

public function integer of_get_screen_name ();//====================================================================
//$<Function>: of_get_screen_name
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-08-07 (V141 Web Population Part 3)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_screen_name

select Data_screen into :ls_screen_name
from app_page_data where app_id = :il_curr_app_id and page = :il_Page;

if not isnull(ls_screen_name) then
	sle_screen.text = ls_screen_name
else
	sle_screen.text = ''
end if
return 1

end function

public function integer of_switch_interface (); //Start Code Change ----03.06.2017 #V153 maha
boolean lb_set
uo_data_view.y = dw_data.y
uo_data_view.x = dw_data.x
uo_data_view.width = dw_data.width
uo_data_view.height = dw_data.height
 debugbreak()
choose case ii_switch
	case 0  //ipop
		lb_set = true
		uo_data_view.visible = false
		if len(is_table) > 0 then sle_screen.text =  is_table
	case 1 //data view
		lb_set = false
		uo_data_view.visible = true
		if len(sle_screen.text) > 0 then  is_table = sle_screen.text
		sle_screen.text = "Double-click to copy value"
end choose

//uo_data_view.visible = lb_set
cb_getdata.visible = lb_set
cb_next.visible = lb_set
cb_prior.visible = lb_set
cb_populate.visible = lb_set
ddlb_page.visible = lb_set
cb_steps.visible = lb_set
cb_notes.visible = lb_set
st_select.visible = lb_set

if uo_data_view.visible = true then
	uo_data_view.of_resize(uo_data_view.ib_link)
end if

return 1
end function

public function integer of_resize (long al_height, long al_width); //Start Code Change ----03.06.2017 #V153 maha - moved from window resize
ole_browser.height = al_height - 156
//---------Begin Modified by (Appeon)Stephen 04.26.2017 for Bug id 5619 - iPop Application doesn't display properly in Web Pop SaaS 15.3 04202017--------
//ole_browser.width =  al_width - 50
//ole_browser.height = al_height - 156
ole_browser.height = al_height - 180
ole_browser.width =  al_width - dw_data.width - 20
//---------End Modfiied ------------------------------------------------------
dw_data.height = ole_browser.height - 100

of_switch_interface( )

return 1
end function

on pfc_cst_u_popwebsite.create
this.cb_extract=create cb_extract
this.cb_notes=create cb_notes
this.cb_steps=create cb_steps
this.sle_screen=create sle_screen
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_complete=create cb_complete
this.cb_prior=create cb_prior
this.cb_next=create cb_next
this.cb_populate=create cb_populate
this.cb_getdata=create cb_getdata
this.ddlb_page=create ddlb_page
this.st_select=create st_select
this.ole_browser=create ole_browser
this.dw_data=create dw_data
this.uo_data_view=create uo_data_view
this.Control[]={this.cb_extract,&
this.cb_notes,&
this.cb_steps,&
this.sle_screen,&
this.pb_1,&
this.pb_2,&
this.cb_complete,&
this.cb_prior,&
this.cb_next,&
this.cb_populate,&
this.cb_getdata,&
this.ddlb_page,&
this.st_select,&
this.ole_browser,&
this.dw_data,&
this.uo_data_view}
end on

on pfc_cst_u_popwebsite.destroy
destroy(this.cb_extract)
destroy(this.cb_notes)
destroy(this.cb_steps)
destroy(this.sle_screen)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_complete)
destroy(this.cb_prior)
destroy(this.cb_next)
destroy(this.cb_populate)
destroy(this.cb_getdata)
destroy(this.ddlb_page)
destroy(this.st_select)
destroy(this.ole_browser)
destroy(this.dw_data)
destroy(this.uo_data_view)
end on

type cb_extract from commandbutton within pfc_cst_u_popwebsite
integer x = 3904
integer y = 24
integer width = 402
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Extract Docs"
end type

event clicked; //Start Code Change ----03.07.2017 #V153 maha - added
openwithparm(w_extract_prac_documents, il_prac_id )
end event

type cb_notes from commandbutton within pfc_cst_u_popwebsite
integer x = 2075
integer y = 24
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Page Notes"
end type

event clicked;//====================================================================
//$<Event>: clicked()
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 10.30.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>: Copied from dw_1.buttonclicked ()
//====================================================================
string ls_notes, ls_screen

select Notes into :ls_notes from app_page_data 
where app_id = :il_curr_app_id and page = :il_Page;

if isnull(ls_notes) then ls_notes = ""  //(Appeon)Harry 07.16.2014 - for the Bug 4115

OpenWithParm( w_ai_notes_new, "R#" +  ls_notes)






	
end event

type cb_steps from commandbutton within pfc_cst_u_popwebsite
integer x = 1737
integer y = 24
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Page Steps"
end type

event clicked;//Start Code Change ----10.17.2013 #V14 maha - open step window

gs_pass_ids lst_ids


lst_ids.l_app_id = il_curr_app_id
lst_ids.committee_id = il_page

openwithparm(w_app_page_steps_child, lst_ids )







	
end event

type sle_screen from singlelineedit within pfc_cst_u_popwebsite
integer x = 18
integer y = 136
integer width = 1202
integer height = 92
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

event modified;//====================================================================
//$<Event>: modified
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-08-07 (V141 Web Population Part 3)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//integer li_cnt
//string   ls_screen
//
//select count(1) into :li_cnt from app_page_data 
//where app_id = :il_curr_app_id and page = :il_Page;
//ls_screen = sle_screen.text
//
//if li_cnt < 1 then
//	insert into app_page_data(App_id, page, Data_screen, Notes) values(:il_curr_app_id, :il_Page, :ls_screen, '');
//else
//	update app_page_data set Data_screen = :ls_screen
//	where app_id = :il_curr_app_id and page = :il_Page;
//end if
//commit using sqlca;
end event

type pb_1 from picturebutton within pfc_cst_u_popwebsite
integer x = 3579
integer y = 24
integer width = 123
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "Undo!"
alignment htextalign = left!
string powertiptext = "Back"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-08-02 (V141 Web Population Part 3)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_back

try
ls_back = "history.go(-1);"
ole_browser.Object.document.parentWindow.execscript(ls_back,"JScript")
catch(runtimeerror e)
end try
end event

type pb_2 from picturebutton within pfc_cst_u_popwebsite
integer x = 3698
integer y = 24
integer width = 123
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "Redo!"
alignment htextalign = left!
string powertiptext = "Forward"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-08-02 (V141 Web Population Part 3)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_forward

try
ls_forward = "history.go(1);"
ole_browser.Object.document.parentWindow.execscript(ls_forward,"JScript")
catch(runtimeerror e)
end try
end event

type cb_complete from commandbutton within pfc_cst_u_popwebsite
boolean visible = false
integer x = 3131
integer y = 24
integer width = 411
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Completed"
end type

event clicked;//Start Code Change ----02.29.2012 #V12 maha - set action to be completed

if isvalid(w_intelliapp_popwebsite) then
	w_intelliapp_popwebsite.of_complete_action()
end if
end event

type cb_prior from commandbutton within pfc_cst_u_popwebsite
integer x = 1248
integer y = 24
integer width = 215
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "< Prior"
end type

event clicked;of_next_prior_page("D")
end event

type cb_next from commandbutton within pfc_cst_u_popwebsite
integer x = 1458
integer y = 24
integer width = 215
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Next >"
end type

event clicked;of_next_prior_page("U")
end event

type cb_populate from commandbutton within pfc_cst_u_popwebsite
integer x = 2560
integer y = 24
integer width = 411
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Populate Site"
end type

event clicked;//====================================================================
// $<evant> clicked()
// $<arguments>
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 11.03.2011
//====================================================================

long ll_Row
long ll_RowCount
string ls_Data
string ls_Command
string ls_object_type
string ls_box_yes_value

try
	dw_data.AcceptText()
	ll_RowCount = dw_data.RowCount()
	for ll_Row = 1 to ll_RowCount
		ls_object_type = dw_data.GetItemString(ll_Row, "object_type")
		ls_box_yes_value = dw_data.GetItemString(ll_Row, "box_yes_value")
		ls_Command = dw_data.GetItemString(ll_Row, "site_field_setcommand")
		ls_Data = dw_data.GetItemString(ll_Row, "site_field_value")
		if IsNull(ls_Data) then ls_Data = ""
		if Len(ls_Command) > 0 then
			of_FillField(ls_object_type, ls_Data, ls_box_yes_value, ls_Command)
		end if
	next
catch (RuntimeError e)
end try
end event

type cb_getdata from commandbutton within pfc_cst_u_popwebsite
integer x = 14
integer y = 24
integer width = 411
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Get Data"
end type

event clicked;//====================================================================
// $<evant> clicked()
// $<arguments>
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 11.14.2011
//====================================================================

long ll_max_page
n_cst_app_population lnv_app

select max(page) into :ll_max_page from app_field_prop where app_id = :il_curr_app_id;
lnv_app.of_Setup(Parent, il_curr_app_id, 1, ll_max_page, il_facility_id)
end event

type ddlb_page from dropdownlistbox within pfc_cst_u_popwebsite
integer x = 795
integer y = 28
integer width = 443
integer height = 828
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;//====================================================================
// $<event> constructor()
// $<arguments>
// $<returns> long
// $<description> V12.1 Website Population
// $<add> (Appeon) evan 10.20.2011
//====================================================================

int i

this.AddItem("Page of Login")

for i = 1 to 100
	this.AddItem("Page " + String(i))
next
end event

event selectionchanged;//====================================================================
// $<event> selectionchanged()
// $<arguments>
//			integer index
// $<returns> long
// $<description> V12.1 Website Population
// $<add> (Appeon) evan 11.03.2011
//====================================================================

il_Page = Index - 1

dw_data.SetFilter("page = " + String(il_Page))
dw_data.Filter()

if Index = 1 then
	cb_prior.enabled = false
else
	cb_prior.enabled = true
end if

of_get_screen_name() //(Appeon)Stephen 2013-08-07 - V141 Web Population Part 3

end event

type st_select from statictext within pfc_cst_u_popwebsite
integer x = 448
integer y = 44
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Page :"
alignment alignment = right!
boolean focusrectangle = false
end type

type ole_browser from olecustomcontrol within pfc_cst_u_popwebsite
event statustextchange ( string text )
event progresschange ( long progress,  long progressmax )
event commandstatechange ( long command,  boolean enable )
event downloadbegin ( )
event downloadcomplete ( )
event titlechange ( string text )
event propertychange ( string szproperty )
event beforenavigate2 ( oleobject pdisp,  any url,  any flags,  any targetframename,  any postdata,  any headers,  ref boolean cancel )
event newwindow2 ( ref oleobject ppdisp,  ref boolean cancel )
event navigatecomplete2 ( oleobject pdisp,  any url )
event documentcomplete ( oleobject pdisp,  any url )
event onquit ( )
event onvisible ( boolean ocx_visible )
event ontoolbar ( boolean toolbar )
event onmenubar ( boolean menubar )
event onstatusbar ( boolean statusbar )
event onfullscreen ( boolean fullscreen )
event ontheatermode ( boolean theatermode )
event windowsetresizable ( boolean resizable )
event windowsetleft ( long left )
event windowsettop ( long top )
event windowsetwidth ( long ocx_width )
event windowsetheight ( long ocx_height )
event windowclosing ( boolean ischildwindow,  ref boolean cancel )
event clienttohostwindow ( ref long cx,  ref long cy )
event setsecurelockicon ( long securelockicon )
event filedownload ( boolean activedocument,  ref boolean cancel )
event navigateerror ( oleobject pdisp,  any url,  any frame,  any statuscode,  ref boolean cancel )
event printtemplateinstantiation ( oleobject pdisp )
event printtemplateteardown ( oleobject pdisp )
event updatepagestatus ( oleobject pdisp,  any npage,  any fdone )
event privacyimpactedstatechange ( boolean bimpacted )
event setphishingfilterstatus ( long phishingfilterstatus )
event newprocess ( long lcauseflag,  oleobject pwb2,  ref boolean cancel )
event redirectxdomainblocked ( oleobject pdisp,  any starturl,  any redirecturl,  any frame,  any statuscode )
integer x = 1234
integer y = 136
integer width = 3223
integer height = 2152
integer taborder = 30
boolean border = false
boolean focusrectangle = false
string binarykey = "pfc_cst_u_popwebsite.udo"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event navigatecomplete2(oleobject pdisp, any url);of_SetErrorEvent(this.object) //Added by Evan 06.21.2012
end event

type dw_data from u_dw within pfc_cst_u_popwebsite
integer x = 18
integer y = 236
integer width = 1202
integer height = 2044
integer taborder = 10
string dataobject = "d_app_mapping_data"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.SetTransObject(SQLCA)
this.of_SetUpdateAble(false)
end event

event buttonclicked;call super::buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-08-08 (V141 Web Population Part 3)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_notes, ls_screen

select Notes into :ls_notes from app_page_data 
where app_id = :il_curr_app_id and page = :il_Page;

if isnull(ls_notes) then ls_notes = ""  //(Appeon)Harry 07.16.2014 - for the Bug 4115

OpenWithParm( w_ai_notes_new, "R#" +  ls_notes)
end event

type uo_data_view from pcf_cst_prac_data_view within pfc_cst_u_popwebsite
integer x = 59
integer y = 124
integer height = 2264
integer taborder = 20
boolean bringtotop = true
end type

on uo_data_view.destroy
call pcf_cst_prac_data_view::destroy
end on


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Epfc_cst_u_popwebsite.bin 
2100000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000004d3bcda001d3545300000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f000000004d3bcda001d354534d3bcda001d35453000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
28ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c000048dd0000379b0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c000048dd0000379b0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Epfc_cst_u_popwebsite.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
