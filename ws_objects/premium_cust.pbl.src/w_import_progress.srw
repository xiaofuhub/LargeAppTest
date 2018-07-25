$PBExportHeader$w_import_progress.srw
$PBExportComments$Window allows for the user to modify the user entered codes.
forward
global type w_import_progress from Window
end type
type st_update_time from statictext within w_import_progress
end type
type st_replace_code_time from statictext within w_import_progress
end type
type st_import_time from statictext within w_import_progress
end type
type dw_1 from datawindow within w_import_progress
end type
type st_header from statictext within w_import_progress
end type
end forward

global type w_import_progress from Window
int X=0
int Y=0
int Width=2281
int Height=1552
boolean TitleBar=true
string Title="Import Progress"
long BackColor=80269524
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_start_timer ( )
st_update_time st_update_time
st_replace_code_time st_replace_code_time
st_import_time st_import_time
dw_1 dw_1
st_header st_header
end type
global w_import_progress w_import_progress

forward prototypes
public function integer wf_set_header ()
public subroutine wf_add_table (string as_table_name)
public subroutine wf_update_prac_import (integer al_procees, integer al_datastore_index)
public subroutine wf_set_code_modification (integer as_result, integer al_index)
public subroutine of_set_update (integer al_result, integer al_index)
public function integer wf_set_vis (integer al_row)
public subroutine of_set_import_time (long al_time)
public subroutine of_set_update_time (long al_update_time)
public subroutine of_set_replace_code_time (long al_time)
end prototypes

event ue_start_timer;

timer(3)
end event

public function integer wf_set_header ();//wf_importing_prac

st_header.text = 'Importing practitioners. Please stand by'

return 1
end function

public subroutine wf_add_table (string as_table_name);
long ll_row
ll_row = dw_1.insertrow(0)
st_header.text =  'Importing Tables'
dw_1.object.table[ll_row] = as_table_name

wf_set_vis(ll_row)


end subroutine

public subroutine wf_update_prac_import (integer al_procees, integer al_datastore_index);

//wf_update_prac_import
st_header.text =  'Updating Practitioner ID'

dw_1.object.change_prac_id[al_datastore_index] = al_procees

wf_set_vis(al_datastore_index)
end subroutine

public subroutine wf_set_code_modification (integer as_result, integer al_index);
st_header.text =  'Updating Lookup Codes'

dw_1.object.lookup_code_modification[al_index] = as_result

wf_set_vis(al_index)
end subroutine

public subroutine of_set_update (integer al_result, integer al_index);

st_header.text = 'Updating Credentialing Tables'

DW_1.OBJECT.update_to_database[AL_INDEX] = AL_RESULT
end subroutine

public function integer wf_set_vis (integer al_row);
yield()
dw_1.ScrollToRow ( al_row )
dw_1.SelectRow(0, FALSE)
dw_1.SelectRow(al_row, TRUE)

return 1
end function

public subroutine of_set_import_time (long al_time);


st_import_time.text = 'Import time: ' + string(al_time/1000)
end subroutine

public subroutine of_set_update_time (long al_update_time);//



st_update_time.text = 'Update Time: ' + string(al_update_time/1000)
end subroutine

public subroutine of_set_replace_code_time (long al_time);

st_replace_code_time.text = 'Replace Code Time: ' + string(al_time/1000)
end subroutine

on w_import_progress.create
this.st_update_time=create st_update_time
this.st_replace_code_time=create st_replace_code_time
this.st_import_time=create st_import_time
this.dw_1=create dw_1
this.st_header=create st_header
this.Control[]={this.st_update_time,&
this.st_replace_code_time,&
this.st_import_time,&
this.dw_1,&
this.st_header}
end on

on w_import_progress.destroy
destroy(this.st_update_time)
destroy(this.st_replace_code_time)
destroy(this.st_import_time)
destroy(this.dw_1)
destroy(this.st_header)
end on

event timer;

//messagebox('','timer')

GarbageCollect ( )
close(this)
end event

type st_update_time from statictext within w_import_progress
int X=18
int Y=1376
int Width=2130
int Height=56
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_replace_code_time from statictext within w_import_progress
int X=18
int Y=1312
int Width=2130
int Height=56
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_import_time from statictext within w_import_progress
int X=18
int Y=1244
int Width=2130
int Height=56
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_import_progress
int Y=124
int Width=2254
int Height=1104
int TabOrder=10
string DataObject="d_ext_progress"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type st_header from statictext within w_import_progress
int X=14
int Y=32
int Width=2254
int Height=88
boolean Enabled=false
string Text="Importing practitioners. Please stand by"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

