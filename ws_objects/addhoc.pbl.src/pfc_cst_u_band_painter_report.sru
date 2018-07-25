$PBExportHeader$pfc_cst_u_band_painter_report.sru
$PBExportComments$(Appeon)Toney 06.10.2013 - V141 ISG-CLX
forward
global type pfc_cst_u_band_painter_report from userobject
end type
type st_trailergroup from statictext within pfc_cst_u_band_painter_report
end type
type dw_trailergroup from pfc_cst_u_band_report within pfc_cst_u_band_painter_report
end type
type st_headergroup from statictext within pfc_cst_u_band_painter_report
end type
type dw_headergroup from pfc_cst_u_band_report within pfc_cst_u_band_painter_report
end type
type sle_tab from singlelineedit within pfc_cst_u_band_painter_report
end type
type dw_syntax from u_dw within pfc_cst_u_band_painter_report
end type
type st_footer from statictext within pfc_cst_u_band_painter_report
end type
type st_summary from statictext within pfc_cst_u_band_painter_report
end type
type st_detail from statictext within pfc_cst_u_band_painter_report
end type
type dw_footer from pfc_cst_u_band_report within pfc_cst_u_band_painter_report
end type
type dw_summary from pfc_cst_u_band_report within pfc_cst_u_band_painter_report
end type
type dw_detail from pfc_cst_u_band_report within pfc_cst_u_band_painter_report
end type
type dw_header from pfc_cst_u_band_report within pfc_cst_u_band_painter_report
end type
type st_header from statictext within pfc_cst_u_band_painter_report
end type
type dw_ruler from datawindow within pfc_cst_u_band_painter_report
end type
end forward

global type pfc_cst_u_band_painter_report from userobject
integer width = 2679
integer height = 2664
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
long backcolor = 67108864
string text = "none"
integer unitsperline = 200
integer unitspercolumn = 200
borderstyle borderstyle = styleraised!
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_trailergroup st_trailergroup
dw_trailergroup dw_trailergroup
st_headergroup st_headergroup
dw_headergroup dw_headergroup
sle_tab sle_tab
dw_syntax dw_syntax
st_footer st_footer
st_summary st_summary
st_detail st_detail
dw_footer dw_footer
dw_summary dw_summary
dw_detail dw_detail
dw_header dw_header
st_header st_header
dw_ruler dw_ruler
end type
global pfc_cst_u_band_painter_report pfc_cst_u_band_painter_report

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-06 By: Andy
boolean			ib_Moving = FALSE
long				il_CurrentY[],il_PriorY[]
long				il_loc

//---------------------------- APPEON END ----------------------------
u_dw			idw_preview
Long			il_view_id
Boolean     ib_group = false
end variables

on pfc_cst_u_band_painter_report.create
this.st_trailergroup=create st_trailergroup
this.dw_trailergroup=create dw_trailergroup
this.st_headergroup=create st_headergroup
this.dw_headergroup=create dw_headergroup
this.sle_tab=create sle_tab
this.dw_syntax=create dw_syntax
this.st_footer=create st_footer
this.st_summary=create st_summary
this.st_detail=create st_detail
this.dw_footer=create dw_footer
this.dw_summary=create dw_summary
this.dw_detail=create dw_detail
this.dw_header=create dw_header
this.st_header=create st_header
this.dw_ruler=create dw_ruler
this.Control[]={this.st_trailergroup,&
this.dw_trailergroup,&
this.st_headergroup,&
this.dw_headergroup,&
this.sle_tab,&
this.dw_syntax,&
this.st_footer,&
this.st_summary,&
this.st_detail,&
this.dw_footer,&
this.dw_summary,&
this.dw_detail,&
this.dw_header,&
this.st_header,&
this.dw_ruler}
end on

on pfc_cst_u_band_painter_report.destroy
destroy(this.st_trailergroup)
destroy(this.dw_trailergroup)
destroy(this.st_headergroup)
destroy(this.dw_headergroup)
destroy(this.sle_tab)
destroy(this.dw_syntax)
destroy(this.st_footer)
destroy(this.st_summary)
destroy(this.st_detail)
destroy(this.dw_footer)
destroy(this.dw_summary)
destroy(this.dw_detail)
destroy(this.dw_header)
destroy(this.st_header)
destroy(this.dw_ruler)
end on

type st_trailergroup from statictext within pfc_cst_u_band_painter_report
event mousedown pbm_lbuttondown
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer y = 1544
integer width = 2464
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "SizeNS!"
long textcolor = 33554432
long backcolor = 67108864
string text = "TrailerGroup"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;if dw_trailergroup.iuo_parent.ib_set_tab_order then return

ib_moving = TRUE
il_priory[6] = this.y
il_loc= this.y
end event

event mousemove;long   ly

if dw_trailergroup.iuo_parent.ib_set_tab_order then return

If ib_Moving And KeyDown(KeyLeftButton!) Then
	this.setposition(totop!)
	ly = Parent.Pointery()
	//$<modify> 01.08.2008 by: Andy
	//IF ly < dw_trailergroup.y  OR ly > parent.height - 500 THEN
	IF ly < dw_trailergroup.y THEN
		return 0
	END IF
	this.y = ly
	il_CurrentY[6] = ly
End If

end event

event mouseup;long  ll_Moved
long	ll_find,ll_object_no

if dw_trailergroup.iuo_parent.ib_set_tab_order then return

If UpperBound(il_CurrentY[])<1 Or UpperBound(il_PriorY[])<1 Then Return 

ll_moved =  il_CurrentY[6] - il_PriorY[6]
If this.y<>il_loc Then
	if ib_moving then
		this.setposition(totop!)
	
		this.move(this.x,il_CurrentY[6])
	
		dw_trailergroup.height=dw_trailergroup.height + ll_moved
			
		dw_summary.y = this.y + this.height + 4
		st_summary.y = dw_summary.y + dw_summary.height + 4
		
		dw_footer.y = st_summary.y + st_summary.height + 4
		st_footer.y = dw_footer.y + dw_footer.height + 4
	
		ib_moving=false
		dw_syntax.modify("datawindow.trailer.1.height='"+string(dw_trailergroup.height)+"'")
	end if
	
	il_PriorY[6] = il_CurrentY[6]
	il_PriorY[3] = st_summary.y
	il_CurrentY[3] = st_Header.y
	il_PriorY[4] = st_Footer.y
	il_CurrentY[4] = st_Footer.y
else 
	ib_moving=false
End If 
return 0
end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_trailergroup.event getfocus()
end event

type dw_trailergroup from pfc_cst_u_band_report within pfc_cst_u_band_painter_report
integer y = 1216
integer width = 2359
integer height = 264
integer taborder = 20
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.is_BandType = 'TRAILER.1'
end event

event getfocus;call super::getfocus;iw_parentwin.is_curband = this.is_bandType

//dw_detail.modify('datawindow.detail.color='+dw_syntax.describe('datawindow.detail.color'))

IF dw_detail.is_CurObj<>''  THEN
	dw_detail.of_unselectobj(dw_detail.is_CurObj)
END IF

//dw_summary.modify('datawindow.summary.color='+dw_syntax.describe('datawindow.summary.color'))
IF dw_summary.is_CurObj<>''  THEN
	dw_Summary.of_unselectobj(dw_Summary.is_CurObj)
END IF
//dw_footer.Modify("DataWindow.Trailer.1.Height='0'")
//dw_footer.modify('datawindow.footer.color='+dw_syntax.describe('datawindow.footer.color'))
IF dw_footer.is_CurObj<>''  THEN
	dw_Footer.of_unselectobj(dw_Footer.is_CurObj)
END IF
//
IF dw_header.is_CurObj<>''  THEN
	dw_header.of_unselectobj(dw_header.is_CurObj)
END IF

IF dw_headergroup.is_CurObj<>''  THEN
	dw_headergroup.of_unselectobj(dw_headergroup.is_CurObj)
END IF
end event

event resize;call super::resize;this.modify("datawindow.trailer.1.height="+string(this.height))

end event

type st_headergroup from statictext within pfc_cst_u_band_painter_report
event mousemove pbm_mousemove
event mousedown pbm_lbuttondown
event mouseup pbm_lbuttonup
integer y = 720
integer width = 2464
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "SizeNS!"
long textcolor = 33554432
long backcolor = 67108864
string text = "HeaderGroup"
boolean border = true
boolean focusrectangle = false
end type

event mousemove;long   ly

if dw_headergroup.iuo_parent.ib_set_tab_order then return

If ib_Moving And KeyDown(KeyLeftButton!) Then
	this.setposition(totop!)
	ly = Parent.Pointery()
	//$<modify> 01.08.2008 by: Andy
	//IF ly < dw_headergroup.y  OR ly > parent.height - 500 THEN
	IF ly < dw_headergroup.y THEN
		return 0
	END IF
	this.y = ly
	il_CurrentY[5] = ly
End If

end event

event mousedown;if dw_headergroup.iuo_parent.ib_set_tab_order then return

ib_moving = TRUE
il_priory[5] = this.y
il_loc= this.y
end event

event mouseup;long  ll_Moved
long	ll_find,ll_object_no

if dw_headergroup.iuo_parent.ib_set_tab_order then return

If UpperBound(il_CurrentY[])<1 Or UpperBound(il_PriorY[])<1 Then Return 

ll_moved =  il_CurrentY[5] - il_PriorY[5]
If this.y<>il_loc Then
	if ib_moving then
		this.setposition(totop!)
	
		this.move(this.x,il_CurrentY[5])
	
		dw_headergroup.height=dw_headergroup.height + ll_moved
		
		dw_detail.y = this.y + this.height + 4
		st_detail.y = dw_detail.y + dw_detail.height + 4
		//
		dw_trailergroup.y = st_detail.y + st_detail.height + 4
		st_trailergroup.y = dw_trailergroup.y + dw_trailergroup.height + 4
	
		dw_summary.y = st_trailergroup.y + st_trailergroup.height + 4
		st_summary.y = dw_summary.y + dw_summary.height + 4
		
		dw_footer.y = st_summary.y + st_summary.height + 4
		st_footer.y = dw_footer.y + dw_footer.height + 4
	
		ib_moving=false
		dw_syntax.modify("datawindow.header.1.height='"+string(dw_headergroup.height)+"'")
	end if
	
	il_PriorY[5] = il_CurrentY[5]
	il_PriorY[2] = st_detail.y
	il_CurrentY[2] = st_detail.y
	il_PriorY[3] = st_summary.y
	il_CurrentY[3] = st_Header.y
	il_PriorY[4] = st_Footer.y
	il_CurrentY[4] = st_Footer.y
	il_PriorY[6] = st_trailergroup.y
	il_CurrentY[6] = st_trailergroup.y
else 
	ib_moving=false
End If 
return 0
end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_headergroup.event getfocus()
end event

type dw_headergroup from pfc_cst_u_band_report within pfc_cst_u_band_painter_report
integer y = 408
integer width = 2359
integer height = 264
integer taborder = 30
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.is_BandType = 'HEADER.1'
end event

event getfocus;call super::getfocus;iw_parentwin.is_curband = this.is_bandType

//dw_detail.modify('datawindow.detail.color='+dw_syntax.describe('datawindow.detail.color'))

IF dw_detail.is_CurObj<>''  THEN
	dw_detail.of_unselectobj(dw_detail.is_CurObj)
END IF

//dw_summary.modify('datawindow.summary.color='+dw_syntax.describe('datawindow.summary.color'))
IF dw_summary.is_CurObj<>''  THEN
	dw_Summary.of_unselectobj(dw_Summary.is_CurObj)
END IF
//dw_footer.Modify("DataWindow.Trailer.1.Height='0'")
//dw_footer.modify('datawindow.footer.color='+dw_syntax.describe('datawindow.footer.color'))
IF dw_footer.is_CurObj<>''  THEN
	dw_Footer.of_unselectobj(dw_Footer.is_CurObj)
END IF
//
IF dw_header.is_CurObj<>''  THEN
	dw_header.of_unselectobj(dw_header.is_CurObj)
END IF

IF dw_trailergroup.is_CurObj<>''  THEN
	dw_trailergroup.of_unselectobj(dw_trailergroup.is_CurObj)
END IF
end event

event resize;call super::resize;this.modify("datawindow.header.1.height="+string(this.height))


end event

type sle_tab from singlelineedit within pfc_cst_u_band_painter_report
boolean visible = false
integer x = 9
integer y = 160
integer width = 165
integer height = 68
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_syntax from u_dw within pfc_cst_u_band_painter_report
boolean visible = false
integer x = 549
integer y = 1424
integer width = 791
integer height = 184
integer taborder = 20
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//<add> 11/13/2007 by: Andy
of_setbase( true)
inv_base.of_setrequestor(this)
//$<add> 01.10.2008 By: Andy
This.of_SetUpdateable(False)

end event

type st_footer from statictext within pfc_cst_u_band_painter_report
event mousedown pbm_lbuttondown
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer y = 2368
integer width = 2464
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "SizeNS!"
long textcolor = 33554432
long backcolor = 67108864
string text = "Footer"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;if dw_footer.iuo_parent.ib_set_tab_order then return

ib_moving = TRUE
il_priory[4] = this.y
il_loc =this.y
end event

event mousemove;long   ly

if dw_footer.iuo_parent.ib_set_tab_order then return

If ib_Moving And KeyDown(KeyLeftButton!) Then
	this.setposition(totop!)
	ly = Parent.Pointery()
	//$<modify> 01.08.2008 by: Andy
	//IF ly <= dw_Footer.y  OR ly > parent.height - 500 THEN
	IF ly <= dw_Footer.y THEN
		return 0
	END IF
	this.y = ly
	il_CurrentY[4] = ly
End If

end event

event mouseup;long  ll_Moved
long	ll_find,ll_object_no

if dw_footer.iuo_parent.ib_set_tab_order then return

If UpperBound(il_CurrentY[])<4 Or UpperBound(il_PriorY[])<4 Then Return 

ll_moved =  il_CurrentY[4] - il_PriorY[4]
If  this.y=il_loc then 
	 ib_moving=false
Else	 
	if ib_moving then
		this.setposition(totop!)
		this.move(this.x,il_CurrentY[4])
	
		dw_Footer.height=dw_Footer.height + ll_moved
	
		ib_moving=false
		dw_syntax.modify("datawindow.footer.height='"+string(dw_footer.height)+"'")
	end if
End If
il_PriorY[4] = il_CurrentY[4]


return 0
end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_footer.event getfocus()
end event

type st_summary from statictext within pfc_cst_u_band_painter_report
event mousedown pbm_lbuttondown
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer y = 1956
integer width = 2464
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "SizeNS!"
long textcolor = 33554432
long backcolor = 67108864
string text = "Summary"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;if dw_summary.iuo_parent.ib_set_tab_order then return

ib_moving = TRUE
il_priory[3] = this.y
il_loc =this.y


end event

event mousemove;long   ly

if dw_summary.iuo_parent.ib_set_tab_order then return

If ib_Moving And KeyDown(KeyLeftButton!) Then
	this.setposition(totop!)
	ly = Parent.Pointery()
	//$<modify> 01.08.2008 by: Andy
	//IF ly <= dw_summary.y  OR ly > parent.height - 500 THEN
	IF ly <= dw_summary.y THEN
		return 0
	END IF
	this.y = ly
	il_CurrentY[3] = ly
End If

end event

event mouseup;long  ll_Moved
long	ll_find,ll_object_no

if dw_summary.iuo_parent.ib_set_tab_order then return

If UpperBound(il_CurrentY[])<3 Or UpperBound(il_PriorY[])<3 Then Return 

ll_moved =  il_CurrentY[3] - il_PriorY[3]
If  this.y=il_loc then 
	 ib_moving=false
Else	 
	if ib_moving then
		this.setposition(totop!)
		this.move(this.x,il_CurrentY[3])
			
		dw_Summary.height=dw_Summary.height + ll_moved
		
		dw_footer.y = st_summary.y + st_summary.height + 4
		st_footer.y = dw_footer.y + dw_footer.height + 4
			
		ib_moving=false
		dw_syntax.modify("datawindow.summary.height='"+string(dw_summary.height)+"'")
	
	end if
	
	il_PriorY[3] = il_CurrentY[3]
	il_PriorY[4] = st_Footer.y
	il_CurrentY[4] = st_Footer.y
End If	

return 0
end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_summary.event getfocus()
end event

type st_detail from statictext within pfc_cst_u_band_painter_report
event mousedown pbm_lbuttondown
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer y = 1132
integer width = 2464
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "SizeNS!"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detail"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;if dw_detail.iuo_parent.ib_set_tab_order then return

ib_moving = TRUE
il_priory[2] = this.y
il_loc= this.y

end event

event mousemove;long   ly

if dw_detail.iuo_parent.ib_set_tab_order then return

If ib_Moving And KeyDown(KeyLeftButton!) Then

	this.setposition(totop!)
	ly = Parent.Pointery()
	//$<modify> 01.08.2008 by: Andy
	//IF ly <= dw_detail.y  OR ly > parent.height - 500 THEN
	IF ly <= dw_detail.y THEN
		return 0
	END IF
	this.y = ly
	il_CurrentY[2] = ly
End If

end event

event mouseup;long  ll_Moved
long	ll_find,ll_object_no

if dw_detail.iuo_parent.ib_set_tab_order then return

If UpperBound(il_CurrentY[])<2 Or UpperBound(il_PriorY[])<2 Then Return 

ll_moved =  il_CurrentY[2] - il_PriorY[2]
If  this.y=il_loc then 
	 ib_moving=false
Else	 
	if ib_moving then
		this.setposition(totop!)
		this.move(this.x,il_CurrentY[2])
	
		dw_detail.height=dw_detail.height + ll_moved
		//Added By Alan on 2009-2-3
		if ib_group then
			dw_trailergroup.y = st_detail.y + st_detail.height + 4
			st_trailergroup.y = dw_trailergroup.y + dw_trailergroup.height + 4
			
			dw_summary.y = st_trailergroup.y + st_trailergroup.height + 4
			st_summary.y = dw_summary.y + dw_summary.height + 4
		else
			dw_summary.y = st_detail.y + st_detail.height + 4
			st_summary.y = dw_summary.y + dw_summary.height + 4
		end if
		
		dw_footer.y = st_summary.y + st_summary.height + 4
		st_footer.y = dw_footer.y + dw_footer.height + 4
	
		ib_moving=false
		dw_syntax.modify("datawindow.detail.height='"+string(dw_detail.height)+"'")

		
	end if
	
	il_PriorY[2] = il_CurrentY[2]
	il_PriorY[3] = st_summary.y
	il_CurrentY[3] = st_Header.y
	il_PriorY[4] = st_Footer.y
	il_CurrentY[4] = st_Footer.y
	il_PriorY[6] = st_trailergroup.y
	il_CurrentY[6] = st_trailergroup.y
	
End If

return 0
end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_detail.event getfocus()
end event

type dw_footer from pfc_cst_u_band_report within pfc_cst_u_band_painter_report
integer y = 2024
integer width = 2359
integer height = 264
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.is_BandType = 'FOOTER'
end event

event resize;this.modify("datawindow.footer.height="+string(this.height))
end event

event getfocus;call super::getfocus;iw_parentwin.is_curband = this.is_bandType

//dw_header.modify('datawindow.header.color='+dw_syntax.describe('datawindow.header.color'))
IF dw_Header.is_CurObj<>''  THEN
	dw_Header.of_unselectobj(dw_Header.is_CurObj)
END IF

//dw_detail.modify('datawindow.detail.color='+dw_syntax.describe('datawindow.detail.color'))
IF dw_detail.is_CurObj<>''  THEN
	dw_detail.of_unselectobj(dw_detail.is_CurObj)
END IF

//dw_summary.modify('datawindow.summary.color='+dw_syntax.describe('datawindow.summary.color'))
IF dw_Summary.is_CurObj<>''  THEN
	dw_Summary.of_unselectobj(dw_Summary.is_CurObj)
END IF
//
IF dw_headergroup.is_CurObj<>''  THEN
	dw_headergroup.of_unselectobj(dw_headergroup.is_CurObj)
END IF

IF dw_trailergroup.is_CurObj<>''  THEN
	dw_trailergroup.of_unselectobj(dw_trailergroup.is_CurObj)
END IF
end event

type dw_summary from pfc_cst_u_band_report within pfc_cst_u_band_painter_report
integer y = 1620
integer width = 2359
integer height = 264
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.is_BandType = 'SUMMARY'
end event

event resize;this.modify("datawindow.summary.height="+string(this.height))

end event

event getfocus;call super::getfocus;iw_parentwin.is_curband = this.is_bandType

//dw_header.modify('datawindow.header.color='+dw_syntax.describe('datawindow.header.color'))
IF dw_Header.is_CurObj<>''  THEN
	dw_Header.of_unselectobj(dw_Header.is_CurObj)
END IF

//dw_detail.modify('datawindow.detail.color='+dw_syntax.describe('datawindow.detail.color'))
IF dw_detail.is_CurObj<>''  THEN
	dw_detail.of_unselectobj(dw_detail.is_CurObj)
END IF
//dw_footer.Modify("DataWindow.Trailer.1.Height='0'")
//dw_Footer.modify('datawindow.Footer.color='+dw_syntax.describe('datawindow.Footer.color'))
IF dw_footer.is_CurObj<>''  THEN
	dw_Footer.of_unselectobj(dw_Footer.is_CurObj)
END IF
//
IF dw_headergroup.is_CurObj<>''  THEN
	dw_headergroup.of_unselectobj(dw_headergroup.is_CurObj)
END IF

IF dw_trailergroup.is_CurObj<>''  THEN
	dw_trailergroup.of_unselectobj(dw_trailergroup.is_CurObj)
END IF
end event

type dw_detail from pfc_cst_u_band_report within pfc_cst_u_band_painter_report
integer y = 812
integer width = 2359
integer height = 264
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.is_BandType = 'DETAIL'
end event

event resize;this.modify("datawindow.detail.height="+string(this.height))

end event

event getfocus;call super::getfocus;iw_parentwin.is_curband = this.is_bandType

//dw_Header.modify('datawindow.Header.color='+dw_syntax.describe('datawindow.Header.color'))

IF dw_Header.is_CurObj<>''  THEN
	dw_Header.of_unselectobj(dw_Header.is_CurObj)
END IF

//dw_summary.modify('datawindow.summary.color='+dw_syntax.describe('datawindow.summary.color'))
IF dw_summary.is_CurObj<>''  THEN
	dw_Summary.of_unselectobj(dw_Summary.is_CurObj)
END IF
//dw_footer.Modify("DataWindow.Trailer.1.Height='0'")
//dw_Footer.modify('datawindow.Footer.color='+dw_syntax.describe('datawindow.Footer.color'))
IF dw_footer.is_CurObj<>''  THEN
	dw_Footer.of_unselectobj(dw_Footer.is_CurObj)
END IF
//
IF dw_headergroup.is_CurObj<>''  THEN
	dw_headergroup.of_unselectobj(dw_headergroup.is_CurObj)
END IF

IF dw_trailergroup.is_CurObj<>''  THEN
	dw_trailergroup.of_unselectobj(dw_trailergroup.is_CurObj)
END IF
end event

event ue_calc_tab_position;call super::ue_calc_tab_position;IF iuo_parent.ib_set_tab_order THEN
	String ls_selected_object_name
	ls_selected_object_name = iuo_parent.is_last_tab_label_name
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 05.16.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	sle_tab.x = this.x + Long( This.Describe( ls_selected_object_name + ".x" ) ) - Long( dw_detail.Describe("datawindow.HorizontalScrollPosition"))
	sle_tab.y = this.y + Long( This.Describe( ls_selected_object_name + ".y" )) - Long( dw_detail.Describe("datawindow.VerticalScrollPosition")) +  Long( dw_detail.Describe("Datawindow.Header.Height") )
	*/
	long ll_max,ll_mun
	If appeongetclienttype() = 'PB' Then
		sle_tab.x = this.x + Long( This.Describe( ls_selected_object_name + ".x" ) ) - Long( dw_detail.Describe("datawindow.HorizontalScrollPosition"))
	Else
//		sle_tab.x = this.x + Long( This.Describe( ls_selected_object_name + ".x" ) ) - PixelsToUnits(long(dw_detail.Describe("datawindow.HorizontalScrollPosition")),XPixelsToUnits! )

		
		If Long( dw_detail.Describe("datawindow.HorizontalScrollPosition")) > 0 then
			ll_max = 36
		Else
			ll_max = 0
		End If
		If iuo_parent.ib_clicked Then
			ll_mun = Long( dw_detail.Describe("datawindow.HorizontalScrollPosition"))
			If ll_mun > 123 And ll_mun <= 188 Then
				sle_tab.x = this.x + Long( This.Describe( ls_selected_object_name + ".x" ))  - ll_mun*5 + (ll_mun - 123)
			ElseIf ll_mun > 188 Then 
				If isvalid(w_report_data_design) Then
					If iw_parentwin.windowstate = maximized! Then
						If iuo_parent.ii_screen_id = 1 Then
							ll_mun = 110
						ElseIf iuo_parent.ii_screen_id = 6 Then
							ll_mun = 110
						ElseIf iuo_parent.ii_screen_id = 7 Then
							ll_mun = 110
						ElseIf iuo_parent.ii_screen_id = 12 Then
							ll_mun = 110
						ElseIf iuo_parent.ii_screen_id = 13 Then
							ll_mun = 110
						ElseIf iuo_parent.ii_screen_id = 19 Then
							ll_mun = 249
						ElseIf iuo_parent.ii_screen_id = 23 Then
							ll_mun = 30
						ElseIf iuo_parent.ii_screen_id = 25 Then
							If ll_mun > 213 And ll_mun < 259 Then
								ll_mun = 228
							ElseIf ll_mun > 259 And ll_mun < 360 Then
								ll_mun = 366
							ElseIf ll_mun > 360 Then
								ll_mun = 388
							Else
								ll_mun = 188
							End If
						ElseIf iuo_parent.ii_screen_id = 26 Then
							ll_mun = 40
						ElseIf iuo_parent.ii_screen_id = 28 Then
							If ll_mun > 213 And ll_mun < 259 Then
								ll_mun = 228
							ElseIf ll_mun > 259 And ll_mun < 360 Then
								ll_mun = 336
							ElseIf ll_mun > 360 And ll_mun < 439 Then
								ll_mun = 438
							ElseIf ll_mun >= 439 And ll_mun < 560 Then
								ll_mun = 498
							ElseIf ll_mun > 560 And ll_mun < 1000  Then
								ll_mun = 400 + ll_mun/2
							ElseIf ll_mun > 1000 And ll_mun < 1816 Then
								ll_mun =  131 + ll_mun
							ElseIf ll_mun >= 1816 And ll_mun < 1880 Then
								ll_mun = ll_mun
							ElseIf ll_mun >= 1880 Then
								ll_mun = 2021
							Else
								ll_mun = 188
							End If
						ElseIf iuo_parent.ii_screen_id = 31 Then
							ll_mun = 110
						ElseIf iuo_parent.ii_screen_id = 32 Then
							ll_mun = 90
						ElseIf iuo_parent.ii_screen_id = 33 Then
							ll_mun = 100
						ElseIf iuo_parent.ii_screen_id = 45 Then
							ll_mun = 70
						ElseIf iuo_parent.ii_screen_id = 47 Then
							ll_mun = 30
						ElseIf iuo_parent.ii_screen_id = 48 Then  
							ll_mun = -24
						End If
					Else	
						If iuo_parent.ii_screen_id = 1 Then		 //Search->Search Criteria  Ok
							ll_mun = 198
						ElseIf iuo_parent.ii_screen_id = 6 Then	 //Details->Contracted Company Contact  ok
							ll_mun = 0
						ElseIf iuo_parent.ii_screen_id = 7 Then	 //Details->Our Company Contact  ok
							ll_mun = 0
						ElseIf iuo_parent.ii_screen_id = 12 Then  //Requirements->Profile Detail  ?
							ll_mun = 110
						ElseIf iuo_parent.ii_screen_id = 13 Then  //Requirements->Profile Detail
							ll_mun = 110
						ElseIf iuo_parent.ii_screen_id = 19 Then	 //Locations->Facilities   OK
							ll_mun = 340
						ElseIf iuo_parent.ii_screen_id = 23 Then	 //Organizations->Address   Ok
							ll_mun = 110
						ElseIf iuo_parent.ii_screen_id = 25 Then	 //Organizations->Organization Contacts  ?
							If ll_mun > 213 And ll_mun < 259 Then
								ll_mun = 228
							ElseIf ll_mun > 259 And ll_mun < 360 Then
								ll_mun = 306
							ElseIf ll_mun > 360 Then
								ll_mun = 468
							Else
								ll_mun = 188
							End If
						ElseIf iuo_parent.ii_screen_id = 26 Then	 //Fee Schedules->Browse Tab->Fee Schedules  Ok
							ll_mun = 130
						ElseIf iuo_parent.ii_screen_id = 28 Then	 //Fee Schedules->Browse Tab->Fees  ?
							If ll_mun > 213 And ll_mun < 259 Then
								ll_mun = 228
							ElseIf ll_mun > 259 And ll_mun < 360 Then
								ll_mun = 336
							ElseIf ll_mun > 360 And ll_mun < 439 Then
								ll_mun = 438
							ElseIf ll_mun >= 439 And ll_mun < 560 Then
								ll_mun = 498
							ElseIf ll_mun > 560 And ll_mun < 1000  Then
								ll_mun = 400 + ll_mun/2
							ElseIf ll_mun > 1000 And ll_mun < 1816 Then
								ll_mun = 201 + ll_mun
							ElseIf ll_mun >= 1816 And ll_mun < 1880 Then
								ll_mun = ll_mun
							ElseIf ll_mun >= 1880 Then
								ll_mun = 2126
							Else
								ll_mun = 188
							End If
						ElseIf iuo_parent.ii_screen_id = 31 Then  //Fee Schedule (NM)->Fee Schedule (Non Healthcare)
					   	ll_mun = 190
						ElseIf iuo_parent.ii_screen_id = 32 Then  //Document Manager->Document Tab->Search Criteria
						   ll_mun = 182
						ElseIf iuo_parent.ii_screen_id = 33 Then  //Action Items->Action Item List
					   	ll_mun = 188
						ElseIf iuo_parent.ii_screen_id = 45 Then  //Document Manager->Work Flow Tab->Search Criteria
					   	ll_mun = 164
						ElseIf iuo_parent.ii_screen_id = 47 Then  //Document Manager->Work Flow Tab->Action Item Detail
					   	ll_mun = 120
						ElseIf iuo_parent.ii_screen_id = 48 Then  //Document Manager->Audit Trail Tab->Search Criteria
							ll_mun = 70
						End If
					End If
				End If
				sle_tab.x = this.x + Long( This.Describe( ls_selected_object_name + ".x" ))  - ll_mun*5 + (ll_mun - 133)
			Else	
				sle_tab.x = this.x + Long( This.Describe( ls_selected_object_name + ".x" ))  - ll_mun*5
			End If
			
		Else
			sle_tab.x = this.x + Long( This.Describe( ls_selected_object_name + ".x" )) + ll_max - Long( dw_detail.Describe("datawindow.HorizontalScrollPosition"))*5 
		End If
	End If
	
	//$<modify> 01.07.2008 by: Andy
	//Reason:Should consider the height of group header. bug:BugJ122701
	If iuo_parent.ii_screen_id = 12 And appeongetclienttype() = 'WEB' Then
		//sle_tab.y = this.y + Long( This.Describe( ls_selected_object_name + ".y" )) - Long( dw_detail.Describe("datawindow.VerticalScrollPosition")) +  Long( dw_detail.Describe("Datawindow.Header.Height")) + 100
		sle_tab.y = this.y + Long( This.Describe( ls_selected_object_name + ".y" )) + 100
	ElseIf iuo_parent.ii_screen_id = 13 And appeongetclienttype() = 'WEB' Then
		//sle_tab.y = this.y + Long( This.Describe( ls_selected_object_name + ".y" )) - Long( dw_detail.Describe("datawindow.VerticalScrollPosition")) +  Long( dw_detail.Describe("Datawindow.Header.Height")) + 80
		sle_tab.y = this.y + Long( This.Describe( ls_selected_object_name + ".y" )) + 80
	Else
		//sle_tab.y = this.y + Long( This.Describe( ls_selected_object_name + ".y" )) - Long( dw_detail.Describe("datawindow.VerticalScrollPosition")) +  Long( dw_detail.Describe("Datawindow.Header.Height"))
		if Long( dw_detail.Describe("Datawindow.Header.1.Height")) > 0 then
			sle_tab.y = this.y + Long( This.Describe( ls_selected_object_name + ".y" )) + Long( dw_detail.Describe("Datawindow.Header.1.Height"))
		else
			sle_tab.y = this.y + Long( This.Describe( ls_selected_object_name + ".y" ))
		end if
	End If		
	//end of modify 01.07.2008
	
	//---------------------------- APPEON END ----------------------------
	
	IF sle_tab.x >= this.x AND sle_tab.x <= this.x + This.width AND sle_tab.y >= this.y AND sle_tab.y <= this.y + This.height THEN 
		IF sle_tab.text <> "" THEN
			sle_tab.Visible = TRUE
		
			sle_tab.SetFocus()
			sle_tab.BringToTop = True
			
			sle_tab.SelectText(1,100)			
		END IF
	ELSE		
		sle_tab.Visible = FALSE
	END IF
END IF

end event

event scrollhorizontal;call super::scrollhorizontal;//iuo_parent.ib_clicked = False   	
//This.Event ue_calc_tab_position()
end event

event scrollvertical;call super::scrollvertical;//This.Event ue_calc_tab_position()
end event

type dw_header from pfc_cst_u_band_report within pfc_cst_u_band_painter_report
integer y = 4
integer width = 2359
integer height = 264
integer taborder = 20
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.is_BandType = 'HEADER'

end event

event resize;this.modify("datawindow.header.height="+string(this.height))
end event

event getfocus;call super::getfocus;iw_parentwin.is_curband = this.is_bandType

//dw_detail.modify('datawindow.detail.color='+dw_syntax.describe('datawindow.detail.color'))

IF dw_detail.is_CurObj<>''  THEN
	dw_detail.of_unselectobj(dw_detail.is_CurObj)
END IF

//dw_summary.modify('datawindow.summary.color='+dw_syntax.describe('datawindow.summary.color'))
IF dw_summary.is_CurObj<>''  THEN
	dw_Summary.of_unselectobj(dw_Summary.is_CurObj)
END IF
//dw_footer.Modify("DataWindow.Trailer.1.Height='0'")
//dw_footer.modify('datawindow.footer.color='+dw_syntax.describe('datawindow.footer.color'))
IF dw_footer.is_CurObj<>''  THEN
	dw_Footer.of_unselectobj(dw_Footer.is_CurObj)
END IF
//
IF dw_headergroup.is_CurObj<>''  THEN
	dw_headergroup.of_unselectobj(dw_headergroup.is_CurObj)
END IF

IF dw_trailergroup.is_CurObj<>''  THEN
	dw_trailergroup.of_unselectobj(dw_trailergroup.is_CurObj)
END IF
end event

type st_header from statictext within pfc_cst_u_band_painter_report
event mousedown pbm_lbuttondown
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer y = 308
integer width = 2464
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "SizeNS!"
long textcolor = 33554432
long backcolor = 67108864
string text = "Header"
boolean border = true
boolean focusrectangle = false
end type

event mousedown;if dw_header.iuo_parent.ib_set_tab_order then return

ib_moving = TRUE
il_priory[1] = this.y
il_loc= this.y

end event

event mousemove;long   ly

if dw_header.iuo_parent.ib_set_tab_order then return

If ib_Moving And KeyDown(KeyLeftButton!) Then
	this.setposition(totop!)
	ly = Parent.Pointery()
	//$<modify> 01.08.2008 by: Andy
	//IF ly < dw_header.y  OR ly > parent.height - 500 THEN
	IF ly < dw_header.y THEN
		return 0
	END IF
	this.y = ly
	il_CurrentY[1] = ly
End If

end event

event mouseup;long  ll_Moved
long	ll_find,ll_object_no

if dw_header.iuo_parent.ib_set_tab_order then return

If UpperBound(il_CurrentY[])<1 Or UpperBound(il_PriorY[])<1 Then Return 

ll_moved =  il_CurrentY[1] - il_PriorY[1]
If this.y<>il_loc Then
	if ib_moving then
		this.setposition(totop!)
	
		this.move(this.x,il_CurrentY[1])
	
		dw_header.height=dw_header.height + ll_moved
		//Added By Alan on 2009-2-3
		if ib_group then
			dw_headergroup.y = this.y + this.height + 4
			st_headergroup.y = dw_headergroup.y + dw_headergroup.height + 4
			
			dw_detail.y = st_headergroup.y + st_headergroup.height + 4
			st_detail.y = dw_detail.y + dw_detail.height + 4
			//
			dw_trailergroup.y = st_detail.y + st_detail.height + 4
			st_trailergroup.y = dw_trailergroup.y + dw_trailergroup.height + 4
		
			dw_summary.y = st_trailergroup.y + st_trailergroup.height + 4
			st_summary.y = dw_summary.y + dw_summary.height + 4
		else
			dw_detail.y = this.y + this.height + 4
			st_detail.y = dw_detail.y + dw_detail.height + 4
		
			dw_summary.y = st_detail.y + st_detail.height + 4
			st_summary.y = dw_summary.y + dw_summary.height + 4
		end if
		
		dw_footer.y = st_summary.y + st_summary.height + 4
		st_footer.y = dw_footer.y + dw_footer.height + 4
	
		ib_moving=false
		dw_syntax.modify("datawindow.header.height='"+string(dw_header.height)+"'")
		
	end if
	
	il_PriorY[1] = il_CurrentY[1]
	il_PriorY[2] = st_detail.y
	il_CurrentY[2] = st_detail.y
	il_PriorY[3] = st_summary.y
	il_CurrentY[3] = st_summary.y
	il_PriorY[4] = st_Footer.y
	il_CurrentY[4] = st_Footer.y
	il_PriorY[5] = st_headergroup.y
	il_CurrentY[5] = st_headergroup.y
	il_PriorY[6] = st_trailergroup.y
	il_CurrentY[6] = st_trailergroup.y
else 
	ib_moving=false
End If 
return 0
end event

event clicked;ib_Moving = FALSE
end event

event getfocus;dw_header.event getfocus()
end event

type dw_ruler from datawindow within pfc_cst_u_band_painter_report
integer y = 4
integer width = 2537
integer height = 2176
integer taborder = 10
string title = "none"
string dataobject = "d_screen_design"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

