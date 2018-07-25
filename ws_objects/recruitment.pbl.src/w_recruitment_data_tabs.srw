$PBExportHeader$w_recruitment_data_tabs.srw
forward
global type w_recruitment_data_tabs from w_response
end type
type p_1 from picture within w_recruitment_data_tabs
end type
type cb_upload from commandbutton within w_recruitment_data_tabs
end type
type cb_email from commandbutton within w_recruitment_data_tabs
end type
type cb_convert from commandbutton within w_recruitment_data_tabs
end type
type cb_delete from commandbutton within w_recruitment_data_tabs
end type
type cb_save from commandbutton within w_recruitment_data_tabs
end type
type cb_close from commandbutton within w_recruitment_data_tabs
end type
type dw_browsexx from u_dw within w_recruitment_data_tabs
end type
type tab_1 from tab within w_recruitment_data_tabs
end type
type tabpage_search from userobject within tab_1
end type
type cb_clear from commandbutton within tabpage_search
end type
type dw_assigned from u_dw within tabpage_search
end type
type dw_pos from u_dw within tabpage_search
end type
type cb_add_rec from commandbutton within tabpage_search
end type
type rb_all from radiobutton within tabpage_search
end type
type cb_select from commandbutton within tabpage_search
end type
type ddlb_search from dropdownlistbox within tabpage_search
end type
type cb_select_to_new from commandbutton within tabpage_search
end type
type dw_dates from u_dw within tabpage_search
end type
type cb_search from commandbutton within tabpage_search
end type
type rb_inc from radiobutton within tabpage_search
end type
type sle_srch_val from singlelineedit within tabpage_search
end type
type rb_new from radiobutton within tabpage_search
end type
type rb_viewed from radiobutton within tabpage_search
end type
type rb_acc from radiobutton within tabpage_search
end type
type rb_dec from radiobutton within tabpage_search
end type
type dw_search from datawindow within tabpage_search
end type
type gb_status from groupbox within tabpage_search
end type
type gb_search from groupbox within tabpage_search
end type
type gb_1 from groupbox within tabpage_search
end type
type gb_3 from groupbox within tabpage_search
end type
type gb_4 from groupbox within tabpage_search
end type
type tabpage_search from userobject within tab_1
cb_clear cb_clear
dw_assigned dw_assigned
dw_pos dw_pos
cb_add_rec cb_add_rec
rb_all rb_all
cb_select cb_select
ddlb_search ddlb_search
cb_select_to_new cb_select_to_new
dw_dates dw_dates
cb_search cb_search
rb_inc rb_inc
sle_srch_val sle_srch_val
rb_new rb_new
rb_viewed rb_viewed
rb_acc rb_acc
rb_dec rb_dec
dw_search dw_search
gb_status gb_status
gb_search gb_search
gb_1 gb_1
gb_3 gb_3
gb_4 gb_4
end type
type tabpage_data from userobject within tab_1
end type
type dw_detail_data from u_dw within tabpage_data
end type
type tabpage_data from userobject within tab_1
dw_detail_data dw_detail_data
end type
type tabpage_documents from userobject within tab_1
end type
type cb_add_doc from commandbutton within tabpage_documents
end type
type dw_docs from datawindow within tabpage_documents
end type
type cb_view_doc from commandbutton within tabpage_documents
end type
type tabpage_documents from userobject within tab_1
cb_add_doc cb_add_doc
dw_docs dw_docs
cb_view_doc cb_view_doc
end type
type tabpage_quest from userobject within tab_1
end type
type cb_calc from commandbutton within tabpage_quest
end type
type cb_6 from commandbutton within tabpage_quest
end type
type dw_quest from datawindow within tabpage_quest
end type
type tabpage_quest from userobject within tab_1
cb_calc cb_calc
cb_6 cb_6
dw_quest dw_quest
end type
type tabpage_tasks from userobject within tab_1
end type
type dw_tasks from u_dw within tabpage_tasks
end type
type rb_all_stat from radiobutton within tabpage_tasks
end type
type rb_compl from radiobutton within tabpage_tasks
end type
type rb_open from radiobutton within tabpage_tasks
end type
type cb_5 from commandbutton within tabpage_tasks
end type
type cb_4 from commandbutton within tabpage_tasks
end type
type cb_3 from commandbutton within tabpage_tasks
end type
type gb_2 from groupbox within tabpage_tasks
end type
type tabpage_tasks from userobject within tab_1
dw_tasks dw_tasks
rb_all_stat rb_all_stat
rb_compl rb_compl
rb_open rb_open
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
gb_2 gb_2
end type
type tab_1 from tab within w_recruitment_data_tabs
tabpage_search tabpage_search
tabpage_data tabpage_data
tabpage_documents tabpage_documents
tabpage_quest tabpage_quest
tabpage_tasks tabpage_tasks
end type
type cb_view from commandbutton within w_recruitment_data_tabs
end type
type ddlb_filter from dropdownlistbox within w_recruitment_data_tabs
end type
type st_1 from statictext within w_recruitment_data_tabs
end type
type dw_detailsxxx from u_dw within w_recruitment_data_tabs
end type
end forward

global type w_recruitment_data_tabs from w_response
integer x = 214
integer y = 221
integer width = 4448
integer height = 2400
string title = "Recruitment Candidates"
boolean controlmenu = false
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
event ue_select_tab_2 ( )
p_1 p_1
cb_upload cb_upload
cb_email cb_email
cb_convert cb_convert
cb_delete cb_delete
cb_save cb_save
cb_close cb_close
dw_browsexx dw_browsexx
tab_1 tab_1
cb_view cb_view
ddlb_filter ddlb_filter
st_1 st_1
dw_detailsxxx dw_detailsxxx
end type
global w_recruitment_data_tabs w_recruitment_data_tabs

type variables
long il_loc_id = 1
long il_pos = 0
long il_rec_id
long il_recrt
long il_prac
string is_filter
datawindow idw_detail
end variables

forward prototypes
public function integer of_filter_status ()
public function integer of_expandnotes (long al_row, string as_column)
public function integer of_modify_fieldprop ()
public function long of_getpracid ()
public function long of_triggerrowfocuschanged (long al_row)
public function integer of_refresh_browse (long al_loc_id)
public function integer of_save ()
public function integer of_set_syntax ()
public function integer of_filter_tasks (string as_type)
public function integer of_search_position (long al_pos)
public function integer of_calc_values (integer ai_row)
public function integer of_download_image (long al_prac_id, long al_rec_id)
public function integer of_reset_tabs ()
public function integer of_run_tdl (long al_prac_id, string as_where, string as_moveto, string as_module)
end prototypes

event ue_select_tab_2(); //Start Code Change ----08.14.2015 #V15 maha
tab_1.selecttab(2)
end event

public function integer of_filter_status ();//long ll_row
//
//ll_row = dw_browse.getrow( )
//
//dw_browse.setfilter(is_filter)
//dw_browse.filter()
//
//of_triggerRowfocuschanged(ll_row)


return 1
end function

public function integer of_expandnotes (long al_row, string as_column);//====================================================================
//$<Function>: of_expandnotes
//$<Arguments>:
// 	value    long      al_row
// 	value    string    as_column
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.05.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_text

ls_text = idw_detail.getitemstring( al_row,as_column)
	if isnull(ls_text) then ls_text = ""  //(Appeon)Harry 07.16.2014 - for the Bug 4115
	openWithParm(w_ai_notes_new,ls_text)
	
	if Message.stringparm = 'Cancel' then 
			return -1
	else
			ls_text = Message.stringparm
			//dw_detail.setitem( al_row,as_column,ls_text)
			//if lower(as_column) <>	'addtl_comments' then idw_detail.setitem( al_row,as_column,ls_text)//long.zhang  Testing Bug # 3960
			idw_detail.setitem( al_row,as_column,ls_text)   //(Appeon)Harry 03.31.2016 - for BugH033105
	end if
	
return 1
end function

public function integer of_modify_fieldprop ();//====================================================================
//$<Function>: of_set_require_field
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.16.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
datastore lds_field_prop
long ll_rowcount
Integer ll_i
String ls_field_name
String ls_text
String ls_sqlselect
Integer li_visible

lds_field_prop = create datastore
lds_field_prop.dataobject = 'd_sys_field_prop_recruiting'
lds_field_prop.settransobject( sqlca)

//debugbreak()
ls_sqlselect = lds_field_prop.Describe("DataWindow.Table.Select")

if lenA(ls_sqlselect) > 0 then
	ls_sqlselect += ' and field_order<>0 and field_id<>18035 and table_id = -1'   //Start Code Change ----09.09.2015 #V15 maha - added table identifier
end if


lds_field_prop.Modify("DataWindow.Table.Select='"+ls_sqlselect+"'")

ll_rowcount = lds_field_prop.retrieve( )

For ll_i = 1 to ll_rowcount
	
		ls_text = lds_field_prop.getitemstring( ll_i,'field_name_allias')
		
		ls_field_name = lds_field_prop.getitemstring( ll_i,'field_name')
		
		li_visible = lds_field_prop.getItemNumber(ll_i,"range_from")
		
		if li_visible = 0 then
				idw_detail.modify( ls_field_name+".visible = '0'")
				idw_detail.modify( ls_field_name+"_t.visible = '0'")
				continue
		end if
		
		if (li_visible = 1 or isNull(li_visible)) and  lds_field_prop.getitemnumber( ll_i,'range_to') = 1 then
			
			if  lds_field_prop.getitemstring( ll_i,'lookup_field') = 'Y' then
					idw_detail.modify( ls_field_name+'.DDDW.Required=Yes')
				else
					
				if lower(ls_field_name) = 'pref_contact_method' then
					idw_detail.modify( ls_field_name+'.DDLB.Required=Yes')
				elseif lower(ls_field_name) <> 'ssn' then //(Appeon)Stephen 02.03.2017 - Recruitment- Social Security Number being offset when Converting to Practitioner in Intellicred Case#68963 Bug_id#5479
					idw_detail.modify( ls_field_name+'.Edit.Required=Yes')
				end if
				
			end if	
			idw_detail.modify( ls_field_name+".background.color = '8257535'")
			
			if idw_detail.describe( ls_field_name + ' _t.text')  <> "!" then		
				idw_detail.modify( ls_field_name + "_t.text='"+ ls_text +"'")
			else
//				messagebox("Failed",ls_field_name)
			end if
		end if
		
		
		
end for

destroy lds_field_prop

return 1
end function

public function long of_getpracid ();//====================================================================
//$<Function>: of_getPracid
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.16.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_prac_id

select min(prac_id) into :ll_prac_id from recruit_prac;

if isNull(ll_prac_id) or ll_prac_id > 0 then
	ll_prac_id = 0
end if	

ll_prac_id --

return ll_prac_id
end function

public function long of_triggerrowfocuschanged (long al_row);//====================================================================
//$<Function>: of_triggerrowfocuschanged
//$<Arguments>:
// 	value    long    al_row
//$<Return>:  long
//$<Description>:  Called From setfilter
//$<Author>: (Appeon) long.zhang 10.14.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//if appeonGetClientType() = "PB" THEN
//	if al_row = dw_browse.getrow( ) then//Added by Appeon long.zhang 10.12.2013 (V14.1 Recruitment Functionality)
//		dw_browse.event rowfocuschanged(al_row)
//	end if
//else	// unable to trigger rowfocuschange event under web after setfilter
//	dw_browse.event rowfocuschanged(dw_browse.getrow( ))
//end if

return 1
end function

public function integer of_refresh_browse (long al_loc_id);//====================================================================
//$<Function>: of_refresh_browse
//$<Arguments>:
// 	value    long    al_loc_id
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 10.15.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//	long ll_row
//	
//	dw_browse.retrieve( )
//	of_filter_status()
//	ll_row = dw_browse.find( 'rec_id='+String(al_loc_id),1,dw_browse.rowcount())	
//	if ll_row > 0 then
//		dw_browse.scrolltorow( ll_row)
//		dw_browse.selectrow( 0,false)
//		dw_browse.selectrow( ll_row,true)
//	end if
	return 1
end function

public function integer of_save ();//====================================================================
//$<Function>: of_save
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 10.22.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_row
long ll_old_loc
Integer li_rtn

li_rtn = this.event pfc_save()

if li_rtn = 1 then
	
	ll_old_loc = il_loc_id
	
	this.setredraw( false)
	
	of_refresh_browse(ll_old_loc)
	this.setredraw( true)
	
end if

return li_rtn
end function

public function integer of_set_syntax ();string ls_syntax
string ls_org_syntax
string ls_temp
string ls_where
string ls_date
string ls_stype
string ls_val
string ls_from
string ls_to
long rc
 date ld_from
date ld_to
integer r
datawindow ldw_search
u_dw dw_dates

dw_dates = tab_1.tabpage_search.dw_dates
ldw_search = tab_1.tabpage_search.dw_search
ldw_search.settransobject( sqlca)
ls_org_syntax = ldw_search.getsqlselect( )
ls_syntax = ls_org_syntax

ls_where = " Where "

//set status
if tab_1.tabpage_search.rb_new.checked then
	ls_temp = " recruit_status = 1 " 
elseif tab_1.tabpage_search.rb_viewed.checked then
	ls_temp = " recruit_status = 2 " 
elseif tab_1.tabpage_search.rb_acc.checked then
	ls_temp = " recruit_status = 3 " 
elseif tab_1.tabpage_search.rb_dec.checked then
	ls_temp = " recruit_status = 0 " 
elseif tab_1.tabpage_search.rb_inc.checked then
	ls_temp = " recruit_status = -1 " 
elseif tab_1.tabpage_search.rb_all.checked then
	ls_temp =  " 1 = 1 "
end if

ls_where+= ls_temp + " and "

 //set date range

dw_dates.accepttext()
ld_from  = dw_dates.getitemdate(1,"from_date")
ld_to  = dw_dates.getitemdate(1,"to_date")

if not isnull(ld_from) then
	ls_from = String(dw_dates.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
	ls_date = " convert(datetime,  convert( varchar, add_date,102) )  >= '" + ls_from + "' and "
//	ls_date = " add_date >= date('" + string(ld_from) + "') and "
end if

if not isnull(ld_to) then
	ls_to = String(dw_dates.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 
	ls_date+=  " convert(datetime,  convert( varchar, add_date,102) )  <= '" + ls_to  + "' and "
end if

ls_where+= ls_date


 
 //set_position
 if il_pos > 0 then
	ls_temp = " recruit_pos = " + string(il_pos)  + " and "
	ls_where+= ls_temp
end if
 
 //set search type and value
 ls_stype = tab_1.tabpage_search.ddlb_search.text
 ls_val = tab_1.tabpage_search.sle_srch_val.text
 if len(ls_stype) > 0 then
	if len(ls_val) = 0 then
		//skip
	else
		Choose case tab_1.tabpage_search.ddlb_search.text
			case "Last Name"
				ls_temp = " upper(last_name) like upper('" + ls_val + "%')"
//			case "Assigned to"
//				ls_temp = " recruiter assn = " + ""
			case "NPI #"
				ls_temp = " npi = '" + ls_val + ""
			case "SSN"
				ls_temp = " ssn = '" + ls_val + ""
		end choose
		ls_temp+= " and "
		ls_where+= ls_temp
	end if
end if

//set recruiter
if il_recrt > 0 then
	ls_temp = " recruiter_assn = " + string(il_recrt) +  " and "
	ls_where+= ls_temp
end if


//set final
ls_syntax+= ls_where
ls_syntax = mid(ls_syntax, 1, len(ls_syntax) - 5)

 ldw_search.setsqlselect(ls_syntax )
 
rc =  ldw_search.retrieve()
// messagebox(string(rc),ls_syntax)
 ldw_search.setsqlselect(ls_org_syntax ) 
 
 if rc > 0 then ldw_search.selectrow( 1,true)

return 1
end function

public function integer of_filter_tasks (string as_type);string ls_filter
integer f

choose case as_type
	case "O"
		//---------Begin Modified by (Appeon)Stephen 03.10.2016 for BugS030801--------
		//ls_filter = "isnull(complete_date)"
		ls_filter = "isnull(compl_date)"
		//---------End Modfiied ------------------------------------------------------
	case "C"
		//---------Begin Modified by (Appeon)Stephen 03.10.2016 for BugS030801--------
		//ls_filter = " not isnull(complete_date)" 
		ls_filter = " not isnull(compl_date)" 
		//---------End Modfiied ------------------------------------------------------
	Case "A"
		ls_filter = ""
end choose

f = tab_1.tabpage_tasks.dw_tasks.setfilter(ls_filter)
if f < 0 then messagebox("Task Filter","Filter Failed")
tab_1.tabpage_tasks.dw_tasks.filter()



return 1
end function

public function integer of_search_position (long al_pos); //Start Code Change ----03.18.2015 #V15 maha - added

if al_pos > 0 then
	tab_1.tabpage_search.rb_all.checked = true
	tab_1.tabpage_search.rb_new.checked = false
	il_pos = al_pos
	tab_1.tabpage_search.dw_pos.setitem(1,"pos_id",al_pos)
	tab_1.tabpage_search.cb_search.triggerevent(clicked!)
end if

return 1
end function

public function integer of_calc_values (integer ai_row); //Start Code Change ----03.26.2015 #V15 maha - added
 integer r
 integer i
 integer v
 datawindow dw_quest
 
 dw_quest = tab_1.tabpage_quest.dw_quest
 dw_quest.accepttext()
 
 if ai_row = 0 then
	for r = 1 to dw_quest.rowcount()
		i = dw_quest.getitemnumber(r,"ans_id")
		if i = 1 then
			v =  dw_quest.getitemnumber(r,"yes_value")
		else
			v =  dw_quest.getitemnumber(r,"no_value")
		end if
			
		dw_quest.setitem(r,"answer_value",v)
	next
else
	i = dw_quest.getitemnumber(ai_row,"ans_id")
	if i = 1 then
		v =  dw_quest.getitemnumber(ai_row,"yes_value")
	else
		v =  dw_quest.getitemnumber(ai_row,"no_value")
	end if
		
	dw_quest.setitem(ai_row,"answer_value",v)
end if


return 1
end function

public function integer of_download_image (long al_prac_id, long al_rec_id);//====================================================================
//$<Function>: of_download_image
//$<Arguments>:
// 	value    long    al_prac_id
//$<Return>:  integer
//$<Description>: Download CV From recruit image table
//$<Author>: (Appeon) long.zhang 09.06.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Integer li_start_page
Integer li_num_pages
Long li_filenum
Long ll_filelen
Long ll_start
Long ll_new_pos, ll_data_length
Integer li_loops
Integer li_counter
Integer li_retval
Blob  lb_image_data
Blob blob_temp
Blob total_blob

string ls_file

SetPointer(HourGlass!)

String ls_filename, ls_Null, ls_filetype

//---------Begin Modified by (Appeon)Stephen 12.15.2015 for BugS112701--------
/*
SELECT file_name, file_type
	INTO :ls_filename, :ls_filetype
	FROM recruit_image
	WHERE prac_id = :al_prac_id
	USING SQLCA;
	*/
SELECT file_name, file_type
	INTO :ls_filename, :ls_filetype
	FROM recruit_image
	WHERE prac_id = :al_prac_id and rec_id = :al_rec_id
	USING SQLCA;
//---------End Modfiied ------------------------------------------------------
	
if sqlca.sqlcode=100 or isnull(ls_filename) then
	messagebox("Prompt","There is no file uploaded for this record!")
	return -1
elseif sqlca.sqlcode < 0 then
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
end if	


ls_file = gs_temp_path + "images\"  
gnv_appeondll.of_parsepath(ls_file)



	ll_start = LastPos(ls_filename,'\')
	ls_filename = MidA(ls_filename,ll_start+1)


if pos(ls_filename,'\') > 0 then
	ls_file = ls_file + mid(ls_filename, pos(ls_filename,'\') +1)
else
	ls_file = ls_file +ls_filename
end if

IF FileExists(ls_file) THEN
	filedelete(ls_file)
END IF

openwithparm( w_appeon_gifofwait, "Downloading CV from Database..." )

IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	
	SELECT Datalength(image_field)
	INTO :ll_data_length
	FROM recruit_image
	WHERE prac_id  = :al_prac_id and rec_id = :al_rec_id 
	USING SQLCA; //rec_id, Added by Appeon long.zhang 12.23.2015 (BugL121204)
	
	IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
		messagebox("Prompt","There is no CV uploaded!")
		RETURN 0
	END IF
	
	IF ll_data_length > 8000 THEN 
		 IF Mod(ll_data_length,8000) = 0 THEN 
			  li_loops = ll_data_length/8000 
		 ELSE 
			  li_loops = (ll_data_length/8000) + 1 
		 END IF 
	ELSE 
		 li_loops = 1 
	END IF 
	
	FOR li_counter = 1 to li_loops
		Yield()
		SetPointer(HourGlass!)
		
		ll_start = (li_counter - 1) * 8000 + 1
		SELECTBLOB substring(image_field,:ll_start,8000)
		     INTO :blob_temp
		    FROM recruit_image
	      WHERE prac_id  = :al_prac_id and rec_id = :al_rec_id 
	       USING  SQLCA;//rec_id, Added by Appeon long.zhang 12.23.2015 (BugL121204)
	
		total_blob += blob_temp
	NEXT 
	
	lb_image_data = total_blob

ELSE
	
	SELECTBLOB image_field 
	INTO :lb_image_data
	FROM recruit_image  
	WHERE prac_id  = :al_prac_id  and rec_id = :al_rec_id //rec_id, Added by Appeon long.zhang 12.23.2015 (BugL121204)
	USING SQLCA;
	
END IF


IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF

ll_filelen = LenA( lb_image_data )

IF Isnull(lb_image_data) OR ll_filelen = 0 THEN
	RETURN -1
END IF

if f_open_image_from_database(ls_file,lb_image_data ) = -1 then return -1

IF Not FileExists( ls_file) THEN 
	MessageBox("File Creation Error", "No  file created.  Check to make sure the directory " + gs_dir_path + " is valid." )
END IF

setnull(ls_Null)
IF FileExists(ls_file) THEN
	ShellExecuteA ( Handle( This ), "open", ls_file, ls_Null, ls_Null, 1)
END IF
	
Return 1

end function

public function integer of_reset_tabs (); //Start Code Change ----12.18.2015 #V15 maha
tab_1.tabpage_data.dw_detail_data.reset()
tab_1.tabpage_documents.dw_docs.reset()
tab_1.tabpage_quest.dw_quest.reset()
tab_1.tabpage_tasks.dw_tasks.reset()

il_rec_id = 0

return 1




end function

public function integer of_run_tdl (long al_prac_id, string as_where, string as_moveto, string as_module);//====================================================================
//$<Function>: of_run_tdl
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 10.27.2016 (V15.3-To Do List additional Modifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_syntax
string ls_org_syntax
string ls_temp
string ls_where
long rc
integer li_cnt
datawindow ldw_search

ldw_search = tab_1.tabpage_search.dw_search
ldw_search.settransobject( sqlca)
ls_org_syntax = ldw_search.getsqlselect( )
ls_syntax = ls_org_syntax

ls_where = " Where "
if as_module = '10' then
	ls_syntax = ls_syntax + " , pd_recruit_actions "
	ls_temp =  " pd_recruit_actions.prac_id = recruit_prac.prac_id "
else
	ls_syntax = ls_syntax 
	ls_temp =  " 1=1 "
end if

ls_where+= ls_temp + " and "

if as_moveto = "34" or as_module = "08" then	
	ls_temp = " recruit_prac.prac_id =" + string(al_prac_id) +  " and "	
else
	if len(trim(as_where)) > 0 then
		ls_temp = as_where + " and "
	else
		ls_temp = ""
	end if	
end if
ls_where+= ls_temp

//set final
ls_syntax+= ls_where
ls_syntax = mid(ls_syntax, 1, len(ls_syntax) - 5)

ldw_search.setsqlselect(ls_syntax )
rc =  ldw_search.retrieve()
ldw_search.setsqlselect(ls_org_syntax ) 
 
if rc > 0 then 
	ldw_search.selectrow( 1,true)
	if as_moveto = "34" then
		tab_1.tabpage_search.cb_select.triggerevent(clicked!)
//		if tab_1.selectedtab<> 1 then tab_1.selecttab(1)
 		yield()
		tab_1.selectedtab = 5
		tab_1.selecttab(5)
	end if
	
end if

return 1
end function

on w_recruitment_data_tabs.create
int iCurrent
call super::create
this.p_1=create p_1
this.cb_upload=create cb_upload
this.cb_email=create cb_email
this.cb_convert=create cb_convert
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_browsexx=create dw_browsexx
this.tab_1=create tab_1
this.cb_view=create cb_view
this.ddlb_filter=create ddlb_filter
this.st_1=create st_1
this.dw_detailsxxx=create dw_detailsxxx
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.cb_upload
this.Control[iCurrent+3]=this.cb_email
this.Control[iCurrent+4]=this.cb_convert
this.Control[iCurrent+5]=this.cb_delete
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.dw_browsexx
this.Control[iCurrent+9]=this.tab_1
this.Control[iCurrent+10]=this.cb_view
this.Control[iCurrent+11]=this.ddlb_filter
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.dw_detailsxxx
end on

on w_recruitment_data_tabs.destroy
call super::destroy
destroy(this.p_1)
destroy(this.cb_upload)
destroy(this.cb_email)
destroy(this.cb_convert)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.dw_browsexx)
destroy(this.tab_1)
destroy(this.cb_view)
destroy(this.ddlb_filter)
destroy(this.st_1)
destroy(this.dw_detailsxxx)
end on

event open;call super::open;tab_1.tabpage_search.cb_search.triggerevent(clicked!)
idw_detail = tab_1.tabpage_data.dw_detail_data   //Start Code Change ----06.03.2015 #V15 maha
of_modify_fieldprop( )
end event

type p_1 from picture within w_recruitment_data_tabs
boolean visible = false
integer x = 3305
integer y = 144
integer width = 87
integer height = 64
string picturename = "arrowhead.png"
boolean focusrectangle = false
end type

type cb_upload from commandbutton within w_recruitment_data_tabs
boolean visible = false
integer x = 4549
integer y = 796
integer width = 119
integer height = 56
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Upload CV"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 12.20.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_prac_id
long ll_row
long ll_image_type
long ll_rec_id
long ll_data_length
integer value, li_pos, li_return,li_start
String docname,ls_filename,named,ls_filetype
boolean lb_new
pfc_cst_nv_image_functions  lnv_image_functions
Blob lb_all_data

ll_row = idw_detail.getrow( )

if ll_row < 1 then return

ll_prac_id  = idw_detail.getitemnumber( ll_row,'prac_id')

if isNull(ll_prac_id) then return


  
 SELECT Top 1 rec_id INTO :ll_rec_id
FROM recruit_image 
Where prac_id = :ll_prac_id;
	
if sqlca.sqlcode = 100 then
	lb_new = true
elseif sqlca.sqlcode < 0 then
	Messagebox( "upload cv"," - Unable to connect to DB due to "+sqlca.SQLErrText)
	return -1
end if

if not lb_new then
		if MessageBox('Upload CV','The previously uploaded CV exists for this record. Do you want to overwrite?',Question!,YesNo!,2) = 2 then
				return
			end if	
end if

value = GetFileOpenName("Select File", &
	+ docname, ls_filename, "docx", &
	 "Word Document (*.docx),*.docx," + &
	 "Word 97-2003 Document (*.doc),*.doc," + &
	 "TIFF Files (*.tif),*.tif," + &
	 "BMP Files (*.bmp),*.bmp," + &
	 "JPG Files (*.jpg),*.jpg," + &
	 "PDF Files (*.pdf),*.pdf")
	 
if value <> 1 then return

ChangeDirectory(gs_current_path)

	

li_pos = Lastpos(ls_filename,'.')
 
 ls_filetype = MidA(ls_filename,li_pos+1)

SELECT Top 1 Image_type into :ll_image_type	FROM wv_recruit_settings;

IF lb_new THEN
	
	INSERT INTO recruit_image
		(prac_id
		,image_type
		,file_name
		,file_type)
		VALUES
		(:ll_prac_id
		,:ll_image_type
		,:ls_filename
		,:ls_filetype
		);
		
ELSE
	UPDATE recruit_image
		SET image_type = :ll_image_type
		,file_name = :ls_filename
		,file_type = :ls_filetype
		Where  rec_id = :ll_rec_id;
END IF

lnv_image_functions = create pfc_cst_nv_image_functions

lb_all_data = lnv_image_functions.of_read_image_file(docname)

destroy lnv_image_functions


if lb_new then
	UpdateBlob recruit_image
	Set image_field = :lb_all_data
	Where prac_id = :ll_prac_id;
else
	UpdateBlob recruit_image
	Set image_field = :lb_all_data
	Where rec_id = :ll_rec_id;
end if

IF sqlca.SQLCode <> 0 THEN
	Messagebox( "upload cv"," Failed to upload BLOB data to DB due to "+sqlca.SQLErrText)
	rollback;
	RETURN -1
ELSE
	COMMIT;
END IF
MessageBox('upload cv','Upload CV successfully');
RETURN 1
end event

type cb_email from commandbutton within w_recruitment_data_tabs
integer x = 768
integer y = 16
integer width = 535
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Email Candidate"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.06.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string s
string ls_email_address
string ls_subject
string ls_notetext
string ls_attach
long ll_return

//---------Begin Modified by (Appeon)Stephen 01.04.2016 for BugS122901--------
//if idw_detail.getrow() < 0 then return
if idw_detail.getrow() < 1 then return
//---------End Modfiied ------------------------------------------------------

ls_email_address = idw_detail.getitemstring(1,"e_mail_address")

if isnull( ls_email_address) or ls_email_address = "" then
	Messagebox("Email Address",  "There is no email address for this Candidate")
	return 1
elseif  pos(ls_email_address, "@",1) = 0 then
	Messagebox("Email Address",  "Invalid email address for this Candidate")
	return 1	
end if



if  gi_email_type = 0 then //Start Code Change ----12.11.2012 #V12 maha - easymail changed to global variable
	open(w_general_email_send)
	w_general_email_send.sle_sendto.text = ls_email_address
elseif gi_email_type = 1 then //Start Code Change ----12.17.2012 #V12 maha - added outlook support
	n_cst_outlook lnv_Outlook
	
	Open( w_email_subject )
	IF Message.StringParm = "Cancel" THEN
		Return 1
	END IF
	
	ls_subject = Mid( Message.StringParm, 1, POS( Message.StringParm, "*" ) -1)
	ls_notetext = Mid( Message.StringParm, POS( Message.StringParm, "*" ) +1, 4000)	
	
	if lnv_Outlook.of_Logon() = -1 then
		MessageBox("Mail", "Logon failed.  Check to make sure you have an email id setup in the user painter.")
		Return 1
	end if
	
	ls_attach = ""
	ll_Return = lnv_Outlook.of_Send(ls_email_address, "", "", ls_subject, ls_notetext, ls_attach)
	lnv_Outlook.of_Logoff()
	if ll_Return <> 1 then
		MessageBox("Mail Send", "Mail not sent.")
		Return 1
	end if	

	
end if
end event

type cb_convert from commandbutton within w_recruitment_data_tabs
integer x = 37
integer y = 16
integer width = 699
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Convert to Practitioner"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.09.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_row
Integer li_recruit_status
Integer li_rtn
long ll_prac_id,ll_count
datawindow ldw_detail  //maha 06.03.2015.

ldw_detail = tab_1.tabpage_data.dw_detail_data   //Start Code Change ----06.03.2015.2015 #V15 maha

ll_row = ldw_detail.getrow( )
if ll_row <= 0 then return

//-------------appeon begin----------------------
//<$>added:long.zhang 11.06.2013
//<$>reason:V14.1 Recruitment Functionality Fix BugA110509
ldw_detail.accepttext( )
if ldw_detail.modifiedcount( ) > 0 then
	if MessageBox("Convert","Do you want to save changes?",Question!,YesNO!,1) = 1 then
		if of_save() < 0 then
			return
		end if
	end if	
end if	
//-------------appeon End------------------------

li_recruit_status = ldw_detail.getitemnumber( ll_row, 'recruit_status')

if li_recruit_status <> 1 and li_recruit_status <> 2 then
//	MessageBox('Convert Data','Invalid status ,only new or viewed status can be converted')
		MessageBox('Convert Data','Invalid status ,only new or in process status can be converted')	//long.zhang 11.06.2013 BugA110506
	return
end if

ll_prac_id = ldw_detail.getitemnumber( ll_row, 'prac_id')
if isNull(ll_prac_id) then return

//-------------appeon begin----------------------
//<$>added:long.zhang 11.06.2013
//<$>reason:V14.1 Recruitment Functionality Fix BugA110509
if ll_prac_id > 0 then
	select count(1) into:ll_count from pd_basic where prac_id = :ll_prac_id;
	if ll_count > 0 then
		if MessageBox('Convert','This record had been already converted before.~r~n Do you want to continue converting it to a new practitioner?',Question!,YesNo!,2) = 2 then
			return
		end if
	end if
end if
//------------appeon end-------------------------

n_cst_recruitmnet ln_recruit

ln_recruit = create n_cst_recruitmnet

if ln_recruit.of_setparentwindow( w_recruitment_data_tabs) = -1 then return

this.enabled = false
	li_rtn = ln_recruit.of_run()
this.enabled = true

destroy ln_recruit

if li_rtn = 1 then
	of_refresh_browse(il_loc_id)
end if
end event

type cb_delete from commandbutton within w_recruitment_data_tabs
integer x = 2368
integer y = 16
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.16.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_row
long ll_prac_id
long ll_count


choose case tab_1.selectedtab
//Start Code Change ----01.05.2016 #V15 maha - reworked code		
	case 1
		messagebox("Delete","You cannot delete from the search screen.")
		return
	case 2

		ll_row = tab_1.tabpage_data.dw_detail_data.getrow( )
		
		if ll_row <= 0 then return
		
		if MessageBox('Delete','Are you sure you want to delete this record?',question!,YesNo!,2) = 2 then return
		
		ll_prac_id = tab_1.tabpage_data.dw_detail_data.getitemnumber( ll_row,'prac_id')
		
		if not isNull(ll_prac_id) then
			
			select count(*) into :ll_count from recruit_image where prac_id = :ll_prac_id;
			
			if ll_count > 0 then
					if MessageBox('Delete','There are '+String(ll_count)+' Image record(s) connect to this record' + &
					'.~r~n delete this record will also delete them. Are you sure you really want to delete this record?',Question!,YesNo!,2) = 2 then
						return
					end if	
			end if
	
			
		end if
		
		tab_1.tabpage_data.dw_detail_data.deleterow( 0)

		gnv_appeondb.of_startqueue( )
		
		tab_1.tabpage_data.dw_detail_data.update( )
		delete from recruit_image where prac_id = :ll_prac_id;
		delete from recruit_prac_quest_answers where rec_id = :il_rec_id ;
		delete from pd_recruit_actions where rec_id = :il_rec_id ;
		gnv_appeondb.of_commitqueue( )
//End Code Change ----01.05.2016 
		
	case 3
		ll_row = tab_1.tabpage_documents.dw_docs.getrow( )
		
		if ll_row <= 0 then return
		
		if MessageBox('Delete','Are you sure you want to delete this Document?',question!,YesNo!,2) = 2 then return
		
		tab_1.tabpage_documents.dw_docs.deleterow(ll_row)
		tab_1.tabpage_documents.dw_docs.update()
		
	case 4
		ll_row = tab_1.tabpage_quest.dw_quest.getrow( )
		
		if ll_row <= 0 then return
		
		if MessageBox('Delete','Are you sure you want to delete this Question?',question!,YesNo!,2) = 2 then return
		tab_1.tabpage_quest.dw_quest.deleterow(ll_row)
		tab_1.tabpage_quest.dw_quest.update()
		
		
	case 5
		ll_row = tab_1.tabpage_tasks.dw_tasks.getrow( )
		
		if ll_row <= 0 then return
		
		if not isnull(tab_1.tabpage_tasks.dw_tasks.getitemdatetime(ll_row, "compl_date")) then
			MessageBox('Delete','Completed Actions canot be deleted')
			return
		end if
		
		if MessageBox('Delete','Are you sure you want to delete this Action?',question!,YesNo!,2) = 2 then return
		tab_1.tabpage_tasks.dw_tasks.deleterow(ll_row)
		tab_1.tabpage_tasks.dw_tasks.update()
		
end choose

end event

type cb_save from commandbutton within w_recruitment_data_tabs
integer x = 1975
integer y = 16
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.05.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
of_save()

return 0
end event

type cb_close from commandbutton within w_recruitment_data_tabs
integer x = 4041
integer y = 16
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close(&C)"
end type

event clicked;close(parent)
end event

type dw_browsexx from u_dw within w_recruitment_data_tabs
boolean visible = false
integer x = 4489
integer y = 148
integer width = 3264
integer height = 504
integer taborder = 10
string dataobject = "d_recruit_browse"
end type

event constructor;call super::constructor;this.settransobject(sqlca)

//-------------appeon begin----------------------
//<$>added:long.zhang 10.12.2013
//<$>reason:V14.1 Recruitment Functionality BugS101108
This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.inv_sort.of_SetColumnDisplayNameStyle( 2 )

This.of_SetFilter(True)
This.inv_Filter.of_SetStyle(1)
//-------------appeon End------------------------
end event

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	value    long    currentrow
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 10.12.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================



if currentrow > 0 then
	il_loc_id = this.getitemnumber(currentrow, "rec_id")
	//dw_detail.retrieve(il_loc_id)
else
	//cb_add.event clicked()
	//dw_detail.reset( )
end if	

this.selectrow(0,false)
this.selectrow(currentrow,true)
this.scrolltorow(currentrow)
end event

event clicked;call super::clicked;long r

r = this.getclickedrow()
this.setrow(r)



end event

type tab_1 from tab within w_recruitment_data_tabs
integer y = 128
integer width = 4439
integer height = 2188
integer taborder = 40
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
tabpage_search tabpage_search
tabpage_data tabpage_data
tabpage_documents tabpage_documents
tabpage_quest tabpage_quest
tabpage_tasks tabpage_tasks
end type

on tab_1.create
this.tabpage_search=create tabpage_search
this.tabpage_data=create tabpage_data
this.tabpage_documents=create tabpage_documents
this.tabpage_quest=create tabpage_quest
this.tabpage_tasks=create tabpage_tasks
this.Control[]={this.tabpage_search,&
this.tabpage_data,&
this.tabpage_documents,&
this.tabpage_quest,&
this.tabpage_tasks}
end on

on tab_1.destroy
destroy(this.tabpage_search)
destroy(this.tabpage_data)
destroy(this.tabpage_documents)
destroy(this.tabpage_quest)
destroy(this.tabpage_tasks)
end on

event selectionchanged;
if newindex = 1 then
	cb_convert.enabled = false
else
	cb_convert.enabled = true
end if
end event

type tabpage_search from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4402
integer height = 2072
long backcolor = 33551856
string text = "Search"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
cb_clear cb_clear
dw_assigned dw_assigned
dw_pos dw_pos
cb_add_rec cb_add_rec
rb_all rb_all
cb_select cb_select
ddlb_search ddlb_search
cb_select_to_new cb_select_to_new
dw_dates dw_dates
cb_search cb_search
rb_inc rb_inc
sle_srch_val sle_srch_val
rb_new rb_new
rb_viewed rb_viewed
rb_acc rb_acc
rb_dec rb_dec
dw_search dw_search
gb_status gb_status
gb_search gb_search
gb_1 gb_1
gb_3 gb_3
gb_4 gb_4
end type

on tabpage_search.create
this.cb_clear=create cb_clear
this.dw_assigned=create dw_assigned
this.dw_pos=create dw_pos
this.cb_add_rec=create cb_add_rec
this.rb_all=create rb_all
this.cb_select=create cb_select
this.ddlb_search=create ddlb_search
this.cb_select_to_new=create cb_select_to_new
this.dw_dates=create dw_dates
this.cb_search=create cb_search
this.rb_inc=create rb_inc
this.sle_srch_val=create sle_srch_val
this.rb_new=create rb_new
this.rb_viewed=create rb_viewed
this.rb_acc=create rb_acc
this.rb_dec=create rb_dec
this.dw_search=create dw_search
this.gb_status=create gb_status
this.gb_search=create gb_search
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_4=create gb_4
this.Control[]={this.cb_clear,&
this.dw_assigned,&
this.dw_pos,&
this.cb_add_rec,&
this.rb_all,&
this.cb_select,&
this.ddlb_search,&
this.cb_select_to_new,&
this.dw_dates,&
this.cb_search,&
this.rb_inc,&
this.sle_srch_val,&
this.rb_new,&
this.rb_viewed,&
this.rb_acc,&
this.rb_dec,&
this.dw_search,&
this.gb_status,&
this.gb_search,&
this.gb_1,&
this.gb_3,&
this.gb_4}
end on

on tabpage_search.destroy
destroy(this.cb_clear)
destroy(this.dw_assigned)
destroy(this.dw_pos)
destroy(this.cb_add_rec)
destroy(this.rb_all)
destroy(this.cb_select)
destroy(this.ddlb_search)
destroy(this.cb_select_to_new)
destroy(this.dw_dates)
destroy(this.cb_search)
destroy(this.rb_inc)
destroy(this.sle_srch_val)
destroy(this.rb_new)
destroy(this.rb_viewed)
destroy(this.rb_acc)
destroy(this.rb_dec)
destroy(this.dw_search)
destroy(this.gb_status)
destroy(this.gb_search)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_4)
end on

type cb_clear from commandbutton within tabpage_search
integer x = 1614
integer y = 236
integer width = 233
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear"
end type

event clicked;date d

setnull(d)

dw_dates.setitem(1,"from_date",d)
dw_dates.setitem(1,"to_date",d)
end event

type dw_assigned from u_dw within tabpage_search
integer x = 3031
integer y = 64
integer width = 777
integer height = 84
integer taborder = 21
string dataobject = "d_recruiter_select"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;datawindowchild dwchild

this.settransobject(sqlca)
this.retrieve()

this.getchild( "rec_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.insertrow(1)
dwchild.setitem(1, "rec_id", 0)
this.setitem(1, "rec_id", 0)

this.of_setupdateable( false)
end event

event itemchanged;call super::itemchanged;il_recrt = long(data)
end event

type dw_pos from u_dw within tabpage_search
integer x = 2025
integer y = 64
integer width = 859
integer height = 76
integer taborder = 11
string dataobject = "d_recruit_pos_4_dddw"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;datawindowchild dwchild

this.settransobject(sqlca)
this.retrieve()

this.getchild( "pos_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.insertrow(1)
dwchild.setitem(1, "pos_id", 0)
this.setitem(1, "pos_id", 0)

this.of_setupdateable( false)
end event

event itemchanged;call super::itemchanged;il_pos = long(data)
end event

type cb_add_rec from commandbutton within tabpage_search
integer x = 3003
integer y = 200
integer width = 343
integer height = 92
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "New"
end type

event clicked; //Start Code Change ----12.18.2015 #V15 maha
of_save()

tab_1.selecttab(2)
of_reset_tabs( )
tab_1.tabpage_data.dw_detail_data.insertrow( 0)
tab_1.tabpage_data.dw_detail_data.setitem( 1,'recruit_status',1)
tab_1.tabpage_data.dw_detail_data.setitem( 1,'add_date',datetime(today(),now()))
end event

type rb_all from radiobutton within tabpage_search
integer x = 1710
integer y = 68
integer width = 174
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All"
end type

type cb_select from commandbutton within tabpage_search
integer x = 3003
integer y = 424
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select"
end type

event clicked;long ll_rec
long ll_prac

if dw_search.getrow() < 1 then return
debugbreak()
ll_rec = dw_search.getitemnumber(dw_search.getrow(),"rec_id")
ll_prac = dw_search.getitemnumber(dw_search.getrow(),"prac_id")
il_recrt = dw_search.getitemnumber(dw_search.getrow(),"recruiter_assn") 
il_prac = ll_prac
il_rec_id = ll_rec
tab_1.tabpage_data.dw_detail_data.retrieve(ll_rec)
tab_1.tabpage_documents.dw_docs.retrieve(ll_prac)
tab_1.tabpage_quest.dw_quest.retrieve(ll_rec)
tab_1.tabpage_tasks.dw_tasks.retrieve(ll_rec)

tab_1.selecttab(2)




end event

type ddlb_search from dropdownlistbox within tabpage_search
integer x = 2016
integer y = 252
integer width = 873
integer height = 396
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string item[] = {"Last Name","NPI #","SSN",""}
borderstyle borderstyle = stylelowered!
end type

type cb_select_to_new from commandbutton within tabpage_search
event uo_select_tab_2 ( )
integer x = 3369
integer y = 424
integer width = 613
integer height = 92
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select to New Window"
end type

event clicked;long ll_rec
long ll_prac
string ls_name

w_recruitment_data_tabs lw_rec

ll_rec = dw_search.getitemnumber(dw_search.getrow(),"rec_id")
ll_prac = dw_search.getitemnumber(dw_search.getrow(),"prac_id")
ls_name = dw_search.getitemstring(dw_search.getrow(),"last_name") + ", " +  dw_search.getitemstring(dw_search.getrow(),"first_name")

open(lw_rec)
lw_rec.il_prac = ll_prac
lw_rec.il_rec_id = ll_rec
lw_rec.title = ls_name


lw_rec.tab_1.tabpage_search.hide()
//lw_rec.setredraw(false)
lw_rec.tab_1.tabpage_data.dw_detail_data.retrieve(ll_rec)
lw_rec.tab_1.tabpage_documents.dw_docs.retrieve(ll_prac)
lw_rec.tab_1.tabpage_tasks.dw_tasks.retrieve(ll_rec)
lw_rec.tab_1.tabpage_quest.dw_quest.retrieve(ll_rec)
//lw_rec.setredraw(true)
lw_rec.postevent ("ue_select_tab_2")



end event

type dw_dates from u_dw within tabpage_search
integer x = 123
integer y = 232
integer width = 1467
integer height = 104
integer taborder = 11
string dataobject = "d_date_range_get_blue"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(true)

this.settransobject(sqlca)
this.insertrow(1)

this.of_setupdateable( false)
end event

type cb_search from commandbutton within tabpage_search
integer x = 3003
integer y = 316
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Search"
boolean default = true
end type

event clicked;

of_set_syntax()
//tab_1.tabpage_search.dw_search.settransobject( sqlca)
//tab_1.tabpage_search.dw_search.retrieve()
end event

type rb_inc from radiobutton within tabpage_search
integer x = 1298
integer y = 68
integer width = 370
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Incomplete"
end type

type sle_srch_val from singlelineedit within tabpage_search
integer x = 2016
integer y = 344
integer width = 873
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type rb_new from radiobutton within tabpage_search
integer x = 123
integer y = 68
integer width = 219
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "New"
boolean checked = true
end type

type rb_viewed from radiobutton within tabpage_search
integer x = 357
integer y = 68
integer width = 265
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Viewed"
end type

type rb_acc from radiobutton within tabpage_search
integer x = 654
integer y = 68
integer width = 311
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Accepted"
end type

type rb_dec from radiobutton within tabpage_search
integer x = 978
integer y = 68
integer width = 293
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Declined"
end type

type dw_search from datawindow within tabpage_search
integer y = 536
integer width = 4398
integer height = 1536
integer taborder = 50
string title = "none"
string dataobject = "d_recruit_browse"
boolean hscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;if currentrow > 0 then
	il_loc_id = this.getitemnumber(currentrow, "rec_id")
	//dw_detail.retrieve(il_loc_id)
else
	//cb_add.event clicked()
	//dw_detail.reset( )
end if	

this.selectrow(0,false)
this.selectrow(currentrow,true)
this.scrolltorow(currentrow)
end event

event doubleclicked;cb_select.triggerevent(clicked!)
end event

type gb_status from groupbox within tabpage_search
integer x = 78
integer y = 8
integer width = 1829
integer height = 160
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Status Filter"
end type

type gb_search from groupbox within tabpage_search
integer x = 1975
integer y = 180
integer width = 969
integer height = 272
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Search On:"
end type

type gb_1 from groupbox within tabpage_search
integer x = 1966
integer y = 8
integer width = 978
integer height = 156
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Position"
end type

type gb_3 from groupbox within tabpage_search
integer x = 2999
integer y = 8
integer width = 841
integer height = 156
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Recruiter Assigned"
end type

type gb_4 from groupbox within tabpage_search
integer x = 78
integer y = 184
integer width = 1824
integer height = 164
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Added Date"
end type

type tabpage_data from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4402
integer height = 2072
long backcolor = 33551856
string text = "Data"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
dw_detail_data dw_detail_data
end type

on tabpage_data.create
this.dw_detail_data=create dw_detail_data
this.Control[]={this.dw_detail_data}
end on

on tabpage_data.destroy
destroy(this.dw_detail_data)
end on

type dw_detail_data from u_dw within tabpage_data
integer width = 4398
integer height = 2072
integer taborder = 11
string dataobject = "d_recruit_detail_tab"
boolean vscrollbar = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	value    long        row
// 	value    long        actionreturncode
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.05.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_text
long ll_recid
string ls_name
	
if row = 0 then return

if dwo.name = 'b_notes' then
	of_expandnotes(row,'notes')
elseif dwo.name = 'b_comment' then
	of_expandnotes(row,'addtl_comments')
end if

if dwo.name = 'b_find' then
	//open(w_recruiter_find)
	openwithparm(w_recruiter_find, "S")  //Start Code Change ----04.01.2016 #V15 maha
	gs_pass_ids lst_pass
	if message.stringparm = "Cancel" then return 
	
	lst_pass = message.powerobjectparm
	//Start Code Change ----04.01.2016 #V15 maha
	ll_recid = lst_pass.l_ids[1] 
	ls_name =  lst_pass.s_doc_ids[1]
//	ll_recid = lst_pass.prac_id
//	ls_name =  lst_pass.s_stringval
	//End Code Change ----04.01.2016
	this.setitem(1,"recruiter_assn", ll_recid)
	this.setitem(1,"recruiter_assn_name", ls_name)
	il_recrt = ll_recid   //Start Code Change ----02.13.2017 #V153 maha
end if
end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(true)
end event

event pfc_update;call super::pfc_update;// //Start Code Change ----12.18.2015 #V15 maha - copied from original window
//long ll_rowcount
//long ll_i
//long ll_prac_id
//
//setNull(ll_prac_id)
//
//ll_rowcount = this.rowcount( )
//For ll_i = 1 to ll_rowcount
//	
//	 //Start Code Change ----12.22.2015 #V15 maha - moved from inside newmodified
//	ll_prac_id = this.getitemnumber( ll_i,'prac_id')
//	if isNull(ll_prac_id) or ll_prac_id = 0 then
//		ll_prac_id = of_getpracid()
//		this.setitem( ll_i,'prac_id',ll_prac_id)
//	end if
//	
//	if this.getitemstatus( ll_i,0,primary!) = NewModified! then
//		
////		if isNull(ll_prac_id) then
////			ll_prac_id = of_getpracid()
////		else
////			ll_prac_id --
////		end if
//		
////		this.setitem( ll_i,'prac_id',ll_prac_id)
// //End Code Change ----12.22.2015
//		this.setitem( ll_i,'status_change_date',datetime(today(),now()))//Added by Appeon long.zhang 11.06.2013 (V14.1 Recruitment Functionality) BugA110510
//		this.setitem( ll_i,'add_date',datetime(today(),now()))	
//		
//	elseif 	this.getitemstatus( ll_i,0,primary!) = DataModified! then
//		
//		this.setitem( ll_i,'mod_date',datetime(today(),now()))
//		this.setitem( ll_i,'mod_by',gs_user_id)
//		
//		if this.getitemstatus(ll_i,'recruit_status',primary!) = DataModified! then//Added by Appeon long.zhang 11.06.2013 (V14.1 Recruitment Functionality) BugA110510
//				this.setitem( ll_i,'status_change_date',datetime(today(),now()))
//		end if
//		
//	end if
//	
//end for

return 1
end event

event pfc_preupdate;call super::pfc_preupdate; //Start Code Change ----12.18.2015 #V15 maha - copied from original window
long ll_rowcount
long ll_i
long ll_prac_id

setNull(ll_prac_id)

ll_rowcount = this.rowcount( )
For ll_i = 1 to ll_rowcount
	
	 //Start Code Change ----12.22.2015 #V15 maha - moved from inside newmodified
	ll_prac_id = this.getitemnumber( ll_i,'prac_id')
	if isNull(ll_prac_id) or ll_prac_id = 0 then
		ll_prac_id = of_getpracid()
		this.setitem( ll_i,'prac_id',ll_prac_id)
		il_prac = ll_prac_id
	end if
	
	if this.getitemstatus( ll_i,0,primary!) = NewModified! then
		
//		if isNull(ll_prac_id) then
//			ll_prac_id = of_getpracid()
//		else
//			ll_prac_id --
//		end if
		
//		this.setitem( ll_i,'prac_id',ll_prac_id)
 //End Code Change ----12.22.2015
		this.setitem( ll_i,'status_change_date',datetime(today(),now()))//Added by Appeon long.zhang 11.06.2013 (V14.1 Recruitment Functionality) BugA110510
		this.setitem( ll_i,'add_date',datetime(today(),now()))	
		
	elseif 	this.getitemstatus( ll_i,0,primary!) = DataModified! then
		
		this.setitem( ll_i,'mod_date',datetime(today(),now()))
		this.setitem( ll_i,'mod_by',gs_user_id)
		
		if this.getitemstatus(ll_i,'recruit_status',primary!) = DataModified! then//Added by Appeon long.zhang 11.06.2013 (V14.1 Recruitment Functionality) BugA110510
				this.setitem( ll_i,'status_change_date',datetime(today(),now()))
		end if
		
	end if
	
end for

return 1
end event

event pfc_postupdate;call super::pfc_postupdate;il_rec_id = this.getitemnumber(1,"rec_id")  //Start Code Change ----01.05.2016 #V15 maha

return 1
end event

type tabpage_documents from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4402
integer height = 2072
long backcolor = 33551856
string text = "Documents"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
cb_add_doc cb_add_doc
dw_docs dw_docs
cb_view_doc cb_view_doc
end type

on tabpage_documents.create
this.cb_add_doc=create cb_add_doc
this.dw_docs=create dw_docs
this.cb_view_doc=create cb_view_doc
this.Control[]={this.cb_add_doc,&
this.dw_docs,&
this.cb_view_doc}
end on

on tabpage_documents.destroy
destroy(this.cb_add_doc)
destroy(this.dw_docs)
destroy(this.cb_view_doc)
end on

type cb_add_doc from commandbutton within tabpage_documents
integer x = 1929
integer y = 8
integer width = 439
integer height = 92
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Document"
end type

event clicked;integer nr

nr = dw_docs.insertrow(0)

dw_docs.setitem(nr, "prac_id",il_prac)

end event

type dw_docs from datawindow within tabpage_documents
integer y = 108
integer width = 4402
integer height = 1964
integer taborder = 60
string title = "none"
string dataobject = "d_recruit_image_list"
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)

this.setrowfocusindicator( p_1)   //Start Code Change ----01.04.2016 #V15 maha
end event

event buttonclicked; //Start Code Change ----03.18.2015 #V15 maha
long ll_prac_id
long ll_row
long ll_image_type
long ll_rec_id
long ll_data_length
integer value, li_pos, li_return,li_start
String docname,ls_filename,named,ls_filetype
boolean lb_new
pfc_cst_nv_image_functions  lnv_image_functions
Blob lb_all_data
debugbreak()
if row < 1 then return

ll_image_type = this.getitemnumber(row, "image_type")
if isnull(ll_image_type) then
	MessageBox('Upload Document','Please select the image type before uploading.')
	return
end if

ll_prac_id  = tab_1.tabpage_data.dw_detail_data.getitemnumber( 1,'prac_id')

if isNull(ll_prac_id) then 
	MessageBox('Upload Document','Data error, the Candidate record has no prac_id.')
	return
end if

//maha 03.18.2015 - modified to include the image type
//SELECT Top 1 rec_id INTO :ll_rec_id
//FROM recruit_image 
//Where prac_id = :ll_prac_id and image_type = :ll_image_type;
//	
//if sqlca.sqlcode = 100 then
//	lb_new = true
//elseif sqlca.sqlcode < 0 then
//	Messagebox( "Upload Image"," - Unable to connect to DB due to "+sqlca.SQLErrText)
//	return -1
//end if
//THIS NEEDS WORK!!!!!!!!!!!!


if isnull(this.getitemstring(row, "file_name")) then
	lb_new = true
end if

if not lb_new then
	if MessageBox('Upload Document','The previously uploaded document exists for this Image Type. Do you want to overwrite?',Question!,YesNo!,2) = 2 then
		return
	end if	
end if

value = GetFileOpenName("Select File", &
	+ docname, ls_filename, "docx", &
	 "Word Document (*.docx),*.docx," + &
	 "Word 97-2003 Document (*.doc),*.doc," + &
	 "TIFF Files (*.tif),*.tif," + &
	 "BMP Files (*.bmp),*.bmp," + &
	 "JPG Files (*.jpg),*.jpg," + &
	 "PDF Files (*.pdf),*.pdf")
	 
if value <> 1 then return

ChangeDirectory(gs_current_path)

	

li_pos = Lastpos(ls_filename,'.')
 
 ls_filetype = MidA(ls_filename,li_pos+1)

//SELECT Top 1 Image_type into :ll_image_type	FROM wv_recruit_settings;

this.setitem(row, "image_type",  ll_image_type)
this.setitem(row, "prac_id",  ll_prac_id)
this.setitem(row, "file_name",  ls_filename)
this.setitem(row, "file_type",  ls_filetype)

//IF lb_new THEN
//	
//	INSERT INTO recruit_image
//		(prac_id
//		,image_type
//		,file_name
//		,file_type)
//		VALUES
//		(:ll_prac_id
//		,:ll_image_type
//		,:ls_filename
//		,:ls_filetype
//		);
//		
//ELSE
//	UPDATE recruit_image
//		SET image_type = :ll_image_type
//		,file_name = :ls_filename
//		,file_type = :ls_filetype
//		Where  rec_id = :ll_rec_id;
//END IF

this.update()

ll_rec_id = this.getitemnumber(row, "rec_id")

lnv_image_functions = create pfc_cst_nv_image_functions

lb_all_data = lnv_image_functions.of_read_image_file(docname)

destroy lnv_image_functions


//if lb_new then
//	UpdateBlob recruit_image
//	Set image_field = :lb_all_data
//	Where prac_id = :ll_prac_id and image_type = :ll_image_type;
//else
	UpdateBlob recruit_image
	Set image_field = :lb_all_data
	Where rec_id = :ll_rec_id;
//end if

IF sqlca.SQLCode <> 0 THEN
	Messagebox( "Upload Document"," Failed to upload Document data to DB due to "+sqlca.SQLErrText)
	rollback;
	RETURN -1
ELSE
	COMMIT;
END IF
//MUST RERETRIEVEW THE DOCUMENTS DATA
this.setitem(row, "img_size", 1)  //Start Code Change ----01.05.2016 #V15 maha - to set checkmark

MessageBox('Upload Document','Uploaded Document successfully')

RETURN 1
end event

event itemchanged;//need to check for a duplicate
end event

event rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 12.15.2015 (fix test bug)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if currentrow < 1 then return

//this.selectrow(0, false)   //Start Code Change ----01.04.2016 #V15 maha - removed
//this.selectrow(currentrow, true)
this.setrow(currentrow)
this.scrolltorow(currentrow)

end event

event clicked;event rowfocuschanged(row)
end event

type cb_view_doc from commandbutton within tabpage_documents
integer x = 2377
integer y = 8
integer width = 439
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Document"
end type

event clicked;
//---------Begin Modified by (Appeon)Stephen 12.15.2015 for BugS112701--------
//of_download_image(il_prac)
long     ll_rec_id
integer li_row

li_row = dw_docs.getrow()
if li_row < 1 then return
ll_rec_id = dw_docs.getitemnumber(li_row, "rec_id")
of_download_image(il_prac, ll_rec_id)
//---------End Modified ------------------------------------------------------


end event

type tabpage_quest from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4402
integer height = 2072
long backcolor = 33551856
string text = "Questions"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
cb_calc cb_calc
cb_6 cb_6
dw_quest dw_quest
end type

on tabpage_quest.create
this.cb_calc=create cb_calc
this.cb_6=create cb_6
this.dw_quest=create dw_quest
this.Control[]={this.cb_calc,&
this.cb_6,&
this.dw_quest}
end on

on tabpage_quest.destroy
destroy(this.cb_calc)
destroy(this.cb_6)
destroy(this.dw_quest)
end on

type cb_calc from commandbutton within tabpage_quest
integer x = 2318
integer y = 8
integer width = 462
integer height = 92
integer taborder = 41
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Calc Qualify Score"
end type

event clicked; //Start Code Change ----04.01.2015 #V15 maha
integer r
long ll_val
long ll_total


of_calc_values(0)  //set the answer values

for r = 1 to dw_quest.rowcount()
	ll_val = dw_quest.getitemnumber(r,"answer_value")
	if ll_val > 0 then ll_total+= ll_val
next

messagebox("Total Score",ll_total)
tab_1.tabpage_data.dw_detail_data.setitem(1,"qualify_score",ll_total)



end event

type cb_6 from commandbutton within tabpage_quest
integer x = 1906
integer y = 8
integer width = 398
integer height = 92
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Questions"
end type

event clicked; //Start Code Change ----03.26.2015 #V15 maha
gs_pass_ids lst_ids
long ll_qid[]
long ll_pk
integer r
integer nr


open(w_recruit_quest_select)
//---------Begin Modified by (Appeon)Stephen 05.23.2016 for Recruitment Module Bug Case#63973 Bug_id#5169 Version 15.1 Build 05/05/2016--------
/*
if message.stringparm = "Cancel" then return
lst_ids = message.powerobjectparm
*/
lst_ids = message.powerobjectparm
if lst_ids.ls_ref_value = "Cancel" then return
//---------End Modfiied ------------------------------------------------------

ll_qid = lst_ids.l_ids

select max(rpa_pk) into :ll_pk from recruit_quest_prac_answers;
if isnull(ll_pk) then ll_pk = 0

for r = 1 to upperbound(ll_qid)
	nr = dw_quest.insertrow	(0)
	dw_quest.setitem(nr,"qt_id",ll_qid[r])
	ll_pk++
	dw_quest.setitem(nr,"rpa_pk",ll_pk)
	dw_quest.setitem(nr,"rec_id",il_rec_id)
next

dw_quest.update()

dw_quest.retrieve(il_rec_id)  //refresh the data for calcs







end event

type dw_quest from datawindow within tabpage_quest
integer y = 120
integer width = 4402
integer height = 1952
integer taborder = 20
string title = "none"
string dataobject = "d_recruit_candidate_answers"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)

this.setrowfocusindicator( p_1)   //Start Code Change ----01.04.2016 #V15 maha
end event

event itemchanged;if dwo.name = "ans_id" then
	of_calc_values( row)
end if
end event

event clicked; //Start Code Change ----11.10.2015 #V15 maha - 
 integer r
 
r = this.getclickedrow()
this.setrow(r)
//this.selectrow(0,false)
//this.selectrow(r,True)
end event

type tabpage_tasks from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4402
integer height = 2072
long backcolor = 33551856
string text = "Tasks/Schedules"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
dw_tasks dw_tasks
rb_all_stat rb_all_stat
rb_compl rb_compl
rb_open rb_open
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
gb_2 gb_2
end type

on tabpage_tasks.create
this.dw_tasks=create dw_tasks
this.rb_all_stat=create rb_all_stat
this.rb_compl=create rb_compl
this.rb_open=create rb_open
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.gb_2=create gb_2
this.Control[]={this.dw_tasks,&
this.rb_all_stat,&
this.rb_compl,&
this.rb_open,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.gb_2}
end on

on tabpage_tasks.destroy
destroy(this.dw_tasks)
destroy(this.rb_all_stat)
destroy(this.rb_compl)
destroy(this.rb_open)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.gb_2)
end on

type dw_tasks from u_dw within tabpage_tasks
integer y = 196
integer width = 2811
integer height = 1876
integer taborder = 21
string dataobject = "d_recruit_action_detail"
end type

event constructor;call super::constructor;datawindowchild dwchild

this.of_SetDropDownCalendar(true)
this.settransobject(sqlca)
this.setrowfocusindicator( p_1)   //Start Code Change ----01.04.2016 #V15 maha

this.getchild( "pos_id", dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve()
end event

event clicked;call super::clicked;integer r

r = this.getclickedrow()
this.setrow(r)
end event

event buttonclicked;call super::buttonclicked; //Start Code Change ----02.13.2017 #V153 maha
string s

if dwo.name = "b_notes" then
	s = This.GetItemString( row, "notes" )
	if isnull(s) then s = ""
	
	OpenWithParm( w_ai_notes_new,  "C#" + s)

	
	IF Message.StringParm = "Cancel" THEN
		Return -1
	ELSE
		s = Message.StringParm
		This.SetItem( row, "notes" , s)
	END IF	
	
end if

if dwo.name = "b_follow" then
	s = This.GetItemString( row, "followup" )
	if isnull(s) then s = ""
	
	OpenWithParm( w_ai_notes_new,  "C#" + s)
	
	IF Message.StringParm = "Cancel" THEN
		Return -1
	ELSE
		s = Message.StringParm
		This.SetItem( row, "followup" , s)
	END IF		
end if


	
	

	








end event

type rb_all_stat from radiobutton within tabpage_tasks
integer x = 974
integer y = 76
integer width = 233
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "All"
boolean checked = true
end type

event clicked;of_filter_tasks("A")
end event

type rb_compl from radiobutton within tabpage_tasks
integer x = 494
integer y = 76
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Completed"
end type

event clicked;of_filter_tasks("C")
end event

type rb_open from radiobutton within tabpage_tasks
integer x = 155
integer y = 76
integer width = 306
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Open"
end type

event clicked;of_filter_tasks("O")
end event

type cb_5 from commandbutton within tabpage_tasks
boolean visible = false
integer x = 3433
integer y = 552
integer width = 347
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Action"
end type

event clicked;integer r

r = dw_tasks.getrow()
if r < 1 then return

if not isnull(dw_tasks.getitemdatetime(r, "compl_date")) then
	MessageBox('Delete','Completed Actions canot be deleted')
	return
end if

if MessageBox('Delete','Are you sure you want to delete this record',question!,YesNo!,2) = 2 then return

dw_tasks.deleterow(r)

dw_tasks.update()






end event

type cb_4 from commandbutton within tabpage_tasks
integer x = 2267
integer y = 52
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Action"
end type

event clicked;integer nr

long ll_pos
long ll_id
if tab_1.tabpage_data.dw_detail_data.getrow() <= 0 then Return // (Appeon)Harry 03.31.2016 for BugH033101
ll_pos = tab_1.tabpage_data.dw_detail_data.getitemnumber(1,"recruit_pos")

//select max(act_id) into :ll_id from pd_recruit_actions;
//if isnull(ll_id) then ll_id = 0
//ll_id++

nr = dw_tasks.insertrow(0)
dw_tasks.scrolltorow(nr)
dw_tasks.setrow(nr)
//dw_tasks.setitem(nr,"act_id",ll_id)
dw_tasks.setitem(nr,"prac_id",il_prac)
dw_tasks.setitem(nr,"rec_id",il_rec_id)
dw_tasks.setitem(nr,"pos_id",ll_pos)	
//messagebox("il_recrt",il_recrt)
if il_recrt > 0 then dw_tasks.setitem(nr,"recruiter_assigned", il_recrt)   //Start Code Change ----02.13.2017 #V153 maha - corrected variable




end event

type cb_3 from commandbutton within tabpage_tasks
integer x = 1906
integer y = 52
integer width = 361
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Checklist"
end type

event clicked;long ll_temp
long ll_id
long ll_pk
long ll_pos
long ll_act
integer tc
integer t
integer nr
integer cnt
string ls_desc
long ll_action_status //maha 01.05.2015
n_ds lds_temp

open(w_select_checklist)

if message.stringparm = "Cancel" then
	messagebox("","Cancel")
	return
else
	ll_temp = message.doubleparm
	if ll_temp > 0 then
			//get list of template items
		lds_temp = CREATE n_ds  
		lds_temp.dataobject = "d_app_audit_rqrd_data_add"   //Start Code Change ----10.20.2015 #V15 maha - changed object
		lds_temp.settransobject(sqlca)
		tc = lds_temp.retrieve(ll_temp)
		
		ll_pos = tab_1.tabpage_data.dw_detail_data.getitemnumber(1,"recruit_pos")
		//add records to action dw
		//act id is auto increment
//		select max(act_id) into :ll_id from pd_recruit_actions;
//		if isnull(ll_id) then ll_id = 0
		
		//Start Code Change ----01.05.2016 #V15 maha
		select lookup_code into :ll_action_status from code_lookup where lookup_name = 'Action Status' and code = 'Incomplete';
		IF SQLCA.SQLCODE = 100 THEN
			MessageBox("Error", "There is no 'Incomplete' in the Action Status lookup table. The status will not be set." )
		END IF
		//End Code Change ----01.05.2016
		
		for t = 1 to tc
			ll_id = lds_temp.getitemnumber(t,"app_audit_id")
			ls_desc = lds_temp.getitemstring(t,"description")
			ll_act = lds_temp.getitemnumber(t,"act_type")
			nr = dw_tasks.insertrow(0)
			dw_tasks.setitem(nr,"clist_item_id",ll_id)
			dw_tasks.setitem(nr,"action_description",ls_desc)
			dw_tasks.setitem(nr,"prac_id",il_prac)
			dw_tasks.setitem(nr,"rec_id",il_rec_id)
			dw_tasks.setitem(nr,"pos_id",ll_pos)	
			dw_tasks.setitem(nr,"action_type",ll_act)	
			if il_recrt > 0 then dw_tasks.setitem(nr,"recruiter_assigned",il_recrt)   //Start Code Change ----02.13.2017 #V153 maha - corrected variable
			
			//Start Code Change ----01.05.2016 #V15 maha	
			if ll_action_status > 0 then
				dw_tasks.setitem(nr,"action_status",ll_action_status)	
			end if
			//End Code Change ----01.05.2016 
			
//			ll_id++
//			dw_tasks.setitem(nr,"act_id",ll_id)
			cnt++
			
		next
		
		destroy lds_temp
		

	end if
end if

end event

type gb_2 from groupbox within tabpage_tasks
integer x = 91
integer y = 16
integer width = 1152
integer height = 156
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Status"
end type

type cb_view from commandbutton within w_recruitment_data_tabs
boolean visible = false
integer x = 4512
integer y = 660
integer width = 174
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View CV"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.06.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_prac_id, ll_rec_id

if idw_detail.getrow( ) <= 0 then return 

ll_prac_id = idw_detail.getitemnumber( idw_detail.getrow( ),'prac_id')

if isNull(ll_prac_id) then return

of_download_image(ll_prac_id, ll_rec_id)

end event

type ddlb_filter from dropdownlistbox within w_recruitment_data_tabs
boolean visible = false
integer x = 41
integer y = 16
integer width = 690
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"All","Accepted","Declined","Incomplete","New","Viewed"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;
choose case index
	case 1   //all
		is_filter = ""
	case 2   //accepted
		is_filter = "recruit_status = 3"
	case 3   //declined
		is_filter = "recruit_status = 0"
	case 4   //incomplete
		is_filter = "recruit_status = -1"
	case 5   //new
		is_filter = "recruit_status = 1"
	case 6   //Viewed
		is_filter = "recruit_status = 2"
end choose

of_filter_status()
end event

type st_1 from statictext within w_recruitment_data_tabs
integer x = 55
integer y = 36
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 32891346
string text = "Status Filter:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_detailsxxx from u_dw within w_recruitment_data_tabs
boolean visible = false
integer x = 1509
integer y = 4
integer width = 187
integer height = 88
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_recruit_detail"
boolean vscrollbar = false
end type

event buttonclicked;call super::buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	value    long        row
// 	value    long        actionreturncode
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.05.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//String ls_text
//	
//if row = 0 then return
//
//if dwo.name = 'b_notes' then
//	
//	of_expandnotes(row,'notes')
//elseif dwo.name = 'b_comment' then
//	
//	of_expandnotes(row,'addtl_comments')
//		
//end if
end event

event pfc_preupdate;call super::pfc_preupdate;////====================================================================
////$<Event>: pfc_preupdate
////$<Arguments>:
////$<Return>:  integer
////$<Description>: 
////$<Author>: (Appeon) long.zhang 09.16.2013 (V14.1 Recruitment Functionality)
////--------------------------------------------------------------------
////$<Modify History>:
////====================================================================
//long ll_rowcount
//long ll_i
//long ll_prac_id
//
//setNull(ll_prac_id)
////
//ll_rowcount = dw_detail.rowcount( )
//For ll_i = 1 to ll_rowcount
//	
//	if this.getitemstatus( ll_i,0,primary!) = NewModified! then
//		
//		if isNull(ll_prac_id) then
//			ll_prac_id = of_getpracid()
//		else
//			ll_prac_id --
//		end if
//		
//		this.setitem( ll_i,'prac_id',ll_prac_id)
//		this.setitem( ll_i,'status_change_date',datetime(today(),now()))//Added by Appeon long.zhang 11.06.2013 (V14.1 Recruitment Functionality) BugA110510
//		this.setitem( ll_i,'add_date',datetime(today(),now()))	
//		
//	elseif 	this.getitemstatus( ll_i,0,primary!) = DataModified! then
//		
//		this.setitem( ll_i,'mod_date',datetime(today(),now()))
//		this.setitem( ll_i,'mod_by',gs_user_id)
//		
//		if this.getitemstatus(ll_i,'recruit_status',primary!) = DataModified! then//Added by Appeon long.zhang 11.06.2013 (V14.1 Recruitment Functionality) BugA110510
//				this.setitem( ll_i,'status_change_date',datetime(today(),now()))
//		end if
//		
//	end if
//	
//end for
//
return 1
end event

