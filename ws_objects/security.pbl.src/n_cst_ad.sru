$PBExportHeader$n_cst_ad.sru
forward
global type n_cst_ad from nonvisualobject
end type
end forward

global type n_cst_ad from nonvisualobject
end type
global n_cst_ad n_cst_ad

type prototypes
function long ADsOpenObject(string path, string userName, string password, long flags, ref GUID iid, ref long ppObject) library "activeds.dll"   
end prototypes

type variables
n_cst_encrypt in_encrypt //Added by Appeon long.zhang 03.16.2017 (Major AD Authentication Bug)
end variables

forward prototypes
public function integer of_connect_ad (string as_ad_server, string as_ad_user, string as_ad_password, ref string as_error)
public function integer of_verify_server (ref string as_error)
public function boolean of_verify_client ()
public function integer of_connect_ad (string as_ad_server, string as_ad_user, string as_ad_password, ref string as_error, boolean ab_verify_server, boolean ab_verify_client)
end prototypes

public function integer of_connect_ad (string as_ad_server, string as_ad_user, string as_ad_password, ref string as_error);Return of_connect_ad(as_ad_server,as_ad_user,as_ad_password,as_error,False, False)
end function

public function integer of_verify_server (ref string as_error);String ls_server, ls_user, ls_pwd, ls_error
If gnv_user_option.of_get_option_value('ad_server_need_verify') = '1' Then
	ls_server = gnv_user_option.of_get_option_value('ad_verify_server_name')
	ls_user = gnv_user_option.of_get_option_value('ad_verify_user_name')
	ls_pwd = gnv_user_option.of_get_option_value('ad_verify_pwd')
	ls_pwd = in_encrypt.of_decrypt( ls_pwd)  //Added by Appeon long.zhang 03.16.2017 (Major AD Authentication Bug)
	If This.of_connect_ad( ls_server, ls_user, ls_pwd,ref as_error, false, false) = 0 Then
		Return 1
	Else
		gnv_debug.of_output(True,'Failed to verify  AD server.'+   as_error+  'AD Server:' + ls_server +', AD User:' + ls_user )
		Return -1
	End If
Else
	Return 1 //need not check
End If


Return 1
end function

public function boolean of_verify_client ();//Verify the client is domain env.
String ls_server, ls_user, ls_pwd, ls_error
Boolean lb_verify
n_cst_systeminfo lnv_systeminfo
lnv_systeminfo = Create n_cst_systeminfo
lb_verify = lnv_systeminfo.of_check_isdomain( )
Destroy lnv_systeminfo
If gnv_user_option.of_get_option_value('ad_server_need_verify_client') = '1' Then
	If lb_verify Then
		Return True
	Else
		Return False
	End If
Else
	Return True
End If


end function

public function integer of_connect_ad (string as_ad_server, string as_ad_user, string as_ad_password, ref string as_error, boolean ab_verify_server, boolean ab_verify_client);//====================================================================
// Function: of_connect_ad
//--------------------------------------------------------------------
// Description: Verify the AD user/pwd.
//--------------------------------------------------------------------
// Arguments:
//                as_ad_server
//                as_ad_user
//                as_ad_password
//      ref     as_error
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo 2016-06-16
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


GUID ls_iid                                                                                                                                                                     
                                                                                                                   
long  la_pp                                                                                                                                                                     
long ll_ret   
Integer li_ret
                                                                                                                                                                                                                                                                                                                                                               
// IUnknown interface = 00000000-0000-0000-C000-000000000046                                                                                                                    
ls_iid.data4[1] = char(192)                                                                                                                                                     
ls_iid.data4[4] = char(17920) //LittleEndian                                                                                                                                    

String ls_server_error
If ab_verify_server Then
	If This.of_verify_server(ref ls_server_error) < 0 Then
		as_error = 'The AD Server Verification failed. ' + ls_server_error 
		Return -1
	End If
End If

If ab_verify_client Then
	If Not This.of_verify_client() Then
		as_error = 'The client Verification failed. The client need logs into the domain.'
		Return -2
	End If
End If

Try                                                                                                                                                                                 
	ll_ret = ADsOpenObject("LDAP://" + as_ad_server, as_ad_user, as_ad_password, 1, ref ls_iid, ref la_pp)                                                                              
Catch (runtimeerror Err1)
	ll_ret = -10
	as_error = 'Failed to execute the ADsOpenObject function.'  + Err1.text
	Return ll_ret
End Try 
                                                                                                                                                                                
Choose Case ll_ret                                                                                                                                                              
	 case 0                                                                                                                                                                         
	 	 //Success     
		  li_ret = 0
	 case -2147023570                                                                                                                                                               
		  //Unknown username or bad password     
		  as_error = "This error will occur if the passed user name during a BIND authentication in the directory is non existing or if the password is invalid . It may also be that the server doesn't allow simple clear text authentication."
		  li_ret = -1      
	Case -2147467259
		  as_error = "This number doesn't indicate a specific reason for this error but will always occur if there are problems in ADO requests, e.g. you forgot to pass the search scope (Subtree, OneLevel etc.) within your request string. This error can occur even without using ADO when you have a type mismatch while writing an object attribute (for example if you use the ADSI method Put to fill an integer or string attribute in a floating point number). In this case you better convert the value into a string first."
		  li_ret = -1		  
	Case -2147463168
		as_error = "This error occurs when the indicated LDAP path of LDAP BIND requests on objects or ADODB requests are invalid. Maybe you tried to access a non existing object with a GetObject call or there was a typing error in the distinguished name of the demanded object."
		li_ret = -1
	Case -2147463160
		as_error = "There are different reasons for this error: One of the parameters used in an ADSI function is invalid - regarding either the data type or logic. The error occurs e.g. during a call with the ADSI function Delete for an object when the indicated object class was incorrect. Or when no array was used as first parameter for a GetInfoEx call."
		li_ret = -1		
	Case -2147463156
		as_error = "This error occurs when you try to access a provider specific attribute without using the necessary techniques. Some directory services return the values for its attributes in this strange syntax format. Instead of using the normal access methods like Get and GetEx, you have to use the ADSI-Function GetPropertyItem."
		li_ret = -1	
	Case -2147463155
		as_error = "This error will occur if you try to access attributes that aren't located in the so-called property cache. This cache has been built up with the functions GetObject, GetInfo or GetInfoEx. It could also be an operational attribute that isn't automatically built in the cache but has to be requested explicitly from the directory. Or there is a simple typing error in the specification of the attribute."
		li_ret = -1		
	Case -2147217911
		as_error = "An ADO call failed because the user account used for a directory BIND authentication had no appropriate permissions."
		li_ret = -1	
	Case -2147217900
		as_error = "This error may occur when trying to perform an ADODB search in the directory. This search fails when the used ADO search string is syntactically incorrect. This have to be considered not only for the LDAP filter which is part of the ADO command string. If you have any syntax errors in your command string, you will encounter this error code."
		li_ret = -1		
	Case -2147217865
		as_error = "This error can occur when trying to perform an ADODB search in the directory. It fails when the specified LDAP server is unreachable or the passed LDAP path in which objects are searched is non existing. But there are LDAP server (e.g. Novell NetWare) that return this error code when the user ID used in the ADO request doesn't exist!"
		li_ret = -1	
	Case -2147024891
		as_error = "An ADSI call failed because the user account used for a directory BIND authentication hadn't enough permissions."
		li_ret = -1		
	Case -2147024865
		as_error = "An unspecific error that may have many different reasons. Often this error occurs when trying to nest AD groups in other groups without considering the group scope (global groups may contain groups of other domains; local domain groups can't be nested in groups from other domains etc.)"
		li_ret = -1	
	Case -2147023541
		as_error = "This error can occur if you use the ADSI function MoveHere - this function is needed for renaming or moving objects. MoveHere is called with two parameters: A complete LDAP pathname and a realtive distinguished name." + &
"~r~nThis error indicates a syntax error in these parameters, it also may be given a non-existing object in the complete LDAP pathname. Please check not only the domain name used in these parameters but also any other part of the LDAP name information. "
		li_ret = -1		
	Case -2147019886
		as_error = "This error occurs when the ADSI method Create is applied to a container object whose distinguished name for the object you want to create does already exist."
		li_ret = -1	
	Case -2147016694
		as_error = "This error occurs when trying to read a non existing attribute in the property cache of an object with the ADSI function GetInfoEx."
		li_ret = -1		
	Case -2147016691
		as_error = "This error occurs primarily when you try to add members to groups that have been members of this group beforehand."
		li_ret = -1	
	Case -2147016684
		as_error = "This error can occur in certain circumstances if you create an object without calling the SetInfo method and immediately write some attributes to this newly created object. So the correct order would be to create the object (with the mandatory attributes), then to call the function SetInfo, and after that set other attributes. "
		li_ret = -1		
	Case -2147016683
		as_error = "This error occurs if you try to delete an object which has one or several child objects. In other words: Only empty OUs or containers can be deleted! Although there is an extended LDAP control wich is named 'Delete Tree', you cannot use such controls in ADSI scripts."
		li_ret = -1	
	Case -2147016682
		as_error = "This error will occur if you want to change the relative distinguished name of an object but this operation, however, is not allowed by the directory server. Alternatively, you could try to rename the respective object with the ADSI move function."
		li_ret = -1		
	Case -2147016671
		as_error = "This error occurs e.g. when passing the wrong data type while writing attributes. There are several attributes existing that require a distinguished name. If you pass a simple string in the put method it will come to this error code."
		li_ret = -1	
	Case -2147016661
		as_error = "This error code occurs e.g. when passing an incorrect distinguished name in the OpenDSObject method of a Windows 2000 ADS. Especially, when the name of the naming context is incorrect (i.e. for example the specification of an invalid domain name)."
		li_ret = -1		
	Case -2147016657
		as_error = "An internal requirement of the directory service wasn't fulfilled. Maybe it was tried to create an Exchange mailbox with an indefinite SMTP address. Or it was tried to create an Active Directory user object that doesn't have a login name."
		li_ret = -1	
	Case -2147016656
		as_error = "This error is similar to ADS_BAD_PATHNAME (0x80005008) - during the BIND process, an LDAP object path was passed from a non existing object. The peculiarity with this issue is that the error code ADS_BAD_PATHNAME is always given back in Active Directory environments, whereas other LDAP server (e.g. Novell eDirectory environments) return LDAP_No_SUCH-OBJECT."
		li_ret = -1		
	Case -2147016654
		as_error = "This error occurs when a distinguished name used for the creation of objects contains invalid characters."
		li_ret = -1	
	Case -2147016651
		as_error = "The LDAP server rejects to perform the requested operation. This error code occurs when trying to change the password of a an Active Directory user via ADSI but with the password not complying with the demands of the domain policies (i.e. it is too short, too simple or used earlier). Or attributes are tried to change which can only be change by the security account manager (e.g. lastLogon)."
		li_ret = -1		
	Case -2147016649
		as_error = "This error occurs in the context of the creation of objects or the access to their attributes. The reason is the usage of an invalid LDAP path, e.g. when you want to create an organizational unit with description cn=.... ."
		li_ret = -1			
	Case -2147016646
		as_error = "This error code occurs when the addressed server is unreachable during a BIND authentication in the directory. This can occur due to underlying network problems. A firewall may block the used LDAP port, or the LDAP service isn't active on the destination host."
		li_ret = -1
	Case -2146827850
		as_error = "This error occurs in LDAP and directory scripting for example when you try to directly access an object attribute with the syntax 'objectname.attributename', or if you try to use Get and Put to access the attributes type. The error code means that the given attribute doesn't exists for that particular object class or that the function you use is not valid for the attribute's data type."
		li_ret = -1

	 case -2147943730                                                                                                                                                               
		 as_error ='Password expired.'                                                                                                                                                      
		  li_ret = -2                                                                                                                                                                   
	 case -2147943731                                                                                                                                                               
		  as_error = 'Account disabled. '		                                                                                                                                                   
		  li_ret = -3                                                                                                                                                                   
	 case -2147943755                                                                                                                                                               
		 as_error = 'Domain not found.'	                                                                                                                                                        
		  li_ret = -4                                                                                                                                                                   
	 case -2147943763                                                                                                                                                               
		 as_error = 'Logon ID already in use.'	                                                                                                                                          
		  li_ret = -5                                                                                                                                                                   
	 case else                                                                                                                                                                      
		  as_error =  'Unknown Error ' + String(ll_ret) + '.'                                                                                                                                                          
		  li_ret = -6                                                                                                                                                                   
End Choose         

//Choose Case li_ret
//	Case  0 // Authenticated                                                                                                                                                              
//		as_error = ''
//	Case  -1  //=  Unknown username or bad password                                                                                                                                        
//		as_error = 'Unknown username or bad password.'
//	Case  -2  //=  Password expired                                                                                                                                                        
//		as_error ='Password expired.'	
//	Case  -3  //=  Account disabled                                                                                                                                                        
//		as_error = 'Account disabled. '		
//	Case  -4  //= Domain not found                                                                                                                                                         
//		as_error = 'Domain not found.'		
//	Case  -5 //=  Logon ID already in use                                                                                                                                                  
//		as_error = 'Logon ID already in use.'		
//	Case  -6 //= Unknown Error 
//		as_error =  'Unknown Error ' + String(ll_ret) + '.'
//End Choose
If as_error <> '' Then
	as_error = as_error + ' Please check your AD account.'
End If
gnv_debug.of_output(False, 'AD Login Result: ' + String (ll_ret)+ ','+String(li_ret)+ ', server:'+as_ad_server+', user:' + as_ad_user + '. ' + as_error)
Return li_ret
end function

on n_cst_ad.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_ad.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

