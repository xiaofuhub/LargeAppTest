$PBExportHeader$n_cst_ocr.sru
forward
global type n_cst_ocr from nonvisualobject
end type
end forward

global type n_cst_ocr from nonvisualobject autoinstantiate
end type

type variables

end variables

forward prototypes
public function integer of_tif2text (string as_filename, ref string as_text)
public function integer of_waitoutputcomplete (string as_filename)
end prototypes

public function integer of_tif2text (string as_filename, ref string as_text);blob lblb_Data
string ls_OutputFile
boolean lb_Result
w_ocr_control lw_window
n_cst_filesrvwin32 lnv_FileSvr

// Return -1 if have no install Image 360 control
if gi_imageocx <> 1 then Return -1

// Get output file path
ls_OutputFile = gs_dir_path + gs_DefDirName + "\ocr_text_temp.txt"
FileDelete(ls_OutputFile)

// Convert TIF to text
try
	// Open progress bar
	OpenWithParm(w_appeon_gifofwait, "OCRing..." )
	Timer(0, w_appeon_gifofwait)
	w_appeon_gifofwait.of_SetMaxPosition(100)
	w_appeon_gifofwait.of_SetMinPosition(0)
	w_appeon_gifofwait.of_SetPosition(0)
	
	// Output text file
	Open(lw_window, "w_ocr_control")
	lw_window.ole_ocr.object.Image = as_FileName
	lw_window.ole_ocr.object.OutputFile = ls_OutputFile
	lw_window.ole_ocr.object.OutputType = 4
	lw_window.ole_ocr.object.ProgressNotification = true
	lw_window.ole_ocr.object.ShowProgress = false
	lw_window.ole_ocr.object.LaunchApplication = false
	lb_Result = lw_window.ole_ocr.object.StartOcr()
	if lb_Result = true then
		of_WaitOutputComplete(ls_OutputFile)
	else
		Close(w_appeon_gifofwait)
		Return -1
	end if
		
	// Read text to as_Text
	lnv_FileSvr = Create n_cst_filesrvwin32
	lnv_FileSvr.of_FileRead(ls_OutputFile, lblb_Data)
	//as_Text = String(lblb_Data)
	as_Text = String(lblb_Data, EncodingAnsi!) //Encoding – Harry 11.14.2013
	FileDelete(ls_OutputFile)
	
	// Destroy objects
	Destroy lnv_FileSvr
	Close(lw_window)
	Close(w_appeon_gifofwait)
catch (RuntimeError e)
	Return -1
end try

Return 1
end function

public function integer of_waitoutputcomplete (string as_filename);integer li_FileNum

do 
	Yield()
	if FileExists(as_FileName) then
		li_FileNum = FileOpen(as_FileName, StreamMode!)
	else
		li_FileNum = -1
	end if
loop while li_FileNum = -1

FileClose(li_FileNum)
		
Return 1
end function

on n_cst_ocr.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_ocr.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

