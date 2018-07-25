$PBExportHeader$w_import_viewdoc.srw
forward
global type w_import_viewdoc from window
end type
type ole_doc from u_office_ocx within w_import_viewdoc
end type
end forward

global type w_import_viewdoc from window
integer width = 3003
integer height = 1712
boolean titlebar = true
string title = "View Document"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 32891346
string icon = "AppIcon!"
boolean center = true
ole_doc ole_doc
end type
global w_import_viewdoc w_import_viewdoc

type prototypes
FUNCTION long ShellExecute(long hwnd, string lpOperation, string lpFile, string lpParameters, string lpDirectory, long nShowCmd) LIBRARY "shell32.dll"  ALIAS FOR "ShellExecuteA;Ansi"
end prototypes

forward prototypes
public function blob of_downloadfile (long al_importid)
public function integer of_writefile (ref string as_filename, string as_filetype, ref blob ablb_data)
end prototypes

public function blob of_downloadfile (long al_importid);blob lb_data
blob lb_all_data
long ll_data_length
long ll_start
long ll_counter
long ll_loops

If gs_dbtype = "ASA" Or appeongetclienttype() <> 'PB' Then		
	SELECTBLOB import_doc INTO :lb_all_data
	FROM import_hdr
	WHERE import_id = :al_ImportID;
Else			
	SELECT DataLength(import_doc) INTO :ll_data_length
	FROM import_hdr
	WHERE import_id = :al_ImportID;
	
	If isnull(ll_data_length) Then ll_data_length = 0
	
	If ll_data_length > 8000 Then 
		If Mod(ll_data_length,8000) = 0 Then
			ll_loops = ll_data_length / 8000 
		Else
			ll_loops = (ll_data_length / 8000) + 1
		End If 
	ElseIf ll_data_length > 0 Then 
		ll_loops = 1 
	End If 
	
	For ll_counter = 1 To ll_loops			
		ll_start = (ll_counter - 1) * 8000 + 1
		SELECTBLOB substring(import_doc,:ll_start,8000) INTO :lb_data
		FROM import_hdr
		WHERE import_id = :al_ImportID;			
		lb_all_data += lb_data
	Next
End If
If isnull(lb_all_data) Then lb_all_data = blob('',EncodingAnsi!) //Encoding – Nova 11.16.2010

Return lb_all_data
end function

public function integer of_writefile (ref string as_filename, string as_filetype, ref blob ablb_data);blob lblb_Buf
long ll_BlobLen
long ll_CurrentPos
long l, ll_Writes
integer li_FileNum
string ls_ImportDirectory
n_cst_import lnv_import

lnv_import = Create n_cst_import
ls_ImportDirectory = lnv_import.of_GetImportDir()
Destroy lnv_import
choose case Lower(as_FileType)
	case "doc"
		as_FileName = ls_ImportDirectory + "\Document temp.doc"
	case "xls"
		as_FileName = ls_ImportDirectory + "\Document temp.xls"
	case "txt"
		as_FileName = ls_ImportDirectory + "\Document temp.txt"
end choose

li_FileNum = FileOpen(as_FileName, StreamMode!, Write!, LockReadWrite!, Replace!)
if li_FileNum < 0 then Return -1
ll_BlobLen = LenA(ablb_Data)

if ll_BlobLen > 32765 then
	 if Mod(ll_BlobLen, 32765) = 0 then
		 ll_Writes = ll_BlobLen / 32765
	 else
		 ll_Writes = (ll_BlobLen / 32765) + 1
	 end if
else
	ll_Writes = 1
end if
ll_CurrentPos = 1

For l = 1 To ll_Writes
	lblb_Buf = BlobMid(ablb_Data, ll_CurrentPos, 32765)
	ll_CurrentPos += 32765
	if FileWrite(li_FileNum, lblb_Buf) = -1 then
	 	Return -1
	end if
Next
FileClose(li_FileNum)

Return 1
end function

on w_import_viewdoc.create
this.ole_doc=create ole_doc
this.Control[]={this.ole_doc}
end on

on w_import_viewdoc.destroy
destroy(this.ole_doc)
end on

event open;string ls_DocPath
string ls_DocName
string ls_FileType
integer li_Pos
long ll_ImportID
blob lblb_Data
n_cst_dm_utils lnv_utils

gnv_reg_ocx.of_check_ocx( 1,'', True) //1: office //Added by Ken.Guo on 2008-11-06

li_Pos = PosA(Message.StringParm, "|")
ll_ImportID = Long(LeftA(Message.StringParm, li_Pos - 1))
ls_DocName = RightA(Message.StringParm, LenA(Message.StringParm) - li_Pos)
ls_FileType = lnv_utils.of_get_fileext(ls_DocName)

OpenWithParm(w_appeon_gifofwait, "Opening the document..." )
lblb_Data = of_DownLoadFile(ll_ImportID)
of_WriteFile(ls_DocPath, ls_FileType, lblb_Data)

choose case Lower(ls_FileType)
	//case "doc", "xls"		
	case "doc", "docx", "xls"	 //V12.2 usage of docx - alfee 07.05.2012					
		Try
			ole_doc.object.Caption = ls_DocName
			ole_doc.object.OpenLocalFile(ls_DocPath , true)
			//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
			gnv_word_utility.of_modify_word_property( ole_doc.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
			//---------End Added ------------------------------------------------------	
		Catch (RunTimeError e)
			If Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
			MessageBox('Error', 'The Office Viewer Active X Control has failed.')			
			Close(this)
			Return
		End Try
		If Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
		
	case else
		ShellExecute(0, "open", ls_DocPath, "","", 1)
		If Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
		Close(this)
		Return
end choose
end event

event resize;ole_doc.Move(0, 0)
ole_doc.Resize(Width - 50, Height - 150)

end event

type ole_doc from u_office_ocx within w_import_viewdoc
integer width = 2949
integer height = 1584
integer taborder = 30
borderstyle borderstyle = stylebox!
string binarykey = "w_import_viewdoc.win"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
08w_import_viewdoc.bin 
2D00000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000f9b6582001d130f600000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d300000000f9b6582001d130f6f9b6582001d130f60000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd000042aa000028ee00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd000042aa000028ee00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
18w_import_viewdoc.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
