$PBExportHeader$w_intelliapp_print.srw
forward
global type w_intelliapp_print from w_response
end type
type uo_print from pfc_cst_u_print_app within w_intelliapp_print
end type
type cb_1 from commandbutton within w_intelliapp_print
end type
end forward

global type w_intelliapp_print from w_response
integer x = 9
integer y = 200
integer width = 4091
integer height = 2224
string title = "IntelliApp Printing"
windowtype windowtype = main!
long backcolor = 33551856
uo_print uo_print
cb_1 cb_1
end type
global w_intelliapp_print w_intelliapp_print

type variables
Integer ii_dashboard_macro = 0
gs_batch_search lst_search
end variables

forward prototypes
public function integer of_print_now ()
end prototypes

public function integer of_print_now ();//gs_batch_search lst_search
long i
long ic
long r
long rc
long pracids[]
string names[]
long ll_facil[]
long ll_loc_id[] //Added by Appeon long.zhang 09.22.2014 (V14.2 Testing Bug # 4229 - In Batch add the print now option is not working)
long ll_state[] //Added by Appeon long.zhang 09.22.2014 (V14.2 Testing Bug # 4229 - In Batch add the print now option is not working)
integer ll_app[]

//lst_search = message.powerobjectparm

pracids[] = lst_search.li_prac_id[]
names[] = lst_search.ls_name[]
ll_facil[] = lst_search.ll_facility[]
ll_app[] = lst_search.ll_app[]
ll_loc_id[] = lst_search.ll_loc_id[] //Added by Appeon long.zhang 09.22.2014 (V14.2 Testing Bug # 4229 - In Batch add the print now option is not working)
ll_state[] = lst_search.ll_state[] //Added by Appeon long.zhang 09.22.2014 (V14.2 Testing Bug # 4229 - In Batch add the print now option is not working)

 ic = upperbound(pracids[]) 
 
FOR i = 1 TO ic
	r = uo_print.tab_1.tabpage_pl.dw_print.InsertRow( 0 )
	uo_print.tab_1.tabpage_pl.dw_print.SetItem( r, "prac_name", names[i] )
	uo_print.tab_1.tabpage_pl.dw_print.SetItem( r, "prac_id",pracids[i] )
	uo_print.tab_1.tabpage_pl.dw_print.SetItem( r, "facility_id", ll_facil[i] )
	uo_print.tab_1.tabpage_pl.dw_print.SetItem( r, "app_id", ll_app[i] )
	if ll_loc_id[i] <> 0 then uo_print.tab_1.tabpage_pl.dw_print.SetItem( r, "loc_id_passed", ll_loc_id[i] ) //Added by Appeon long.zhang 09.22.2014 (V14.2 Testing Bug # 4229 - In Batch add the print now option is not working)
	if ll_state[i] <> 0 then uo_print.tab_1.tabpage_pl.dw_print.SetItem( r, "state_passed", ll_state[i] ) //Added by Appeon long.zhang 09.22.2014 (V14.2 Testing Bug # 4229 - In Batch add the print now option is not working)
	uo_print.tab_1.tabpage_pl.dw_print.SetItem( r, "selected", 1 )
END FOR

uo_print.tab_1.tabpage_pl.dw_print.SetRow( 1 )
uo_print.tab_1.tabpage_pl.dw_print.ScrollToRow( 1 )

uo_print.tab_1.tabpage_pl.dw_print.SetFocus()

 //Start Code Change ----06.25.2014 #V14.2 maha - from batch add 'print now' to prevent adding actions
uo_print.ib_create_actions = False 
uo_print.tab_1.tabpage_net_dev.visible = false
 //End Code Change ----06.25.2014

return 1
end function

on w_intelliapp_print.create
int iCurrent
call super::create
this.uo_print=create uo_print
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_print
this.Control[iCurrent+2]=this.cb_1
end on

on w_intelliapp_print.destroy
call super::destroy
destroy(this.uo_print)
destroy(this.cb_1)
end on

event closequery;call super::closequery;//messagebox("","hdfds" )
//DISCONNECT USING SQLCA;
//
//SQLCA.DBMS = "ODBC"
//SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=" + gs_user_id + ";PWD=" + gs_password + "',DelimitIdentifier='No'"
//SQLCA.AutoCommit = TRUE
//	
//CONNECT USING SQLCA;
end event

event open;call super::open;//Long ll_prac_id
//gs_pass_ids lstr_ids
//
//lstr_ids = Message.PowerObjectParm
//
//IF lstr_ids.s_stringval = "FromPracFolder" THEN
//	uo_print.of_from_prac_folder( lstr_ids.prac_id )
//END IF
end event

event pfc_postopen;call super::pfc_postopen;gnv_reg_ocx.of_check_ocx( 3, '', True) //Added by Ken.Guo on 2008-11-07
end event

type uo_print from pfc_cst_u_print_app within w_intelliapp_print
integer x = 46
integer y = 16
integer taborder = 10
boolean bringtotop = true
boolean border = false
end type

on uo_print.destroy
call pfc_cst_u_print_app::destroy
end on

type cb_1 from commandbutton within w_intelliapp_print
integer x = 3378
integer y = 12
integer width = 389
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(parent)
end event

