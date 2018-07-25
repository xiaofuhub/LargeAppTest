$PBExportHeader$u_office_ocx.sru
forward
global type u_office_ocx from olecustomcontrol
end type
end forward

global type u_office_ocx from olecustomcontrol
integer width = 1623
integer height = 976
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "u_office_ocx.udo"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
event onfilecommand ( integer item,  ref boolean iscancel )
event ondocumentopened ( string file,  OleObject document )
event ondocumentclosed ( )
event afterpreviewclosed ( )
event onstatuschange ( string statustext,  long statuscode )
event onwebgetfinished ( string retdata )
event onwebexecutefinished ( string retdata )
event oncustommenucmd ( long menuindex,  string menucaption,  long mymenuid )
event oncustomfilemenucmd ( long menuindex,  string menucaption,  long mymenuid )
event afterhandsignordraw ( long draworsign,  boolean iscanceled )
event afterchecksign ( )
event onsignselect ( boolean isvalidsign,  string signinfo )
event onsheetselectionchange ( string sheetname,  long row,  long col,  OleObject selectionrange )
event onsheetbeforedoubleclick ( string sheetname,  long row,  long col,  ref boolean iscancel )
event onsheetbeforerightclick ( string sheetname,  long row,  long col,  ref boolean iscancel )
event onwordwpsselchange ( OleObject selection )
event onsheetchange ( string sheetname,  long row,  long col )
event oncustommenucmd2 ( long menupos,  long submenupos,  long subsubmenupos,  string menucaption,  long mymenuid )
event afteropenfromurl ( OleObject document,  long statuscode )
event beforeoriginalmenucommand ( string menutitle,  ref boolean iscancel )
event beforeaddsign ( string signname,  string signuser,  ref boolean iscancel )
event ondocactivated ( boolean isactivated )
event onprintprnfromurlevent ( long statuscode,  string url,  string docname,  string moreinfo )
event onwordbeforerightclick ( OleObject selection,  ref boolean iscancel )
event onpptbeforerightclick ( OleObject selection,  ref boolean iscancel )
event beforedocuploaded ( OleObject controlfiledata )
event onbeforedosecsign ( string username,  string signname,  string signuser,  string signsn,  ref boolean iscancel )
event onbeforedosecsignfromekey ( string username,  string signname,  string signuser,  string signsn,  string ekeysn,  ref boolean iscancel )
event afterpublishaspdftourl ( string retdata,  long errorcode )
event onpptslideshowbegin ( )
event onpptslideshowend ( )
event onpptslideshownextslide ( )
event onsecsignsetinfo ( string username,  long signtype,  OleObject secsignobject )
event onwordbeforedoubleclick ( OleObject selection,  ref boolean iscancel )
event oncustombuttononmenucmd ( long btnpos,  string btncaption,  long btnid )
event onscreenmodechanged ( boolean isfullscreenmode )
event onsecsigndeleted ( string username,  string signname,  string signuser,  string signsn,  string ekeysn,  string userdata )
event afterfilecommand ( integer item )
event afterpublishasntkftourl ( string retdata,  long errorcode )
event aftersaveasntkftolocal ( string fname,  long errorcode )
event oncustomtoolbarcommand ( long buttonindex )
event onsheetfollowhyperlink ( OleObject sheet,  OleObject linktarget )
event onsecsignfinished ( boolean bisok,  OleObject secsignobject )
event onurloperationcompleted ( long uloperationtype,  long ulstatcode,  string bstrretdata )
event onbeginopenfromurl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onaddtemplatefromurl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onaddpicfromurl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onaddsignfromurl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onaddsecsignfromurl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onisurlsignpassok ( long lfunctype,  long lstatcode,  string bstrretdata )
event onaddncotemplatefromurl ( long lfunctype,  long lstatcode,  string bstrretdata )
event ondoproofreadurl ( long lfunctype,  long lstatcode,  string bstrretdata )
event ondowebget ( long lfunctype,  long lstatcode,  string bstrretdata )
event ondowebexecute ( long lfunctype,  long lstatcode,  string bstrretdata )
event onsavetourl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onsavehandsigntourl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onsaveasgiffilestourl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onpublishashtmltourl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onsaveasotherformattourl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onsaveasprnfiletourl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onpublishaspdftourl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onpublishasntkftourl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onsavencotourl ( long lfunctype,  long lstatcode,  string bstrretdata )
event onopenncofromurl ( long lfunctype,  long lstatcode,  string bstrretdata )
event ondowebexecute2 ( long lfunctype,  long lstatcode,  string bstrretdata )
event aftersaveaspdffile ( long errorcode )
event onclickhyperlink ( string bstrname,  ref boolean iscancel )
event onclickcustomcontextmenu ( long menuindex )
event onbeforeleftclick ( )
event aftersavetolocal ( string bstrpath )
event aftersavetourl ( string bstrurl )
event beforetoolbarsign ( )
event aftertoolbarsign ( boolean bisok )
end type
global u_office_ocx u_office_ocx

type variables
n_cst_dm_utils inv_dm_utils
end variables

forward prototypes
public function integer of_close ()
public function integer of_open (string as_file, boolean ab_readonly)
public function integer of_open (ref blob ablb_data, string as_file, boolean ab_readonly)
end prototypes

public function integer of_close ();//close the document - alfee 07.14.2009

this.object.Close()

Return 1
end function

public function integer of_open (string as_file, boolean ab_readonly);//Open the specified document - alfee 07.14.2009

of_close()
IF NOT FileExists(as_file) OR IsNull(ab_readonly) THEN RETURN -1 

TRY
	
This.object.OpenLocalFile(as_file, ab_readonly)

CATCH(throwable th1)
	MessageBox("Open File","Open file failed due to: " + th1.text)
	RETURN -1
END TRY

RETURN 1
end function

public function integer of_open (ref blob ablb_data, string as_file, boolean ab_readonly);//open the specified document with blob data - alfee 07.14.2009

// Generate a temporary file
IF inv_dm_utils.of_readblob( as_file, ablb_Data) = -1 THEN RETURN -1

DO While Not FileExists(as_file)
	Yield( )
LOOP
Yield( )

//Open file
Return of_Open(as_file, ab_readonly)
end function

event constructor;//Re-created on new Office Control - (Appeon)Alfee 11.12.2013 for V141 ISG-CLX

//this.object.IsResetToolbarsOnOpen = true//Alfee 11.26.2007

//this.object.menubar(false)
this.object.titlebar(false)
//this.object.statusbar(false)
this.object.filenew = false
this.object.fileopen = false
this.object.filesave = false
this.object.filesaveas = false

//Set the primary key
this.object.MakerCaption="IntelliSoft Group Inc."
this.object.MakerKey="B6DE7E7AC5ECB2246623312AFA9289F069F21D6E"
//Set the title key
this.object.ProductCaption="IntelliSoft Group Inc."
this.object.ProductKey="D2FA8177167CF61E789F322B794D4DD12E86EC68"

this.object.IsShowFullScreenButton = gb_ShowFullScreenButton //(Appeon)Alfee 07.02.2013 for V141 ISG-CLX

end event

on u_office_ocx.create
end on

on u_office_ocx.destroy
end on


Start of PowerBuilder Binary Data Section : Do NOT Edit
00u_office_ocx.bin 
2000000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000081e2b43001cedf5700000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d30000000081e2b43001cedf5781e2b43001cedf570000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd000024b10000193800dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd000024b10000193800dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10u_office_ocx.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
