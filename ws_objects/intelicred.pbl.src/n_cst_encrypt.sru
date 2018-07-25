$PBExportHeader$n_cst_encrypt.sru
forward
global type n_cst_encrypt from nonvisualobject
end type
end forward

global type n_cst_encrypt from nonvisualobject autoinstantiate
end type

type variables
CONSTANT string CRYPT_KEY = "$#@%&#%@&*"
CONSTANT integer CRYPT_VAL  = 100 //maha 03.19.2013
// lead characters used: # - 1; $ - 2; @ - 3; & = temp
end variables

forward prototypes
public function string of_encrypt (string as_str)
public function string of_decrypt (string as_str)
public function string of_encrypt2 (string as_pw, string as_salt)
public function string of_decrypt2 (string as_pw, string as_salt)
public function string of_encrypt3 (string as_pw, string as_salt)
public function string of_encrypt_temp (string as_str)
public function string of_decrypt (string as_str, boolean ab_new)
public function string of_encrypt (string as_str, boolean ab_new)
end prototypes

public function string of_encrypt (string as_str);//Overloaded for V15.2 WV Security Questions by alfee 12.30.2016

RETURN of_encrypt (as_str, FALSE)

//integer i, j, li_val
//string ls_enctext = ""
//string ls_str
////debugbreak()
////Start Code Change ---- 06.25.2007 #V7 maha  made changes to allow encryption for db conn setting
//ls_str = as_str
//if MidA(as_str,1,8) = "isoft@@@" then
//	li_val = 153
//	ls_str = MidA(as_str,9)
//else
//	//------Begin Modified by alfee 04.08.2013 for performance tuning ---------
//	if gi_encryption_val < 0 then
//		select set_45 into :gi_encryption_val from icred_settings;
//	end if
//	li_val = gi_encryption_val
//	//select set_45 into :li_val from icred_settings;
//	//------End Modfiied ----------------------------------------------------------------	
//end if
//
//j = LenA(ls_str)
//
////li_val = of_get_app_setting("set_45","I")
//if isnull(li_val) then li_val = 0
//if li_val = 0 then li_val = 255
//
//FOR i = 1 TO j
//    ls_enctext += MidA(CRYPT_KEY , mod(i,10) + 1, 1)
//    ls_enctext += String(CharA(li_val - AscA(MidA(ls_str, i, 1))))
//NEXT
////End Code Change---06.26.2007
//RETURN ls_enctext

end function

public function string of_decrypt (string as_str);//Overloaded for V15.2 WV Security Questions by alfee 12.30.2016

RETURN of_decrypt (as_str, FALSE)

//integer i, j,li_val
//string ls_encchar, ls_temp, ls_unasstr = "** Encryption Error", ls_str
//boolean lb_ok = true
////Start Code Change ---- 06.26.2007 #V7 maha  modified for nonconnected function.  Web version not coded(not needed)
//ls_str = as_str
//j = LenA(ls_str)
//
////If appeongetclienttype() = 'PB' Then
//	if MidA(as_str,1,8) = "isoft@@@" then
//		li_val = 153
//		ls_str = MidA(as_str,9)
//		j = LenA(ls_str)
//	else
//	//------Begin Modified by alfee 04.08.2013 for performance tuning ---------
//	if gi_encryption_val < 0 then
//		select set_45 into :gi_encryption_val from icred_settings;
//	end if
//	li_val = gi_encryption_val
//	//select set_45 into :li_val from icred_settings;
//	//------End Modfiied ----------------------------------------------------------------	
//	end if
//
//	//li_val = of_get_app_setting("set_45","I")
//	if isnull(li_val) then li_val = 0
//	if li_val = 0 then li_val = 255
//	
//	IF NOT Mod(j, 2) = 1 THEN
//		ls_temp = ""
//		FOR i = 2 TO (j + 1) STEP 2
//			ls_encchar = MidA(ls_str, i - 1, 1)
//			IF MidA(CRYPT_KEY, Mod(i / 2, 10) + 1, 1) <> ls_encchar THEN
//			  lb_ok = FALSE
//			  EXIT
//			END IF     
//			ls_encchar = MidA(ls_str, i, 1)
//			ls_temp += string(CharA(li_val - AscA(ls_encchar)))
//		NEXT
//	END IF
////End Code Change---06.26.2007	
//	IF lb_ok THEN ls_unasstr = ls_temp
//	
//	RETURN ls_unasstr
///*Else
//	li_val = integer(gnv_data.of_getitem("icred_settings" , "set_45" , False))
//
//	//li_val = of_get_app_setting("set_45","I")
//	if isnull(li_val) then li_val = 0
//	if li_val = 0 then li_val = 255
//	
//	ls_unasstr = space(255)
//	gnv_appeondll.of_decrypt(as_str,CRYPT_KEY,li_val , ls_unasstr)
//	
//	RETURN ls_unasstr
//End If*/
////---------------------------- APPEON END ----------------------------
end function

public function string of_encrypt2 (string as_pw, string as_salt);//Start Code Change ----03.04.2013 #V12 maha - added as stronger algorithm
//not completed 3.4.2013 needs:
//brown_val added to updates
// code changed to use that field
//code to set the brown_val for the user in the password update
integer i, li_len, li_val, li_salt_num
integer li_salt_value
string ls_enctext = "$"
string ls_pw
string ls_salt
string ls_salt_char
string ls_user
string ls_bit
//debugbreak()

 //encryption for db conn setting
ls_pw = as_pw
//SElect set_45 into :li_val from icred_settings;
//select brown_val into :ls_salt from security_users where user_id = :as_user;
//if isnull(ls_salt) or len(ls_salt) < 10 then  return "Failed"

ls_salt = as_salt
//ls_salt = "7YfNQ@" + "$%*#@"

li_len = LenA(ls_pw)

//li_val = of_get_app_setting("set_45","I")
//if isnull(li_val) then li_val = 0
//if li_val = 0 then li_val = 255

li_val = CRYPT_VAL
//debugbreak()
FOR i = 1 TO li_len
	ls_salt_char = MidA(ls_salt , i, 1)
	li_salt_value = AscA(ls_salt_char )
	ls_enctext += string(CharA( mod(li_salt_value + 15,93) + 32))
	li_salt_num = mod( li_val - AscA(MidA(ls_pw, i, 1)) +  li_salt_value, 93) + 32
	ls_enctext += String(CharA(   li_salt_num  ))
//	ls_enctext += String(CharA(   AscA(MidA(ls_pw, i, 1)) -  li_salt_value  ))
NEXT
//End Code Change---06.26.2007
RETURN ls_enctext
end function

public function string of_decrypt2 (string as_pw, string as_salt);integer i, li_len,li_val
integer li_salt_value, li_salt2
integer li_salt_pos = 0
//Start Code Change ----03.04.2013 #V12 maha - added
//not completed 3.4.2013
string ls_encchar, ls_temp, ls_unasstr = "** Encryption Error", ls_str
string ls_salt
string ls_salt_char
string ls_user
string ls_bit
boolean lb_ok = true

ls_str = as_pw
li_len = LenA(ls_str)

//If appeongetclienttype() = 'PB' Then
if MidA(as_pw,1,8) = "isoft@@@" then
	li_val = 153
	ls_str = MidA(as_pw,9)
	li_len = LenA(ls_str)
else
//	select set_45 into :li_val from icred_settings;
	li_val = CRYPT_VAL
	//select brown_value into :ls_salt from security_users where user id = :ls_user;
//	ls_salt = "7YfNQ@" + "$%*#@"
	ls_salt = as_salt
end if

	//li_val = of_get_app_setting("set_45","I")
//if isnull(li_val) then li_val = 0
//if li_val = 0 then li_val = 255


debugbreak()
//IF NOT Mod( li_len, 2) = 1 THEN
	ls_temp = ""
	FOR i = 4 TO ( li_len + 2) STEP 2  
		li_salt_pos++
		ls_salt_char = MidA(ls_salt , li_salt_pos, 1)
		li_salt_value = AscA(ls_salt_char)  // - 100
	//	li_salt2 = AscA(ls_salt_char) + 15
		ls_encchar = MidA(ls_str, i - 1, 1)
//		ls_encchar = CharA(li_salt2)
		
		ls_temp += string(CharA( li_val -  AscA(ls_encchar) + li_salt_value ))
		//ls_temp += string(CharA( AscA(ls_encchar) + li_salt_value ))
	NEXT
//END IF
//	ls_salt_char = MidA(ls_salt , i, 1)
//	li_salt_value = AscA(ls_salt_char )
//	ls_enctext += string(CharA(li_salt_value + 15))
//	ls_enctext += String(CharA( li_val - AscA(MidA(ls_pw, i, 1)) +  li_salt_value  ))


//End Code Change---06.26.2007	
	IF lb_ok THEN ls_unasstr = ls_temp
	
	RETURN ls_unasstr


end function

public function string of_encrypt3 (string as_pw, string as_salt);//Start Code Change ----03.02.2016 - base code copied from prior function to be modified

integer i, li_len, li_val, li_salt_num
integer li_salt_value
integer li_prior = 7   //maha 03.02.2016
integer li_max = 50   //maha 03.02.2016
integer p = 0    //maha 03.02.2016
integer s = 0    //maha 03.02.2016
integer h    //maha 03.02.2016
string ls_enctext = "@"
string ls_pw
string ls_salt
string ls_salt_char
string ls_user
string ls_bit
string ls_hash = "@"
//debugbreak()

ls_pw = as_pw

ls_salt = as_salt

//add the values of the salt chars
for i = 1 to len(ls_salt)
	ls_salt_char = MidA(ls_salt , i, 1)
	li_salt_value = AscA(ls_salt_char )
	li_val+= li_salt_value
next

//modulus of salt total devided by len of password
h = mod(li_val,len(ls_pw))
if h < 2 then h = 2
//messagebox("h",h)
li_len = LenA(ls_pw)

li_val = CRYPT_VAL
//debugbreak()
//mod(93) and + 32 keep it in the range of 33-125 ascii
FOR i = 1 TO li_max  //all pws will be the same length in database
	p++
	if p > li_len then p = 1  //pw char position
	s++ 
	if s > 10 then s = 1  //salt char position
	ls_salt_char = MidA(ls_salt , s, 1)
	li_salt_value = AscA(ls_salt_char )
	//add char based on salt
	//ls_enctext += string(CharA( mod(li_salt_value + 15,93) + 32))
	//encrypt pw char based on salt value and prior char value
	li_salt_num = mod( li_val + (i * li_salt_value) - AscA(MidA(ls_pw, p, 1)) +  li_salt_value - li_prior , 93) + 33
	li_prior = li_salt_num
	//add encrypted char
	ls_enctext += String(CharA(   li_salt_num  ))
NEXT

//rehash
for p = 1 to h
	for i = 2 to len(ls_enctext)
		ls_salt_char = MidA(ls_enctext , i, 1)
		li_salt_value = AscA(ls_salt_char )
		li_salt_num = mod( li_val - i +  li_salt_value, 93) + 32
		//add encrypted char
		ls_hash += String(CharA(   li_salt_num  ))
	next
	ls_enctext =ls_hash
	if p < h then ls_hash = "@"
next

ls_enctext =ls_hash




RETURN ls_enctext
end function

public function string of_encrypt_temp (string as_str);//Start Code Change ----08.15.2016 #V153 maha - created to encrypt temporary passwords
string s

//use the basic encrypt and add '&' to the front
s = of_encrypt( as_str)

s = "&" + s

return s


end function

public function string of_decrypt (string as_str, boolean ab_new);//Duplicated and overloaded with a new argu "ab_new" for V15.2 WV Security Questions by alfee 12.30.2016

integer i, j,li_val
string ls_encchar, ls_temp, ls_unasstr = "** Encryption Error", ls_str
boolean lb_ok = true
//Start Code Change ---- 06.26.2007 #V7 maha  modified for nonconnected function.  Web version not coded(not needed)
ls_str = as_str
j = LenA(ls_str)

//If appeongetclienttype() = 'PB' Then
	if MidA(as_str,1,8) = "isoft@@@" then
		li_val = 153
		ls_str = MidA(as_str,9)
		j = LenA(ls_str)
	else
	//------Begin Modified by alfee 04.08.2013 for performance tuning ---------
	if gi_encryption_val < 0 then
		select set_45 into :gi_encryption_val from icred_settings;
	end if
	li_val = gi_encryption_val
	//select set_45 into :li_val from icred_settings;
	//------End Modfiied ----------------------------------------------------------------	
	end if

	//li_val = of_get_app_setting("set_45","I")
	if isnull(li_val) then li_val = 0
	if li_val = 0 then li_val = 255
	
	if ab_new and li_val > 159 then li_val = 159 //alfee 12.30.2016
	
	IF NOT Mod(j, 2) = 1 THEN
		ls_temp = ""
		FOR i = 2 TO (j + 1) STEP 2
			ls_encchar = MidA(ls_str, i - 1, 1)
			IF MidA(CRYPT_KEY, Mod(i / 2, 10) + 1, 1) <> ls_encchar THEN
			  lb_ok = FALSE
			  EXIT
			END IF     
			ls_encchar = MidA(ls_str, i, 1)
			ls_temp += string(CharA(li_val - AscA(ls_encchar)))
		NEXT
	END IF
//End Code Change---06.26.2007	
	IF lb_ok THEN ls_unasstr = ls_temp
	
	RETURN ls_unasstr
/*Else
	li_val = integer(gnv_data.of_getitem("icred_settings" , "set_45" , False))

	//li_val = of_get_app_setting("set_45","I")
	if isnull(li_val) then li_val = 0
	if li_val = 0 then li_val = 255
	
	ls_unasstr = space(255)
	gnv_appeondll.of_decrypt(as_str,CRYPT_KEY,li_val , ls_unasstr)
	
	RETURN ls_unasstr
End If*/
//---------------------------- APPEON END ----------------------------
end function

public function string of_encrypt (string as_str, boolean ab_new);//Duplicated and overloaded with a new argu "ab_new" for V15.2 WV Security Questions by alfee 12.30.2016
//As the ascii code for space is 32, it's corresponding number in CharA () may be default to 128 (160-32), 
//which will lead to the different values between IntelliCred and WebView (ASNI and Unicode).
//The workaround is set the CRYPT_KEY to 159 while it's 160 or greater than 160 and the ab_wv is true.
//Note: The CRYPT_KEY can be set to 126 - 160 in the current program.  Standard ASCII Code: 0 - 127.

integer i, j, li_val
string ls_enctext = ""
string ls_str

//Start Code Change ---- 06.25.2007 #V7 maha  made changes to allow encryption for db conn setting
ls_str = as_str
if MidA(as_str,1,8) = "isoft@@@" then
	li_val = 153
	ls_str = MidA(as_str,9)
else
	//------Begin Modified by alfee 04.08.2013 for performance tuning ---------
	if gi_encryption_val < 0 then
		select set_45 into :gi_encryption_val from icred_settings;
	end if
	li_val = gi_encryption_val
	//select set_45 into :li_val from icred_settings;
	//------End Modfiied ----------------------------------------------------------------	
end if

j = LenA(ls_str)

//li_val = of_get_app_setting("set_45","I")
if isnull(li_val) then li_val = 0
if li_val = 0 then li_val = 255

if ab_new and li_val > 159 then li_val = 159 //alfee 12.30.2016

FOR i = 1 TO j
    ls_enctext += MidA(CRYPT_KEY , mod(i,10) + 1, 1)
    ls_enctext += String(CharA(li_val - AscA(MidA(ls_str, i, 1))))
NEXT
//End Code Change---06.26.2007

RETURN ls_enctext

end function

on n_cst_encrypt.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_encrypt.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

