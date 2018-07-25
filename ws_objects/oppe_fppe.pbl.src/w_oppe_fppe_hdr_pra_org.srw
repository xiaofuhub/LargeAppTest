$PBExportHeader$w_oppe_fppe_hdr_pra_org.srw
forward
global type w_oppe_fppe_hdr_pra_org from window
end type
type cb_upload from commandbutton within w_oppe_fppe_hdr_pra_org
end type
type tab_1 from tab within w_oppe_fppe_hdr_pra_org
end type
type tabpage_1 from userobject within tab_1
end type
type dw_detail from datawindow within tabpage_1
end type
type dw_browse from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_detail dw_detail
dw_browse dw_browse
end type
type tabpage_2 from userobject within tab_1
end type
type ole_excel from olecontrol within tabpage_2
end type
type ole_image from olecontrol within tabpage_2
end type
type ole_pdf from olecontrol within tabpage_2
end type
type ole_word from olecontrol within tabpage_2
end type
type dw_docs from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
ole_excel ole_excel
ole_image ole_image
ole_pdf ole_pdf
ole_word ole_word
dw_docs dw_docs
end type
type tab_1 from tab within w_oppe_fppe_hdr_pra_org
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type rb_all_type from radiobutton within w_oppe_fppe_hdr_pra_org
end type
type rb_his from radiobutton within w_oppe_fppe_hdr_pra_org
end type
type rb_cur from radiobutton within w_oppe_fppe_hdr_pra_org
end type
type rb_all_stat from radiobutton within w_oppe_fppe_hdr_pra_org
end type
type rb_fppe from radiobutton within w_oppe_fppe_hdr_pra_org
end type
type rb_oppe from radiobutton within w_oppe_fppe_hdr_pra_org
end type
type cb_add from commandbutton within w_oppe_fppe_hdr_pra_org
end type
type cb_delete from commandbutton within w_oppe_fppe_hdr_pra_org
end type
type cb_close from commandbutton within w_oppe_fppe_hdr_pra_org
end type
type cb_save from commandbutton within w_oppe_fppe_hdr_pra_org
end type
type gb_1 from groupbox within w_oppe_fppe_hdr_pra_org
end type
type gb_2 from groupbox within w_oppe_fppe_hdr_pra_org
end type
end forward

global type w_oppe_fppe_hdr_pra_org from window
integer width = 3611
integer height = 2280
boolean titlebar = true
string title = "OPPE/FPPE Data"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_upload cb_upload
tab_1 tab_1
rb_all_type rb_all_type
rb_his rb_his
rb_cur rb_cur
rb_all_stat rb_all_stat
rb_fppe rb_fppe
rb_oppe rb_oppe
cb_add cb_add
cb_delete cb_delete
cb_close cb_close
cb_save cb_save
gb_1 gb_1
gb_2 gb_2
end type
global w_oppe_fppe_hdr_pra_org w_oppe_fppe_hdr_pra_org

type variables
long il_prac
long il_hdr_id
integer il_parent
string is_stat_filter
string is_type_filter
string is_document_path
datawindow idw_browse
datawindow idw_detail
datawindow idw_docs

pfc_cst_nv_image_functions  inv_image_functions
end variables

forward prototypes
public function integer of_filter ()
public function integer of_add_document ()
public function integer of_view_document (string as_ext, long al_record)
public function integer of_construct_document ()
end prototypes

public function integer of_filter ();string ls_filter

if LenA(is_stat_filter  ) > 0 then
	ls_filter = is_stat_filter
	if LenA(is_type_filter) > 0 then
		ls_filter = ls_filter + " and " + is_type_filter
	end if
else
	if LenA(is_type_filter) > 0 then ls_filter = is_type_filter
end if

idw_browse.setfilter(ls_filter)
idw_browse.filter()
idw_detail.setfilter(ls_filter)
idw_detail.filter()

//Start Code Change ----08.13.2009 #V92 maha
idw_browse.selectrow(0,false)
idw_browse.selectrow(idw_browse.getrow() ,true)
//End Code Change---08.13.2009

return 1
end function

public function integer of_add_document ();string ls_fullname, ls_name
string ls_ext
integer value
integer li_ret
integer nr
long li_rec

Value = GetFileOpenName("Select File", &
	+ ls_fullname, ls_name, "TIF", &
	+ "TIFF Files (*.tif),*.tif," &
	+ "Bitmap Files (*.bmp),*.bmp," &
	+ "JPG Files (*.jpg),*.jpg," &
	+ "PDF Files (*.pdf),*.pdf," &
	+ "Word Documents(*.doc),*.doc," &
	+ "Excel Files (*.xls),*.xls" 	)   
	
ls_ext = Upper(RightA(Trim(ls_fullname),4)) 

select max(dcmt_id) into :li_rec from pd_oppe_docs;
if isnull(li_rec) then li_rec = 0
li_rec++

nr = tab_1.tabpage_2.dw_docs.insertrow(0)
tab_1.tabpage_2.dw_docs.setitem(nr,"dcmt_id",li_rec)
tab_1.tabpage_2.dw_docs.setitem(nr,"file_name",ls_name )
tab_1.tabpage_2.dw_docs.setitem(nr,"file_type",ls_ext)
tab_1.tabpage_2.dw_docs.setitem(nr,"oppe_hdr_id",il_hdr_id)
tab_1.tabpage_2.dw_docs.setitem(nr,"prac_id",il_prac)
tab_1.tabpage_2.dw_docs.setitem(nr,"facility_id",il_parent)
tab_1.tabpage_2.dw_docs.setitem(nr,"add_date",datetime(today(),now()))
tab_1.tabpage_2.dw_docs.setitem(nr,"add_user",gs_user_id )
tab_1.tabpage_2.dw_docs.update()
tab_1.tabpage_2.dw_docs.setrow(nr)
debugbreak()
if of_upload_doc_data("OPPE", ls_fullname,"",li_rec) = 1 then
	tab_1.tabpage_2.dw_docs.setitem(nr,"flen",10 ) //Start Code Change ----08.13.2009 #V92 maha - added to show the checkmark as green
end if

tab_1.tabpage_2.dw_docs.setfocus( )

RETURN 1








end function

public function integer of_view_document (string as_ext, long al_record);string ls_file
blob ib_data




ls_file = is_document_path + "view_document." + as_ext

ib_data = of_download_file("OPPE","", al_record)

if isnull(ib_data) then
	messagebox("File Download","There is no document data associated with this record.")
	return -1
end if












return 1
end function

public function integer of_construct_document ();//n_appeon_storage_area lnv_storage_area
//Long ll_row, ll_area_row
//Long ll_area_id
//String ls_doc_name
//String ls_doc_path
//String ls_full_name
//String ls_Null
//Integer li_rtn
//
//if this.Enabled = False then return -2;
//SetNull( ls_Null )
//
//ll_area_row = dw_storage_area.GetSelectedrow( 0 )
//ll_row = dw_storage_docs.GetSelectedrow( 0 )
//IF ll_row = 0 THEN RETURN -2
//
//ll_area_id = dw_storage_docs.GetItemNumber(ll_row, "area_id")
//ls_doc_name = dw_storage_docs.GetItemString(ll_row, "doc_name")
//ls_doc_path = dw_storage_area.GetItemString(ll_area_row, "area_doc_path")
//ls_full_name = ls_doc_path + ls_doc_name
//
//IF LEN(ls_full_name) > 0 THEN
//		
//	// Create directory
//	n_appeon_download lnv_download
//	lnv_download.of_parsepath( ls_doc_path )
//
//	// Open process window
//	OpenWithParm( w_appeon_gifofwait, "Downloading document from database...")
//
//	li_rtn = lnv_storage_area.of_download_file( ll_area_id, ls_doc_name, ls_full_name)
//	
//	// Clsoe process window
//	IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
//	
//	IF li_rtn < 0 THEN
//		IF li_rtn = -2 THEN Messagebox("View document","The document does not exist in the database!")
//		RETURN -2
//	END IF
//
//	IF FileExists(ls_full_name) THEN
//		ShellExecuteA ( Handle( This ), "open", ls_full_name, ls_Null, ls_Null, 1)
//	END IF
//END IF
//
return 1
end function

on w_oppe_fppe_hdr_pra_org.create
this.cb_upload=create cb_upload
this.tab_1=create tab_1
this.rb_all_type=create rb_all_type
this.rb_his=create rb_his
this.rb_cur=create rb_cur
this.rb_all_stat=create rb_all_stat
this.rb_fppe=create rb_fppe
this.rb_oppe=create rb_oppe
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_close=create cb_close
this.cb_save=create cb_save
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cb_upload,&
this.tab_1,&
this.rb_all_type,&
this.rb_his,&
this.rb_cur,&
this.rb_all_stat,&
this.rb_fppe,&
this.rb_oppe,&
this.cb_add,&
this.cb_delete,&
this.cb_close,&
this.cb_save,&
this.gb_1,&
this.gb_2}
end on

on w_oppe_fppe_hdr_pra_org.destroy
destroy(this.cb_upload)
destroy(this.tab_1)
destroy(this.rb_all_type)
destroy(this.rb_his)
destroy(this.rb_cur)
destroy(this.rb_all_stat)
destroy(this.rb_fppe)
destroy(this.rb_oppe)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;string s
integer p

s = message.stringparm
p = PosA(s,"*",1)
il_prac = long(MidA(s,1, p - 1))
il_parent = long(MidA(s, p + 1))

idw_browse = tab_1.tabpage_1.dw_browse
idw_detail = tab_1.tabpage_1.dw_detail
idw_docs = tab_1.tabpage_2.dw_docs

idw_browse.retrieve(il_prac, il_parent)
idw_detail.retrieve(il_prac, il_parent)

is_document_path = gs_temp_path + "temp\oppe\"
end event

type cb_upload from commandbutton within w_oppe_fppe_hdr_pra_org
integer x = 1797
integer y = 48
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "View Doc"
end type

event clicked;string ls_fullname, ls_name
string ls_ext
integer value
string ls_file_name
integer li_ret
integer nr
long li_rec

Value = GetFileOpenName("Select File", &
	+ ls_fullname, ls_name, "TIF", &
	+ "TIFF Files (*.tif),*.tif," &
	+ "Bitmap Files (*.bmp),*.bmp," &
	+ "JPG Files (*.jpg),*.jpg," &
	+ "PDF Files (*.pdf),*.pdf," &
	+ "Word Documents(*.doc),*.doc," &
	+ "Excel Files (*.xls),*.xls" 	)   
	
ls_ext = Upper(RightA(Trim(ls_fullname),4)) 

select max(dcmt_id) into :li_rec from pd_oppe_docs;
if isnull(li_rec) then li_rec = 0
li_rec++

nr = tab_1.tabpage_2.dw_docs.insertrow(0)
tab_1.tabpage_2.dw_docs.setitem(nr,"dcmt_id",li_rec)
tab_1.tabpage_2.dw_docs.setitem(nr,"file_name",ls_name )
tab_1.tabpage_2.dw_docs.setitem(nr,"file_type",ls_ext)
tab_1.tabpage_2.dw_docs.setitem(nr,"oppe_hdr_id",il_hdr_id)
tab_1.tabpage_2.dw_docs.setitem(nr,"prac_id",il_prac)
tab_1.tabpage_2.dw_docs.setitem(nr,"facility_id",il_parent)
tab_1.tabpage_2.dw_docs.setitem(nr,"add_date",datetime(today(),now()))
tab_1.tabpage_2.dw_docs.setitem(nr,"add_user",gs_user_id )
tab_1.tabpage_2.dw_docs.update()

of_upload_doc_data("OPPE", ls_file_name,"",li_rec) //app function

RETURN 1
end event

type tab_1 from tab within w_oppe_fppe_hdr_pra_org
event create ( )
event destroy ( )
integer x = 9
integer y = 172
integer width = 3557
integer height = 1960
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;if tab_1.tabpage_1.dw_browse.rowcount() > 0 then
	il_hdr_id =tab_1.tabpage_1.dw_browse.getitemnumber(tab_1.tabpage_1.dw_browse.getrow(),"pd_oppe_hdr_id") 
end if

if newindex = 2 then
	tab_1.tabpage_2.dw_docs.retrieve(il_hdr_id)
end if
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3520
integer height = 1844
long backcolor = 67108864
string text = "Evaluations"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_detail dw_detail
dw_browse dw_browse
end type

on tabpage_1.create
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.Control[]={this.dw_detail,&
this.dw_browse}
end on

on tabpage_1.destroy
destroy(this.dw_detail)
destroy(this.dw_browse)
end on

type dw_detail from datawindow within tabpage_1
integer x = 18
integer y = 1180
integer width = 3474
integer height = 640
integer taborder = 30
boolean titlebar = true
string title = "Detail"
string dataobject = "d_oppe_fppe_prac_detail"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type dw_browse from datawindow within tabpage_1
integer x = 18
integer y = 12
integer width = 3474
integer height = 1164
integer taborder = 20
boolean titlebar = true
string title = "Browse"
string dataobject = "d_oppe_fppe_prac_browse"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

event clicked;integer r

r = this.getclickedrow()

end event

event rowfocuschanged;integer r

r = currentrow
this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)

//r = tab_1.tabpage_1.dw_detail.find("",1,tab_1.tabpage_1.dw_detail..rowcount())

if r > 0 then 
	tab_1.tabpage_1.dw_detail.setrow(r)
	tab_1.tabpage_1.dw_detail.scrolltorow(r)
end if
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3520
integer height = 1844
long backcolor = 67108864
string text = "Documentation"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
ole_excel ole_excel
ole_image ole_image
ole_pdf ole_pdf
ole_word ole_word
dw_docs dw_docs
end type

on tabpage_2.create
this.ole_excel=create ole_excel
this.ole_image=create ole_image
this.ole_pdf=create ole_pdf
this.ole_word=create ole_word
this.dw_docs=create dw_docs
this.Control[]={this.ole_excel,&
this.ole_image,&
this.ole_pdf,&
this.ole_word,&
this.dw_docs}
end on

on tabpage_2.destroy
destroy(this.ole_excel)
destroy(this.ole_image)
destroy(this.ole_pdf)
destroy(this.ole_word)
destroy(this.dw_docs)
end on

type ole_excel from olecontrol within tabpage_2
event queryinterface ( oleobject riid,  ref pointer ppvobj )
event addref ( )
event release ( )
event selectionchange ( oleobject target )
event beforedoubleclick ( oleobject target,  ref boolean cancel )
event beforerightclick ( oleobject target,  ref boolean cancel )
event activate ( )
event deactivate ( )
event calculate ( )
event change ( oleobject target )
event followhyperlink ( oleobject target )
event pivottableupdate ( oleobject target )
integer x = 969
integer y = 804
integer width = 2057
integer height = 688
integer taborder = 40
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_oppe_fppe_hdr_pra_org.win"
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

type ole_image from olecontrol within tabpage_2
event fitmodechanged ( )
event scalechanged ( )
event selectionchanged ( )
event pagechanged ( )
event pagecountchanged ( )
event curpagenumchanged ( )
event visiblerectchanged ( )
integer x = 9
integer y = 1388
integer width = 3365
integer height = 248
integer taborder = 40
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_oppe_fppe_hdr_pra_org.win"
integer binaryindex = 1
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

type ole_pdf from olecontrol within tabpage_2
integer x = 14
integer y = 944
integer width = 3291
integer height = 432
integer taborder = 40
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_oppe_fppe_hdr_pra_org.win"
integer binaryindex = 2
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

type ole_word from olecontrol within tabpage_2
integer x = 14
integer y = 484
integer width = 3429
integer height = 452
integer taborder = 30
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_oppe_fppe_hdr_pra_org.win"
integer binaryindex = 3
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

type dw_docs from datawindow within tabpage_2
integer x = 9
integer y = 8
integer width = 3497
integer height = 464
integer taborder = 30
boolean titlebar = true
string title = "Evaluation Documents"
string dataobject = "d_oppe_prac_documents"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

event constructor;this.settransobject(sqlca)
end event

type rb_all_type from radiobutton within w_oppe_fppe_hdr_pra_org
integer x = 901
integer y = 60
integer width = 192
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "All"
boolean checked = true
end type

event clicked;is_type_filter = ""

of_filter()
end event

type rb_his from radiobutton within w_oppe_fppe_hdr_pra_org
integer x = 512
integer y = 64
integer width = 265
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "History"
end type

event clicked;is_stat_filter = "active_status = 0"
of_filter()

end event

type rb_cur from radiobutton within w_oppe_fppe_hdr_pra_org
integer x = 224
integer y = 64
integer width = 302
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Current"
end type

event clicked;is_stat_filter = "active_status = 1"
of_filter()


end event

type rb_all_stat from radiobutton within w_oppe_fppe_hdr_pra_org
integer x = 46
integer y = 64
integer width = 210
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "All"
boolean checked = true
end type

event clicked;is_stat_filter = ""
of_filter()
end event

type rb_fppe from radiobutton within w_oppe_fppe_hdr_pra_org
integer x = 1390
integer y = 60
integer width = 242
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "FPPE"
end type

event clicked;is_type_filter = "oppe_fppe = 'FPPE'"

of_filter()
end event

type rb_oppe from radiobutton within w_oppe_fppe_hdr_pra_org
integer x = 1125
integer y = 60
integer width = 261
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "OPPE"
end type

event clicked;is_type_filter = "oppe_fppe = 'OPPE'"

of_filter()
end event

type cb_add from commandbutton within w_oppe_fppe_hdr_pra_org
integer x = 2149
integer y = 48
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;integer nr

if tab_1.selectedtab = 1 then
	nr = idw_detail.insertrow(0)
	idw_detail.scrolltorow(nr)
else
	of_add_document( )
end if
end event

type cb_delete from commandbutton within w_oppe_fppe_hdr_pra_org
integer x = 2505
integer y = 48
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Delete"
end type

event clicked;//delete message
//delete record
//delete documents
end event

type cb_close from commandbutton within w_oppe_fppe_hdr_pra_org
integer x = 3214
integer y = 48
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_save from commandbutton within w_oppe_fppe_hdr_pra_org
integer x = 2857
integer y = 48
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;idw_detail.update()
end event

type gb_1 from groupbox within w_oppe_fppe_hdr_pra_org
integer x = 859
integer y = 4
integer width = 809
integer height = 148
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Type"
end type

type gb_2 from groupbox within w_oppe_fppe_hdr_pra_org
integer x = 14
integer y = 4
integer width = 837
integer height = 148
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Status"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
01w_oppe_fppe_hdr_pra_org.bin 
2200001c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000007fffffffe00000004000000050000000600000008fffffffe000000090000000a0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000020002082000000000000000c04600000000000000000000000000000073e41fb001cf32c5000000030000108000000000004f00010065006c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000102000affffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000140000000000430001006d006f004f0070006a0062000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010200120000000100000004ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000010000006d00000000006f0057006b0072006f0062006b006f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000068600000000fffffffe00000002fffffffe0000000400000005000000060000000700000008000000090000000a0000000b0000000c0000000d0000000e0000000f000000100000001100000012000000130000001400000015000000160000001700000018000000190000001a0000001b0000001c0000001dfffffffe0000001f000000200000002100000022000000230000002400000025000000260000002700000028000000290000002a0000002b0000002c0000002d0000002e0000002f000000300000003100000032000000330000003400000035000000360000003700000038fffffffe0000003a0000003b0000003cfffffffe0000003e0000003f0000004000000041fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
27ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff02000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffe000100000a03ffffffff0002082000000000000000c046000000000000217263694d666f736f664f2074656369666378452057206c65736b726f7465656800000600666942000e003866450000006c6563786568532e382e7465b239f4000000007100000000000000000000000000000000000000000000000000000000001008090005060007cd18d30000c0c100000306000200e100c104b000000002000000e20070005c7500000531726573202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202000020042016104b000000002000001c00002013d009c0001000e0002000800de0000000c060000090002001900120000000000020002001301af000000000002000201bc003d0000007800124a4c005a00383273000000000258000100020040008d00000000000200020022000e000000010002000201b700da000000000002001a0031000000c801907fff000000000105800000720041006100690031006c00c8001a7fff000000000190800000000041010500690072006c0061001a0031000000c801907fff000000000105800000720041006100690031006c00c8001a7fff000000000190800000000041010500690072006c0061001c041e001700052224220023232c233b295f302422285c232c2322295c30230021041e001c00062224220023232c233b295f306465525b22285c5d2c2322245c30232322041e291d00070024220000232c2322302e30233b295f302422285c232c2322302e30231e295c300800270400002200232224223023232c5f30302e525b3b295c5d64652224222823232c2330302e30041e295c002a00375f000032222422282c23202a5f302323285f3b292a22242223285c203023232c5f3b295c222422282d22202a3b295f225f40285f2e041e2929002900285f00002c23202a5f302323285f3b29285c202a23232c233b295c30202a285f5f222d22285f3b291e295f402c003f0400003a002422285f23202a223023232c5f30302e285f3b292a22242223285c203023232c5c30302e285f3b292a222422222d2220295f3f3f40285f3b041e295f002b00365f00003123202a283023232c5f30302e285f3b29285c202a23232c2330302e305f3b295c22202a283f3f222d5f3b295f295f4028001400e0000000000020fff5000000000000000020c00000001400e0000000010020fff50000f4000000000020c00000001400e0000000010020fff50000f4000000000020c00000001400e0000000020020fff50000f4000000000020c00000001400e0000000020020fff50000f4000000000020c00000001400e0000000000020fff50000f4000000000020c00000001400e0000000000020fff50000f4000000000020c00000001400e0000000000020fff50000f4000000000020c00000001400e0000000000020fff50000f4000000000020c00000001400e0000000000020fff50000f4000000000020c00000001400e0000000000020fff50000f4000000000020c00000001400e0000000000020fff50000f4000000000020c00000001400e0000000000020fff50000f4000000000020c00000001400e0000000000020fff50000f4000000000020c00000001400e0000000000020fff50000f4000000000020c00000001400e00000000000200001000000000000000020c00000001400e0002b00010020fff50000f8000000000020c00000001400e0002900010020fff50000f8000000000020c00000001400e0002c00010020fff50000f8000000000020c00000001400e0002a00010020fff50000f8000000000020c00000001400e0000900010020fff50000f8000000000020c0000000040293ff03801000040293ff06801100040293ff04801200040293ff07801300040293ff00800000040293ff05801400020160008500000593000e0000000068530006317465650004008c00010001000801c1000001c10001be22000800fc0000000000000000000200ff0863000808630015000000000000000000150000000000000aea00000900000000001008d3001006c107cd18060000c00d0000030100020002000c000f006400010002000200110010000000fc0008004dd2f1a95f3f50620100020002002a002b000000000002000200820080000100000008000000000025000000000004028100ff00c100020000001404000015000200830084000000000002002200a100ff00000001000100040001000000000000000000e00000000000003fe00000005500003f080002000e0200000000000001000000000000003e000000b6001202000000060000400000000000000000000f001d0000000300000000000000000100000000000600ef00370000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffff000000030000000400000001ffffffff
2C000000020000000000002e68000011ac0000066a0009000103350300000400000000000c000400000103000000050008020b0000000000000000000500ac020c000501c2020900000000000000000005ffff0201000400ff010400000004000d0102000000030002001e0000004f00020065006c0072005000730065003000300000003000000000000000000000000000000000000000000000000000000000000000000000000000000000000200180000000300000005ffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000001e000006ac0000000000530005006d00750061006d00790072006e0049006f0066006d007200740061006f00690000006e00000000000000000000000000000000000000000000000001020028ffffffff00000006ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000039000000d000000000004400050063006f006d0075006e006500530074006d00750061006d00790072006e0049006f0066006d007200740061006f00690000006e000000000000000000020038ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000003d00000104000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004ffff0127000000030004001e012700000003ffff001e000000000005ffff0201000500ff020900000000000000000004ffff0127000000030005001e0201000000ffffff0000000500000209000700000416000001c100ab0000000000000004ffff0127000000030005001e0201000000ffffff0000000500000209000700000416000001c100ab0000000000000004ffff0127000000030005001e0201000000ffffff0000000500000209000700000416000001c100ab0001000100000004ffff0127000000030005001e0201000000ffffff0000000500000209000700000416000001c100ab0000000000000007000002fc00c0c0c000040000012d0000000500000209000000c0c0c000000005c0c00201000400c0010400000004000d010200000008000202fa000000000000c0c00000000400c0012d00000005000102140000000000000000000500000213000801c002fa0000000000000000000000040000012d0000000c00020940000000f000210000000000010000000001c000040000012d00000005000102140000000000110000000500110213000401c0012d0000000c00020940000000f000210000000000010000001101c000040000012d00000005000102140000000000220000000500220213000401c0012d0000000c00020940000000f000210000000000010000002201c000040000012d00000005000102140000000000330000000500330213000401c0012d0000000c00020940000000f000210000000000010000003301c000040000012d00000005000102140000000000440000000500440213000401c0012d0000000c00020940000000f000210000000000010000004401c000040000012d00000005000102140000000000550000000500550213000401c0012d0000000c00020940000000f000210000000000010000005501c000040000012d00000005000102140000000000660000000500660213000401c0012d0000000c00020940000000f000210000000000010000006601c000040000012d00000005000102140000000000770000000500770213000401c0012d0000000c00020940000000f000210000000000010000007701c000040000012d00000005000102140000000000880000000500880213000401c0012d0000000c00020940000000f000210000000000010000008801c000040000012d00000005000102140000000000990000000500990213000401c0012d0000000c00020940000000f000210000000000010000009901c000040000012d00000005000102140000000000aa0000000500aa0213000401c0012d0000000c00020940000000f00021000000000001000000aa01c000040000012d00000005000102140000000000000000000500ab021300040000012d0000000c00020940000000f000210000000000ab00000000000100040000012d00000005000102140000004000000000000500ab021300040040012d0000000c00020940000000f000210000000000ab00000000000100040040012d00000005000102140000008000000000000500ab021300040080012d0000000c00020940000000f000210000000000ab00000000000100040080012d0000000500010214000000c000000000000500ab0213000400c0012d0000000c00020940000000f000210000000000ab000000000001000400c0012d00000005000102140000010000000000000500ab021300040100012d0000000c00020940000000f000210000000000ab00000000000100040100012d00000005000102140000014000000000000500ab021300040140012d0000000c00020940000000f000210000000000ab00000000000100040140012d00000005000102140000018000000000000500ab0213
2B00040180012d0000000c00020940000000f000210000000000ab00000000000100040180012d0000000500010214000001c000000000000500ab0213000401c0012d0000000c00020940000000f000210000000000ab000000000001000701c002fc00000000000000000000000000040003012d00000004ffff0127000000030005001e0201000000c0c0c000000005c0c00209000700c00416000001c100ab0001000100000004ffff0127000000030000000000000000000000000000000000000000494e414e0000000000000000000000000000000000000000000000000000fffe000200050000000000000000000000000000000000000001f29f85e010684ff9000891abd9b3272b00000030000000a00000000700000001000000400000000400000048000000080000005800000012000000680000000c000000800000000d0000008c000000130000009800000002000004e40000001e0000000872657375000000310000001e0000000872657375000000310000001e000000107263694d666f736f78452074006c65630000004003e30c0001c9ffd8000000400514390001c9ffd800000003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffe000200050000000000000000000000000000000000000001d5cdd502101b2e9c00089793aef92c2b00000030000000d40000000900000001000000500000000f0000005800000017000000740000000b0000007c0000001000000084000000130000008c00000016000000940000000d0000009c0000000c000000af00000002000004e40000001e0000001465746e4953696c6c2074666f756f72470000007000000003000b18d80000000b000000000000000b000000000000000b000000000000000b000000000000101e0000000100000007656568530c003174020000101e0000000b00000057000000736b726f7465656800030073000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
28ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001ef347a6242e4ba210a1ca094e7df7f6d00000000000000000000000073e41fb001cf32c5000000030000008000000000004f00010065006c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000102000affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000001400000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000100000024000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0200000100000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000300000013d8000013d80000000300030000000000000000000300080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
27fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd0000000cfffffffefffffffe00000005000000060000000700000008000000090000000a0000000bfffffffefffffffe0000000e0000000f000000100000001100000012000000130000001400000015fffffffe0000001700000018000000190000001a0000001b0000001c0000001dfffffffe0000001f000000200000002100000022000000230000002400000025fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000020002090600000000000000c04600000000000000000000000000000073e41fb001cf32c5000000030000014000000000004f00010065006c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000102000affffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000140000000000540031006200610065006c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000102000e0000000100000004ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000004000010000000000000430001006d006f004f0070006a006200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000010000007100000000fffffffe00000002fffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff02000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffe000100000a03ffffffff0002090600000000000000c0460000000000001f7263694d666f736f664f207465636966726f57206f442064656d75630a00746e4d000000726f5753636f446400001000726f57006f442e64656d7563382e746eb239f40000000071000000000000000000000000000000000000000000000000ffffffff000000030000000400000001ffffffff000000020000000000003b88000001e70000002c0009000100160300000000000000000500050000020b0000000000000000000501e7020c00033b880000000000000000000000000000000000000000414e00000000494e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f028600010012000f009c000000040000000000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
21000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000400000400002fff1040c00400000000000000000004e00060072006f0061006d0000006c000000024a430018485f00184a610401486d0018487304094874040900000409000000000000000000000000000000004041004400a1fff2050c004400000000000000000044001600660065007500610074006c005000200072006100670061006100720068007000460020006e006f0000007400520000fff34069005200b30000050c00000000000c000000610054006c006200200065006f004e006d0072006c0061001c00000003f61706d63400030a0100d634006c0501000661000003000003f6000b000200280000fff4406b002800c1000005000000000000070000006f004e004c00200073006900000074000000020000000000000000000000011000000400000000ffffffff00000001000020040001ffff00997aa0000000000000000000000001000000000000000000000000000300000100000021c00000ac8d00000000000200030000c849000000003000000000000001000000000000000000000000000006000180080100000005000006000000080100000006000006000000080100000007000000010000000400000008000000e50000000000000000000079e8000040ff0046000180000000000000000000011b86140001000100000000000000000000000000000000000010020000000000000100000040000040001001ffff00070000006e0055006e006b0077006f00ff006e00080001ff0000000000000000ff000000000001ffff000000020000ff00ffff00ff000000020000ff00ffff000300000047000000000190160602020005040503870403020020007a0880000000000000ff00000000000001540000006d006900730065004e00200077006500520020006d006f006e00610035000000020190160105050006070102000705020000000000100000000000000000000000800000530000006d0079006f00620000006c0090263300020000010204060b02020202007a87040000002000000880000000000001ff0000000000720041006100690000006c000400220088083100d0f000186800000200000001d732df00d732df26000000260000010000000000000000000100000000000100030004000000011000000000000000000100010001000000000000000000000010f00000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0070800b400b4051281810000000034000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000010f00000000008000000000000000000000000000000000000000000000000004800000000000058fff009000100000fe400003fff000004ff7fffffff7fffffff7fffffff7fffffff7fffffff7fffffe87fffff00004679320000000000000000000000000000000000000012ffff0000000000000000000000000005000000730075007200650005003100730075007200650000003100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
23000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004f00020065006c0072005000730065003000300000003000000000
22000000000000000000000000000000000000000000000000000000000000000000000000000200180000000300000006ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000006e00000000006f005700640072006f0044007500630065006d0074006e000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000d0000102e0000000000530005006d00750061006d00790072006e0049006f0066006d007200740061006f00690000006e000000000000000000000000000000000000000000000000010200280000000500000007ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000160000100000000000004400050063006f006d0075006e006500530074006d00750061006d00790072006e0049006f0066006d007200740061006f00690000006e000000000000000000020038ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000001e000010000000000000c1a5ec0409607f12f00000000000bf100000000000000000000600000008016a62000e87e66a62000087e600000000000000000000000000000000001604090000102e0000ed840000ed840000000100000000000000000000000000000000000000000000000000000000000fffff0000000000000000000fffff0000000000000000000fffff00000000000000000000000000000000000000a403a400000000000003a4000003a400000000000003a400000000000003a400000000000003a400000000000003a4000000140000000000000000000003de00000014000004160000000000000416000000000000041600000000000004160000000c000004220000000c000003f200000000000004d7000000b60000043a000000000000043a000000000000043a000000000000043a000000000000043a000000000000043a000000000000043a000000000000043a0000000000000456000000020000045800000000000004580000000000000458000000000000045800000000000004580000000000000458000000240000058d00000268000007f50000003e0000047c0000001500000000000000000000000000000000000003a4000000000000043a00000000000000000000000000000000000000000000043a000000000000043a000000000000043a000000000000043a000000000000047c000000000000000000000000000003a400000000000003a4000000000000043a0000000000000000000000000000043a0000000000000491000000160000043a000000000000043a000000000000043a000000000000043a00000000000003a4000000000000043a00000000000003a4000000000000043a00000000000004560000000000000000000000000000043a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000043a00000000000004560000000000000000000000000000043a0000000000000000000000000000043a00000000000003a400000000000003a40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000043a000000000000043a000000000000042e0000000c000093900000fe4ed4c1000001c9000000000416000000000000043a000000000000043a0000000000000000000000000000045600000000000004a700000030000004d7000000000000043a0000000000000833000000000000043a0000000000000833000000000000043a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000833000000000000000000000000000003a4000000000000043a0000001c0000043a000000000000043a000000000000043a000000000000043a000000000000043a0000000000000000000000000000000000000000000000000000000000000000000000000000043a000000000000043a000000000000043a000000000000047c000000000000047c0000000000000000000000000000000000000000000000000000000000000000000000000000043a0000000000000000000000000000000000000000000000000000000000000000000000000000043a000000000000043a000000000000043a00000000000004d7000000000000043a000000000000043a000000000000043a000000000000043a000000000000000000000000000003f200000000000003f200000000000003f2000000240000041600000000000003f200000000000003f200000000000003f2000000000000041600000000000003b800000014000003cc0000000e000003da00000004000003a400000000000003a400000000000003a400000000000003a400000000000003a400000000000003a4000000000000ffff00000000ffff000200000000010c00000000000000000000000000000000000000000000000000000000000000000000000000000000
2700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000000801000000fc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e8681606010046790000060000000801000000fd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2A000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000010000000000060000000801000000fd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004040000010101009031002cb01f0168b0202fd0b0213de0b022070890230708902405a0b02505a0b0170000b01802d0900c02d0000002d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffe000200050000000000000000000000000000000000000001f29f85e010684ff9000891abd9b3272b000000300000016c000000110000000100000090000000020000009800000003000000a400000004000000b000000005000000c000000006000000cc00000007000000d800000008000000ec00000009000000fc00000012000001080000000a000001280000000c000001340000000d000001400000000e0000014c0000000f00000154000000100000015c000000130000016400000002000004e40000001e00000004000000000000001e00000004000000000000001e0000000872657375000000310000001e00000004000000000000001e00000004000000000000001e0000000c6d726f4e642e6c610000746f0000001e0000000872657375000000310000001e00000004000000310000001e000000187263694d666f736f664f207465636966726f57200000006400000040000000000000000000000040c3a4520001c9fe4e00000040c3a4520001c9fe4e000000030000000100000003000000000000000300000000000000030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
22000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffe000200050000000000000000000000000000000000000001d5cdd502101b2e9c00089793aef92c2b00000030000000f80000000c00000001000000680000000f00000070000000050000008c0000000600000094000000110000009c00000017000000a40000000b000000ac00000010000000b400000013000000bc00000016000000c40000000d000000cc0000000c000000d900000002000004e40000001e0000001465746e4953696c6c2074666f756f72470000007000000003000000010000000300000001000000030000000000000003000b18d80000000b000000000000000b000000000000000b000000000000000b000000000000101e000000010000000100100c000000020000001e0000000600746954000300656c010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11w_oppe_fppe_hdr_pra_org.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
