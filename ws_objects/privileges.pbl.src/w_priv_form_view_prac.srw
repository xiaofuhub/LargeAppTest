$PBExportHeader$w_priv_form_view_prac.srw
forward
global type w_priv_form_view_prac from w_popup
end type
type cb_savedoc from commandbutton within w_priv_form_view_prac
end type
type cb_8 from uo_cb_output within w_priv_form_view_prac
end type
type st_format from statictext within w_priv_form_view_prac
end type
type ddlb_format from dropdownlistbox within w_priv_form_view_prac
end type
type dw_prac from u_dw within w_priv_form_view_prac
end type
type cb_close from commandbutton within w_priv_form_view_prac
end type
type dw_form from u_dw within w_priv_form_view_prac
end type
end forward

global type w_priv_form_view_prac from w_popup
integer width = 4032
integer height = 3168
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
cb_savedoc cb_savedoc
cb_8 cb_8
st_format st_format
ddlb_format ddlb_format
dw_prac dw_prac
cb_close cb_close
dw_form dw_form
end type
global w_priv_form_view_prac w_priv_form_view_prac

type variables
long il_prac
long il_facil
long il_area
integer il_templ
integer ii_format
u_dw idw
end variables

forward prototypes
public function integer of_get_form ()
public function integer of_dw (integer ai_format)
end prototypes

public function integer of_get_form (); //Start Code Change ----01.05.2017 #V153 maha - added
integer r
integer rc
integer ll_row
integer pc
integer g
long ll_procd_id
//long ll_prac
//long ll_facil
//long ll_area
datawindowchild ldwc_form
string ls_prac_name
string ls_stat
//n_ds lds_prac
//n_ds lds_form

select full_name into :ls_prac_name from v_full_name where prac_id = :il_prac;
	
of_dw(ii_format)

dw_form.settransobject(sqlca)
//get form data
dw_form.retrieve( il_facil,  il_area )

//modify forms
dw_form.GetChild( "dw_2", ldwc_form )
ldwc_form.Modify( 'prac_name.text = "' + ls_prac_name + '"' )  //Start Code Change ----10.17.2014 #V14.2 maha - adjusted for apostrophie in name
dw_form.GetChild( "dw_3", ldwc_form )
ldwc_form.Modify( 'prac_name.text = "' + ls_prac_name + '"')   //Start Code Change ----10.17.2014 #V14.2 maha - adjusted for apostrophie in name
dw_form.GetChild( "dw_4", ldwc_form )
ldwc_form.Modify('prac_name.text = "' + ls_prac_name + '"')   //Start Code Change ----10.17.2014 #V14.2 maha - adjusted for apostrophie in name
dw_form.GetChild( "dw_5", ldwc_form )
ldwc_form.Modify('prac_name.text = "' + ls_prac_name + '"')   //Start Code Change ----10.17.2014 #V14.2 maha - adjusted for apostrophie in name

 //Start Code Change ----04.24.2017 #V153 maha
choose case ii_format
	case 1, 6
		dw_form.GetChild( "dw_1", ldwc_form )
		ldwc_form.Modify( 'prac_name.text = "' + ls_prac_name + '"' )
end choose
 //End Code Change ----04.24.2017

dw_form.object.prac_footer.text = ls_prac_name  //Start Code Change ----07.27.2016 #V152 maha

choose case ii_format
	case 1,3,4
		//if dw_form.dataobject = 'd_form_clin_priv_request_master_f4' or  dw_form.dataobject = 'd_form_clin_priv_request_master_f3' or dw_form.dataobject = 'd_form_clin_priv_request_master_f2' then
		dw_form.GetChild( "dw_form", ldwc_form )  //Start Code Change ----04.22.2016 #V15 maha
		dw_form.Modify( 'prac_name.text = "' + ls_prac_name + '"' ) 		
		dw_form.GetChild( "dw_3", ldwc_form )
	case 5
		//elseif  dw_form.dataobject = 'd_form_clin_priv_request_master_f5'  then 
		dw_form.GetChild( "dw_form", ldwc_form )  
		ldwc_form.Modify( 'prac_name.text = "' + ls_prac_name + '"' ) 
	case else
		ldwc_form.GetChild( "dw_4", ldwc_form )

end choose 

//set provider statuses		
rc = ldwc_form.Rowcount()
ldwc_form.Modify( 'prac_name.text = "' + ls_prac_name + '"' )   //Start Code Change ----10.17.2014 #V14.2 maha - adjusted for apostrophie in name


dw_prac.settransobject(sqlca) //practitoner privs
pc = dw_prac.retrieve(il_prac,il_facil)


choose case ii_format
	case 1,3,4
		dw_form.GetChild( "dw_3", ldwc_form )
	case 6   //Start Code Change ----05.03.2017 #V153 maha
		dw_form.GetChild( "dw_4", ldwc_form )
	case else
		dw_form.GetChild( "dw_1", ldwc_form )
end choose


rc = ldwc_form.Rowcount()
	//---------End Added ------------------------------------------------------

for r = 1 to rc
	ll_procd_id = ldwc_form.getitemnumber(r,"procd_id")
	g = 0
	g = dw_prac.find("procd_id = " + string(ll_procd_id) ,1,pc)

	if g > 0 then
		ls_stat = dw_prac.getitemstring(g,"code")
		ldwc_form.setitem(r,"facility_zip",ls_stat) 
	elseif g < 0 then
		messagebox("Find error in of_get_form function","Contact IntelliSoft Support")
		return -1
	else
		ldwc_form.setitem(r,"facility_zip","") 
	end if
next



return 1
end function

public function integer of_dw (integer ai_format);
choose case ai_format
	case 1
		dw_form.dataobject = "d_form_clin_priv_request_master_f2"
	case 3
		dw_form.dataobject = "d_form_clin_priv_request_master_f3"
	case 4
		dw_form.dataobject = "d_form_clin_priv_request_master_f4"
	case -1
		dw_form.dataobject = "d_form_clin_priv_request_master_f1_alt"	
	case 5
		dw_form.dataobject = "d_form_clin_priv_request_master_f5"	
	case 6   //Start Code Change ----04.24.2017 #V153 maha - milford
		dw_form.dataobject = "d_form_clin_priv_request_master_cm6"
	case else
		dw_form.dataobject = "d_form_clin_priv_request_master_f1"
end choose

return 1
end function

on w_priv_form_view_prac.create
int iCurrent
call super::create
this.cb_savedoc=create cb_savedoc
this.cb_8=create cb_8
this.st_format=create st_format
this.ddlb_format=create ddlb_format
this.dw_prac=create dw_prac
this.cb_close=create cb_close
this.dw_form=create dw_form
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_savedoc
this.Control[iCurrent+2]=this.cb_8
this.Control[iCurrent+3]=this.st_format
this.Control[iCurrent+4]=this.ddlb_format
this.Control[iCurrent+5]=this.dw_prac
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.dw_form
end on

on w_priv_form_view_prac.destroy
call super::destroy
destroy(this.cb_savedoc)
destroy(this.cb_8)
destroy(this.st_format)
destroy(this.ddlb_format)
destroy(this.dw_prac)
destroy(this.cb_close)
destroy(this.dw_form)
end on

event open;call super::open;gs_pass_ids lst_ids
integer i


lst_ids = message.powerobjectparm

il_prac = lst_ids.prac_id
il_facil = lst_ids.facility_id
il_area = lst_ids.l_app_id

//get the format from priv setup
SELECT alt_form  INTO :ii_format   FROM facility,   priv_template  WHERE ( facility.priv_template = priv_template.template_id ) and facility.facility_id = :il_facil;
if isnull(ii_format) then ii_format = 0

if ii_format > -2 then 
	choose case ii_format
		case 0 
			i = ddlb_format.selectitem(2)
		case 1
			i =	ddlb_format.selectitem(4)
		case -1
			i = ddlb_format.selectitem(1)
		case 3
			i = ddlb_format.selectitem(5)
		case 4
			i = ddlb_format.selectitem(6)
		case 5
			i = ddlb_format.selectitem(3)
		case 6   //Start Code Change ----04.25.2017 #V153 maha
			i = ddlb_format.selectitem(7)
		case else
			i = ddlb_format.selectitem(0)
	end choose
end if


of_get_form( )
end event

type cb_savedoc from commandbutton within w_priv_form_view_prac
boolean visible = false
integer x = 2583
integer y = 16
integer width = 613
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save on Documents Tab"
end type

event clicked;messagebox("","Not yet coded")
return

//save the file as a pdf


//save as document record
// identify existing - set to history (ask)
// create new record, upload document
// audit record
end event

type cb_8 from uo_cb_output within w_priv_form_view_prac
integer x = 2043
integer y = 16
integer width = 416
integer height = 92
integer taborder = 20
end type

event clicked;

m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent(idw)
NewMenu.m_options.m_mailall.visible = false
NewMenu.m_options.m_printall.visible = false
NewMenu.m_options.m_saveasexcel.visible = false
NewMenu.m_options.m_printcurrent.text = 'Print'
NewMenu.m_options.m_mailcurrent.text = 'EMail'
//NewMenu.m_options.PopMenu(w_mdi.pointerx(),w_mdi.pointerY())
NewMenu.m_options.PopMenu(this.x + parent.x, this.y + parent.y + 90) //alfee 11.17.2010

//this calls events in u_dw
//the save as pdf calls ...
end event

event constructor;call super::constructor;idw = dw_form
end event

type st_format from statictext within w_priv_form_view_prac
boolean visible = false
integer x = 946
integer y = 32
integer width = 375
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Select Format"
boolean focusrectangle = false
end type

type ddlb_format from dropdownlistbox within w_priv_form_view_prac
integer x = 1335
integer y = 16
integer width = 544
integer height = 508
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Format 1 (ORG)","Format 1  Alt","Format 1 (V3)","Format 2","Format 3","Format 4","Custom m6"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//Start Code Change ----06.11.2012 #V12 maha - added selector
//Start Code Change ----10.01.2013 #V14 maha - changed for added 1 alt
choose case index
	case 1 //1
		ii_format = 0
	case 2 //1alt
		ii_format = -1
	case 3 //5 Added by Appeon long.zhang 09.18.2015 (Bug # 4721 for Case #00056366 Privilege Lists)
		ii_format = 5
	case 4 //2
		ii_format = 1
	case 5 //3
		ii_format = 3
	case 6 //4,
		ii_format = 4
	case 7 //6,
		ii_format = 6
end choose

of_get_form()
//of_dataobject( )
end event

type dw_prac from u_dw within w_priv_form_view_prac
boolean visible = false
integer x = 59
integer y = 40
integer width = 224
integer height = 60
integer taborder = 20
string dataobject = "d_prac_priv_list_clin_area"
end type

type cb_close from commandbutton within w_priv_form_view_prac
integer x = 3703
integer y = 16
integer width = 306
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

event clicked;close(parent)
end event

type dw_form from u_dw within w_priv_form_view_prac
event ue_mail_current_dw ( )
integer x = 9
integer y = 128
integer width = 4000
integer height = 2944
integer taborder = 10
boolean hscrollbar = true
end type

event ue_mail_current_dw(); //Start Code Change ----08.24.2017 #V153 maha - copied from reports
long	ll_Rtn
debugbreak()
ll_Rtn = Super::EVENT ue_save_pdf_for_mailing( )
if ll_Rtn <> 0 then return

if  gi_email_type = 1 then 

	Super::EVENT ue_mail_bak('Report','' )
else
	Super::EVENT ue_mail('Report','' )
end if

end event

