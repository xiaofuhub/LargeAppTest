$PBExportHeader$w_agreement_template_preview.srw
forward
global type w_agreement_template_preview from w_popup
end type
type ole_1 from u_email_edit within w_agreement_template_preview
end type
end forward

global type w_agreement_template_preview from w_popup
integer width = 4078
integer height = 2216
string title = "Agreement Template Preview"
long backcolor = 33551856
boolean center = true
ole_1 ole_1
end type
global w_agreement_template_preview w_agreement_template_preview

type variables
string is_chapter[] = {"##","@@"}
string is_paragraph = "#.0"
string is_section = "#.#"

//WdFindWrap
Constant int wdFindAsk = 2 
Constant int wdFindContinue = 1 
Constant int wdFindStop = 0 

//WdReplace
Constant int wdReplaceAll = 2 
Constant int wdReplaceNone = 0 
Constant int wdReplaceOne = 1 

Constant int wdColorBlack = 0 //04.22.2008
end variables

forward prototypes
public function integer of_preview (string as_filename)
end prototypes

public function integer of_preview (string as_filename);integer i, j, li_chapter, li_paragraph, li_section
long ll_pos_paragraph,ll_pos_section, ll_cnt, ll_bookmark, ll_start,ll_end
string ls_mark,ls_replace
boolean lb_found_chapter, lb_found_paragraph, lb_found_section
oleobject lole_word
n_cst_word_utility lnv_word

if not fileexists(as_filename) then return -1

ole_1.object.openlocalfile(as_filename,false)

if ole_1.object.DocType < 1 then return -1

lole_word = ole_1.object.ActiveDocument
//---------Begin Added by (Appeon)Harry 03.12.2014 for V142 ISG-CLX--------
gnv_word_utility.of_modify_word_property( lole_word)	//Added By Mark Lee 06/20/2013 change for office 2013.
//---------End Added ------------------------------------------------------

//-----------Begin Added By alfee on 04.22.2008---------
//Set default color property for hyperlink field
Boolean ib_changed = FALSE //04.22.2008
FOR i =  1 TO lole_word.Styles.Count
	IF lole_word.Styles.Item[i].NameLocal = "FollowedHyperlink" THEN
		lole_word.Styles.Item[i].Font.Color = wdColorBlack
		IF ib_changed THEN EXIT
		ib_changed = TRUE
	END IF
	IF lole_word.Styles.Item[i].NameLocal = "Hyperlink" THEN
		lole_word.Styles.Item[i].Font.Color = wdColorBlack
		IF ib_changed THEN EXIT
		ib_changed = TRUE
	END IF		
NEXT
//-----------End Added---------------------------------------

setpointer(HourGlass!)
this.setredraw(false)

lnv_word = create n_cst_word_utility
//auto numbering for document
lnv_word.of_preview(lole_word, True) 
destroy lnv_word

this.setredraw(true)


return 1
end function

on w_agreement_template_preview.create
int iCurrent
call super::create
this.ole_1=create ole_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_1
end on

on w_agreement_template_preview.destroy
call super::destroy
destroy(this.ole_1)
end on

event open;call super::open;string ls_filename 

gnv_reg_ocx.of_check_ocx( 1,'', True) //1: office //Added by Ken.Guo on 2008-11-06

ls_filename = message.stringparm

if isnull(ls_filename) or len(trim(ls_filename)) < 1 then return -1

//preview template file
openwithparm( w_appeon_gifofwait, "Previewing template file ..." )
of_preview(ls_filename) 
if isvalid( w_appeon_gifofwait) then close(w_appeon_gifofwait)

//-----Begin Added by Alfee 05.28.2007 -----------------------
If isValid(w_agreement_template_painter) THEN
	w_agreement_template_painter.enabled = false
	w_agreement_template_painter.of_menu_security("others")
END If
//-----End Added ---------------------------------------------
end event

event pfc_preopen;call super::pfc_preopen;long ll_i
string ls_scale

This.of_SetResize(True)

This.inv_resize.of_SetOrigSize (This.workspacewidth(),This.workspaceheight())
ls_scale = this.inv_resize.scale

For ll_i =  1 To upperbound(This.CONTrol)
   This.inv_resize.of_Register (This.CONTrol[ll_i],ls_scale)
Next

end event

event close;call super::close;if isvalid(w_agreement_template_painter) then
		w_agreement_template_painter.enabled = true
		w_agreement_template_painter.of_menu_security("detail")
		w_agreement_template_painter.setfocus()
end if
end event

event activate;call super::activate;//Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
If gs_imageview_version = '5.0' and isvalid(ole_1 ) Then
	ole_1.object.activate(true)
End If
end event

event deactivate;call super::deactivate;//Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
//If gs_imageview_version = '5.0' and isvalid(ole_1 ) Then
//	ole_1.object.activate(false)
//End If
end event

type ole_1 from u_email_edit within w_agreement_template_preview
integer x = 23
integer y = 24
integer width = 3995
integer height = 2068
integer taborder = 10
string binarykey = "w_agreement_template_preview.win"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
01w_agreement_template_preview.bin 
2600000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000005e42c7b001d1312900000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d3000000005e42c7b001d131295e42c7b001d131290000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
26ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd00005a550000356f00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd00005a550000356f00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11w_agreement_template_preview.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
