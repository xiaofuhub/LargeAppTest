$PBExportHeader$pfc_cst_u_app_status.sru
forward
global type pfc_cst_u_app_status from userobject
end type
type dw_1 from datawindow within pfc_cst_u_app_status
end type
type p_approval from picture within pfc_cst_u_app_status
end type
type p_verif from picture within pfc_cst_u_app_status
end type
type p_de from picture within pfc_cst_u_app_status
end type
type p_audit from picture within pfc_cst_u_app_status
end type
type st_4 from statictext within pfc_cst_u_app_status
end type
type st_3 from statictext within pfc_cst_u_app_status
end type
type st_2 from statictext within pfc_cst_u_app_status
end type
type st_1 from statictext within pfc_cst_u_app_status
end type
type r_1 from rectangle within pfc_cst_u_app_status
end type
type r_2 from rectangle within pfc_cst_u_app_status
end type
type r_3 from rectangle within pfc_cst_u_app_status
end type
type r_4 from rectangle within pfc_cst_u_app_status
end type
type oval_audit from roundrectangle within pfc_cst_u_app_status
end type
type oval_approval from roundrectangle within pfc_cst_u_app_status
end type
type oval_verif from roundrectangle within pfc_cst_u_app_status
end type
type oval_de from roundrectangle within pfc_cst_u_app_status
end type
end forward

global type pfc_cst_u_app_status from userobject
integer width = 914
integer height = 140
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
p_approval p_approval
p_verif p_verif
p_de p_de
p_audit p_audit
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
r_1 r_1
r_2 r_2
r_3 r_3
r_4 r_4
oval_audit oval_audit
oval_approval oval_approval
oval_verif oval_verif
oval_de oval_de
end type
global pfc_cst_u_app_status pfc_cst_u_app_status

forward prototypes
public function integer of_get_status (long al_prac_id, integer ai_facility_id)
public function integer of_reset ()
public function integer of_get_status_rec (long al_recid)
end prototypes

public function integer of_get_status (long al_prac_id, integer ai_facility_id);DateTime ldt_audit_complete
DateTime ldt_de_complete
DateTime ldt_approval_complete
DateTime ldt_verif_complete
integer cnt
long ll_red =  200   //maha 03.26.2012 //255
long ll_green  =  11534255 //maha 03.26.2012 //8453888

//Start Code Change ----01.18.2011 #V11 maha - if inactive set to grey
Select count( pd_affil_stat.active_status) into :cnt FROM pd_affil_stat  WHERE ( pd_affil_stat.prac_id = :al_prac_id ) AND  
	( pd_affil_stat.parent_facility_id = :ai_facility_id ) AND
	( pd_affil_stat.active_status in ( 1,4 ) );
	
if cnt = 0 then 
	oval_audit.fillcolor = 11711154 //silver
	oval_de.fillcolor = 11711154
	oval_verif.fillcolor = 11711154
	oval_approval.fillcolor = 11711154
	return 0
end if
//End Code Change ----01.18.2011
	

SELECT pd_affil_stat.date_app_audit_completed,   
       pd_affil_stat.date_data_entry_completed,   
       pd_affil_stat.date_verif_completed,   
       pd_affil_stat.apptmnt_start_date  
INTO :ldt_audit_complete,   
     :ldt_de_complete,   
     :ldt_verif_complete,   
     :ldt_approval_complete  
FROM pd_affil_stat  
WHERE ( pd_affil_stat.prac_id = :al_prac_id ) AND  
      ( pd_affil_stat.parent_facility_id = :ai_facility_id ) AND
		( pd_affil_stat.active_status in ( 1,4 ) );  //maha  changed to include pending 072402
IF SQLCA.SQLCODE <> 0 THEN
	Return -1
END IF

IF IsNull( ldt_audit_complete ) THEN
	oval_audit.fillcolor = ll_red
ELSE
	oval_audit.fillcolor = ll_green
END IF

IF IsNull( ldt_de_complete ) THEN
	oval_de.fillcolor = ll_red
ELSE
	oval_de.fillcolor = ll_green
END IF

IF IsNull( ldt_verif_complete ) THEN
	oval_verif.fillcolor = ll_red
ELSE
	oval_verif.fillcolor = ll_green
END IF

IF IsNull( ldt_approval_complete ) THEN
	oval_approval.fillcolor = ll_red
ELSE
	oval_approval.fillcolor = ll_green
END IF


RETURN 0


end function

public function integer of_reset ();oval_audit.fillcolor = 255
oval_de.fillcolor = 255
oval_verif.fillcolor = 255
oval_approval.fillcolor = 255

// RP added 1.28.2016
dw_1.reset()
dw_1.insertRow(0)

RETURN 0


end function

public function integer of_get_status_rec (long al_recid);//--------------- RP Modified 1.28.2016 -------------------------------------------------------------------
return dw_1.retrieve(al_recid)


////Start Code Change ----12.08.2014 #V14.2 maha - added new function to filter by recid - copied from of_get_status
//DateTime ldt_audit_complete
//DateTime ldt_de_complete
//DateTime ldt_approval_complete
//DateTime ldt_verif_complete
//integer li_status
//long ll_red =  200   //maha 03.26.2012 //255
//long ll_green  =  11534255 //maha 03.26.2012 //8453888
//
////if inactive set to grey
//SELECT pd_affil_stat.date_app_audit_completed,   
//       pd_affil_stat.date_data_entry_completed,   
//       pd_affil_stat.date_verif_completed,   
//       pd_affil_stat.apptmnt_start_date,
//	 pd_affil_stat.active_status
//INTO :ldt_audit_complete,   
//     :ldt_de_complete,   
//     :ldt_verif_complete,   
//     :ldt_approval_complete ,
//	 :li_status
//FROM pd_affil_stat  
//WHERE  pd_affil_stat.rec_id = :al_recid  ; 
//
//IF SQLCA.SQLCODE <> 0 THEN
//	Return -1
//END IF
//	
////other than active, pending, midcycle  set gray
//choose case li_status
//	case 3,2,0 
//		oval_audit.fillcolor = 11711154 //silver
//		oval_de.fillcolor = 11711154
//		oval_verif.fillcolor = 11711154
//		oval_approval.fillcolor = 11711154
//		 //Start Code Change ----05.18.2015 #V15 maha
//		p_audit.visible = false
//		p_de.visible = false
//		p_verif.visible = false
//		p_approval.visible = false
//		//End Code Change ----05.18.2015
//		return 0
//end choose
//
//	
//IF IsNull( ldt_audit_complete ) THEN
//	oval_audit.fillcolor = ll_red
//	p_audit.visible = false  //maha 05.18.2015
//ELSE
//	oval_audit.fillcolor = ll_green
//	p_audit.visible = true  //maha 05.18.2015
//END IF
//
//IF IsNull( ldt_de_complete ) THEN
//	oval_de.fillcolor = ll_red
//	p_de.visible = false //maha 05.18.2015
//ELSE
//	oval_de.fillcolor = ll_green
//	p_de.visible = true //maha 05.18.2015
//END IF
//
//IF IsNull( ldt_verif_complete ) THEN
//	oval_verif.fillcolor = ll_red
//	p_verif.visible = false //maha 05.18.2015
//ELSE
//	oval_verif.fillcolor = ll_green
//	p_verif.visible = true //maha 05.18.2015
//END IF
//
//IF IsNull( ldt_approval_complete ) THEN
//	oval_approval.fillcolor = ll_red
//	p_approval.visible = false //maha 05.18.2015
//ELSE
//	oval_approval.fillcolor = ll_green
//	p_approval.visible = true //maha 05.18.2015
//END IF
//

RETURN 0


end function

on pfc_cst_u_app_status.create
this.dw_1=create dw_1
this.p_approval=create p_approval
this.p_verif=create p_verif
this.p_de=create p_de
this.p_audit=create p_audit
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.r_1=create r_1
this.r_2=create r_2
this.r_3=create r_3
this.r_4=create r_4
this.oval_audit=create oval_audit
this.oval_approval=create oval_approval
this.oval_verif=create oval_verif
this.oval_de=create oval_de
this.Control[]={this.dw_1,&
this.p_approval,&
this.p_verif,&
this.p_de,&
this.p_audit,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.r_1,&
this.r_2,&
this.r_3,&
this.r_4,&
this.oval_audit,&
this.oval_approval,&
this.oval_verif,&
this.oval_de}
end on

on pfc_cst_u_app_status.destroy
destroy(this.dw_1)
destroy(this.p_approval)
destroy(this.p_verif)
destroy(this.p_de)
destroy(this.p_audit)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.r_3)
destroy(this.r_4)
destroy(this.oval_audit)
destroy(this.oval_approval)
destroy(this.oval_verif)
destroy(this.oval_de)
end on

type dw_1 from datawindow within pfc_cst_u_app_status
integer width = 914
integer height = 140
integer taborder = 10
string title = "none"
string dataobject = "d_pd_affil_stat_demo"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;setTransObject(SQLCA)

end event

type p_approval from picture within pfc_cst_u_app_status
integer x = 750
integer y = 236
integer width = 91
integer height = 64
string picturename = "checkmarkgreen.png"
boolean focusrectangle = false
end type

type p_verif from picture within pfc_cst_u_app_status
integer x = 485
integer y = 248
integer width = 91
integer height = 64
string picturename = "checkmarkgreen.png"
boolean focusrectangle = false
end type

type p_de from picture within pfc_cst_u_app_status
integer x = 256
integer y = 240
integer width = 91
integer height = 64
string picturename = "checkmarkgreen.png"
boolean focusrectangle = false
end type

type p_audit from picture within pfc_cst_u_app_status
integer x = 59
integer y = 256
integer width = 91
integer height = 64
string picturename = "checkmarkgreen.png"
boolean focusrectangle = false
end type

type st_4 from statictext within pfc_cst_u_app_status
integer x = 695
integer y = 8
integer width = 183
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "MS Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Approval"
boolean focusrectangle = false
end type

type st_3 from statictext within pfc_cst_u_app_status
integer x = 498
integer y = 8
integer width = 160
integer height = 56
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "MS Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Verify"
boolean focusrectangle = false
end type

type st_2 from statictext within pfc_cst_u_app_status
integer x = 224
integer y = 8
integer width = 219
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "MS Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Data Entry"
boolean focusrectangle = false
end type

type st_1 from statictext within pfc_cst_u_app_status
integer x = 18
integer y = 12
integer width = 178
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "MS Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Checklist"
boolean focusrectangle = false
end type

type r_1 from rectangle within pfc_cst_u_app_status
integer linethickness = 4
long fillcolor = 16777215
integer x = 5
integer width = 206
integer height = 132
end type

event constructor;this.LineColor = rgb(184, 184, 184)

end event

type r_2 from rectangle within pfc_cst_u_app_status
integer linethickness = 4
long fillcolor = 16777215
integer x = 206
integer width = 242
integer height = 132
end type

event constructor;this.LineColor = rgb(184, 184, 184)

end event

type r_3 from rectangle within pfc_cst_u_app_status
integer linethickness = 4
long fillcolor = 16777215
integer x = 443
integer width = 242
integer height = 132
end type

event constructor;this.LineColor = rgb(184, 184, 184)

end event

type r_4 from rectangle within pfc_cst_u_app_status
integer linethickness = 4
long fillcolor = 16777215
integer x = 677
integer width = 219
integer height = 132
end type

event constructor;this.LineColor = rgb(184, 184, 184)

end event

type oval_audit from roundrectangle within pfc_cst_u_app_status
integer linethickness = 4
long fillcolor = 12632256
integer x = 59
integer y = 64
integer width = 96
integer height = 48
integer cornerheight = 40
integer cornerwidth = 46
end type

event constructor;this.LineColor = rgb(128, 128, 128)

end event

type oval_approval from roundrectangle within pfc_cst_u_app_status
integer linethickness = 4
long fillcolor = 12632256
integer x = 736
integer y = 64
integer width = 96
integer height = 48
integer cornerheight = 40
integer cornerwidth = 46
end type

event constructor;this.LineColor = rgb(128, 128, 128)

end event

type oval_verif from roundrectangle within pfc_cst_u_app_status
integer linethickness = 4
long fillcolor = 12632256
integer x = 507
integer y = 64
integer width = 96
integer height = 48
integer cornerheight = 40
integer cornerwidth = 46
end type

event constructor;this.LineColor = rgb(128, 128, 128)

end event

type oval_de from roundrectangle within pfc_cst_u_app_status
integer linethickness = 4
long fillcolor = 12632256
integer x = 274
integer y = 64
integer width = 96
integer height = 48
integer cornerheight = 40
integer cornerwidth = 46
end type

event constructor;this.LineColor = rgb(128, 128, 128)

end event

