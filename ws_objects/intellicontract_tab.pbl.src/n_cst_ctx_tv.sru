$PBExportHeader$n_cst_ctx_tv.sru
$PBExportComments$[intellicontract_tab]  Helper object for the contract module
forward
global type n_cst_ctx_tv from nonvisualobject
end type
end forward

global type n_cst_ctx_tv from nonvisualobject
event ue_retrieve ( )
end type
global n_cst_ctx_tv n_cst_ctx_tv

type variables
DataStore ids_ctx_tv_settings
Integer ii_use_group,ii_displaycount,ii_hidebrowse,ii_col_max_width = 30,ii_show_data
String is_group_by
String is_group_sort_type

String is_display_columns[],is_display_null[]
String is_data_sort_by,is_data_sort_type

String is_sort_syntax
String is_tv_type

String is_font
Long il_font_size, il_font_text_color, il_font_italy, il_font_bold, il_font_underline
end variables

forward prototypes
public subroutine of_refresh_var ()
end prototypes

event ue_retrieve();ids_ctx_tv_settings.Retrieve(gs_user_id)
If ids_ctx_tv_settings.RowCount() = 0 Then
	ids_ctx_tv_settings.InsertRow(0)
	ids_ctx_tv_settings.SetItem(1,'user_id',gs_user_id)
	If ids_ctx_tv_settings.Update() <> 1 Then
		Messagebox('Error','Failed to initialize tree view settings data, please call support.' + SQLCA.sqlerrtext )
		Return 
	End If
End If


of_refresh_var()
end event

public subroutine of_refresh_var ();String ls_display_col1,ls_display_col2,ls_display_col3,ls_display_col4,ls_display_col5

ii_use_group = ids_ctx_tv_settings.GetItemNumber(1,'show_group')
ii_displaycount = ids_ctx_tv_settings.GetItemNumber(1,'displaycount')
ii_hidebrowse = ids_ctx_tv_settings.GetItemNumber(1,'hide_browse')
ii_col_max_width = ids_ctx_tv_settings.GetItemNumber(1,'max_width')
is_group_by = ids_ctx_tv_settings.GetItemString(1,'group_by')
is_group_sort_type = ids_ctx_tv_settings.GetItemString(1,'group_sort_type')
ls_display_col1 = ids_ctx_tv_settings.GetItemString(1,'display_col1')
ls_display_col2 = ids_ctx_tv_settings.GetItemString(1,'display_col2')
ls_display_col3 = ids_ctx_tv_settings.GetItemString(1,'display_col3')
ls_display_col4 = ids_ctx_tv_settings.GetItemString(1,'display_col4')
ls_display_col5 = ids_ctx_tv_settings.GetItemString(1,'display_col5')
is_tv_type = ids_ctx_tv_settings.GetItemString(1,'tv_type')

is_font = ids_ctx_tv_settings.GetItemString(1,'font')
il_font_size = ids_ctx_tv_settings.GetItemNumber(1,'font_size')
il_font_text_color = ids_ctx_tv_settings.GetItemNumber(1,'font_text_color')
il_font_italy = ids_ctx_tv_settings.GetItemNumber(1,'font_italy')
il_font_bold = ids_ctx_tv_settings.GetItemNumber(1,'font_bold')
il_font_underline = ids_ctx_tv_settings.GetItemNumber(1,'font_underline')

If isnull(ii_hidebrowse) Then ii_hidebrowse = 0
If isnull(ii_col_max_width) Then ii_col_max_width = 0

is_display_columns[] = is_display_null[]
If ls_display_col1 <> '' And Not isnull(ls_display_col1) Then
	is_display_columns[UpperBound(is_display_columns[]) + 1] = ls_display_col1
End If
If ls_display_col2 <> '' And Not isnull(ls_display_col2) Then
	is_display_columns[UpperBound(is_display_columns[]) + 1] = ls_display_col2
End If
If ls_display_col3 <> '' And Not isnull(ls_display_col3) Then
	is_display_columns[UpperBound(is_display_columns[]) + 1] = ls_display_col3
End If
If ls_display_col4 <> '' And Not isnull(ls_display_col4) Then
	is_display_columns[UpperBound(is_display_columns[]) + 1] = ls_display_col4
End If
If ls_display_col5 <> '' And Not isnull(ls_display_col5) Then
	is_display_columns[UpperBound(is_display_columns[]) + 1] = ls_display_col5
End If

is_data_sort_by = ids_ctx_tv_settings.GetItemString(1,'display_sort_by')
is_data_sort_type = ids_ctx_tv_settings.GetItemString(1,'display_sort_type')
ii_show_data =  ids_ctx_tv_settings.GetItemNumber(1,'show_data')

If ii_use_group <> 1 Then
	is_group_by = ''
End If

If is_group_sort_type = '' or Isnull(is_group_sort_type) Then is_group_sort_type = 'A'
If is_data_sort_type = '' or Isnull(is_data_sort_type) Then is_data_sort_type = 'A'

is_sort_syntax = ''
If ii_use_group = 1 and is_group_by <> '' Then
	is_sort_syntax = " " + is_group_by + " " + is_group_sort_type
End If

If is_data_sort_by <> '' Then
	is_sort_syntax += " " + is_data_sort_by + " " + is_data_sort_type
End If

If isnull(ii_show_data) Then ii_show_data = 1


end subroutine

on n_cst_ctx_tv.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_ctx_tv.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_ctx_tv_settings = Create DataStore
ids_ctx_tv_settings.DataObject = 'd_ctx_tv_settings'
ids_ctx_tv_settings.SetTransObject(SQLCA)

end event

event destructor;If isvalid(ids_ctx_tv_settings) Then Destroy ids_ctx_tv_settings
end event

