$PBExportHeader$w_create_view.srw
forward
global type w_create_view from window
end type
type st_2 from statictext within w_create_view
end type
type dw_screen1 from datawindow within w_create_view
end type
type cb_1 from commandbutton within w_create_view
end type
type dw_fields from datawindow within w_create_view
end type
type st_1 from statictext within w_create_view
end type
end forward

global type w_create_view from window
integer x = 1056
integer y = 484
integer width = 2469
integer height = 412
boolean titlebar = true
string title = "Create Database View"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
st_2 st_2
dw_screen1 dw_screen1
cb_1 cb_1
dw_fields dw_fields
st_1 st_1
end type
global w_create_view w_create_view

forward prototypes
public function integer of_create_view ()
end prototypes

public function integer of_create_view ();Datawindowchild dwchild

 Boolean lb_facility_level

Long ll_next_dv_id
Long ll_label_y = 50
Long ll_field_y = 114
Long ll_next_field_id
Integer li_screen_len
Integer li_fld_len
Integer fl
Integer l
Integer li_retval
Integer li_code_lookup_cnt
Integer li_address_lookup_cnt
Integer li_facility_id
Integer li_found
Integer li_append_to_screen_id
Integer li_next_screen_id  
Integer li_next_screen_order  
Integer loop_cnt
Integer ll_cnt
Integer li_nr
Integer li_rc
Integer li_dv_cnt
Integer d
Integer i
Integer li_table_id

String ls_char
String ls_drop_sql
String ls_field_orig
String ls_view_where_sql
String ls_view_field_sql
String ls_view_from_sql

String ls_ltr_where_sql
String ls_ltr_field_sql
String ls_ltr_from_sql
String ls_group_syntax
String ls_grey
String ls_white
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_stripped_field
String ls_sql
String ls_field
String ls_ver_ltr_sql
String ls_from_sql
String ls_where_sql
String ls_ver_ltr_doc
String ls_field_sql
String ls_exp_doc_name
String  ls_coltype
String ls_table
String ls_screen_name
String ls_lookup_type
String ls_alpha[26]
String ls_field_labels[]
string ls_tab2

ls_alpha[1] = 'A'
ls_alpha[2] = 'B'
ls_alpha[3] = 'C'
ls_alpha[4] = 'D'
ls_alpha[5] = 'E'
ls_alpha[6] = 'F'
ls_alpha[7] = 'G'
ls_alpha[8] = 'H'
ls_alpha[9] = 'I'
ls_alpha[10] = 'J'
ls_alpha[11] = 'K'
ls_alpha[12] = 'L'
ls_alpha[13] = 'M'
ls_alpha[14] = 'N'
ls_alpha[15] = 'O'
ls_alpha[16] = 'P'
ls_alpha[17] = 'Q'
ls_alpha[18] = 'R'
ls_alpha[19] = 'S'
ls_alpha[20] = 'T'
ls_alpha[21] = 'U'
ls_alpha[22] = 'V'
ls_alpha[23] = 'W'
ls_alpha[24] = 'X'
ls_alpha[25] = 'Y'
ls_alpha[26] = 'Z'


dw_fields.SetTRansObject( SQLCA )
dw_fields.Retrieve( dw_screen1.GetItemNumber( 1, "screen_id" ) )

ls_table = dw_fields.GetItemString( 1, "table_name" )
ls_table = MidA( ls_table, 5, 100 ) 


ls_screen_name = dw_fields.GetItemString( 1, "screen_alias" )
li_screen_len = LenA( ls_screen_name )
FOR l = 1 TO li_screen_len
	CHOOSE CASE MidA( ls_screen_name, l, 1 )
	CASE " ", "!","@","#","$","%","^","&","*","(",")","-","=","+","[","]","{","}","\","/","//","|","/","?",",","<",">",".",":",";"
		ls_screen_name = MidA( ls_screen_name, 1, l -1 ) + MidA( ls_screen_name, l+1, 500 )
	END CHOOSE
END FOR


li_rc = dw_fields.RowCount()



FOR i = 1 TO li_rc	
	ls_field_orig = dw_fields.GetItemString( i, "field_name" )
	ls_field_labels[i] = dw_fields.GetItemString( i, "field_label" )	
	
	CHOOSE CASE MidA( ls_field_labels[i], 1, 1 )
		CASE "1","2","3","4","5","6","7","8","9","0"
			ls_field_labels[i] = MidA( ls_field_labels[i], 2, 500 )
		CASE "32234234"		
	END CHOOSE		

	li_fld_len = LenA( ls_field_labels[i] )
	IF li_fld_len = 0 THEN
		ls_field_labels[i] = ls_field_orig	
	END IF
		
	FOR fl = 1 TO li_fld_len
		IF LenA( ls_field_labels[i] ) = 0 THEN
			ls_field_labels[i] = ls_field_orig
			CONTINUE
		END IF
		ls_char = Upper( MidA( ls_field_labels[i], fl, 1 ) )
		CHOOSE CASE ls_char
			CASE " ", "!","@","#","$","%","^","&","*","(",")","-","=","+","[","]","{","}","\","/","|","?",",","<",">",".",":",";"
				ls_field_labels[i] = MidA( ls_field_labels[i], 1, fl -1 ) + MidA( ls_field_labels[i], fl + 1 , 500 )
				fl --
			CASE "42423423"
		END CHOOSE
	END FOR

	CHOOSE CASE  Upper( ls_field_labels[i] )
		CASE "SELECT", "DATE", "DATETIME", "ORDER", "WHERE"
			ls_field_labels[i] = ls_field_labels[i] + "_1"
		CASE "342342342342"	
	END CHOOSE		
	ls_field_labels[i] = MidA( ls_field_labels[i], 1, 30 )
	//messagebox("", ls_field_labels[i])
END FOR


////look for duplicate names
FOR i = 1 TO li_rc
	FOR l = 1 TO li_rc
		IF l = i THEN
			CONTINUE
		END IF
		IF Upper(ls_field_labels[i]) = Upper(ls_field_labeLs[l]) THEN
			ll_cnt ++
			ls_field_labels[l] = ls_field_labels[l] + "_" + String( ll_cnt )
		END IF
	END FOR
END FOR


FOR i = 1 TO li_rc	
	ls_field_orig = dw_fields.GetItemString( i, "field_name" )
	ls_field =  ls_table + "." + ls_field_orig
	ls_stripped_field = ls_field_labels[i]
	ls_lookup_type = dw_fields.GetItemString( i, "lookup_type" )
	IF ls_lookup_type  = "" OR IsNull( ls_lookup_type )  THEN
		ls_field_sql = ls_field_sql + ls_field_labels[i] + " = " +  ls_field + ",~n~r"		
	ELSE
		IF ls_lookup_type = "C" THEN
			li_code_lookup_cnt++	
			
			ls_field_sql = ls_field_sql + ls_stripped_field + "_code = code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + ".code,~n~r"
			ls_field_sql = ls_field_sql + ls_stripped_field + "_descr = code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + ".description,~n~r"	
			//------------------- APPEON BEGIN -------------------
			//$<modify> Stephen 06.20.2012
			//$<reason>  V12.2 SQL Server 2008 Support
			/*
			ls_from_sql = ls_from_sql + "code_lookup code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + ",~n~r"
			ls_where_sql = ls_where_sql + "( code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + ".lookup_code =* " + ls_field + ") AND~n~r "
			*/
			ls_tab2 = ls_table + " " + ls_table +"_"+string(i)         
			ls_field =  ls_table +"_"+string(i) + "." + ls_field_orig  
			ls_from_sql = ls_from_sql + "code_lookup code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + " right outer join " +ls_tab2
			ls_from_sql = ls_from_sql + " on "+ "( code_lookup_" + ls_alpha[ li_code_lookup_cnt ] + ".lookup_code = " +  ls_field  + "),~n~r"
			//------------------- APPEON END -------------------
			
		ELSEIF ls_lookup_type = "A" THEN			
			li_address_lookup_cnt++	
			
			ls_field_sql = ls_field_sql + ls_stripped_field + "_code = address_lookup_" + ls_alpha[ li_address_lookup_cnt ] + ".code,~n~r"
			ls_field_sql = ls_field_sql + ls_stripped_field + "_name = address_lookup_" + ls_alpha[ li_address_lookup_cnt ] + ".entity_name,~n~r"	
			//------------------- APPEON BEGIN -------------------
			//$<modify> Stephen 06.20.2012
			//$<reason>  V12.2 SQL Server 2008 Support
			/*
			ls_where_sql = ls_where_sql + "( address_lookup_" + ls_alpha[ li_address_lookup_cnt ] + ".lookup_code =* " + ls_field + ") AND~n~r"
			ls_from_sql = ls_from_sql + "address_lookup address_lookup_" + ls_alpha[ li_address_lookup_cnt ] + ",~n~r"	
			*/
			ls_tab2 = ls_table + " " + ls_table +"_"+string(i)         
			ls_field =  ls_table +"_"+string(i) + "." + ls_field_orig  
			ls_from_sql = ls_from_sql + "address_lookup address_lookup_" + ls_alpha[ li_address_lookup_cnt ] +" right outer join " +ls_tab2
			ls_from_sql = ls_from_sql + " on "+ "( address_lookup_" + ls_alpha[ li_address_lookup_cnt ] + ".lookup_code = " + ls_field  +  "),~n~r"	
			//------------------- APPEON END -------------------
		ELSE
			ls_field_sql = ls_field_sql + ls_field + ",~n~r"
		END IF
	END IF	
END FOR


ls_view_field_sql = "CREATE VIEW " + "v_" + ls_screen_name + " AS SELECT prac_id, rec_id, "
	
ls_view_from_sql = "FROM "

ls_view_from_sql = ls_view_from_sql + "" + ls_table + ",~n~r" 
IF li_code_lookup_cnt + li_address_lookup_cnt = 0 THEN 
	ls_view_where_sql = "" 
	ls_field_sql = MidA( ls_field_sql, 1, LenA( ls_field_sql ) -3 )
	ls_from_sql = "FROM " + ls_table 
	ls_view_from_sql = ""
	ls_sql = ls_view_field_sql + " " + ls_field_sql + " " + ls_view_from_sql + " " + ls_from_sql + " " + ls_view_where_sql + " " + ls_where_sql	
ELSE
	ls_view_where_sql = "WHERE " 
	ls_view_field_sql = MidA( ls_view_field_sql + ls_field_sql, 1, LenA( ls_view_field_sql + ls_field_sql )-3 )
	ls_view_from_sql =  MidA( ls_view_from_sql +  ls_from_sql, 1, LenA( ls_view_from_sql +  ls_from_sql )-3 )
	ls_view_where_sql = MidA( ls_view_where_sql + ls_where_sql, 1, LenA( ls_view_where_sql + ls_where_sql )-6 )
	ls_sql =  ls_view_field_sql + " " + ls_view_from_sql + " " + ls_view_where_sql	
END IF

ClipBoard( ls_sql )  

ls_drop_sql = "DROP VIEW v_" + ls_screen_name
EXECUTE IMMEDIATE :ls_drop_sql;

EXECUTE IMMEDIATE :ls_sql;

IF SQLCA.SQLCODE = -1 THEN
	MessageBox("View", "Failed creating View." )
END IF

MessageBox("Complete", "Finished creating VIEW."  )

Return 1
end function

on w_create_view.create
this.st_2=create st_2
this.dw_screen1=create dw_screen1
this.cb_1=create cb_1
this.dw_fields=create dw_fields
this.st_1=create st_1
this.Control[]={this.st_2,&
this.dw_screen1,&
this.cb_1,&
this.dw_fields,&
this.st_1}
end on

on w_create_view.destroy
destroy(this.st_2)
destroy(this.dw_screen1)
destroy(this.cb_1)
destroy(this.dw_fields)
destroy(this.st_1)
end on

event open;SQLCA.DBMS="ODBC"
SQLCA.DBParm = "ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL',DelimitIdentifier='Yes'"

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
	MessageBox("Login", "Inital Login Failed!  Check your ODBC configuration")
	Return -1
END IF


dw_screen1.SetTransObject( SQLCA )
dw_screen1.InsertRow( 0 )

end event

type st_2 from statictext within w_create_view
integer x = 37
integer y = 196
integer width = 2386
integer height = 112
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "This utility will create a database view for any screen using the data_view_screen and data_view_fields tables"
boolean focusrectangle = false
end type

type dw_screen1 from datawindow within w_create_view
integer x = 837
integer y = 60
integer width = 805
integer height = 136
integer taborder = 20
string dataobject = "d_select_screen_to_append_to"
boolean border = false
boolean livescroll = true
end type

type cb_1 from commandbutton within w_create_view
integer x = 1646
integer y = 64
integer width = 306
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create View"
end type

event clicked;of_create_view()
end event

type dw_fields from datawindow within w_create_view
integer x = 14
integer y = 360
integer width = 2898
integer height = 700
integer taborder = 30
string dataobject = "d_create_view_fields"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_create_view
integer x = 55
integer y = 84
integer width = 800
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Select Screen to Create  View For:"
boolean focusrectangle = false
end type

