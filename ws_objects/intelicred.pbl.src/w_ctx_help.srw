$PBExportHeader$w_ctx_help.srw
$PBExportComments$[intellicontract_w] Contract Help window
forward
global type w_ctx_help from w_response
end type
type ole_1 from olecustomcontrol within w_ctx_help
end type
end forward

global type w_ctx_help from w_response
integer width = 2811
integer height = 2896
ole_1 ole_1
end type
global w_ctx_help w_ctx_help

forward prototypes
public function integer of_create_help ()
public function integer wf_cpt_code_hlp ()
public function integer of_create_help2 ()
end prototypes

public function integer of_create_help ();
string ls_help 


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.13.2006 By: LeiWei
//$<reason> Replace help text.
/*
ls_help = "<html>" + &
'<head>' + &
'<title>Contract Alarms Help</title>' + &
'</head>' + &
'<body bgcolor="#d8bfd8">' + &
'<p align="center">&nbsp;</p>' + &
'<p align="center"><b><font face="Arial" size="2">Contract Alarms Help</font></b></p>' + &
'<p align="left">&nbsp;</p>' + &
'<p align="left"><font face="Arial" size="2">The purpose of this window is for' + &
' the user to set up automatic email notifications when a specific date is coming' + &
' due for action. Below is a brief explanation of the fields found on this window.</font></p>' + &
'<p align="left"><font face="Arial" size="2"><b><u>Alarm Notification days </u>:</b>&nbsp;' + &
'The number of days the alarm will function prior to the date</font></p>' + &
'<p align="left"><font face="Arial" size="2"><b><u>Alarm Frequency:</u></b> The' + &
' number of days between the alarm notices. That is 1 - every day, 2- every other' + &
' day.</font></p>' + &
'<p align="left"><font face="Arial" size="2"><b><u>Alarm Enabled:</u>&nbsp;</b>' + &
'Flag that indicated weather of not the alarm is active</font></p>' + &
'<p align="left"><font face="Arial" size="2"><b><u>Create Action Item:&nbsp;</u></b>' + &
'Indicates weather or an Action Item will be created.</font></p>' + &
'<p align="left"><font face="Arial" size="2"><b><u>Times to send:</u></b> The' + &
' maximum amount of&nbsp; times this message will be sent.</font></p>' + &
'<p align="left"><font face="Arial" size="2"><b><u>Alarm message:</u></b>&nbsp;' + &
'The message that will be displayed in the email when the alarm is run.</font></p>' + &
'<p align="left"><font face="Arial" size="2"><b><u>Notification users:</u></b>' + &
' Users that will be notified when the alarm is run. To set up an email address for a user go to' + &
' System | Painters | User Painter, select a user in the <u>Select User</u> drop down, ' + &
'enter an email address in the <u>Email ID</u> &nbsp; field and' + &
' save. </font></p>' + &
'<p align="left">&nbsp;</p>' + &
'<p align="left">&nbsp;</p>' + &
'</body>' + &
'</html>' 
*/

ls_help = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">' + &
'<html xmlns:o>' + &
'<head>' + &
'<title></title>' + &
'<meta name="GENERATOR" content="Microsoft Visual Studio.NET 7.0">' + &
'<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">' + &
'</head>' + &
'<body bgcolor="#d8bfd8">' + &
'<P style="TEXT-ALIGN: center" align="center"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Contract ' + &
'Alarms Help</SPAN></B></P>' + &
'<P><SPAN lang="EN-US">&nbsp;</SPAN><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Use ' + &
'the Contract Alarms window to set up automatic email notifications when a ' + &
'specific date is coming due for action. Below is a brief explanation of the ' + &
'fields found on this window.</SPAN></P>' + &
'<TABLE class="MsoNormalTable" id="Table1" style="MARGIN-LEFT: 41.4pt; BORDER-COLLAPSE: collapse; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt" cellSpacing="0" cellPadding="0" border="2" borderColor="black" borderColorDark="black" borderColorLight="black">' + &
'<TR style="mso-yfti-irow: 0; mso-yfti-firstrow: yes">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Alarm ' + &
'Notification Days' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">The ' + &
'number of days before the date specified in the Contract Dates field to send ' + &
'the first notification.' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 1">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Times ' + &
'to Send' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">The ' + &
'maximum number of times this notification will be sent.' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 2">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Alarm ' + &
'Frequency' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">The ' + &
'number of days between alarm notices, for example:' + &
'<o:p></o:p></SPAN></P>' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">1 ' + &
'= every day' + &
'<o:p></o:p></SPAN></P>' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">2 ' + &
'= every other day' + &
'<o:p></o:p></SPAN></P>' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">7 ' + &
'= once a week' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 3">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Times ' + &
'Sent' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Filled ' + &
'in by IntelliContract. Indicates number of times email has been sent.' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 4">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Notification ' + &
'Last Sent' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Filled ' + &
'in by IntelliContract. Date and time of last email notification.' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 6">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Alarm ' + &
'Enabled' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Flag ' + &
'that indicates whether or not the alarm is enabled.' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 7">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Alarm ' + &
'Message' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">The ' + &
'message that will be displayed in the email generated by the alarm.' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 5">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Create ' + &
'Action Item' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Indicates ' + &
'whether or not an Action Item will be created. ' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 5">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Auto ' + &
'Increment Date By' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Automatically ' + &
'increment a Date field that the alarm is associated with by a given amount of time once the Alarm Action Item Status field is completed. ' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 8; mso-yfti-lastrow: yes">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Notification ' + &
'Users' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Users ' + &
'who will be notified. Only users set up in the User Painter may be ' + &
'selected. Users must have an email address in the Email ID field in User ' + &
'Painter.' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'</TABLE>' + &
'</body>' + &
'</html>'

//---------------------------- APPEON END ----------------------------

				
integer li_FileNum
li_FileNum = FileOpen(gnv_app.is_application_path +'\'+ "help.html",StreamMode!, Write!, LockWrite!, Replace!)
FileWrite ( li_FileNum, ls_help )
FileClose ( li_FileNum )
ole_1.object.Navigate( gnv_app.is_application_path +'\'+ "help.html" )


return 0
end function

public function integer wf_cpt_code_hlp ();
string ls_help 

 ls_help = "<html>" + &
'<head>' + &
'<meta http-equiv="Content-Language" content="en-us">' + &
'<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">' + &
'<meta name="GENERATOR" content="Microsoft FrontPage 4.0"> ' + &
'<meta name="ProgId" content="FrontPage.Editor.Document"> ' + &
'<title>CPT Code Help</title> ' + &
'</head>' + &
'<body bgcolor="#FFFFCC">' + &
'<p align="center">CPT Code Help</p>' + &
'<p align="left"><b>CPT Code Import:</b></p>' + &
'<p align="left"><b>&nbsp;</b>The CPT code import utility assumes that the user ' + &
'in importing a text file with two columns. The first column assumes a five digit ' + &
'code followed by a space/tab and the description.</p>' + &
'<p align="left">The format should look like this:</p>' + &
'<p align="left">20950 Monitoring of interstitial fluid pressure (includes insertion of ' + &
'devices wick catheter technique  needle manometer technique)&nbsp;</p>' + &
'<p align="left"><br>' + &
'If the current list is in an Excel spread sheet save the file in text format. ' + &
'Then import the codes.&nbsp;</p>' + &
'<p align="left"><b>Template Creation:</b></p>' + &
'<p align="left">After CPT&nbsp; codes have imported the user can then make a ' + &
'template. The template is used in the Medical fee schedules.</p>' + &
'<p align="left">from the menu select System | Painters| Contact | CPT Code | and ' + &
'select the templates tab. At the top of the window click insert to create a new ' + &
'template. Give the template a name click save. After saved is clicked the CPT ' + &
'codes will populate. The user can check off the codes required for saving.</p> ' + &
'</body>' + &
'</html>' 
integer li_FileNum
li_FileNum = FileOpen(gnv_app.is_application_path +'\'+ "help.html",StreamMode!, Write!, LockWrite!, Replace!)
FileWrite ( li_FileNum, ls_help )
FileClose ( li_FileNum )
ole_1.object.Navigate( gnv_app.is_application_path +'\'+ "help.html" )

return 0
end function

public function integer of_create_help2 ();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.27.2007 By: Evan
//$<reason> w_ctx_alram UI change.

string ls_help
integer li_FileNum

ls_help = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">' + &
'<html xmlns:o>' + &
'<head>' + &
'<title></title>' + &
'<meta name="GENERATOR" content="Microsoft Visual Studio.NET 7.0">' + &
'<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">' + &
'</head>' + &
'<body bgcolor="#d8bfd8">' + &
'<P style="TEXT-ALIGN: center" align="center"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Contract ' + &
'Alarms Help</SPAN></B></P>' + &
'<P><SPAN lang="EN-US">&nbsp;</SPAN><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Use ' + &
'the Contract Alarms window to set up automatic email notifications when a ' + &
'specific date is coming due for action. Below is a brief explanation of the ' + &
'fields found on this window.</SPAN></P>' + &
'<TABLE class="MsoNormalTable" id="Table1" style="MARGIN-LEFT: 41.4pt; BORDER-COLLAPSE: collapse; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt" cellSpacing="0" cellPadding="0" border="2" borderColor="black" borderColorDark="black" borderColorLight="black">' + &
'<TR style="mso-yfti-irow: 6">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Alarm ' + &
'Enabled' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Flag ' + &
'that indicates whether or not the alarm is enabled.' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 0; mso-yfti-firstrow: yes">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Days In Advance ' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">The ' + &
'number of days before the date specified in the Contract Dates field to send ' + &
'the first notification.' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 2">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Every [  ] Days ' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">The ' + &
'number of days between alarm notices, for example:' + &
'<o:p></o:p></SPAN></P>' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">1 ' + &
'= every day' + &
'<o:p></o:p></SPAN></P>' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">2 ' + &
'= every other day' + &
'<o:p></o:p></SPAN></P>' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">7 ' + &
'= once a week' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 1">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Up to [  ] Times' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">The ' + &
'maximum number of times this notification will be sent.' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 5">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Set Date' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">If Create '+&
'Action Item is checked, the system will automatically increment a Date field that the alarm is associated with by a given amount of time once the Alarm Action '+&
'Item Status field is completed. Otherwise the system will automatically increment a Date field once the initial email reminder is sent.' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 5">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Advanced Set Date ' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">It enables set the occurrences of snooze dynamically. Users can set multiple records dialog that has the ability to put records represent the way they want the snooze to increment.  And the [x] loop checkbox will reset all the snooze records and start from beginning again once the last snooze happens otherwise the system will keep the last snooze as the snooze setting for ongoing alarms. ' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 5">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Create ' + &
'Action Item' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Indicates ' + &
'whether or not an Action Item will be created. ' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 5">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Action ' + &
'Item Title' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">The ' + &
'title displayed in Contract Action Item List. ' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 5">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Trigger Work ' + &
'Flow' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">When ' + &
'Contract Alarms is triggered for the first time, the Work Flow selected here will be triggered and it will be triggered for only once. ' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 3">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Times ' + &
'Emailed' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Filled ' + &
'in by IntelliContract. Indicates number of times email has been sent.' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 4">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Last ' + &
'Emailed' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Filled ' + &
'in by IntelliContract. Date and time of last email notification.' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 4">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Last ' + &
'Work Flow Triggered' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Filled ' + &
'in by IntelliContract. Date and time of last work flow triggering.' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 7">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Email ' + &
'Template' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">The ' + &
'Email template that is defined in Email Painter.' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 7">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Auto ' + &
'Generate Email Signature' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Automatically ' + &
"inserts the sender's signature to the end of the email when it sends out an email." + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 7">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Attachment' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">The ' + &
'attachment that will be attached to the email generated by the alarm.' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 8; mso-yfti-lastrow: yes">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Users ' + &
'to Notify' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Users ' + &
'who will be notified. Only users set up in the User Painter may be ' + &
'selected. Users must have an email address in the Email ID field in User ' + &
'Painter.' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 7">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Alert ' + &
'Message' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">The ' + &
'message that will be displayed in the email generated by the alarm.' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'<TR style="mso-yfti-irow: 7">' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 126pt; PADDING-TOP: 0cm" vAlign="top" width="168">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><B><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">Set As Default ' + &
'<o:p></o:p></SPAN></B></P>' + &
'</TD>' + &
'<TD style="PADDING-RIGHT: 5.4pt; PADDING-LEFT: 5.4pt; PADDING-BOTTOM: 0cm; WIDTH: 270pt; PADDING-TOP: 0cm" vAlign="top" width="360">' + &
'<P class="MsoNormal" style="MARGIN-BOTTOM: 3pt"><SPAN lang="EN-US" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-bidi-font-size: 12.0pt">It will set all new alarms of the same field to the settings you currently have in this Alarm window as default.  But the default setting can only be effective for fields under the same View. ' + &
'<o:p></o:p></SPAN></P>' + &
'</TD>' + &
'</TR>' + &
'</TABLE>' + &
'</body>' + &
'</html>'

li_FileNum = FileOpen(gnv_app.is_application_path +'\'+ "help.html",StreamMode!, Write!, LockWrite!, Replace!)
FileWrite ( li_FileNum, ls_help )
FileClose ( li_FileNum )
ole_1.object.Navigate( gnv_app.is_application_path +'\'+ "help.html" )

Return 0
//--------------------------- APPEON END ---------------------------
end function

on w_ctx_help.create
int iCurrent
call super::create
this.ole_1=create ole_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_1
end on

on w_ctx_help.destroy
call super::destroy
destroy(this.ole_1)
end on

event open;call super::open;if message.stringparm = 'cpt_help' then 
	wf_cpt_code_hlp( )
else
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 08.27.2007 By: Evan
	//$<reason> w_ctx_alram UI change.	
	//of_create_help( )
	of_create_help2()
	//--------------------------- APPEON END -----------------------------
end if
end event

type ole_1 from olecustomcontrol within w_ctx_help
event statustextchange ( string text )
event progresschange ( long progress,  long progressmax )
event commandstatechange ( long command,  boolean enable )
event downloadbegin ( )
event downloadcomplete ( )
event titlechange ( string text )
event propertychange ( string szproperty )
event beforenavigate2 ( oleobject pdisp,  any url,  any flags,  any targetframename,  any postdata,  any headers,  ref boolean cancel1 )
event newwindow2 ( ref oleobject ppdisp,  ref boolean cancel1 )
event navigatecomplete2 ( oleobject pdisp,  any url )
event documentcomplete ( oleobject pdisp,  any url )
event onquit ( )
event onvisible ( boolean ocx_visible )
event ontoolbar ( boolean toolbar )
event onmenubar ( boolean menubar )
event onstatusbar ( boolean statusbar )
event onfullscreen ( boolean fullscreen )
event ontheatermode ( boolean theatermode )
event windowsetresizable ( boolean resizable1 )
event windowsetleft ( long left )
event windowsettop ( long top )
event windowsetwidth ( long ocx_width )
event windowsetheight ( long ocx_height )
event windowclosing ( boolean ischildwindow,  ref boolean cancel1 )
event clienttohostwindow ( ref long cx,  ref long cy )
event setsecurelockicon ( long securelockicon )
event filedownload ( ref boolean cancel1 )
event navigateerror ( oleobject pdisp,  any url,  any frame,  any statuscode,  ref boolean cancel1 )
event printtemplateinstantiation ( oleobject pdisp )
event printtemplateteardown ( oleobject pdisp )
event updatepagestatus ( oleobject pdisp,  any npage,  any fdone )
event privacyimpactedstatechange ( boolean bimpacted )
integer width = 2789
integer height = 2820
integer taborder = 10
boolean border = false
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_ctx_help.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
04w_ctx_help.bin 
2A00000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000a1035e6001ce7ec600000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f00000000a1035e6001ce7ec6a1035e6001ce7ec6000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Affffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c00003f0c000048dd0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c00003f0c000048dd0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
14w_ctx_help.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
