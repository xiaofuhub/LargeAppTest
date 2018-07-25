$PBExportHeader$n_cst_datetime.sru
$PBExportComments$Extension Date and/or Datetime service
forward
global type n_cst_datetime from pfc_n_cst_datetime
end type
end forward

global type n_cst_datetime from pfc_n_cst_datetime
end type

forward prototypes
public function string of_daynameofweek (date ad_source, boolean ab_shortname)
public function date of_exp_date_birthday (integer ai_years, date ad_start, long al_prac)
end prototypes

public function string of_daynameofweek (date ad_source, boolean ab_shortname);//====================================================================
//$<Function>: of_DayNameOfWeek
//$<Arguments>:
// 	value    date       ad_source
// 	value    boolean    ab_shortname
//$<Return>:  string
//$<Description>: 
//$<Author>: (Appeon) Toney 06.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_DayNumber

//Check parameters
If IsNull(ad_source) Then
	long ll_null
	SetNull(ll_null)
	Return ''
End If

//Check for invalid date
If Not of_IsValid(ad_source) Then
	Return ''
End If

ll_DayNumber = DayNumber (ad_source)

Choose Case ll_DayNumber
	Case 1
		If ab_shortname Then
			Return "Sun"
		Else
			Return "Sunday"
		End If
	Case 2
		If ab_shortname Then
			Return "Mon"
		Else
			Return "Monday"
		End If		
	Case 3
		If ab_shortname Then
			Return "Tue"
		Else
			Return "Tuesday"
		End If		
	Case 4
		If ab_shortname Then
			Return "Wed"
		Else
			Return "Wednesday"
		End If		
	Case 5
		If ab_shortname Then
			Return "Thu"
		Else
			Return "Thursday"
		End If		
	Case 6
		If ab_shortname Then
			Return "Fri"
		Else
			Return "Friday"
		End If		
	Case 7
		If ab_shortname Then
			Return "Sat"
		Else
			Return "Saturday"
		End If		
	Case Else
		Return ''
End Choose
end function

public function date of_exp_date_birthday (integer ai_years, date ad_start, long al_prac);//Start Code Change ----06.26.2014 #V14.2 maha - added for setting appointment expiration date based on birthday
date ld_date
date ld_test
datetime ld_dob
integer dob_month
integer dob_day
integer end_month
integer end_year
integer end_day

ld_date = of_relativeyear( ad_start, ai_years)

select date_of_birth into :ld_dob from pd_basic where prac_id = :al_prac;

if isnull(ld_dob) then return date("1800-01-01")
debugbreak()
dob_month = month(date(ld_dob))
dob_day = day(date(ld_dob))
end_month = month(ld_date)
end_day = day(ld_date)
end_year = year(ld_date)

if dob_month = end_month then 
	ld_test = ld_date
	if end_day - 1 > dob_day then  // check day so as to not go over 2 years
		ld_date = date(string(end_year) + "-" + string(dob_month) + "-" +  string(dob_day) ) //maha corrected 9.30.2014
	end if
	
elseif dob_month < end_month then
	ld_date = date(string(end_year) + "-" + string(dob_month) + "-01" )
	ld_date = of_lastdayofmonth(ld_date)
else
	end_year = end_year - 1
	ld_date = date(string(end_year) + "-" + string(dob_month) + "-01" )
	ld_date = of_lastdayofmonth(ld_date)
end if



return ld_date

end function

on n_cst_datetime.create
call super::create
end on

on n_cst_datetime.destroy
call super::destroy
end on

