$PBExportHeader$w_update_education.srw
forward
global type w_update_education from Window
end type
type cb_1 from commandbutton within w_update_education
end type
end forward

global type w_update_education from Window
int X=1056
int Y=484
int Width=2569
int Height=1516
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_1 cb_1
end type
global w_update_education w_update_education

on w_update_education.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_update_education.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within w_update_education
int X=457
int Y=260
int Width=1376
int Height=728
int TabOrder=10
string Text="Run"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;LONG ll_Rec_id, ll_prac_id, ll_ed_type, ll_lookup_code, ll_degree, ll_next_id
String ls_code

DECLARE c_ed CURSOR FOR  
SELECT pd_education.rec_id,   
         pd_education.prac_id,   
         pd_education.education_type,
	    pd_education.degree
FROM pd_education
WHERE education_type = 573;
 
OPEN c_ed;

FETCH c_ed INTO :ll_Rec_id, :ll_prac_id, :ll_ed_type, :ll_degree;
 
DO WHILE SQLCA.SQLCODE = 0
	
     SELECT code_lookup.code  
     INTO :ls_code
     FROM code_lookup,   
          pd_basic  
   	WHERE ( pd_basic.prof_suffix = code_lookup.lookup_code ) and  
          ( ( pd_basic.prac_id = :ll_prac_id ) )   ;

	Select code_lookup.lookup_code
	INTO :ll_lookup_code
	FROM code_lookup
	WHERE lookup_name = 'Education Degrees' AND
		 lookup_code = :ls_code;
		 
	IF SQLCA.SQLCODE = 100 THEN
		
		SELECT ids.lookup_code_id  
		INTO :ll_lookup_code  
		FROM ids  ;
		
		ll_lookup_code++
		
		INSERT INTO code_lookup  
        	    ( lookup_code,   
          	 lookup_name,   
	           code,   
     	      description )  
	     VALUES ( :ll_lookup_code,   
        	  	 'Education Degrees',   
	           :ls_code,   
     	      :ls_code )  ;
	
		UPDATE ids
		SET lookup_code_id = :ll_lookup_code;
	ELSEIF SQLCA.SQLCODE = -1 THEN
		ll_lookup_code = ll_degree
	END IF
	
	UPDATE pd_education
	SET degree = :ll_lookup_code
	WHERE rec_id = :ll_rec_id;

	FETCH c_ed INTO :ll_Rec_id, :ll_prac_id, :ll_ed_type, :ll_degree;	
LOOP

CLOSE c_ed;
end event

