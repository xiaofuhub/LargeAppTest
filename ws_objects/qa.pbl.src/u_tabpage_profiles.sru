$PBExportHeader$u_tabpage_profiles.sru
forward
global type u_tabpage_profiles from u_tabpg
end type
type uo_profile from pfc_cst_u_profile within u_tabpage_profiles
end type
end forward

global type u_tabpage_profiles from u_tabpg
integer width = 3543
integer height = 1832
string text = "Profiles"
uo_profile uo_profile
end type
global u_tabpage_profiles u_tabpage_profiles

on u_tabpage_profiles.create
int iCurrent
call super::create
this.uo_profile=create uo_profile
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_profile
end on

on u_tabpage_profiles.destroy
call super::destroy
destroy(this.uo_profile)
end on

type uo_profile from pfc_cst_u_profile within u_tabpage_profiles
integer width = 3557
integer height = 1836
integer taborder = 20
end type

on uo_profile.destroy
call pfc_cst_u_profile::destroy
end on

