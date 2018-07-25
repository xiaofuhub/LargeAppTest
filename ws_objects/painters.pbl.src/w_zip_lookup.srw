$PBExportHeader$w_zip_lookup.srw
forward
global type w_zip_lookup from w_main
end type
type cb_1 from commandbutton within w_zip_lookup
end type
type sle_zip from singlelineedit within w_zip_lookup
end type
type st_1 from statictext within w_zip_lookup
end type
type st_count from statictext within w_zip_lookup
end type
type cb_add from u_cb within w_zip_lookup
end type
type cb_delete from u_cb within w_zip_lookup
end type
type cb_save from u_cb within w_zip_lookup
end type
type cb_close from u_cb within w_zip_lookup
end type
type cb_sort from u_cb within w_zip_lookup
end type
type cb_filter from u_cb within w_zip_lookup
end type
type dw_record from u_dw within w_zip_lookup
end type
type dw_detail from u_dw within w_zip_lookup
end type
end forward

global type w_zip_lookup from w_main
integer x = 5
integer y = 312
integer width = 3835
integer height = 2216
string title = "Zip Code Lookup"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
cb_1 cb_1
sle_zip sle_zip
st_1 st_1
st_count st_count
cb_add cb_add
cb_delete cb_delete
cb_save cb_save
cb_close cb_close
cb_sort cb_sort
cb_filter cb_filter
dw_record dw_record
dw_detail dw_detail
end type
global w_zip_lookup w_zip_lookup

type variables
String is_lookup_name
long ii_importrows = 0

end variables

forward prototypes
public function integer of_count ()
end prototypes

public function integer of_count ();//Start Code Change ---- 03.29.2006 #354 maha created 

long l

l = dw_detail.rowcount()
st_count.text = string(l)

return 1
end function

event open;call super::open;//Start Code Change ----08.08.2014 #V14.2 maha - screen created
long rc

dw_detail.of_SetTransObject(SQLCA)
rc = dw_detail.Retrieve()
dw_record.of_SetTransObject(SQLCA)
dw_detail.sharedata( dw_record ) 

st_count.text = string(rc)

if rc = 0 then
	string ls_filename, ls_fullname
	integer   li_fileid = 1

	ls_fullname = gs_dir_path + "IntelliCred\zip_import_file142.txt"
	
	//---------Begin Added by (Appeon)Stephen 05.05.2017 for V15.3 Bug # 5631 - import zip data file is missing in SaaS--------
	if appeongetclienttype() = 'WEB' and not fileexists(ls_fullname ) then
		n_cst_update_extra ln_file
		ln_file.of_download_file(ls_fullname)
	end if
	//---------End Added ------------------------------------------------------	
	
	if not fileexists(ls_fullname ) then
		messagebox("Zip file import", "Attempting to import zip data from file zip_import_file142.txt.  It is not in the intelliCred directory. If you know its location please browse to it." )
		li_fileid = GetFileOpenName ("Open", ls_fullname, ls_filename,    "txt", "Text Files (*.txt),*.txt,INI Files  (*.ini), *.ini,Batch Files (*.bat),*.bat",    gs_dir_path + "/IntelliCred", 512)
	end if
	
	if li_fileid < 1 then return
	messagebox("Zip code records.","Importing Zip lookup records. Please wait.")
	ii_importrows = dw_detail.importfile( ls_fullname)
	st_count.text = string(ii_importrows)
end if

 

end event

on w_zip_lookup.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.sle_zip=create sle_zip
this.st_1=create st_1
this.st_count=create st_count
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_close=create cb_close
this.cb_sort=create cb_sort
this.cb_filter=create cb_filter
this.dw_record=create dw_record
this.dw_detail=create dw_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.sle_zip
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_count
this.Control[iCurrent+5]=this.cb_add
this.Control[iCurrent+6]=this.cb_delete
this.Control[iCurrent+7]=this.cb_save
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.cb_sort
this.Control[iCurrent+10]=this.cb_filter
this.Control[iCurrent+11]=this.dw_record
this.Control[iCurrent+12]=this.dw_detail
end on

on w_zip_lookup.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.sle_zip)
destroy(this.st_1)
destroy(this.st_count)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.cb_sort)
destroy(this.cb_filter)
destroy(this.dw_record)
destroy(this.dw_detail)
end on

event pfc_save;
return Super::Event pfc_save()

end event

event pfc_postopen;if ii_importrows > 0 then
	//messagebox("Zip /code records.","Importing Zip lookup records. Please wait.")
	dw_detail.update()
	messagebox("Zip records","Import Complete")
end if
end event

type cb_1 from commandbutton within w_zip_lookup
integer x = 1737
integer y = 36
integer width = 343
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Find Zip"
end type

event clicked;string ls_zip
long f

ls_zip = trim(sle_zip.text)

f = dw_detail.find( "zip_code = '" + ls_zip + "'", 1, dw_detail.rowcount())

if f > 0 then
	dw_detail.scrolltorow(f)
	dw_detail.setrow(f)
else
	messagebox("Find","Zip Code not found")
end if
end event

type sle_zip from singlelineedit within w_zip_lookup
integer x = 1381
integer y = 36
integer width = 347
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_zip_lookup
integer x = 626
integer y = 2020
integer width = 2254
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
boolean focusrectangle = false
end type

type st_count from statictext within w_zip_lookup
integer x = 50
integer y = 2032
integer width = 169
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "0"
boolean focusrectangle = false
end type

type cb_add from u_cb within w_zip_lookup
integer x = 416
integer y = 36
integer height = 84
integer taborder = 70
boolean bringtotop = true
string text = "&Add"
end type

event clicked;Integer li_row, li_lst_order


if dw_detail.filteredcount( ) > 0 then
	dw_detail.setfilter("")
	dw_detail.filter( )
end if

li_row = dw_detail.InsertRow(0)
dw_detail.SetRow(li_row)
dw_detail.ScrollToRow(li_row)

dw_detail.Enabled = True

dw_detail.SetFocus()
dw_detail.SetColumn(1)

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-13 By: Scofield
//$<Reason> Refresh the counter
of_count()



end event

type cb_delete from u_cb within w_zip_lookup
integer x = 773
integer y = 36
integer height = 84
integer taborder = 80
boolean bringtotop = true
string text = "&Delete"
end type

event clicked;long l_code,ll_Rtn
long cnt
Long ll_department_code
string ls_text

dw_detail.Event pfc_deleterow()
dw_detail.SetFocus()

of_count()


end event

type cb_save from u_cb within w_zip_lookup
integer x = 59
integer y = 36
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string text = "&Save"
end type

event clicked;Integer li_retval


if dw_detail.DataObject = "" then return			//Added by Scofield on 2008-03-12

li_retval = Parent.Event pfc_save()

dw_detail.SetFocus()

of_count()
	




end event

type cb_close from u_cb within w_zip_lookup
integer x = 3415
integer y = 36
integer height = 84
integer taborder = 50
boolean bringtotop = true
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type cb_sort from u_cb within w_zip_lookup
integer x = 2642
integer y = 36
integer height = 84
integer taborder = 100
boolean bringtotop = true
string text = "So&rt"
end type

event clicked;if dw_detail.DataObject = "" then return			//Added by Scofield on 2008-03-12

dw_detail.Event pfc_SortDlg()

dw_detail.SetFocus()

end event

type cb_filter from u_cb within w_zip_lookup
integer x = 2999
integer y = 36
integer height = 84
integer taborder = 110
boolean bringtotop = true
string text = "&Filter"
end type

event clicked;if dw_detail.DataObject = "" then return			//Added by Scofield on 2008-03-12

//dw_detail.Event pfc_filterdlg()
string null_str

SetNull(null_str)

dw_detail.SetFilter(null_str)

dw_detail.Filter()

dw_detail.SetFocus()

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-13 By: Scofield
//$<Reason> Refresh the counter
of_count()
//---------------------------- APPEON END ----------------------------

end event

type dw_record from u_dw within w_zip_lookup
integer y = 1636
integer width = 3826
integer height = 376
integer taborder = 40
string dataobject = "d_zip_lookup_detail"
boolean vscrollbar = false
end type

event constructor;call super::constructor;this.of_setupdateable(false)  //Add by Stephen 04.12.2011 --- Fixed a bug.
end event

event doubleclicked;call super::doubleclicked;//Start Code Change ----01.12.2012 #V12 maha - copied from dw_detail
String	ls_Text,ls_ObjName
String	ls_Phone,ls_fax,ls_RetParm

if This.AcceptText() <> 1 then return

ls_ObjName = dwo.Name

if ls_ObjName = 'large_description_1' or ls_ObjName = 'large_description_2' then
	ls_Text = This.GetItemString(Row,ls_ObjName)
	OpenWithParm(w_cp_desc,ls_Text)
	if Message.Doubleparm = -1 then return
	This.SetItem(Row,ls_ObjName,Message.StringParm)
	This.AcceptText()
end if


if row > 0 and row <= This.RowCount() then
	if ls_ObjName = 'phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
		This.SetColumn('phone')
	elseif ls_ObjName = 'fax' then
		ls_fax = This.GetItemString(row,'fax')
		if IsNull(ls_fax) then ls_fax = ""
		OpenWithParm(w_phonedetail,"Fax:" + ls_fax)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'fax',ls_RetParm)
		end if
		This.SetColumn('fax')
	end if
end if

end event

event buttonclicked;call super::buttonclicked;//Start Code Change ----04.26.2012 #V12 maha - added help message

if dwo.name = "b_help" then
	messagebox("Facility field","The Facility field is only available for the Department, Division and Section tables.  When set to a specific facility the record will only show in the corresponding drop down list on the Provider Appointment tab Detail 2 Department records, if the Appointment is connected to that Facility.~rAny lookups left blank or set to all will show fall the time.")
end if
end event

type dw_detail from u_dw within w_zip_lookup
integer y = 144
integer width = 3822
integer height = 1492
integer taborder = 30
string dataobject = "d_zip_lookup_browse"
boolean hscrollbar = true
end type

event constructor;This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.of_SetReqColumn(True)

This.inv_sort.of_SetColumnHeader(True)

end event

event itemchanged;call super::itemchanged;//---------Begin Modified by (Appeon)Eugene 06.18.2013 for V141 ISG-CLX--------
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 10.19.2006 By: Davis
////$<reason> Fix a defect.
//
//IF Lower(is_lookup_name) = 'contract action type' THEN
//	IF lower(dwo.name) = 'code' THEN
//		IF LenA(data) > 0 THEN
//			IF NOT f_validstr(This.GetitemString(row, "custom_1")) THEN
//				This.Setitem(row, "custom_1", data)
//			END IF
//		END IF
//	END IF
//END IF
//
////---------------------------- APPEON END ----------------------------

//Modify By Jervis 09.11.2009
IF lower(dwo.name) = 'code' THEN
	IF LEN(data) > 0 THEN
		IF Lower(is_lookup_name) = 'contract action type' THEN
			IF NOT f_validstr(This.GetitemString(row, "custom_1")) THEN
				This.Setitem(row, "custom_1", data)
			END IF
		END IF
		IF Pos('~t' + THIS.Describe("DataWindow.Objects"), '~t' + 'description'+ '~t') > 0 THEN  //(Appeon)Eugene 07.08.2013 - V141 ISG-CLX
			IF NOT f_validstr(This.GetitemString(row, "description")) THEN
				This.Setitem(row, "description", data)
				this.selectedtext( )
			END IF
		END IF 
	END IF
END IF
//---------End Modfiied ------------------------------------------------------
end event

event clicked;call super::clicked;//Start Code Change ---- 10.15.2007 #V7 maha
integer i

i = this.getclickedrow()
this.setrow(i)
//End Code Change---10.15.2007
end event

event rbuttondown;call super::rbuttondown;
String	ls_ColName,ls_Objects,ls_ObjName,ls_Band,ls_Type
long		ll_SepPos,ll_DisDiff,ll_WidthDiff,ll_Rtn
DateTime	ldt_Null

ls_ColName = Lower(dwo.Name)
if dw_detail.Describe(ls_ColName + ".Type") <> "column" then return

if ls_ColName = "datetime_1" or ls_ColName = "datetime_2" then
	SetNull(ldt_Null)
	ll_Rtn = MessageBox("Set Null", "Would you like to set this Date to null?", question!, yesno!, 2)
	if ll_Rtn = 1 then this.SetItem(Row,ls_ColName,ldt_Null)
	return
end if

ls_Objects = dw_detail.Describe("DataWindow.Objects") + "~t"
ll_SepPos = PosA(ls_Objects,"~t")


end event

event rowfocuschanged;call super::rowfocuschanged;
dw_record.setrow(currentrow)
dw_record.scrolltorow(currentrow)
this.selectrow( 0, false)
this.selectrow( currentrow,true)

end event

