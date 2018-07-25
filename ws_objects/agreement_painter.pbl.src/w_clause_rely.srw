$PBExportHeader$w_clause_rely.srw
$PBExportComments$Create by Jack 11/10/2006
forward
global type w_clause_rely from w_response
end type
type cb_delete from commandbutton within w_clause_rely
end type
type cb_add from commandbutton within w_clause_rely
end type
type cb_close from commandbutton within w_clause_rely
end type
type cb_save from commandbutton within w_clause_rely
end type
type dw_clause_rely from u_dw within w_clause_rely
end type
end forward

global type w_clause_rely from w_response
integer width = 2126
integer height = 908
string title = "Dependant Clauses"
boolean controlmenu = false
long backcolor = 33551856
cb_delete cb_delete
cb_add cb_add
cb_close cb_close
cb_save cb_save
dw_clause_rely dw_clause_rely
end type
global w_clause_rely w_clause_rely

type variables
long il_ctx_acp_clause_id,il_category,il_ctx_acp_clause_rely_id
long il_close  // Add by Jack 05/22/2007

//--------Begin Added by Alfee 05.23.2007-------------
DataStore ids_rely //Store all caluse rely records
Long il_rely_cnt   //The count of rows in ids_rely
Long il_relyid[]   //Store current clause's relied ids
//--------End Added-----------------------------------
end variables

forward prototypes
public function string of_get_filter (long al_clauseid)
public function integer of_find_rely (long al_clauseid)
end prototypes

public function string of_get_filter (long al_clauseid);Long i, ll_cnt
String ls_filter

IF il_rely_cnt < 1 THEN RETURN ''

//Get all relied clause ids recursively
of_find_rely(al_clauseid)

ll_cnt = UpperBound(il_relyid)
IF ll_cnt < 1 THEN RETURN ''

//Generate filter string
ls_filter = 'ctx_acp_clause_id not in ( '
FOR i = 1 to ll_cnt
	IF i = 1 THEN
		ls_filter += String(il_relyid[i])
	ELSE
		ls_filter += ", " + String(il_relyid[i])
	END If
NEXT
ls_filter += ' )'

RETURN ls_filter
end function

public function integer of_find_rely (long al_clauseid);Long ll_found, ll_clauseid

ll_found = ids_rely.Find('ctx_acp_clause_rely_id = ' + String(al_clauseid), 1, il_rely_cnt)
DO While ll_found > 0
	ll_clauseid = ids_rely.GetItemNumber(ll_found, "ctx_acp_clause_id")
	il_relyid[UpperBound(il_relyid) + 1] = ll_clauseid
	of_find_rely(ll_clauseid) //
	IF ll_found >= il_rely_cnt THEN EXIT
	ll_found = ids_rely.Find('ctx_acp_clause_rely_id = ' + String(al_clauseid), ll_found + 1, il_rely_cnt)
LOOP

RETURN 1
end function

on w_clause_rely.create
int iCurrent
call super::create
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_clause_rely=create dw_clause_rely
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_delete
this.Control[iCurrent+2]=this.cb_add
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.dw_clause_rely
end on

on w_clause_rely.destroy
call super::destroy
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_clause_rely)
end on

event open;call super::open;long ll_row,ll_category
string ls_type, ls_filter
str_folder lstr_folder
datawindowchild child

dw_clause_rely.of_SetTransObject( SQLCA )

lstr_folder = message.powerobjectparm
ls_type = lstr_folder.as_type
il_ctx_acp_clause_id = lstr_folder.al_folder_id
ll_category = lstr_folder.al_category
il_category = ll_category

gnv_appeondb.of_startqueue() //Added by Alfee 05.23.2007
dw_clause_rely.getchild('ctx_acp_clause_rely_id',child)
child.settransobject(sqlca)
child.retrieve(ll_category,il_ctx_acp_clause_id)
//---------Beign Added by Alfee 05.23.2007---------------
ids_rely = Create DataStore
ids_rely.DataObject = 'd_clause_rely'
ids_rely.SetTransObject(SQLCA)
il_rely_cnt = ids_rely.Retrieve()
gnv_appeondb.of_commitqueue()
il_rely_cnt = ids_rely.RowCount()
//---------End Added -----------------------------------

If ls_type = 'Update' Then
 	dw_clause_rely.retrieve(il_ctx_acp_clause_id)
	If dw_clause_rely.rowcount() < 1 Then 
		cb_add.triggerevent(clicked!)
		This.title = This.title + ' - Add'
	Else
		This.title = This.title + ' - Edit'
	End If		
Else
	dw_clause_rely.dataobject = 'd_clause_rely_add1'
	dw_clause_rely.settransobject(sqlca)
	dw_clause_rely.getchild('ctx_acp_clause_rely_id',child)
	child.settransobject(sqlca)
	child.retrieve(ll_category,il_ctx_acp_clause_id)
	ll_row = dw_clause_rely.insertrow(0)
	dw_clause_rely.setitem(ll_row,'ctx_acp_clause_id',il_ctx_acp_clause_id)
End If
dw_clause_rely.setfocus()

//---------Beign Added by Alfee 05.23.2007---------------
//Filter the clause rely ids in dddw recursively
//<$Reason>If 1-2, 2-3 then 3-1 is not allowed, or will be a dead loop.
ls_filter = of_get_filter(il_ctx_acp_clause_id) 
IF len(Trim(ls_filter)) > 0 THEN
	child.SetFilter(ls_filter)
	child.Filter()
END IF
//---------End Added -----------------------------------

//-------Begin Added by Alfee 09.20.2007--------
//Set readonly to the window
If w_mdi.of_security_access(6800) < 2 Then
	dw_clause_rely.Enabled = False
	cb_add.Enabled = False
	cb_delete.Enabled = False
	cb_save.Enabled = False
End If
//-------End Added------------------------------

end event

event closequery;long ll_ctx_acp_clause_rely_id
dw_clause_rely.accepttext()
If dw_clause_rely.getrow() > 0 Then
	ll_ctx_acp_clause_rely_id = dw_clause_rely.getitemnumber(dw_clause_rely.getrow(),'ctx_acp_clause_rely_id')
End If
If isnull(ll_ctx_acp_clause_rely_id) Or ll_ctx_acp_clause_rely_id = 0 Then
	ib_closestatus = False
	Return 0
Else
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 05.22.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	Super::Event closequery()
	*/
	il_close = Super::Event closequery()
	Return il_close
	//---------------------------- APPEON END ----------------------------
End If

end event

event close;Destroy ids_rely  //added by alfee 05.23.2007

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.22.2007 By: Jack
//$<reason> Fix a defect.
If il_close = 1 Then
	ib_closestatus = False
	Return 0
Else
	Super::Event close()
End If
//---------------------------- APPEON END ----------------------------


end event

type cb_delete from commandbutton within w_clause_rely
integer x = 1079
integer y = 644
integer width = 334
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;//----------Begin Modified by Alfee 08.29.2007-----------
Long ll_row

ll_row = dw_clause_rely.getrow()
If ll_row > 0 Then dw_clause_rely.deleterow(ll_row)
/*dw_clause_rely.accepttext()
If dw_clause_rely.rowcount() < 1 Then Return
dw_clause_rely.deleterow(0)*/
//----------End Modified ---------------------------------
end event

type cb_add from commandbutton within w_clause_rely
integer x = 741
integer y = 644
integer width = 334
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;long ll_row
ll_row = dw_clause_rely.insertrow(0)
dw_clause_rely.ScrolltoRow(ll_row) //alfee 08.22.2007
dw_clause_rely.setitem(ll_row,'ctx_acp_clause_id',il_ctx_acp_clause_id)
dw_clause_rely.setfocus()

end event

type cb_close from commandbutton within w_clause_rely
integer x = 1755
integer y = 644
integer width = 334
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)


end event

type cb_save from commandbutton within w_clause_rely
integer x = 1417
integer y = 644
integer width = 334
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//---------Begin Modified by Alfee 05.23.2007------------------
Long ll_cnt, i, ll_clauseid, ll_found

dw_clause_rely.accepttext()
If dw_clause_rely.modifiedcount() < 1 and dw_clause_rely.deletedcount() < 1 Then RETURN

ll_cnt = dw_clause_rely.RowCount()
FOR i = 1 to ll_cnt
	ll_clauseid = dw_clause_rely.GetItemNumber(i,'ctx_acp_clause_rely_id')
	//Check empty field
	IF IsNull(ll_clauseid) or ll_clauseid = 0 THEN
		MessageBox('Saving Error','The dependant clause cannot be empty!')
		RETURN
	END IF
	//Check duplicate records
	If i < ll_cnt THEN
		ll_found = dw_clause_rely.Find('ctx_acp_clause_rely_id = ' + String(ll_clauseid), i + 1, ll_cnt)
		IF ll_found > 0 THEN
			MessageBox('Saving Error','The dependant clause cannot be duplicate!')
			RETURN
		END IF
	END IF		
NEXT

//Update data & Close window
IF dw_clause_rely.Update() <> 1 THEN
	MessageBox('Saving Error','The dependant clause cannot be saved! ~r~n' + SQLCA.Sqlerrtext)
ELSE
	Close(Parent)
END IF	

//dw_clause_rely.accepttext()
//
//long ll_row,ll_ctx_acp_clause_rely_id
//boolean lb_update
//il_ctx_acp_clause_rely_id = 0
//If dw_clause_rely.modifiedcount() > 0 Or dw_clause_rely.deletedcount() > 0 Then
//	For ll_row = 1 To dw_clause_rely.rowcount()
//		ll_ctx_acp_clause_rely_id = dw_clause_rely.getitemnumber(ll_row,'ctx_acp_clause_rely_id')
//		If ll_ctx_acp_clause_rely_id <> il_ctx_acp_clause_rely_id Then
//			il_ctx_acp_clause_rely_id = ll_ctx_acp_clause_rely_id
//		Else
//			lb_update = True
//		End If
//	Next
//	If lb_update Then
//		messagebox('Saving Error','Dependant Clause cannot be empty or duplicate.')
//		dw_clause_rely.setfocus()
//		dw_clause_rely.setcolumn(2)
//		Return
//	Else
//		dw_clause_rely.update()
//	End If
//End If
//------------End Modified----------------------------------
end event

type dw_clause_rely from u_dw within w_clause_rely
integer y = 16
integer width = 2089
integer height = 600
integer taborder = 20
string dataobject = "d_clause_rely_add"
boolean hscrollbar = true
end type

event constructor;//This.of_SetUpdateable( False )
end event

event clicked;call super::clicked;//Added by Alfee 08.30.2007
if row > 0 and getrow() <> row then
	scrolltorow(row)
end if
end event

