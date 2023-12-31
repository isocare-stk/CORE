$PBExportHeader$n_cst_divsrv_operate.sru
$PBExportComments$ทำรายการเกี่ยวกับปันผลเฉลี่ยคืน
forward
global type n_cst_divsrv_operate from NonVisualObject
end type
end forward

/// <summary> ทำรายการเกี่ยวกับปันผลเฉลี่ยคืน
/// </summary>
global type n_cst_divsrv_operate from NonVisualObject
end type
global n_cst_divsrv_operate n_cst_divsrv_operate

type variables
Public:

string is_coopcontrol , is_coopid
 
transaction						itr_sqlca
Exception						ithw_exception

n_cst_dbconnectservice		inv_transection
n_cst_dwxmlieservice			inv_dwxmliesrv
n_cst_procservice				inv_procsrv
n_cst_progresscontrol		inv_progress
n_cst_doccontrolservice		inv_docsrv
n_cst_datawindowsservice	inv_dwsrv
end variables

forward prototypes
public function integer of_initservice (n_cst_dbconnectservice anv_dbtrans) throws Exception
public function integer of_init_slip (ref str_divsrv_oper astr_divavg_oper) throws Exception
public function integer of_init_slip_ccl (ref str_divsrv_oper astr_divavg_oper) throws Exception
public function integer of_init_slip_grp (ref str_divsrv_oper astr_divavg_oper) throws Exception
public function integer of_save_slip (ref str_divsrv_oper astr_divavg_oper) throws Exception
public function integer of_save_slip_ccl (ref str_divsrv_oper astr_divavg_oper) throws Exception
public function integer of_save_slip_grp (ref str_divsrv_oper astr_divavg_oper) throws Exception
public function integer of_setprogress (ref n_cst_progresscontrol anv_progress) throws Exception
public function integer of_init_slip_main (n_ds ads_info_mem, n_ds ads_slip_main) throws Exception
public function integer of_init_slip_detail (n_ds ads_slip_main, n_ds ads_slip_detail) throws Exception
public function integer of_init_slip_ccl_main (n_ds ads_info_mem, n_ds ads_slip_main) throws Exception
public function integer of_chk_slip_ccl (string as_branchid, string as_slipno) throws Exception
public function integer of_tran_slip_ccl (str_divsrv_tran astr_tran) throws Exception
public function integer of_post_slip_ccl (n_ds ads_slip, n_ds ads_slipdet) throws Exception
public function integer of_tran_slip (str_divsrv_tran astr_tran) throws Exception
protected function integer of_setsrvdoccontrol (boolean ab_switch)
protected function integer of_setsrvdwxmlie (boolean ab_switch)
protected function integer of_setsrvproc (boolean ab_switch)
public function integer of_save_slip_cls (ref str_divsrv_oper astr_divavg_oper) throws Exception
protected function integer of_setsrvdw (boolean ab_switch)
end prototypes

public function integer of_initservice (n_cst_dbconnectservice anv_dbtrans) throws Exception;/***********************************************************
<description>
	ไว้สำหรับเริ่มข้อมูลของ service ทำรายการเกี่ยวกับปันผล
</description>

<arguments>  
	atr_dbtrans					n_cst_dbconnectservice		user object สำหรับต่อฐานข้อมูล
</arguments> 

<return> 
	1								Integer		ถ้าไม่มีข้อมูลผิดพลาด
</return> 

<usage>
	สำหรับเริ่มข้อมูลของ service ทำรายการเกี่ยวกับปันผล
	ตัวอย่าง
	
	n_cst_dbconnectservice inv_db
	lnv_service = create n_cst_divavgoperate_service
	lnv_service.of_initservice( inv_db )
	
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 16/11/2010 by Godji

</usage>

***********************************************************/
itr_sqlca = anv_dbtrans.itr_dbconnection

if isnull( inv_transection ) or not isvalid( inv_transection ) then
	inv_transection = create n_cst_dbconnectservice
	inv_transection = anv_dbtrans
end if

inv_progress = create n_cst_progresscontrol

is_coopcontrol 	= anv_dbtrans.is_coopcontrol
is_coopid			= anv_dbtrans.is_coopid

return 1
end function

public function integer of_init_slip (ref str_divsrv_oper astr_divavg_oper) throws Exception;string ls_xmlmain
string ls_divyear
string ls_memcoopid , ls_memno
boolean lb_err = false
n_ds lds_info_mem
n_ds lds_slip_main , lds_slip_detail

this.of_setsrvproc( true )
this.of_setsrvdwxmlie( true )

lds_info_mem = create n_ds
lds_info_mem.dataobject = "d_divsrv_info_yrmember"
lds_info_mem.settransobject( itr_sqlca )

lds_slip_main = create n_ds
lds_slip_main.dataobject = "d_divsrv_opr_main"
lds_slip_main.settransobject( itr_sqlca )

lds_slip_detail = create n_ds
lds_slip_detail.dataobject = "d_divsrv_opr_detail"
lds_slip_detail.settransobject( itr_sqlca )

ls_xmlmain		= astr_divavg_oper.xml_main

if inv_dwxmliesrv.of_xmlimport( lds_slip_main , ls_xmlmain ) < 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาดในการนำเข้าข้อมูลใบทำรายการจ่ายเงินปันผล-เฉลี่ยคืน(0.1)"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

ls_divyear			= lds_slip_main.object.div_year[1]
ls_memcoopid	= lds_slip_main.object.coop_id[1]
ls_memno			= lds_slip_main.object.member_no[1]

// set ค่าในการดึงข้อมูลสมาชิก
try
	inv_procsrv.of_set_sqldw_column( lds_info_mem, " and yrbgmaster.div_year = '" + ls_divyear + "' " ) // ใส่เงื่อนไขอื่นๆ
	//inv_procsrv.of_set_sqldw_column( lds_info_mem, " and yrbgmaster.coop_id = '" + ls_memcoopid + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_info_mem, " and yrbgmaster.member_no = '" + ls_memno + "' " ) // ใส่เงื่อนไขอื่นๆ
catch( Exception lthw_setdwsql )
	ithw_exception.text	+= "~r~nพบขอผิดพลาด (0.2)"
	ithw_exception.text	+= lthw_setdwsql.text
	lb_err = true
end try
if lb_err then Goto objdestroy

lds_info_mem.retrieve()

// init ข้อมูล
try
	this.of_init_slip_main( lds_info_mem , lds_slip_main )
	this.of_init_slip_detail( lds_slip_main , lds_slip_detail )
catch( Exception lthw_init )
	ithw_exception.text 	= "~r~nพบขอผิดพลาด(10.1)"
	ithw_exception.text	+= lthw_init.text
	ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
	lb_err = true
end try
if lb_err then Goto objdestroy

astr_divavg_oper.xml_main	= inv_dwxmliesrv.of_xmlexport( lds_slip_main )
astr_divavg_oper.xml_detail	= inv_dwxmliesrv.of_xmlexport( lds_slip_detail )

objdestroy:
if isvalid(lds_info_mem) then destroy lds_info_mem
if isvalid(lds_slip_main) then destroy lds_slip_main
if isvalid(lds_slip_detail) then destroy lds_slip_detail

this.of_setsrvdwxmlie( false )
this.of_setsrvproc( false )

if lb_err then
	astr_divavg_oper.xml_main		= ""
	astr_divavg_oper.xml_detail		= ""
	rollback using itr_sqlca ;
	ithw_exception.text = "n_cst_divsrv_operate.of_init_slip()" + ithw_exception.text
	throw ithw_exception
end if

return 1
end function

public function integer of_init_slip_ccl (ref str_divsrv_oper astr_divavg_oper) throws Exception;string ls_xmlmain
string ls_divyear
string ls_memcoopid , ls_memno
string ls_coopid , ls_slipno
boolean lb_err = false
n_ds lds_info_mem
n_ds lds_slip_ccl_main , lds_slip_ccl_list , lds_slip_ccl_detail

this.of_setsrvproc( true )
this.of_setsrvdwxmlie( true )

lds_info_mem = create n_ds
lds_info_mem.dataobject = "d_divsrv_info_member"
lds_info_mem.settransobject( itr_sqlca )

lds_slip_ccl_main = create n_ds
lds_slip_ccl_main.dataobject = "d_divsrv_opr_ccl_main"
lds_slip_ccl_main.settransobject( itr_sqlca )

lds_slip_ccl_list = create n_ds
lds_slip_ccl_list.dataobject = "d_divsrv_opr_ccl_list"
lds_slip_ccl_list.settransobject( itr_sqlca )

lds_slip_ccl_detail = create n_ds
lds_slip_ccl_detail.dataobject = "d_divsrv_opr_ccl_detail"
lds_slip_ccl_detail.settransobject( itr_sqlca )

ls_xmlmain		= astr_divavg_oper.xml_main

if inv_dwxmliesrv.of_xmlimport( lds_slip_ccl_main , ls_xmlmain ) < 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาดในการนำเข้าข้อมูลยกเลิกใบทำรายการจ่ายเงินปันผล-เฉลี่ยคืน(0.1)"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

ls_divyear			= lds_slip_ccl_main.object.div_year[1]
ls_memcoopid		= lds_slip_ccl_main.object.coop_id[1]
ls_memno			= lds_slip_ccl_main.object.member_no[1]

// set ค่าในการดึงข้อมูลสมาชิก
try
	inv_procsrv.of_set_sqldw_column( lds_info_mem, " and mbmembmaster.coop_id = '" + ls_memcoopid + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_info_mem, " and mbmembmaster.member_no = '" + ls_memno + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_slip_ccl_list, " where yrslippayout.div_year = '" + ls_divyear + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_slip_ccl_list, " and yrslippayout.coop_id = '" + ls_memcoopid + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_slip_ccl_list, " and yrslippayout.member_no = '" + ls_memno + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_slip_ccl_list, " and yrslippayout.slip_status = 1 " ) // ใส่เงื่อนไขอื่นๆ
catch( Exception lthw_setdwsql )
	ithw_exception.text	+= "~r~nพบขอผิดพลาด (0.2)"
	ithw_exception.text	+= lthw_setdwsql.text
	lb_err = true
end try
if lb_err then Goto objdestroy

// init ข้อมูล
try
	lds_info_mem.retrieve()
	this.of_init_slip_ccl_main( lds_info_mem , lds_slip_ccl_main )
catch( Exception lthw_init )
	ithw_exception.text 	= "~r~nพบขอผิดพลาด(10.1)"
	ithw_exception.text	+= lthw_init.text
	ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
	lb_err = true
end try
if lb_err then Goto objdestroy

lds_slip_ccl_list.retrieve()

if lds_slip_ccl_list.rowcount() > 0 then
	ls_coopid		= lds_slip_ccl_list.object.coop_id[1]
	ls_slipno			= lds_slip_ccl_list.object.payoutslip_no[1]
	lds_slip_ccl_detail.retrieve( ls_coopid , ls_slipno )
end if

astr_divavg_oper.xml_main	= inv_dwxmliesrv.of_xmlexport( lds_slip_ccl_main )
astr_divavg_oper.xml_list	= inv_dwxmliesrv.of_xmlexport( lds_slip_ccl_list )
astr_divavg_oper.xml_detail	= inv_dwxmliesrv.of_xmlexport( lds_slip_ccl_detail )

objdestroy:
if isvalid(lds_slip_ccl_main) then destroy lds_slip_ccl_main
if isvalid(lds_slip_ccl_list) then destroy lds_slip_ccl_list
if isvalid(lds_slip_ccl_detail) then destroy lds_slip_ccl_detail

this.of_setsrvdwxmlie( false )
this.of_setsrvproc( false )

if lb_err then
	astr_divavg_oper.xml_main		= ""
	astr_divavg_oper.xml_list		= ""
	astr_divavg_oper.xml_detail		= ""
	rollback using itr_sqlca ;
	ithw_exception.text = "n_cst_divsrv_operate.of_init_slip_ccl()" + ithw_exception.text
	throw ithw_exception
end if

return 1
end function

public function integer of_init_slip_grp (ref str_divsrv_oper astr_divavg_oper) throws Exception;string ls_xmloption , ls_xmllist
string ls_column , ls_tag , ls_columntyp , ls_value
string ls_sqlext , ls_sql
datetime ldtm_date
integer li_num_cols , li_index
boolean lb_err = false
n_ds lds_xmloption , lds_xmllist , lds_xmlrpt

this.of_setsrvdwxmlie( true )
this.of_setsrvproc( true )

lds_xmloption = create n_ds
lds_xmloption.dataobject = "d_divsrv_opr_grp_option"
lds_xmloption.settransobject( itr_sqlca )

//lds_xmllist = create n_ds
//lds_xmllist.dataobject = "d_divsrv_opr_grp_list"
//lds_xmllist.settransobject( itr_sqlca )

lds_xmlrpt = create n_ds
lds_xmlrpt.dataobject = "d_divsrv_opr_grp_rpt_sum"
lds_xmlrpt.settransobject( itr_sqlca )

ls_xmloption		= astr_divavg_oper.xml_option

//** เฉพาะกิจทำไปก่อน
lds_xmloption.importstring( XML!, ls_xmloption )
//if inv_dwxmliesrv.of_xmlimport( lds_xmloption , ls_xmloption ) < 1 then
//	ithw_exception.text = "~r~nพบขอผิดพลาด ในการนำเข้าข้อมูล(0.1)"
//	ithw_exception.text += "~r~nเงื่อนไขการดึงข้อมูลจ่ายเงินปันผล-เฉลี่ยคืน"
//	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
//	lb_err = true ; Goto objdestroy
//end if

li_num_cols 	= Integer (lds_xmloption.Describe ( "DataWindow.Column.Count" )) 

for li_index = 1 to li_num_cols
	ls_column 		= trim(lds_xmloption.Describe ( "#" + String(li_index) + ".Name" ))
	ls_tag				= trim(lds_xmloption.Describe ( "#" + String(li_index) + ".Tag" ))
	if isnull( ls_tag ) or ls_tag = '?' then continue
	ls_columntyp	= upper( left( lds_xmloption.Describe ( "#" + String(li_index) + ".ColType" ) , 4 ) )
	choose case ls_columntyp
		case "CHAR"
			if lower( right( ls_column , 4 ) ) = "date" or lower( trim( ls_column ) ) = "ordertype_code" then continue ;// หมายเหตุ เป็นวันที่ให้ข้ามไป ให้ใช้จาก Type DateTime
			ls_value		= lds_xmloption.getitemstring( 1 , ls_column )
			if lower(right( ls_tag , 4 )) = "like" then ls_value = "%" + ls_value + "%"
			ls_value		= "'"+ ls_value + "'"
		case "DECI"
			ls_value		= string( lds_xmloption.getitemdecimal( 1 , ls_column ) )
			if lower(right( ls_tag , 4 )) = "like" then ls_value = "%" + ls_value + "%"
		case "DATE"
			ldtm_date	= lds_xmloption.getitemdatetime( 1 , ls_column )
			if isnull( ldtm_date ) then continue ;
			ls_value		= string( ldtm_date , "yyyy/mm/dd" )
			ls_value		= "convert(datetime, '" + ls_value + "') "
	end choose
	
	if (not IsNull(ls_value)) and trim(ls_value) <> "" then ls_sqlext += " and " + ls_tag + " " + ls_value + " "
	
next

//ls_sql		= lds_xmllist.getsqlselect()
//
//ls_sql		+= ls_sqlext + " and yrdivmethpay.methpay_status = 0 "
//
//if lds_xmllist.setsqlselect( ls_sql ) <> 1 then
//	ithw_exception.text = "~r~nพบขอผิดพลาด ในการนำเข้าข้อมูล(0.2)"
//	ithw_exception.text += "~r~nเงื่อนไขการดึงข้อมูลเตรียมจ่ายปันผล-เฉลี่ยคืน"
//	ithw_exception.text += "~r~n" + lds_xmllist.of_geterrormessage()
//	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
//	lb_err = true ; Goto objdestroy
//end if
//
//if lds_xmllist.retrieve() < 1 then
//	ithw_exception.text = "~r~nพบขอผิดพลาด ในการดึงข้อมูล(0.3)"
//	ithw_exception.text += "~r~nไม่พบข้อมูลเตรียมจ่ายปันผล-เฉลี่ยคืน"
//	ithw_exception.text += "~r~n" + lds_xmllist.of_geterrormessage()
//	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
//	lb_err = true ; Goto objdestroy
//end if

/*
ls_sql		= lds_xmlrpt.getsqlselect()

ls_sql		+= ls_sqlext + " and yrdivmethpay.methpay_status = 0 "
*/

// set ค่าในการดึงข้อมูลสมาชิก
try
	inv_procsrv.of_set_sqldw_column( lds_xmlrpt, ls_sqlext + " and yrdivmethpay.methpay_status = 0 " )
	inv_procsrv.of_set_sqldw_column( lds_xmlrpt, ls_sqlext + " and ( yrdivmethpay.sequest_flag = 0 or yrdivmethpay.sequest_flag is null ) " )
catch( Exception lthw_setdwsql )
	ithw_exception.text	= "~r~nพบขอผิดพลาด (SLIPGRP 0.35)"
	ithw_exception.text	+= lthw_setdwsql.text
	ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
	lb_err = true
end try
if lb_err then Goto objdestroy

//if lds_xmlrpt.setsqlselect( ls_sql ) <> 1 then
//	ithw_exception.text = "~r~nพบขอผิดพลาด ในการนำเข้าข้อมูล(0.4)"
//	ithw_exception.text += "~r~nเงื่อนไขการดึงข้อมูลรายงานเตรียมจ่ายปันผล-เฉลี่ยคืน"
//	ithw_exception.text += "~r~n" + lds_xmllist.of_geterrormessage()
//	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
//	lb_err = true ; Goto objdestroy
//end if

//if lds_xmlrpt.retrieve() < 1 then
	//ithw_exception.text = "~r~nพบขอผิดพลาด ในการดึงข้อมูล(0.5)"
	//ithw_exception.text += "~r~nไม่พบข้อมูลรายงานเตรียมจ่ายปันผล-เฉลี่ยคืน"
	//ithw_exception.text += "~r~n" + lds_xmllist.of_geterrormessage()
	//ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	//lb_err = true ; Goto objdestroy
//end if

astr_divavg_oper.xml_option			= inv_dwxmliesrv.of_xmlexport( lds_xmloption )
//astr_divavg_oper.xml_list				= inv_dwxmliesrv.of_xmlexport( lds_xmllist )
astr_divavg_oper.xml_report			= inv_dwxmliesrv.of_xmlexport( lds_xmlrpt )
//astr_divavg_oper.sql_select_list		= lds_xmllist.getsqlselect()
astr_divavg_oper.sql_select_report	= lds_xmlrpt.getsqlselect()

objdestroy:
if isvalid(lds_xmloption) then destroy lds_xmloption
if isvalid(lds_xmllist) then destroy lds_xmllist
if isvalid(lds_xmlrpt) then destroy lds_xmlrpt

this.of_setsrvdwxmlie( false )

if lb_err then
	astr_divavg_oper.xml_option			= ""
	astr_divavg_oper.xml_list				= ""
	astr_divavg_oper.xml_report			= ""
	astr_divavg_oper.sql_select_list		= ""
	astr_divavg_oper.sql_select_report	= ""
	rollback using itr_sqlca ;
	ithw_exception.text = "n_cst_divsrv_operate.of_init_slip_grp()" + ithw_exception.text
	throw ithw_exception
end if

return 1
end function

public function integer of_save_slip (ref str_divsrv_oper astr_divavg_oper) throws Exception;string ls_xmlmain , ls_xmldetail
string ls_coopid , ls_memcoop , ls_memno , ls_divyear
string ls_methpay , ls_divitem , ls_expaccid
string ls_bizzcoop , ls_bizztyp , ls_bizzaccno
string ls_slipno , ls_entryid
integer li_index , li_count , li_seqno , li_shseqno , li_divsign , li_tranyear , li_sequest
dec{2} ldc_divamt , ldc_avgamt , ldc_etcamt , ldc_itempay
dec{2} ldc_divbal , ldc_avgbal , ldc_etcbal , ldc_expbal , ldc_itembal
dec{2} ldc_expamt , ldc_sequest , ldc_prin , ldc_int
datetime ldtm_entry , ldtm_oper , ldtm_slip
boolean lb_err = false
n_ds lds_slip_main , lds_slip_detail

this.of_setsrvdwxmlie( true )
this.of_setsrvdoccontrol( true )

lds_slip_main = create n_ds
lds_slip_main.dataobject = "d_divsrv_opr_main"
lds_slip_main.settransobject( itr_sqlca )

lds_slip_detail = create n_ds
lds_slip_detail.dataobject = "d_divsrv_opr_detail"
lds_slip_detail.settransobject( itr_sqlca )

ls_xmlmain		= astr_divavg_oper.xml_main
ls_xmldetail		= astr_divavg_oper.xml_detail

if inv_dwxmliesrv.of_xmlimport( lds_slip_main , ls_xmlmain ) < 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาดในการนำเข้าข้อมูลใบทำรายการจ่ายเงินปันผลเฉลี่ยคืน(0.1)"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

if inv_dwxmliesrv.of_xmlimport( lds_slip_detail , ls_xmldetail ) < 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาดในการนำเข้าข้อมูลใบคำขอวิธีจ่ายเงินปันผลเฉลี่ยคืน(0.2)"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

ls_coopid			= lds_slip_main.object.coop_id[1]
ls_memcoop		= lds_slip_main.object.coop_id[1]
ls_memno			= lds_slip_main.object.member_no[1]
ls_divyear			= lds_slip_main.object.div_year[1]
ls_entryid			= lds_slip_main.object.entry_id[1]
ldtm_oper			= lds_slip_main.object.operate_date[1]
ldtm_slip				= lds_slip_main.object.slip_date[1]
ldtm_entry			= datetime( today() , now() )

li_tranyear			= integer( left( trim( ls_divyear ) , 4 ) )

try
	ls_slipno	= inv_docsrv.of_getnewdocno( ls_coopid , "YRSLIPPAYOUT")	// get เลขที่เอกสาร
catch( Exception lthw_getreqdoc )
	ithw_exception.text	= "~r~nพบขอผิดพลาด (20.1)" + lthw_getreqdoc.text
	lb_err = true
end try
if lb_err then Goto objdestroy

lds_slip_main.object.payoutslip_no[1]		= ls_slipno
lds_slip_main.object.entry_date[1]		= datetime( today() , now() )
lds_slip_main.object.slip_status[1]			= 1

li_count	= lds_slip_detail.rowcount()

for li_index = 1 to li_count
	lds_slip_detail.object.coop_id[li_index]				= ls_coopid
	lds_slip_detail.object.payoutslip_no[li_index]		= ls_slipno
next

// บันทึก Main
if lds_slip_main.update() <> 1 then
	ithw_exception.text	= "~r~nบันทึกข้อมูลจ่ายเงินปันผลเฉลี่ยคืน (Main) ไม่ได้ (70.1)"
	ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
	ithw_exception.text	+= "~r~n" + lds_slip_main.of_geterrormessage()
	ithw_exception.text	+= "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

// บันทึก Detail
if lds_slip_detail.update() <> 1 then
	ithw_exception.text	= "~r~nบันทึกข้อมูลจ่ายเงินปันผลเฉลี่ยคืน (Detail) ไม่ได้ (70.2)"
	ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
	ithw_exception.text	+= "~r~n" + lds_slip_detail.of_geterrormessage()
	ithw_exception.text	+= "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

for li_index = 1 to li_count
	
	ls_methpay		= lds_slip_detail.object.methpaytype_code[li_index]
	ls_expaccid		= lds_slip_detail.object.expense_accid[li_index]
	ls_bizzcoop 		= lds_slip_detail.object.bizzcoop_id[li_index]
	ls_bizztyp 		= lds_slip_detail.object.bizztype_code[li_index]
	ls_bizzaccno		= lds_slip_detail.object.bizzaccount_no[li_index]
	li_seqno			= lds_slip_detail.object.seq_no[li_index]
	ldc_expamt		= lds_slip_detail.object.item_payment[li_index]
	ldc_divamt		= lds_slip_detail.object.div_payment[li_index]
	ldc_avgamt		= lds_slip_detail.object.avg_payment[li_index]
	ldc_etcamt		= lds_slip_detail.object.etc_payment[li_index]
	ldc_prin			= lds_slip_detail.object.prin_payment[li_index]
	ldc_int			= lds_slip_detail.object.int_payment[li_index]
	//** ค้างเฉลี่ยการตัดจ่ายยอดปันผล เฉลี่ยคืน ปันผลค้างจ่าย
	//** hard code
	select yud.divitemtype_code , yud.sign_flag 
	into :ls_divitem , :li_divsign
	from yrucfmethpay yum , yrucfdivitemtype yud
	where yum.methpaystm_itemtype = yud.divitemtype_code
	and yum.methpaytype_code = :ls_methpay
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (60.0)"
		ithw_exception.text	+= "~r~nไม่พบข้อมูลทำรายการ ไม่ได้"
		ithw_exception.text	+= "~r~nประเภทรายการ : " + ls_methpay
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	
	select div_balamt , avg_balamt , etc_balamt
	into :ldc_divbal , :ldc_avgbal , :ldc_etcbal
	from yrdivmaster
	where coop_id= :ls_memcoop
	and member_no	= :ls_memno
	and div_year		= :ls_divyear
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (60.1)"
		ithw_exception.text	+= "~r~nไม่พบข้อมูลปันผล ไม่ได้"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	ldc_expbal		= ldc_expamt
//	DO WHILE ldc_expbal > 0
		if ldc_etcbal > 0 and ldc_expbal > 0 then
			if ldc_etcbal > ldc_expbal then // สำหรับตรวจว่าหักไปกี่บาท
				ldc_expbal = 0
			else
				ldc_expbal = ldc_expbal - ldc_etcamt
			end if
		end if
		
		if ldc_avgbal > 0 and ldc_expbal > 0 then
			if ldc_avgbal > ldc_expbal then
				ldc_expbal = 0
			else
				ldc_expbal = ldc_expbal - ldc_avgamt
			end if
		end if
		
		if ldc_divbal > 0 and ldc_expbal > 0 then
			if ldc_divbal > ldc_expbal then
				ldc_expbal = 0
			else
				ldc_expbal = ldc_expbal - ldc_divamt
			end if
		end if
		
//	LOOP
	
	ldc_divbal		= ldc_divbal + ( li_divsign * ldc_divamt )
	ldc_avgbal		= ldc_avgbal + ( li_divsign * ldc_avgamt )
	ldc_etcbal		= ldc_etcbal + ( li_divsign * ldc_etcamt )
	
	ldc_itempay	= ldc_divamt + ldc_avgamt + ldc_etcamt
	ldc_itembal	= ldc_divbal + ldc_avgbal + ldc_etcbal
	//** จบ hard code
	
	update yrdivmethpay
	set methpay_status = 1 ,
	ref_slipcoop = :ls_coopid,
	ref_slipno = :ls_slipno
	where coop_id = :ls_memcoop
	and member_no = :ls_memno
	and seq_no = :li_seqno
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (70.3)"
		ithw_exception.text	+= "~r~nอัพเดทสถานะผ่านรายการจ่ายปันผล-เฉลี่ยคืน ไม่ได้"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	
	select max( ds.seq_no ) 
	into :li_shseqno
	from yrdivstatement ds 
	where ds.coop_id = :ls_memcoop
	and ds.member_no = :ls_memno
	and ds.div_year = :ls_divyear
	using itr_sqlca ;
	if itr_sqlca.sqlcode <> 0 or isnull( li_shseqno ) then li_shseqno = 0
	li_shseqno++
	
	insert into yrdivstatement
	( coop_id , member_no , div_year , seq_no , operate_date , slip_date , divitemtype_code , 
	div_payment , avg_payment , etc_payment , item_payment , item_balamt ,  
	item_status , entry_id , entry_date , ref_slipcoop , ref_slipno )
	values
	( :ls_memcoop , :ls_memno , :ls_divyear , :li_shseqno , :ldtm_oper , :ldtm_slip , :ls_divitem ,
	:ldc_divamt , :ldc_avgamt , :ldc_etcamt , :ldc_itempay , :ldc_itembal ,
	1 , :ls_entryid , :ldtm_entry	, :ls_coopid , :ls_slipno ) using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (70.4)"
		ithw_exception.text	+= "~r~nนำเข้ารายการเคลื่อนไหวปันผล-เฉลี่ยคืน ไม่ได้"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	
	update yrdivmaster
	set div_balamt 	= :ldc_divbal, 
	avg_balamt 		= :ldc_avgbal, 
	etc_balamt		= :ldc_etcbal,
	item_balamt		= :ldc_itembal
	where coop_id= :ls_memcoop
	and member_no	= :ls_memno
	and div_year		= :ls_divyear
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (70.5)"
		ithw_exception.text	+= "~r~nอัพเดทข้อมูลปันผล-เฉลี่ยคืนคงเหลือ ไม่ได้"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	
	//** hardcode
	
	if ls_methpay = 'DEP' then
		li_sequest		= lds_slip_detail.object.sequest_flag[li_index]
		ldc_sequest		= lds_slip_detail.object.sequest_amt[li_index]
		insert into dpdepttran
		( coop_id , deptaccount_no , memcoop_id , member_no , system_code , tran_year , tran_date , seq_no , deptitem_amt , tran_status , dividen_amt , average_amt , branch_operate , sequest_status , sequest_amt , ref_slipno , ref_coopid )
		values
		( :ls_coopid , :ls_expaccid , :ls_memcoop , :ls_memno , 'DIV' , :li_tranyear , :ldtm_oper , 1 , :ldc_itempay , 0 , :ldc_divamt , :ldc_avgamt , '000' , :li_sequest , :ldc_sequest , :ls_slipno , :ls_coopid )
		using itr_sqlca ;
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "~r~nพบขอผิดพลาด (70.6)"
			ithw_exception.text	+= "~r~nผ่านรายการข้อมูลปันผล-เฉลี่ยคืน ไปเงินฝาก ไม่ได้"
			ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
			ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
			ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
			ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
			lb_err = true ; if lb_err then Goto objdestroy
		end if
	end if
	
	if ls_methpay = 'LON' then
		insert into sltranspayin
		( 	coop_id , memcoop_id , member_no , trans_date , seq_no , 
			transitem_code , realpay_date , shrtype_code , concoop_id , loancontract_no ,
			transpay_type , trans_amt , principal_trnamt , interest_trnamt , sliptype_code , trnsource_code , trnsource_refslipno, trnsource_status , moneytype_code , post_status )
		values
		( 	:is_coopcontrol , :is_coopcontrol , :ls_memno , :ldtm_oper , nvl( ( select max( seq_no ) from sltranspayin where coop_id = :ls_coopid and coop_id = :ls_memcoop and member_no = :ls_memno and trans_date = :ldtm_oper ) , 0 ) + 1 ,
			'LON' , :ldtm_oper , :ls_bizztyp , :ls_bizzcoop , :ls_bizzaccno ,
			2 , :ldc_itempay , :ldc_prin , :ldc_int , 'PX' , 'DIV' , :ls_slipno , 8 , 'TRN' , 0 )
		using itr_sqlca ;
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "~r~nพบขอผิดพลาด (70.7)"
			ithw_exception.text	+= "~r~nผ่านรายการข้อมูลปันผล-เฉลี่ยคืน ไปชำระเงินกู้ ไม่ได้"
			ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
			ithw_exception.text	+= "~r~nเลขที่สัญญา : " + ls_bizzaccno
			ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
			ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
			ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
			lb_err = true ; if lb_err then Goto objdestroy
		end if
		
		update lnpreparepay
		set prepare_status = 1 , 
		ref_slipcoop = :is_coopid , 
		ref_slipno = :ls_slipno , 
		entrypay_id = :ls_entryid , 
		entrypay_date = sysdate
		where coop_id = :is_coopcontrol
		and loancontract_no = :ls_bizzaccno
		and prepare_status = 8
		using itr_sqlca;
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "~r~nพบขอผิดพลาด (70.8)"
			ithw_exception.text	+= "~r~nผ่านรายการข้อมูลปันผล-เฉลี่ยคืน ไปชำระเงินกู้ ไม่ได้"
			ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
			ithw_exception.text	+= "~r~nเลขที่สัญญา : " + ls_bizzaccno
			ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
			ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
			ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
			lb_err = true ; if lb_err then Goto objdestroy
		end if
		
	end if
	
	ldc_divamt	= 0
	ldc_avgamt	= 0
	ldc_etcamt	= 0
	ldc_divbal	= 0
	ldc_avgbal	= 0
	ldc_etcbal	= 0
	//** จบ hardcode	
	
next

//ส่งเลขที่จ่ายกลับเอาไว้ไปพิมพ์ใบสำคัญ
astr_divavg_oper.payoutslip_no = ls_slipno

objdestroy:
if isvalid(lds_slip_main) then destroy lds_slip_main
if isvalid(lds_slip_detail) then destroy lds_slip_detail

this.of_setsrvdwxmlie( false )
this.of_setsrvdoccontrol( false )
if lb_err then
	rollback using itr_sqlca ;
	ithw_exception.text = "n_cst_divsrv_operate.of_save_slip()" + ithw_exception.text
	throw ithw_exception
else
	commit using itr_sqlca ;
end if

return 1
end function

public function integer of_save_slip_ccl (ref str_divsrv_oper astr_divavg_oper) throws Exception;string ls_xmlmain , ls_xmllist
string ls_divyear
string ls_memcoop , ls_memno
string ls_coopid , ls_slipno
string ls_entryid
integer li_index , li_count
datetime ldtm_oper , ldtm_slip , ldtm_entry
boolean lb_err = false
n_ds lds_slip_ccl_main , lds_slip_ccl_list , lds_slip_main , lds_slip_detail

this.of_setsrvdwxmlie( true )

lds_slip_ccl_main = create n_ds
lds_slip_ccl_main.dataobject = "d_divsrv_opr_ccl_main"
lds_slip_ccl_main.settransobject( itr_sqlca )

lds_slip_ccl_list = create n_ds
lds_slip_ccl_list.dataobject = "d_divsrv_opr_ccl_list"
lds_slip_ccl_list.settransobject( itr_sqlca )

lds_slip_main = create n_ds
lds_slip_main.dataobject = "d_divsrv_opr_main"
lds_slip_main.settransobject( itr_sqlca )

lds_slip_detail = create n_ds
lds_slip_detail.dataobject = "d_divsrv_opr_detail"
lds_slip_detail.settransobject( itr_sqlca )

ls_xmlmain		= astr_divavg_oper.xml_main
ls_xmllist			= astr_divavg_oper.xml_list

if inv_dwxmliesrv.of_xmlimport( lds_slip_ccl_main , ls_xmlmain ) < 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาดในการนำเข้าข้อมูลยกเลิกใบทำรายการจ่ายเงินปันผล-เฉลี่ยคืน(0.1)"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

if inv_dwxmliesrv.of_xmlimport( lds_slip_ccl_list , ls_xmllist ) < 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาดในการนำเข้าข้อมูลยกเลิกใบทำรายการจ่ายเงินปันผล-เฉลี่ยคืน(0.2)"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

ls_memcoop		= lds_slip_ccl_main.object.coop_id[1]
ls_memno			= lds_slip_ccl_main.object.member_no[1]
ls_entryid			= lds_slip_ccl_main.object.entry_id[1]
ldtm_oper			= lds_slip_ccl_main.object.operate_date[1]
ldtm_slip				= lds_slip_ccl_main.object.slip_date[1]
ldtm_entry			= datetime( today() , now() )

// กรองให้เหลือแต่พวกที่ทำรายการเท่านั้น
lds_slip_ccl_list.setfilter( "operate_flag > 0" )
lds_slip_ccl_list.filter()
// ลบพวกไม่ทำรายการทิ้งไป
lds_slip_ccl_list.rowsdiscard( 1, lds_slip_ccl_list.filteredcount(), filter! )

li_count	= lds_slip_ccl_list.rowcount()

for li_index = 1 to li_count
	
	ls_divyear		= lds_slip_ccl_list.object.div_year[li_index]
	ls_coopid		= lds_slip_ccl_list.object.coop_id[li_index]
	ls_slipno			= lds_slip_ccl_list.object.payoutslip_no[li_index]
	
	try
		this.of_chk_slip_ccl( ls_coopid , ls_slipno )
	catch( Exception lthw_chkslip )
		ithw_exception.text	+= lthw_chkslip.text
		ithw_exception.text += "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text += "~r~nกรุณาตรวจสอบ"
		lb_err = true 
	end try
	if lb_err then Goto objdestroy
	
	if lds_slip_main.retrieve( ls_coopid , ls_slipno ) > 0 then
		lds_slip_main.object.cancel_id[1]	= ls_entryid
		if lds_slip_detail.retrieve( ls_coopid , ls_slipno ) > 0 then
			// ผ่านรายการยกเลิก
			try
				this.of_post_slip_ccl( lds_slip_main , lds_slip_detail )
			catch( Exception lthw_postslipccl )
				ithw_exception.text	+= lthw_postslipccl.text
				lb_err = true
			end try
			if lb_err then Goto objdestroy
		else
			ithw_exception.text += "~r~nพบขอผิดพลาดในการดึงข้อมูลใบทำรายการยกเลิกส่วนรายละเอียด(0.52)"
			ithw_exception.text += "~r~nกรุณาตรวจสอบ"
			lb_err = true ; Goto objdestroy
		end if
	else
		ithw_exception.text += "~r~nพบขอผิดพลาดในการดึงข้อมูลใบทำรายการยกเลิกหัวใบเสร็จ(0.51)"
		ithw_exception.text += "~r~nกรุณาตรวจสอบ"
		lb_err = true ; Goto objdestroy
	end if
	
next

objdestroy:
if isvalid(lds_slip_ccl_main) then destroy lds_slip_ccl_main
if isvalid(lds_slip_ccl_list) then destroy lds_slip_ccl_list
if isvalid(lds_slip_main) then destroy lds_slip_main
if isvalid(lds_slip_detail) then destroy lds_slip_detail

this.of_setsrvdwxmlie( false )

if lb_err then
	rollback using itr_sqlca ;
	ithw_exception.text = "n_cst_divsrv_operate.of_init_slip_ccl()" + ithw_exception.text
	throw ithw_exception
else
	commit using itr_sqlca ;
end if

return 1
end function

public function integer of_save_slip_grp (ref str_divsrv_oper astr_divavg_oper) throws Exception;string ls_xmloption , ls_xmllist
string ls_column , ls_tag , ls_columntyp , ls_value
string ls_sqlext , ls_sql
string ls_moneytype , ls_expbank , ls_expbranch , ls_expaccid , ls_expbanktyp
string ls_bizzcoop , ls_bizztyp , ls_bizzaccno
string ls_tofromaccid
string ls_coopid , ls_entryid
string ls_memcoop , ls_slipno , ls_divyear
string ls_memno , ls_methpay , ls_divitem
integer li_num_cols , li_index , li_seqno , li_shseqno
integer li_mrow , li_drow , li_erow , li_divsign , li_sequest
integer li_tranyear
long ll_index , ll_count
dec{2} ldc_divamt , ldc_avgamt , ldc_etcamt , ldc_itempay
dec{2} ldc_divbal , ldc_avgbal , ldc_etcbal , ldc_expbal , ldc_itembal
dec{2} ldc_prin , ldc_int , ldc_fee
dec{2} ldc_expamt , ldc_sequest
datetime ldtm_oper , ldtm_slip , ldtm_date
datetime ldtm_entry
boolean lb_err = false
n_ds lds_xmloption , lds_xmllist
n_ds lds_slip_main , lds_slip_det

this.of_setsrvdwxmlie( true )
this.of_setsrvdoccontrol( true )

inv_progress.istr_progress.progress_text = "ประมวลจ่ายเงินปันผล-เฉลี่ยคืน"
inv_progress.istr_progress.progress_index = 0
inv_progress.istr_progress.progress_max = 1
inv_progress.istr_progress.subprogress_text = "เตรียมข้อมูล"
inv_progress.istr_progress.subprogress_index = 0
inv_progress.istr_progress.subprogress_max = 1
inv_progress.istr_progress.status = 8

lds_xmloption = create n_ds
lds_xmloption.dataobject = "d_divsrv_opr_grp_option"
lds_xmloption.settransobject( itr_sqlca )

lds_xmllist = create n_ds
lds_xmllist.dataobject = "d_divsrv_opr_grp_list"
lds_xmllist.settransobject( itr_sqlca )

lds_slip_main = create n_ds
lds_slip_main.dataobject = "d_divsrv_opr_main"
lds_slip_main.settransobject( itr_sqlca )

lds_slip_det = create n_ds
lds_slip_det.dataobject = "d_divsrv_opr_detail"
lds_slip_det.settransobject( itr_sqlca )

ls_xmloption		= astr_divavg_oper.xml_option

//** เฉพาะกิจทำไปก่อน
lds_xmloption.importstring( XML!, ls_xmloption )
//if inv_dwxmliesrv.of_xmlimport( lds_xmloption , ls_xmloption ) < 1 then
//	ithw_exception.text = "~r~nพบขอผิดพลาด ในการนำเข้าข้อมูล(0.1)"
//	ithw_exception.text += "~r~nเงื่อนไขการดึงข้อมูลจ่ายเงินปันผล-เฉลี่ยคืน"
//	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
//	lb_err = true ; Goto objdestroy
//end if

li_num_cols 	= Integer (lds_xmloption.Describe ( "DataWindow.Column.Count" )) 

for li_index = 1 to li_num_cols
	ls_column 		= trim(lds_xmloption.Describe ( "#" + String(li_index) + ".Name" ))
	ls_tag				= trim(lds_xmloption.Describe ( "#" + String(li_index) + ".Tag" ))
	if isnull( ls_tag ) or ls_tag = '?' then continue
	ls_columntyp	= upper( left( lds_xmloption.Describe ( "#" + String(li_index) + ".ColType" ) , 4 ) )
	choose case ls_columntyp
		case "CHAR"
			if lower( right( ls_column , 4 ) ) = "date" or lower( trim( ls_column ) ) = "ordertype_code" then continue ;// หมายเหตุ เป็นวันที่ให้ข้ามไป ให้ใช้จาก Type DateTime
			ls_value		= lds_xmloption.getitemstring( 1 , ls_column )
			if lower(right( ls_tag , 4 )) = "like" then ls_value = "%" + ls_value + "%"
			ls_value		= "'"+ ls_value + "'"
		case "DECI"
			ls_value		= string( lds_xmloption.getitemdecimal( 1 , ls_column ) )
			if lower(right( ls_tag , 4 )) = "like" then ls_value = "%" + ls_value + "%"
		case "DATE"
			ldtm_date	= lds_xmloption.getitemdatetime( 1 , ls_column )
			if isnull( ldtm_date ) then continue ;
			ls_value		= string( ldtm_date , "dd/mm/yyyy" )
			ls_value		= "to_date( '" + ls_value + "' , 'dd/mm/yyyy' ) "
	end choose
	
	if (not IsNull(ls_value)) and trim(ls_value) <> "" then ls_sqlext += " and " + ls_tag + " " + ls_value + " "
	
next

ls_sql		= lds_xmllist.getsqlselect()

ls_sql		+= ls_sqlext + " and yrdivmethpay.methpay_status = 0 "
ls_sql		+= ls_sqlext + " and ( yrdivmethpay.sequest_flag = 0 or yrdivmethpay.sequest_flag is null ) "

if lds_xmllist.setsqlselect( ls_sql ) <> 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาด ในการนำเข้าข้อมูล(0.2)"
	ithw_exception.text += "~r~nเงื่อนไขการดึงข้อมูลเตรียมจ่ายปันผล-เฉลี่ยคืน"
	ithw_exception.text += "~r~n" + lds_xmllist.of_geterrormessage()
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

if lds_xmllist.retrieve() < 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาด ในการดึงข้อมูล(0.3)"
	ithw_exception.text += "~r~nไม่พบข้อมูลเตรียมจ่ายปันผล-เฉลี่ยคืน"
	ithw_exception.text += "~r~n" + lds_xmllist.of_geterrormessage()
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

ls_coopid			= lds_xmloption.object.coop_id[1]
ls_divyear		= lds_xmloption.object.div_year[1]
ls_entryid		= lds_xmloption.object.entry_id[1]
ls_tofromaccid	= lds_xmloption.object.tofrom_accid[1]
ldtm_oper 		= lds_xmloption.object.operate_date[1]
ldtm_slip			= lds_xmloption.object.slip_date[1]

li_tranyear		= integer( left( trim( ls_divyear ) , 4 ) )

//วัน loop ผ่านรายการ
ll_count	= lds_xmllist.rowcount()


inv_progress.istr_progress.subprogress_max = ll_count

for ll_index = 1 to ll_count
	
	inv_progress.istr_progress.subprogress_index = ll_index
	
	yield()
	if inv_progress.of_is_stop() then
		ithw_exception.text = "~r~nยกเลิกการประมวลโดยผู้ทำรายการ ( Slip Group 50.1)"
		lb_err		= true ; Goto objdestroy
	end if
	
	ldtm_entry		= datetime( today() , now() )
	
	ls_memcoop	= lds_xmllist.object.coop_id[ll_index]
	ls_memno		= lds_xmllist.object.member_no[ll_index]
	ls_methpay		= lds_xmllist.object.methpaytype_code[ll_index]
	ls_moneytype	= lds_xmllist.object.moneytype_code[ll_index]
	ls_expbank 		= lds_xmllist.object.expense_bank[ll_index]
	ls_expbranch 	= lds_xmllist.object.expense_branch[ll_index]
	ls_expaccid		= lds_xmllist.object.expense_accid[ll_index]
	ls_expbanktyp	= lds_xmllist.object.expense_bank_typ[ll_index]
	ls_bizzcoop 		= lds_xmllist.object.bizzcoop_id[ll_index]
	ls_bizztyp 		= lds_xmllist.object.bizztype_code[ll_index]
	ls_bizzaccno		= lds_xmllist.object.bizzaccount_no[ll_index]
	ldc_divamt		= lds_xmllist.object.div_amt[ll_index]
	ldc_avgamt		= lds_xmllist.object.avg_amt[ll_index]
	ldc_etcamt		= lds_xmllist.object.etc_amt[ll_index]
	ldc_prin			= lds_xmllist.object.prin_amt[ll_index]
	ldc_int			= lds_xmllist.object.int_amt[ll_index]
	li_seqno			= lds_xmllist.object.seq_no[ll_index]
	li_sequest		= lds_xmllist.object.sequest_flag[ll_index]
	ldc_sequest		= lds_xmllist.object.sequest_amt[ll_index]
	ldc_expamt		= lds_xmllist.object.expense_amt[ll_index]
	
	lds_slip_main.reset()
	lds_slip_det.reset()
	
	li_mrow	= lds_slip_main.insertrow(0)
	li_drow	= lds_slip_det.insertrow(0)
	
	ldc_fee	= 0
	if ls_moneytype = "CBT" and is_coopcontrol = "010001" then
		ldc_fee	= 5
	end if
	
	try
		ls_slipno	= inv_docsrv.of_getnewdocno( ls_coopid , "YRSLIPPAYOUT")	// get เลขที่เอกสาร
	catch( Exception lthw_getreqdoc )
		ithw_exception.text	= "~r~nพบขอผิดพลาด (20.1)" + lthw_getreqdoc.text
		lb_err = true
	end try
	if lb_err then Goto objdestroy
	
	lds_slip_main.object.coop_id[li_mrow]				= ls_coopid
	lds_slip_main.object.div_year[li_mrow]				= ls_divyear
	lds_slip_main.object.payoutslip_no[li_mrow]		= ls_slipno
	lds_slip_main.object.coop_id[li_mrow]			= ls_memcoop
	lds_slip_main.object.member_no[li_mrow]			= ls_memno
	lds_slip_main.object.operate_date[li_mrow]		= ldtm_oper
	lds_slip_main.object.slip_date[li_mrow]				= ldtm_slip
	lds_slip_main.object.payout_payment[li_mrow]	= ldc_expamt
	lds_slip_main.object.slip_status[li_mrow]			= 1
	lds_slip_main.object.entry_id[li_mrow]				= ls_entryid
	lds_slip_main.object.entry_date[li_mrow]			= ldtm_entry
	
	//** ค้างเฉลี่ยการตัดจ่ายยอดปันผล เฉลี่ยคืน ปันผลค้างจ่าย
	//** hard code
	select yud.divitemtype_code , yud.sign_flag 
	into :ls_divitem , :li_divsign
	from yrucfmethpay yum , yrucfdivitemtype yud
	where yum.coop_id = yud.coop_id
	and yum.methpaystm_itemtype = yud.divitemtype_code
	and yum.coop_id = :is_coopcontrol
	and yum.methpaytype_code = :ls_methpay
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (60.0)"
		ithw_exception.text	+= "~r~nไม่พบข้อมูลทำรายการ ไม่ได้"
		ithw_exception.text	+= "~r~nประเภทรายการ : " + ls_methpay
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
		
	select div_balamt , avg_balamt , etc_balamt
	into :ldc_divbal , :ldc_avgbal , :ldc_etcbal
	from yrdivmaster
	where coop_id= :ls_memcoop
	and member_no	= :ls_memno
	and div_year		= :ls_divyear
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (60.1)"
		ithw_exception.text	+= "~r~nไม่พบข้อมูลปันผล ไม่ได้"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	ldc_expbal		= ldc_expamt
	
	if ldc_divbal + ldc_avgbal + ldc_etcbal <= 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (60.2)"
		ithw_exception.text	+= "~r~nเงินปันผล-เฉลี่ยคืน ไม่พอจ่าย"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~nยอดปันผล-เฉลี่ยคืนคงเหลือ : " + string( ldc_divbal + ldc_avgbal + ldc_etcbal , "#,###,##0.00" ) + " บาท"
		ithw_exception.text	+= "~r~nยอดทำรายการ : " + string( ldc_expamt , "#,###,##0.00" ) + " บาท"
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	
//	DO WHILE ldc_expbal > 0
//		if ldc_etcbal > 0 and ldc_expbal > 0 then
//			if ldc_etcbal > ldc_expbal then
//				ldc_etcamt = ldc_etcamt + ldc_expbal	// สำหรับตรวจว่าหักไปกี่บาท
//				ldc_expbal = 0
//			else
//				ldc_etcamt = ldc_etcbal
//				ldc_expbal = ldc_expbal - ldc_etcbal
//			end if
//		end if
//		
//		if ldc_avgbal > 0 and ldc_expbal > 0 then
//			if ldc_avgbal > ldc_expbal then
//				ldc_avgamt = ldc_avgamt + ldc_expbal
//				ldc_expbal = 0
//			else
//				ldc_avgamt = ldc_avgbal
//				ldc_expbal = ldc_expbal - ldc_avgbal
//			end if
//		end if
//		
//		if ldc_divbal > 0 and ldc_expbal > 0 then
//			if ldc_divbal > ldc_expbal then
//				ldc_divamt = ldc_divamt + ldc_expbal
//				ldc_expbal = 0
//			else
//				ldc_divamt = ldc_divbal
//				ldc_expbal = ldc_expbal - ldc_divbal
//			end if
//		end if
		
//	LOOP
	
	ldc_divbal		= ldc_divbal + ( li_divsign * ldc_divamt )
	ldc_avgbal		= ldc_avgbal + ( li_divsign * ldc_avgamt )
	ldc_etcbal		= ldc_etcbal + ( li_divsign * ldc_etcamt )
	
	ldc_itempay	= ldc_divamt + ldc_avgamt + ldc_etcamt
	ldc_itembal	= ldc_divbal + ldc_avgbal + ldc_etcbal
	//** จบ hard code
	
	lds_slip_det.object.coop_id[li_drow]					= ls_coopid
	lds_slip_det.object.payoutslip_no[li_drow]			= ls_slipno
	lds_slip_det.object.seq_no[li_drow]					= 1
	lds_slip_det.object.methpaytype_code[li_drow]		= ls_methpay
	lds_slip_det.object.moneytype_code[li_drow]		= ls_moneytype	
	lds_slip_det.object.tofrom_accid[li_drow]			= ls_tofromaccid	
	lds_slip_det.object.expense_bank[li_drow]			= ls_expbank
	lds_slip_det.object.expense_branch[li_drow]		= ls_expbranch
	lds_slip_det.object.expense_accid[li_drow]			= ls_expaccid
	lds_slip_det.object.expense_bank_typ[li_drow]		= ls_expbanktyp
	lds_slip_det.object.div_payment[li_drow]			= ldc_divamt
	lds_slip_det.object.avg_payment[li_drow]			= ldc_avgamt
	lds_slip_det.object.etc_payment[li_drow]			= ldc_etcamt
	lds_slip_det.object.fee_amt[li_drow]					= ldc_fee
	lds_slip_det.object.item_payment[li_drow]			= ldc_expamt
	lds_slip_det.object.sequest_flag[li_drow]			= li_sequest
	lds_slip_det.object.sequest_amt[li_drow]			= ldc_sequest
	lds_slip_det.object.bizzcoop_id[li_drow]				= ls_bizzcoop
	lds_slip_det.object.bizztype_code[li_drow]			= ls_bizztyp
	lds_slip_det.object.bizzaccount_no[li_drow]			= ls_bizzaccno
	lds_slip_det.object.prin_payment[li_drow]			= ldc_prin
	lds_slip_det.object.int_payment[li_drow]				= ldc_int
	
	// บันทึก Main
	if lds_slip_main.update() <> 1 then
		ithw_exception.text	= "~r~nบันทึกข้อมูลจ่ายเงินปันผลเฉลี่ยคืน (Main) ไม่ได้ (70.1)"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + lds_slip_main.of_geterrormessage()
		ithw_exception.text	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; Goto objdestroy
	end if

	// บันทึก Detail
	if lds_slip_det.update() <> 1 then
		ithw_exception.text	= "~r~nบันทึกข้อมูลจ่ายเงินปันผลเฉลี่ยคืน (Detail) ไม่ได้ (70.2)"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + lds_slip_det.of_geterrormessage()
		ithw_exception.text	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; Goto objdestroy
	end if

	update yrdivmethpay
	set methpay_status = 1 ,
	ref_slipcoop = :ls_coopid,
	ref_slipno = :ls_slipno
	where coop_id = :ls_memcoop
	and member_no = :ls_memno
	and seq_no = :li_seqno
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (70.3)"
		ithw_exception.text	+= "~r~nอัพเดทสถานะผ่านรายการจ่ายปันผล-เฉลี่ยคืน ไม่ได้"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	
	select max( ds.seq_no ) 
	into :li_shseqno
	from yrdivstatement ds 
	where ds.coop_id = :ls_memcoop
	and ds.member_no = :ls_memno
	and ds.div_year = :ls_divyear
	using itr_sqlca ;
	if itr_sqlca.sqlcode <> 0 or isnull( li_shseqno ) then li_shseqno = 0
	li_shseqno++
	
	insert into yrdivstatement
	( coop_id , member_no , div_year , seq_no , operate_date , slip_date , divitemtype_code , 
	div_payment , avg_payment , etc_payment , item_payment , item_balamt ,  
	item_status , entry_id , entry_date , ref_slipcoop , ref_slipno )
	values
	( :ls_memcoop , :ls_memno , :ls_divyear , :li_shseqno , :ldtm_oper , :ldtm_slip , :ls_divitem ,
	:ldc_divamt , :ldc_avgamt , :ldc_etcamt , :ldc_itempay , :ldc_itembal ,
	1 , :ls_entryid , sysdate	, :ls_coopid , :ls_slipno ) using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (70.4)"
		ithw_exception.text	+= "~r~nนำเข้ารายการเคลื่อนไหวปันผล-เฉลี่ยคืน ไม่ได้"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	
	update yrdivmaster
	set div_balamt 	= :ldc_divbal, 
	avg_balamt 		= :ldc_avgbal, 
	etc_balamt		= :ldc_etcbal,
	item_balamt		= :ldc_itembal
	where coop_id= :is_coopcontrol
	and member_no	= :ls_memno
	and div_year		= :ls_divyear
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (70.5)"
		ithw_exception.text	+= "~r~nอัพเดทข้อมูลปันผล-เฉลี่ยคืนคงเหลือ ไม่ได้"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	
	//** hardcode
	
	if ls_methpay = 'DEP' then
		insert into dpdepttran
		( 	coop_id , deptaccount_no , memcoop_id , member_no , system_code , tran_year , tran_date , 
			seq_no , 
			deptitem_amt , tran_status , dividen_amt , average_amt , branch_operate , sequest_status , sequest_amt , ref_slipno , ref_coopid )
		values
		( 	:ls_coopid , :ls_expaccid , :ls_memcoop , :ls_memno , 'DIV' , :li_tranyear , :ldtm_slip , 
			nvl( ( select max( seq_no ) from dpdepttran where coop_id = :ls_coopid and deptaccount_no = :ls_expaccid and coop_id = :ls_memcoop and member_no = :ls_memno and system_code = 'DIV' and tran_year = :li_tranyear and tran_date = :ldtm_oper ) , 0 ) + 1 , 
			:ldc_itempay , 0 , :ldc_divamt , :ldc_avgamt , '000' , 0 , 0 , :ls_slipno , :ls_coopid )
		using itr_sqlca ;
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "~r~nพบขอผิดพลาด (70.6)"
			ithw_exception.text	+= "~r~nผ่านรายการข้อมูลปันผล-เฉลี่ยคืน ไปเงินฝาก ไม่ได้"
			ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
			ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
			ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
			ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
			lb_err = true ; if lb_err then Goto objdestroy
		end if
	end if
	
	if ls_methpay = 'LON' then
//		select coop_id , coop_id , member_no , trans_date , seq_no , transitem_code , realpay_date , shrtype_code , concoop_id , loancontract_no , transpay_type , trans_amt , principal_trnamt , interest_trnamt , sliptype_code , trnsource_code , trnsource_status , moneytype_code , post_status  from sltranspayin ;
		insert into sltranspayin
		( 	coop_id , memcoop_id , member_no , trans_date , seq_no , 
			transitem_code , realpay_date , shrtype_code , concoop_id , loancontract_no ,
			transpay_type , trans_amt , principal_trnamt , interest_trnamt , sliptype_code , trnsource_code , trnsource_refslipno, trnsource_status , moneytype_code , post_status )
		values
		( 	:is_coopcontrol , :is_coopcontrol , :ls_memno , :ldtm_oper , nvl( ( select max( seq_no ) from sltranspayin where coop_id = :ls_coopid and coop_id = :ls_memcoop and member_no = :ls_memno and trans_date = :ldtm_oper ) , 0 ) + 1 ,
			'LON' , :ldtm_slip , :ls_bizztyp , :ls_bizzcoop , :ls_bizzaccno ,
			2 , :ldc_itempay , :ldc_prin , :ldc_int , 'PX' , 'DIV' , :ls_slipno , 8 , 'TRN' , 0 )
		using itr_sqlca ;
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "~r~nพบขอผิดพลาด (70.7)"
			ithw_exception.text	+= "~r~nผ่านรายการข้อมูลปันผล-เฉลี่ยคืน ไปชำระเงินกู้ ไม่ได้"
			ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
			ithw_exception.text	+= "~r~nเลขที่สัญญา : " + ls_bizzaccno
			ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
			ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
			ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
			lb_err = true ; if lb_err then Goto objdestroy
		end if
		
		update lnpreparepay
		set prepare_status = 1 , 
		ref_slipcoop = :is_coopid , 
		ref_slipno = :ls_slipno , 
		entrypay_id = :ls_entryid , 
		entrypay_date = sysdate
		where coop_id = :is_coopcontrol
		and loancontract_no = :ls_bizzaccno
		and prepare_status = 8
		using itr_sqlca;
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "~r~nพบขอผิดพลาด (70.8)"
			ithw_exception.text	+= "~r~nผ่านรายการข้อมูลปันผล-เฉลี่ยคืน ไปชำระเงินกู้ ไม่ได้"
			ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
			ithw_exception.text	+= "~r~nเลขที่สัญญา : " + ls_bizzaccno
			ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
			ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
			ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
			lb_err = true ; if lb_err then Goto objdestroy
		end if
		
	end if
	
	ldc_divamt	= 0
	ldc_avgamt	= 0
	ldc_etcamt	= 0
	ldc_divbal	= 0
	ldc_avgbal	= 0
	ldc_etcbal	= 0
	//** จบ hardcode	
	
	inv_progress.istr_progress.subprogress_text = string( ll_index , "#,##0" ) + "/" + string( ll_count , "#,##0" ) + " เลขสมาชิก : " + ls_memno
	
next

objdestroy:
if isvalid(lds_xmloption) then destroy lds_xmloption
if isvalid(lds_xmllist) then destroy lds_xmllist
if isvalid(lds_slip_main) then destroy lds_slip_main
if isvalid(lds_slip_det) then destroy lds_slip_det

this.of_setsrvdoccontrol( false )
this.of_setsrvdwxmlie( false )

if lb_err then
	rollback using itr_sqlca ;
	ithw_exception.text = "n_cst_divsrv_operate.of_save_slip_grp()" + ithw_exception.text
	throw ithw_exception
else
	commit using itr_sqlca ;
end if

inv_progress.istr_progress.status = 1

return 1
end function

public function integer of_setprogress (ref n_cst_progresscontrol anv_progress) throws Exception;/***********************************************************
<description>
	กำหนด progress bar ที่ใช้แสดงผล
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 28/9/2010 by MiT
</usage> 
***********************************************************/
anv_progress = inv_progress

return 1
end function

public function integer of_init_slip_main (n_ds ads_info_mem, n_ds ads_slip_main) throws Exception;integer li_ifrow , li_rqrow

li_ifrow	= ads_info_mem.rowcount()
li_rqrow	= ads_slip_main.rowcount()

if isnull( li_ifrow ) or li_ifrow < 1 then
	ithw_exception.text	+= "~r~nไม่พบข้อมูลรายละเอียดสมาชิก"
	throw ithw_exception
end if

ads_slip_main.object.coop_id[li_rqrow]				= ads_info_mem.object.coop_id[li_ifrow]
ads_slip_main.object.member_no[li_rqrow]			= ads_info_mem.object.member_no[li_ifrow]
ads_slip_main.object.membtype_code[li_rqrow]	= ads_info_mem.object.membtype_code[li_ifrow]
ads_slip_main.object.membtype_desc[li_rqrow]	= ads_info_mem.object.membtype_desc[li_ifrow]
ads_slip_main.object.membgroup_code[li_rqrow]	= ads_info_mem.object.membgroup_code[li_ifrow]
ads_slip_main.object.membgroup_desc[li_rqrow]	= ads_info_mem.object.membgroup_desc[li_ifrow]
ads_slip_main.object.prename_desc[li_rqrow]		= ads_info_mem.object.prename_desc[li_ifrow]
//ads_slip_main.object.prename_edesc[li_rqrow]	= ads_info_mem.object.prename_edesc[li_ifrow]
ads_slip_main.object.memb_name[li_rqrow]		= ads_info_mem.object.memb_name[li_ifrow]
ads_slip_main.object.memb_surname[li_rqrow]	= ads_info_mem.object.memb_surname[li_ifrow]
ads_slip_main.object.memb_ename[li_rqrow]		= ads_info_mem.object.memb_ename[li_ifrow]
ads_slip_main.object.memb_esurname[li_rqrow]	= ads_info_mem.object.memb_esurname[li_ifrow]
ads_slip_main.object.resign_status[li_rqrow]		= ads_info_mem.object.resign_status[li_ifrow]
ads_slip_main.object.resign_date[li_rqrow]			= ads_info_mem.object.resign_date[li_ifrow]
ads_slip_main.object.member_status[li_rqrow]	= ads_info_mem.object.member_status[li_ifrow]
ads_slip_main.object.member_date[li_rqrow]		= ads_info_mem.object.member_date[li_ifrow]
ads_slip_main.object.div_balamt[li_rqrow]			= ads_info_mem.object.div_balamt[li_ifrow]
ads_slip_main.object.avg_balamt[li_rqrow]			= ads_info_mem.object.avg_balamt[li_ifrow]
ads_slip_main.object.etc_balamt[li_rqrow]			= ads_info_mem.object.etc_balamt[li_ifrow]
ads_slip_main.object.slip_status[1]					= 1


return 1
end function

public function integer of_init_slip_detail (n_ds ads_slip_main, n_ds ads_slip_detail) throws Exception;string ls_methpay, ls_money, ls_tofromaccid, ls_methdesc
string ls_expbank, ls_expbranch, ls_expaccid, ls_expbanktyp
string ls_divyear, ls_coopid, ls_memno
integer li_drow, li_seqno, li_sequest, li_row
dec{2}ldc_expamt, ldc_div, ldc_avg, ldc_etc, ldc_sequest
n_ds lds_info_mem
long ll_count

ls_divyear = ads_slip_main.object.div_year[1]
ls_coopid = ads_slip_main.object.coop_id[1]
ls_memno = ads_slip_main.object.member_no[1]

ads_slip_detail.reset()

lds_info_mem = create n_ds
lds_info_mem.dataobject = "d_divsrv_yrdivmethpay"
lds_info_mem.settransobject( itr_sqlca )

ll_count = lds_info_mem.Retrieve(ls_coopid,ls_memno,ls_divyear)







for li_row = 0 to ll_count
	
	li_seqno = lds_info_mem.GetItemDecimal(li_row,"seqno")
	ls_methpay = lds_info_mem.GetItemString(li_row,"methpaytype_code")	
	ls_money = lds_info_mem.GetItemString(li_row,"moneytype_code")	
	ls_expbank = lds_info_mem.GetItemString(li_row,"expense_bank")
	ls_expbranch = lds_info_mem.GetItemString(li_row,"expense_branch")
	ls_expaccid = lds_info_mem.GetItemString(li_row,"expense_accid")
	ldc_div = lds_info_mem.GetItemDecimal(li_row,"div_payment")
	ldc_avg = lds_info_mem.GetItemDecimal(li_row,"avg_payment")
	ldc_etc = lds_info_mem.GetItemDecimal(li_row,"etc_payment")
	ldc_expamt = lds_info_mem.GetItemDecimal(li_row,"item_payment")
	li_sequest = lds_info_mem.GetItemDecimal(li_row,"sequest_flag")
	ldc_sequest = lds_info_mem.GetItemDecimal(li_row,"sequest_amt")
	ls_expbanktyp = lds_info_mem.GetItemString(li_row,"expense_bank_typ")
	
    
	
	


	
	
	//ads_slip_detail.object.div_payment[li_drow] = ldc_div
	//ads_slip_detail.object.avg_payment[li_drow] = ldc_avg
	//ads_slip_detail.object.etc_payment[li_drow] = ldc_etc
	//ads_slip_detail.object.fee_amt[li_drow] = 0
	//ads_slip_detail.object.item_payment[li_drow] = ldc_expamt
	//ads_slip_detail.object.sequest_flag[li_drow] = li_sequest
	//ads_slip_detail.object.sequest_amt[li_drow] = ldc_sequest
	//ads_slip_detail.object.expense_bank_typ[li_drow] = ls_expbanktyp
	
	//ads_slip_detail.SetItem(li_drow,"methpaytype_desc",ls_methdesc)
		
	// default ค่า tofrom_accid
	if ls_money = "CSH" or ls_money = "CBT" or ls_money = "CHQ" then
		select min(account_id)
		into :ls_tofromaccid
		from cmucftofromaccid
		where applgroup_code = 'SLN'
		and sliptype_code = 'LWD'
		and moneytype_code = :ls_money
		using itr_sqlca;
		
		if trim(ls_tofromaccid) <> "" and not IsNull(ls_tofromaccid) then
			ads_slip_detail.SetItem(li_drow, "tofrom_accid", ls_tofromaccid)
		end if
	end if

	
next


ldc_expamt = dec(ads_slip_detail. describe ("evaluate( 'sum( item_payment for all )', " + string(ads_slip_detail.rowcount())+" )"))
ads_slip_main.object.payout_payment[1] = ldc_expamt

return 1
end function

public function integer of_init_slip_ccl_main (n_ds ads_info_mem, n_ds ads_slip_main) throws Exception;integer li_ifrow , li_rqrow

li_ifrow	= ads_info_mem.rowcount()
li_rqrow	= ads_slip_main.rowcount()

if isnull( li_ifrow ) or li_ifrow < 1 then
	ithw_exception.text	+= "~r~nไม่พบข้อมูลรายละเอียดสมาชิก"
	throw ithw_exception
end if

ads_slip_main.object.coop_id[li_rqrow]			= ads_info_mem.object.coop_id[li_ifrow]
ads_slip_main.object.member_no[li_rqrow]			= ads_info_mem.object.member_no[li_ifrow]
ads_slip_main.object.membtype_code[li_rqrow]	= ads_info_mem.object.membtype_code[li_ifrow]
ads_slip_main.object.membtype_desc[li_rqrow]	= ads_info_mem.object.membtype_desc[li_ifrow]
ads_slip_main.object.membgroup_code[li_rqrow]	= ads_info_mem.object.membgroup_code[li_ifrow]
ads_slip_main.object.membgroup_desc[li_rqrow]	= ads_info_mem.object.membgroup_desc[li_ifrow]
ads_slip_main.object.prename_desc[li_rqrow]		= ads_info_mem.object.prename_desc[li_ifrow]
//ads_slip_main.object.prename_edesc[li_rqrow]	= ads_info_mem.object.prename_edesc[li_ifrow]
ads_slip_main.object.memb_name[li_rqrow]		= ads_info_mem.object.memb_name[li_ifrow]
ads_slip_main.object.memb_ename[li_rqrow]		= ads_info_mem.object.memb_ename[li_ifrow]
ads_slip_main.object.resign_status[li_rqrow]		= ads_info_mem.object.resign_status[li_ifrow]
ads_slip_main.object.resign_date[li_rqrow]			= ads_info_mem.object.resign_date[li_ifrow]
ads_slip_main.object.member_status[li_rqrow]	= ads_info_mem.object.member_status[li_ifrow]
ads_slip_main.object.member_date[li_rqrow]		= ads_info_mem.object.member_date[li_ifrow]
//ads_slip_main.object.div_balamt[li_rqrow]			= ads_info_mem.object.div_balamt[li_ifrow]
//ads_slip_main.object.avg_balamt[li_rqrow]			= ads_info_mem.object.avg_balamt[li_ifrow]
//ads_slip_main.object.etc_balamt[li_rqrow]			= ads_info_mem.object.etc_balamt[li_ifrow]
//ads_slip_main.object.slip_status[1]					= 1

return 1
end function

public function integer of_chk_slip_ccl (string as_branchid, string as_slipno) throws Exception;integer li_chk

select count( payoutslip_no )
into :li_chk
from yrslippayout
where coop_id = :as_branchid
and payoutslip_no = :as_slipno
and finpost_status = 1
using itr_sqlca;

if itr_sqlca.sqlcode <> 0 or isnull( li_chk ) then li_chk = 0

if li_chk > 0 then 
	ithw_exception.text += "~r~nไม่สามารถทำรายการได้เนื่องจากระบบการเงินผ่านรายการจ่ายไปเรียบร้อยแล้ว"
	ithw_exception.text += "~r~nเลขที่ใบทำรายการ : " + as_slipno
	throw ithw_exception
end if

return 1
end function

public function integer of_tran_slip_ccl (str_divsrv_tran astr_tran) throws Exception;string ls_msgerr , ls_refcoop , ls_refslipno
string ls_entrycoop , ls_entryid
boolean lb_err = false
n_ds	lds_slip_main , lds_slip_detail

ls_refcoop			= astr_tran.as_refslipcoop
ls_refslipno			= astr_tran.as_refslipno
ls_entrycoop		= astr_tran.as_entrycoop
ls_entryid			= astr_tran.as_entryid

ls_msgerr	= ''
if isnull(ls_refcoop) then ls_msgerr += '~r~nสาขาสหกรณ์ของใบทำรายการ ( as_refslipbranch ) '
if isnull(ls_refslipno) then ls_msgerr += '~r~nเลขที่ใบทำรายการ ( as_refslipno ) '
if isnull(ls_entrycoop) then ls_msgerr += '~r~nสาขาสหกรณ์ที่ผู้ทำรายการทำรายการ ( as_entrybranch ) '
if isnull(ls_entryid) then ls_msgerr += '~r~nรหัสผู้ทำรายการ ( as_entryid ) '

if len( ls_msgerr ) > 0 then
	ithw_exception.text += "~r~nพบข้อผิดพลาดกรุณาตรวจสอบ( 0.01)"
	ithw_exception.text += ls_msgerr
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

lds_slip_main = create n_ds
lds_slip_main.dataobject = "d_divsrv_opr_main"
lds_slip_main.settransobject( itr_sqlca )

lds_slip_detail = create n_ds
lds_slip_detail.dataobject = "d_divsrv_opr_detail"
lds_slip_detail.settransobject( itr_sqlca )

if lds_slip_main.retrieve( ls_refcoop , ls_refslipno ) > 0 then
	lds_slip_main.object.cancel_id[1]	= ls_entryid
	if lds_slip_detail.retrieve( ls_refcoop , ls_refslipno ) > 0 then
		// ผ่านรายการยกเลิก
		try
			this.of_post_slip_ccl( lds_slip_main , lds_slip_detail )
		catch( Exception lthw_postslipccl )
			ithw_exception.text	+= lthw_postslipccl.text
			lb_err = true
		end try
		if lb_err then Goto objdestroy
	else
		ithw_exception.text += "~r~nพบขอผิดพลาดในการดึงข้อมูลใบทำรายการยกเลิกส่วนรายละเอียด(0.52)"
		ithw_exception.text += "~r~nกรุณาตรวจสอบ"
		lb_err = true ; Goto objdestroy
	end if
else
	ithw_exception.text += "~r~nพบขอผิดพลาดในการดึงข้อมูลใบทำรายการยกเลิกหัวใบเสร็จ(0.51)"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

objdestroy:
if isvalid(lds_slip_main) then destroy lds_slip_main
if isvalid(lds_slip_detail) then destroy lds_slip_detail

if lb_err then
	ithw_exception.text = "n_cst_divsrv_operate.of_tran_slip_ccl()" + ithw_exception.text
	throw ithw_exception
end if

return 1
end function

public function integer of_post_slip_ccl (n_ds ads_slip, n_ds ads_slipdet) throws Exception;string ls_memcoop , ls_memno , ls_divyear
string ls_coopid , ls_slipno , ls_methpay , ls_rdivitem
string ls_entry
integer li_subindex , li_subcount
integer li_seqno , li_rdivsign , li_shseqno
dec{2} ldc_divamt , ldc_avgamt , ldc_etcamt , ldc_itempay
dec{2} ldc_divbal , ldc_avgbal , ldc_etcbal , ldc_expbal , ldc_itembal
dec{2} ldc_expamt
datetime ldtm_oper , ldtm_slip , ldtm_entry
boolean lb_err

ls_memcoop		= ads_slip.object.coop_id[1]
ls_memno			= ads_slip.object.member_no[1]
ls_divyear			= ads_slip.object.div_year[1]
ls_entry				= ads_slip.object.cancel_id[1]
ldtm_oper 			= ads_slip.object.operate_date[1]
ldtm_slip				= ads_slip.object.slip_date[1]

ldtm_entry			= datetime( today() , now() )

li_subcount			= ads_slipdet.rowcount()

for li_subindex = 1 to li_subcount
	
	ls_coopid		= ads_slipdet.object.coop_id[li_subindex]
	ls_slipno			= ads_slipdet.object.payoutslip_no[li_subindex]
	ls_methpay		= ads_slipdet.object.methpaytype_code[li_subindex]
	ldc_divamt		= ads_slipdet.object.div_payment[li_subindex]
	ldc_avgamt		= ads_slipdet.object.avg_payment[li_subindex]
	ldc_etcamt		= ads_slipdet.object.etc_payment[li_subindex]
	ldc_expamt		= ads_slipdet.object.item_payment[li_subindex]

	//** ค้างเฉลี่ยการตัดจ่ายยอดปันผล เฉลี่ยคืน ปันผลค้างจ่าย
	//** hard code
	select yd.divitemtype_code , yd.sign_flag 
	into :ls_rdivitem , :li_rdivsign
	from yrucfmethpay yum , yrucfdivitemtype yud , yrucfdivitemtype yd
	where yum.methpaystm_itemtype = yud.divitemtype_code
	and yud.reverse_itemtype = yd.divitemtype_code
	and yum.methpaytype_code = :ls_methpay
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (60.0)"
		ithw_exception.text	+= "~r~nไม่พบข้อมูลทำรายการ ไม่ได้"
		ithw_exception.text	+= "~r~nประเภทรายการ : " + ls_methpay
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	
	select div_balamt , avg_balamt , etc_balamt
	into :ldc_divbal , :ldc_avgbal , :ldc_etcbal
	from yrdivmaster
	where coop_id= :ls_memcoop
	and member_no	= :ls_memno
	and div_year		= :ls_divyear
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (60.1)"
		ithw_exception.text	+= "~r~nไม่พบข้อมูลปันผล ไม่ได้"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	ldc_expbal		= ldc_expamt
	
	ldc_divbal		= ldc_divbal + ( li_rdivsign * ldc_divamt )
	ldc_avgbal		= ldc_avgbal + ( li_rdivsign * ldc_avgamt )
	ldc_etcbal		= ldc_etcbal + ( li_rdivsign * ldc_etcamt )
			
	ldc_itempay	= ldc_divamt + ldc_avgamt + ldc_etcamt
	ldc_itembal	= ldc_divbal + ldc_avgbal + ldc_etcbal
	//** จบ hard code
	
	select max( ds.seq_no ) 
	into :li_shseqno
	from yrdivstatement ds 
	where ds.coop_id = :ls_memcoop
	and ds.member_no = :ls_memno
	and ds.div_year = :ls_divyear
	using itr_sqlca ;
	if itr_sqlca.sqlcode <> 0 or isnull( li_shseqno ) then li_shseqno = 0
	li_shseqno++
	
	insert into yrdivstatement
	( coop_id , member_no , div_year , seq_no , operate_date , slip_date , divitemtype_code , 
	div_payment , avg_payment , etc_payment , item_payment , item_balamt ,  
	item_status , entry_id , entry_date , ref_slipcoop , ref_slipno )
	values
	( :ls_memcoop , :ls_memno , :ls_divyear , :li_shseqno , :ldtm_oper , :ldtm_slip , :ls_rdivitem ,
	:ldc_divamt , :ldc_avgamt , :ldc_etcamt , :ldc_itempay , :ldc_itembal ,
	-9 , :ls_entry , :ldtm_entry	, :ls_coopid , :ls_slipno ) using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (70.1)"
		ithw_exception.text	+= "~r~nนำเข้าข้อมูลยกเลิกรายการเคลื่อนไหวปันผล-เฉลี่ยคืน ไม่ได้"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	
	update yrdivstatement
	set item_status = -9
	where ref_slipcoop = :ls_coopid  
	and ref_slipno = :ls_slipno
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (70.2)"
		ithw_exception.text	+= "~r~nอัพเดทสถานะยกเลิกคู่รายการเคลื่อนไหวปันผล-เฉลี่ยคืน ไม่ได้"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	
	update yrdivmaster
	set div_balamt 	= :ldc_divbal, 
	avg_balamt 		= :ldc_avgbal, 
	etc_balamt		= :ldc_etcbal,
	item_balamt		= :ldc_itembal
	where coop_id	= :ls_memcoop
	and member_no	= :ls_memno
	and div_year		= :ls_divyear
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (70.3)"
		ithw_exception.text	+= "~r~nอัพเดทข้อมูลปันผล-เฉลี่ยคืนคงเหลือ ไม่ได้"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	
	//** hardcode
	ldc_divamt	= 0
	ldc_avgamt	= 0
	ldc_etcamt	= 0
	ldc_divbal	= 0
	ldc_avgbal	= 0
	ldc_etcbal	= 0
	//** จบ hardcode	
	
next

update yrslippayout
set slip_status = -9 ,
finpost_status = -9 ,
cancel_id = :ls_entry ,
cancel_date = :ldtm_entry
where coop_id = :ls_coopid
and payoutslip_no = :ls_slipno
using itr_sqlca;
if itr_sqlca.sqlcode <> 0 then
	ithw_exception.text	= "~r~nพบขอผิดพลาด (70.4)"
	ithw_exception.text	+= "~r~nอัพเดทสถานะใบทำรายการยกเลิกปันผล-เฉลี่ยคืนคงเหลือ ไม่ได้"
	ithw_exception.text	+= "~r~nเลขที่ใบทำรายการ : " + ls_slipno
	ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
	ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
	ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
	lb_err = true ; if lb_err then Goto objdestroy
end if

update yrdivmethpay
set methpay_status = 0 ,
ref_slipcoop = '',
ref_slipno = ''
where ref_slipcoop = :ls_coopid
and ref_slipno = :ls_slipno
using itr_sqlca;
if itr_sqlca.sqlcode <> 0 then
	ithw_exception.text	= "~r~nพบขอผิดพลาด (70.5)"
	ithw_exception.text	+= "~r~nอัพเดทสถานะผ่านรายการจ่ายปันผล-เฉลี่ยคืน ไม่ได้"
	ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
	ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
	ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
	ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
	lb_err = true ; if lb_err then Goto objdestroy
end if

objdestroy:

if lb_err then
	ithw_exception.text = "n_cst_divsrv_operate.of_post_slip_ccl()" + ithw_exception.text
	throw ithw_exception
end if

return 1
end function

public function integer of_tran_slip (str_divsrv_tran astr_tran) throws Exception;string ls_msgerr , ls_refcoop , ls_refslipno
string ls_entrycoop , ls_entryid
string ls_chqbank , ls_chqbranch , ls_chqno
datetime ldtm_chq , ldtm_entry
boolean lb_err = false

ls_refcoop			= astr_tran.as_refslipcoop
ls_refslipno			= astr_tran.as_refslipno
ls_entrycoop		= astr_tran.as_entrycoop
ls_entryid			= astr_tran.as_entryid
ls_chqbank			= astr_tran.as_chqbank
ls_chqbranch		= astr_tran.as_chqbranch
ls_chqno				= astr_tran.as_chqno
ldtm_chq				= astr_tran.adtm_chq

ls_msgerr	= ''
if isnull(ls_refcoop) then ls_msgerr += '~r~nสาขาสหกรณ์ของใบทำรายการ ( as_refslipbranch ) '
if isnull(ls_refslipno) then ls_msgerr += '~r~nเลขที่ใบทำรายการ ( as_refslipno ) '
if isnull(ls_entrycoop) then ls_msgerr += '~r~nสาขาสหกรณ์ที่ผู้ทำรายการทำรายการ ( as_entrybranch ) '
if isnull(ls_entryid) then ls_msgerr += '~r~nรหัสผู้ทำรายการ ( as_entryid ) '
if isnull(ls_chqbank) then ls_chqbank += ''
if isnull(ls_chqbranch) then ls_chqbranch += ''
if isnull(ls_chqno) then ls_chqno += ''
if isnull(ldtm_chq) then setnull( ldtm_chq )

if len( ls_msgerr ) > 0 then
	ithw_exception.text += "~r~nพบข้อผิดพลาด( 0.01 )"
	ithw_exception.text += ls_msgerr
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

//update yrslippayout ผ่านรายการการเงิน
update 	yrslippayout
set 		finpost_status 			= 1, 
			finpost_bycoopid 	= :ls_entrycoop, 
			finpost_id 				= :ls_entryid, 
			finpost_date			= sysdate
where	coop_id			= :ls_refcoop
and		payoutslip_no			= :ls_refslipno
using itr_sqlca;
if itr_sqlca.sqlcode <> 0 then
	ithw_exception.text += "~r~nพบข้อผิดพลาด ไม่สามารถอัพเดทสถานะผ่านรายการจากระบบการเงินได้( 70.01 )"
	ithw_exception.text += "~r~nสาขาใบเสร็จที่ทำรายการ/เลขที่ใบทำรายการ : " + ls_refcoop + " / " + ls_refslipno
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

//update yrslippayoutdet ผ่านรายการ cheque
if len( ls_chqno ) > 0 then
	update 	yrslippayoutdet
	set 		cheque_bank 			= :ls_chqbank, 
				cheque_branch 		= :ls_chqbranch, 
				cheque_no 				= :ls_chqno, 
				cheque_date			= :ldtm_chq
	where	coop_id			= :ls_refcoop
	and		payoutslip_no			= :ls_refslipno
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text += "~r~nพบข้อผิดพลาด ไม่สามารถอัพเดทสถานะผ่านรายการเช็คจากระบบการเงินได้( 70.02 )"
		ithw_exception.text += "~r~nสาขาใบเสร็จที่ทำรายการ/เลขที่ใบทำรายการ : " + ls_refcoop + " / " + ls_refslipno
		ithw_exception.text += "~r~nกรุณาตรวจสอบ"
		lb_err = true ; Goto objdestroy
	end if
end if

objdestroy:

if lb_err then
	ithw_exception.text = "n_cst_divsrv_operate.of_tran_slip()" + ithw_exception.text
	throw ithw_exception
end if

return 1
end function

protected function integer of_setsrvdoccontrol (boolean ab_switch);// Check argument
if isnull( ab_switch ) then
	return -1
end if

if ab_switch then
	if isnull( inv_docsrv ) or not isvalid( inv_docsrv ) then
		inv_docsrv	= create n_cst_doccontrolservice
		inv_docsrv.of_settrans( inv_transection )
		return 1
	end if
else
	if isvalid( inv_docsrv ) then
		destroy inv_docsrv
		return 1
	end if
end if

return 0
end function

protected function integer of_setsrvdwxmlie (boolean ab_switch);// Check argument
if isnull( ab_switch ) then
	return -1
end if

if ab_switch then
	if isnull( inv_dwxmliesrv ) or not isvalid( inv_dwxmliesrv ) then
		inv_dwxmliesrv	= create n_cst_dwxmlieservice
		return 1
	end if
else
	if isvalid( inv_dwxmliesrv ) then
		destroy inv_dwxmliesrv
		return 1
	end if
end if

return 0
end function

protected function integer of_setsrvproc (boolean ab_switch);// Check argument
if isnull( ab_switch ) then
	return -1
end if

if ab_switch then
	if isnull( inv_procsrv ) or not isvalid( inv_procsrv ) then
		inv_procsrv	= create n_cst_procservice
		inv_procsrv.of_initservice()
		return 1
	end if
else
	if isvalid( inv_procsrv ) then
		destroy inv_procsrv
		return 1
	end if
end if

return 0
end function

public function integer of_save_slip_cls (ref str_divsrv_oper astr_divavg_oper) throws Exception;string ls_xmloption , ls_sql
string ls_divyear , ls_chgmethpay , ls_chgmoneytype
string ls_memno , ls_methpay , ls_moneytype
string ls_expbank , ls_expbranch , ls_expaccid
string ls_bizzcoop , ls_bizztype , ls_bizzacc
string ls_slipno , ls_entryid
string ls_divitem
integer li_seq , li_sequest , li_divsign
integer li_mrow , li_drow , li_shseqno , li_tranyear
long ll_index , ll_count
dec{2} ldc_div , ldc_avg , ldc_etc , ldc_expense , ldc_sequest
dec{2} ldc_divbal , ldc_avgbal , ldc_etcbal , ldc_expbal
dec{2} ldc_prin , ldc_int , ldc_itempay , ldc_itembal
datetime ldtm_oper , ldtm_slip , ldtm_entry
boolean lb_err = false
n_ds lds_xmloption , lds_list
n_ds lds_slip_main , lds_slip_detail

this.of_setsrvdwxmlie( true )
this.of_setsrvdoccontrol( true )
this.of_setsrvdw(true)

inv_progress.istr_progress.progress_text = "ประมวลจ่ายเงินปันผล-เฉลี่ยคืน"
inv_progress.istr_progress.progress_index = 0
inv_progress.istr_progress.progress_max = 1
inv_progress.istr_progress.subprogress_text = "เตรียมข้อมูล"
inv_progress.istr_progress.subprogress_index = 0
inv_progress.istr_progress.subprogress_max = 1
inv_progress.istr_progress.status = 8

lds_xmloption = create n_ds
lds_xmloption.dataobject = "d_divsrv_opr_close_option"
lds_xmloption.settransobject( itr_sqlca )

lds_slip_main = create n_ds
lds_slip_main.dataobject = "d_divsrv_opr_main"
lds_slip_main.settransobject( itr_sqlca )

lds_slip_detail = create n_ds
lds_slip_detail.dataobject = "d_divsrv_opr_detail"
lds_slip_detail.settransobject( itr_sqlca )

lds_list = create n_ds
lds_list.settransobject( itr_sqlca )

ls_xmloption		= astr_divavg_oper.xml_option

//** เฉพาะกิจทำไปก่อน
//lds_xmloption.importstring( XML!, ls_xmloption )
if inv_dwxmliesrv.of_xmlimport( lds_xmloption , ls_xmloption ) < 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาด ในการนำเข้าข้อมูล(0.1)"
	ithw_exception.text += "~r~nเงื่อนไขการปิดยอดจ่ายเงินปันผล-เฉลี่ยคืน"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

ls_divyear		= lds_xmloption.object.div_year[1]
ls_entryid		= lds_xmloption.object.entry_id[1]
ldtm_oper		= lds_xmloption.object.operate_date[1]
ldtm_slip			= lds_xmloption.object.operate_date[1] /*ใช้วันเดียวกับ oper_date*/

li_tranyear		= integer( left( trim( ls_divyear ) , 4 ) )

/*
ดึงค่า วิธีชำระจ่ายปันผลปีถัดไป
*/
select methpaytype_code , join_moneytype_code
into :ls_chgmethpay , :ls_chgmoneytype
from(
	select methpaytype_code , join_moneytype_code , rownum
	from yrucfmethpay
	where coop_id = :is_coopcontrol
	and paynxtdiv_flag = 1
	order by methpaytype_sort 
)
where rownum = 1
using itr_sqlca;
if isnull( ls_chgmethpay ) then ls_chgmethpay = ""
if itr_sqlca.sqlcode <> 0 or ls_chgmethpay = "" then
	ithw_exception.text = "~r~nพบขอผิดพลาด ดึงข้อมูลวิธีจ่ายปันผลปีถัดไป(0.2)"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

/*
อัพเดทวิธีชำระพวกที่ไม่ได้ทำรายการเป็นวิธีจ่ายปันผลปีถัดไป
*/
update yrdivmethpay
set methpaytype_code = :ls_chgmethpay ,
moneytype_code = :ls_chgmoneytype
where coop_id = :is_coopcontrol
and methpay_status = 0
using itr_sqlca;
if itr_sqlca.sqlcode <> 0 then
	ithw_exception.text = "~r~nพบขอผิดพลาด อัพเดทข้อมูลวิธีจ่ายปันผลปีถัดไป(70.1)"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

/*
ผ่านรายการจ่ายปันผล
*/
ls_sql		= " select coop_id , member_no , seq_no , div_year , "
ls_sql		+= " nvl( methpaytype_code , '' ) as methpaytype_code , nvl( moneytype_code , '' ) as moneytype_code , "
ls_sql		+= " nvl( expense_bank , '' ) as expense_bank , nvl( expense_branch , '' ) as expense_branch , nvl( expense_accid , '' ) as expense_accid , "
ls_sql		+= " nvl( bizzcoop_id , '' ) as bizzcoop_id , nvl( bizztype_code , '' ) as bizztype_code , nvl( bizzaccount_no , '' ) as bizzaccount_no , "
ls_sql		+= " nvl( div_amt , 0 ) as div_amt , nvl( avg_amt , 0 ) as avg_amt , nvl( etc_amt , 0 ) as etc_amt , nvl( expense_amt , 0 ) as expense_amt , "
ls_sql		+= " nvl( sequest_flag , 0 ) as sequest_flag , nvl( sequest_amt , 0 ) as sequest_amt , nvl( prin_amt , 0 ) as prin_amt , nvl( int_amt , 0 ) as int_amt "
ls_sql		+= " from yrdivmethpay "
ls_sql		+= " where coop_id = '" + is_coopcontrol + "' "
ls_sql		+= " and div_year = '" + ls_divyear + "' "
ls_sql		+= " and methpay_status = 0 "

inv_dwsrv.of_create_dw( lds_list , ls_sql , '' )
lds_list.settransobject( itr_sqlca )
ll_count	= lds_list.retrieve()

for ll_index = 1 to ll_count
	
	// ตรวจสอบการสั่งหยุดทำงาน
	yield()
	if inv_progress.of_is_stop() then
		ithw_exception.text = "~r~nหยุดการทำงานโดยผู้ใช้(50.1)"
		ithw_exception.text += "~r~nกรุณาตรวจสอบ"
		lb_err = true ; Goto objdestroy
	end if
	
	ls_memno		= lds_list.object.member_no[ll_index]
	ls_methpay		= lds_list.object.methpaytype_code[ll_index]
	ls_moneytype	= lds_list.object.moneytype_code[ll_index]
	ls_expbank		= lds_list.object.expense_bank[ll_index]
	ls_expbranch	= lds_list.object.expense_branch[ll_index]
	ls_expaccid		= lds_list.object.expense_accid[ll_index]
	ls_bizzcoop		= lds_list.object.bizzcoop_id[ll_index]
	ls_bizztype		= lds_list.object.bizztype_code[ll_index]
	ls_bizzacc		= lds_list.object.bizzaccount_no[ll_index]
	li_seq				= lds_list.object.seq_no[ll_index]
	li_sequest		= lds_list.object.sequest_flag[ll_index]
	ldc_div			= lds_list.object.div_amt[ll_index]
	ldc_avg			= lds_list.object.avg_amt[ll_index]
	ldc_etc			= lds_list.object.etc_amt[ll_index]
	ldc_expense		= lds_list.object.expense_amt[ll_index]
	ldc_sequest		= lds_list.object.sequest_amt[ll_index]
	ldc_prin			= lds_list.object.prin_amt[ll_index]
	ldc_int			= lds_list.object.int_amt[ll_index]
	
	ldtm_entry		= datetime( today() , now() )
	
	lds_slip_main.reset()
	lds_slip_detail.reset()
	
	li_mrow	= lds_slip_main.insertrow(0)
	li_drow	= lds_slip_detail.insertrow(0)
	
	try
		ls_slipno	= inv_docsrv.of_getnewdocno( is_coopid , "YRSLIPPAYOUT")	// get เลขที่เอกสาร
	catch( Exception lthw_getreqdoc )
		ithw_exception.text	= "~r~nพบขอผิดพลาด (20.1)" + lthw_getreqdoc.text
		lb_err = true
	end try
	if lb_err then Goto objdestroy
	
	lds_slip_main.object.coop_id[li_mrow]				= is_coopid
	lds_slip_main.object.div_year[li_mrow]				= ls_divyear
	lds_slip_main.object.payoutslip_no[li_mrow]		= ls_slipno
	lds_slip_main.object.coop_id[li_mrow]				= is_coopcontrol
	lds_slip_main.object.member_no[li_mrow]			= ls_memno
	lds_slip_main.object.operate_date[li_mrow]		= ldtm_oper
	lds_slip_main.object.slip_date[li_mrow]				= ldtm_slip
	lds_slip_main.object.payout_payment[li_mrow]	= ldc_expense
	lds_slip_main.object.slip_status[li_mrow]			= 1
	lds_slip_main.object.entry_id[li_mrow]				= ls_entryid
	lds_slip_main.object.entry_date[li_mrow]			= ldtm_entry
	
	//** ค้างเฉลี่ยการตัดจ่ายยอดปันผล เฉลี่ยคืน ปันผลค้างจ่าย
	//** hard code
	select yud.divitemtype_code , yud.sign_flag 
	into :ls_divitem , :li_divsign
	from yrucfmethpay yum , yrucfdivitemtype yud
	where yum.coop_id = yud.coop_id
	and yum.methpaystm_itemtype = yud.divitemtype_code
	and yum.coop_id = :is_coopcontrol
	and yum.methpaytype_code = :ls_methpay
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (60.0)"
		ithw_exception.text	+= "~r~nไม่พบข้อมูลทำรายการ ไม่ได้"
		ithw_exception.text	+= "~r~nประเภทรายการ : " + ls_methpay
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
		
	select div_balamt , avg_balamt , etc_balamt
	into :ldc_divbal , :ldc_avgbal , :ldc_etcbal
	from yrdivmaster
	where coop_id		= :is_coopcontrol
	and member_no	= :ls_memno
	and div_year		= :ls_divyear
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (60.1)"
		ithw_exception.text	+= "~r~nไม่พบข้อมูลปันผล ไม่ได้"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	ldc_expbal		= ldc_expense
	
	if ldc_divbal + ldc_avgbal + ldc_etcbal <= 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (60.2)"
		ithw_exception.text	+= "~r~nเงินปันผล-เฉลี่ยคืน ไม่พอจ่าย"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~nยอดปันผล-เฉลี่ยคืนคงเหลือ : " + string( ldc_divbal + ldc_avgbal + ldc_etcbal , "#,###,##0.00" ) + " บาท"
		ithw_exception.text	+= "~r~nยอดทำรายการ : " + string( ldc_expense , "#,###,##0.00" ) + " บาท"
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	
	ldc_divbal		= ldc_divbal + ( li_divsign * ldc_div )
	ldc_avgbal		= ldc_avgbal + ( li_divsign * ldc_avg )
	ldc_etcbal		= ldc_etcbal + ( li_divsign * ldc_etc )
	
	ldc_itempay	= ldc_div + ldc_avg + ldc_etc
	ldc_itembal	= ldc_divbal + ldc_avgbal + ldc_etcbal
	//** จบ hard code
	
	lds_slip_detail.object.coop_id[li_drow]					= is_coopid
	lds_slip_detail.object.payoutslip_no[li_drow]			= ls_slipno
	lds_slip_detail.object.seq_no[li_drow]					= 1
	lds_slip_detail.object.methpaytype_code[li_drow]		= ls_methpay
	lds_slip_detail.object.moneytype_code[li_drow]		= ls_moneytype	
	lds_slip_detail.object.tofrom_accid[li_drow]			= ""	
	lds_slip_detail.object.expense_bank[li_drow]			= ls_expbank
	lds_slip_detail.object.expense_branch[li_drow]		= ls_expbranch
	lds_slip_detail.object.expense_accid[li_drow]			= ls_expaccid
	lds_slip_detail.object.expense_bank_typ[li_drow]		= ""
	lds_slip_detail.object.div_payment[li_drow]			= ldc_div
	lds_slip_detail.object.avg_payment[li_drow]			= ldc_avg
	lds_slip_detail.object.etc_payment[li_drow]			= ldc_etc
	lds_slip_detail.object.fee_amt[li_drow]					= 0
	lds_slip_detail.object.item_payment[li_drow]			= ldc_expense
	lds_slip_detail.object.sequest_flag[li_drow]			= li_sequest
	lds_slip_detail.object.sequest_amt[li_drow]			= ldc_sequest
	lds_slip_detail.object.bizzcoop_id[li_drow]				= ls_bizzcoop
	lds_slip_detail.object.bizztype_code[li_drow]			= ls_bizztype
	lds_slip_detail.object.bizzaccount_no[li_drow]			= ls_bizzacc
	lds_slip_detail.object.prin_payment[li_drow]			= ldc_prin
	lds_slip_detail.object.int_payment[li_drow]				= ldc_int
	
	// บันทึก Main
	if lds_slip_main.update() <> 1 then
		ithw_exception.text	= "~r~nบันทึกข้อมูลจ่ายเงินปันผลเฉลี่ยคืน (Main) ไม่ได้ (70.1)"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + lds_slip_main.of_geterrormessage()
		ithw_exception.text	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; Goto objdestroy
	end if

	// บันทึก Detail
	if lds_slip_detail.update() <> 1 then
		ithw_exception.text	= "~r~nบันทึกข้อมูลจ่ายเงินปันผลเฉลี่ยคืน (Detail) ไม่ได้ (70.2)"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + lds_slip_detail.of_geterrormessage()
		ithw_exception.text	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; Goto objdestroy
	end if

	update yrdivmethpay
	set methpay_status = 1 ,
	ref_slipcoop = :is_coopid,
	ref_slipno = :ls_slipno
	where coop_id = :is_coopcontrol
	and member_no = :ls_memno
	and seq_no = :li_seq
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (70.3)"
		ithw_exception.text	+= "~r~nอัพเดทสถานะผ่านรายการจ่ายปันผล-เฉลี่ยคืน ไม่ได้"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	
	select max( ds.seq_no ) 
	into :li_shseqno
	from yrdivstatement ds 
	where ds.coop_id = :is_coopcontrol
	and ds.member_no = :ls_memno
	and ds.div_year = :ls_divyear
	using itr_sqlca ;
	if itr_sqlca.sqlcode <> 0 or isnull( li_shseqno ) then li_shseqno = 0
	li_shseqno++
	
	insert into yrdivstatement
	( coop_id , member_no , div_year , seq_no , operate_date , slip_date , divitemtype_code , 
	div_payment , avg_payment , etc_payment , item_payment , item_balamt ,  
	item_status , entry_id , entry_date , ref_slipcoop , ref_slipno )
	values
	( :is_coopcontrol , :ls_memno , :ls_divyear , :li_shseqno , :ldtm_oper , :ldtm_slip , :ls_divitem ,
	:ldc_div , :ldc_avg , :ldc_etc , :ldc_itempay , :ldc_itembal ,
	1 , :ls_entryid , sysdate	, :is_coopid , :ls_slipno ) using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (70.4)"
		ithw_exception.text	+= "~r~nนำเข้ารายการเคลื่อนไหวปันผล-เฉลี่ยคืน ไม่ได้"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	
	update yrdivmaster
	set div_balamt 	= :ldc_divbal, 
	avg_balamt 		= :ldc_avgbal, 
	etc_balamt		= :ldc_etcbal,
	item_balamt		= :ldc_itembal
	where coop_id= :is_coopcontrol
	and member_no	= :ls_memno
	and div_year		= :ls_divyear
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "~r~nพบขอผิดพลาด (70.5)"
		ithw_exception.text	+= "~r~nอัพเดทข้อมูลปันผล-เฉลี่ยคืนคงเหลือ ไม่ได้"
		ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
		ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
		ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
		ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
		lb_err = true ; if lb_err then Goto objdestroy
	end if
	
	//** hardcode
	
	if ls_methpay = 'DEP' then
		insert into dpdepttran
		( 	coop_id , deptaccount_no , memcoop_id , member_no , system_code , tran_year , tran_date , 
			seq_no , 
			deptitem_amt , tran_status , dividen_amt , average_amt , branch_operate , sequest_status , sequest_amt , ref_slipno , ref_coopid )
		values
		( 	:ls_bizzcoop , :ls_expaccid , :is_coopcontrol , :ls_memno , 'DIV' , :li_tranyear , :ldtm_oper , 
			nvl( ( select max( seq_no ) from dpdepttran where coop_id = :ls_bizzcoop and deptaccount_no = :ls_expaccid and memcoop_id = :is_coopcontrol and member_no = :ls_memno and system_code = 'DIV' and tran_year = :li_tranyear and tran_date = :ldtm_oper ) , 0 ) + 1 , 
			:ldc_itempay , 0 , :ldc_div , :ldc_avg , '000' , 0 , 0 , :ls_slipno , :is_coopid )
		using itr_sqlca ;
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "~r~nพบขอผิดพลาด (70.6)"
			ithw_exception.text	+= "~r~nผ่านรายการข้อมูลปันผล-เฉลี่ยคืน ไปเงินฝาก ไม่ได้"
			ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
			ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
			ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
			ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
			lb_err = true ; if lb_err then Goto objdestroy
		end if
	end if
	
	if ls_methpay = 'LON' then
//		select coop_id , coop_id , member_no , trans_date , seq_no , transitem_code , realpay_date , shrtype_code , concoop_id , loancontract_no , transpay_type , trans_amt , principal_trnamt , interest_trnamt , sliptype_code , trnsource_code , trnsource_status , moneytype_code , post_status  from sltranspayin ;
		insert into sltranspayin
		( 	coop_id , memcoop_id , member_no , trans_date , seq_no , 
			transitem_code , realpay_date , shrtype_code , concoop_id , loancontract_no ,
			transpay_type , trans_amt , principal_trnamt , interest_trnamt , sliptype_code , trnsource_code , trnsource_refslipno, trnsource_status , moneytype_code , post_status )
		values
		( 	:is_coopcontrol , :is_coopcontrol , :ls_memno , :ldtm_oper , nvl( ( select max( seq_no ) from sltranspayin where coop_id = :is_coopcontrol and coop_id = :is_coopcontrol and member_no = :ls_memno and trans_date = :ldtm_oper ) , 0 ) + 1 ,
			'LON' , :ldtm_oper , :ls_bizztype , :ls_bizzcoop , :ls_bizzacc ,
			2 , :ldc_itempay , :ldc_prin , :ldc_int , 'PX' , 'DIV' , :ls_slipno , 8 , 'TRN' , 0 )
		using itr_sqlca ;
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "~r~nพบขอผิดพลาด (70.7)"
			ithw_exception.text	+= "~r~nผ่านรายการข้อมูลปันผล-เฉลี่ยคืน ไปชำระเงินกู้ ไม่ได้"
			ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
			ithw_exception.text	+= "~r~nเลขที่สัญญา : " + ls_bizzacc
			ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
			ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
			ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
			lb_err = true ; if lb_err then Goto objdestroy
		end if
		
		update lnpreparepay
		set prepare_status = 1 , 
		ref_slipcoop = :is_coopid , 
		ref_slipno = :ls_slipno , 
		entrypay_id = :ls_entryid , 
		entrypay_date = sysdate
		where coop_id = :is_coopcontrol
		and loancontract_no = :ls_bizzacc
		and prepare_status = 8
		using itr_sqlca;
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "~r~nพบขอผิดพลาด (70.8)"
			ithw_exception.text	+= "~r~nผ่านรายการข้อมูลปันผล-เฉลี่ยคืน ไปชำระเงินกู้ ไม่ได้"
			ithw_exception.text	+= "~r~nเลขที่สมาชิก : " + ls_memno
			ithw_exception.text	+= "~r~nเลขที่สัญญา : " + ls_bizzacc
			ithw_exception.text	+= "~r~n" + string( itr_sqlca.sqlcode )
			ithw_exception.text	+= "~r~n" + itr_sqlca.sqlerrtext
			ithw_exception.text 	+= "~r~nกรุณาตรวจสอบ"
			lb_err = true ; if lb_err then Goto objdestroy
		end if
		
	end if
	
	ldc_div	= 0
	ldc_avg	= 0
	ldc_etc	= 0
	ldc_divbal	= 0
	ldc_avgbal	= 0
	ldc_etcbal	= 0
	//** จบ hardcode	
	
	inv_progress.istr_progress.subprogress_text	= string(ll_index,"#,##0") + "/" + string(ll_count,"#,##0") +". เลขสมาชิก > "+ls_memno+" > ยอดจ่าย " + string( ldc_expense,"#,##0.00")
	
next

objdestroy:
if isvalid(lds_xmloption) then destroy lds_xmloption

this.of_setsrvdoccontrol( false )
this.of_setsrvdwxmlie( false )
this.of_setsrvdw(false)

if lb_err then
	rollback using itr_sqlca ;
	ithw_exception.text = "n_cst_divsrv_operate.of_save_slip_cls()" + ithw_exception.text
	throw ithw_exception
else
	commit using itr_sqlca ;
end if

inv_progress.istr_progress.status = 1

return 1
end function

protected function integer of_setsrvdw (boolean ab_switch);// Check argument
if isnull( ab_switch ) then
	return -1
end if

if ab_switch then
	if isnull( inv_dwsrv ) or not isvalid( inv_dwsrv ) then
		inv_dwsrv	= create n_cst_datawindowsservice
		inv_dwsrv.of_initservice( inv_transection )
		return 1
	end if
else
	if isvalid( inv_dwsrv ) then
		destroy inv_dwsrv
		return 1
	end if
end if

return 0
end function

on n_cst_divsrv_operate.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_divsrv_operate.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ithw_exception = create Exception
end event
