$PBExportHeader$w_api_setup_export.srw
forward
global type w_api_setup_export from window
end type
type dw_list from datawindow within w_api_setup_export
end type
type dw_resp from datawindow within w_api_setup_export
end type
type dw_res_hdr from datawindow within w_api_setup_export
end type
type dw_res_body from datawindow within w_api_setup_export
end type
type cb_import from commandbutton within w_api_setup_export
end type
type st_3 from statictext within w_api_setup_export
end type
type st_1 from statictext within w_api_setup_export
end type
type dw_req_body from datawindow within w_api_setup_export
end type
type dw_req_hdr from datawindow within w_api_setup_export
end type
type dw_inout from datawindow within w_api_setup_export
end type
type st_2 from statictext within w_api_setup_export
end type
type dw_main from datawindow within w_api_setup_export
end type
type dw_req from datawindow within w_api_setup_export
end type
type cb_2 from commandbutton within w_api_setup_export
end type
type gb_3 from groupbox within w_api_setup_export
end type
end forward

global type w_api_setup_export from window
integer x = 1056
integer y = 484
integer width = 3035
integer height = 976
boolean titlebar = true
string title = "Import API Setup"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
long backcolor = 33551856
dw_list dw_list
dw_resp dw_resp
dw_res_hdr dw_res_hdr
dw_res_body dw_res_body
cb_import cb_import
st_3 st_3
st_1 st_1
dw_req_body dw_req_body
dw_req_hdr dw_req_hdr
dw_inout dw_inout
st_2 st_2
dw_main dw_main
dw_req dw_req
cb_2 cb_2
gb_3 gb_3
end type
global w_api_setup_export w_api_setup_export

type variables
String is_app_path
String is_app_path_only
boolean ib_hdr
boolean ib_links
boolean ib_steps
boolean ib_extract
boolean ib_comp
n_cst_filesrvwin32 inv_filesrv
end variables

forward prototypes
public subroutine of_import_code ()
public function integer of_delete_existing (integer ai_webapi[])
end prototypes

public subroutine of_import_code ();////code not being used; was original trapping for existing records
//
//datawindow ldw_imp
//
//integer r
//integer res
//long org_id[]
//long new_id[]
//long ll_max
//long rec_org
//long i
//long ic
//long w
//string ls_path
//string ls_file
//
//select Max(wc_id) into :ll_max from wc_hdr;
//
//ls_path = gs_temp_path
//r = GetFolder ( "Browse to folder where the import files are.", ls_path )
//if r = 0 then return //cancel
//if MidA(ls_path,LenA(ls_path),1) <> "\" then ls_path += "\"
//
//for r = 1 to 5 //for each datawindow
//	choose case r
//		case 1
//			ldw_imp = dw_hdr
//			ls_file = "wc_hdr_imp.txt"
//		case 2
//			ldw_imp = dw_ent_link
//			ls_file = "wc_ent_imp.txt"
//		case 3
//			ldw_imp = dw_steps
//			ls_file = "wc_stp_imp.txt"
//		case 4
//			ldw_imp = dw_step_comp
//			ls_file = "wc_stpcomp_imp.txt"
//		case 5
//			ldw_imp = dw_web_comp
//			ls_file = "wc_webcomp_imp.txt"
//	end choose
//	ls_file = ls_path + ls_file
//	if not fileexists(ls_file) then
//		messagebox("Import Failure","Unable to find file " + ls_file )
//		return
//	end if
//	res = ldw_imp.importfile( ls_file )
//	if res < 1 then
//		messagebox("Import Failure","Unable to Import file " + ls_file )
//		return
//	end if
//	ic = ldw_imp.rowcount()
//	ldw_imp.sort()
//	for i = 1 to ic //list of imported records
//		rec_org = ldw_imp.getitemnumber(i,"wc_id")
//		if r = 1 then //the header dw get and set the crawler id
//			org_id[i] = rec_org
//			ll_max++
//			new_id[i] = ll_max
//			ldw_imp.setitem(i,"wc_id",ll_max)
//		else //all the child data
//			for w = 1 to upperbound(org_id) // if match to the org id chnage to the new id
//				if rec_org = org_id[w] then
//					ldw_imp.setitem(i,"wc_id",new_id[w])
//					exit
//				end if
//			next //orgid
//		end if
//	next //record
//	if ldw_imp.update() < 1 then //save failure
//		messagebox("Import Failure","Update failure in dw_" + string(r) )
//		rollback using sqlca;
//		return
//	end if
//	
//next //case
//
//commit using sqlca;
end subroutine

public function integer of_delete_existing (integer ai_webapi[]);

datawindow ldw_imp

integer r
integer res
long org_id[]
long new_id[]
long ll_max
long rec_org
long i
long ic
long w



for r = 1 to 8 //for each datawindow
	choose case r
		case 1
			ldw_imp = dw_main
		case 2
			ldw_imp = dw_req
		case 3
			ldw_imp = dw_inout
		case 4
			ldw_imp = dw_req_hdr
		case 5
			ldw_imp = dw_req_body
		case 6
			ldw_imp = dw_resp
		case 7
			ldw_imp = dw_res_hdr
		case 8
			ldw_imp = dw_res_body
	end choose
	
	ic = ldw_imp.retrieve(ai_webapi[])
	
	for w = 1 to ic
		ldw_imp.deleterow(1)
	next

next 

dw_inout.update()
dw_req_body.update()
dw_req_hdr.update()
dw_res_body.update()
dw_res_hdr.update()
dw_resp.update()
dw_req.update()
dw_main.update()

return 1

end function

on w_api_setup_export.create
this.dw_list=create dw_list
this.dw_resp=create dw_resp
this.dw_res_hdr=create dw_res_hdr
this.dw_res_body=create dw_res_body
this.cb_import=create cb_import
this.st_3=create st_3
this.st_1=create st_1
this.dw_req_body=create dw_req_body
this.dw_req_hdr=create dw_req_hdr
this.dw_inout=create dw_inout
this.st_2=create st_2
this.dw_main=create dw_main
this.dw_req=create dw_req
this.cb_2=create cb_2
this.gb_3=create gb_3
this.Control[]={this.dw_list,&
this.dw_resp,&
this.dw_res_hdr,&
this.dw_res_body,&
this.cb_import,&
this.st_3,&
this.st_1,&
this.dw_req_body,&
this.dw_req_hdr,&
this.dw_inout,&
this.st_2,&
this.dw_main,&
this.dw_req,&
this.cb_2,&
this.gb_3}
end on

on w_api_setup_export.destroy
destroy(this.dw_list)
destroy(this.dw_resp)
destroy(this.dw_res_hdr)
destroy(this.dw_res_body)
destroy(this.cb_import)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.dw_req_body)
destroy(this.dw_req_hdr)
destroy(this.dw_inout)
destroy(this.st_2)
destroy(this.dw_main)
destroy(this.dw_req)
destroy(this.cb_2)
destroy(this.gb_3)
end on

type dw_list from datawindow within w_api_setup_export
integer y = 368
integer width = 2944
integer height = 436
integer taborder = 50
string title = "none"
string dataobject = "d_webapi_main_exp_list"
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

type dw_resp from datawindow within w_api_setup_export
integer x = 823
integer y = 1684
integer width = 475
integer height = 284
integer taborder = 100
string title = "none"
string dataobject = "d_webapi_resp_exp_imp"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_res_hdr from datawindow within w_api_setup_export
integer x = 1307
integer y = 1632
integer width = 430
integer height = 336
integer taborder = 100
string dataobject = "d_webapi_resp_hdr_exp_imp"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_res_body from datawindow within w_api_setup_export
integer x = 1769
integer y = 1628
integer width = 471
integer height = 284
integer taborder = 110
string title = "none"
string dataobject = "d_webapi_resp_body_exp_imp"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cb_import from commandbutton within w_api_setup_export
integer x = 1888
integer y = 32
integer width = 475
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Export Data"
end type

event clicked;datawindow ldw_imp

integer r
integer res
long org_id[]
long new_id[]
long ll_max
long rec_org
long i
long ic
long w
string ls_path
string ls_file
String ls_txt
long ec
Long ll_file
integer f
integer te
integer cn
boolean lb_imp
n_cst_string lnv_string

 inv_filesrv = create n_cst_filesrvwin32

ls_path = gs_temp_path

ls_path+= "API\"
//messagebox("", ls_path)

IF NOT inv_filesrv.of_DirectoryExists (ls_path) THEN  inv_filesrv.of_CreateDirectory (ls_path)

destroy inv_filesrv

if MidA(ls_path,LenA(ls_path),1) <> "\" then ls_path += "\"

dw_list.accepttext()

for r = 1 to dw_list.rowcount()
	if dw_list.getitemnumber(r,"selected") = 1 then
		org_id[r] = dw_list.getitemnumber(r,"webapi_id")
	end if
next

debugbreak()
for r = 1 to 8 //for each datawindow
	choose case r
		case 1
			lb_imp = true  //always import the header even if they won't be updated
			ldw_imp = dw_main
			ls_file = "api_imp_main.txt" //change from api_main_imp.txt to api_imp_main.txt, Modified  by Appeon long.zhang 05.25.2016
		case 2
			ldw_imp = dw_req
			//continue	
			ls_file = "api_imp_req.txt"
		case 3
			ldw_imp = dw_inout
			ls_file = "api_imp_inout.txt"
		case 4
			ldw_imp = dw_req_hdr
			ls_file = "api_imp_req_hdr.txt"
		case 5
			ldw_imp = dw_req_body
			ls_file = "api_imp_req_body.txt"
		case 6
			ldw_imp = dw_resp
			ls_file = "api_imp_resp.txt"
		case 7
			ldw_imp = dw_res_hdr
			ls_file = "api_imp_res_hdr.txt"
		case 8
			ldw_imp = dw_res_body
			ls_file = "api_imp_res_body.txt"
	end choose

	ls_file = ls_path + ls_file
	ldw_imp.retrieve(org_id[])
	ldw_imp.saveas( ls_file, text! , False)
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 08.24.2016
	//<$>reason: Add aditional logic in web version for double quotation marks (Bug id 5297 - Getting errors setting up API for AMA)
	If AppeonGetClientType() = "WEB" then
		//Read string to ls_txt		
		ll_file = FileOpen(ls_file, TextMode!)
		
		If ll_file > 0 Then
			FileReadEx ( ll_file, ls_txt )
			FileClose(ll_file)
			
			//Write
			ll_file = FileOpen(ls_file, TextMode!, Write!, LockReadWrite!, Replace! )
			If ll_file > 0 Then
				//Replace all  double quotation marks
				ls_txt = lnv_string.of_globalreplace( ls_txt,'"', '"""')
				//ReWrite ls_txt to text file
				FileWriteEx( ll_file, ls_txt)
				
				//File Close
				FileClose(ll_file)
			End If
		End If
	End If
	//------------------- APPEON END -------------------
next //case

messagebox("","Export Complete")






end event

type st_3 from statictext within w_api_setup_export
integer x = 41
integer y = 152
integer width = 1531
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "2) Click Export Data"
boolean focusrectangle = false
end type

type st_1 from statictext within w_api_setup_export
integer x = 41
integer y = 212
integer width = 1531
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "3) The Files will be saved in the IntelliCred/API folder"
boolean focusrectangle = false
end type

type dw_req_body from datawindow within w_api_setup_export
integer x = 1280
integer y = 1320
integer width = 471
integer height = 284
integer taborder = 100
string dataobject = "d_webapi_req_body_exp_imp"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_req_hdr from datawindow within w_api_setup_export
integer x = 841
integer y = 1324
integer width = 430
integer height = 336
integer taborder = 90
string dataobject = "d_webapi_req_hdr_exp_imp"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_inout from datawindow within w_api_setup_export
integer x = 73
integer y = 1956
integer width = 677
integer height = 284
integer taborder = 90
string title = "none"
string dataobject = "d_webapi_inout_exp_imp"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type st_2 from statictext within w_api_setup_export
integer x = 37
integer y = 84
integer width = 1531
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "1) Select the APIs to copy"
boolean focusrectangle = false
end type

type dw_main from datawindow within w_api_setup_export
integer x = 78
integer y = 1312
integer width = 686
integer height = 336
integer taborder = 80
string dataobject = "d_webapi_main_exp_imp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_req from datawindow within w_api_setup_export
integer x = 78
integer y = 1664
integer width = 681
integer height = 284
integer taborder = 90
string dataobject = "d_webapi_req_main_exp_imp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cb_2 from commandbutton within w_api_setup_export
integer x = 2427
integer y = 32
integer width = 475
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

event clicked;Close(Parent)
end event

type gb_3 from groupbox within w_api_setup_export
integer y = 8
integer width = 1655
integer height = 324
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 33551856
string text = "Export API setup data"
end type

