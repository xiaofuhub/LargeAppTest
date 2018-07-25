$PBExportHeader$w_help_window.srw
forward
global type w_help_window from window
end type
type cb_3 from commandbutton within w_help_window
end type
type cb_print from commandbutton within w_help_window
end type
type st_1 from statictext within w_help_window
end type
type dw_cats from datawindow within w_help_window
end type
type cb_2 from commandbutton within w_help_window
end type
type cb_1 from commandbutton within w_help_window
end type
type dw_search from datawindow within w_help_window
end type
type cb_go from commandbutton within w_help_window
end type
type sle_search from singlelineedit within w_help_window
end type
type rb_exact from radiobutton within w_help_window
end type
type rb_all from radiobutton within w_help_window
end type
type rb_any from radiobutton within w_help_window
end type
type cb_quit from commandbutton within w_help_window
end type
type gb_keyword from groupbox within w_help_window
end type
end forward

global type w_help_window from window
integer x = 5
integer y = 96
integer width = 3666
integer height = 2232
boolean titlebar = true
string title = "Help"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
cb_3 cb_3
cb_print cb_print
st_1 st_1
dw_cats dw_cats
cb_2 cb_2
cb_1 cb_1
dw_search dw_search
cb_go cb_go
sle_search sle_search
rb_exact rb_exact
rb_all rb_all
rb_any rb_any
cb_quit cb_quit
gb_keyword gb_keyword
end type
global w_help_window w_help_window

type variables
long il_helpid
end variables

on w_help_window.create
this.cb_3=create cb_3
this.cb_print=create cb_print
this.st_1=create st_1
this.dw_cats=create dw_cats
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_search=create dw_search
this.cb_go=create cb_go
this.sle_search=create sle_search
this.rb_exact=create rb_exact
this.rb_all=create rb_all
this.rb_any=create rb_any
this.cb_quit=create cb_quit
this.gb_keyword=create gb_keyword
this.Control[]={this.cb_3,&
this.cb_print,&
this.st_1,&
this.dw_cats,&
this.cb_2,&
this.cb_1,&
this.dw_search,&
this.cb_go,&
this.sle_search,&
this.rb_exact,&
this.rb_all,&
this.rb_any,&
this.cb_quit,&
this.gb_keyword}
end on

on w_help_window.destroy
destroy(this.cb_3)
destroy(this.cb_print)
destroy(this.st_1)
destroy(this.dw_cats)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_search)
destroy(this.cb_go)
destroy(this.sle_search)
destroy(this.rb_exact)
destroy(this.rb_all)
destroy(this.rb_any)
destroy(this.cb_quit)
destroy(this.gb_keyword)
end on

event open;long ll_mess
string ls_sql
string ls_sql_org
string ls_where
long rows
long i

dw_cats.settransobject(sqlca)
i = dw_cats.Retrieve()
if i = 0 then
	messagebox("Help Files","You have no helps files in your system.~rGo to System->Utilities and run Import Help Files.")
	close(this)
end if

ll_mess = message.doubleparm
//messagebox("",ll_mess)
if ll_mess > 0 then 
	il_helpid = ll_mess


	dw_search.SetTransObject( SQLCA )
	ls_sql = dw_search.Object.DataWindow.Table.Select
	//messagebox("",ls_sql)
	ls_sql_org = ls_sql
	
	ls_where = " Where help_id = " + string(ll_mess)


	ls_sql = ls_sql + ls_where + ";"
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2005-11-17 By: Cao YongWang
	//$<reason> Replaced setsqlselect function with modify function
	//dw_search.SetSQLSelect ( ls_sql )
	dw_search.modify('datawindow.table.select = "' + ls_sql + '"')
	//---------------------------- APPEON END ----------------------------
	//messagebox( "w_sql_msg", ls_sql )
	dw_search.SetTransObject( SQLCA )
	
	rows = dw_search.Retrieve()
	
//	if rows < 1 then
//		messagebox("No records found","There are no records that meet the specified search criteria")
//	end if
//	debugbreak()

	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2005-11-17 By: Cao YongWang
	//$<reason> Replaced setsqlselect function with modify function
	//dw_search.SetSQLSelect ( ls_sql_org )
	dw_search.modify( 'datawindow.table.select = "' + ls_sql_org + '"')
	//---------------------------- APPEON END ----------------------------
	dw_search.settransobject(sqlca)
	
end if

	
	
 
end event

type cb_3 from commandbutton within w_help_window
integer x = 3040
integer y = 72
integer width = 279
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;messagebox("About Help","This is the first version of the IntelliCred Help Files, and it contains only a minimal number of files.~rAdditional files will be available in the near future.")
end event

type cb_print from commandbutton within w_help_window
integer x = 2743
integer y = 72
integer width = 279
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;dw_search.print()
end event

type st_1 from statictext within w_help_window
integer x = 50
integer y = 40
integer width = 773
integer height = 132
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Select Subcategory to view related tips"
boolean focusrectangle = false
end type

type dw_cats from datawindow within w_help_window
integer x = 37
integer y = 188
integer width = 786
integer height = 1936
integer taborder = 60
string dataobject = "d_help_category_tv"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;//string ls_search
//string ls_words[]
//integer i
//integer r
//integer w = 0
//string ls_sql
//string ls_keyword = ""
//string ls_where
//integer p1
//integer p2
//integer p3
//string ls_sql_org
//string iword
//integer rows
//integer wc
//long bugid
//
//dw_search.SetTransObject( SQLCA )
//ls_sql = dw_search.Object.DataWindow.Table.Select
////messagebox("",ls_sql)
//ls_sql_org = ls_sql
//
//
//ls_search = this.getitemstring(this.getrow(),"subcategory")
//
//if len(ls_search) < 1 then //no value
//	ls_keyword = "" 
//	//messagebox("ls_keyword","Nothing")
//
//
//else //all and any
//	
//	ls_keyword =	" Where subcategory like '%" + ls_search + "%'"	
//end if
//
//ls_where =  ls_keyword 
//
//
//ls_sql = ls_sql + ls_where + ";"
//
//dw_search.SetSQLSelect ( ls_sql )
//	//messagebox( "w_sql_msg", ls_sql )
//dw_search.SetTransObject( SQLCA )
//
//rows = dw_search.Retrieve()
//
//if rows < 1 then
////		messagebox("No records found","There are no records that meet the specified search criteria")
//end if
//debugbreak()
//
//dw_search.SetSQLSelect ( ls_sql_org )
//dw_search.settransobject(sqlca)
//
//
end event

event clicked;
string ls_search
string ls_words[]
integer i
long r
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

if this.rowcount() < 1 then return

This.SelectRow( 0, False )
This.SelectRow( row, True )

r = this.getclickedrow()

this.setrow(r)


dw_search.SetTransObject( SQLCA )
ls_sql = dw_search.Object.DataWindow.Table.Select
//messagebox("",ls_sql)
ls_sql_org = ls_sql




ls_search = this.getitemstring(this.getrow(),"subcategory")

if LenA(ls_search) < 1 then //level 1
	ls_search = this.getitemstring(this.getrow(),"category")
	ls_keyword =	" Where category like '%" + ls_search + "%'"	
	//messagebox("ls_keyword","Nothing")
else //all and any
	
	ls_keyword =	" Where subcategory like '%" + ls_search + "%'"	
end if

ls_where =  ls_keyword 


ls_sql = ls_sql + ls_where + ";"
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-17 By: Cao YongWang
//$<reason> Replaced setsqlselect function with modify function
//dw_search.SetSQLSelect ( ls_sql )
dw_search.modify('datawindow.table.select = "' + ls_sql +'"')
//---------------------------- APPEON END ----------------------------
	//messagebox( "w_sql_msg", ls_sql )
dw_search.SetTransObject( SQLCA )

rows = dw_search.Retrieve()

if rows < 1 then
//		messagebox("No records found","There are no records that meet the specified search criteria")
end if
debugbreak()

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-17 By: Cao YongWang
//$<reason> Replaced setsqlselect function with modify function
//dw_search.SetSQLSelect ( ls_sql_org )
dw_search.modify('datawindow.table.select = "' + ls_sql_org +'"')
//---------------------------- APPEON END ----------------------------
dw_search.settransobject(sqlca)
end event

event treenodeselected;//Start Code Change ----07.26.2016 #V153 maha - changed to treeview

//IF row < 1 OR grouplevel < 1 THEN RETURN

string ls_search
string ls_words[]
integer i
long r
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
debugbreak()
if this.rowcount() < 1 then return

r = this.getclickedrow()

this.setrow(r)

dw_search.SetTransObject( SQLCA )
ls_sql = dw_search.Object.DataWindow.Table.Select
//messagebox("",ls_sql)
ls_sql_org = ls_sql

if grouplevel > 1 then
	ls_search = this.getitemstring(this.getrow(),"subcategory")
	ls_keyword =	" Where subcategory like '%" + ls_search + "%'"	
else //all and any
	ls_search = this.getitemstring(this.getrow(),"category")
	ls_keyword =	" Where category like '%" + ls_search + "%'"	
end if

ls_where =  ls_keyword 


ls_sql = ls_sql + ls_where + ";"

dw_search.modify('datawindow.table.select = "' + ls_sql +'"')

	//messagebox( "w_sql_msg", ls_sql )
dw_search.SetTransObject( SQLCA )

rows = dw_search.Retrieve()

if rows < 1 then
//		messagebox("No records found","There are no records that meet the specified search criteria")
end if
debugbreak()

//reset sql
dw_search.modify('datawindow.table.select = "' + ls_sql_org +'"')
dw_search.settransobject(sqlca)

end event

type cb_2 from commandbutton within w_help_window
integer x = 2446
integer y = 72
integer width = 279
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_search.SetSort(null_str)

dw_search.Sort( )
end event

type cb_1 from commandbutton within w_help_window
integer x = 2153
integer y = 72
integer width = 279
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;string null_str

SetNull(null_str)

dw_search.Setfilter(null_str)

dw_search.filter( )
end event

type dw_search from datawindow within w_help_window
integer x = 855
integer y = 356
integer width = 2766
integer height = 1764
integer taborder = 20
string dataobject = "d_help_browse"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_go from commandbutton within w_help_window
integer x = 2153
integer y = 216
integer width = 283
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
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
//$<modify> 2005-11-17 By: Cao YongWang
//$<reason> Replaced setsqlselect function with modify function
//dw_search.SetSQLSelect ( ls_sql )
dw_search.modify('datawindow.table.select = "' + ls_sql +'"')
//---------------------------- APPEON END ----------------------------

	//messagebox( "w_sql_msg", ls_sql )
dw_search.SetTransObject( SQLCA )

rows = dw_search.Retrieve()

if rows < 1 then
//		messagebox("No records found","There are no records that meet the specified search criteria")
end if
debugbreak()
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-17 By: Cao YongWang
//$<reason> Replaced setsqlselect function with modify function
//dw_search.SetSQLSelect ( ls_sql_org )
dw_search.modify('datawindow.table.select = "' + ls_sql_org +'"')
//---------------------------- APPEON END ----------------------------

dw_search.settransobject(sqlca)




end event

type sle_search from singlelineedit within w_help_window
integer x = 864
integer y = 212
integer width = 1257
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type rb_exact from radiobutton within w_help_window
integer x = 1669
integer y = 88
integer width = 434
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Exact phrase"
boolean checked = true
end type

type rb_all from radiobutton within w_help_window
integer x = 1303
integer y = 88
integer width = 325
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All words"
end type

type rb_any from radiobutton within w_help_window
integer x = 928
integer y = 88
integer width = 361
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Any words"
end type

type cb_quit from commandbutton within w_help_window
integer x = 3342
integer y = 72
integer width = 279
integer height = 84
integer taborder = 90
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

type gb_keyword from groupbox within w_help_window
integer x = 864
integer y = 24
integer width = 1262
integer height = 160
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Keyword Search"
end type

