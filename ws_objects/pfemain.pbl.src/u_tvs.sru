$PBExportHeader$u_tvs.sru
$PBExportComments$Extension Serviced Base TreeView class
forward
global type u_tvs from pfc_u_tvs
end type
end forward

global type u_tvs from pfc_u_tvs
event pfc_cst_collapseall ( )
event pfc_cst_expandall ( )
end type
global u_tvs u_tvs

event pfc_cst_collapseall();//====================================================================
//$<Event>: pfc_cst_collapseall
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Toney 06.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Added By Ken.Guo 2010-01-05.
long ll_tvi

ll_tvi = This.finditem(roottreeitem!, 0)
ll_tvi = This.FindItem(ChildTreeItem!,ll_tvi)

Do While ll_tvi > 0 
	This.collapseitem(ll_tvi)
	ll_tvi = This.finditem(NextTreeItem!, ll_tvi)
Loop


end event

event pfc_cst_expandall();//====================================================================
//$<Event>: pfc_cst_expandall
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Toney 06.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Added By Ken.Guo 2010-01-05.
long ll_tvi
ll_tvi = This.FindItem(RootTreeItem!, 0)
This.ExpandAll(ll_tvi)

end event

on u_tvs.create
call super::create
end on

on u_tvs.destroy
call super::destroy
end on

