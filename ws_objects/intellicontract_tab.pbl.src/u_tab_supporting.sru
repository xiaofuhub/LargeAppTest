$PBExportHeader$u_tab_supporting.sru
$PBExportComments$[intellicontract_tab]  Supporting information Tab
forward
global type u_tab_supporting from u_tab
end type
type tabpage_image from u_tabpage_supporting_scanned_images within u_tab_supporting
end type
type tabpage_image from u_tabpage_supporting_scanned_images within u_tab_supporting
end type
type tabpage_docs from u_tabpage_supporting_docs within u_tab_supporting
end type
type tabpage_docs from u_tabpage_supporting_docs within u_tab_supporting
end type
end forward

global type u_tab_supporting from u_tab
integer width = 3977
integer height = 1996
long backcolor = 33551856
tabpage_image tabpage_image
tabpage_docs tabpage_docs
end type
global u_tab_supporting u_tab_supporting

forward prototypes
public function integer of_retieve ()
end prototypes

public function integer of_retieve ();



//this.tabpage_docs.of_retrieve( )
//this.tabpage_image.of_retrieve( )


return 0
end function

on u_tab_supporting.create
this.tabpage_image=create tabpage_image
this.tabpage_docs=create tabpage_docs
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_image
this.Control[iCurrent+2]=this.tabpage_docs
end on

on u_tab_supporting.destroy
call super::destroy
destroy(this.tabpage_image)
destroy(this.tabpage_docs)
end on

event selectionchanged;call super::selectionchanged;


this.tabpage_image.event ue_selectionchanged( )


if newindex =  1 then 
	this.tabpage_image.tab_1.tabpage_browse.dw_1.setfocus( )
else 
	this.tabpage_docs.tab_1.tabpage_1.dw_1.setfocus( )
//	this.tabpage_image.tab_1.tabpage_view.uo_1.dw_1.setfocus( )
	
end if


end event

type tabpage_image from u_tabpage_supporting_scanned_images within u_tab_supporting
integer x = 18
integer y = 100
integer width = 3941
integer height = 1880
end type

type tabpage_docs from u_tabpage_supporting_docs within u_tab_supporting
integer x = 18
integer y = 100
integer width = 3941
integer height = 1880
end type

