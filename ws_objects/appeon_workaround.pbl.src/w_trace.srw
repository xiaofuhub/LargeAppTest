$PBExportHeader$w_trace.srw
forward
global type w_trace from window
end type
type cbx_dbcalls from checkbox within w_trace
end type
type cbx_current from checkbox within w_trace
end type
type cb_all from commandbutton within w_trace
end type
type cb_default from commandbutton within w_trace
end type
type cbx_garbagecoll from checkbox within w_trace
end type
type cbx_systemerrors from checkbox within w_trace
end type
type cbx_userdefined from checkbox within w_trace
end type
type cbx_objectcreate from checkbox within w_trace
end type
type cbx_embeddedsql from checkbox within w_trace
end type
type cbx_routineentry from checkbox within w_trace
end type
type cbx_routineline from checkbox within w_trace
end type
type rb_thread from radiobutton within w_trace
end type
type rb_process from radiobutton within w_trace
end type
type rb_clock from radiobutton within w_trace
end type
type rb_none from radiobutton within w_trace
end type
type sle_tracelabel from singlelineedit within w_trace
end type
type st_2 from statictext within w_trace
end type
type cb_1 from commandbutton within w_trace
end type
type cbx_prompt from checkbox within w_trace
end type
type st_1 from statictext within w_trace
end type
type sle_filename from singlelineedit within w_trace
end type
type gb_1 from groupbox within w_trace
end type
type gb_2 from groupbox within w_trace
end type
type cb_result from commandbutton within w_trace
end type
type ov_state from oval within w_trace
end type
type cb_startstop from commandbutton within w_trace
end type
type cb_exit from commandbutton within w_trace
end type
end forward

global type w_trace from window
integer width = 1367
integer height = 1524
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cbx_dbcalls cbx_dbcalls
cbx_current cbx_current
cb_all cb_all
cb_default cb_default
cbx_garbagecoll cbx_garbagecoll
cbx_systemerrors cbx_systemerrors
cbx_userdefined cbx_userdefined
cbx_objectcreate cbx_objectcreate
cbx_embeddedsql cbx_embeddedsql
cbx_routineentry cbx_routineentry
cbx_routineline cbx_routineline
rb_thread rb_thread
rb_process rb_process
rb_clock rb_clock
rb_none rb_none
sle_tracelabel sle_tracelabel
st_2 st_2
cb_1 cb_1
cbx_prompt cbx_prompt
st_1 st_1
sle_filename sle_filename
gb_1 gb_1
gb_2 gb_2
cb_result cb_result
ov_state ov_state
cb_startstop cb_startstop
cb_exit cb_exit
end type
global w_trace w_trace

type variables
TimerKind itk_kind 
string is_title = 'Trace Options. Version 1.0.2' 
string is_starttext
string is_lastpath = "c:\"

end variables

forward prototypes
public function string of_converterror (errorreturn a_error)
public subroutine of_errmsg (errorreturn ae_error, string as_msg)
public subroutine wf_modifyhistory ()
end prototypes

public function string of_converterror (errorreturn a_error);// of_converterror: convert enumerated type  
// ErrorReturn parameter to text. 
String ls_result 
choose case a_error    
	Case Success!       
		ls_result =  "Success!"    
	Case FileCloseError!       
		ls_result =  "FileCloseError!"    
	Case FileOpenError!       
		ls_result =  "FileOpenError!"    
	Case FileReadError!       
		ls_result =  "FileReadError!"    
	Case FileWriteError!       
		ls_result =  "FileWriteError!"    
	Case FileNotOpenError!       
		ls_result =  "FileNotOpenError!"    
	Case FileAlreadyOpenError!       
		ls_result =  "FileAlreadyOpenError!"    
	Case FileInvalidFormatError!       
		ls_result =  "FileInvalidFormatError!"    
	Case FileNotSetError!       
		ls_result =  "FileNotSetError!"    
	Case EventNotExistError!       
		ls_result =  "EventNotExistError!"    
	Case EventWrongPrototypeError!       
		ls_result =  "EventWrongPrototypeError!"    
	Case ModelNotExistsError!       
		ls_result =  "ModelNotExistsError!"    
	Case ModelExistsError!       
		ls_result =  "ModelExistsError!"    
	Case TraceStartedError!       
		ls_result =  "TraceStartedError!"    
	Case TraceNotStartedError!       
		ls_result =  "TraceNotStartedError!"    
	Case TraceNoMoreNodes!       
		ls_result =  "TraceNoMoreNodes!"    
	Case TraceGeneralError!       
		ls_result =  "TraceGeneralError!"    
	Case FeatureNotSupportedError!       
		ls_result =  "FeatureNotSupportedError!"   
	Case else       
		ls_result =  "Unknown Error Code" 
	end choose 
	return ls_result 

end function

public subroutine of_errmsg (errorreturn ae_error, string as_msg);Messagebox( this.title,'Error executing '+ as_msg + '. Error code : '+ of_converterror(ae_error) ) 
end subroutine

public subroutine wf_modifyhistory ();
/* 
 * Modify history:
 * 2006-10-25, rainman
 * Fix bugs
 * 1. Fix the bug that can not detect datawindowchild retrieve()
 * 2. Fix the bug that can not detect datawindow update()
 */

end subroutine

on w_trace.create
this.cbx_dbcalls=create cbx_dbcalls
this.cbx_current=create cbx_current
this.cb_all=create cb_all
this.cb_default=create cb_default
this.cbx_garbagecoll=create cbx_garbagecoll
this.cbx_systemerrors=create cbx_systemerrors
this.cbx_userdefined=create cbx_userdefined
this.cbx_objectcreate=create cbx_objectcreate
this.cbx_embeddedsql=create cbx_embeddedsql
this.cbx_routineentry=create cbx_routineentry
this.cbx_routineline=create cbx_routineline
this.rb_thread=create rb_thread
this.rb_process=create rb_process
this.rb_clock=create rb_clock
this.rb_none=create rb_none
this.sle_tracelabel=create sle_tracelabel
this.st_2=create st_2
this.cb_1=create cb_1
this.cbx_prompt=create cbx_prompt
this.st_1=create st_1
this.sle_filename=create sle_filename
this.gb_1=create gb_1
this.gb_2=create gb_2
this.cb_result=create cb_result
this.ov_state=create ov_state
this.cb_startstop=create cb_startstop
this.cb_exit=create cb_exit
this.Control[]={this.cbx_dbcalls,&
this.cbx_current,&
this.cb_all,&
this.cb_default,&
this.cbx_garbagecoll,&
this.cbx_systemerrors,&
this.cbx_userdefined,&
this.cbx_objectcreate,&
this.cbx_embeddedsql,&
this.cbx_routineentry,&
this.cbx_routineline,&
this.rb_thread,&
this.rb_process,&
this.rb_clock,&
this.rb_none,&
this.sle_tracelabel,&
this.st_2,&
this.cb_1,&
this.cbx_prompt,&
this.st_1,&
this.sle_filename,&
this.gb_1,&
this.gb_2,&
this.cb_result,&
this.ov_state,&
this.cb_startstop,&
this.cb_exit}
end on

on w_trace.destroy
destroy(this.cbx_dbcalls)
destroy(this.cbx_current)
destroy(this.cb_all)
destroy(this.cb_default)
destroy(this.cbx_garbagecoll)
destroy(this.cbx_systemerrors)
destroy(this.cbx_userdefined)
destroy(this.cbx_objectcreate)
destroy(this.cbx_embeddedsql)
destroy(this.cbx_routineentry)
destroy(this.cbx_routineline)
destroy(this.rb_thread)
destroy(this.rb_process)
destroy(this.rb_clock)
destroy(this.rb_none)
destroy(this.sle_tracelabel)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.cbx_prompt)
destroy(this.st_1)
destroy(this.sle_filename)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.cb_result)
destroy(this.ov_state)
destroy(this.cb_startstop)
destroy(this.cb_exit)
end on

event open;application lapp_current 
lapp_current = getapplication() 
itk_kind = Clock! 
this.title = this.is_title
is_starttext = cb_startstop.text 
sle_filename.text = is_lastpath + classname(lapp_current)+'.pbp'

//cb_startstop.triggerevent('clicked')
end event

type cbx_dbcalls from checkbox within w_trace
integer x = 18
integer y = 1208
integer width = 823
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Only show database calls"
boolean checked = true
end type

type cbx_current from checkbox within w_trace
integer x = 18
integer y = 1284
integer width = 823
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Analyse the current trace file"
boolean checked = true
end type

type cb_all from commandbutton within w_trace
integer x = 882
integer y = 788
integer width = 293
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&All"
end type

event clicked;cbx_routineline.checked = true
cbx_routineentry.checked = true
cbx_embeddedsql.checked = true
cbx_objectcreate.checked = true
cbx_userdefined.checked = true
cbx_systemerrors.checked = true
cbx_garbagecoll.checked = true

end event

type cb_default from commandbutton within w_trace
integer x = 882
integer y = 688
integer width = 293
integer height = 88
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Default"
end type

event clicked;cbx_routineline.checked = true
cbx_routineentry.checked = false
cbx_embeddedsql.checked = true
cbx_objectcreate.checked = false
cbx_userdefined.checked = false
cbx_systemerrors.checked = false
cbx_garbagecoll.checked = true

end event

type cbx_garbagecoll from checkbox within w_trace
integer x = 119
integer y = 1092
integer width = 590
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "&Garbage Collection"
boolean checked = true
end type

type cbx_systemerrors from checkbox within w_trace
integer x = 119
integer y = 1020
integer width = 462
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "System &Errors"
end type

type cbx_userdefined from checkbox within w_trace
integer x = 119
integer y = 948
integer width = 667
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "&User Defined Activities"
end type

type cbx_objectcreate from checkbox within w_trace
integer x = 119
integer y = 876
integer width = 795
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Object &Creation/Destruction"
end type

type cbx_embeddedsql from checkbox within w_trace
integer x = 119
integer y = 804
integer width = 507
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Embedded &SQL"
boolean checked = true
end type

type cbx_routineentry from checkbox within w_trace
integer x = 119
integer y = 732
integer width = 539
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Routine Line &Hits"
end type

type cbx_routineline from checkbox within w_trace
integer x = 119
integer y = 660
integer width = 549
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Routine Entry/Exit"
boolean checked = true
end type

type rb_thread from radiobutton within w_trace
integer x = 919
integer y = 428
integer width = 343
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Thread"
end type

event clicked;if rb_thread.checked then itk_kind = Thread!

end event

type rb_process from radiobutton within w_trace
integer x = 594
integer y = 428
integer width = 343
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Process"
end type

event clicked;if rb_process.checked then itk_kind = Process!

end event

type rb_clock from radiobutton within w_trace
integer x = 329
integer y = 428
integer width = 343
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Clock"
boolean checked = true
end type

event clicked;
if rb_clock.checked then itk_kind = Clock!

end event

type rb_none from radiobutton within w_trace
integer x = 73
integer y = 428
integer width = 343
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "None"
end type

event clicked;if rb_none.checked then itk_kind = TimerNone!    


end event

type sle_tracelabel from singlelineedit within w_trace
integer x = 18
integer y = 252
integer width = 1161
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_trace
integer x = 23
integer y = 192
integer width = 343
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Trace Label"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_trace
integer x = 1184
integer y = 96
integer width = 137
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "..."
end type

event clicked;string docpath, docname
integer li_rtn

li_rtn = GetFileSaveName("Select File", docpath, docname, "pbp",  + "PowerBuilder Profile(*.pbp), *.pbp," + "All Files (*.*), *.*", is_lastpath, 32770)

IF li_rtn < 1 THEN return

if li_rtn = 1 then
	is_lastpath =  string(docpath)
 	sle_filename.text = string(docpath)
end if

end event

type cbx_prompt from checkbox within w_trace
integer x = 608
integer y = 24
integer width = 581
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prompt for Overwrite"
end type

type st_1 from statictext within w_trace
integer x = 23
integer y = 36
integer width = 425
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Trace File Name"
boolean focusrectangle = false
end type

type sle_filename from singlelineedit within w_trace
integer x = 18
integer y = 96
integer width = 1161
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;is_lastpath = this.text

end event

type gb_1 from groupbox within w_trace
integer x = 18
integer y = 344
integer width = 1307
integer height = 224
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Timer Kind"
end type

type gb_2 from groupbox within w_trace
integer x = 18
integer y = 576
integer width = 1307
integer height = 624
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Trace Activities"
end type

type cb_result from commandbutton within w_trace
integer x = 18
integer y = 1344
integer width = 421
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Analysis &Result"
end type

event clicked;is_lastpath = sle_filename.text
if cbx_current.checked then
	openwithparm(w_traceanalysis,is_lastpath)
else
	openwithparm(w_traceanalysis,"")
end if

end event

type ov_state from oval within w_trace
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 134217857
integer x = 581
integer y = 1360
integer width = 78
integer height = 72
end type

type cb_startstop from commandbutton within w_trace
integer x = 667
integer y = 1344
integer width = 357
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Start &Trace"
boolean default = true
end type

event clicked;// instance variables: 
errorreturn le_errorreturn 
Integer li_key

//Set the file path
is_lastpath = parent.sle_filename.text

// Check that the button label is Start Trace 
// and a trace file name has been entered 
If This.Text = is_starttext Then
	If Len(Trim(sle_filename.Text)) = 0 Then
		MessageBox(Parent.Title, 'Trace file name is required',information!)
		sle_filename.SetFocus()
		Return
	End If
	// If Prompt for overwrite is checked and the    
	// file exists, pop up a response window    
	If cbx_prompt.Checked And FileExists(sle_filename.Text) Then
		li_key = MessageBox(Parent.Title, 'Are you willing to overwrite '+sle_filename.Text + "?", question!,okcancel!,1)
		If li_key = 2 Then
			Return
		End If
	end if

	// Open the trace file    
	TraceOpen( sle_filename.Text, itk_kind )
	// Enable tracing for checked activities    
	// For each activity, check for errors and close    
	// the trace file if an error occurs    
	If cbx_embeddedsql.Checked Then
		le_errorreturn = TraceEnableActivity( ActESql! )
		If le_errorreturn <> Success! Then
			of_errmsg(le_errorreturn, 'TraceEnableActivity( ActESql! )')
			le_errorreturn = Traceclose()
			If le_errorreturn <> Success! Then
				of_errmsg(le_errorreturn,'TraceClose')
			End If
			Return
		End If
	End If
	If cbx_routineentry.Checked Then
		le_errorreturn = TraceEnableActivity(ActRoutine!)
		If le_errorreturn <> Success! Then
			of_errmsg(le_errorreturn, 'TraceEnableActivity( ActRoutine! )')
			Traceclose()
			If le_errorreturn <> Success! Then
				of_errmsg(le_errorreturn,'TraceClose')
			End If
			Return
		End If
	End If
	If cbx_userdefined.Checked Then
		le_errorreturn = TraceEnableActivity( ActUser! )
		If le_errorreturn <> Success! Then
			of_errmsg(le_errorreturn,'TraceEnableActivity( ActUser! )')
			Traceclose()
			If le_errorreturn <> Success! Then
				of_errmsg(le_errorreturn,'TraceClose')
			End If
			Return
		End If
	End If
	If cbx_systemerrors.Checked Then
		le_errorreturn = TraceEnableActivity(ActError! )
		If le_errorreturn <> Success! Then
			of_errmsg(le_errorreturn,'TraceEnableActivity( ActError! )')
			Traceclose()
			If le_errorreturn <> Success! Then
				of_errmsg(le_errorreturn,'TraceClose')
			End If
			Return
		End If
	End If
	If cbx_routineline.Checked Then
		le_errorreturn = TraceEnableActivity( ActLine! )
		If le_errorreturn <> Success! Then
			of_errmsg(le_errorreturn, ' TraceEnableActivity( ActLine! )')
			Traceclose()
			If le_errorreturn <> Success! Then
				of_errmsg(le_errorreturn,'TraceClose')
			End If
			Return
		End If
	End If
	If cbx_objectcreate.Checked Then
		le_errorreturn = TraceEnableActivity( ActObjectCreate! )
		If le_errorreturn <> Success! Then
			of_errmsg(le_errorreturn,  'TraceEnableActivity( ActObject! )')
			Traceclose()
			If le_errorreturn <> Success! Then
				of_errmsg(le_errorreturn,'TraceClose')
			End If
			Return
		End If
		le_errorreturn = TraceEnableActivity( ActObjectDestroy! )
		If le_errorreturn <> Success! Then
			of_errmsg(le_errorreturn,  'TraceEnableActivity(ActObjectDestroy!)')
			Traceclose()
			If le_errorreturn <> Success! Then
				of_errmsg(le_errorreturn,'TraceClose')
			End If
			Return      
		End If  
	End If   
	If cbx_garbagecoll.Checked Then     
		le_errorreturn =  TraceEnableActivity( ActGarbageCollect! )   
		If le_errorreturn <> Success! Then      
			of_errmsg(le_errorreturn,  'TraceEnableActivity(ActGarbageCollect! )')     
			Traceclose()       
			If le_errorreturn <> Success! Then    
				of_errmsg(le_errorreturn,'TraceClose')   
			End If     
			Return     
		End If   
	End If
	// Start tracing    
	le_errorreturn =TraceBegin( sle_tracelabel.text )    
	ov_state.FillColor = rgb(0,255,0)
	if le_errorreturn <> Success! then     
		of_errmsg(le_errorreturn,'TraceBegin') 
		return  
	end if       
	// Change the title of the window and the  
	// text of the Start Trace button   
	parent.title = is_title + '(Tracing)'   
	this.text = 'Stop &Tracing' 
	// If the button label is Stop Trace, stop tracing 
	// and close the trace file 
else    
	le_errorreturn =TraceEnd()  
	if le_errorreturn <> Success! then   
		of_errmsg(le_errorreturn,'TraceEnd')   
		return    
	end if    
	le_errorreturn =TraceClose()    
	if le_errorreturn <> Success! then   
		of_errmsg(le_errorreturn,'TraceClose')  
	end if   
	ov_state.FillColor = rgb(255,0,0)
	this.text = is_starttext  
	parent.title = is_title 
end if
end event

type cb_exit from commandbutton within w_trace
integer x = 1033
integer y = 1344
integer width = 293
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "E&xit"
boolean cancel = true
end type

event clicked;close(parent)
end event

