$PBExportHeader$pfc_cst_build_annotation_bar.sru
forward
global type pfc_cst_build_annotation_bar from UserObject
end type
type r_1 from rectangle within pfc_cst_build_annotation_bar
end type
type r_bar from rectangle within pfc_cst_build_annotation_bar
end type
end forward

global type pfc_cst_build_annotation_bar from UserObject
int Width=1015
int Height=80
boolean Border=true
long BackColor=67108864
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
r_1 r_1
r_bar r_bar
end type
global pfc_cst_build_annotation_bar pfc_cst_build_annotation_bar

on pfc_cst_build_annotation_bar.create
this.r_1=create r_1
this.r_bar=create r_bar
this.Control[]={this.r_1,&
this.r_bar}
end on

on pfc_cst_build_annotation_bar.destroy
destroy(this.r_1)
destroy(this.r_bar)
end on

type r_1 from rectangle within pfc_cst_build_annotation_bar
int Width=992
int Height=48
boolean Enabled=false
int LineThickness=4
long FillColor=80269524
end type

type r_bar from rectangle within pfc_cst_build_annotation_bar
int X=5
int Y=4
int Width=41
int Height=40
boolean Enabled=false
int LineThickness=4
long LineColor=32768
long FillColor=32768
end type

