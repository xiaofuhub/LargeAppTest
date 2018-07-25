$PBExportHeader$w_appl_website_fill.srw
forward
global type w_appl_website_fill from w_main
end type
type cb_1 from commandbutton within w_appl_website_fill
end type
type ole_browser from olecustomcontrol within w_appl_website_fill
end type
type cb_back from commandbutton within w_appl_website_fill
end type
type cb_forward from commandbutton within w_appl_website_fill
end type
type cb_close from commandbutton within w_appl_website_fill
end type
type uo_de from pfc_cst_u_de_display within w_appl_website_fill
end type
end forward

global type w_appl_website_fill from w_main
integer width = 4430
integer height = 2940
cb_1 cb_1
ole_browser ole_browser
cb_back cb_back
cb_forward cb_forward
cb_close cb_close
uo_de uo_de
end type
global w_appl_website_fill w_appl_website_fill

type variables
long il_batch
long il_pracid
long il_screen
long il_dvid = 1
long il_rec_id
long il_wc_id
long il_facility
long il_entity
string is_save_type = 'N'
string is_prac_names[]
string is_url
string is_type
string is_lookup_search_column_field = "None" 
string is_lookup_search_column_table = "None"
string is_sql_syntax
string is_first_column_detail_1
pfc_cst_nv_data_entry_functions inv_data_fun
pfc_n_cst_ai_action_items  inv_action_items
end variables

on w_appl_website_fill.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.ole_browser=create ole_browser
this.cb_back=create cb_back
this.cb_forward=create cb_forward
this.cb_close=create cb_close
this.uo_de=create uo_de
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.ole_browser
this.Control[iCurrent+3]=this.cb_back
this.Control[iCurrent+4]=this.cb_forward
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.uo_de
end on

on w_appl_website_fill.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.ole_browser)
destroy(this.cb_back)
destroy(this.cb_forward)
destroy(this.cb_close)
destroy(this.uo_de)
end on

event close;call super::close;destroy inv_data_fun
end event

event open;call super::open; //Start Code Change ----02.28.2017 #V153 maha
 string ls_site
 inv_data_fun = create pfc_cst_nv_data_entry_functions
 inv_data_fun.of_setup_cache()
inv_data_fun.of_refresh_cache()



il_pracid = 1
il_dvid = 1
il_screen = 1

ls_site = "http://commerce.alaska.gov/cbp/Main/CBPLSearch.aspx?mode=Prof"
ole_browser.visible = true
try
	ole_browser.object.navigate(ls_site)
	catch (RuntimeError e)
end try

//dw_detail.of_settransobject( sqlca)


end event

type cb_1 from commandbutton within w_appl_website_fill
integer x = 69
integer y = 16
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked;

//retrieve data entry
//tab_1.tabpage_detail.uo_data_entry.of_set_verification_info( tab_1.tabpage_verif.uo_verif_summary )
uo_de.of_set_data_view_id( il_dvid )
uo_de.of_set_prac_id( il_pracid )
uo_de.of_set_parent_facility_id( il_facility )
uo_de.of_set_affil_recid(1111)   //Start Code Change ----07.15.2015 #V15 maha - for attest quest


//IF il_prac_id = -9 THEN
//	ib_new_prac = True
//	il_prac_id = gnv_app.of_Get_Id("PRAC_ID")
//		gl_prac_id = il_prac_id
//	tab_1.tabpage_detail.uo_data_entry.of_set_prac_id( il_prac_id )	
//	il_rec_id = gnv_app.of_Get_Id("RECORD_ID")
//	This.Title = "New"
//	uo_app_stat.of_Reset( )	
//ELSE

//	of_setup_title()
//END IF

window lw
lw = parent
// tab_1.tabpage_detail.uo_data_entry.of_set_parent_window( This )
//uo_de.of_set_parent_window( lw )
// mskinner 30 March 2005 -- end
uo_de.of_setup( false )
//uo_de.of_set_verifying_facility( ii_verifying_facility_id )

Return 0
end event

type ole_browser from olecustomcontrol within w_appl_website_fill
event statustextchange ( string text )
event progresschange ( long progress,  long progressmax )
event commandstatechange ( long command,  boolean enable )
event downloadbegin ( )
event downloadcomplete ( )
event titlechange ( string text )
event propertychange ( string szproperty )
event beforenavigate2 ( oleobject pdisp,  any url,  any flags,  any targetframename,  any postdata,  any headers,  ref boolean ab_cancel )
event newwindow2 ( ref oleobject ppdisp,  ref boolean ab_cancel )
event navigatecomplete2 ( oleobject pdisp,  any url )
event documentcomplete ( oleobject pdisp,  any url )
event onquit ( )
event onvisible ( boolean ocx_visible )
event ontoolbar ( boolean toolbar )
event onmenubar ( boolean menubar )
event onstatusbar ( boolean statusbar )
event onfullscreen ( boolean fullscreen )
event ontheatermode ( boolean theatermode )
event windowsetresizable ( boolean ab_resizable )
event windowsetleft ( long left )
event windowsettop ( long top )
event windowsetwidth ( long ocx_width )
event windowsetheight ( long ocx_height )
event windowclosing ( boolean ischildwindow,  ref boolean ab_cancel )
event clienttohostwindow ( ref long cx,  ref long cy )
event setsecurelockicon ( long securelockicon )
event filedownload ( ref boolean ab_cancel )
event navigateerror ( oleobject pdisp,  any url,  any frame,  any statuscode,  ref boolean ab_cancel )
event printtemplateinstantiation ( oleobject pdisp )
event printtemplateteardown ( oleobject pdisp )
event updatepagestatus ( oleobject pdisp,  any npage,  any fdone )
event privacyimpactedstatechange ( boolean bimpacted )
integer x = 1097
integer y = 124
integer width = 3278
integer height = 2680
integer taborder = 20
boolean bringtotop = true
boolean focusrectangle = false
string binarykey = "w_appl_website_fill.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event commandstatechange(long command, boolean enable);CHOOSE CASE command
CASE 1 //CSC_NAVIGATEFORWARD
	cb_forward.enabled = enable
CASE 2 //CSC_NAVIGATEBACK
	cb_back.enabled = enable
END CHOOSE
end event

event newwindow2(ref oleobject ppdisp, ref boolean ab_cancel);//alfee 08.11.2010

//ole_browser2.Visible = True
//ole_browser2.object.RegisterAsBrowser = True
//ppDisp =ole_browser2.object
end event

event navigatecomplete2(oleobject pdisp, any url);//code to enable back button

end event

type cb_back from commandbutton within w_appl_website_fill
integer x = 3337
integer width = 325
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<< Back"
end type

event clicked;try

//	If ole_browser.bringtotop = True Then
		ole_browser.object.goback()
//	ElseIf ole_browser2.bringtotop = True Then
//		ole_browser2.object.goback()
//	End If

	//---------End Modified ------------------------------	
catch (RuntimeError e) // Add by Evan on 10.19.2009
end try
end event

type cb_forward from commandbutton within w_appl_website_fill
integer x = 3671
integer width = 325
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Forward >>"
end type

event clicked;//---------Begin Modified by alfee 08.11.2010 --------
//If ole_browser.bringtotop = True Then
	ole_browser.object.goforward()
//ElseIf ole_browser2.bringtotop = True Then
//	ole_browser2.object.goforward()
//End If
//tab_1.tabpage_view.ole_browser.object.goforward()
//---------End Modified ------------------------------

end event

type cb_close from commandbutton within w_appl_website_fill
integer x = 4041
integer width = 343
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)

end event

type uo_de from pfc_cst_u_de_display within w_appl_website_fill
integer y = 132
integer taborder = 20
end type

on uo_de.destroy
call pfc_cst_u_de_display::destroy
end on


Start of PowerBuilder Binary Data Section : Do NOT Edit
02w_appl_website_fill.bin 
2500000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000001eb62ff001d291ff00000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f000000001eb62ff001d291ff1eb62ff001d291ff000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Cffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c00004a1b0000453f0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c00004a1b0000453f0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
12w_appl_website_fill.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
