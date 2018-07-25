$PBExportHeader$w_extract_prac_verif_docs.srw
forward
global type w_extract_prac_verif_docs from w_popup
end type
type lb_1 from listbox within w_extract_prac_verif_docs
end type
type cb_close from commandbutton within w_extract_prac_verif_docs
end type
type cb_1 from commandbutton within w_extract_prac_verif_docs
end type
type dw_browse from u_dw within w_extract_prac_verif_docs
end type
type st_1 from statictext within w_extract_prac_verif_docs
end type
type cb_change from commandbutton within w_extract_prac_verif_docs
end type
type sle_path from singlelineedit within w_extract_prac_verif_docs
end type
end forward

global type w_extract_prac_verif_docs from w_popup
integer x = 214
integer y = 221
integer width = 4315
integer height = 2260
string title = "Extract Verification Documents"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
lb_1 lb_1
cb_close cb_close
cb_1 cb_1
dw_browse dw_browse
st_1 st_1
cb_change cb_change
sle_path sle_path
end type
global w_extract_prac_verif_docs w_extract_prac_verif_docs

type variables
long il_prac
long il_facility[]


pfc_cst_nv_image_functions  inv_image_functions
end variables

on w_extract_prac_verif_docs.create
int iCurrent
call super::create
this.lb_1=create lb_1
this.cb_close=create cb_close
this.cb_1=create cb_1
this.dw_browse=create dw_browse
this.st_1=create st_1
this.cb_change=create cb_change
this.sle_path=create sle_path
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lb_1
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_browse
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_change
this.Control[iCurrent+7]=this.sle_path
end on

on w_extract_prac_verif_docs.destroy
call super::destroy
destroy(this.lb_1)
destroy(this.cb_close)
destroy(this.cb_1)
destroy(this.dw_browse)
destroy(this.st_1)
destroy(this.cb_change)
destroy(this.sle_path)
end on

event open;call super::open;//Start Code Change ----11.15.2017 #V154 maha
long ll_ver
string ls_path
gs_pass_ids lst_ids

lst_ids = message.powerobjectparm

il_prac = lst_ids.prac_id
il_facility[1] = lst_ids.facility_id

select verifying_facility into :ll_ver from pd_affil_stat where prac_id = :il_prac and parent_facility_id = :il_facility[1] and active_status in (1,4);

il_facility[2] = ll_ver
ls_path = lst_ids.s_stringval
// debugbreak()
dw_browse.settransobject(sqlca)
dw_browse.retrieve( 1, il_prac, il_facility)
 
inv_image_functions = create pfc_cst_nv_image_functions 
 
sle_path.text = ls_path
 
 
 
end event

event close;call super::close;destroy inv_image_functions
end event

type lb_1 from listbox within w_extract_prac_verif_docs
integer x = 4343
integer y = 420
integer width = 480
integer height = 324
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_close from commandbutton within w_extract_prac_verif_docs
integer x = 3941
integer y = 28
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

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_extract_prac_verif_docs
integer x = 3049
integer y = 28
integer width = 805
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Download Selected Documents"
end type

event clicked;//Start Code Change ----11.15.2017 #V154 maha
Long ll_rec_id
Long ll_prac_id
Integer li_facility_id
Integer li_screen_id
integer li_type
integer p
integer li_file_count  //maha 11.21.2017
integer res  //mama 11.21.2017
string ls_docid
String ls_image_path
string ls_file
string ls_ref
string ls_name
string ls_type
string ls_screen
Integer li_rc
Integer i

Integer li_count
gs_pass_ids lst_ids

DataWindowChild dwchild

n_cst_string lnv_string
String ls_Recipient[]

dw_browse.AcceptText()
li_rc = dw_browse.RowCount()

//ls_image_path = gnv_data.of_getitem("ids" , "imaging_path" , False)
ls_image_path = sle_path.text
if right(ls_image_path, 1) <> "\" then
	ls_image_path+= "\"
end if
//gs_app_image_path = gnv_data.of_getitem("ids" , "intelliapp_app_path" , False)

//check for existing files
//get the count od the files in the directory
lb_1.DirList ( ls_image_path ,0)
li_file_count =  lb_1.TotalItems()

if li_file_count > 0 then
	res = messagebox("Existing files","There are existing files in the " + ls_image_path + " directory.  Do you want to delete them before downlaoding the new files?", question!, yesno!, 1 )
	if res = 1 then
		gnv_app.gnvlo_msword.of_delete_file(ls_image_path )
	end if
end if

FOR i = 1 TO li_rc
	IF dw_browse.GetItemNumber( i, "selected" )	= 1 THEN
		li_count++
	END IF		
END FOR

IF li_count = 0 THEN
	MessageBox("Invalid Selection", "Nothing Selected" )
	Return -1
END IF


//ls_image_path = right( ls_image_path, len(ls_image_path) -1)

//filedelete(  right( ls_image_path, len(ls_image_path) -1))

li_count = 0


FOR i = 1 TO li_rc
	IF dw_browse.GetItemNumber( i, "selected" ) <> 1 THEN
		CONTINUE
	END IF					
	ls_file = ""

	ls_ref = dw_browse.GetItemString( i, "reference_value" )
	ls_ref = of_strip_char(ls_ref, "/", "-") //Start Code Change ----11.29.2017 #V154 maha
	ls_screen = dw_browse.GetItemstring( i, "screen" )		
	ls_docid = dw_browse.GetItemstring( i, "doc_id" ) 
	ll_prac_id = dw_browse.getitemnumber(i, "prac_id")
	li_type = dw_browse.GetItemnumber( i, "verification_picture_flag" )
	
	choose case li_type
		case 1
			ls_type = ".html"
		case 2
			ls_type = ".pdf"
		case 3
			ls_type = ".htm"
		case 4
			ls_type = ".bmp"
		case 5
			ls_type = ".png"
		case 6
			ls_type = ".xml"
		case 7
			ls_type = ".jpg"
	end choose
	
	p = pos(ls_screen, " ", 1)
	if p > 0 then ls_screen = left(ls_screen, p - 1)
			
	ls_name = of_prac_name_for_file(ll_prac_id)
	
	ls_file = ls_name + "_" + ls_screen  + "_" + ls_ref  //name less file type
	ls_file = ls_image_path + ls_file //add path
	ls_file = of_strip_char( "/",ls_file, "-") //Start Code Change ----11.29.2017 #V154 maha
	
	if len(ls_file) > 200 then leftA(ls_file, 200)  //check length
	ls_file+= ls_type

	IF  inv_image_functions.of_get_verif_doc(ls_docid, "Verif", 0 , ls_file)  = -1 THEN
		continue
	else
		li_count++
	END IF

	//MessageBox("Files", ls_file )
END FOR	

MessageBox("Downloaded Files", string(li_count) + " Files extracted" )
end event

type dw_browse from u_dw within w_extract_prac_verif_docs
integer y = 140
integer width = 4297
integer height = 2040
integer taborder = 30
string dataobject = "d_verif_download_file_select"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_setupdateable(false)
end event

event buttonclicked;call super::buttonclicked; //Start Code Change ----04.11.2017 #V153 maha

if dwo.name = "b_select" then
	integer li_rc
	integer v
	integer i
	li_rc = this.RowCount()

	IF dwo.Text = "Select All" THEN
		dwo.Text = "Deselect All"
		v = 1
	ELSE
		dwo.Text = "Select All"
		v = 0
	END IF
	
	FOR i = 1 TO li_rc
			this.SetItem( i, "selected", v )
	END FOR
end if
end event

type st_1 from statictext within w_extract_prac_verif_docs
integer x = 32
integer y = 48
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
string text = "Download Directory:"
boolean focusrectangle = false
end type

type cb_change from commandbutton within w_extract_prac_verif_docs
integer x = 2414
integer y = 28
integer width = 311
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Change"
end type

event clicked;string ls_path 

ls_path = f_browseforfolder('Please select the download folder.' ,handle(parent))

sle_path.text = ls_path + "\"
end event

type sle_path from singlelineedit within w_extract_prac_verif_docs
integer x = 535
integer y = 32
integer width = 1865
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

