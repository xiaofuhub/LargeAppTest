$PBExportHeader$w_missing_verif_check.srw
forward
global type w_missing_verif_check from window
end type
type cb_2 from commandbutton within w_missing_verif_check
end type
type sle_facil from singlelineedit within w_missing_verif_check
end type
type sle_prac from singlelineedit within w_missing_verif_check
end type
type st_cnt from statictext within w_missing_verif_check
end type
type dw_missing from datawindow within w_missing_verif_check
end type
type dw_verifs from datawindow within w_missing_verif_check
end type
type cb_1 from commandbutton within w_missing_verif_check
end type
type dw_data from datawindow within w_missing_verif_check
end type
type dw_rules from datawindow within w_missing_verif_check
end type
end forward

global type w_missing_verif_check from window
integer width = 3397
integer height = 2472
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
sle_facil sle_facil
sle_prac sle_prac
st_cnt st_cnt
dw_missing dw_missing
dw_verifs dw_verifs
cb_1 cb_1
dw_data dw_data
dw_rules dw_rules
end type
global w_missing_verif_check w_missing_verif_check

type variables
integer ii_facility_id
long il_prac
end variables

forward prototypes
public function integer of_set_inst (integer ai_facility, long al_prac)
end prototypes

public function integer of_set_inst (integer ai_facility, long al_prac);ii_facility_id = ai_facility
il_prac = al_prac

return 1
end function

on w_missing_verif_check.create
this.cb_2=create cb_2
this.sle_facil=create sle_facil
this.sle_prac=create sle_prac
this.st_cnt=create st_cnt
this.dw_missing=create dw_missing
this.dw_verifs=create dw_verifs
this.cb_1=create cb_1
this.dw_data=create dw_data
this.dw_rules=create dw_rules
this.Control[]={this.cb_2,&
this.sle_facil,&
this.sle_prac,&
this.st_cnt,&
this.dw_missing,&
this.dw_verifs,&
this.cb_1,&
this.dw_data,&
this.dw_rules}
end on

on w_missing_verif_check.destroy
destroy(this.cb_2)
destroy(this.sle_facil)
destroy(this.sle_prac)
destroy(this.st_cnt)
destroy(this.dw_missing)
destroy(this.dw_verifs)
destroy(this.cb_1)
destroy(this.dw_data)
destroy(this.dw_rules)
end on

type cb_2 from commandbutton within w_missing_verif_check
integer x = 2848
integer y = 32
integer width = 343
integer height = 92
integer taborder = 10
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

type sle_facil from singlelineedit within w_missing_verif_check
integer x = 114
integer y = 1308
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "facil"
borderstyle borderstyle = stylelowered!
end type

type sle_prac from singlelineedit within w_missing_verif_check
integer x = 119
integer y = 1408
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "prac"
borderstyle borderstyle = stylelowered!
end type

type st_cnt from statictext within w_missing_verif_check
integer x = 219
integer y = 1612
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_missing from datawindow within w_missing_verif_check
integer x = 96
integer y = 548
integer width = 3081
integer height = 668
integer taborder = 40
string title = "none"
string dataobject = "d_ver_missing_add_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_verifs from datawindow within w_missing_verif_check
integer x = 1765
integer y = 96
integer width = 686
integer height = 400
integer taborder = 30
string title = "none"
string dataobject = "d_ver_missing_active_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_missing_verif_check
integer x = 471
integer y = 1860
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;long i
long ic
long nr
integer r
integer rc
integer v
integer vc
integer cnt
Long ll_seq
integer li_f[]
integer li_find
string ls_rule
string ls_find
string ls_doc
string rec_field
string f
string p
integer li_screen
long ll_recid
pfc_cst_nv_data_entry_functions lu_def
n_ds lds_verif
DataWindowChild dwchild

f = sle_facil.text
p = sle_prac.text

ii_facility_id = integer(f)
li_f[1] = ii_facility_id
il_prac = long(p)


dw_rules.settransobject(sqlca)
ic = dw_rules.retrieve(ii_facility_id,1)
dw_verifs.settransobject(sqlca)
vc = dw_verifs.retrieve(1,il_prac,li_f)
dw_missing.settransobject(sqlca)
lu_def = create pfc_cst_nv_data_entry_functions
lds_verif = create n_ds

debugbreak()
for i = 1 to ic
	ls_rule = dw_rules.getitemstring(i,"verify_data")
	//if the rule is set to inital only skip
	if ls_rule <> 'B' then 
		continue
	else
		li_screen = dw_rules.getitemnumber(i,"screen_id")
		if li_screen = 1 then continue
		lu_def.of_create_dynamic_ds( il_prac, 1, li_screen, lds_verif,  ii_facility_id, sqlca)
		rc = lds_verif.rowcount( )
		if rc < 1 then continue
		for r = 1 to rc
			choose case li_screen
				case 2
					rec_field = "pd_address_rec_id"
				case 10
					continue
					rec_field = "pd_hosp_affil_rec_id"
				case else
					//messagebox("",li_screen)
					rec_field = "rec_id"
			end choose
			ll_recid = lds_verif.getitemnumber(r,"rec_id")
			ls_find = "rec_id = " + string(ll_recid)
			li_find = dw_verifs.find(ls_find,1,vc)
			if li_find = 0 then
				//create the verification in dw_missing
				cnt++
				st_cnt.text = string(cnt)
				nr = dw_missing.insertrow(0)
				dw_missing.setitem(nr,"prac_id",il_prac)
				select max(seq_no) into :ll_seq from verif_info where prac_id = :il_prac  and facility_id = :ii_facility_id and rec_id = :ll_recid;
				ll_seq++
				dw_missing.setitem(nr,"seq_no",1)
				dw_missing.setitem(nr,"facility_id",ii_facility_id)
				dw_missing.setitem(nr,"print_flag",1)
				dw_missing.setitem(nr,"exp_credential_flag",0)
				dw_missing.setitem(nr,"reference_value","reference")
				dw_missing.setitem(nr,"active_status",1)
				dw_missing.setitem(nr,"rec_id",ll_recid)
				ls_doc = string(ll_recid) + "-" + string(il_prac) + "-" + string(ii_facility_id) + "-" + string(ll_seq)
				dw_missing.setitem(nr,"doc_id",ls_doc)
				dw_missing.setitem(nr,"screen_id",li_screen)
				//dw_missing.setitem(nr,"verification_method",????)
			end if
			
		next
	
	end if
next

//dw_missing.GetChild( "screen_id", dwchild )
//dwchild.settransobject(sqlca)
//dwchild.retrieve()
//dwchild.insertrow(1)

destroy lu_def


end event

type dw_data from datawindow within w_missing_verif_check
integer x = 891
integer y = 92
integer width = 686
integer height = 400
integer taborder = 20
string title = "none"
string dataobject = "d_ver_summary_record_view_browse"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_rules from datawindow within w_missing_verif_check
integer x = 87
integer y = 80
integer width = 686
integer height = 400
integer taborder = 10
string title = "none"
string dataobject = "d_rules_for_missing_verifs"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

