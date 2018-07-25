$PBExportHeader$w_license_agreement.srw
forward
global type w_license_agreement from w_popup
end type
type st_title1 from statictext within w_license_agreement
end type
type st_footer1 from statictext within w_license_agreement
end type
type mle_1 from multilineedit within w_license_agreement
end type
type st_title2 from statictext within w_license_agreement
end type
type cb_yes from commandbutton within w_license_agreement
end type
type cb_no from commandbutton within w_license_agreement
end type
type ln_1 from line within w_license_agreement
end type
type ln_2 from line within w_license_agreement
end type
end forward

global type w_license_agreement from w_popup
integer width = 2642
integer height = 1768
string title = " LICENSE AGREEMENT "
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
st_title1 st_title1
st_footer1 st_footer1
mle_1 mle_1
st_title2 st_title2
cb_yes cb_yes
cb_no cb_no
ln_1 ln_1
ln_2 ln_2
end type
global w_license_agreement w_license_agreement

forward prototypes
public function integer of_set_asa_license ()
public function integer of_set_img_license ()
end prototypes

public function integer of_set_asa_license ();RETURN 1
end function

public function integer of_set_img_license ();//Set license info for Global Imaging 360


//Set title
st_title1.text = "The Global 360 imaging software is required by the IntelliSoft program to operate properly and was purchased as part of your IntelliSoft license agreement.  It is required that you read the license agreement and agree to the terms of the Global 360 License in order for you to use the imaging functionality of the IntelliSoft software." + "~r~n"
st_title1.text += "" + "~r~n"

st_title2.text = "ATTACHMENT III" +  "~r~n"
st_title2.text += "Global 360 License Agreement" + "~r~n"

//Set footer
st_footer1.text = "Do You Accept This Agreement? " 
st_footer1.text += "If You accept the terms and conditions of this License Agreement, click ~"Yes~". "  
st_footer1.text += "If You do not accept the terms and conditions of this License Agreement, click ~"No~", you will not be able to continue to use the program."

//Set Agreement
mle_1.text = "GLOBAL 360 LICENSE AGREEMENT " + "~r~n"
mle_1.text += "Licensed Product: Global 360 Imaging for Windows " + "~r~n"
mle_1.text += " " + "~r~n"
mle_1.text += "This is a legal agreement between You (individually or on behalf of your company) and Global 360. (~"Global 360~") for the use of the Licensed Product described above. By pressing the ~"Yes~" button below and proceeding with the installation, You confirm that (i) You have read this License Agreement, and (ii) You agree to be bound by its terms and conditions.  If You disagree with or do not accept any of the terms of this License Agreement, You may cancel this transaction by pressing the ~"No~" button below and returning the product with your receipt to the authorized supplier of Global 360 products within thirty (30) days from the date of purchase.  A full refund will be sent to You provided You return the product with a dated proof of purchase. Questions relating to this License Agreement may be submitted to chris.hedden@global360.com.or (214) 445-4160.  " + "~r~n"
mle_1.text += " " + "~r~n"
mle_1.text += "Use " + "~r~n"
mle_1.text += "You are granted a personal, nontransferable, nonexclusive license to install and use one copy of the Licensed Product on a single personal computer or workstation that is not used as a server. If you have purchased a User Pack that entitles you to multiple users, you may install and use up to the number of copies of the Licensed Product indicated. You may also make one copy of the Licensed Product for archival purposes. " + "~r~n"
mle_1.text += " " + "~r~n"
mle_1.text += "Sample Code " + "~r~n"
mle_1.text += "The Licensed Product may contain code examples (~"Sample Code~"). If the Licensed Product contains Sample Code, You are granted a royalty-free right to use, reproduce and distribute the Sample Code under the following conditions:  (i) You may not use Global 360's name, logos or trademarks in the marketing or distribution of your software product(s); and (ii) if You use any Sample Code in your software product(s), You will indemnify, defend and hold Global 360 harmless from and against any claims, actions or damages arising or resulting from the use or distribution of your software product(s). " + "~r~n"
mle_1.text += " " + "~r~n"
mle_1.text += "Right to Audit " + "~r~n"
mle_1.text += "In light of the nature of this License Agreement, Global 360 reserves the right for it or its independent auditors to inspect your systems from time to time in order to assure compliance with the terms of this License Agreement. " + "~r~n"
mle_1.text += " " + "~r~n"
mle_1.text += "Intellectual Property Rights " + "~r~n"
mle_1.text += "The Licensed Product and accompanying documentation are protected by both copyright law and international treaties. Global 360, its parent company and its suppliers own all intellectual property rights in the Licensed Product and accompanying documentation, and the structure, organization and code contain valuable trade secrets of Global 360 and its suppliers. Global 360 retains all rights not expressly granted hereunder. " + "~r~n"
mle_1.text += " " + "~r~n"
mle_1.text += "Restrictions " + "~r~n"
mle_1.text += "Except as expressly authorized by this License Agreement, You may not copy, modify, translate, reverse engineer, decompile or disassemble (except as applicable law expressly prohibits this restriction) the Licensed Product.   You may not sell, license, lend, reproduce or distribute the Licensed Product to others, or use the Licensed Product for any purpose other than internal business use.  You may, however, transfer the Licensed Product on a permanent basis provided You transfer the Licensed Product, this License Agreement and all documentation and media and You do not retain any copies.  Any transfer of the Licensed Product must include the most recent update and all prior versions. " + "~r~n"
mle_1.text += " " + "~r~n"
mle_1.text += "Limited Warranty " + "~r~n"
mle_1.text += "For a period of thirty (30) days following the date of purchase, Global 360 warrants to the original Licensee that (i) the Licensed Product will perform substantially in accordance with the accompanying documentation and (ii) the documentation and media are free from defects in materials and workmanship.  This limited warranty does not cover failures caused by accident, abuse or misapplication.  In the event of a failure of the Licensed Product or documentation to meet this limited warranty, the entire liability of Global 360 and your exclusive remedy shall be, at Global 360's sole discretion, either: (a) replacement of the Licensed Product or documentation not meeting the limited warranty, or (b) return of the fee paid, provided the Licensed Product and accompanying materials are returned to Global 360, or its licensed distributor, with a copy of your receipt from an authorized source.  Any replacement product or documentation will be warranted for the remainder of the original warranty period or ten (10) days, whichever is longer. " + "~r~n"
mle_1.text += " " + "~r~n"
mle_1.text += "EXCEPT AS SPECIFICALLY PROVIDED HEREIN, GLOBAL 360 MAKES NO WARRANTY, EITHER EXPRESS OR IMPLIED, RELATING TO THE LICENSED PRODUCT, INCLUDING BUT NOT LIMITED TO WARRANTIES OF  " + "~r~n"
mle_1.text += "MERCHANTABILITY, NONINFRINGEMENT OR FITNESS FOR A PARTICULAR PURPOSE.  NEITHER Global 360 NOR ITS SUPPLIERS WARRANTS THAT THE LICENSED PRODUCT IS ERROR-FREE, WILL OPERATE WITHOUT INTERRUPTION OR WILL WORK IN ALL COMBINATIONS SELECTED BY YOU. This limited warranty gives You specific legal rights, and You may have other rights which vary from jurisdiction to jurisdiction. " + "~r~n"
mle_1.text += " " + "~r~n"
mle_1.text += "Limitation of Liability " + "~r~n"
mle_1.text += "IN NO EVENT SHALL GLOBAL 360 OR ANY OF ITS SUPPLIERS BE LIABLE FOR SPECIAL, INCIDENTAL, CONSEQUENTIAL OR INDIRECT DAMAGES (INCLUDING, BUT NOT LIMITED TO, COSTS OF PROCURING SUBSTITUTE PRODUCTS OR SERVICES, DAMAGES FOR LOSS OF PROFITS OR REVENUE, BUSINESS INTERRUPTION, LOSS OF INFORMATION OR OTHER PECUNIARY LOSS) ARISING OUT OF THE USE OR INABILITY TO USE THE LICENSED PRODUCT, HOWEVER CAUSED AND UNDER ANY THEORY OF LIABILITY, EVEN IF GLOBAL 360 HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.  IN NO EVENT SHALL GLOBAL 360'S LIABILITY FOR MONEY DAMAGES EXCEED THE AMOUNT PAID BY YOU FOR THE LICENSED PRODUCT FROM WHICH THE CLAIM AROSE.  Some jurisdictions do not allow the exclusion or limitation of liability for consequential or incidental damages, so the above limitation may not apply to You. " + "~r~n"
mle_1.text += " " + "~r~n"
mle_1.text += "Proprietary Rights Infringement " + "~r~n"
mle_1.text += "Global 360 shall defend any claim, suit or proceeding and pay any settlement amounts or damages awarded by a court of final jurisdiction arising out of claims by third parties that the Licensed Product infringes any U.S. patent, copyright or trademark, provided that You promptly notify Global 360 of the claim in writing and permit Global 360 to control the defense or settlement of such claim and cooperate in the defense or settlement thereof. You shall have the option of being represented by counsel at your own expense. If as a result of any such claim, your right to use the Licensed Product is revoked by a court of competent jurisdiction, Global 360, at its expense and sole discretion, shall do one of the following:  " + "~r~n"
mle_1.text += "(i) obtain for You the right to continue using the Licensed Product; (ii) provide You with a replacement or modified product with substantially the same functionality as the Licensed Product; or (iii) provide You with a refund in exchange for termination of your right to use the Licensed Product.  If a refund is provided within four years of the date of delivery of the Licensed Product, the amount shall be the original purchase price of the infringing product as amortized on a straight-line basis over a four-year period from the date of delivery. " + "~r~n" 
mle_1.text += "  " + "~r~n"
mle_1.text += "Global 360's obligations under this section shall not apply to claims of infringement based upon: (i) use of other than the latest unmodified release of the Licensed Product made available by Global 360 or its authorized reseller to You, if such infringement would have been avoided by the use of such release of the Licensed Product, (ii) combination, operation or use of the Licensed Product with any non-Global 360 programs or data, if such infringement would not have occurred without such combination, operation or use, or (iii) use of the Licensed Product after receiving written notice from Global 360 that the Licensed Product infringes a U.S. patent, copyright or trademark of a third party.  Global 360's obligations under this section constitute your sole and exclusive remedy for a claim of intellectual property infringement.  " + "~r~n"
mle_1.text += " " + "~r~n"
mle_1.text += "Right of Termination " + "~r~n"
mle_1.text += "Global 360 has the right to terminate this License Agreement if You fail to adhere to the terms and conditions of this License Agreement.  Upon termination for any reason, You must destroy all copies of the Licensed Product in your possession. " + "~r~n"
mle_1.text += " " + "~r~n"
mle_1.text += "U.S. Government Restricted Rights " + "~r~n"
mle_1.text += "The Licensed Product and accompanying documentation are Commercial Computer Software and documentation as defined under Federal Acquisition Regulations and agency supplements to them.  Use, duplication or disclosure by the U.S. Government is subject to the restrictions of these licensing terms and conditions as prescribed in DFAR 227.7202-3(a) and DFAR 227.7202-4 or, as applicable, the Commercial Computer Software Restricted Rights clause at FAR 52.227-19.  Manufacturer is Global 360, 5400 LBJ Freeway, 3rd Floor, Dallas TX 75240, USA. " + "~r~n"
mle_1.text += " " + "~r~n"
mle_1.text += "Governing Law and General Provisions " + "~r~n"
mle_1.text += "The laws of the State of New York, United States of America, to whose jurisdiction You consent, shall govern this License Agreement.  The United Nations Convention on Contracts for the International Sale of Goods shall not apply to this License Agreement. The Licensed Product may be subject to U.S. Department of Commerce export regulations.  It is your responsibility to comply with all such regulations. If any part of this License Agreement is found void or unenforceable, it will not affect the validity of the balance of the License Agreement, which shall remain valid and enforceable according to its terms.  This License Agreement constitutes the entire agreement between Global 360 and You concerning the Licensed Product and documentation and supersedes all prior communications, agreements and understandings, written or oral, between Global 360 and You. "

RETURN 1
end function

event open;call super::open;String ls_product

ls_product = Message.Stringparm

CHOOSE CASE Lower(ls_product)
	CASE "global 360"
		of_set_img_license()
	CASE "sybase asa"
		of_set_asa_license()
	CASE ELSE
			
END CHOOSE

end event

on w_license_agreement.create
int iCurrent
call super::create
this.st_title1=create st_title1
this.st_footer1=create st_footer1
this.mle_1=create mle_1
this.st_title2=create st_title2
this.cb_yes=create cb_yes
this.cb_no=create cb_no
this.ln_1=create ln_1
this.ln_2=create ln_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_title1
this.Control[iCurrent+2]=this.st_footer1
this.Control[iCurrent+3]=this.mle_1
this.Control[iCurrent+4]=this.st_title2
this.Control[iCurrent+5]=this.cb_yes
this.Control[iCurrent+6]=this.cb_no
this.Control[iCurrent+7]=this.ln_1
this.Control[iCurrent+8]=this.ln_2
end on

on w_license_agreement.destroy
call super::destroy
destroy(this.st_title1)
destroy(this.st_footer1)
destroy(this.mle_1)
destroy(this.st_title2)
destroy(this.cb_yes)
destroy(this.cb_no)
destroy(this.ln_1)
destroy(this.ln_2)
end on

event pfc_postopen;//Commented by (Appeon)Harry 11.07.2013 - V141 ISG-CLX  BugH102401 cancel extend ancestorscript
end event

type st_title1 from statictext within w_license_agreement
integer x = 50
integer y = 36
integer width = 2528
integer height = 216
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type st_footer1 from statictext within w_license_agreement
integer x = 50
integer y = 1380
integer width = 2528
integer height = 164
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type mle_1 from multilineedit within w_license_agreement
integer x = 50
integer y = 400
integer width = 2528
integer height = 960
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_title2 from statictext within w_license_agreement
integer x = 50
integer y = 280
integer width = 2528
integer height = 108
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_yes from commandbutton within w_license_agreement
integer x = 1893
integer y = 1584
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Yes"
end type

event clicked;ClosewithReturn(Parent, "1")
end event

type cb_no from commandbutton within w_license_agreement
integer x = 2235
integer y = 1584
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&No"
end type

event clicked;ClosewithReturn(Parent, "-1")
end event

type ln_1 from line within w_license_agreement
long linecolor = 1073741824
integer linethickness = 4
integer beginy = 256
integer endx = 2802
integer endy = 256
end type

type ln_2 from line within w_license_agreement
long linecolor = 1073741824
integer linethickness = 4
integer beginy = 1560
integer endx = 2793
integer endy = 1560
end type

