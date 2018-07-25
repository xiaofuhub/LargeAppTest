$PBExportHeader$w_traceanalysis.srw
forward
global type w_traceanalysis from window
end type
type tv_1 from treeview within w_traceanalysis
end type
type cb_1 from commandbutton within w_traceanalysis
end type
end forward

global type w_traceanalysis from window
integer width = 2926
integer height = 2080
boolean titlebar = true
string title = "TraceAnalysisResult "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
tv_1 tv_1
cb_1 cb_1
end type
global w_traceanalysis w_traceanalysis

type variables
long il_count = 0
end variables

forward prototypes
public subroutine of_dumpnode (tracetreenode atctn_node, ref str_node astr_node)
public subroutine of_analysisnode ()
public subroutine of_analysisnode (tracetreenode atctn_list[], long al_treehandle)
end prototypes

public subroutine of_dumpnode (tracetreenode atctn_node, ref str_node astr_node);string ls_exit, ls_label, ls_routinename
long ll_node_cnt 
TraceTreeNode ltctn_list[] 
errorreturn l_err 
astr_node.Children = FALSE
astr_node.Label = '' 
astr_node.count = 0

IF NOT isvalid(atctn_node) THEN RETURN 
CHOOSE CASE atctn_node.ActivityType 
   CASE ActRoutine!    
		TraceTreeRoutine ltctrt_routine     
		ltctrt_routine = atctn_node   
		IF ltctrt_routine.Classname <> '' THEN 
			ls_routinename = ltctrt_routine.ClassName + "."     
		END IF        
		ls_routinename += ltctrt_routine.Name    
		ltctrt_routine.GetChildrenList(ltctn_list)   
		ll_node_cnt = UpperBound(ltctn_list)  
		
		//filter begin
		if ll_node_cnt = 0 then
			if not ( (ltctrt_routine.classname = "datawindow" or ltctrt_routine.classname = "datastore" or ltctrt_routine.classname = "datawindowchild") and &
				(left(ltctrt_routine.Name, 8) = "retrieve" or left(ltctrt_routine.Name, 7) = "update(" ) ) then
				ls_label = "INVALID NODE"
				astr_node.label = ls_label  
				return
			end if
		end if

		//	ls_label = "Execute " + ls_routinename + ' :' + space(ii_offset) + String(l_timescale * (ltctrt_routine.ExitTimerValue - ltctrt_routine.EnterTimerValue), '0.000000')   
		ls_label = ls_routinename + ' :' + String((ltctrt_routine.ExitTimerValue - ltctrt_routine.EnterTimerValue), '0.000000') + "s"
		if len(ltctrt_routine.libraryname) <> 0 then
			string ls_library
			ls_library = right(ltctrt_routine.libraryname, len(ltctrt_routine.libraryname) - lastpos(ltctrt_routine.libraryname, "\"))
			ls_label += " [" + ls_library + "]"
		end if
		if left(ltctrt_routine.Name, 9) = "retrieve(" or &
			left(ltctrt_routine.Name, 7) = "update(" then
			astr_node.count = 1
			ls_label += "  (Calls = " + string(astr_node.count) + ")"
			il_count ++
		end if
		astr_node.Children = (ll_node_cnt > 0)   
		astr_node.Time = ltctrt_routine.EnterTimerValue 
			
//	CASE ActLine!       
//		TraceTreeLine tctln_treeLine    
//		tctln_treeLine = atctn_node       
////		ls_label = LINEPREFIX + String(tctln_treeLine.LineNumber ) 
//		ls_label = String(tctln_treeLine.LineNumber ) 
//		astr_node.time = tctln_treeLine.Timervalue   
//		//...     
//		// CASE statements omitted   
//		//...   
	CASE ActESQL! 
		TraceTreeESQL tct_esql
		tct_esql = atctn_node
		ls_label = tct_esql.name + " :" + string(tct_esql.exittimervalue - tct_esql.entertimervalue, '0.000000') + "s"
		astr_node.time = tct_esql.exittimervalue - tct_esql.entertimervalue
		astr_node.Children = false
		astr_node.count = 1
		ls_label += " (Calls = " + string(astr_node.count) + ")"
		il_count ++
	CASE ELSE     
		ls_label = "INVALID NODE" 
   END CHOOSE   
	astr_node.label = ls_label  
	RETURN

end subroutine

public subroutine of_analysisnode ();
end subroutine

public subroutine of_analysisnode (tracetreenode atctn_list[], long al_treehandle);TraceTreeNode ltctn_node, ltctn_list[]
long ll_index, ll_limit, ll_itemHandle, ll_tmpcount = 0
string ls_line  
str_node lstr_node  
treeviewitem ltvi_Item

ll_limit = UpperBound(atctn_list)
FOR ll_index = 1 to ll_limit    
	ll_tmpcount = il_count
   ltctn_node = atctn_list[ll_index]  
	of_dumpnode(ltctn_node, lstr_node)   
	if lstr_node.label = "INVALID NODE" then continue 
	ltvi_Item.Label = lstr_node.label
	ltvi_Item.data = lstr_node.time
	//if have calls, then change the picture
	if lstr_node.count >= 1 then
		ltvi_Item.PictureIndex = 3
	else	
		ltvi_Item.PictureIndex = 2
	end if
	ltvi_Item.SelectedPictureIndex = ltvi_Item.PictureIndex
	ltvi_Item.children = false
	ll_itemHandle = tv_1.InsertItemLast(al_treeHandle, ltvi_Item)
	//if have child, then recursion the child
	if lstr_node.children then
		TraceTreeRoutine ltctrt_routine     
		ltctrt_routine = ltctn_node
		ltctrt_routine.getchildrenlist( ltctn_list )
		of_analysisnode(ltctn_list, ll_itemHandle)
		if ll_tmpcount <> il_count then
			tv_1.getitem( ll_itemHandle, ltvi_Item )
			ltvi_Item.label += "  (TotalCalls = " + string(il_count - ll_tmpcount) + ")"
			ltvi_Item.pictureindex = 3
			ltvi_Item.SelectedPictureIndex = ltvi_Item.PictureIndex
			tv_1.setitem( ll_itemHandle, ltvi_Item )
		elseif w_trace.cbx_dbCalls.checked = true then
			//only show the database call stacks
			tv_1.deleteItem(ll_itemHandle)
		end if
		//recursion call
	end if
	
NEXT

end subroutine

on w_traceanalysis.create
this.tv_1=create tv_1
this.cb_1=create cb_1
this.Control[]={this.tv_1,&
this.cb_1}
end on

on w_traceanalysis.destroy
destroy(this.tv_1)
destroy(this.cb_1)
end on

event resize;tv_1.x = 5
tv_1.y = 0 
tv_1.width = this.width - 40
tv_1.height = this.height - 125

end event

event open;this.cb_1.event clicked( )
end event

type tv_1 from treeview within w_traceanalysis
event ue_init_tree ( )
integer x = 5
integer y = 8
integer width = 2798
integer height = 1588
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean tooltips = false
string picturename[] = {"Application!","Browse!","Watcom!"}
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event ue_init_tree();long ll_Root
treeviewitem ltvi_Item

setpointer(HourGlass!)

ll_Root = this.finditem(roottreeitem!,0)
IF ll_Root > 0 THEN
	This.DeleteItem(ll_Root)
END IF

ltvi_Item.Label = "Analysis Root"
ltvi_Item.Data = 0
ltvi_Item.PictureIndex = 1
ltvi_Item.SelectedPictureIndex = ltvi_Item.PictureIndex
ll_Root = This.InsertItemfirst (0, ltvi_Item)

end event

event constructor;this.event ue_init_tree( )
end event

type cb_1 from commandbutton within w_traceanalysis
integer x = 2368
integer y = 1632
integer width = 357
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "AnaysisTrace"
end type

event clicked;TraceTree ltct_model
long ll_RootHandle
TraceTreeNode ltctn_list[], ltctn_node 
long ll_index, ll_limit 
string ls_line, ls_filename = ""  
str_node lstr_node  
string ls_path = ""

ls_path = message.stringparm

//Open trace File
if isvalid(w_trace) and ls_path <> "" then
	if not fileexists(ls_path) then
		messagebox("Error","File is not exist.")
		close(parent)
		return
	end if
	ls_filename = ls_path
else
	string docpath, docname
	integer li_rtn
	li_rtn = GetFileSaveName("Select File", docpath, docname, "pbp",  + "PowerBuilder Profile(*.pbp), *.pbp," + "All Files (*.*), *.*", "c:\", 32770)
	//if file is empty , then return
	IF li_rtn < 1 or string(docpath) = "" THEN
		close(parent)
		return
	end if
	if li_rtn = 1 then ls_filename =  string(docpath)
end if

//build tree
ll_RootHandle = tv_1.FindItem(RootTreeItem! , 0)
tv_1.event ue_init_tree( )
//reset instance variable
il_count = 0

//create TraceTree
ltct_model = CREATE TraceTree
ltct_model.SetTraceFileName(ls_filename)
ltct_model.BuildModel()


ltct_model.EntryList(ltctn_list) 
of_analysisnode(ltctn_list,ll_RootHandle)

//destroy
ltct_model.DestroyModel()
DESTROY ltct_model

//expand tree
tv_1.Expanditem(ll_RootHandle)

end event

