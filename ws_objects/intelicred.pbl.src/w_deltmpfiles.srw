$PBExportHeader$w_deltmpfiles.srw
forward
global type w_deltmpfiles from window
end type
type lb_files from listbox within w_deltmpfiles
end type
end forward

global type w_deltmpfiles from window
boolean visible = false
integer width = 2505
integer height = 1384
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
lb_files lb_files
end type
global w_deltmpfiles w_deltmpfiles

on w_deltmpfiles.create
this.lb_files=create lb_files
this.Control[]={this.lb_files}
end on

on w_deltmpfiles.destroy
destroy(this.lb_files)
end on

event open;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-07 By: Scofield
//$<Reason> Clean up the temporary files
Integer	li_IntervalDays,li_FileCount,li_Cycle
String	ls_LastClrDate,ls_ClrDir,ls_Type,ls_FileName,ls_Path
Date		ld_LastDate,ld_Today
long		ll_DiffDays

li_IntervalDays = ProfileInt(gs_IniFilePathName,"Setup","Interval_Days",30)
if li_IntervalDays = 0 then return

ls_LastClrDate = ProfileString(gs_IniFilePathName,"Setup","Last_Clear_Date",String(Today(),"YYYY/MM/DD"))
ld_LastDate = Date(ls_LastClrDate)
ld_Today = Today()
ll_DiffDays = DaysAfter(ld_LastDate,ld_Today)

if ll_DiffDays < li_IntervalDays then return

ls_ClrDir = gs_temp_path + "Agreement\Manager"
ls_Type = ls_ClrDir + "\*.*"
lb_files.DirList(ls_Type,0)
li_FileCount = lb_files.TotalItems()

for li_Cycle = 1 to li_FileCount
	ls_FileName = lb_files.Text(li_Cycle)
	ls_Path = ls_ClrDir + "\" + ls_FileName
	FileDelete(ls_Path)
next

ls_LastClrDate = String(Today(),"YYYY/MM/DD")
SetProfileString(gs_IniFilePathName,"Setup","Last_Clear_Date",ls_LastClrDate)

Close(This)

//---------------------------- APPEON END ----------------------------

end event

type lb_files from listbox within w_deltmpfiles
boolean visible = false
integer x = 800
integer y = 388
integer width = 549
integer height = 452
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

