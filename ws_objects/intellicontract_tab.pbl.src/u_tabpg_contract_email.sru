$PBExportHeader$u_tabpg_contract_email.sru
forward
global type u_tabpg_contract_email from u_tabpg_contract_master
end type
end forward

global type u_tabpg_contract_email from u_tabpg_contract_master
long backcolor = 33551856
end type
global u_tabpg_contract_email u_tabpg_contract_email

on u_tabpg_contract_email.create
call super::create
end on

on u_tabpg_contract_email.destroy
call super::destroy
end on

event constructor;call super::constructor;//Added By Mark Lee 02/07/2013
If not isvalid(w_contract_email_folder) Then
	If isvalid(gw_contract) Then 
		Open(w_contract_email_folder,gw_contract)
			w_contract_email_folder.of_adjustsize()
//	Else
//		Open(w_contract_email_folder,w_contract)
	End If
//	If isvalid(w_contract_email_folder) Then
//		w_contract_email_folder.Resizable = False	
//	End If

Else
	w_contract_email_folder.show()
	// It is a adjust of the position for the window w_contract_email_folder
	w_contract_email_folder.of_adjustsize()
End If
end event

event resize;call super::resize;//Added By Mark Lee 03/04/2013
If isvalid(w_contract_email_folder) Then
	w_contract_email_folder.of_adjustsize()
End If 
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_email
long backcolor = 33551856
end type

