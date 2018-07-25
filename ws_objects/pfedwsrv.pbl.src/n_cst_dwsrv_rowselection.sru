$PBExportHeader$n_cst_dwsrv_rowselection.sru
$PBExportComments$Extension DataWindow Row Selection service
forward
global type n_cst_dwsrv_rowselection from pfc_n_cst_dwsrv_rowselection
end type
end forward

global type n_cst_dwsrv_rowselection from pfc_n_cst_dwsrv_rowselection
end type
global n_cst_dwsrv_rowselection n_cst_dwsrv_rowselection

forward prototypes
public subroutine of_selectrow_custom (long al_row)
end prototypes

public subroutine of_selectrow_custom (long al_row);//====================================================================
//$<Function>: of_selectrow_custom
//$<Arguments>:
// 	value    long    al_row
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Toney 06.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long ll_getrow,i,ll_start,ll_end

If al_row <= 0 Then Return 
ll_getrow = idw_requestor.GetRow()

If KeyDown(KeyControl!) Then
	idw_requestor.SelectRow(al_row, Not idw_requestor.IsSelected(al_row))
ElseIf KeyDown(KeyShift!) Then
	idw_requestor.SetRedraw(False)
	If al_row < ll_getrow Then
		ll_start = al_row
		ll_end = ll_getrow
	Else
		ll_start = ll_getrow
		ll_end = al_row
	End If
	idw_requestor.SelectRow(0,False)
	For i = ll_start to ll_end
		idw_requestor.SelectRow(i,True)
	Next
	idw_requestor.SetRedraw(True)
Else
	idw_requestor.SelectRow(0,False)
	idw_requestor.SelectRow(al_row,True)	
End If

Return


end subroutine

on n_cst_dwsrv_rowselection.create
call super::create
end on

on n_cst_dwsrv_rowselection.destroy
call super::destroy
end on

