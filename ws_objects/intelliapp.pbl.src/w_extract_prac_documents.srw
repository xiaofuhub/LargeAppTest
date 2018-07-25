$PBExportHeader$w_extract_prac_documents.srw
forward
global type w_extract_prac_documents from w_popup
end type
type cb_close from commandbutton within w_extract_prac_documents
end type
type cb_1 from commandbutton within w_extract_prac_documents
end type
type dw_browse from u_dw within w_extract_prac_documents
end type
type st_1 from statictext within w_extract_prac_documents
end type
type cb_change from commandbutton within w_extract_prac_documents
end type
type sle_path from singlelineedit within w_extract_prac_documents
end type
end forward

global type w_extract_prac_documents from w_popup
integer x = 214
integer y = 221
integer width = 4306
integer height = 2260
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
cb_close cb_close
cb_1 cb_1
dw_browse dw_browse
st_1 st_1
cb_change cb_change
sle_path sle_path
end type
global w_extract_prac_documents w_extract_prac_documents

type variables
long il_prac

pfc_cst_nv_image_functions  inv_image_functions
end variables

on w_extract_prac_documents.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_1=create cb_1
this.dw_browse=create dw_browse
this.st_1=create st_1
this.cb_change=create cb_change
this.sle_path=create sle_path
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_browse
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_change
this.Control[iCurrent+6]=this.sle_path
end on

on w_extract_prac_documents.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_1)
destroy(this.dw_browse)
destroy(this.st_1)
destroy(this.cb_change)
destroy(this.sle_path)
end on

event open;call super::open; //Start Code Change ----03.07.2017 #V153 maha - added
 il_prac = message.doubleparm
 
 dw_browse.settransobject(sqlca)
 dw_browse.retrieve(il_prac, gs_user_id)
 dw_browse.setfilter("active_status = 1")  
 dw_browse.filter()
 
 inv_image_functions = create pfc_cst_nv_image_functions 
 
sle_path.text = gs_temp_path
 
 
 
end event

event close;call super::close;destroy inv_image_functions
end event

type cb_close from commandbutton within w_extract_prac_documents
integer x = 3941
integer y = 36
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

type cb_1 from commandbutton within w_extract_prac_documents
integer x = 3049
integer y = 36
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

event clicked; //Start Code Change ----03.07.2017 #V153 maha
Long ll_rec_id
Long ll_prac_id
Integer li_facility_id
Integer li_screen_id
Long ll_pk

String ls_image_path
string ls_file
string ls_ref
string ls_screen
Integer li_rc
Integer i

Integer li_count


DataWindowChild dwchild

n_cst_string lnv_string//Nova 07262010
String ls_Recipient[]//Nova 07262010

dw_browse.AcceptText()
li_rc = dw_browse.RowCount()

//ls_image_path = gnv_data.of_getitem("ids" , "imaging_path" , False)
ls_image_path = sle_path.text
if right(ls_image_path, 1) <> "\" then
	ls_image_path+= "\"
end if
//gs_app_image_path = gnv_data.of_getitem("ids" , "intelliapp_app_path" , False)
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_rc
	IF dw_browse.GetItemNumber( i, "selected" )	= 1 THEN
		li_count++
	END IF		
END FOR

IF li_count = 0 THEN
	MessageBox("Invalid Selection", "Nothing Selected" )
	Return -1
END IF

li_count = 0

FOR i = 1 TO li_rc
	IF dw_browse.GetItemNumber( i, "selected" )	= 0 THEN
		CONTINUE
	END IF					
	
	ls_ref = dw_browse.GetItemString( i, "reference_name" )
	ls_screen = dw_browse.GetItemstring( i, "image_type_description" )		
	ll_pk = dw_browse.GetItemNumber( i, "image_pk" ) 

	IF inv_image_functions.of_retrieve_image_for_extract (ll_pk, ls_ref, ls_screen, ls_image_path)  = -1 THEN
		continue
	else
		li_count++
	END IF

//	ls_file = gs_temp_path + "images\" + String(ll_prac_id) + "_" + String(ll_seq_no) + ".tif"
END FOR	

MessageBox("Downloaded Files", string(li_count) + " Files extracted" )
end event

type dw_browse from u_dw within w_extract_prac_documents
integer y = 140
integer width = 4297
integer height = 2040
integer taborder = 30
string dataobject = "d_pd_image_list"
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

type st_1 from statictext within w_extract_prac_documents
integer x = 32
integer y = 56
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

type cb_change from commandbutton within w_extract_prac_documents
integer x = 2418
integer y = 36
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

type sle_path from singlelineedit within w_extract_prac_documents
integer x = 535
integer y = 36
integer width = 1865
integer height = 92
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

