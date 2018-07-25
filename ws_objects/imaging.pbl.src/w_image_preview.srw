$PBExportHeader$w_image_preview.srw
$PBExportComments$SK Practitioner Folder - alfee 09.08.2010
forward
global type w_image_preview from w_popup
end type
type st_none from statictext within w_image_preview
end type
type cb_1 from commandbutton within w_image_preview
end type
type uo_1 from pfc_cst_u_image_preview within w_image_preview
end type
end forward

global type w_image_preview from w_popup
integer width = 3209
integer height = 2272
string title = "Image Preview"
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_none st_none
cb_1 cb_1
uo_1 uo_1
end type
global w_image_preview w_image_preview

forward prototypes
public function integer of_get_image (string as_parm, long al_rec_id)
end prototypes

public function integer of_get_image (string as_parm, long al_rec_id);//===================================
// $<Function> View Image: of_get_image ()
// $<arguments>
//	value string as_parm:prac_id and screen_id
//	value long al_rec_id:rec_id
// $<returns> integer
// $<description> get image from the Demographics screens
// $<add> (Appeon) Long.zhang 11.04.2011
//===================================

long ll_pos,ll_prac,ll_scr,ll_row

ll_pos = Pos(as_parm, '||')

if  ll_pos > 0 then
	ll_prac = Long(Left (as_parm, ll_pos - 1))
	ll_scr = Long(Mid(as_parm, ll_pos + 2))
	
	//Start Code Change ----12.04.2012 #V12 maha - added user variable and filter
	uo_1.tab_view.tabpage_browse.dw_browse.retrieve(ll_prac, ll_scr, gs_user_id)	
	uo_1.of_security_filter( uo_1.tab_view.tabpage_browse.dw_browse)
	 //End Code Change ----12.04.2012
end if
ll_row =  uo_1.tab_view.tabpage_browse.dw_browse.find( 'pd_images_prac_id='+String(ll_prac)+' and pd_images_screen_id='+String(ll_scr)+' and pd_images_rec_id='+String(al_rec_id),1, uo_1.tab_view.tabpage_browse.dw_browse.rowcount())

if ll_row > 0 then
	 uo_1.tab_view.tabpage_browse.dw_browse.scrolltorow( ll_row)
	 uo_1.tab_view.tabpage_browse.dw_browse.selectrow( 0,false)
	 uo_1.tab_view.tabpage_browse.dw_browse.selectrow( ll_row,true)
end if
uo_1.tab_view.selecttab( 2)

return 1

end function

on w_image_preview.create
int iCurrent
call super::create
this.st_none=create st_none
this.cb_1=create cb_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_none
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.uo_1
end on

on w_image_preview.destroy
call super::destroy
destroy(this.st_none)
destroy(this.cb_1)
destroy(this.uo_1)
end on

event open;//SK Practitioner Folder - alfee 09.10.2010

Long ll_pos, ll_pos2,ll_prac, ll_scr,LL_I,ll_rec,ll_row
String ls_mess,ls_scale

ls_mess = Message.StringParm
ll_pos = Pos(ls_mess, '||')

if  ll_pos > 0 then
	ll_prac = Long(Left (ls_mess, ll_pos - 1))
	//----------------------APPEON BEGIN ------------------
	//<$Modified > long.zhang 03.28.2012
	//<$Reason> get correct image if clicked view image button
	ll_pos2 = Pos(ls_mess, '||',ll_pos+2)
	if ll_pos2 >0 then
		ll_scr = Long(Mid(ls_mess, ll_pos + 2,ll_pos2 - ll_pos -2 ))
		ll_rec = long(Mid(ls_mess,ll_pos2+2))	
	else
		ll_scr = Long(Mid(ls_mess, ll_pos + 2))
	end if

	uo_1.tab_view.tabpage_browse.dw_browse.settransobject( SQLCA)
	 //Start Code Change ----12.04.2012 #V12 maha - added user variable and filter
	 //Start Code Change ----09.15.2017 #V154 maha - modified for retrieval options
	//uo_1.tab_view.tabpage_browse.dw_browse.retrieve(ll_prac, ll_scr, gs_user_id)	
	uo_1.of_retrieve( ll_prac, ll_scr)
	 //End Code Change ----09.15.2017 
	uo_1.of_security_filter( uo_1.tab_view.tabpage_browse.dw_browse)
	 //End Code Change ----12.04.2012
	
	if ll_rec > 0 then
		ll_row = uo_1.tab_view.tabpage_browse.dw_browse.find('pd_images_rec_id='+String(ll_rec),1,uo_1.tab_view.tabpage_browse.dw_browse.rowcount())
		IF ll_row >0 then
			 uo_1.tab_view.tabpage_browse.dw_browse.scrolltorow( ll_row)
			 uo_1.tab_view.tabpage_browse.dw_browse.selectrow( 0,false)
			 uo_1.tab_view.tabpage_browse.dw_browse.selectrow( ll_row,true)
		end if
	else  //Start Code Change ----12.19.2014 #V14.2 maha
		ll_row = 1
	end if
	//----------------------APPEON END---------------------
	uo_1.of_set_menu( 1)
end if

uo_1.of_set_parent( this)

//if uo_1.tab_view.tabpage_browse.dw_browse.getrow( ) > 0 then
if uo_1.tab_view.tabpage_browse.dw_browse.getrow( ) > 0 and ll_row > 0 then  //Start Code Change ----12.19.2014 #V14.2 maha  - stay on browse tab if no matching image
	uo_1.tab_view.post selecttab( 2)
end if

//--------------APPEON BEGIN------------------------
//$<add> long.zhang 11.04.2011
//$<Reason> view image can  resize window

this.of_SetResize(TRUE)
ls_scale = this.inv_resize.scale

this.inv_resize.of_SetOrigSize (this.workspacewidth( ) ,  this.workspaceheight( ) )
	
FOR LL_I =  1 TO UPPERBOUND(this.CONTrol)
   this.inv_resize.of_Register (this.CONTrol[LL_I]  , ls_scale	 )
NEXT

this.inv_resize.of_Register (this.uo_1.tab_view  , ls_scale	 )

FOR LL_I =  1 TO UPPERBOUND(this.uo_1.tab_view.tabpage_browse.Control)
	 this.inv_resize.of_Register (this.uo_1.tab_view.tabpage_browse.CONTrol[LL_I]  , ls_scale	 )
next

FOR LL_I =  1 TO UPPERBOUND(this.uo_1.tab_view.tabpage_image.Control)
	 this.inv_resize.of_Register (this.uo_1.tab_view.tabpage_image.CONTrol[LL_I]  , ls_scale	 )
next
//--------------APPEON END-------------------------------
end event

event resize;
uo_1.width = this.width - 60
uo_1.height = this.height - 170 - uo_1.y
uo_1.of_resize()
end event

type st_none from statictext within w_image_preview
boolean visible = false
integer x = 91
integer y = 24
integer width = 1929
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "No available image for selected record"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_image_preview
integer x = 2802
integer y = 4
integer width = 343
integer height = 92
integer taborder = 30
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

type uo_1 from pfc_cst_u_image_preview within w_image_preview
integer x = 14
integer y = 116
integer width = 3177
integer taborder = 40
end type

on uo_1.destroy
call pfc_cst_u_image_preview::destroy
end on

