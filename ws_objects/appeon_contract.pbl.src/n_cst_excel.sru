$PBExportHeader$n_cst_excel.sru
forward
global type n_cst_excel from nonvisualobject
end type
end forward

global type n_cst_excel from nonvisualobject
end type
global n_cst_excel n_cst_excel

type variables
n_cst_string inv_string 
boolean ib_read = true
end variables

forward prototypes
public function string of_asctochar (integer ai_char)
public subroutine of_readtitlefromdw (datawindow adw, oleobject ao_excelapp)
public function integer of_readcompute_fromdw (u_dw adw, oleobject ao_excelapp)
public function string of_saveas_excel (u_dw adw_source, string as_rptname, boolean ab_header)
public subroutine of_open_file (string as_filename)
public function integer of_findandreplacechar (oleobject aole_object, datastore ads_data, boolean ab_header)
public function string of_dw_type (integer ai_type)
public function string of_saveas_excel (datastore adw_source, string as_rptname, boolean ab_header, boolean ab_xlsx)
public subroutine of_readtitlefromdw (datastore adw, oleobject ao_excelapp)
public function string of_saveas_excel (datawindow adw_source, string as_rptname, boolean ab_header, boolean ab_xlsx)
end prototypes

public function string of_asctochar (integer ai_char);string	ls_char  , ls_Char1, ls_Char2
integer	li , li_mod

li = int( ai_char / 26 )
li_mod = mod( ai_char, 26 )

IF li > 0 and li_mod > 0 then
	ls_char1 = char( 64 + li )
	ls_char2 = char( 64 + li_mod )
elseif li > 1 and li_mod = 0 then
	ls_char1 = char( 64 + li - 1 )
	ls_char2 = 'Z'
elseif li <= 1   then
	ls_Char1 = ''
	ls_Char2 = char( 64 + ai_Char )
end if

ls_char = ls_char1 + ls_char2
return ls_char
end function

public subroutine of_readtitlefromdw (datawindow adw, oleobject ao_excelapp);oleObject	lo_ExcelActiveSht
string		ls_title , ls_col , ls_Sum,ls_type
integer	   li , li_ColCount
long			ll_Rowcount

lo_ExcelActiveSht = ao_ExcelApp.ActiveSheet
lo_ExcelActiveSht.Rows("1:1").Select()
//ao_ExcelApp.Selection.Insert()

li_ColCount = integer(adw.Describe("datawindow.Column.Count"))
ll_Rowcount = adw.RowCount() + 2
For li = 1 to li_ColCount
	ls_title = ''
	ls_Sum 	= ''
	ls_col = adw.Describe("#" + string(li) + ".name")
	
	ls_Type = adw.Describe( ls_Col + "_t.type" )
	if ls_type = 'compute' or ls_type = 'column' then
//		ls_title = adw.Describe("Evaluate('" + ls_col + "_t',1)")

      ls_title=ls_col
	else
		ls_title = inv_string.of_globalReplace(inv_string.of_globalReplace(adw.Describe(ls_col + "_t.text" ),'~r~n',''),'"','')
	end if
	
	if ls_title <> '!' and ls_title <> '' then
		lo_ExcelActiveSht.cells[1,li].value = ls_title
	end if
	
	//¼ì²éÊÇ·ñÓÐºÏ¼ÆÁÐ
	ls_type = adw.Describe( ls_Col + '_sum.type')
	if ls_type = 'text' then
		ls_Sum = adw.Describe( ls_col + '_sum.Text')
	elseif ( ls_type = 'compute' or ls_type = 'column') then
		ls_Sum = adw.Describe( "Evaluate('" + ls_col + "_sum',1)")
	end if
	
	if ls_sum <> '!' and ls_sum <> '?' then
		lo_ExcelActiveSht.cells[ll_rowcount,li].value = ls_Sum
	end if

Next



end subroutine

public function integer of_readcompute_fromdw (u_dw adw, oleobject ao_excelapp);////====================================================================
//// [¹¦ÄÜ] ´ÓdwÖÐ½«ComputeÁÐ¶ÁÈ¡³öÀ´£¬Ë³Ðò·ÅÖÃÔÚColumnµÄºóÃæ
////--------------------------------------------------------------------
//// [Èë¿Ú²ÎÊý]	OleObject Excel  , aDw
////--------------------------------------------------------------------
//// [·µ»ØÖµ] integer	 µ±Ç°¿ÉÏÔÊ¾µÄ×Ö¶Î + Compute¸öÊý, ¼´µ±Ç°Excel µÄÁÐÊý
////--------------------------------------------------------------------
//// [Ê¹ÓÃÌØÊâÔ¼¶¨] Ö»ÏÞÓÚGrid ÐÍdW
////--------------------------------------------------------------------
////	[Î¬»¤ÀúÊ·] Mirabelle  2001-02-16
////====================================================================
oleobject lo_excelactivesht
long ll_row,ll_upperbound,ll_rowcount
string ls_visible,ls_band,ls_ColToChar,ls_compute[],ls_type,ls_value,ls_valueall,ls_lastcol
integer li_colcount,li_endcol,li_col,li_discard,li_index
lo_ExcelActiveSht = ao_ExcelApp.ActiveSheet
li_ColCount = integer(adw.Describe("datawindow.Column.Count"))
li_discard=0
for li_col=1 to li_colcount

   ls_visible=adw.describe("#"+string(li_col)+".visible")
   ls_band=adw.describe("#"+string(li_col)+".band")
	if ls_band<>"detail" or ls_visible="0" then
	   ls_ColToChar = of_AscToChar(li_col - li_discard ) 
		lo_ExcelActiveSht.columns( ls_ColToChar+ ":" + ls_ColToChar).select()
		ao_ExcelApp.Selection.Delete()  //Çå³ý±¾ÁÐ
		li_discard++
	end if
	
next

adw.inv_base.of_getobjects(ls_compute[],'compute','detail',true)
li_colcount=li_colcount - li_discard

ll_upperbound = UpperBound(ls_Compute[])
ll_rowcount   = adw.RowCount()
For li_index = 1 to ll_upperbound

	li_ColCount ++
	lo_ExcelActiveSht.cells[1,li_colCount].value = ls_compute[li_index]
	//ÅÐ¶Ïµ±Ç°µÄcompute ÓÃGetItemString or getItemDecimal
	//Í¨ÓÃTag,»òGetItemDecimalÀ´ÊÔÑéÅÐ¶Ï
	
	ls_Type = adw.Describe(ls_Compute[li_index] + ".Coltype")
	For ll_row = 1 to ll_rowcount
		ls_Value = adw.Describe("Evaluate('" + ls_compute[li_index]+ "'," + string(ll_row) + ")")
		if (isnull(ls_value) or ls_value = '' or ls_value = '0') then 	
			Continue
		end if

		//Ö±½Ó¸³Öµ£¬Ê¹ÓÃclipboard(ls_ValueAll)ÓÐÊ±»á³öÏÖÂÒÂë Maintenance Jack 2003-06-25
		If adw.describe(ls_Compute[li_index]+".format")='***' Then
			ls_value='***'
		End If			
		ls_lastCol = of_AscToChar(li_ColCount)
		ao_ExcelApp.range(ls_lastCol+ String(ll_row +1) + ":" + ls_LastCol + String(ll_row +1)  ).Select()
		ao_ExcelApp.range(ls_lastCol+ String(ll_row +1) + ":" + ls_LastCol + String(ll_row +1)  ).value = ls_value
	Next
	
	//¼ì²éÊÇ·ñÓÐºÏ¼ÆÖµ,Èç¹ûÒÑ¾­·ÅÔÚSummary Çø£¬Ôò·ÅÔÚ±¾ÁÐµÄºóÃæ
	ls_type = adw.Describe( ls_compute[li_index] + '_sum.type' )
	if ls_type = 'column' or ls_type = 'compute' then
		ls_value = adw.Describe( "Evaluate('" + ls_compute[li_index] + "_sum',1)" )
	elseif ls_type = 'text' then
		ls_value = adw.Describe( ls_compute[li_index] + '_sum.text' )
	else
		Continue
	end if
	
	ls_ValueAll += '~r~n' +  ls_Value
	

	//Ö±½Ó¸³Öµ£¬Ê¹ÓÃclipboard(ls_ValueAll)ÓÐÊ±»á³öÏÖÂÒÂë Maintenance Jack 2003-06-25
	ls_lastCol = of_AscToChar(li_ColCount)
		If adw.describe(ls_Compute[li_index]+".format")='***' Then
			ls_value='***'
		End If		
	ao_ExcelApp.range(ls_lastCol+ String(ll_row + 1) + ":" + ls_LastCol + String(ll_row +1)  ).Select()
	ao_ExcelApp.range(ls_lastCol+ String(ll_row + 1) + ":" + ls_LastCol + String(ll_row +1)  ).value = ls_value
Next
li_endcol=li_colcount 
return li_EndCol

end function

public function string of_saveas_excel (u_dw adw_source, string as_rptname, boolean ab_header);///********************************************************************
//[Description]  EXport to excel format file
//********************************************************************/

Return of_SaveAs_excel( adw_source, as_rptname, ab_header, true )


//datastore lds_saveexcel
//string ls_dwtype
//n_cst_string lnv_string
//
//string ls_dwsyntax,ls_error
//
//oleobject lo_ExcelApp
//oleobject lo_ExcelActiveSht
//long ll_rc,ll_rows
//string ls_LastCol,ls_format
//long ll_k 
//string ls_edit
//string ls_coltype
//integer li_cols,li_inserted
//string ls_col,ls_colname
//long ll_x,ll_multi,ll_summaryrow
//string ls_tempName
//long ll_width
//
//
//
//If adw_source.rowcount()=0 Then Return ''
//
////adw_source.SetRedraw(False)
//SetPointer( HourGlass! )
//
//ls_DwType = adw_source.describe("Datawindow.Processing")
//choose case ls_DwType 
//	case '0','1'
//		if adw_source.RowCount() = 0 then return ''
//	case else
//		messagebox('Saveas to excel',"Can't convert to excel format.") 
//		return ''
//end choose
//
///*
////´«ÈëµÄÎÄ¼þÃû²»ÄÜº¬ÓÐÈçÏÂ¾Å¸ö×Ö·û(/,\,:,*,?,",<,>,|),·ñÔò»á³ö´í
//
//as_rptname = lnv_string.of_globalreplace( as_rptname, '\', '_')
//as_rptname = lnv_string.of_globalreplace( as_rptname, ':', '_')
//as_rptname = lnv_string.of_globalreplace( as_rptname, '*', '_')
//as_rptname = lnv_string.of_globalreplace( as_rptname, '?', '_')
//as_rptname = lnv_string.of_globalreplace( as_rptname, '"', '_')
//as_rptname = lnv_string.of_globalreplace( as_rptname, '<', '_')
//as_rptname = lnv_string.of_globalreplace( as_rptname, '>', '_')
//as_rptname = lnv_string.of_globalreplace( as_rptname, '|', '_')
//*/
///*
//Open(w_Progress)
//of_addProgress(0.05) //0.05
//lu_dwsrv.of_getobjects(ls_objects[],this,'*','*',True)
/////////////////////////
//string	ls_columntype,ls_colstyle,ls_dataColumn,ls_DisplayColumn,ls_dwcColtype,ls_dddwcol[],ls_dddwcolstr
//long		ll_colID
//datawindowchild ldc_dw
//*/
//ls_dwsyntax=adw_source.Describe("datawindow.syntax")
//
//lds_saveexcel=create datastore
//lds_saveexcel.Create(ls_dwsyntax, ls_error)
//IF Len(ls_error) > 0 THEN
//	destroy lds_saveexcel
//	Return ''
//END IF
//lds_saveexcel.object.data=adw_source.object.data
//
///*
//For i=1 To UpperBound(ls_objects[])
//	ls_edit=adw_source.Describe(ls_objects[i]+".edit.style")
//	Choose Case ls_edit
//		Case 'checkbox'
//			ls_objchk[UpperBound(ls_objchk[])+1]=ls_objects[i]
//			ls_off=adw_source.Describe(ls_objects[i]+".CheckBox.Off")
//			ls_chkoff[UpperBound(ls_chkoff[])+1]=ls_off
//			ls_on =adw_source.Describe(ls_objects[i]+".CheckBox.on")
//			ls_chkon[UpperBound(ls_chkon[])+1]=ls_on
//			ls_err =lds_saveexcel.Modify(ls_objects[i]+".edit.case=any")
//			ls_Coltype=adw_source.Describe(ls_objects[i]+".Coltype")
//			If Pos(ls_Coltype,'char')>0 Then
//				For j=1 To adw_source.rowcount()
//					If adw_source.GetItemString(j,ls_objects[i])=ls_on Then
//						lds_saveexcel.SetItem(j,ls_objects[i],gf_TranslateStr('yes'))
//					Else
//						lds_saveexcel.SetItem(j,ls_objects[i],gf_TranslateStr('not'))
//					End If
//				Next
//			End If
//		Case 'ddlb','dddw','radiobuttons'
//				ls_err =lds_saveexcel.Modify(ls_objects[i]+".edit.case=any")
//				ls_Coltype=adw_source.Describe(ls_objects[i]+".Coltype")
//				If Pos(ls_Coltype,'char')>0 Then
//					For j=1 To adw_source.rowcount()
//						ls_Value = adw_source.Describe("Evaluate('lookupdisplay(" + ls_objects[i] + ")'," + string(j) + ")")
//						lds_saveexcel.SetItem(j,ls_objects[i],ls_Value)
//					Next
//			
//				End If
//
//	End Choose
//Next	
//*/
//
//Try
//		ls_tempName = gs_dir_path + gs_DefDirName + "\Temp\"
//		gnv_appeondll.of_parsepath( ls_tempName)
//		ls_tempName += '\temp.xls' 
//		
//	
//	 
//	if lds_saveexcel.Saveas(ls_tempName, Excel8! , ab_header)=-1 then
//		destroy lds_saveexcel
//		return ''
//	end if
//	if not ab_header then 
//		destroy lds_saveexcel
//		of_open_file(as_rptname) //Added By Ken.Guo 2010-09-13.
//		return as_rptname
//	end if
//	
//	//of_addProgress(0.10) //0.15
//	lo_ExcelApp = CREATE OleObject
//	ll_RC = lo_ExcelApp.ConnectToNewObject( 'Excel.Application' )
//	IF ll_RC <> 0 THEN	
//			destroy lds_saveexcel
//			DESTROY lo_ExcelApp
//			//of_addProgress(0.85)
//			RETURN ''
//	END IF
//	
//	//of_addProgress(0.10) //0.25
//	lo_ExcelApp.Application.WindowState = 2
//	lo_ExcelApp.Application.Visible = false
//	
//	//´ò¿ª±¨±íÄÚÈÝÎÄ¼þ, Áí´æÎªExcelÎÄ¼þ
//	lo_ExcelActiveSht = lo_ExcelApp.WorkBooks.open(ls_tempName)
//Catch(Throwable iii)
//	//of_addProgress(0.99)
//	if isvalid(lo_ExcelApp) then DESTROY lo_ExcelApp
//	destroy lds_saveexcel
//	Return ''
//End Try 
//ll_rows = adw_source.RowCount() + 1
//
////of_addProgress(0.20)//0.45
//
//Try
//	lo_ExcelActiveSht.SaveAs(as_rptname,1 )
//Catch(Throwable ii)
//	lo_ExcelActiveSht.Close()
//	lo_ExcelApp.Application.Quit
//	lo_ExcelApp.DisconnectObject()
//	
//	fileDelete(ls_tempName)
//
//	Destroy	lo_ExcelApp
//	Destroy	lo_ExcelActiveSht 
//	destroy lds_saveexcel
//	//of_addProgress(0.99)
//	Return ''
//End Try
//
//
////of_addProgress(0.10) //0.55
//
//
//////Ôö¼Ó±íÍ·ÐÅÏ¢ //¸ù¾ÝDw µÄÖµ£¬Ë³ÐòÉèÖÃ
//of_ReadTitleFromDw( adw_source , lo_ExcelApp )
//
////of_SetProgress(0.65) //0.65
////ls_LastCol ='E'   //default Öµ
//Try
//	if ls_DwType <> '3' then
//		//ÉèÖÃÑÚÂëÏÔÊ¾¸ñÊ½ Maintenance Jack 2006-3-6
//		for ll_k=1 to long(adw_source.Describe("DataWindow.Column.Count"))
//			ls_format = "?" //³õÊ¼»¯ÎªÃ»ÓÐ¸ñÊ½
//			if adw_source.Describe("#"+string(ll_k)+".format")='***' then
//				//lo_ExcelApp.range(of_asctochar(ll_k)+"2:"+ of_asctochar(ll_k)+string(adw_source.rowcount()+1)).Value = "***"
//			else	
//				//¸ñÊ½´¦Àí
//				ls_edit =  adw_source.Describe("#"+string(ll_k)+".edit.style")
//				choose case ls_edit
//					case "editmask"
//						ls_format = adw_source.Describe("#" +string(ll_k)+ ".EditMask.Mask")
//						if ls_format = "?" then 
//							ls_format = adw_source.Describe("#"+string(ll_k)+".format")
//						end if 
//					case else
//						ls_format = adw_source.Describe("#"+string(ll_k)+".format")
//				end choose
//				
//				ls_coltype = adw_source.Describe("#"+string(ll_k)+".Coltype")
//				choose case left(ls_coltype,4)
//					case "deci","long","numb","real","date","time","char"
//						/*
//						if left(ls_coltype,4) = "char" then 
//							ls_format = "@"	//ÉèÖÃÎªÎÄ±¾¸ñÊ½
//						end if 
//						*/
//						 
//						if ls_format <> "[general]" and pos(ls_format,"[") = 0 and ls_format <> "?" and ls_format <> "!" then
//							try
//								lo_ExcelApp.range(of_asctochar(ll_k)+"2:"+of_asctochar(ll_k)+string(adw_source.rowcount()+1)).NumberFormatLocal = ls_format
//							Catch(Throwable e)
//								if Handle(getApplication()) = 0 then 
//									messageBox("debug","Error:" + e.text)
//								end if 
//							end try
//						end if 
//				end choose
//	
//			end if
//			
//			//ÈÕÆÚ¸ñÊ½×Ö¶ÎÁí´æÎªExcelºó¶¼ÈÏÎªÊÇÎÄ±¾ÀàÐÍ£¬Òò´Ë¼´Ê¹ÉèÖÃÁËÈÕÆÚ¸ñÊ½Ò²Ã»ÓÐÓÃ
//			//Ëã·¨£ºÔÚÈÕÆÚÁÐÇ°Ãæ²åÈëÒ»ÐÂÁÐ£¬²¢ÉèÖÃÎªÈÕÆÚÁÐµÄÈÕÆÚ¸ñÊ½£¬ÔÙ½«ÐÂÁÐµÄÊý¾Ý¿½µ½µ±Ç°ÈÕÆÚÁÐ¡£ÕâÑùÍê³ÉÎÄ±¾µ½ÈÕÆÚµÄ×ª»»
//			//Maintenance Jack 2006-3-6
//			if lower(left(adw_source.Describe("#"+string(ll_k)+".ColType"),3)) = 'dat' and (ls_format <> "[general]" and pos(ls_format,"[") = 0 and ls_format <> "?" and ls_format <> "!") then //ÈÕÆÚºÍÊ±¼äÀàÐÍ¶¼Òª´¦Àí£¬µ«ÊÇ²»ÓÐÉèÖÃ¸ñÊ½µÄÈÕÆÚºÍÊ±¼ä²»´¦Àí£¬·ñÔò»á×ª³ÉÊýÖµ
//				lo_ExcelApp.range(of_asctochar(ll_k)+"2:"+of_asctochar(ll_k)+"2").select()
//				lo_ExcelApp.Selection.EntireColumn.Insert
//				lo_ExcelApp.range(of_asctochar(ll_k)+"2").NumberFormatLocal = lo_ExcelApp.range(of_asctochar(ll_k +1)+"2").NumberFormatLocal 
//				lo_ExcelApp.ActiveCell.FormulaR1C1 = '=IF(RC[1]="","",IF(Len(RC[1])>19,VALUE(left(RC[1],19)),VALUE(RC[1])))' //¼ÓIF ÓïÑÔ£¬±ÜÃâ½«¿ÕÖµ±äÎª1900-1-0 "=value(RC[1])"
//				if adw_source.rowcount() > 1 then
//					lo_ExcelApp.Selection.AutoFill(lo_ExcelApp.Range(of_asctochar(ll_k)+"2:"+of_asctochar(ll_k)+string(adw_source.rowcount()+1)))
//				end if
//				lo_ExcelApp.Range(of_asctochar(ll_k)+"2:"+of_asctochar(ll_k)+string(adw_source.rowcount()+1)).Select()
//				lo_ExcelApp.Selection.Copy()
//				lo_ExcelApp.Range(of_asctochar(ll_k+1)+"2:"+of_asctochar(ll_k+1)+"2").Select()
//				lo_ExcelApp.Selection.PasteSpecial(-4163)
//				lo_ExcelApp.columns( of_asctochar(ll_k)+ ":" + of_asctochar(ll_k)).select()
//				lo_ExcelApp.Application.CutCopyMode = False
//				lo_ExcelApp.Selection.Delete()
//			end if
//			
//			//Set column width - jervis 05.26.2010
//			ll_width = long(adw_source.Describe("#"+string(ll_k)+".width"))
//			//Unit of Excel column width is 1/10 inch
//			//1 inch = 2.54cm
//			//1 Pixel = 0.26 mm
//			ll_width = UnitsToPixels(ll_width,XUnitsToPixels! ) *0.26/2.54
//			lo_ExcelApp.columns( of_asctochar(ll_k)).ColumnWidth = ll_width
//			
//		next
//	end if
//Catch(Throwable ff)
//	lo_ExcelActiveSht.Close()
//	lo_ExcelApp.Application.Quit
//	lo_ExcelApp.DisconnectObject()
//	
//	fileDelete(ls_tempName)
//
//	Destroy	lo_ExcelApp
//	Destroy	lo_ExcelActiveSht 
//	destroy lds_saveexcel
//	//of_addProgress(0.99)
//	Return ''
//End Try
//
//Try
//	lo_ExcelApp.range("A1" ).Select() //°Ñ¹â±êÉèÖÃ»ØµÚÒ»¸ñ
//	lo_ExcelActiveSht.Save()
//Catch(Throwable ee)
//End Try
//
//lo_ExcelActiveSht.Close()
//lo_ExcelApp.Application.Quit
//lo_ExcelApp.DisconnectObject()
//fileDelete(ls_tempName)
//
//
//
//DESTROY lo_ExcelApp
//Destroy	lo_ExcelActiveSht 
//destroy lds_saveexcel
//
////of_addProgress(0.05) //1.00
//of_open_file(as_rptname) //Added By Ken.Guo 2010-09-13.
//RETURN as_RptName
//
end function

public subroutine of_open_file (string as_filename);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_excel.of_open_file()
// $<arguments>
//		value	string	as_filename		
// $<returns> (none)
// $<description>
// $<description> Open the file.
//////////////////////////////////////////////////////////////////////
// $<add> 2010-09-13 by Ken.Guo
//////////////////////////////////////////////////////////////////////

gnv_appeondll.post of_open_file(as_filename,"Would you like to open the file in Excel now?")

end subroutine

public function integer of_findandreplacechar (oleobject aole_object, datastore ads_data, boolean ab_header);Long			ll_Find, ll_Find2
Integer		li_Count, li_i
String			ls_Col

li_Count = Long( ads_data.Describe( "Datawindow.column.count" ) )


For li_i = 1 To li_Count
	If Pos( lower( ads_Data.Describe( "#" + String( li_i ) + ".Coltype" )), 'char' ) > 0 Then
		ls_Col = ads_Data.Describe("#" + String( li_i ) + ".name" )
		ll_Find2 = 1
		do
			ll_Find = ads_data.Find( " len( "  + ls_Col + ")>255", ll_Find2, ads_data.RowCount( ) )
			If ll_Find > 0 Then
				If ab_header Then
					aole_object.cells( ll_Find+1, li_i ).value = ads_data.GetItemString( ll_Find, ls_Col ) 
				Else
					aole_object.cells( ll_Find, li_i ).value = ads_data.GetItemString( ll_Find, ls_Col ) 
				End If
				aole_object.cells( ll_Find+1, li_i ).WrapText = FALSE
				
				ll_Find2 = ll_Find + 1
			End If			
		loop while ll_Find > 0 and ll_Find2 <= ads_data.RowCount( )
		
	End If
	
Next


















Return 0
end function

public function string of_dw_type (integer ai_type);//Start Code Change ----11.28.2016 #V153 maha - added for more descriptive error message
string s

choose case ai_type
	case 0
		s = "(Default) Form, group, n-up, or tabular"
	case 1
		s = "Grid"
	case 2 
		s = "Label"
	case 3
		s = "Graph"
	Case 4
		s = "Crosstab"
	case 5
		s ="Composite"
	case 6
		s = "OLE"
	case 7
		s = "RichText"
	case 8, 9
		s = "TreeView"
end choose

return s
end function

public function string of_saveas_excel (datastore adw_source, string as_rptname, boolean ab_header, boolean ab_xlsx);/********************************************************************
[Description]  EXport to excel format file
//modified by gavins 20120411
//u_dw replaced to datastore   ///Modified by (Appeon)Gavin 12.07.2017 for V16.1  Export and excel
********************************************************************/
datastore lds_saveexcel
string ls_dwtype
n_cst_string lnv_string

string ls_dwsyntax,ls_error

oleobject lo_ExcelApp
oleobject lo_ExcelActiveSht
long ll_rc,ll_rows
string ls_LastCol,ls_format
long ll_k 
string ls_edit
string ls_coltype
integer li_cols,li_inserted
string ls_col,ls_colname
long ll_x,ll_multi,ll_summaryrow
string ls_tempName
long ll_width
String ls_tag, ls_tmp
string ls_type  //maha 11.28.2016

n_cst_AppeonDll	lnv_Appeon
string 	ls_dateformat, ls_FormulaR1C1
boolean	lb_dutch_dateformat			//adjust the date format ('dd-mm-jjjj') for dutch language...
boolean	lb_semicolon
integer	li_exists

//lnv_Appeon.of_registryget("HKEY_CURRENT_USER\Control Panel\International","sShortDate", RegString!, ls_dateformat)		//Added By Mark Lee 10/28/2013

If adw_source.rowcount()=0 Then Return ''

//adw_source.SetRedraw(False)
SetPointer( HourGlass! )
// only  tabular  grid  free
ls_DwType = adw_source.describe("Datawindow.Processing")
choose case ls_DwType 
	case '0','1'
		if adw_source.RowCount() = 0 then return ''
	case else
		//Start Code Change ----11.28.2016 #V153 maha - modified for more descriptive message
		ls_type = of_dw_type(integer(ls_DwType ))
		//messagebox('Saveas to excel',"Can't convert to excel format.") 
		messagebox('Saveas to excel',"This particular data format (" + ls_type + ") cannot be converted to Excel.")
		//End Code Change ----11.28.2016
		return ''
end choose

ls_dwsyntax=adw_source.Describe("datawindow.syntax")

lds_saveexcel=create datastore
lds_saveexcel.Create(ls_dwsyntax, ls_error)
IF Len(ls_error) > 0 THEN
	destroy lds_saveexcel
	Return ''
END IF


//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 04.29.2015
//<$>reason:New Mexico Health Case#53521, when saving to Excel the program freezes
adw_source.RowsCopy(1, adw_source.RowCount(), Primary!, lds_saveexcel, 1, Primary!)
//lds_saveexcel.object.data=adw_source.object.data
//------------------- APPEON END -------------------

If ab_xlsx Then
	// temporary  save  2003 version
	Try
			ls_tempName = gs_dir_path + gs_DefDirName + "\Temp\"
			gnv_appeondll.of_parsepath( ls_tempName)
			ls_tempName += '\temp.xls' 
				 
		if lds_saveexcel.Saveas(ls_tempName, Excel8! , ab_header)=-1 then
			destroy lds_saveexcel
			return ''
		end if
	
		lo_ExcelApp = CREATE OleObject
		ll_RC = lo_ExcelApp.ConnectToNewObject( 'Excel.Application' )
		IF ll_RC <> 0 THEN	
				destroy lds_saveexcel
				DESTROY lo_ExcelApp
				RETURN ''
		END IF
		
		lo_ExcelApp.Application.WindowState = 2
		lo_ExcelApp.Application.Visible = false
	
		lo_ExcelActiveSht = lo_ExcelApp.WorkBooks.open(ls_tempName)
	Catch(Throwable iii)
	
		if isvalid(lo_ExcelApp) then DESTROY lo_ExcelApp
		destroy lds_saveexcel
		Return ''
	End Try 
	ll_rows = adw_source.RowCount() + 1
	
	Try
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 11.11.2015
		//<$>reason:Still save xls format when as_rptname has '.xls', For issue 'Question on Option to Save As on iReport'
		//lo_ExcelActiveSht.SaveAs(as_rptname,51 )
		If Lower(RightA(as_rptname, 4)) = '.xls' Then
			lo_ExcelActiveSht.SaveAs(as_rptname,56 )
		Else //xlsx
			lo_ExcelActiveSht.SaveAs(as_rptname,51 )
		End If
		//------------------- APPEON END -------------------	
	Catch(Throwable ii)
		lo_ExcelActiveSht.Close()
		lo_ExcelApp.Application.Quit
		lo_ExcelApp.DisconnectObject()
		
		fileDelete(ls_tempName)
	
		Destroy	lo_ExcelApp
		Destroy	lo_ExcelActiveSht 
		destroy lds_saveexcel
	
		Return ''
	End Try
Else//not advantage version
	Try
					 
		if lds_saveexcel.Saveas(as_rptname, Excel8! , ab_header)=-1 then
			destroy lds_saveexcel
			return ''
		end if
	
		lo_ExcelApp = CREATE OleObject
		ll_RC = lo_ExcelApp.ConnectToNewObject( 'Excel.Application' )
		IF ll_RC <> 0 THEN	
				destroy lds_saveexcel
				DESTROY lo_ExcelApp
				RETURN ''
		END IF
		
		lo_ExcelApp.Application.WindowState = 2
		lo_ExcelApp.Application.Visible = false
	
		lo_ExcelActiveSht = lo_ExcelApp.WorkBooks.open(as_rptname)
	Catch(Throwable iiii)
	
		if isvalid(lo_ExcelApp) then DESTROY lo_ExcelApp
		destroy lds_saveexcel
		Return ''
	End Try 
	
	lo_ExcelApp.application.displayalerts = false
	
End If

/**************************************************/
//header   operation

////Ôö¼Ó±íÍ·ÐÅÏ¢ //¸ù¾ÝDw µÄÖµ£¬Ë³ÐòÉèÖÃ
if  ab_header then of_ReadTitleFromDw( adw_Source , lo_ExcelApp )

//Begin - Added By Mark Lee 10/28/2013
//adjust the date format is 'dd-mm-jjjj' for dutch language...
lb_dutch_dateformat = false 
lb_semicolon = false
Try
	lo_ExcelApp.range(of_asctochar(long(adw_source.Describe("DataWindow.Column.Count"))+1)+"2").select()
	lo_ExcelApp.range(of_asctochar(long(adw_source.Describe("DataWindow.Column.Count"))+1)+"2").FormulaR1C1 = '=Today()'

	ls_dateformat = lo_ExcelApp.range(of_asctochar(long(adw_source.Describe("DataWindow.Column.Count"))+1)+"2").NumberFormatLocal
	if not isnull(ls_dateformat) and (pos(ls_dateformat,'jj') > 0 or pos(ls_dateformat,'JJ') > 0 )	then 
		lb_dutch_dateformat = true
	end if 
	lo_ExcelApp.Selection.Delete()
				
	lo_ExcelApp.range(of_asctochar(long(adw_source.Describe("DataWindow.Column.Count"))+2)+"2").select()
	lo_ExcelApp.range(of_asctochar(long(adw_source.Describe("DataWindow.Column.Count"))+2)+"2").FormulaR1C1 =  '=IF(1=2,1, 2)' 	//lb_semicolon = true
	
	if AppeonGetClientType() = 'WEB' then			//the web cannot support the try...catch case.
		li_exists  =integer(lo_ExcelApp.range(of_asctochar(long(adw_source.Describe("DataWindow.Column.Count"))+2)+"2").Value)
		if not isnull(li_exists) and li_exists = 2 then 
		else
			lb_semicolon = true
		end if 
	end if 	

	lo_ExcelApp.Selection.Delete()
Catch (Throwable cc)
	lb_semicolon = true

End Try
//End - Added By Mark Lee 10/28/2013


//of_SetProgress(0.65) //0.65
//ls_LastCol ='E'   //default Öµ
Try
	//xlsx  find  char that is exceed 255 word  

//	If ab_xlsx Then 
		This.of_Findandreplacechar( lo_ExcelApp, lds_saveexcel,  ab_header )
//	End If

	
	if ls_DwType <> '3' then
		//ÉèÖÃÑÚÂëÏÔÊ¾¸ñÊ½ Maintenance Jack 2006-3-6
		for ll_k=1 to long(adw_source.Describe("DataWindow.Column.Count"))
			ls_format = "?" //³õÊ¼»¯ÎªÃ»ÓÐ¸ñÊ½
			if adw_source.Describe("#"+string(ll_k)+".format")='***' then
				//lo_ExcelApp.range(of_asctochar(ll_k)+"2:"+ of_asctochar(ll_k)+string(adw_source.rowcount()+1)).Value = "***"
			else	
				//¸ñÊ½´¦Àí
				ls_edit =  adw_source.Describe("#"+string(ll_k)+".edit.style")
				choose case ls_edit
					case "editmask"
						ls_format = adw_source.Describe("#" +string(ll_k)+ ".EditMask.Mask")
						if ls_format = "?" then 
							ls_format = adw_source.Describe("#"+string(ll_k)+".format")
						end if 
					case else
						ls_format = adw_source.Describe("#"+string(ll_k)+".format")
				end choose
				
				ls_coltype = adw_source.Describe("#"+string(ll_k)+".Coltype")
				
//				//Added By Ken.Guo 04/12/2012.  Use date format with varchar field.
//				ls_tag = adw_source.Describe("#"+string(ll_k)+".Tag")
//				If Pos(Lower(ls_tag),'dateformat=') > 0 and ab_xlsx Then
//					ls_format = Mid(ls_tag, 12, Len(ls_tag))
//				End If
			
				choose case left(ls_coltype,4)
					case "deci","long","numb","real","date","time","char"
						/*
						if left(ls_coltype,4) = "char" then 
							ls_format = "@"	//ÉèÖÃÎªÎÄ±¾¸ñÊ½
						end if 
						*/
						 
						if ls_format <> "[general]" and pos(ls_format,"[") = 0 and ls_format <> "?" and ls_format <> "!" then
							try
								if lb_dutch_dateformat = true and (pos(ls_format,'y') > 0 or pos(ls_format,'Y') > 0  ) then //Added By Mark Lee 10/28/2013  d-m-jjjj u:mm, this is set for other date format.
									if pos(ls_format,'y') > 0 then 
										ls_format =	lnv_string.of_globalreplace( ls_format, 'y','j')								
									elseif pos(ls_format,'Y') > 0 then 
										ls_format =	lnv_string.of_globalreplace( ls_format, 'Y','J')								
									end if 
								end if 
								lo_ExcelApp.range(of_asctochar(ll_k)+"2:"+of_asctochar(ll_k)+string(adw_source.rowcount()+1)).NumberFormatLocal = ls_format									
							Catch(Throwable e)
								if Handle(getApplication()) = 0 then 
									messageBox("debug","Error:" + e.text)
								end if 
							end try
						end if 
				end choose
	
			end if
			
			//ÈÕÆÚ¸ñÊ½×Ö¶ÎÁí´æÎªExcelºó¶¼ÈÏÎªÊÇÎÄ±¾ÀàÐÍ£¬Òò´Ë¼´Ê¹ÉèÖÃÁËÈÕÆÚ¸ñÊ½Ò²Ã»ÓÐÓÃ
			//Ëã·¨£ºÔÚÈÕÆÚÁÐÇ°Ãæ²åÈëÒ»ÐÂÁÐ£¬²¢ÉèÖÃÎªÈÕÆÚÁÐµÄÈÕÆÚ¸ñÊ½£¬ÔÙ½«ÐÂÁÐµÄÊý¾Ý¿½µ½µ±Ç°ÈÕÆÚÁÐ¡£ÕâÑùÍê³ÉÎÄ±¾µ½ÈÕÆÚµÄ×ª»»
			//Maintenance Jack 2006-3-6
			if lower(left(adw_source.Describe("#"+string(ll_k)+".ColType"),3)) = 'dat' and (ls_format <> "[general]" and pos(ls_format,"[") = 0 and ls_format <> "?" and ls_format <> "!")  & 
			   Or Pos(Lower(ls_format), 'mm') > 0 then  //Added By Ken.Guo 04/12/2012.  Some varchar field include Date Format data. e.g. Contract Browse Report.
				lo_ExcelApp.range(of_asctochar(ll_k)+"2:"+of_asctochar(ll_k)+"2").select()
				lo_ExcelApp.Selection.EntireColumn.Insert
				lo_ExcelApp.range(of_asctochar(ll_k)+"2").NumberFormatLocal = lo_ExcelApp.range(of_asctochar(ll_k +1)+"2").NumberFormatLocal 	
				ls_FormulaR1C1 =  '=IF(RC[1]="","",IF(Len(RC[1])>19,VALUE(left(RC[1],19)),VALUE(RC[1])))'
				if lb_semicolon = true then 	//Added By Mark Lee 10/28/2013
					ls_FormulaR1C1 = lnv_string.of_globalreplace( ls_FormulaR1C1, ',',';')								
				end if 
				lo_ExcelApp.ActiveCell.FormulaR1C1 = ls_FormulaR1C1 //¼ÓIF ÓïÑÔ£¬±ÜÃâ½«¿ÕÖµ±äÎª1900-1-0 "=value(RC[1])"
				if adw_source.rowcount() > 1 then
					lo_ExcelApp.Selection.AutoFill(lo_ExcelApp.Range(of_asctochar(ll_k)+"2:"+of_asctochar(ll_k)+string(adw_source.rowcount()+1)))
				end if
				lo_ExcelApp.Range(of_asctochar(ll_k)+"2:"+of_asctochar(ll_k)+string(adw_source.rowcount()+1)).Select()
				lo_ExcelApp.Selection.Copy()
				lo_ExcelApp.Range(of_asctochar(ll_k+1)+"2:"+of_asctochar(ll_k+1)+"2").Select()
				lo_ExcelApp.Selection.PasteSpecial(-4163)
				lo_ExcelApp.columns( of_asctochar(ll_k)+ ":" + of_asctochar(ll_k)).select()
				lo_ExcelApp.Application.CutCopyMode = False
				lo_ExcelApp.Selection.Delete()		
			end if
			
			//Set column width - jervis 05.26.2010
			ll_width = long(adw_source.Describe("#"+string(ll_k)+".width"))
			//Unit of Excel column width is 1/10 inch
			//1 inch = 2.54cm
			//1 Pixel = 0.26 mm
			ll_width = UnitsToPixels(ll_width,XUnitsToPixels! ) *0.26/2.54
			lo_ExcelApp.columns( of_asctochar(ll_k)).ColumnWidth = ll_width
			
		next
	end if
Catch(Throwable ff)
	gnv_debug.of_output( true,"n_cst_excel() throwable: "+ff.text)				//Added By Mark Lee 10/28/2013
	lo_ExcelActiveSht.Close()
	lo_ExcelApp.Application.Quit
	lo_ExcelApp.DisconnectObject()
	
	fileDelete(ls_tempName)

	Destroy	lo_ExcelApp
	Destroy	lo_ExcelActiveSht 
	destroy lds_saveexcel
	//of_addProgress(0.99)
	Return ''
End Try

Try
	lo_ExcelApp.range("A1" ).Select() //°Ñ¹â±êÉèÖÃ»ØµÚÒ»¸ñ
	If ab_xlsx Then
		lo_ExcelActiveSht.Save()
	Else
		lo_ExcelActiveSht.Saveas( as_rptname, 1 )
	End If
Catch(Throwable ee)
End Try

lo_ExcelActiveSht.Close()
lo_ExcelApp.Application.Quit
lo_ExcelApp.DisconnectObject()
fileDelete(ls_tempName)



DESTROY lo_ExcelApp
Destroy	lo_ExcelActiveSht 
destroy lds_saveexcel

//of_addProgress(0.05) //1.00
if ib_read = true then //(Appeon)Stephen 06.16.2017 - V15.4-WebView Reporting Functionality
	of_open_file(as_rptname) //Added By Ken.Guo 2010-09-13.
end if
RETURN as_RptName

end function

public subroutine of_readtitlefromdw (datastore adw, oleobject ao_excelapp);//u_dw replaced to datastore   ///Modified by (Appeon)Gavin 12.07.2017 for V16.1  Export and excel

oleObject	lo_ExcelActiveSht
string		ls_title , ls_col , ls_Sum,ls_type
integer	   li , li_ColCount
long			ll_Rowcount

lo_ExcelActiveSht = ao_ExcelApp.ActiveSheet
lo_ExcelActiveSht.Rows("1:1").Select()
//ao_ExcelApp.Selection.Insert()

li_ColCount = integer(adw.Describe("datawindow.Column.Count"))
ll_Rowcount = adw.RowCount() + 2
For li = 1 to li_ColCount
	ls_title = ''
	ls_Sum 	= ''
	ls_col = adw.Describe("#" + string(li) + ".name")
	
	ls_Type = adw.Describe( ls_Col + "_t.type" )
	if ls_type = 'compute' or ls_type = 'column' then
//		ls_title = adw.Describe("Evaluate('" + ls_col + "_t',1)")

      ls_title=ls_col
	else
		ls_title = inv_string.of_globalReplace(inv_string.of_globalReplace(adw.Describe(ls_col + "_t.text" ),'~r~n',''),'"','')
	end if
	
	if ls_title <> '!' and ls_title <> '' then
		lo_ExcelActiveSht.cells[1,li].value = ls_title
	end if
	
	//¼ì²éÊÇ·ñÓÐºÏ¼ÆÁÐ
	ls_type = adw.Describe( ls_Col + '_sum.type')
	if ls_type = 'text' then
		ls_Sum = adw.Describe( ls_col + '_sum.Text')
	elseif ( ls_type = 'compute' or ls_type = 'column') then
		ls_Sum = adw.Describe( "Evaluate('" + ls_col + "_sum',1)")
	end if
	
	if ls_sum <> '!' and ls_sum <> '?' then
		lo_ExcelActiveSht.cells[ll_rowcount,li].value = ls_Sum
	end if

Next



end subroutine

public function string of_saveas_excel (datawindow adw_source, string as_rptname, boolean ab_header, boolean ab_xlsx);/********************************************************************
[Description]  EXport to excel format file
//modified by gavins 20120411
********************************************************************/
datastore lds_saveexcel
string ls_dwtype
n_cst_string lnv_string

string ls_dwsyntax,ls_error

oleobject lo_ExcelApp
oleobject lo_ExcelActiveSht
long ll_rc,ll_rows
string ls_LastCol,ls_format
long ll_k 
string ls_edit
string ls_coltype
integer li_cols,li_inserted
string ls_col,ls_colname
long ll_x,ll_multi,ll_summaryrow
string ls_tempName
long ll_width
String ls_tag, ls_tmp
string ls_type  //maha 11.28.2016

n_cst_AppeonDll	lnv_Appeon
string 	ls_dateformat, ls_FormulaR1C1
boolean	lb_dutch_dateformat			//adjust the date format ('dd-mm-jjjj') for dutch language...
boolean	lb_semicolon
integer	li_exists

//lnv_Appeon.of_registryget("HKEY_CURRENT_USER\Control Panel\International","sShortDate", RegString!, ls_dateformat)		//Added By Mark Lee 10/28/2013

If adw_source.rowcount()=0 Then Return ''

//adw_source.SetRedraw(False)
SetPointer( HourGlass! )
// only  tabular  grid  free
ls_DwType = adw_source.describe("Datawindow.Processing")
choose case ls_DwType 
	case '0','1'
		if adw_source.RowCount() = 0 then return ''
	case else
		//Start Code Change ----11.28.2016 #V153 maha - modified for more descriptive message
		ls_type = of_dw_type(integer(ls_DwType ))
		//messagebox('Saveas to excel',"Can't convert to excel format.") 
		messagebox('Saveas to excel',"This particular data format (" + ls_type + ") cannot be converted to Excel.")
		//End Code Change ----11.28.2016
		return ''
end choose

ls_dwsyntax=adw_source.Describe("datawindow.syntax")

lds_saveexcel=create datastore
lds_saveexcel.Create(ls_dwsyntax, ls_error)
IF Len(ls_error) > 0 THEN
	destroy lds_saveexcel
	Return ''
END IF

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 04.29.2015
//<$>reason:New Mexico Health Case#53521, when saving to Excel the program freezes
adw_source.RowsCopy(1, adw_source.RowCount(), Primary!, lds_saveexcel, 1, Primary!)
//lds_saveexcel.object.data=adw_source.object.data
//------------------- APPEON END -------------------

If ab_xlsx Then
	// temporary  save  2003 version
	Try
			ls_tempName = gs_dir_path + gs_DefDirName + "\Temp\"
			gnv_appeondll.of_parsepath( ls_tempName)
			ls_tempName += '\temp.xls' 
				 
		if lds_saveexcel.Saveas(ls_tempName, Excel8! , ab_header)=-1 then
			destroy lds_saveexcel
			return ''
		end if
	
		lo_ExcelApp = CREATE OleObject
		ll_RC = lo_ExcelApp.ConnectToNewObject( 'Excel.Application' )
		IF ll_RC <> 0 THEN	
				destroy lds_saveexcel
				DESTROY lo_ExcelApp
				RETURN ''
		END IF
		
		lo_ExcelApp.Application.WindowState = 2
		lo_ExcelApp.Application.Visible = false
	
		lo_ExcelActiveSht = lo_ExcelApp.WorkBooks.open(ls_tempName)
	Catch(Throwable iii)
	
		if isvalid(lo_ExcelApp) then DESTROY lo_ExcelApp
		destroy lds_saveexcel
		Return ''
	End Try 
	ll_rows = adw_source.RowCount() + 1
	
	Try
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 11.11.2015
		//<$>reason:Still save xls format when as_rptname has '.xls', For issue 'Question on Option to Save As on iReport'
		//lo_ExcelActiveSht.SaveAs(as_rptname,51 )
		If Lower(RightA(as_rptname, 4)) = '.xls' Then
			lo_ExcelActiveSht.SaveAs(as_rptname,56 )
		Else //xlsx
			lo_ExcelActiveSht.SaveAs(as_rptname,51 )
		End If
		//------------------- APPEON END -------------------	
	Catch(Throwable ii)
		lo_ExcelActiveSht.Close()
		lo_ExcelApp.Application.Quit
		lo_ExcelApp.DisconnectObject()
		
		fileDelete(ls_tempName)
	
		Destroy	lo_ExcelApp
		Destroy	lo_ExcelActiveSht 
		destroy lds_saveexcel
	
		Return ''
	End Try
Else//not advantage version
	Try
					 
		if lds_saveexcel.Saveas(as_rptname, Excel8! , ab_header)=-1 then
			destroy lds_saveexcel
			return ''
		end if
	
		lo_ExcelApp = CREATE OleObject
		ll_RC = lo_ExcelApp.ConnectToNewObject( 'Excel.Application' )
		IF ll_RC <> 0 THEN	
				destroy lds_saveexcel
				DESTROY lo_ExcelApp
				RETURN ''
		END IF
		
		lo_ExcelApp.Application.WindowState = 2
		lo_ExcelApp.Application.Visible = false
	
		lo_ExcelActiveSht = lo_ExcelApp.WorkBooks.open(as_rptname)
	Catch(Throwable iiii)
	
		if isvalid(lo_ExcelApp) then DESTROY lo_ExcelApp
		destroy lds_saveexcel
		Return ''
	End Try 
	
	lo_ExcelApp.application.displayalerts = false
	
End If

/**************************************************/
//header   operation

////Ôö¼Ó±íÍ·ÐÅÏ¢ //¸ù¾ÝDw µÄÖµ£¬Ë³ÐòÉèÖÃ
if  ab_header then of_ReadTitleFromDw( adw_source , lo_ExcelApp )

//Begin - Added By Mark Lee 10/28/2013
//adjust the date format is 'dd-mm-jjjj' for dutch language...
lb_dutch_dateformat = false 
lb_semicolon = false
Try
	lo_ExcelApp.range(of_asctochar(long(adw_source.Describe("DataWindow.Column.Count"))+1)+"2").select()
	lo_ExcelApp.range(of_asctochar(long(adw_source.Describe("DataWindow.Column.Count"))+1)+"2").FormulaR1C1 = '=Today()'

	ls_dateformat = lo_ExcelApp.range(of_asctochar(long(adw_source.Describe("DataWindow.Column.Count"))+1)+"2").NumberFormatLocal
	if not isnull(ls_dateformat) and (pos(ls_dateformat,'jj') > 0 or pos(ls_dateformat,'JJ') > 0 )	then 
		lb_dutch_dateformat = true
	end if 
	lo_ExcelApp.Selection.Delete()
				
	lo_ExcelApp.range(of_asctochar(long(adw_source.Describe("DataWindow.Column.Count"))+2)+"2").select()
	lo_ExcelApp.range(of_asctochar(long(adw_source.Describe("DataWindow.Column.Count"))+2)+"2").FormulaR1C1 =  '=IF(1=2,1, 2)' 	//lb_semicolon = true
	
	if AppeonGetClientType() = 'WEB' then			//the web cannot support the try...catch case.
		li_exists  =integer(lo_ExcelApp.range(of_asctochar(long(adw_source.Describe("DataWindow.Column.Count"))+2)+"2").Value)
		if not isnull(li_exists) and li_exists = 2 then 
		else
			lb_semicolon = true
		end if 
	end if 	

	lo_ExcelApp.Selection.Delete()
Catch (Throwable cc)
	lb_semicolon = true

End Try
//End - Added By Mark Lee 10/28/2013


//of_SetProgress(0.65) //0.65
//ls_LastCol ='E'   //default Öµ
Try
	//xlsx  find  char that is exceed 255 word  

//	If ab_xlsx Then 
		This.of_Findandreplacechar( lo_ExcelApp, lds_saveexcel,  ab_header )
//	End If

	
	if ls_DwType <> '3' then
		//ÉèÖÃÑÚÂëÏÔÊ¾¸ñÊ½ Maintenance Jack 2006-3-6
		for ll_k=1 to long(adw_source.Describe("DataWindow.Column.Count"))
			ls_format = "?" //³õÊ¼»¯ÎªÃ»ÓÐ¸ñÊ½
			if adw_source.Describe("#"+string(ll_k)+".format")='***' then
				//lo_ExcelApp.range(of_asctochar(ll_k)+"2:"+ of_asctochar(ll_k)+string(adw_source.rowcount()+1)).Value = "***"
			else	
				//¸ñÊ½´¦Àí
				ls_edit =  adw_source.Describe("#"+string(ll_k)+".edit.style")
				choose case ls_edit
					case "editmask"
						ls_format = adw_source.Describe("#" +string(ll_k)+ ".EditMask.Mask")
						if ls_format = "?" then 
							ls_format = adw_source.Describe("#"+string(ll_k)+".format")
						end if 
					case else
						ls_format = adw_source.Describe("#"+string(ll_k)+".format")
				end choose
				
				ls_coltype = adw_source.Describe("#"+string(ll_k)+".Coltype")
				
//				//Added By Ken.Guo 04/12/2012.  Use date format with varchar field.
//				ls_tag = adw_source.Describe("#"+string(ll_k)+".Tag")
//				If Pos(Lower(ls_tag),'dateformat=') > 0 and ab_xlsx Then
//					ls_format = Mid(ls_tag, 12, Len(ls_tag))
//				End If
			
				choose case left(ls_coltype,4)
					case "deci","long","numb","real","date","time","char"
						/*
						if left(ls_coltype,4) = "char" then 
							ls_format = "@"	//ÉèÖÃÎªÎÄ±¾¸ñÊ½
						end if 
						*/
						 
						if ls_format <> "[general]" and pos(ls_format,"[") = 0 and ls_format <> "?" and ls_format <> "!" then
							try
								if lb_dutch_dateformat = true and (pos(ls_format,'y') > 0 or pos(ls_format,'Y') > 0  ) then //Added By Mark Lee 10/28/2013  d-m-jjjj u:mm, this is set for other date format.
									if pos(ls_format,'y') > 0 then 
										ls_format =	lnv_string.of_globalreplace( ls_format, 'y','j')								
									elseif pos(ls_format,'Y') > 0 then 
										ls_format =	lnv_string.of_globalreplace( ls_format, 'Y','J')								
									end if 
								end if 
								lo_ExcelApp.range(of_asctochar(ll_k)+"2:"+of_asctochar(ll_k)+string(adw_source.rowcount()+1)).NumberFormatLocal = ls_format									
							Catch(Throwable e)
								if Handle(getApplication()) = 0 then 
									messageBox("debug","Error:" + e.text)
								end if 
							end try
						end if 
				end choose
	
			end if
			
			//ÈÕÆÚ¸ñÊ½×Ö¶ÎÁí´æÎªExcelºó¶¼ÈÏÎªÊÇÎÄ±¾ÀàÐÍ£¬Òò´Ë¼´Ê¹ÉèÖÃÁËÈÕÆÚ¸ñÊ½Ò²Ã»ÓÐÓÃ
			//Ëã·¨£ºÔÚÈÕÆÚÁÐÇ°Ãæ²åÈëÒ»ÐÂÁÐ£¬²¢ÉèÖÃÎªÈÕÆÚÁÐµÄÈÕÆÚ¸ñÊ½£¬ÔÙ½«ÐÂÁÐµÄÊý¾Ý¿½µ½µ±Ç°ÈÕÆÚÁÐ¡£ÕâÑùÍê³ÉÎÄ±¾µ½ÈÕÆÚµÄ×ª»»
			//Maintenance Jack 2006-3-6
			if lower(left(adw_source.Describe("#"+string(ll_k)+".ColType"),3)) = 'dat' and (ls_format <> "[general]" and pos(ls_format,"[") = 0 and ls_format <> "?" and ls_format <> "!")  & 
			   Or Pos(Lower(ls_format), 'mm') > 0 then  //Added By Ken.Guo 04/12/2012.  Some varchar field include Date Format data. e.g. Contract Browse Report.
				lo_ExcelApp.range(of_asctochar(ll_k)+"2:"+of_asctochar(ll_k)+"2").select()
				lo_ExcelApp.Selection.EntireColumn.Insert
				lo_ExcelApp.range(of_asctochar(ll_k)+"2").NumberFormatLocal = lo_ExcelApp.range(of_asctochar(ll_k +1)+"2").NumberFormatLocal 	
				ls_FormulaR1C1 =  '=IF(RC[1]="","",IF(Len(RC[1])>19,VALUE(left(RC[1],19)),VALUE(RC[1])))'
				if lb_semicolon = true then 	//Added By Mark Lee 10/28/2013
					ls_FormulaR1C1 = lnv_string.of_globalreplace( ls_FormulaR1C1, ',',';')								
				end if 
				lo_ExcelApp.ActiveCell.FormulaR1C1 = ls_FormulaR1C1 //¼ÓIF ÓïÑÔ£¬±ÜÃâ½«¿ÕÖµ±äÎª1900-1-0 "=value(RC[1])"
				if adw_source.rowcount() > 1 then
					lo_ExcelApp.Selection.AutoFill(lo_ExcelApp.Range(of_asctochar(ll_k)+"2:"+of_asctochar(ll_k)+string(adw_source.rowcount()+1)))
				end if
				lo_ExcelApp.Range(of_asctochar(ll_k)+"2:"+of_asctochar(ll_k)+string(adw_source.rowcount()+1)).Select()
				lo_ExcelApp.Selection.Copy()
				lo_ExcelApp.Range(of_asctochar(ll_k+1)+"2:"+of_asctochar(ll_k+1)+"2").Select()
				lo_ExcelApp.Selection.PasteSpecial(-4163)
				lo_ExcelApp.columns( of_asctochar(ll_k)+ ":" + of_asctochar(ll_k)).select()
				lo_ExcelApp.Application.CutCopyMode = False
				lo_ExcelApp.Selection.Delete()		
			end if
			
			//Set column width - jervis 05.26.2010
			ll_width = long(adw_source.Describe("#"+string(ll_k)+".width"))
			//Unit of Excel column width is 1/10 inch
			//1 inch = 2.54cm
			//1 Pixel = 0.26 mm
			ll_width = UnitsToPixels(ll_width,XUnitsToPixels! ) *0.26/2.54
			lo_ExcelApp.columns( of_asctochar(ll_k)).ColumnWidth = ll_width
			
		next
	end if
Catch(Throwable ff)
	gnv_debug.of_output( true,"n_cst_excel() throwable: "+ff.text)				//Added By Mark Lee 10/28/2013
	lo_ExcelActiveSht.Close()
	lo_ExcelApp.Application.Quit
	lo_ExcelApp.DisconnectObject()
	
	fileDelete(ls_tempName)

	Destroy	lo_ExcelApp
	Destroy	lo_ExcelActiveSht 
	destroy lds_saveexcel
	//of_addProgress(0.99)
	Return ''
End Try

Try
	lo_ExcelApp.range("A1" ).Select() //°Ñ¹â±êÉèÖÃ»ØµÚÒ»¸ñ
	If ab_xlsx Then
		lo_ExcelActiveSht.Save()
	Else
		lo_ExcelActiveSht.Saveas( as_rptname, 1 )
	End If
Catch(Throwable ee)
End Try

lo_ExcelActiveSht.Close()
lo_ExcelApp.Application.Quit
lo_ExcelApp.DisconnectObject()
fileDelete(ls_tempName)



DESTROY lo_ExcelApp
Destroy	lo_ExcelActiveSht 
destroy lds_saveexcel

//of_addProgress(0.05) //1.00
if ib_read = true then //(Appeon)Stephen 06.16.2017 - V15.4-WebView Reporting Functionality
	of_open_file(as_rptname) //Added By Ken.Guo 2010-09-13.
end if
RETURN as_RptName

end function

on n_cst_excel.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_excel.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

