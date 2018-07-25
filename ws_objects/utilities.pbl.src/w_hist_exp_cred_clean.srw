$PBExportHeader$w_hist_exp_cred_clean.srw
forward
global type w_hist_exp_cred_clean from window
end type
type st_liccnt2 from statictext within w_hist_exp_cred_clean
end type
type cb_3 from commandbutton within w_hist_exp_cred_clean
end type
type cb_1 from commandbutton within w_hist_exp_cred_clean
end type
type st_8 from statictext within w_hist_exp_cred_clean
end type
type st_7 from statictext within w_hist_exp_cred_clean
end type
type st_6 from statictext within w_hist_exp_cred_clean
end type
type st_5 from statictext within w_hist_exp_cred_clean
end type
type st_deacnt2 from statictext within w_hist_exp_cred_clean
end type
type st_inscnt2 from statictext within w_hist_exp_cred_clean
end type
type st_vercnt from statictext within w_hist_exp_cred_clean
end type
type st_1 from statictext within w_hist_exp_cred_clean
end type
type st_inscnt from statictext within w_hist_exp_cred_clean
end type
type st_deacnt from statictext within w_hist_exp_cred_clean
end type
type st_dea from statictext within w_hist_exp_cred_clean
end type
type st_insurance from statictext within w_hist_exp_cred_clean
end type
type st_license from statictext within w_hist_exp_cred_clean
end type
type st_4 from statictext within w_hist_exp_cred_clean
end type
type cb_syn2 from commandbutton within w_hist_exp_cred_clean
end type
type cb_syn1 from commandbutton within w_hist_exp_cred_clean
end type
type st_liccnt from statictext within w_hist_exp_cred_clean
end type
type dw_1 from datawindow within w_hist_exp_cred_clean
end type
type cb_2 from commandbutton within w_hist_exp_cred_clean
end type
type gb_1 from groupbox within w_hist_exp_cred_clean
end type
type gb_2 from groupbox within w_hist_exp_cred_clean
end type
end forward

global type w_hist_exp_cred_clean from window
integer x = 14
integer y = 4
integer width = 1705
integer height = 1108
boolean titlebar = true
string title = "Check invalid Historical verifications, unmatched Exp Dates"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
st_liccnt2 st_liccnt2
cb_3 cb_3
cb_1 cb_1
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_deacnt2 st_deacnt2
st_inscnt2 st_inscnt2
st_vercnt st_vercnt
st_1 st_1
st_inscnt st_inscnt
st_deacnt st_deacnt
st_dea st_dea
st_insurance st_insurance
st_license st_license
st_4 st_4
cb_syn2 cb_syn2
cb_syn1 cb_syn1
st_liccnt st_liccnt
dw_1 dw_1
cb_2 cb_2
gb_1 gb_1
gb_2 gb_2
end type
global w_hist_exp_cred_clean w_hist_exp_cred_clean

type variables
string is_syn1
string is_syn2
string is_syn3
string is_syn4
string is_syn5
string is_syn6
string is_syn7
string is_syn8
string is_syn9
string is_syn10

integer ii_next = 1
end variables

forward prototypes
public function integer of_check ()
public function integer of_fix ()
public function integer of_check_dates ()
public function integer of_fix_dates ()
end prototypes

public function integer of_check ();string ls_sql
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
long cnt
integer i

//Start Code Change ----10.01.2009 #V92 maha - corrected the screen queries for nulls in the data_status field
for i = 1 to 4
	choose case i
		case 1
			ls_sql = "SELECT verif_info.rec_id, verif_info.prac_id, seq_no, facility_id, verif_info.data_status,  verif_info.doc_id  FROM pd_insurance,    verif_info   WHERE ( pd_insurance.rec_id = verif_info.rec_id ) and  ( pd_insurance.prac_id = verif_info.prac_id ) and   ( verif_info.screen_id = 15 ) AND  ( verif_info.active_status = 1 ) AND  (( pd_insurance.active_status = 2 and  verif_info.data_status is null) or ( pd_insurance.active_status <> verif_info.data_status ) )  ;"		
		case 2
			ls_sql = "SELECT verif_info.rec_id, verif_info.prac_id, seq_no, facility_id, verif_info.data_status,  verif_info.doc_id  FROM pd_license,    verif_info   WHERE ( pd_license.rec_id = verif_info.rec_id ) and  ( pd_license.prac_id = verif_info.prac_id ) and   ( verif_info.screen_id = 4 ) AND  ( verif_info.active_status = 1 ) AND  (( pd_license.active_status = 2 and  verif_info.data_status is null) or ( pd_license.active_status <> verif_info.data_status ) )  ;"
		case 3
			ls_sql = "SELECT verif_info.rec_id, verif_info.prac_id, seq_no, facility_id, verif_info.data_status,  verif_info.doc_id  FROM pd_dea_state_csr,    verif_info   WHERE ( pd_dea_state_csr.rec_id = verif_info.rec_id ) and  ( pd_dea_state_csr.prac_id = verif_info.prac_id ) and   ( verif_info.screen_id = 5 ) AND  ( verif_info.active_status = 1 ) AND  (( pd_dea_state_csr.active_status = 2 and  verif_info.data_status is null) or ( pd_dea_state_csr.active_status <> verif_info.data_status ) )  ;"
		case 4
			ls_sql = "select distinct rec_id,     prac_id ,           facility_id ,         seq_no ,           screen_id ,data_status   from verif_info where data_status = 2 and active_status = 1 and exp_credential_flag = 1;"
	end choose


	ls_presentation_str = "style(type=grid)" 
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
	IF LenA(ERRORS) > 0 THEN //this will fail if the table has not been completed
		if PosA(ERRORS,"Table or view not found",1) > 0 then
			messagebox ("syntax error","Table not found (should have  prefix)" )
			return -1
		else
			MessageBox("Caution", &
			"SyntaxFromSQL caused these errors: " + ERRORS)
			RETURN -1
		end if
	END IF
	

	dw_1.Create( ls_dwsyntax_str, ERRORS)
	dw_1.SetTransObject( SQLCA )
	cnt = dw_1.retrieve()
	
	choose case i
		case 1
			st_liccnt.text = string(cnt)
		case 2
			st_inscnt.text = string(cnt)
		case 3
			st_deacnt.text = string(cnt)
		case 4
			st_vercnt.text = string(cnt)
	end choose



next

return 1

end function

public function integer of_fix ();string ls_sql
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
long cnt
integer i

//Start Code Change ----10.01.2009 #V92 maha - corrected for null data_status values
update verif_info set verif_info.data_status = pd_insurance.active_status from verif_info join  pd_insurance on pd_insurance.rec_id = verif_info.rec_id WHERE     ( pd_insurance.prac_id = verif_info.prac_id ) and   ( verif_info.screen_id = 15 ) AND  ( verif_info.active_status = 1 ) AND (( pd_insurance.active_status = 2 and  verif_info.data_status is null) or ( pd_insurance.active_status <> verif_info.data_status ) )  ;

update verif_info set verif_info.data_status = pd_license.active_status from verif_info join  pd_license on pd_license.rec_id = verif_info.rec_id WHERE     ( pd_license.prac_id = verif_info.prac_id ) and   ( verif_info.screen_id = 4 ) AND  ( verif_info.active_status = 1 ) AND (( pd_license.active_status = 2 and  verif_info.data_status is null) or ( pd_license.active_status <> verif_info.data_status ) )  ;

update verif_info set verif_info.data_status = pd_dea_state_csr.active_status from  verif_info join  pd_dea_state_csr on pd_dea_state_csr.rec_id = verif_info.rec_id WHERE     ( pd_dea_state_csr.prac_id = verif_info.prac_id ) and   ( verif_info.screen_id = 5 ) AND  ( verif_info.active_status = 1 ) AND  (( pd_dea_state_csr.active_status = 2 and  verif_info.data_status is null) or ( pd_dea_state_csr.active_status <> verif_info.data_status ) )  ;

delete   from verif_info where data_status = 2 and active_status = 1 and exp_credential_flag = 1;

commit using sqlca;





messagebox("Done","Function completed")

return 1
end function

public function integer of_check_dates ();string ls_sql
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
long cnt
integer i

//Start Code Change ----10.01.2009 #V92 maha - corrected the screen queries for nulls in the data_status field
for i = 1 to 3
	choose case i
		case 1
			ls_sql = "SELECT verif_info.rec_id, verif_info.prac_id, seq_no, facility_id, verif_info.data_status,  verif_info.doc_id  FROM pd_insurance,    verif_info   WHERE ( pd_insurance.rec_id = verif_info.rec_id ) and  ( pd_insurance.prac_id = verif_info.prac_id ) and   ( verif_info.screen_id = 15 ) AND  ( verif_info.active_status = 1 ) AND  (( pd_insurance.coverage_to <>  verif_info.expiration_date) )  ;	"
		case 2
			ls_sql = "SELECT verif_info.rec_id, verif_info.prac_id, seq_no, facility_id, verif_info.data_status,  verif_info.doc_id  FROM pd_license,    verif_info   WHERE ( pd_license.rec_id = verif_info.rec_id ) and  ( pd_license.prac_id = verif_info.prac_id ) and   ( verif_info.screen_id = 4 ) AND  ( verif_info.active_status = 1 ) AND  (( pd_license.expiration_date <>  verif_info.expiration_date) )  ;"
		case 3
			ls_sql = "SELECT verif_info.rec_id, verif_info.prac_id, seq_no, facility_id, verif_info.data_status,  verif_info.doc_id  FROM pd_dea_state_csr,    verif_info   WHERE ( pd_dea_state_csr.rec_id = verif_info.rec_id ) and  ( pd_dea_state_csr.prac_id = verif_info.prac_id ) and   ( verif_info.screen_id = 5 ) AND  ( verif_info.active_status = 1 ) AND  (( pd_dea_state_csr.expiration_date <> verif_info.expiration_date ) );"
//		case 4
//			ls_sql = "select distinct rec_id,     prac_id ,           facility_id ,         seq_no ,           screen_id ,data_status   from verif_info where data_status = 2 and active_status = 1 and exp_credential_flag = 1;"
	end choose


	ls_presentation_str = "style(type=grid)" 
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
	IF LenA(ERRORS) > 0 THEN //this will fail if the table has not been completed
		if PosA(ERRORS,"Table or view not found",1) > 0 then
			messagebox ("syntax error","Table not found (should have  prefix)" )
			return -1
		else
			MessageBox("Caution", &
			"SyntaxFromSQL caused these errors: " + ERRORS)
			RETURN -1
		end if
	END IF
	

	dw_1.Create( ls_dwsyntax_str, ERRORS)
	dw_1.SetTransObject( SQLCA )
	cnt = dw_1.retrieve()
	
	choose case i
		case 1
			st_liccnt2.text = string(cnt)
		case 2
			st_inscnt2.text = string(cnt)
		case 3
			st_deacnt2.text = string(cnt)
//		case 4
//			st_vercnt.text = string(cnt)
	end choose



next

return 1

end function

public function integer of_fix_dates ();string ls_sql
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
long cnt
integer i


update verif_info set verif_info.expiration_date = pd_insurance.coverage_to from verif_info join  pd_insurance on pd_insurance.rec_id = verif_info.rec_id WHERE     ( pd_insurance.prac_id = verif_info.prac_id ) and   ( verif_info.screen_id = 15 ) AND  ( verif_info.active_status = 1 ) AND (( pd_insurance.coverage_to <> verif_info.expiration_date) )  ;

update verif_info set verif_info.expiration_date = pd_license.expiration_date from verif_info join  pd_license on pd_license.rec_id = verif_info.rec_id WHERE     ( pd_license.prac_id = verif_info.prac_id ) and   ( verif_info.screen_id = 4 ) AND  ( verif_info.active_status = 1 ) AND (( pd_license.expiration_date <>  verif_info.expiration_date)  )  ;

update verif_info set verif_info.expiration_date = pd_dea_state_csr.expiration_date from  verif_info join  pd_dea_state_csr on pd_dea_state_csr.rec_id = verif_info.rec_id WHERE     ( pd_dea_state_csr.prac_id = verif_info.prac_id ) and   ( verif_info.screen_id = 5 ) AND  ( verif_info.active_status = 1 ) AND  (( pd_dea_state_csr.expiration_date <> verif_info.expiration_date)  )  ;


commit using sqlca;


st_liccnt2.text = "X"
st_inscnt2.text = "X"
st_deacnt2.text = "X"


messagebox("Done","Function completed")

return 1
end function

on w_hist_exp_cred_clean.create
this.st_liccnt2=create st_liccnt2
this.cb_3=create cb_3
this.cb_1=create cb_1
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_deacnt2=create st_deacnt2
this.st_inscnt2=create st_inscnt2
this.st_vercnt=create st_vercnt
this.st_1=create st_1
this.st_inscnt=create st_inscnt
this.st_deacnt=create st_deacnt
this.st_dea=create st_dea
this.st_insurance=create st_insurance
this.st_license=create st_license
this.st_4=create st_4
this.cb_syn2=create cb_syn2
this.cb_syn1=create cb_syn1
this.st_liccnt=create st_liccnt
this.dw_1=create dw_1
this.cb_2=create cb_2
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.st_liccnt2,&
this.cb_3,&
this.cb_1,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_deacnt2,&
this.st_inscnt2,&
this.st_vercnt,&
this.st_1,&
this.st_inscnt,&
this.st_deacnt,&
this.st_dea,&
this.st_insurance,&
this.st_license,&
this.st_4,&
this.cb_syn2,&
this.cb_syn1,&
this.st_liccnt,&
this.dw_1,&
this.cb_2,&
this.gb_1,&
this.gb_2}
end on

on w_hist_exp_cred_clean.destroy
destroy(this.st_liccnt2)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_deacnt2)
destroy(this.st_inscnt2)
destroy(this.st_vercnt)
destroy(this.st_1)
destroy(this.st_inscnt)
destroy(this.st_deacnt)
destroy(this.st_dea)
destroy(this.st_insurance)
destroy(this.st_license)
destroy(this.st_4)
destroy(this.cb_syn2)
destroy(this.cb_syn1)
destroy(this.st_liccnt)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='No'"
//	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Not Logged In", "Login Failed!")
//ELSE
//	MESSAGEBOX("","LOGIN OK")
//END IF
SQLCA.AutoCommit = false
end event

event close;//disCONNECT USING SQLCA;
SQLCA.AutoCommit = True
end event

type st_liccnt2 from statictext within w_hist_exp_cred_clean
integer x = 325
integer y = 720
integer width = 146
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "X"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_hist_exp_cred_clean
integer x = 553
integer y = 844
integer width = 338
integer height = 84
integer taborder = 210
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Check Dates"
end type

event clicked;of_check_dates()


end event

type cb_1 from commandbutton within w_hist_exp_cred_clean
integer x = 974
integer y = 844
integer width = 187
integer height = 84
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Modify"
end type

event clicked;of_fix_dates()
end event

type st_8 from statictext within w_hist_exp_cred_clean
integer x = 32
integer y = 720
integer width = 233
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Records"
boolean focusrectangle = false
end type

type st_7 from statictext within w_hist_exp_cred_clean
integer x = 279
integer y = 640
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
string text = "License"
boolean focusrectangle = false
end type

type st_6 from statictext within w_hist_exp_cred_clean
integer x = 645
integer y = 640
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
string text = "Insurance"
boolean focusrectangle = false
end type

type st_5 from statictext within w_hist_exp_cred_clean
integer x = 1047
integer y = 640
integer width = 233
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "DEA"
boolean focusrectangle = false
end type

type st_deacnt2 from statictext within w_hist_exp_cred_clean
integer x = 1079
integer y = 720
integer width = 114
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "X"
boolean focusrectangle = false
end type

type st_inscnt2 from statictext within w_hist_exp_cred_clean
integer x = 736
integer y = 720
integer width = 142
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "X"
boolean focusrectangle = false
end type

type st_vercnt from statictext within w_hist_exp_cred_clean
integer x = 1371
integer y = 300
integer width = 114
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "X"
boolean focusrectangle = false
end type

type st_1 from statictext within w_hist_exp_cred_clean
integer x = 1307
integer y = 220
integer width = 302
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Verifications"
boolean focusrectangle = false
end type

type st_inscnt from statictext within w_hist_exp_cred_clean
integer x = 741
integer y = 300
integer width = 142
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "X"
boolean focusrectangle = false
end type

type st_deacnt from statictext within w_hist_exp_cred_clean
integer x = 1083
integer y = 300
integer width = 114
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "X"
boolean focusrectangle = false
end type

type st_dea from statictext within w_hist_exp_cred_clean
integer x = 1051
integer y = 220
integer width = 233
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "DEA"
boolean focusrectangle = false
end type

type st_insurance from statictext within w_hist_exp_cred_clean
integer x = 649
integer y = 220
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
string text = "Insurance"
boolean focusrectangle = false
end type

type st_license from statictext within w_hist_exp_cred_clean
integer x = 283
integer y = 220
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
string text = "License"
boolean focusrectangle = false
end type

type st_4 from statictext within w_hist_exp_cred_clean
integer x = 32
integer y = 300
integer width = 233
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Records"
boolean focusrectangle = false
end type

type cb_syn2 from commandbutton within w_hist_exp_cred_clean
integer x = 978
integer y = 424
integer width = 187
integer height = 84
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Modify"
end type

event clicked;of_fix()
end event

type cb_syn1 from commandbutton within w_hist_exp_cred_clean
integer x = 558
integer y = 424
integer width = 338
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Check Status"
end type

event clicked;of_check()


end event

type st_liccnt from statictext within w_hist_exp_cred_clean
integer x = 329
integer y = 300
integer width = 146
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "X"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_hist_exp_cred_clean
boolean visible = false
integer x = 1705
integer y = 816
integer width = 265
integer height = 112
integer taborder = 90
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type cb_2 from commandbutton within w_hist_exp_cred_clean
integer x = 1381
integer y = 32
integer width = 247
integer height = 84
integer taborder = 200
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

type gb_1 from groupbox within w_hist_exp_cred_clean
integer x = 5
integer y = 592
integer width = 1627
integer height = 376
integer taborder = 210
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Check Expiration Dates"
end type

type gb_2 from groupbox within w_hist_exp_cred_clean
integer x = 5
integer y = 160
integer width = 1627
integer height = 376
integer taborder = 220
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Check Historical Status"
end type

