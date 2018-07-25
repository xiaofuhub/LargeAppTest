$PBExportHeader$w_mod_prf_scr_dw.srw
forward
global type w_mod_prf_scr_dw from window
end type
type dw_properties from datawindow within w_mod_prf_scr_dw
end type
type st_1 from statictext within w_mod_prf_scr_dw
end type
type cb_2 from commandbutton within w_mod_prf_scr_dw
end type
type sle_1 from singlelineedit within w_mod_prf_scr_dw
end type
type dw_browse from datawindow within w_mod_prf_scr_dw
end type
type cb_1 from commandbutton within w_mod_prf_scr_dw
end type
type dw_detail from datawindow within w_mod_prf_scr_dw
end type
end forward

global type w_mod_prf_scr_dw from window
integer width = 3570
integer height = 1508
boolean titlebar = true
string title = "Modify Screens in Profile Report"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_properties dw_properties
st_1 st_1
cb_2 cb_2
sle_1 sle_1
dw_browse dw_browse
cb_1 cb_1
dw_detail dw_detail
end type
global w_mod_prf_scr_dw w_mod_prf_scr_dw

forward prototypes
public function string of_mod_dw_for_profile (integer ai_scr_id, string as_scr_allias)
end prototypes

public function string of_mod_dw_for_profile (integer ai_scr_id, string as_scr_allias);//Start Code Change ---- 10.22.2007 #V7 maha
// function created to modify screen in preparation to export syntax to profile view
//called from of_update_profile_views
string ls_syntax
//string ls_screen
string s
string ls_field
integer i
integer ic
long ll_max_height
long ll_height
string ls_height
string ls_y
string ls_islookup
string ls_lookup_code
string ls_lookup_type
string ls_lookup_field


//debugbreak()
s = dw_detail.modify('datawindow.header.height = "90"')
s = dw_detail.modify('datawindow.Text.Background.Color=16777215')
s = dw_detail.modify('datawindow.color=16777215' )
//s = dw_detail.modify('datawindow.Detail.Height.AutoSize')
s = dw_detail.modify('datawindow.Detail.width = "3300"') //Start Code Change ----03.28.2008 #V8 maha
s = dw_detail.modify('datawindow.header.width = "3300"')

//ls_screen = dw_select_section.getitemstring(dw_select_section.getrow(),"screen_alias")
//ai_scr_id = dw_select_section.getitemnumber(dw_select_section.getrow(),"screen_id")
s = dw_detail.modify('create text(band=header alignment="2" text="' + as_scr_allias  + '" border="0" color="0" x="9" y="0" height="80" width="3282" html.valueishtml="0"  name=t_1 visible="1"  font.face="Times New Roman" font.height="-12" font.weight="700"  font.family="1" font.pitch="2" font.charset="0" background.mode="2" background.color="12632256" )')

//ic = integer(dw_detail.Object.DataWindow.Column.Count)    //Commented By Ken.Guo 06.13.2008
ic = Integer(dw_detail.Describe("DataWindow.Column.Count")) //Added By Ken.Guo 06.13.2008

for i = 1 to ic
	//debugbreak()
	ls_field = dw_detail.describe("#" + string(i) + ".Name")
	if integer(dw_detail.describe("#" + string(i) + ".visible")) > 0 then
		ls_height = dw_detail.describe("#" + string(i) + ".height")
		ls_y = dw_detail.describe("#" + string(i) + ".y")
		ll_height = long(ls_height) + long(ls_y)
		if ll_max_height < ll_height then ll_max_height = ll_height//dw_detail.Modify(ls_field + ".border = '0'")
		dw_detail.Modify( ls_field + "_t.font.weight = '700'") //Start Code Change ----01.08.2008 #V8 maha - make labels bold
	else
		dw_detail.Modify("#" + string(i) + ".visible = '0'")
	end if
	
	dw_detail.Modify("#" + string(i) + ".border = '0'") //removes indented border
	dw_detail.Modify("#" + string(i) + ".DDLB.UseAsBorder = 'No'") //removes arrow
	//dw_detail.Modify( ls_field + "_t.font.underline = '1'")
next
//messagebox("ll_max_height",ll_max_height)
s = dw_detail.modify("datawindow.Detail.Height = '" + string(ll_max_height) + "'")

dw_properties.SetFilter("data_view_fields_screen_id = " + String(ai_scr_id))
dw_properties.Filter()

//remove underlines
FOR i = 1 TO dw_properties.rowcount()
	ls_field = dw_properties.GetItemString( i, "sys_fields_field_name" )
	dw_detail.Modify( ls_field + "_t.font.underline = '0'")
	if dw_properties.GetItemString( i, "data_view_fields_visible" ) = "N" THEN
		dw_detail.Modify( ls_field + "_t.font.visible = '0'") //make label invisible
	end if
	
	
	//@@@@@@@@@@@@@@@@@@@@@@@@@
	if dw_properties.GetItemString( i, "data_view_fields_visible" ) = "Y" THEN
		ls_islookup = dw_properties.GetItemString( i, "sys_fields_lookup_field")
		
		IF ls_field = "active_status" THEN
			//dw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
			dw_detail.Modify( ls_field + ".dddw.useasborder = NO")			
			//dw_detail.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
			//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
			//adw_detail.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
			//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
			dw_detail.Modify( ls_field + ".dddw.name = 'd_code_lookup_active_inactive'")
			dw_detail.Modify( ls_field + ".dddw.datacolumn = 'lookup_code'")			
			dw_detail.Modify( ls_field + ".dddw.displaycolumn = 'description'")						
		END IF
	
		IF ls_islookup = "Y" THEN
			ls_lookup_code = dw_properties.GetItemString( i, "sys_fields_lookup_code" )
			ls_lookup_field = dw_properties.GetItemString( i, "sys_fields_lookup_field_name" )
			ls_lookup_type = dw_properties.GetItemString( i, "sys_fields_lookup_type" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")
			//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AutoHScroll = Yes")
			dw_detail.Modify( ls_field + ".dddw.useasborder = No")	
			dw_detail.Modify( ls_field + ".dddw.Autoretrieve = Yes")
			//detail.Modify(ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
			//adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Lines= 15")
	
			IF ls_lookup_type = "C" THEN
				dw_detail.Modify( ls_field + ".dddw.name = 'd_dddw_code_lookup_all'")
				dw_detail.Modify( ls_field + ".dddw.datacolumn = 'lookup_code'")
				IF Upper( ls_lookup_field ) = "CODE" THEN
					dw_detail.Modify( ls_field + ".dddw.displaycolumn = 'code'")
				ELSE
					dw_detail.Modify( ls_field + ".dddw.displaycolumn = '"+ls_lookup_field+"'")
				END IF
			ELSEIF ls_lookup_type = "A" THEN
				//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HscrollBar = Yes")			
				dw_detail.Modify( ls_field + ".dddw.name = 'd_dddw_address_lookup_all'")
				dw_detail.Modify( ls_field + ".dddw.datacolumn = 'lookup_code'")		
		
				IF Upper( ls_lookup_field ) = "CODE" THEN
					dw_detail.Modify( ls_field + ".dddw.displaycolumn = 'code'")
				ELSE
					dw_detail.Modify( ls_field + ".dddw.displaycolumn = 'entity_name'")			
				END IF
			ELSEIF ls_lookup_type = "Q" THEN
				dw_detail.Modify( ls_field + ".dddw.name = 'd_dddw_quest_lookup'")
				dw_detail.Modify( ls_field + ".dddw.datacolumn = 'quest_id'")	
				dw_detail.Modify( ls_field + ".dddw.displaycolumn = 'short_quest'")
				//adw_detail.Modify( ls_field + ".dddw.useasborder = No")
				//adw_detail.Modify( ls_field + ".dddw.vscrollbar = Yes")		END IF
			END IF
		END IF
	end if
	
	
	//?????@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
next

//hide buttons
if ai_scr_id = 2 then //address
	dw_detail.Modify("findbutton.visible = '0'")
elseif ai_scr_id = 13 then //references
	dw_detail.Modify("peerbutton.visible = '0'")
end if

ls_syntax = dw_detail.Describe("DataWindow.Syntax")

return ls_syntax
end function

on w_mod_prf_scr_dw.create
this.dw_properties=create dw_properties
this.st_1=create st_1
this.cb_2=create cb_2
this.sle_1=create sle_1
this.dw_browse=create dw_browse
this.cb_1=create cb_1
this.dw_detail=create dw_detail
this.Control[]={this.dw_properties,&
this.st_1,&
this.cb_2,&
this.sle_1,&
this.dw_browse,&
this.cb_1,&
this.dw_detail}
end on

on w_mod_prf_scr_dw.destroy
destroy(this.dw_properties)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.sle_1)
destroy(this.dw_browse)
destroy(this.cb_1)
destroy(this.dw_detail)
end on

type dw_properties from datawindow within w_mod_prf_scr_dw
boolean visible = false
integer x = 745
integer y = 1308
integer width = 686
integer height = 400
integer taborder = 30
string dataobject = "d_sys_field_properties_4prf"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
this.retrieve(1) //default view
end event

type st_1 from statictext within w_mod_prf_scr_dw
integer x = 18
integer y = 1108
integer width = 608
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "PBL/PPD to LibraryImport:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_mod_prf_scr_dw
integer x = 2615
integer y = 1092
integer width = 96
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "..."
end type

event clicked;string filename
string path

GetFileOpenName ( "Select File", path, filename, "PBL/PBD", "PBL/PBD Files (*.pbl;*.pbd),*.pbl;*.pbd" , gs_current_path)
ChangeDirectory(gs_current_path) 
sle_1.text = filename
end event

type sle_1 from singlelineedit within w_mod_prf_scr_dw
integer x = 626
integer y = 1096
integer width = 1966
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_browse from datawindow within w_mod_prf_scr_dw
integer x = 9
integer y = 36
integer width = 1134
integer height = 980
integer taborder = 20
string title = "none"
string dataobject = "d_prf_scr_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.setTransobject(sQLCA)
this.retrieve( )
end event

type cb_1 from commandbutton within w_mod_prf_scr_dw
integer x = 18
integer y = 1260
integer width = 457
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Modify Properties"
end type

event clicked;Integer li_rtn
Long i, ll_scr_id
String ls_path, ls_scr_dw, ls_syntax, ls_error, ls_scr_allias

IF MessageBox("Modify Properties","Modify properties for all Screen DataWinddows?", Question!,YesNo!) = 2 THEN
	RETURN
END IF

ls_path = Trim(sle_1.text)
IF NOT FileExists(ls_path) THEN 
	MessageBox("Modify Properties","The pbl/pbd file is not existing!")
	RETURN
END IF

FOR i = 1 TO dw_browse.RowCount()
	ls_scr_dw = dw_browse.GetItemString(i,"scr_dw")
	ll_scr_id = dw_browse.GetItemNumber(i,"scr_id")
	ls_scr_allias = dw_browse.GetItemString(i,"screen_alias")
	
	IF LenA(Trim(ls_scr_dw)) < 1 THEN CONTINUE
	
	dw_detail.DataObject = ls_scr_dw
	dw_detail.SetTransObject(SQLCA)

	ls_syntax = of_mod_dw_for_profile(ll_scr_id, ls_scr_allias)
	IF LenA(Trim(ls_syntax)) < 1 THEN CONTINUE
	
	li_rtn = LibraryImport(ls_path, ls_scr_dw, ImportDataWindow!, ls_syntax, ls_error)
	IF li_rtn <> 1 THEN
		MessageBox("Library Import","Library Import Failed for '" + ls_scr_dw + "' due to: " + ls_error)
		CONTINUE		
	END IF		
NEXT




end event

type dw_detail from datawindow within w_mod_prf_scr_dw
integer x = 1198
integer y = 36
integer width = 2267
integer height = 980
integer taborder = 10
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

