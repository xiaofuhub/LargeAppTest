$PBExportHeader$w_xml_read.srw
forward
global type w_xml_read from window
end type
type dw_basic from datawindow within w_xml_read
end type
type sle_2 from singlelineedit within w_xml_read
end type
type cb_4 from commandbutton within w_xml_read
end type
type cb_3 from commandbutton within w_xml_read
end type
type cb_2 from commandbutton within w_xml_read
end type
type cb_1 from commandbutton within w_xml_read
end type
end forward

global type w_xml_read from window
integer width = 2405
integer height = 1876
boolean titlebar = true
string title = "XML Parser"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_basic dw_basic
sle_2 sle_2
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_xml_read w_xml_read

type variables
string is_file
end variables

forward prototypes
public function string of_parse_first (string as_data)
public function string of_date_fix (string as_data)
public function integer of_parse_file ()
public function integer of_build_tables (string as_table)
public function integer of_parse_hr_xml_file ()
end prototypes

public function string of_parse_first (string as_data);string ls_write
string ls_date
integer p1
integer p2
integer p3

//debugbreak()
//<Provider ProviderID="937" ProviderAttestID="1901307" AttestDate="2005-03-24T15:29:26" ModelVersion="18" xmlns="urn:GeoAccess.PDE.Provider">
//break the data into separate rows
p1 = PosA(as_data,'ProviderID="',1)
p1 = p1+12
p2 =  PosA(as_data,'"',p1 ) 
ls_write += "ProviderID*" + MidA(as_data,p1 , p2 - p1 )
ls_write += "~r~n"

p1 = PosA(as_data,'ProviderAttestID="',1)
p1 = p1+19
p2 =  PosA(as_data,'"',p1) 
ls_write += "ProviderAttestID*" + MidA(as_data,p1, p2 - p1 )
ls_write += "~r~n"

p1 = PosA(as_data,'AttestDate="',1)
p1 = p1+12
p2 =  PosA(as_data,'"',p1) 
ls_date = MidA(as_data,p1 , p2 - p1 )
ls_date = of_date_fix( ls_date)
ls_write += "AttestDate*" + ls_date


return ls_write
end function

public function string of_date_fix (string as_data);string ls_return

ls_return = as_data

//debugbreak()
if   PosA(as_data,"-",1) = 5 and   PosA(as_data,'T',1) = 11 then
	ls_return = MidA(as_data,1,10) + " " + MidA(as_data,12)
end if

return ls_return
end function

public function integer of_parse_file ();//parse the file

long i
long ic
long pa
long pb
long pc
long pd
boolean ib_skip


integer li_read
integer li_write

string ls_read
string ls_name
string ls_value
string ls_write
string ls_table

is_file = sle_2.text
//debugbreak()
li_read = FileOpen ( is_file)
li_write = FileOpen ( "C:\_xmlparsetest.txt" ,        LineMode!, Write!, LockWrite!, Replace!)


for i = 1 to 50000
	if FileRead ( li_read, ls_read) = -100 then exit //end of file
	
	if i = 1 then  //parsing for the first row of the file
		ls_write = of_parse_first(ls_read)
		messagebox("",ls_write)
		ic = FileWrite ( li_write, ls_write)
		continue
	end if
	
	pa = PosA(ls_read, "<" ,1)
	pb = PosA(ls_read, ">" ,1)
	pc = PosA(ls_read, "</" ,1)
	
	ib_skip = false
	if pc = 0 then //if there is no close tag
		if PosA(ls_read,"ID=",1) = 0 then //if there is no id value skip
			continue
		else
			ls_table = MidA(ls_read,3,PosA(ls_read," ID",1)  - 3)
			//messagebox("",ls_table)
			of_build_tables( ls_table)
			ls_name = "#%#%#%" + "*" + MidA(ls_read,2,LenA(ls_read) - 2)
				ls_value = ""
			ib_skip = true
		end if
	elseif pc < 6 then  //skip the close tag
		//skip the line
		continue
	else
		ls_name = MidA(ls_read, pa + 1, pb - 1 - pa )
		ls_value = MidA(ls_read, pb + 1, pc - 1 - pb )
	end if
	
//	if ib_skip then 
//		ls_write = "~r~n"
//		ic = FileWrite ( li_write, ls_write)
//	end if
	
	if PosA(ls_value,"00:00:00",1) > 0 then
		ls_value = of_date_fix( ls_value)
	end if
	
	ls_write = upper(ls_name) + "*" + ls_value
	
	ic = FileWrite ( li_write, ls_write)
next

FileClose(li_read)
FileClose(li_write)

return 1


end function

public function integer of_build_tables (string as_table);

if PosA(as_table ,"<",1) > 0 then return 1  //skips all the tables sub of practice

choose case upper(as_table)
	case 'OTHERNAME'
		
	case 'LANGUAGE'
		
	case 'PROVIDERCDS'
		
	case 'PROVIDERMEDICARE'

	case 'PROVIDERMEDICAID'
	
	case 'PROVIDERLICENSE'	
		
	case 'EDUCATION'
		
	case 'SPECIALTY'
			
	case 'OTHERINTEREST'
				
	case 'PRACTICE'
		
	case 'ACCESSIBILITY'
		
	case 'ASSOCIATE'
		
	case 'ASSOCIATESPECIALTY'
		
	case 'CERTIFICATION'
		
	case 'LANGUAGE'
	
	case 'LIMITATION'
		
	case 'PATIENT'
		
	case 'PHONECOVERAGE'
		
	case 'SERVICE'
		
	case 'TAXID'
		
	case 'PROVIDERPRACTICEHOURS'
	
	case 'HOSPITAL'
		
	case 'INSURANCE'
		
	case 'WORKHISTORY'
		
	case 'TIMEGAP'
		
	case 'REFERENCE'
		
	case 'DISCLOSURE'
		
	case 'MALPRACTICE'
		
	case 'CLAIMSTATUS'
		
	case 'PROVIDERADDRESS'
		
	case else
		messagebox("Table not found",as_table)
		
end choose
		
		
		
		
return 1

end function

public function integer of_parse_hr_xml_file ();//parse the file

long i
long ic
long pa
long pb
long pc
long pstart1
long pstart2
long pd
boolean ib_skip


integer li_read
integer li_write

string ls_read
string ls_name
string ls_value
string ls_write
string ls_table

is_file = sle_2.text

li_read = FileOpen ( is_file)
li_write = FileOpen ( "C:\_xmlparsetest.txt" ,        LineMode!, Write!, LockWrite!, Replace!)


for i = 1 to 50000
	if FileRead ( li_read, ls_read) = -100 then exit //end of file
	
//	if i = 1 then  //parsing for the first row of the file
//		ls_write = of_parse_first(ls_read)
//		messagebox("",ls_write)
//		ic = FileWrite ( li_write, ls_write)
//		continue
//	end if
	
	pa = PosA(ls_read, "{" ,1) //opening lines
	pb = PosA(ls_read, "viewkind" ,1) 
	pc = PosA(ls_read, "xml:lang" ,1) 
	
	ls_write = upper(ls_name) + "*" + ls_value
	pstart1 = PosA(ls_read, "\pard\fi" ,1)
	pstart2 = PosA(ls_read, "\cf2\b\f1" ,1)
	
	ib_skip = false
	
	//skip the header lines
	if pa > 0 then continue
	if pb > 0 then continue
	if pc > 0 then continue
	
	if pstart1 > 0 then 
		pd = 47
	elseif pstart2 > 0 then
		pd = 35
	else
		pd = 1
	end if
	//debugbreak()
	//skip any par means no value
	//ls_name =  mid(ls_read, len(ls_read) - 6) 
	//if ls_name = "\cf0\par" then continue
	if PosA(ls_read, "\cf0\par" ,1) > 0 then continue
	
	
	
	ls_name = ""
	ls_value = MidA(ls_read, pd)
//		if pos(ls_read,"ID=",1) = 0 then //if there is no id value skip
//			continue
//		else
//			ls_table = mid(ls_read,3,pos(ls_read," ID",1)  - 3)
//			//messagebox("",ls_table)
//			of_build_tables( ls_table)
//			ls_name = "#%#%#%" + "*" + mid(ls_read,2,len(ls_read) - 2)
//				ls_value = ""
//			ib_skip = true
//		end if
//	elseif pc < 6 then  //skip the close tag
//		//skip the line
//		continue
//	else
//		ls_name = mid(ls_read, pa + 1, pb - 1 - pa )
//		ls_value = mid(ls_read, pb + 1, pc - 1 - pb )
//	end if
//	
////	if ib_skip then 
////		ls_write = "~r~n"
////		ic = FileWrite ( li_write, ls_write)
////	end if
//	
//	if pos(ls_value,"00:00:00",1) > 0 then
//		ls_value = of_date_fix( ls_value)
//	end if
	
//	ls_write = upper(ls_name) + "*" + ls_value
	ls_write = upper(ls_name) + ls_value
	
	ic = FileWrite ( li_write, ls_write)
next

FileClose(li_read)
FileClose(li_write)

return 1


end function

on w_xml_read.create
this.dw_basic=create dw_basic
this.sle_2=create sle_2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_basic,&
this.sle_2,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_xml_read.destroy
destroy(this.dw_basic)
destroy(this.sle_2)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type dw_basic from datawindow within w_xml_read
integer x = 133
integer y = 400
integer width = 2103
integer height = 1240
integer taborder = 40
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_2 from singlelineedit within w_xml_read
integer x = 105
integer y = 56
integer width = 1358
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "I:\hr-xml-test.xml"
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_xml_read
integer x = 2057
integer y = 272
integer width = 279
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "none"
end type

type cb_3 from commandbutton within w_xml_read
integer x = 1774
integer y = 52
integer width = 279
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Run"
end type

event clicked;integer ll_ret

is_file = sle_2.text

of_parse_hr_xml_file()

//ll_ret = XMLParseFile(is_file)
//messagebox("parsefile",ll_ret)
//
//ll_ret = dw_basic.importfile( is_file)
//messagebox("importfile",ll_ret)
//

end event

type cb_2 from commandbutton within w_xml_read
integer x = 1481
integer y = 52
integer width = 279
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Get file"
end type

event clicked;string docpath, docname

integer i, li_cnt, li_rtn, li_filenum

 

li_rtn = GetFileOpenName("Select File",   docpath, docname, "XML",  "XML Files (*.XML),*.XML," )
sle_2.text = docpath
end event

type cb_1 from commandbutton within w_xml_read
integer x = 2066
integer y = 52
integer width = 279
integer height = 84
integer taborder = 10
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

