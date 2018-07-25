$PBExportHeader$u_tabpage_supporting_scanned_images.sru
$PBExportComments$[intellicontract_tab]  Supporting information Tab
forward
global type u_tabpage_supporting_scanned_images from u_tabpg_contract_master
end type
type tab_1 from u_tab_supporting_images_det within u_tabpage_supporting_scanned_images
end type
type tab_1 from u_tab_supporting_images_det within u_tabpage_supporting_scanned_images
end type
end forward

global type u_tabpage_supporting_scanned_images from u_tabpg_contract_master
string text = "Scanned Images"
tab_1 tab_1
end type
global u_tabpage_supporting_scanned_images u_tabpage_supporting_scanned_images

type variables


STRING IS_VERSION
end variables

forward prototypes
public function integer of_retrieve ()
end prototypes

public function integer of_retrieve ();


this.tab_1.of_retrieve( )

return 0
end function

on u_tabpage_supporting_scanned_images.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on u_tabpage_supporting_scanned_images.destroy
call super::destroy
destroy(this.tab_1)
end on

type st_1 from u_tabpg_contract_master`st_1 within u_tabpage_supporting_scanned_images
end type

type tab_1 from u_tab_supporting_images_det within u_tabpage_supporting_scanned_images
integer taborder = 10
boolean bringtotop = true
tabposition tabposition = tabsonbottom!
end type

