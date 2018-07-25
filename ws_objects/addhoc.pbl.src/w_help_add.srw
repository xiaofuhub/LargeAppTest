$PBExportHeader$w_help_add.srw
forward
global type w_help_add from window
end type
type st_cnt from statictext within w_help_add
end type
type cb_4 from commandbutton within w_help_add
end type
type dw_cats from datawindow within w_help_add
end type
type cb_sort from commandbutton within w_help_add
end type
type cb_filt from commandbutton within w_help_add
end type
type cb_3 from commandbutton within w_help_add
end type
type cb_2 from commandbutton within w_help_add
end type
type dw_add from datawindow within w_help_add
end type
type dw_search from datawindow within w_help_add
end type
type cb_go from commandbutton within w_help_add
end type
type sle_search from singlelineedit within w_help_add
end type
type rb_exact from radiobutton within w_help_add
end type
type rb_all from radiobutton within w_help_add
end type
type rb_any from radiobutton within w_help_add
end type
type cb_1 from commandbutton within w_help_add
end type
type gb_keyword from groupbox within w_help_add
end type
type cb_5 from commandbutton within w_help_add
end type
type dw_exp from datawindow within w_help_add
end type
end forward

global type w_help_add from window
integer x = 27
integer y = 16
integer width = 3511
integer height = 2332
boolean titlebar = true
string title = "Help"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 80269524
st_cnt st_cnt
cb_4 cb_4
dw_cats dw_cats
cb_sort cb_sort
cb_filt cb_filt
cb_3 cb_3
cb_2 cb_2
dw_add dw_add
dw_search dw_search
cb_go cb_go
sle_search sle_search
rb_exact rb_exact
rb_all rb_all
rb_any rb_any
cb_1 cb_1
gb_keyword gb_keyword
cb_5 cb_5
dw_exp dw_exp
end type
global w_help_add w_help_add

type variables
long il_openfor
end variables

on w_help_add.create
this.st_cnt=create st_cnt
this.cb_4=create cb_4
this.dw_cats=create dw_cats
this.cb_sort=create cb_sort
this.cb_filt=create cb_filt
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_add=create dw_add
this.dw_search=create dw_search
this.cb_go=create cb_go
this.sle_search=create sle_search
this.rb_exact=create rb_exact
this.rb_all=create rb_all
this.rb_any=create rb_any
this.cb_1=create cb_1
this.gb_keyword=create gb_keyword
this.cb_5=create cb_5
this.dw_exp=create dw_exp
this.Control[]={this.st_cnt,&
this.cb_4,&
this.dw_cats,&
this.cb_sort,&
this.cb_filt,&
this.cb_3,&
this.cb_2,&
this.dw_add,&
this.dw_search,&
this.cb_go,&
this.sle_search,&
this.rb_exact,&
this.rb_all,&
this.rb_any,&
this.cb_1,&
this.gb_keyword,&
this.cb_5,&
this.dw_exp}
end on

on w_help_add.destroy
destroy(this.st_cnt)
destroy(this.cb_4)
destroy(this.dw_cats)
destroy(this.cb_sort)
destroy(this.cb_filt)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_add)
destroy(this.dw_search)
destroy(this.cb_go)
destroy(this.sle_search)
destroy(this.rb_exact)
destroy(this.rb_all)
destroy(this.rb_any)
destroy(this.cb_1)
destroy(this.gb_keyword)
destroy(this.cb_5)
destroy(this.dw_exp)
end on

event open;long ll_mess
string ls_sql
string ls_sql_org
string ls_where
long rows

if message.stringparm = "P" then  //from the intellicred program
	//skip login
	il_openfor = 0
else
	
	SQLCA.DBMS="ODBC"
	SQLCA.DbParm="ConnectString='DSN=Iapp;UID=DBA;PWD=SQL;',DelimitIdentifier='Yes'"
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2007-09-14 By: Scofield
	//$<Reason> Set the connection cache dynamically on Web
	if AppeonGetClientType() = 'WEB' then
		SQLCA.DBMS = gs_CacheType
		SQLCA.DBParm = gs_CacheSet
	end if
	//---------------------------- APPEON END ----------------------------

	CONNECT USING SQLCA;
	
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("Not Logged In", "Login Failed!")
	ELSE
		//MESSAGEBOX("","LOGIN OK")
	END IF
	il_openfor = 1
	
end if

	dw_cats.settransobject(sqlca)
	rows = dw_cats.Retrieve()	
	st_cnt.text = string(rows)
	
	open(w_user_name)
end event

event close;
if il_openfor = 1 then
	disCONNECT USING SQLCA;
end if
end event

type st_cnt from statictext within w_help_add
integer x = 777
integer y = 1228
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_help_add
integer x = 3205
integer y = 8
integer width = 247
integer height = 56
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "About"
end type

event clicked;messagebox("About","This program uses an ODBC connection called Iapp which should be connected to the IntelliApp database on the server.")
end event

type dw_cats from datawindow within w_help_add
integer x = 27
integer y = 196
integer width = 686
integer height = 1144
integer taborder = 90
string dataobject = "d_help_category_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string ls_search
//string ls_words[]
//integer i
long r
//integer w = 0
string ls_sql
string ls_keyword = ""
string ls_where
//integer p1
//integer p2
//integer p3
string ls_sql_org
string iword
integer rows
//integer wc
//long bugid

if this.rowcount() < 1 then return

r = this.getclickedrow()

this.setrow(r)

dw_search.SetTransObject( SQLCA )
ls_sql = dw_search.Object.DataWindow.Table.Select
//messagebox("",ls_sql)
ls_sql_org = ls_sql

ls_search = this.getitemstring(this.getrow(),"subcategory")

if LenA(ls_search) < 1 then //no value
	ls_keyword = "" 
	//messagebox("ls_keyword","Nothing")
else //all and any
	ls_keyword =	" Where subcategory like '%" + ls_search + "%'"	
end if

ls_where =  ls_keyword 

ls_sql = ls_sql + ls_where + ";"
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.24.2006 By: LiuHongXin
//$<reason> Replaced setsqlselect function with modify function.
/*
dw_search.SetSQLSelect ( ls_sql )
dw_search.SetTransObject( SQLCA )
rows = dw_search.Retrieve()
dw_search.SetSQLSelect ( ls_sql_org )
*/
dw_search.modify('datawindow.table.select = "' + ls_sql +'"')
dw_search.SetTransObject( SQLCA )
rows = dw_search.Retrieve()
dw_search.modify('datawindow.table.select = "' + ls_sql_org +'"')
//---------------------------- APPEON END ----------------------------
dw_search.settransobject(sqlca)
dw_add.reset()
end event

type cb_sort from commandbutton within w_help_add
integer x = 1376
integer y = 1208
integer width = 247
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Filter"
end type

event clicked;string null_str

SetNull(null_str)

dw_search.Setfilter(null_str)

dw_search.filter( )
end event

type cb_filt from commandbutton within w_help_add
integer x = 1696
integer y = 1208
integer width = 247
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_search.SetSort(null_str)

dw_search.Sort( )
end event

type cb_3 from commandbutton within w_help_add
integer x = 3200
integer y = 1280
integer width = 247
integer height = 76
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Save"
end type

event clicked;long helpid

if dw_add.rowcount() < 1 then return

if isnull(dw_add.getitemnumber(1,"help_id")) then
	select max(help_id) into :helpid from sys_help;
	if isnull(helpid) then helpid = 0
	helpid++
	dw_add.setitem(1,"help_id",helpid)
end if

//if dw_add.GetItemStatus ( 1, 0, primary! ) = DataModified!  then
	dw_add.setitem(1,"mod_date",today())
//end if

dw_add.update()
commit using sqlca;

dw_cats.retrieve()
end event

type cb_2 from commandbutton within w_help_add
integer x = 2912
integer y = 1280
integer width = 247
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Add"
end type

event clicked;
dw_add.settransobject(sqlca)
dw_add.insertrow(1)
dw_add.setitem(1,"create_date",today())
dw_add.setitem(1,"mod_date",today())
dw_add.setitem(1,"user_id",gs_user_id)

end event

type dw_add from datawindow within w_help_add
integer x = 41
integer y = 1372
integer width = 3429
integer height = 844
integer taborder = 80
string dataobject = "d_help_de"
boolean livescroll = true
end type

type dw_search from datawindow within w_help_add
integer x = 736
integer y = 192
integer width = 2747
integer height = 996
integer taborder = 20
string dataobject = "d_help_browse_alt"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event clicked;long 	ll_Row,ll_hid

if This.RowCount() < 1 then Return

ll_Row = this.GetClickedRow()
if Not(ll_Row > 0 and ll_Row <= This.RowCount()) then Return

This.SetRow(ll_Row)
ll_hid = This.GetItemNumber(ll_Row,"help_id")
dw_Add.SetTransObject(SQLCA)
dw_Add.Retrieve(ll_hid)

end event

type cb_go from commandbutton within w_help_add
integer x = 2825
integer y = 68
integer width = 283
integer height = 88
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "< GO >"
end type

event clicked;string ls_search
string ls_words[]
integer i
integer r
integer w = 0
string ls_sql
string ls_keyword = ""
string ls_where
integer p1
integer p2
integer p3
string ls_sql_org
string iword
integer rows
integer wc
long bugid

dw_search.SetTransObject( SQLCA )
ls_sql = dw_search.Object.DataWindow.Table.Select

//messagebox("",ls_sql)
ls_sql_org = ls_sql

// ************ bug id search************
//if len(sle_bugid.text) > 0 then
//	if isnumber(sle_bugid.text) then//bad entry check
//		bugid = long(sle_bugid.text)
//		ls_where = " Where help_id = " + string(bugid)
//		goto runit //skip over all other search parameters
//	end if
//end if
//************ WORD SEARCH **********************************

ls_search = sle_search.text

if LenA(ls_search) < 1 then //no value
	ls_keyword = "" 
	//messagebox("ls_keyword","Nothing")

elseif rb_exact.checked = true then //exact
	ls_keyword =	" Where help_file like '%" + ls_search + "%'"	
	
else //all and any
	if PosA(ls_search, " " ,1) < 1 then //if only 1 word treat like exact
		ls_keyword =	" Where help_file like '%" + ls_search + "%'"	
		
	else
		p1 = PosA(ls_search, " "  )
		if isnull(p1) then //error
			ls_keyword = ""
			//messagebox("ls_keyword null",ls_keyword)
	//	elseif p1 = 0 then //one word
	//		ls_words[1] = mid(ls_search,1,len(ls_search))
	//		messagebox("only one word",ls_words[1])
		else
			ls_keyword = " Where"
			if rb_any.checked = true then ls_keyword = ls_keyword + " ("
			w = 1
			ls_words[w] = MidA(ls_search,1,p1 - 1)
			do while p1 >0 //for each word put into array
				p2 = p1
				p1 = PosA(ls_search, " " ,p2 + 1)
				w++
				if p1 = 0 then
					ls_words[w] = MidA(ls_search,p2 + 1,LenA(ls_search))
				else
					ls_words[w] = MidA(ls_search,p2 + 1,p1 - p2 - 1)
				end if
			loop
		end if
		
		wc = upperbound(ls_words)
		for i = 1 to wc
			iword = ls_words[i]
			//messagebox("ls_words[i]",iword)
			
			ls_keyword = ls_keyword + " help_file like '%" + ls_words[i] + "%'"
			if rb_all.checked = true then //all
				ls_keyword = ls_keyword + " and"
			elseif rb_any.checked = true then //any
				ls_keyword = ls_keyword + " or "
			end if
		next
		ls_keyword = MidA(ls_keyword,1,LenA(ls_keyword) - 4)
		if rb_any.checked = true then ls_keyword = ls_keyword + " )"
	end if

	
end if 

ls_where =  ls_keyword 
	//messagebox("ls_where",ls_where)


//messagebox("li_stat_search",li_stat_search)
//messagebox("li_type_search",li_type_search)

//************** TYPE and STATUS ********************
//if li_stat_search > 0  and li_stat_search <> 5 then
//	if ls_where = "" then
//		ls_where = " Where "
//	else 
//		ls_where = ls_where + " and "
//	end if
//	ls_where = ls_where + " status = " + string(li_stat_search)
//end if
//
//if li_type_search > 0 and li_type_search <> 5 then
//	if ls_where = "" then
//		ls_where = " Where "
//	else 
//		ls_where = ls_where + " and "
//	end if
//	ls_where = ls_where + " type = " + string(li_type_search)
//end if

//runit:

ls_sql = ls_sql + ls_where + ";"

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.30.2006 By: Liang QingShi
//$<reason> 
/*
dw_search.SetSQLSelect ( ls_sql )
*/
dw_search.modify("DataWindow.Table.Select = " + '"' + ls_sql + '"')
//---------------------------- APPEON END ----------------------------

dw_search.SetTransObject( SQLCA )

rows = dw_search.Retrieve()

if rows < 1 then
//		messagebox("No records found","There are no records that meet the specified search criteria")
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.30.2006 By: Liang QingShi
//$<reason> 
/*
dw_search.SetSQLSelect ( ls_sql_org )
*/
dw_search.modify("DataWindow.Table.Select = " + '"' + ls_sql_org + '"')
//---------------------------- APPEON END ----------------------------
dw_search.settransobject(sqlca)

dw_add.reset()


end event

type sle_search from singlelineedit within w_help_add
integer x = 1440
integer y = 68
integer width = 1344
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type rb_exact from radiobutton within w_help_add
integer x = 923
integer y = 76
integer width = 434
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Exact phrase"
boolean checked = true
end type

type rb_all from radiobutton within w_help_add
integer x = 539
integer y = 76
integer width = 325
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "All words"
end type

type rb_any from radiobutton within w_help_add
integer x = 133
integer y = 64
integer width = 361
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Any words"
end type

type cb_1 from commandbutton within w_help_add
integer x = 3205
integer y = 68
integer width = 247
integer height = 88
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
end type

event clicked;close(parent)
end event

type gb_keyword from groupbox within w_help_add
integer x = 69
integer y = 4
integer width = 1353
integer height = 176
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
string text = "Keyword Search"
end type

type cb_5 from commandbutton within w_help_add
integer x = 1984
integer y = 1208
integer width = 439
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Export All files"
end type

event clicked;integer i, ic

dw_exp.settransobject(sqlca)
ic = dw_exp.retrieve()

if ic < 1 then return

gnv_dw.of_SaveAs(dw_exp,"",text!,false)//.saveas("",text!,false) Modify by Evan 05.11.2010
end event

type dw_exp from datawindow within w_help_add
integer x = 2030
integer y = 1224
integer width = 338
integer height = 48
integer taborder = 60
string dataobject = "d_help_impt"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

