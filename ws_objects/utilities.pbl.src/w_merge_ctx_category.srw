$PBExportHeader$w_merge_ctx_category.srw
forward
global type w_merge_ctx_category from w_response
end type
type mle_tips2 from multilineedit within w_merge_ctx_category
end type
type st_3 from statictext within w_merge_ctx_category
end type
type cbx_delete from checkbox within w_merge_ctx_category
end type
type mle_tips from multilineedit within w_merge_ctx_category
end type
type st_2 from statictext within w_merge_ctx_category
end type
type st_1 from statictext within w_merge_ctx_category
end type
type dw_target from datawindow within w_merge_ctx_category
end type
type dw_source from datawindow within w_merge_ctx_category
end type
type cb_cancel from commandbutton within w_merge_ctx_category
end type
type cb_merge from commandbutton within w_merge_ctx_category
end type
type gb_1 from groupbox within w_merge_ctx_category
end type
end forward

global type w_merge_ctx_category from w_response
integer width = 1810
integer height = 1004
string title = "Merge Contract Category"
long backcolor = 33551856
event ue_retrieve_category ( )
mle_tips2 mle_tips2
st_3 st_3
cbx_delete cbx_delete
mle_tips mle_tips
st_2 st_2
st_1 st_1
dw_target dw_target
dw_source dw_source
cb_cancel cb_cancel
cb_merge cb_merge
gb_1 gb_1
end type
global w_merge_ctx_category w_merge_ctx_category

forward prototypes
public function integer of_merge_category (long al_source_category, long al_target_category, boolean ab_delete_source, ref string as_error_text)
end prototypes

event ue_retrieve_category();datawindowchild ldwc_category

dw_source.Reset()
dw_target.Reset()

dw_source.GetChild('category',ldwc_category)
ldwc_category.SetTransObject(SQlCA)
ldwc_category.Retrieve()

dw_target.GetChild('category',ldwc_category)
ldwc_category.SetTransObject(SQlCA)
ldwc_category.Retrieve()

dw_source.InsertRow(0)
dw_target.InsertRow(0)

end event

public function integer of_merge_category (long al_source_category, long al_target_category, boolean ab_delete_source, ref string as_error_text);Boolean lb_auto_commit
SetPointer(HourGlass!)

lb_auto_commit = SQLCA.autocommit
SQLCA.autocommit = False

Update ctx_am_document Set category = :al_target_category  Where category = :al_source_category;
If SQLCA.sqlcode < 0 Then
	as_error_text = SQLCA.sqlerrtext
	SQLCA.autocommit = lb_auto_commit
	Rollback;
	Return -1
End If

Update ctx_acp_document Set category = :al_target_category Where category = :al_source_category;
If SQLCA.sqlcode < 0 Then
	as_error_text = SQLCA.sqlerrtext
	SQLCA.autocommit = lb_auto_commit
	Rollback;
	Return -1
End If

Update ctx_basic_info Set category   = :al_target_category Where category = :al_source_category ;
If SQLCA.sqlcode < 0 Then
	as_error_text = SQLCA.sqlerrtext
	SQLCA.autocommit = lb_auto_commit
	Rollback;
	Return -1
End If

Update ctx_acp_folder Set category = :al_target_category Where category = :al_source_category;
If SQLCA.sqlcode < 0 Then
	as_error_text = SQLCA.sqlerrtext
	SQLCA.autocommit = lb_auto_commit
	Rollback;
	Return -1
End If

Update ctx_acp_template Set category = :al_target_category Where category = :al_source_category; 
If SQLCA.sqlcode < 0 Then
	as_error_text = SQLCA.sqlerrtext
	SQLCA.autocommit = lb_auto_commit
	Rollback;
	Return -1
End If

If ab_delete_source Then
	Delete From ctx_acp_contract_management_right Where category = :al_source_category;
	If SQLCA.sqlcode < 0 Then
		as_error_text = SQLCA.sqlerrtext
		SQLCA.autocommit = lb_auto_commit
		Rollback;
		Return -1
	End If
	
	Delete From Code_lookup Where lookup_code = :al_source_category;
	If SQLCA.sqlcode < 0 Then
		as_error_text = SQLCA.sqlerrtext
		SQLCA.autocommit = lb_auto_commit
		Rollback;
		Return -1
	End If
End If

Commit;
SQLCA.autocommit = lb_auto_commit

Return 1
end function

on w_merge_ctx_category.create
int iCurrent
call super::create
this.mle_tips2=create mle_tips2
this.st_3=create st_3
this.cbx_delete=create cbx_delete
this.mle_tips=create mle_tips
this.st_2=create st_2
this.st_1=create st_1
this.dw_target=create dw_target
this.dw_source=create dw_source
this.cb_cancel=create cb_cancel
this.cb_merge=create cb_merge
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_tips2
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.cbx_delete
this.Control[iCurrent+4]=this.mle_tips
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_target
this.Control[iCurrent+8]=this.dw_source
this.Control[iCurrent+9]=this.cb_cancel
this.Control[iCurrent+10]=this.cb_merge
this.Control[iCurrent+11]=this.gb_1
end on

on w_merge_ctx_category.destroy
call super::destroy
destroy(this.mle_tips2)
destroy(this.st_3)
destroy(this.cbx_delete)
destroy(this.mle_tips)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_target)
destroy(this.dw_source)
destroy(this.cb_cancel)
destroy(this.cb_merge)
destroy(this.gb_1)
end on

event pfc_save;//Override Ancester Script.
Return 1
end event

event open;call super::open;Event ue_retrieve_category()
end event

type mle_tips2 from multilineedit within w_merge_ctx_category
integer x = 23
integer y = 672
integer width = 1774
integer height = 72
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Please close all the windows before the mergence."
boolean border = false
boolean displayonly = true
end type

type st_3 from statictext within w_merge_ctx_category
integer x = 832
integer y = 184
integer width = 96
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "--->"
boolean focusrectangle = false
end type

type cbx_delete from checkbox within w_merge_ctx_category
integer x = 23
integer y = 384
integer width = 1774
integer height = 64
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Delete the source contract category in lookup table after the mergence"
boolean checked = true
end type

type mle_tips from multilineedit within w_merge_ctx_category
integer x = 23
integer y = 484
integer width = 1774
integer height = 176
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "This function will merge the source contract category to the target contract category.After the mergence, all the places referenced the source contract category will be modified to the target contract category. "
boolean border = false
boolean displayonly = true
end type

type st_2 from statictext within w_merge_ctx_category
integer x = 978
integer y = 100
integer width = 663
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Target Contract Category:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_merge_ctx_category
integer x = 82
integer y = 100
integer width = 663
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Source Contract Category:"
boolean focusrectangle = false
end type

type dw_target from datawindow within w_merge_ctx_category
integer x = 983
integer y = 164
integer width = 663
integer height = 84
integer taborder = 20
string title = "none"
string dataobject = "d_ctx_category"
boolean livescroll = true
end type

type dw_source from datawindow within w_merge_ctx_category
integer x = 96
integer y = 164
integer width = 658
integer height = 84
integer taborder = 10
string title = "none"
string dataobject = "d_ctx_category"
boolean livescroll = true
end type

type cb_cancel from commandbutton within w_merge_ctx_category
integer x = 1440
integer y = 784
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;Close(Parent)
end event

type cb_merge from commandbutton within w_merge_ctx_category
integer x = 1074
integer y = 784
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Merge"
end type

event clicked;Long ll_source_category,ll_target_category
String ls_err
Integer li_ret

ll_source_category = dw_source.GetItemNumber(1,'category')
ll_target_category = dw_target.GetItemNumber(1,'category')

If Isnull(ll_source_category) Then
	Messagebox('IntelliSoft','The Source Contract Category can not be empty.')
	dw_source.SetFocus()
	Return -1
End If

If Isnull(ll_target_category) Then
	Messagebox('IntelliSoft','The Target Contract Category can not be empty.')
	dw_target.SetFocus()
	Return -1
End If

If ll_source_category = ll_target_category Then
	Messagebox('IntelliSoft','The Target Contract Category and the Source Contract Category can not be the same value.')
	dw_target.SetFocus()
	Return -1	
End If

If Messagebox('Merge Contract Category','Are you sure you want to merge the contract category?',Question!,YesNo!) = 1 Then
	li_ret = of_merge_category(ll_source_category,ll_target_category,cbx_delete.checked,ls_err)
	If li_ret < 0 Then
		Messagebox('IntelliSoft','Failed to merge the contract category. ~r~n'+ls_err+'~r~nPlease call support.',Exclamation!)
	Else
		Messagebox('IntelliSoft','Merge successfully. Please re-login the application.')
	End If
	Parent.Event ue_retrieve_category()
End If

Return 1

end event

type gb_1 from groupbox within w_merge_ctx_category
integer x = 50
integer y = 36
integer width = 1696
integer height = 284
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Contract Category Choose"
end type

