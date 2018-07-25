$PBExportHeader$w_wv_required_template_new.srw
$PBExportComments$WebView required document template
forward
global type w_wv_required_template_new from w_response
end type
type cb_types from commandbutton within w_wv_required_template_new
end type
type p_1 from picture within w_wv_required_template_new
end type
type cb_close from commandbutton within w_wv_required_template_new
end type
type cb_save from commandbutton within w_wv_required_template_new
end type
type cb_selectall from commandbutton within w_wv_required_template_new
end type
type dw_images from u_dw within w_wv_required_template_new
end type
type dw_select from datawindow within w_wv_required_template_new
end type
type cb_delete from commandbutton within w_wv_required_template_new
end type
type cb_copy from commandbutton within w_wv_required_template_new
end type
type cb_new from commandbutton within w_wv_required_template_new
end type
type gb_1 from groupbox within w_wv_required_template_new
end type
end forward

global type w_wv_required_template_new from w_response
integer x = 214
integer y = 221
integer width = 2565
integer height = 2564
string title = "WebView Required Document Templates"
long backcolor = 33551856
cb_types cb_types
p_1 p_1
cb_close cb_close
cb_save cb_save
cb_selectall cb_selectall
dw_images dw_images
dw_select dw_select
cb_delete cb_delete
cb_copy cb_copy
cb_new cb_new
gb_1 gb_1
end type
global w_wv_required_template_new w_wv_required_template_new

type variables
long    il_template_id=0
string is_template_name=""
end variables

on w_wv_required_template_new.create
int iCurrent
call super::create
this.cb_types=create cb_types
this.p_1=create p_1
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_selectall=create cb_selectall
this.dw_images=create dw_images
this.dw_select=create dw_select
this.cb_delete=create cb_delete
this.cb_copy=create cb_copy
this.cb_new=create cb_new
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_types
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.cb_selectall
this.Control[iCurrent+6]=this.dw_images
this.Control[iCurrent+7]=this.dw_select
this.Control[iCurrent+8]=this.cb_delete
this.Control[iCurrent+9]=this.cb_copy
this.Control[iCurrent+10]=this.cb_new
this.Control[iCurrent+11]=this.gb_1
end on

on w_wv_required_template_new.destroy
call super::destroy
destroy(this.cb_types)
destroy(this.p_1)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_selectall)
destroy(this.dw_images)
destroy(this.dw_select)
destroy(this.cb_delete)
destroy(this.cb_copy)
destroy(this.cb_new)
destroy(this.gb_1)
end on

event open;call super::open;IF gi_imaging = 0 THEN
	cb_types.Visible = False
ELSE
	IF w_mdi.of_security_access( 1370 ) = 0 THEN
		cb_types.Visible = False
	ELSE
		cb_types.Visible = True
	END IF
END IF
end event

type cb_types from commandbutton within w_wv_required_template_new
integer x = 1545
integer y = 12
integer width = 494
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Document Types"
end type

event clicked;open(w_image_type_painter)
end event

type p_1 from picture within w_wv_required_template_new
integer x = 41
integer y = 316
integer width = 1541
integer height = 92
boolean originalsize = true
string picturename = "wv_req_status.png"
boolean border = true
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_wv_required_template_new
integer x = 2043
integer y = 12
integer width = 453
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_save from commandbutton within w_wv_required_template_new
integer x = 1106
integer y = 12
integer width = 434
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;parent.event pfc_save()
end event

type cb_selectall from commandbutton within w_wv_required_template_new
boolean visible = false
integer x = 1330
integer y = 316
integer width = 82
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select &All"
end type

event clicked;int  li
int  new_value



IF LeftA(lower(this.text),6)="select" THEN
	new_Value=1
	this.text = "Unselect &All"
ELSE
	new_Value=0
	this.text = "Select &All"
END IF

FOR li = 1 to dw_images.rowcount()
	dw_images.setitem(li,"is_image_linked",new_value)
NEXT
end event

type dw_images from u_dw within w_wv_required_template_new
integer x = 18
integer y = 420
integer width = 2519
integer height = 2048
integer taborder = 50
string dataobject = "d_required_template_images"
end type

event pfc_retrieve;return this.retrieve(il_template_id)
end event

event retrieveend;call super::retrieveend;int   li

for li =1 to rowcount
	if isnull(this.getitemnumber(li,"template_id")) or &
		   this.getitemnumber(li,"template_id") <=0 THEN
		this.setitemstatus(li,0,primary!,New!)
	END IF
next


end event

event pfc_preupdate;call super::pfc_preupdate;int   li

for li =1 to rowcount()
	if isnull(this.getitemnumber(li,"template_id")) or &
		   this.getitemnumber(li,"template_id") <=0 THEN
		this.setitem(li,"template_id",il_template_id)
	END IF
	if isnull(this.getitemnumber(li,"image_type_id")) or &
		   this.getitemnumber(li,"image_type_id") <=0 THEN
		this.setitem(li,"image_type_id",this.getitemnumber(li,"image_type_image_type_id"))
	END IF
	if isnull(this.getitemnumber(li,"is_image_linked")) THEN
		this.setitem(li,"is_image_linked",0)
	END IF
next

return success
end event

event constructor;call super::constructor;this.of_setrowselect( true)
this.ib_rmbmenu = false

end event

event buttonclicked;call super::buttonclicked;int  li
int  new_value

if dwo.name = "b_select" then
	IF LeftA(lower(dwo.text),6)="select" THEN
		new_Value=1
		dwo.text = "Unselect &All"
	ELSE
		new_Value=0
		dwo.text = "Select &All"
	END IF
	
	FOR li = 1 to dw_images.rowcount()
		dw_images.setitem(li,"is_image_linked",new_value)
	NEXT
end if
end event

type dw_select from datawindow within w_wv_required_template_new
event ue_retrievedddw ( )
integer x = 69
integer y = 156
integer width = 878
integer height = 88
integer taborder = 40
string title = "none"
string dataobject = "d_select_required_template"
boolean border = false
boolean livescroll = true
end type

event ue_retrievedddw();datawindowchild  dwchild

this.getchild("template_id",dwchild)
dwchild.reset()
dwchild.settransobject(sqlca)
dwchild.retrieve()

end event

event constructor;THIS.SETTRAnsobject( sqlca)
this.event ue_retrievedddw( )
end event

event itemchanged;IF row < 1 then return

IF parent.event closequery() = 1 THEN 
	this.setitem(row,1,il_template_id)
	return 1
END IF
IF long(data) <= 0 OR isnull(data) THEN
	dw_images.reset()
	return
END IF

il_template_id = long(data)
dw_images.event pfc_retrieve()

end event

type cb_delete from commandbutton within w_wv_required_template_new
integer x = 2016
integer y = 156
integer width = 453
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete Template"
end type

event clicked;IF il_template_id <= 0 or isnull(il_template_id) THEN
	messagebox("Delete","Please select a template to delete.",exclamation!)
	return
END IF

int  li_count

SELECT count(*) INTO :li_count
FROM facility
WHERE default_wv_init_template=:il_template_id
	  OR default_wv_reapp_template=:il_template_id;

IF li_Count > 0 THEN
	messagebox('Delete','Current template has been used in Facility Painter. It cannot be deleted.',exclamation!)
	return
END IF

IF messagebox("Delete","Are you sure you want to delete this template?",question!,yesno!,2) <> 1 then return


gnv_appeondb.of_startqueue( )
delete from wv_required_template_image where template_id = :il_template_id;

delete from wv_required_template  where template_id = :il_template_id;

commit;

dw_select.event ue_retrievedddw( )
gnv_appeondb.of_commitqueue( )

setnull(il_template_id)
dw_select.setitem(1,1,il_template_id)

dw_select.post event itemchanged(1,dw_select.object.template_id,string(il_template_id))

end event

type cb_copy from commandbutton within w_wv_required_template_new
integer x = 1504
integer y = 156
integer width = 453
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "C&opy Template"
end type

event clicked;IF il_template_id <= 0 or isnull(il_template_id) THEN
	messagebox("Copy","Please select a template to copy.",exclamation!)
	return
END IF
IF parent.event closequery() = 1 THEN return

open(w_get_template_name)

IF Message.StringParm = "Cancel" THEN
	Return -1
ELSE
	is_template_name = Message.StringParm
	long  li_rec_id
	
	gnv_appeondb.of_startqueue( )
	Insert into wv_required_template(template_name) values(:is_template_name);
	commit;
	select max(template_id) into :li_rec_id from wv_required_template;
	
	//---------Begin Added by (Appeon)Stephen 10.08.2016 for Bug 5346 - WebView Required Documents Templates copy--------
	gnv_appeondb.of_commitqueue( )
	gnv_appeondb.of_startqueue( )
	//---------End Added ------------------------------------------------------ 
	insert into wv_required_template_image(template_id,image_type_id,is_image_linked)
	select :li_rec_id,image_type_id,is_image_linked
	from wv_required_template_image
	where template_id=:il_template_id;

	dw_select.event ue_retrievedddw( )

	gnv_appeondb.of_commitqueue( )
	
	dw_select.setitem(1,1,li_rec_id)
	
	dw_select.post event itemchanged(1,dw_select.object.template_id,string(li_rec_id))
END IF



end event

type cb_new from commandbutton within w_wv_required_template_new
integer x = 978
integer y = 156
integer width = 453
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&New Template"
end type

event clicked;long li_rec_id
Integer li_retval

li_retval = parent.Event closequery()
IF li_retval = 1 THEN
	Return 1
END IF

Open( w_get_template_name )  //maha 083105 changed window name
IF Message.StringParm = "Cancel" THEN
	Return -1
ELSE
	is_template_name = Message.StringParm
	Insert into wv_required_template(template_name) values(:is_template_name);
	commit;
	select max(template_id) into :li_rec_id from wv_required_template;
	
	dw_select.event ue_retrievedddw( )
	dw_select.setitem(1,1,li_rec_id)
	
	dw_select.post event itemchanged(1,dw_select.object.template_id,string(li_rec_id))
END IF



end event

type gb_1 from groupbox within w_wv_required_template_new
integer x = 32
integer y = 96
integer width = 2473
integer height = 180
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Template"
end type

