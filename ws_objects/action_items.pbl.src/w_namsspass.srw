$PBExportHeader$w_namsspass.srw
forward
global type w_namsspass from window
end type
type dw_org_facility_select from pfc_cst_u_org_facility_selector_vertical within w_namsspass
end type
type tab_1 from tab within w_namsspass
end type
type tabpage_1 from userobject within tab_1
end type
type sle_1 from singlelineedit within tabpage_1
end type
type st_10 from statictext within tabpage_1
end type
type rb_template_2 from radiobutton within tabpage_1
end type
type rb_template_1 from radiobutton within tabpage_1
end type
type rb_none1 from radiobutton within tabpage_1
end type
type cb_17 from commandbutton within tabpage_1
end type
type cb_16 from commandbutton within tabpage_1
end type
type cb_15 from commandbutton within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type st_4 from statictext within tabpage_1
end type
type st_5 from statictext within tabpage_1
end type
type st_6 from statictext within tabpage_1
end type
type st_7 from statictext within tabpage_1
end type
type st_8 from statictext within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
sle_1 sle_1
st_10 st_10
rb_template_2 rb_template_2
rb_template_1 rb_template_1
rb_none1 rb_none1
cb_17 cb_17
cb_16 cb_16
cb_15 cb_15
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
gb_2 gb_2
end type
type tabpage_upload from userobject within tab_1
end type
type cb_8 from commandbutton within tabpage_upload
end type
type st_results from statictext within tabpage_upload
end type
type cb_upload_file from commandbutton within tabpage_upload
end type
type cb_12 from commandbutton within tabpage_upload
end type
type rb_temp2 from radiobutton within tabpage_upload
end type
type rb_temp1 from radiobutton within tabpage_upload
end type
type rb_none2 from radiobutton within tabpage_upload
end type
type gb_1 from groupbox within tabpage_upload
end type
type tabpage_upload from userobject within tab_1
cb_8 cb_8
st_results st_results
cb_upload_file cb_upload_file
cb_12 cb_12
rb_temp2 rb_temp2
rb_temp1 rb_temp1
rb_none2 rb_none2
gb_1 gb_1
end type
type tabpage_search from userobject within tab_1
end type
type st_status from statictext within tabpage_search
end type
type cb_14 from commandbutton within tabpage_search
end type
type cb_13 from commandbutton within tabpage_search
end type
type dw_providers from datawindow within tabpage_search
end type
type tabpage_search from userobject within tab_1
st_status st_status
cb_14 cb_14
cb_13 cb_13
dw_providers dw_providers
end type
type tab_1 from tab within w_namsspass
tabpage_1 tabpage_1
tabpage_upload tabpage_upload
tabpage_search tabpage_search
end type
type cb_11 from commandbutton within w_namsspass
end type
type cb_9 from commandbutton within w_namsspass
end type
type cb_7 from commandbutton within w_namsspass
end type
type cb_6 from commandbutton within w_namsspass
end type
type cb_5 from commandbutton within w_namsspass
end type
type cb_4 from commandbutton within w_namsspass
end type
type cb_3 from commandbutton within w_namsspass
end type
type cb_1 from commandbutton within w_namsspass
end type
type st_pracs from statictext within w_namsspass
end type
type cb_view from commandbutton within w_namsspass
end type
type cb_batch from commandbutton within w_namsspass
end type
type cb_prac from commandbutton within w_namsspass
end type
type cb_2 from commandbutton within w_namsspass
end type
type st_1 from statictext within w_namsspass
end type
type sle_path from singlelineedit within w_namsspass
end type
type cb_close from commandbutton within w_namsspass
end type
type cb_run from commandbutton within w_namsspass
end type
type gb_prac from groupbox within w_namsspass
end type
type cb_10 from commandbutton within w_namsspass
end type
type ole_browser from olecustomcontrol within w_namsspass
end type
type gb_facility from groupbox within w_namsspass
end type
end forward

global type w_namsspass from window
integer width = 3465
integer height = 2456
boolean titlebar = true
string title = "NAMSS PASS Export"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_org_facility_select dw_org_facility_select
tab_1 tab_1
cb_11 cb_11
cb_9 cb_9
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_1 cb_1
st_pracs st_pracs
cb_view cb_view
cb_batch cb_batch
cb_prac cb_prac
cb_2 cb_2
st_1 st_1
sle_path sle_path
cb_close cb_close
cb_run cb_run
gb_prac gb_prac
cb_10 cb_10
ole_browser ole_browser
gb_facility gb_facility
end type
global w_namsspass w_namsspass

type variables
long il_pracs[]
long il_export_api
long il_export_url
integer ii_letter
long il_ticket
long il_facility_id
string is_prac_names[]
string is_file
string is_np_vendor
string is_np_client
gs_batch_search ist_search
n_winhttp in_http
end variables

forward prototypes
public function string of_get_token ()
public function integer of_get_ids ()
public function string of_find_prac (string as_npi)
end prototypes

public function string of_get_token ();integer p
long ll_pos1, ll_pos2, ll_pos3
String ls_url
string ls_source
string ls_token
string ls_auth
any la_res
inet iinet_base
n_cst_datetime lnv

long flags = 0
string  TargetFrame = ""
string  Headers = "Content-Type: application/x-www-form-urlencoded"  //_vbCrlf
string ls_post


//ls_url =  "https://api.namsspass.com/api/v1/token/"

//ls_post = "vendor_key=" + is_np_vendor + "&client_key=" + is_np_client + "&format=json"
//https://api.namsspass.com/api/v1/token/?vendor_key=8bnftb43smimk5uehq3upuhj9r&client_key=hb2rg2b143617dq77u02jregaf14972&format=xml"
//messagebox("post", ls_post)
//ole_browser.Object.Navigate(ls_url, Flags, TargetFrame, ls_Post, Headers)	
//ls_url = "https://api.namsspass.com/api/v1/token/?vendor_key=" + is_np_vendor + "&client_key=" + is_np_client + "&format=json"
//ls_url = "https://api.namsspass.com/api/v1/token/?vendor_key=8bnftb43smimk5uehq3upuhj9r&client_key=hb2rg2b143617dq77u02jregaf14972&format=json"


//return "test"


//ole_browser.Object.Navigate(ls_url)	
lnv.of_wait(2)

ls_source = ole_Browser.object.Document.All.Item(0).innerHTML

debugbreak()
ll_pos1 = pos(ls_source, "vendor_key_authorized",1)
//ll_pos2 = pos(ls_source, ',"',ll_pos1)
ll_pos1+= 23
ll_pos3 = pos(ls_source, ',"c',ll_pos1)
ls_auth = mid(ls_source, ll_pos1,ll_pos3 - ll_pos1)
if ls_auth <> "true" then
	messagebox("NAMSS PASS", "Vendor authorization failed:~r" + is_np_vendor )
	return "failed"
end if

ll_pos1 = pos(ls_source, "client_key_authorized",1)
ll_pos1+= 23
ll_pos3 = pos(ls_source, '},',ll_pos1)
ls_auth = mid(ls_source, ll_pos1,ll_pos3 - ll_pos1)
if ls_auth <> "true" then
	messagebox("NAMSS PASS", "User authorization failed:~r" + is_np_client )
	return "failed"
end if


ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)

ll_pos1 = pos(ls_source, "auth_token",1)
ll_pos2 = pos(ls_source, '":"',ll_pos1)
ll_pos2+= 3
ll_pos3 = pos(ls_source, '"}]',ll_pos2)

ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)

//openwithparm(w_sql_msg,ls_source)
messagebox("token", ls_token)

return ls_token



//<BODY>{"results":[{"auth_token":"8719124d-1ac6-4b22-94e5-b770fcc65d8b"}],"authentication":{"vendor_key_authorized":true,"client_key_authorized":true},"meta":{"is_production":false,"method":"GET","is_multipart":false,"description":"/api/v1/token/","version":"1.0","total_results":1}} </BODY>
end function

public function integer of_get_ids ();//this function will get the NAMSS PASS vendor and user id 

is_np_vendor = "8bnftb43smimk5uehq3upuhj9r" //do not change this value !!!!!

select namsspass_client into :is_np_client from security_users where user_id = :gs_user_id;

if isnull(is_np_client) or is_np_client = "" then
	messagebox("NAMSS PASS Client id","There is no NAMSS PASS Client id for your user in the system.  This is set in the Adminsitration Utilities  Screen NAMSS PASS Settings")
end if

//is_np_client = "hb2rg2b143617dq77u02jregaf14972"

return 1
end function

public function string of_find_prac (string as_npi);//this function gets the total count of provider records connected to the NPI provided
//ls_token is used for API security for the next function call
integer li_FileNum
string ls_url
integer p
long ll_pos1, ll_pos2, ll_pos3
string ls_source
string ls_token
string ls_auth
any la_res
inet iinet_base
n_cst_datetime lnv

ls_url =  gs_temp_path + "namsspasstotals.htm"

li_FileNum = FileOpen(ls_url,   LineMode!, Write!, LockWrite!, Replace!)

FileWrite(li_FileNum,'<form name="namsspass_totals"')
FileWrite(li_FileNum,'	action="https://api.namsspass.com/api/v1/affiliation/totals/" method="post">')
FileWrite(li_FileNum,'	<input type="hidden" name="vendor_key" value="' + is_np_vendor + '">' )
FileWrite(li_FileNum,'	<input type="hidden" name="client_key" value="' + is_np_client + '">' )
FileWrite(li_FileNum,'	<input type="hidden" name="npi" value="' + as_npi + '">' )
FileWrite(li_FileNum,'	<input type="hidden" name="format" value="json">' )
FileWrite(li_FileNum,	'<input type="submit" name="Submit" value="NAMSS PASS">' )
FileWrite(li_FileNum,'</form>')

FileClose(li_FileNum)

ole_browser.Object.Navigate(ls_url)

lnv.of_wait(1)

ole_browser.object.document.Forms("namsspass_totals").Submit.Click

lnv.of_wait(2)

ls_source = ole_Browser.object.Document.All.Item(0).innerHTML


ll_pos1 = pos(ls_source, "vendor_key_authorized",1)
//ll_pos2 = pos(ls_source, ',"',ll_pos1)
ll_pos1+= 23
ll_pos3 = pos(ls_source, ',"c',ll_pos1)
ls_auth = mid(ls_source, ll_pos1,ll_pos3 - ll_pos1)
if ls_auth <> "true" then
	messagebox("NAMSS PASS", "Vendor authorization failed:~r" + is_np_vendor )
	return "-1"
end if

ll_pos1 = pos(ls_source, "client_key_authorized",1)
ll_pos1+= 23
ll_pos3 = pos(ls_source, '},',ll_pos1)
ls_auth = mid(ls_source, ll_pos1,ll_pos3 - ll_pos1)
if ls_auth <> "true" then
	messagebox("NAMSS PASS", "User authorization failed:~r" + is_np_client )
	return "-2"
end if


ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)

ll_pos1 = pos(ls_source, "total_records_found",1)
ll_pos2 = pos(ls_source,":",ll_pos1)
ll_pos2++
ll_pos3 = pos(ls_source, "}",ll_pos2)

ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)

//openwithparm(w_sql_msg,ls_source)
//messagebox("Found records", ls_token)

return ls_token






end function

on w_namsspass.create
this.dw_org_facility_select=create dw_org_facility_select
this.tab_1=create tab_1
this.cb_11=create cb_11
this.cb_9=create cb_9
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_1=create cb_1
this.st_pracs=create st_pracs
this.cb_view=create cb_view
this.cb_batch=create cb_batch
this.cb_prac=create cb_prac
this.cb_2=create cb_2
this.st_1=create st_1
this.sle_path=create sle_path
this.cb_close=create cb_close
this.cb_run=create cb_run
this.gb_prac=create gb_prac
this.cb_10=create cb_10
this.ole_browser=create ole_browser
this.gb_facility=create gb_facility
this.Control[]={this.dw_org_facility_select,&
this.tab_1,&
this.cb_11,&
this.cb_9,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_1,&
this.st_pracs,&
this.cb_view,&
this.cb_batch,&
this.cb_prac,&
this.cb_2,&
this.st_1,&
this.sle_path,&
this.cb_close,&
this.cb_run,&
this.gb_prac,&
this.cb_10,&
this.ole_browser,&
this.gb_facility}
end on

on w_namsspass.destroy
destroy(this.dw_org_facility_select)
destroy(this.tab_1)
destroy(this.cb_11)
destroy(this.cb_9)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.st_pracs)
destroy(this.cb_view)
destroy(this.cb_batch)
destroy(this.cb_prac)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.sle_path)
destroy(this.cb_close)
destroy(this.cb_run)
destroy(this.gb_prac)
destroy(this.cb_10)
destroy(this.ole_browser)
destroy(this.gb_facility)
end on

event open;//Start Code Change ----04.15.2013 #V14 maha - window created

select export_id into :il_export_url from export_header where export_name = 'NAMSSPASSExport';
select export_id into :il_export_api from export_header where export_name = 'NAMSSPASSExport';

//if il_export_id = 0 or isnull(il_export_id) then
//	messagebox("NAMSSPASSExport", "There is no Export named NAMSSPASSExport available.")
//	close( this)
//	return
//end if
	
sle_path.text = gs_temp_path

is_file = gs_temp_path + "NAMSSPASSExport.xls"

of_get_ids( )  //Start Code Change ----08.14.2013 #V14 maha
end event

type dw_org_facility_select from pfc_cst_u_org_facility_selector_vertical within w_namsspass
integer x = 73
integer y = 260
integer width = 827
integer height = 76
integer taborder = 70
string dataobject = "d_facility_w_picture"
end type

event constructor;DataWindowChild dwchild

This.SetTransObject( SQLCA )

This.InsertRow( 0 )
//this.retrieve(gs_user_id)
//If This.RowCount() < 1 Then This.InsertRow(0) //alfee 11.24.2009

This.GetChild( "facility_name", dwchild )
dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve( gs_user_id )
dwchild.InsertRow(1)
dwchild.SetItem( 1, "facility_name", "All" )
dwchild.SetItem( 1, "facility_id", 0 )

//This.SetItem( 1, "facility_id", 0 )
//IF IsNull(this.getItemNumber(1,"facility_id")) then This.SetItem( 1, "facility_id", 0 )	//long.zhang 09.26.2011 Department Secuirty and Profile Module - Bug id 2658
//---------------------------- APPEON END ----------------------------

end event

event itemchanged;call super::itemchanged;	il_facility_id = Integer( data )
end event

type tab_1 from tab within w_namsspass
integer x = 37
integer y = 380
integer width = 3305
integer height = 1852
integer taborder = 60
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
tabpage_1 tabpage_1
tabpage_upload tabpage_upload
tabpage_search tabpage_search
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_upload=create tabpage_upload
this.tabpage_search=create tabpage_search
this.Control[]={this.tabpage_1,&
this.tabpage_upload,&
this.tabpage_search}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_upload)
destroy(this.tabpage_search)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3269
integer height = 1736
long backcolor = 33551856
string text = "Upload (Website)"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
sle_1 sle_1
st_10 st_10
rb_template_2 rb_template_2
rb_template_1 rb_template_1
rb_none1 rb_none1
cb_17 cb_17
cb_16 cb_16
cb_15 cb_15
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
gb_2 gb_2
end type

on tabpage_1.create
this.sle_1=create sle_1
this.st_10=create st_10
this.rb_template_2=create rb_template_2
this.rb_template_1=create rb_template_1
this.rb_none1=create rb_none1
this.cb_17=create cb_17
this.cb_16=create cb_16
this.cb_15=create cb_15
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.gb_2=create gb_2
this.Control[]={this.sle_1,&
this.st_10,&
this.rb_template_2,&
this.rb_template_1,&
this.rb_none1,&
this.cb_17,&
this.cb_16,&
this.cb_15,&
this.st_2,&
this.st_3,&
this.st_4,&
this.st_5,&
this.st_6,&
this.st_7,&
this.st_8,&
this.gb_2}
end on

on tabpage_1.destroy
destroy(this.sle_1)
destroy(this.st_10)
destroy(this.rb_template_2)
destroy(this.rb_template_1)
destroy(this.rb_none1)
destroy(this.cb_17)
destroy(this.cb_16)
destroy(this.cb_15)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.gb_2)
end on

type sle_1 from singlelineedit within tabpage_1
integer x = 1669
integer y = 72
integer width = 1303
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_10 from statictext within tabpage_1
integer x = 1440
integer y = 92
integer width = 233
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "File Path:"
boolean focusrectangle = false
end type

type rb_template_2 from radiobutton within tabpage_1
integer x = 978
integer y = 112
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Template 2"
end type

event clicked;ii_letter = 2
end event

type rb_template_1 from radiobutton within tabpage_1
integer x = 526
integer y = 112
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
string text = "Template 1"
boolean checked = true
end type

event clicked;ii_letter = 1
end event

type rb_none1 from radiobutton within tabpage_1
integer x = 128
integer y = 112
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
string text = "None"
end type

event clicked;ii_letter = 0
end event

type cb_17 from commandbutton within tabpage_1
integer x = 1339
integer y = 356
integer width = 343
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Open File"
end type

event clicked;//Start Code Change ----04.08.2013 #V12 maha

Long prac_ids[]
string ls_exp_name
string ls_path
integer res
integer i


debugbreak()
ls_path = sle_path.text + "NAMSSPASS Export.xls"
//messagebox("",ls_path)
of_open_excel(ls_path,"NP")



return

end event

type cb_16 from commandbutton within tabpage_1
integer x = 1339
integer y = 472
integer width = 494
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Go to NAMSS PASS"
end type

event clicked;

String ls_url = "http://www.namss.org/NAMSSPASS/tabid/425/Default.aspx" 
	//String ls_url = "https://pro-file2.winstaff.com/winstaff/phdb2/hco.jsp" 
	inet iinet_base 
	String ls_null
	
	GetContextService("Internet", iinet_base)
	if gi_citrix = 1 then
		of_open_web(ls_url)
	else
		setnull(ls_null)
		//---------Begin Modified by (Appeon)Harry 04.27.2015 for Keep Everything under One Browser--------
		//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)
		ShellExecuteA (Handle( This ), "open", of_getbrowserversion( ), ls_url, ls_Null, 4)
		//---------End Modfiied ------------------------------------------------------
	end if
	return 1
end event

type cb_15 from commandbutton within tabpage_1
integer x = 1330
integer y = 224
integer width = 343
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create File"
end type

event clicked;//Start Code Change ----04.08.2013 #V12 maha

Long prac_ids[]
string ls_exp_name
string ls_path
integer res
integer i
pfc_n_cst_ai_export_apb  n_export

ls_path = sle_path.text 

if il_export_url = 0 or isnull(il_export_url) then
	messagebox("NAMSSPASSExport", "There is no Export named NAMSSPASSExport available.  Contact support for Export files.")
	return
end if

n_export = CREATE pfc_n_cst_ai_export_apb

n_export.is_header_rebuild = "NP"

if il_facility_id = 0 then
	messagebox("Facility","Please select the facility")
	return -1
end if
	

res = n_export.of_export_data_with_text( il_export_url, il_pracs[],ls_path,0,string(ii_letter),string(il_facility_id),"",2,"" ) ////Start Code Change ----01.06.2010 #V10 maha - added param 1

destroy n_export
//debugbreak()
//ls_path = ls_path + "NAMSSPASS Export.xls"
//i = run(ls_path)

//return
//messagebox("res",res)
//if res < 0 then
//	return -1
//else
//	String ls_url = "http://www.namss.org/NAMSSPASS/tabid/425/Default.aspx" 
//	//String ls_url = "https://pro-file2.winstaff.com/winstaff/phdb2/hco.jsp" 
//	inet iinet_base 
//	String ls_null
//	
//	GetContextService("Internet", iinet_base)
//	if gi_citrix = 1 then
//		of_open_web(ls_url)
//	else
//		setnull(ls_null)
//		ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)
//	end if
//	return 1
//end if
end event

type st_2 from statictext within tabpage_1
integer x = 101
integer y = 240
integer width = 1198
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Select providers and  and click Create file."
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_1
integer x = 91
integer y = 364
integer width = 997
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Open File and save as .XLSX."
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_1
integer x = 91
integer y = 480
integer width = 997
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Go to NAMSS PASS site and login."
boolean focusrectangle = false
end type

type st_5 from statictext within tabpage_1
integer x = 1367
integer y = 812
integer width = 1449
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Click ~'Upload data file~' link to upload your file."
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_1
integer x = 1367
integer y = 712
integer width = 1431
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Click ~'Upload/Manage Your Affiliation Data for ...~' link"
boolean focusrectangle = false
end type

type st_7 from statictext within tabpage_1
integer x = 1367
integer y = 624
integer width = 997
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Click ~'Access the NAMSS PASS~' link"
boolean focusrectangle = false
end type

type st_8 from statictext within tabpage_1
integer x = 859
integer y = 624
integer width = 457
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "On the Website:"
boolean focusrectangle = false
end type

type gb_2 from groupbox within tabpage_1
integer x = 78
integer y = 52
integer width = 1289
integer height = 144
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Letter setting"
end type

type tabpage_upload from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3269
integer height = 1736
long backcolor = 33551856
string text = "Upload (API)"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
cb_8 cb_8
st_results st_results
cb_upload_file cb_upload_file
cb_12 cb_12
rb_temp2 rb_temp2
rb_temp1 rb_temp1
rb_none2 rb_none2
gb_1 gb_1
end type

on tabpage_upload.create
this.cb_8=create cb_8
this.st_results=create st_results
this.cb_upload_file=create cb_upload_file
this.cb_12=create cb_12
this.rb_temp2=create rb_temp2
this.rb_temp1=create rb_temp1
this.rb_none2=create rb_none2
this.gb_1=create gb_1
this.Control[]={this.cb_8,&
this.st_results,&
this.cb_upload_file,&
this.cb_12,&
this.rb_temp2,&
this.rb_temp1,&
this.rb_none2,&
this.gb_1}
end on

on tabpage_upload.destroy
destroy(this.cb_8)
destroy(this.st_results)
destroy(this.cb_upload_file)
destroy(this.cb_12)
destroy(this.rb_temp2)
destroy(this.rb_temp1)
destroy(this.rb_none2)
destroy(this.gb_1)
end on

type cb_8 from commandbutton within tabpage_upload
integer x = 133
integer y = 220
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create File"
end type

event clicked;//Start Code Change ----04.08.2013 #V12 maha

Long prac_ids[]
string ls_exp_name
string ls_path
integer res
integer i
pfc_n_cst_ai_export_apb  n_export

if isnull(is_np_client) or is_np_client = "" then
	messagebox("NAMSS PASS Client id","There is no NAMSS PASS Client id for your user in the system.  This is set in the Adminsitration Utilities  Screen NAMSS PASS Settings")
	return 
end if

if il_export_url = 0 or isnull(il_export_url) then
	messagebox("NAMSSPASSAPI", "There is no Export named NAMSSPASSAPI available.  Contact support for Export files." )
	return
end if

ls_path = sle_path.text 

is_file = ls_path + "NAMSSPASS Export.xls"

n_export = CREATE pfc_n_cst_ai_export_apb

n_export.is_header_rebuild = "NP"

res = n_export.of_export_data_with_text( il_export_api, il_pracs[],ls_path,0,string(ii_letter),string(il_facility_id),"",2,"" ) ////Start Code Change ----01.06.2010 #V10 maha - added param 1

destroy n_export

if res = 1 then
	is_file = ls_path
	messagebox("File Created",ls_path)
	st_results.text = "File Created.  Click Begin Process"
else
	st_results.text = "File Creation Failed."
end if

end event

type st_results from statictext within tabpage_upload
integer x = 151
integer y = 708
integer width = 1742
integer height = 624
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Providers and Facility.  Click Create File."
boolean focusrectangle = false
end type

type cb_upload_file from commandbutton within tabpage_upload
integer x = 910
integer y = 220
integer width = 343
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Upload File"
end type

event clicked;string ls_source
string ls_done = "NOT"
n_cst_datetime lnv
long ll_p1
long ll_p2
long ll_p3
integer cnt

ole_browser.object.document.Forms("namsspass_letterid").Submit.Click

do until ls_done = "DONE" 
	lnv.of_wait(1)
	ls_source = ole_Browser.object.Document.All.Item(0).innerHTML
	ll_p1 = pos(ls_source, "result" , 1)
	if ll_p1 > 0 then  ls_done = "DONE" 
	cnt++
	if cnt > 15 then  ls_done = "DONE" 
loop




end event

type cb_12 from commandbutton within tabpage_upload
integer x = 530
integer y = 220
integer width = 357
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Begin Process"
end type

event clicked;integer li_FileNum
string ls_url

ls_url = gs_temp_path + "namsspassletterid.htm"

li_FileNum = FileOpen(ls_url,   LineMode!, Write!, LockWrite!, Replace!)

FileWrite(li_FileNum,'<form name="namsspass_letterid" enctype="multipart/form-data"')
FileWrite(li_FileNum,'	action="https://api.namsspass.com/api/v1/update/file/ticket/" method="post">')
FileWrite(li_FileNum,'	Browse to file NAMSSPASSExport.xls, and click Upload File <br/>')
FileWrite(li_FileNum,'	<input type="hidden" name="vendor_key" value="' + is_np_vendor + '">' )
FileWrite(li_FileNum,'	<input type="hidden" name="client_key" value="' + is_np_client + '">' )
//FileWrite(li_FileNum,'	<input type="hidden" name="letter_id" value="' + string (ii_letter) + '">' )
FileWrite(li_FileNum,'	<input type="hidden" name="letter_id" value="' + string (1390) + '">' )
FileWrite(li_FileNum,'	<input type="hidden" name="format" value="json">' )
FileWrite(li_FileNum,'	<input type="hidden" name="post_live" value="false">' )
FileWrite(li_FileNum,'	<input type="file" name="file_upload" value="' + is_file + '">' )
FileWrite(li_FileNum,'	<br/> <br/> <br/>' )
FileWrite(li_FileNum,	'<input type="submit" name="submit" value="Submit File">' )
FileWrite(li_FileNum,'</form>')

FileClose(li_FileNum)

ole_browser.Object.Navigate(ls_url)

st_results.text = "Click Browse to select the NAMSSPASSEXPORT.xls~rClick Upload File."
end event

type rb_temp2 from radiobutton within tabpage_upload
integer x = 1019
integer y = 116
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Template 2"
end type

event clicked;ii_letter = 2
end event

type rb_temp1 from radiobutton within tabpage_upload
integer x = 576
integer y = 116
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
string text = "Template 1"
boolean checked = true
end type

event clicked;ii_letter = 1
end event

type rb_none2 from radiobutton within tabpage_upload
integer x = 160
integer y = 116
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
string text = "None"
end type

event clicked;ii_letter = 0
end event

type gb_1 from groupbox within tabpage_upload
integer x = 110
integer y = 64
integer width = 1289
integer height = 144
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Letter setting"
end type

type tabpage_search from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3269
integer height = 1736
long backcolor = 33551856
string text = "Search"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
st_status st_status
cb_14 cb_14
cb_13 cb_13
dw_providers dw_providers
end type

on tabpage_search.create
this.st_status=create st_status
this.cb_14=create cb_14
this.cb_13=create cb_13
this.dw_providers=create dw_providers
this.Control[]={this.st_status,&
this.cb_14,&
this.cb_13,&
this.dw_providers}
end on

on tabpage_search.destroy
destroy(this.st_status)
destroy(this.cb_14)
destroy(this.cb_13)
destroy(this.dw_providers)
end on

type st_status from statictext within tabpage_search
integer x = 87
integer y = 144
integer width = 1362
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Progress"
boolean focusrectangle = false
end type

type cb_14 from commandbutton within tabpage_search
integer x = 535
integer y = 36
integer width = 530
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "NAMSS PASS Search"
end type

event clicked;long rc
long r
integer li_cnt
string ls_npi
string res
string ls_name

dw_providers.settransobject(sqlca)
rc = dw_providers.rowcount()

for r = 1 to rc
	if dw_providers.getitemnumber(r,"selected") = 1 then
		ls_name =  dw_providers.getitemstring(r,"full_name")
		ls_npi =  dw_providers.getitemstring(r,"npi_number")
		st_status.text = "Searching for " + ls_name
		res = of_find_prac(ls_npi)
		li_cnt = integer(res)
		dw_providers.setitem(r, "num_found", li_cnt)
		if li_cnt < 1 then dw_providers.setitem(r,"selected", 0)
	end if
next

st_status.text = "Completed search"
		
end event

type cb_13 from commandbutton within tabpage_search
integer x = 69
integer y = 36
integer width = 453
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Provider List"
end type

event clicked;long rc
long r
string ls_npi


dw_providers.settransobject(sqlca)
rc = dw_providers.retrieve(il_pracs[])




end event

type dw_providers from datawindow within tabpage_search
integer x = 69
integer y = 228
integer width = 3113
integer height = 832
integer taborder = 60
string title = "none"
string dataobject = "d_namsspass_get_pracs"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type cb_11 from commandbutton within w_namsspass
integer x = 3936
integer y = 744
integer width = 343
integer height = 88
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "totals file"
end type

event clicked;integer li_FileNum
string ls_url
integer p
long ll_pos1, ll_pos2, ll_pos3
string ls_source
string ls_token
string ls_auth
any la_res
inet iinet_base
n_cst_datetime lnv

ls_url =  gs_temp_path + "namsspasstotals.htm"

li_FileNum = FileOpen(ls_url,   LineMode!, Write!, LockWrite!, Replace!)

FileWrite(li_FileNum,'<form name="namsspass_totals"')
FileWrite(li_FileNum,'	action="https://api.namsspass.com/api/v1/affiliation/totals/" method="post">')
FileWrite(li_FileNum,'	<input type="hidden" name="vendor_key" value="' + is_np_vendor + '">' )
FileWrite(li_FileNum,'	<input type="hidden" name="client_key" value="' + is_np_client + '">' )
FileWrite(li_FileNum,'	<input type="hidden" name="npi" value="1234567890">' )
FileWrite(li_FileNum,'	<input type="hidden" name="format" value="json">' )
FileWrite(li_FileNum,	'<input type="submit" name="Submit" value="NAMSS PASS">' )
FileWrite(li_FileNum,'</form>')

FileClose(li_FileNum)

ole_browser.Object.Navigate(ls_url)

lnv.of_wait(1)

ole_browser.object.document.Forms("namsspass_totals").Submit.Click

lnv.of_wait(2)

ls_source = ole_Browser.object.Document.All.Item(0).innerHTML


ll_pos1 = pos(ls_source, "vendor_key_authorized",1)
//ll_pos2 = pos(ls_source, ',"',ll_pos1)
ll_pos1+= 23
ll_pos3 = pos(ls_source, ',"c',ll_pos1)
ls_auth = mid(ls_source, ll_pos1,ll_pos3 - ll_pos1)
if ls_auth <> "true" then
	messagebox("NAMSS PASS", "Vendor authorization failed:~r" + is_np_vendor )
	return 
end if

ll_pos1 = pos(ls_source, "client_key_authorized",1)
ll_pos1+= 23
ll_pos3 = pos(ls_source, '},',ll_pos1)
ls_auth = mid(ls_source, ll_pos1,ll_pos3 - ll_pos1)
if ls_auth <> "true" then
	messagebox("NAMSS PASS", "User authorization failed:~r" + is_np_client )
	return
end if


ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)

ll_pos1 = pos(ls_source, "total_records_found",1)
ll_pos2 = pos(ls_source,":",ll_pos1)
ll_pos2++
ll_pos3 = pos(ls_source, "}",ll_pos2)

ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)

//openwithparm(w_sql_msg,ls_source)
messagebox("Found records", ls_token)

return 






end event

type cb_9 from commandbutton within w_namsspass
integer x = 4105
integer y = 348
integer width = 343
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "links"
end type

event clicked;//http://www.rgagnon.com/pbdetails/pb-0202.html
//http://www.netomatix.com/HttpPostData.aspx
end event

type cb_7 from commandbutton within w_namsspass
integer x = 4073
integer y = 472
integer width = 343
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "letter id"
end type

event clicked;integer p
long ll_pos1, ll_pos2, ll_pos3
long flags = 0
string  TargetFrame = ""
string  Headers = "Content-Type: application/x-www-form-urlencoded"  //_vbCrlf
String ls_url

string ls_source
string ls_token
string ls_auth
string ls_post
any la_res
n_cst_datetime lnv

ls_url = "https://api.namsspass.com/api/v1/update/file/ticket/"

ls_post = "vendor_key=" + is_np_vendor + "&client_key=" + is_np_client + "&letter_id="+ string(ii_letter) +"&file_upload=" + is_file + "&format=json&post_live=false"
//https://api.namsspass.com/api/v1/token/?vendor_key=8bnftb43smimk5uehq3upuhj9r&client_key=hb2rg2b143617dq77u02jregaf14972&format=xml"
messagebox("post", ls_post)
//clipboard(ls_url)

ole_browser.Object.Navigate(ls_url, Flags, TargetFrame, ls_Post, Headers)	
lnv.of_wait(3)

ls_source = ole_Browser.object.Document.All.Item(0).innerHTML
messagebox("Result", ls_source)
//ll_pos1 = pos(ls_source, "_token",1)
//ll_pos2 = pos(ls_source, "class=tx>",ll_pos1)
//ll_pos2+= 9
//ll_pos3 = pos(ls_source, "</",ll_pos2)
//
//ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)
//
//messagebox("token", ls_token)

//      Sub Command1_Click()
//         Dim URL As String
//         Dim Flags As Long
//         Dim TargetFrame As String
//         Dim PostData() As Byte
//         Dim Headers As String
//
//         URL = "http://YourServer" ' A URL that will accept a POST
//         Flags = 0
//         TargetFrame = ""
//
//         PostData = "Information sent to host"
//
//         ' VB creates a Unicode string by default so we need to
//         ' convert it back to Single byte character set.
//         PostData = StrConv(PostData, vbFromUnicode)
//
//         Headers = "Content-Type: application/x-www-form-urlencoded" & _
//            vbCrlf
//         WebBrowser1.Navigate URL, Flags, TargetFrame, PostData, Headers
//      End Sub



//http://www.netomatix.com/HttpPostData.aspx
end event

type cb_6 from commandbutton within w_namsspass
integer x = 3675
integer y = 504
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "tokenpost"
end type

event clicked;integer p
String ls_url
string ls_source
inet iinet_base

ls_url = "https://api.namsspass.com/api/v1/token/"


ole_browser.Object.Navigate(ls_url, "vendor_key=8bnftb43smimk5uehq3upuhj9r&client_key=hb2rg2b143617dq77u02jregaf14972&format=xml")	
//ls_source = ole_browser.object.getsource()












//if LenA(ls_url) < 6 then 
//	messagebox("Error","Invalid URL")
//	return
//end if
//
//if gi_citrix = 1 then
//	of_open_web(ls_url)
//else
//	String ls_null
//	setnull(ls_null)
//	ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)
//	
//	//---------------------------- APPEON END ----------------------------
//	
//end if
end event

type cb_5 from commandbutton within w_namsspass
integer x = 46
integer y = 1952
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "token"
end type

event clicked;of_get_ids( )
of_get_token( )

//ls_url = "https://api.namsspass.com/api/v1/token/?vendor_key=8bnftb43smimk5uehq3upuhj9r&client_key=hb2rg2b143617dq77u02jregaf14972&format=xml"
//
//
//ole_browser.Object.Navigate(ls_url)	
//lnv.of_wait(3)
//
//ls_source = ole_Browser.object.Document.All.Item(0).innerHTML
//
//ll_pos1 = pos(ls_source, "_token",1)
//ll_pos2 = pos(ls_source, "class=tx>",ll_pos1)
//ll_pos2+= 9
//ll_pos3 = pos(ls_source, "</",ll_pos2)
//
//ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)
//
//messagebox("token", ls_token)

end event

type cb_4 from commandbutton within w_namsspass
integer x = 3712
integer y = 424
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "token test"
end type

event clicked;
Boolean lb_result
String ls_URL, ls_data
string ls_resp
long p1
long p2

SetPointer(HourGlass!)

ls_URL  = "https://api.namsspass.com/api/v1/token/?"
 ls_data = "vendor_key=8bnftb43smimk5uehq3upuhj9r&"
 ls_data+= "client_key=hb2rg2b143617dq77u02jregaf14972"
//  ls_data+= "&format=json"


lb_result = in_http.Open("POST", ls_URL)
If Not lb_result Then
	MessageBox("Send Error","Post")
	return 0
end if

//in_http.SetRequestHeader("Content-Length", String(Len(ls_data)))
//in_http.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
//MessageBox("Send data",ls_data)
//debugbreak()

ls_url+= ls_data
//clipboard(ls_url)

ls_url = "https://api.namsspass.com/api/v1/token/?vendor_key=8bnftb43smimk5uehq3upuhj9r&client_key=hb2rg2b143617dq77u02jregaf14972&format=xml"

lb_result = in_http.Send(ls_url)

If Not lb_result Then
	MessageBox("Send Error #" + &
					String(Error.Number), Error.Text, StopSign!)
	Return
End If

If in_http.ResponseText = "" Then
	ls_resp = "No response returned"
Else
	ls_resp = in_http.ResponseText
End If




MessageBox("Response",ls_resp)
end event

type cb_3 from commandbutton within w_namsspass
integer x = 3730
integer y = 324
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Totals alt"
end type

event clicked;
//!!!HTTPS IS UNSUPPORTED BY POSTURL!!!



//Blob lblb_args 
//String ls_header
//String ls_url
//String ls_args
//string ls_result
//long ll_length
//integer li_rc
//inet iinet
//n_ir_msgbox ir
//
//li_rc = GetContextService( "Internet", iinet )
//
//IF li_rc = 1 THEN
//   ir = CREATE n_ir_msgbox
//  ls_URL  = "https://api.namsspass.com/api/v1/affiliation/totals/?"
//   ls_args = "vendor_key=8bnftb43smimk5uehq3upuhj9r&user_key=hb2rg2b143617dq77u02jregaf14972&npi=012345678"
//   lblb_args = Blob( ls_args )
//   ll_length = Len( lblb_args )
//   ls_header = "Content-Type: "  +    "application/x-www-form-urlencoded~n" +  "Content-Length: " + String( ll_length ) + "~n~n"
//   li_rc = iinet.PostURL( ls_url, lblb_args, ls_header, ir )
//END IF
//
//messagebox("",li_rc)
//messagebox("",string(ir))


end event

type cb_1 from commandbutton within w_namsspass
integer x = 3849
integer y = 616
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Totals Test"
end type

event clicked;//test affiliation
Boolean lb_result
String ls_URL, ls_data
string ls_send
string ls_resp
long p1
long p2

SetPointer(HourGlass!)
DEBUGBREAK()
ls_URL  = "https://api.namsspass.com/api/v1/affiliation/totals/?"
 ls_data = "vendor_key=8bnftb43smimk5uehq3upuhj9r&"
 ls_data+= "client_key=hb2rg2b143617dq77u02jregaf14972&"
 ls_data+= "npi=01234567890"
ls_data+= "&format=json"
 

lb_result = in_http.Open("POST", ls_URL)
If Not lb_result Then
	MessageBox("Send Error","Post")
	return 0
end if

ls_send  = ls_url + ls_data
//MessageBox("POST url", ls_send)
clipboard(ls_send)
 
//lb_result = in_http.Send(ls_data)
lb_result = in_http.Send(ls_send)
If Not lb_result Then
	MessageBox("Send Error #" + &
					String(Error.Number), Error.Text, StopSign!)
	Return
End If

If in_http.ResponseText = "" Then
	ls_resp = "No response returned"
Else
	ls_resp = in_http.ResponseText
End If


//ls_resp = mid(ls_resp, p1 + 4, p1 - p2 - 4)
//clipboard(ls_resp)
openwithparm(w_sql_msg,ls_resp)
//MessageBox("Response",ls_resp)
end event

type st_pracs from statictext within w_namsspass
integer x = 87
integer y = 88
integer width = 1179
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "No provider selected"
boolean focusrectangle = false
end type

type cb_view from commandbutton within w_namsspass
integer x = 1966
integer y = 72
integer width = 489
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&View Selected"
end type

event clicked;gs_batch_search ls_b

IF UpperBound( il_pracs ) > 0 THEN
	ls_b.li_prac_id[] = il_pracs[]
	openwithparm(w_selected_prac_list,ls_b)
END IF
end event

type cb_batch from commandbutton within w_namsspass
integer x = 1472
integer y = 72
integer width = 489
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Batch Select"
end type

event clicked;openwithparm(w_batch_prac_select_new, "R" )

if message.stringparm = "Cancel" then return

ist_search = message.powerobjectparm
il_pracs[] = ist_search.li_prac_id[]
is_prac_names[] = ist_search.ls_name[]

st_pracs.Text = String( UpperBound( il_pracs[] ) ) + " Practitioners selected."

IF UpperBound( il_pracs ) > 0 THEN
	cb_run.Enabled = True
END IF

 

end event

type cb_prac from commandbutton within w_namsspass
integer x = 942
integer y = 72
integer width = 526
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select Provider"
end type

event clicked;Integer li_nr
Integer li_find
Long ll_prac_id
String ls_full_name
long r
long rc
long i
long ic
gs_search lstr_search
gs_batch_search lst_batch

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "REPORTS0" 

OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN
	Return -1
END IF
debugbreak()
rc = UpperBound( il_pracs )
////ll_prac_id = Long( Mid( Message.StringParm, 1, Pos( Message.StringParm, "-" ) -1 ) )

lst_batch = message.powerobjectparm
//maha 091605 allowing for multi selection
ic = upperbound(lst_batch.li_prac_id[])
//maha app101305
for i = 1 to ic
	ll_prac_id = lst_batch.li_prac_id[i] //maha 091605
	for r = 1 to rc
		if il_pracs[r] = ll_prac_id then
			li_find = 1
			exit
		end if
	next
	IF li_find > 0 THEN
		//skip
	else
		rc++
		il_pracs[rc] = ll_prac_id
		//Start Code Change ---- 04.10.2006 #396 maha
		is_prac_names[rc] = lst_batch.ls_name[i]
		//End Code Change---04.10.2006
	END IF
next


st_pracs.Text = String( UpperBound( il_pracs[] ) ) + " Providers selected."

IF UpperBound( il_pracs ) > 0 THEN
	cb_run.Enabled = True
END IF

 

end event

type cb_2 from commandbutton within w_namsspass
integer x = 4064
integer y = 232
integer width = 256
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Browse"
end type

event clicked;string ls_path 

ls_path = f_browseforfolder('Please select a Directory/Folder where you will save the export.' ,handle(parent))

if f_validstr(ls_path)  then 

sle_path.text = ls_path  +"\"

end if
end event

type st_1 from statictext within w_namsspass
integer x = 3694
integer y = 224
integer width = 233
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
string text = "File Path:"
boolean focusrectangle = false
end type

type sle_path from singlelineedit within w_namsspass
integer x = 3726
integer y = 72
integer width = 1303
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_close from commandbutton within w_namsspass
integer x = 3017
integer y = 68
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;Close(parent)
end event

type cb_run from commandbutton within w_namsspass
boolean visible = false
integer x = 2665
integer y = 68
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;////Start Code Change ----04.08.2013 #V12 maha
//
//Long prac_ids[]
//string ls_exp_name
//string ls_path
//integer res
//integer i
//pfc_n_cst_ai_export_apb  n_export
//
//ls_path = sle_path.text 
//
//n_export = CREATE pfc_n_cst_ai_export_apb
//
//n_export.is_header_rebuild = "NP"
//
//res = n_export.of_export_data_with_text( il_export_id, il_pracs[],ls_path,0,string(ii_letter),"","",2,"" ) ////Start Code Change ----01.06.2010 #V10 maha - added param 1
//
//destroy n_export
//
////messagebox("res",res)
//if res < 0 then
//	return -1
//else
//	String ls_url = "http://www.namss.org/NAMSSPASS/tabid/425/Default.aspx" 
//	inet iinet_base 
//	String ls_null
//	
//	GetContextService("Internet", iinet_base)
//	if gi_citrix = 1 then
//		of_open_web(ls_url)
//	else
//		setnull(ls_null)
//		//---------Begin Modified by (Appeon)Harry 04.27.2015 for Keep Everything under One Browser--------
//		//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)
//		ShellExecuteA (Handle( This ), "open", of_getbrowserversion( ), ls_url, ls_Null, 4)
//		//---------End Modfiied ------------------------------------------------------
//	end if
//	return 1
//end if
end event

type gb_prac from groupbox within w_namsspass
integer x = 14
integer y = 20
integer width = 2519
integer height = 168
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Providers"
end type

type cb_10 from commandbutton within w_namsspass
integer x = 3525
integer y = 792
integer width = 343
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "token file"
end type

event clicked;integer li_FileNum
string ls_url
integer p
long ll_pos1, ll_pos2, ll_pos3
string ls_source
string ls_token
string ls_auth
any la_res
inet iinet_base
n_cst_datetime lnv

ls_url = gs_temp_path + "namsspasstoken.htm"

li_FileNum = FileOpen(ls_url,   LineMode!, Write!, LockWrite!, Replace!)

FileWrite(li_FileNum,'<form name="namsspass_token"')
FileWrite(li_FileNum,'	action="https://api.namsspass.com/api/v1/token/" method="post">')
FileWrite(li_FileNum,'	<input type="hidden" name="vendor_key" value="' + is_np_vendor + '">' )
FileWrite(li_FileNum,'	<input type="hidden" name="client_key" value="' + is_np_client + '">' )
FileWrite(li_FileNum,'	<input type="hidden" name="format" value="json">' )
FileWrite(li_FileNum,	'<input type="submit" name="Submit" value="NAMSS PASS">' )
FileWrite(li_FileNum,'</form>')

FileClose(li_FileNum)

ole_browser.Object.Navigate(ls_url)
lnv.of_wait(1)
ole_browser.object.document.Forms("namsspass_token").Submit.Click

lnv.of_wait(2)

ls_source = ole_Browser.object.Document.All.Item(0).innerHTML


ll_pos1 = pos(ls_source, "vendor_key_authorized",1)

ll_pos1+= 23
ll_pos3 = pos(ls_source, ',"c',ll_pos1)
ls_auth = mid(ls_source, ll_pos1,ll_pos3 - ll_pos1)
if ls_auth <> "true" then
	messagebox("NAMSS PASS", "Vendor authorization failed:~r" + is_np_vendor )
	return 
end if

ll_pos1 = pos(ls_source, "client_key_authorized",1)
ll_pos1+= 23
ll_pos3 = pos(ls_source, '},',ll_pos1)
ls_auth = mid(ls_source, ll_pos1,ll_pos3 - ll_pos1)
if ls_auth <> "true" then
	messagebox("NAMSS PASS", "User authorization failed:~r" + is_np_client )
	return
end if


ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)

ll_pos1 = pos(ls_source, "auth_token",1)
ll_pos2 = pos(ls_source, '":"',ll_pos1)
ll_pos2+= 3
ll_pos3 = pos(ls_source, '"}]',ll_pos2)

ls_token = mid(ls_source, ll_pos2,ll_pos3 - ll_pos2)

//openwithparm(w_sql_msg,ls_source)
messagebox("token", ls_token)

return 

end event

type ole_browser from olecustomcontrol within w_namsspass
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
integer x = 2816
integer y = 2008
integer width = 576
integer height = 340
integer taborder = 50
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_namsspass.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
end type

event commandstatechange(long command, boolean enable);CHOOSE CASE command
CASE 1 //CSC_NAVIGATEFORWARD
	//cb_forward.enabled = enable
CASE 2 //CSC_NAVIGATEBACK
	//cb_back.enabled = enable
END CHOOSE
end event

event newwindow2(ref oleobject ppdisp, ref boolean ab_cancel);//alfee 08.11.2010

//ole_browser2.Visible = True
//ole_browser2.object.RegisterAsBrowser = True
//ppDisp =ole_browser2.object
end event

event navigatecomplete2(oleobject pdisp, any url);//code to enable back button

end event

type gb_facility from groupbox within w_namsspass
integer x = 37
integer y = 204
integer width = 905
integer height = 160
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Facility"
end type

event constructor;//BEGIN---Delete by Evan 09/19/2008
/*
IF gs_cust_type = "C" THEN
	This.Text = 'Client'
ELSEIF gs_cust_type = "I" THEN
	This.Text = 'Payor/Hospital'
END IF
*/
//BEGIN---Delete by Evan 09/19/2008
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
06w_namsspass.bin 
2A00000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000a4190e5001d3491600000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f00000000a4190e5001d34916a4190e5001d34916000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
26ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c00000d06000008c90000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c00000d06000008c90000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
16w_namsspass.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
