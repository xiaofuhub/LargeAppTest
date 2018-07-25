$PBExportHeader$w_test_fax.srw
forward
global type w_test_fax from window
end type
type cb_2 from commandbutton within w_test_fax
end type
type cb_1 from commandbutton within w_test_fax
end type
end forward

global type w_test_fax from window
integer x = 1056
integer y = 484
integer width = 1669
integer height = 1160
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
cb_2 cb_2
cb_1 cb_1
end type
global w_test_fax w_test_fax

on w_test_fax.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.cb_1}
end on

on w_test_fax.destroy
destroy(this.cb_2)
destroy(this.cb_1)
end on

type cb_2 from commandbutton within w_test_fax
integer x = 389
integer y = 524
integer width = 809
integer height = 300
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "fax"
end type

event clicked;string sQ = "~""
Long ChanNum
Integer iRC, a
String ls_fax_number, ls_time, ls_date, ls_recipient, ls_company, ls_subject, ls_resolution, ls_cover_text, ls_attachments[]


ls_recipient = "John Damelio"
ls_company = "IntelliSoft Group Inc"
ls_fax_number = "978-251-0909"
ls_time = String( Now(), "HH:MM:SS" )
ls_date = String( Today( ), "mm/dd/yy"  )
ls_subject = "This is a subject line"
ls_cover_text = "This is a test to see if this test goes on the cover.  Im am pretty sure it will." 
ls_attachments[ 1 ] = gs_dir_path + "IntelliCred\Fax\fax_1.doc"
ls_attachments[ 2 ] = "c:\bugs1.doc"

ls_resolution = "High"


//This is the start of the DDE 
//to WinFax. Create the link and
//disable automatic reception in WinFax.

ChanNum = OpenChannel("FAXMNG32", "CONTROL")
//ChanNum = DDEInitiate("FAXMNG32", "CONTROL")

ExecRemote("GoIdle", ChanNum )
//DDEExecute(ChanNum, "GoIdle")

CloseChannel (ChanNum)
//DDETerminate ChanNum


//'Create a new link with the TRANSMIT topic.
ChanNum = OpenChannel ("FAXMNG32", "TRANSMIT")

//set recipient
iRC = SetRemote ( "Sendfax", "recipient(" + sQ + ls_fax_number + sQ + "," + sQ + ls_time + sQ + "," + sQ + ls_date + sQ + "," + sQ + ls_recipient + sQ + "," + sQ + ls_company + sQ + "," + sQ + ls_subject + sQ + "," + sQ + "" + sQ + "," + sQ + "" + sQ + "," + sQ + "" + sQ + ")", ChanNum )

//'setcoverpage
iRC = SetRemote ( "Sendfax", "setcoverpage(" + sQ + "C:\Program Files\WinFax\Cover\Stars.cvp" + sQ + ")", ChanNum )

//'fillcoverpage
iRC = SetRemote ( "Sendfax", "fillcoverpage(" + sQ + ls_cover_text + sQ + ")", ChanNum )
//DDEPoke ChanNum, "sendfax", "fillcoverpage(" + sQ + "Please send comments by Friday noon." + sQ + ")"

//'attach
FOR a = 1 TO UpperBound( ls_attachments[] )
	iRC = SetRemote ( "Sendfax", "attach(" + sQ + ls_attachments[a] + sQ + ")", ChanNum )
END FOR

//DDEPoke ChanNum, "sendfax", "attach(" + sQ + "C:\WINFAX\DATA\ATTACH.FXS" + sQ + ")"

//showsendscreen
iRC = SetRemote ( "Sendfax", "showsendscreen(" + sQ + "0" + sQ + ")", ChanNum )
//DDEPoke ChanNum, "sendfax", "showsendscreen(" + sQ + "0" + sQ + ")"

//resolution
iRC = SetRemote ( "Sendfax", "resolution(" + sQ + ls_resolution + sQ + ")", ChanNum )
//DDEPoke ChanNum, "sendfax", "resolution(" + sQ + "HIGH" + sQ + ")"

//'Tell WinFax to send the fax.
iRC = SetRemote ( "Sendfax", "SendfaxUI", ChanNum )

CloseChannel (ChanNum)
//DDETerminate ChanNum

ChanNum = OpenChannel ("FAXMNG32", "CONTROL")
//ChanNum = DDEInitiate("FAXMNG32", "CONTROL")

ExecRemote("GoActive", ChanNum )
//DDEExecute(ChanNum, "GoActive")

//'Close the link between the applications.
CloseChannel (ChanNum)
//DDETerminate ChanNum



end event

type cb_1 from commandbutton within w_test_fax
integer x = 384
integer y = 140
integer width = 809
integer height = 300
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "fax"
end type

event clicked;/////////////////////////////////////////////////////////////////////
//Description: Used to fax missing information letters to practitioners
//
//Called From: The ue_fax_missing event is triggered from the
//					m_wip_menu menu and that event calls this function
//Arguments: None
//Function Calls: None
//Return Value: -1 If Failed
//Global Variables: gphonepfx (Holds the phone prefix for dialing out)
/////////////////////////////////////////////////////////////////////


datetime rd
date ld_date
Long hWinHandle = 0
INT li_row_count, li_attach_count, x1
int iJob, iRC, currentrow, totalretrieved, tr, l, I, totalfaxes, loops, rowfound[], count , rqst
string sCurrentPrinter, docname, apptype
string sQ = "~"", sStringToFax = "", srecipient, sPhoneNumber, sAttachment
string sWinFaxDriver = "Winfax,WinFax,FaxModem", prac_id
string sPerson, sResolution = "HIGH", sCoverPageText
string sFaxTime = "", sFaxDate = "", ls_customer_number, ls_time, ls_action, ls_contact



sFaxTime = String(Now())
sFaxDate = String(Today())


//dw_fax_cover.SetTransObject(SQLCA)

SetPointer (Hourglass!)

//Run ("c:\WINFAX\faxmng.exe", MINIMIZED!)

//____________________________________________________________________
// General format of DDEPoke:
// "Sendfax", "recipient("97545143","11:11:11","12/12/94","Mr Folleras","IPPC")"
//
// If a coverpage is desired, use the DDE call below:
//
//iRC = SetRemote ("Sendfax", "fillcoverpage(~""+CoverPageText+"~")", hWinHandle)
//____________________________________________________________________

sStringToFax = ""
//sCurrentPrinter = ProfileString ("C:\WINNT\WIN.INI", "windows", "device", "none")
//SetProfileString ("C:\WINDOWS\WIN.INI", "windows", "device", sWinfaxDriver)

//sCurrentPrinter = ProfileString ("C:\WINNT\WIN.INI", "windows", "device", "none")
//SetProfileString ("C:\WINDOWS\WIN.INI", "windows", "device", sWinfaxDriver)

//dw_letter.AcceptText()

//li_row_count= dw_letter.RowCount()

//FOR i = 1 TO li_row_count

debugbreak()
	sphonenumber = "603-888-7984"

	sRecipient  =  "IntelliSoft Group Inc" //dw_letter.GetItemString(i, "customer_name")

	sPerson		=  "John D'Amelio " // dw_letter.GetItemString(i, "contact")

	//CloseChannel (hWinHandle)

	hWinHandle = OpenChannel ("FAXMNG32", "TRANSMIT")
	//messagebox("", hwinhandle )
	IF hWinHandle <= 0 THEN
		MessageBox("","error" )
	ELSE
		MessageBox("", "Got Handle" )
	END IF
	
	//DDEPoke ChanNum, "sendfax", "recipient(" + sQ + "555-1212" + sQ + "," + sQ + "12:00:00" + sQ + "," + sQ + "05/04/97" + sQ + "," + sQ + "Aiden Krup" + sQ + "," + sQ + "F. B. Marketing Co." + sQ + "," + sQ + "Sales" + sQ + "," + sQ + "Sales" + sQ + "," + sQ + "Billing Code 08" + sQ + "," + sQ + "Fax" + sQ + ")"

	
	//messagebox("", "recipient(" + sQ + "555-1212" + sQ + "," + sQ + "12:00:00" + sQ + "," + sQ + "05/04/97" + sQ + "," + sQ + "Aiden Krup" + sQ + "," + sQ + "F. B. Marketing Co." + sQ + "," + sQ + "Sales" + sQ + "," + sQ + "Sales" + sQ + "," + sQ + "Billing Code 08" + sQ + "," + sQ + "Fax" + sQ + ")")
	iRC = SetRemote( "sendfax", "recipient(" + sQ + "555-1212" + sQ + "," + sQ + "12:00:00" + sQ + "," + sQ + "05/04/97" + sQ + "," + sQ + "Aiden Krup" + sQ + "," + sQ + "F. B. Marketing Co." + sQ + "," + sQ + "Sales" + sQ + "," + sQ + "Sales" + sQ + "," + sQ + "Billing Code 08" + sQ + "," + sQ + "Fax" + sQ + ")" , hWinHandle)
	
	//iRC = SetRemote ("sendfax", "recipient("+sQ+sPhoneNumber+sQ+","+sQ +sFaxTime+sQ+","+sQ+sFaxDate+sQ+","+sQ+sPerson+sQ+","+sQ+sRecipient+sQ+")", hWinHandle)
	
	if iRC <> 1 then
		MessageBox ("Fax Error", "Error setting remote and generating fax!",StopSign!)
		CloseChannel (hWinHandle)	
		//sCurrentPrinter = ProfileString ("C:\WINDOWS\WIN.INI", "windows", "device", "none")
		//SetProfileString ("C:\WINDOWS\WIN.INI", "windows", "device", sWinfaxDriver)
		return -1
	end if

	iRC = SetRemote ("Sendfax", "showsendscreen(~"0~")", hWinHandle)

	if iRC <> 1 then
		MessageBox ("Fax Error", "Error hiding send-screen and generating fax!",StopSign!)
		CloseChannel (hWinHandle)
		//sCurrentPrinter = ProfileString ("C:\WINDOWS\WIN.INI", "windows", "device", "none")
		//SetProfileString ("C:\WINDOWS\WIN.INI", "windows", "device", sWinfaxDriver)
		return -1
	end if

	iRC = SetRemote ("Sendfax", "resolution(~""+sResolution+"~")", hWinHandle)

	if iRC <> 1 then
		MessageBox ("Fax Error", "Error in setting resolution and generating fax!",StopSign!)
		CloseChannel (hWinHandle)
		//sCurrentPrinter = ProfileString ("C:\WINDOWS\WIN.INI", "windows", "device", "none")
		//SetProfileString ("C:\WINDOWS\WIN.INI", "windows", "device", sWinfaxDriver)
		return -1
	end if
	
	
	sAttachment = gs_dir_path + "IntelliCred\fax\fax_1.doc"
	iRC = SetRemote( "Sendfax", "attach(~"" + sAttachment+ "~")",hWinHandle)	

//	li_attach_count = dw_attachments.RowCount()
//	FOR x1 = 1 to li_attach_count
//		sAttachment = dw_attachments.GetItemString(x1, "file_name")
//		//MESSAGEBOX("","attach(~"" + sAttachment+ "~")")
//		iRC = SetRemote( "Sendfax", "attach(~"" + sAttachment+ "~")",hWinHandle)
//		if iRC <> 1 then
//			MessageBox ("Fax Error", "Error in adding attachments and generating fax!",StopSign!)
//			CloseChannel (hWinHandle)
//			//sCurrentPrinter = ProfileString ("C:\WINDOWS\WIN.INI", "windows", "device", "none")
//			//SetProfileString ("C:\WINDOWS\WIN.INI", "windows", "device", sWinfaxDriver)
//			return -1
//		end if
//	END FOR
//	
	//li_row_count = dw_fax_cover.Retrieve(dw_letter.GetItemString(i, "customer_number"))
	//dw_fax_cover.SetItem(1, "notes", mle_notes.Text)
	//dw_fax_cover.Print()

	//iRC = SetRemote ("Sendfax", "fillcoverpage(~""+SCoverPageText+"~")", hWinHandle)

	//ls_customer_number = dw_letter.GetItemString(i, "customer_number")
	//ls_time = String(Now())
	//ls_action = "Faxed Document"
	//ls_contact = dw_letter.GetItemString(i, "contact")
	//ld_date = Today()
  	 
	  
CloseChannel (hWinHandle)
//DDETerminate ChanNum

hWinHandle = OpenChannel ("FAXMNG32", "CONTROL")
//ChanNum = DDEInitiate("FAXMNG32", "CONTROL")

ExecRemote("GoActive", hWinHandle )
//DDEExecute(ChanNum, "GoActive")

//'Close the link between the applications.
CloseChannel (hWinHandle)
//DDETerminate ChanNum


	  
	 
//END FOR

//SetProfileString ("C:\WINDOWS\WIN.INI", "windows", "device", sCurrentPrinter)
//SetPointer (Arrow!)

return 1



end event

