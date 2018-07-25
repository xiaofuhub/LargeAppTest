$PBExportHeader$w_report_text_properties.srw
$PBExportComments$(Appeon)Toney 06.10.2013 - V141 ISG-CLX
forward
global type w_report_text_properties from w_contract_text_properties
end type
end forward

global type w_report_text_properties from w_contract_text_properties
end type
global w_report_text_properties w_report_text_properties

on w_report_text_properties.create
call super::create
end on

on w_report_text_properties.destroy
call super::destroy
end on

type dw_properties_text from w_contract_text_properties`dw_properties_text within w_report_text_properties
end type

event dw_properties_text::itemchanged;choose case dwo.name 
	case "text_color", "background_color"
		of_ShowColor()
end choose

w_report_data_design.uo_design.Post of_set_dw_properties(this.GetColumnName(), 3)
end event

type cb_ok from w_contract_text_properties`cb_ok within w_report_text_properties
end type

type cb_cancel from w_contract_text_properties`cb_cancel within w_report_text_properties
end type

