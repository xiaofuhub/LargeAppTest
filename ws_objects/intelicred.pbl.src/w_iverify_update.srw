$PBExportHeader$w_iverify_update.srw
forward
global type w_iverify_update from Window
end type
type cb_1 from commandbutton within w_iverify_update
end type
end forward

global type w_iverify_update from Window
int X=823
int Y=360
int Width=2016
int Height=1208
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_1 cb_1
end type
global w_iverify_update w_iverify_update

on w_iverify_update.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_iverify_update.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within w_iverify_update
int X=466
int Y=296
int Width=873
int Height=428
int TabOrder=10
string Text="Update"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Long ll_next_id

SELECT Max( lookup_code )  
INTO :ll_next_id  
FROM code_lookup  ;


ll_next_id ++

INSERT INTO code_lookup  
         ( lookup_code,   
           lookup_name,   
           code,   
           description,   
           type,   
           custom_1,   
           custom_2,   
           custom_3,   
           custom_4,   
           custom_5,   
           custom_6 )  
VALUES ( :ll_next_id,   
           'Verification Method',   
           'iVerify',   
           'Verify using iVerify data warehouse',   
           'S',   
           null,   
           null,   
           null,   
           null,   
           null,   
           null )  ;


end event

