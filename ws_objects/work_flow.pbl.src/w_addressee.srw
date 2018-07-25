$PBExportHeader$w_addressee.srw
forward
global type w_addressee from window
end type
type dw_find from datawindow within w_addressee
end type
type cb_cancel from commandbutton within w_addressee
end type
type cb_ok from commandbutton within w_addressee
end type
type st_2 from statictext within w_addressee
end type
type sle_mail from singlelineedit within w_addressee
end type
type cb_add from commandbutton within w_addressee
end type
type dw_mail from datawindow within w_addressee
end type
type st_1 from statictext within w_addressee
end type
type ln_1 from line within w_addressee
end type
type ln_2 from line within w_addressee
end type
type ln_3 from line within w_addressee
end type
type ln_4 from line within w_addressee
end type
end forward

global type w_addressee from window
integer width = 1751
integer height = 1796
boolean titlebar = true
string title = "Select Names"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "Application5!"
boolean center = true
dw_find dw_find
cb_cancel cb_cancel
cb_ok cb_ok
st_2 st_2
sle_mail sle_mail
cb_add cb_add
dw_mail dw_mail
st_1 st_1
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
end type
global w_addressee w_addressee

forward prototypes
public subroutine wf_addmail (long ai_row)
end prototypes

public subroutine wf_addmail (long ai_row);String	ls_UserID,ls_Text

ls_UserID = dw_Mail.GetItemString(ai_Row,'user_id')

if IsNull(ls_UserID) or Trim(ls_UserID) = '' then return

ls_Text = Trim(sle_Mail.Text)

if ls_Text <> '' then
	ls_Text += ";" + ls_UserID
else
	ls_Text = ls_UserID
end if

sle_Mail.Text = ls_Text
sle_Mail.SelectText(LenA(ls_Text),0)

end subroutine

on w_addressee.create
this.dw_find=create dw_find
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_2=create st_2
this.sle_mail=create sle_mail
this.cb_add=create cb_add
this.dw_mail=create dw_mail
this.st_1=create st_1
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
this.Control[]={this.dw_find,&
this.cb_cancel,&
this.cb_ok,&
this.st_2,&
this.sle_mail,&
this.cb_add,&
this.dw_mail,&
this.st_1,&
this.ln_1,&
this.ln_2,&
this.ln_3,&
this.ln_4}
end on

on w_addressee.destroy
destroy(this.dw_find)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_2)
destroy(this.sle_mail)
destroy(this.cb_add)
destroy(this.dw_mail)
destroy(this.st_1)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
end on

event open;String	ls_StrParm,ls_Type,ls_Mail,ls_Syntax

ls_StrParm = Message.Stringparm

if Not IsNull(ls_StrParm) then
	ls_Type = MidA(ls_StrParm,2,PosA(ls_StrParm,")")-2)
	cb_add.Text += ls_Type
	
	ls_Mail = MidA(ls_StrParm,PosA(ls_StrParm,")")+1)
	sle_mail.Text = ls_Mail
end if

dw_Mail.SetTransObject(SQLCA)
dw_Mail.Retrieve()

ls_Syntax = 'release 9;~r~ndatawindow(units=0 timer_interval=0 color=1073741824 processing=1 HTMLDW=no print.printername="" print.documentname="" print.orientation = 0 print.margin.left = 110 print.margin.right = 110 print.margin.top = 96 print.margin.bottom = 96 print.paper.source = 0 print.paper.size = 0 print.canusedefaultprinter=yes print.prompt=no print.buttons=no print.preview.buttons=no print.cliptext=no print.overrideprintjob=no print.collate=yes hidegrayline=no grid.lines=0 selected.mouse=no )~r~nsummary(height=0 color="536870912" )~r~nfooter(height=0 color="536870912" )~r~ndetail(height=68 color="536870912" )~r~ntable(column=(type=char(50) updatewhereclause=yes name=findvalue dbname="findvalue" )~r~n )~r~ncolumn(band=detail id=1 alignment="0" tabsequence=10 border="0" color="33554432" x="9" y="4" height="60" width="997" format="[general]" html.valueishtml="0"  name=findvalue visible="1" edit.limit=0 edit.case=any edit.focusrectangle=no edit.autoselect=yes edit.autohscroll=yes edit.imemode=0  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )~r~nhtmltable(border="1" )~r~nhtmlgen(clientevents="1" clientvalidation="1" clientcomputedfields="1" clientformatting="0" clientscriptable="0" generatejavascript="1" encodeselflinkargs="1" netscapelayers="0" )~r~nexport.xml(headgroups="1" includewhitespace="0" metadatatype=0 savemetadata=0 )~r~nimport.xml()~r~nexport.pdf(method=0 distill.custompostscript="0" xslfop.print="0" )~r~n '
dw_find.Create(ls_Syntax)

dw_find.InsertRow(0)
dw_find.Post SetFocus()

end event

type dw_find from datawindow within w_addressee
event ue_enter pbm_dwnprocessenter
event ue_key pbm_dwnkey
integer x = 745
integer y = 60
integer width = 928
integer height = 84
integer taborder = 10
borderstyle borderstyle = stylelowered!
end type

event ue_enter;This.SelectText(1,LenA(This.GetText()))
This.Post SetFocus()

end event

event ue_key;if key <> keyenter! then
	cb_add.Default = true
	cb_ok.Default = false
end if

end event

event editchanged;String	ls_FindText,ls_Condition
long		ll_Row

ls_FindText = Trim(data)
ls_Condition = "LOWER(user_id) like '" + lower(ls_FindText) + "%'"

ll_Row = dw_mail.Find(ls_Condition,1,dw_mail.RowCount())

if ll_Row > 0 then
	dw_mail.ScrollToRow(ll_Row)
	dw_mail.SetRow(ll_Row)
end if

end event

type cb_cancel from commandbutton within w_addressee
integer x = 965
integer y = 1564
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

event clicked;CloseWithReturn(Parent,'Cancel')
end event

type cb_ok from commandbutton within w_addressee
integer x = 425
integer y = 1564
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;String	ls_Mail

ls_Mail = Trim(sle_mail.Text)

CloseWithReturn(Parent,ls_Mail)

end event

type st_2 from statictext within w_addressee
integer x = 59
integer y = 1248
integer width = 471
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Message Recipients"
boolean focusrectangle = false
end type

type sle_mail from singlelineedit within w_addressee
integer x = 370
integer y = 1344
integer width = 1298
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_add from commandbutton within w_addressee
integer x = 59
integer y = 1340
integer width = 297
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add -->"
end type

event clicked;long	ll_Row

ll_Row = dw_mail.GetRow()

if ll_Row < 1 or ll_Row > dw_mail.RowCount() then return

wf_addmail(ll_Row)
cb_add.Default = false
cb_ok.Default = true

end event

type dw_mail from datawindow within w_addressee
integer x = 59
integer y = 196
integer width = 1609
integer height = 1012
integer taborder = 20
string title = "none"
string dataobject = "d_addressee"
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;This.SelectRow(0,false)
This.SelectRow(CurrentRow,True)
cb_add.Default = true
cb_ok.Default = false

end event

event doubleclicked;cb_add.Event Clicked()
end event

type st_1 from statictext within w_addressee
integer x = 59
integer y = 72
integer width = 690
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Type Name or Select from list:"
boolean focusrectangle = false
end type

type ln_1 from line within w_addressee
long linecolor = 16777215
integer linethickness = 4
integer beginx = 521
integer beginy = 1272
integer endx = 1669
integer endy = 1272
end type

type ln_2 from line within w_addressee
long linecolor = 8421504
integer linethickness = 4
integer beginx = 521
integer beginy = 1268
integer endx = 1669
integer endy = 1268
end type

type ln_3 from line within w_addressee
long linecolor = 16777215
integer linethickness = 4
integer beginx = 59
integer beginy = 1504
integer endx = 1673
integer endy = 1504
end type

type ln_4 from line within w_addressee
long linecolor = 8421504
integer linethickness = 4
integer beginx = 59
integer beginy = 1500
integer endx = 1673
integer endy = 1500
end type

