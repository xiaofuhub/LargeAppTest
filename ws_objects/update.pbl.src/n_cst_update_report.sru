$PBExportHeader$n_cst_update_report.sru
forward
global type n_cst_update_report from nonvisualobject
end type
end forward

global type n_cst_update_report from nonvisualobject
end type
global n_cst_update_report n_cst_update_report

forward prototypes
public function long of_update_reports ()
end prototypes

public function long of_update_reports ();/////////////////////////////////////////////////////// //
//Function : of_update_reports()
//arguments: long gl_logfilehandle //Error Log File
//return   : long 
//describe : update report (come from w_priv_update.of_update_reports())
//developer: Andy 09/17/2007
/////////////////////////////////////////////////////////
String rpt_path, wiz_path, ls_Error
n_cst_datastore lds_report,lds_wizard
n_appeon_download lnv_download //Alfee 01.30.2008

lds_report = Create n_cst_datastore
lds_wizard = Create n_cst_datastore

lds_report.DataObject = 'd_report_import'
lds_wizard.DataObject = 'd_report_wiz_import'

lds_report.SetTransObject(SQLCA)
lds_wizard.SetTransObject(SQLCA)

//-------Begin Modified by Alfee 01.30.2008-----------
//rpt_path = gs_sysrunpath + "\reports_v85.txt"
//wiz_path = gs_sysrunpath + "\report_wiz_v85.txt"
IF appeongetclienttype() = 'WEB' THEN 
	rpt_path = gs_dir_path + "intellicred\reports_v161.txt" 			
	wiz_path = gs_dir_path + "intellicred\report_wiz_v161.txt"		

	//Download report text files
	IF lnv_download.of_downloadfile("", rpt_path) <> 0 THEN
		ls_Error = "n_cst_update_report.of_update_reports() Information: Failed to download " + rpt_path + ", call support."			
		IF IsValid(gnv_logservice)THEN 
			gnv_logservice.of_setloglevel(2) //warning level
			gnv_logservice.of_log_warning(ls_Error)
			gb_upgrade_failed = TRUE			
		END IF		
	END IF
	IF lnv_download.of_downloadfile("", wiz_path) <> 0 THEN
		ls_Error = "n_cst_update_report.of_update_reports() Information: Failed to download " + wiz_path + ", call support."			
		IF IsValid(gnv_logservice)THEN 
			gnv_logservice.of_setloglevel(2) //warning level
			gnv_logservice.of_log_warning(ls_Error)
			gb_upgrade_failed = TRUE
		END IF				
	END IF
ELSE 
	rpt_path = Gs_Current_Directory + "\reports_v161.txt"			//Start Code Change ----02.04.2010 #V10 maha	//Modified by Scofield on 2008-06-11
	wiz_path = Gs_Current_Directory + "\report_wiz_v161.txt"		//Start Code Change ----02.04.2010 #V10 maha	//Modified by Scofield on 2008-06-11
END IF
//-------End Modified --------------------------------

IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN
	w_infodisp.Title = 'Update reports'
	w_infodisp.Center = True
	w_infodisp.st_complete.Visible = False
	w_infodisp.st_3.Visible = False
	w_infodisp.st_information.Visible = False
	w_infodisp.st_1.Text = 'Update reports, Please stand by'
	w_infodisp.wf_set_min_max(1,2)
END IF

IF FileExists(rpt_path) = True THEN
	IF FileExists(wiz_path) = True THEN
		IF IsValid(w_infodisp) THEN
			w_infodisp.wf_step_pbar(1)
			w_infodisp.st_1.Text = 'Reports ' + String(1) + ' of ' + String(2) +' Please stand by'
		END IF
		DELETE From sys_reports Where report_id < 1000;
		//<1000 added 031002 for not deleting custom reports.
		
		lds_report.Reset()
		lds_report.ImportFile( rpt_path )
		lds_report.Update()
		COMMIT Using SQLCA;
		
		IF IsValid(w_infodisp) THEN
			w_infodisp.wf_step_pbar(1)
			w_infodisp.st_1.Text = 'Reports ' + String(2) + ' of ' + String(2) +' Please stand by'
		END IF
		DELETE From sys_report_wizard Where report_id < 1000;
		
		lds_wizard.Reset()
		lds_wizard.ImportFile(wiz_path )
		lds_wizard.Update()
		COMMIT Using SQLCA;
	ELSE
		//--------Begin Modified by Alfee 01.30.2008-----------------------------
		ls_Error = "n_cst_update_report.of_update_reports() Information:File  does not exist " + wiz_path + ". Unable to update report list."		
		IF IsValid(gnv_logservice)THEN 
			gnv_logservice.of_setloglevel(2) //warning level
			gnv_logservice.of_log_warning(ls_Error)
			gb_upgrade_failed = TRUE
		END IF	
		/*
		//--------Begin Modified by Nva 11.12.2007-----------------------------
		ls_Error = '~r~n' + "==================================================="
		//ls_Error+= "~r~nError:n_cst_update_report.of_update_reports()~r~nInformation:File  does not exist " + wiz_path + ". Unable to update report list."
		ls_Error+= "~r~nWarning:n_cst_update_report.of_update_reports()~r~nInformation:File  does not exist " + wiz_path + ". Unable to update report list."		
		FileWrite(gl_logfilehandle,ls_Error)
		//gb_Flag = True	
		// $<reason>   Fix a defect.
		//---------End Modified -----------------------------------------------	
		*/
		//---------End Modified -----------------------------------------------		
	END IF
ELSE
	//--------Begin Modified by Alfee 01.30.2008-----------------------------
	ls_Error = "n_cst_update_report.of_update_reports()  Information:File  does not exist " + rpt_path + ". Unable to update report list."
	IF IsValid(gnv_logservice)THEN 
		gnv_logservice.of_setloglevel(2) //warning level
		gnv_logservice.of_log_warning(ls_Error)
		gb_upgrade_failed = TRUE
	END IF	
	/*	
	//--------Begin Modified by Nva 11.12.2007-----------------------------
	ls_Error = '~r~n' + "==================================================="
	//ls_Error+= "~r~nError:n_cst_update_report.of_update_reports()~r~nInformation:File  does not exist " + rpt_path + ". Unable to update report list."
	ls_Error+= "~r~nWarning:n_cst_update_report.of_update_reports()~r~nInformation:File  does not exist " + rpt_path + ". Unable to update report list."
	FileWrite(gl_logfilehandle,ls_Error)
	//gb_Flag = True
	// $<reason>   Fix a defect.
	//==============================APPEON END============================
	*/
	//---------End Modified -----------------------------------------------		
END IF

Destroy lds_report
Destroy lds_wizard

//If isvalid(w_infodisp) Then Close(w_infodisp)

RETURN 1

end function

on n_cst_update_report.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_update_report.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

