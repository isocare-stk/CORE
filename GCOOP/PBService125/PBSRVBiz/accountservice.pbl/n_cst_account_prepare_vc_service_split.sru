$PBExportHeader$n_cst_account_prepare_vc_service_split.sru
$PBExportComments$ตัวบริการ เตรียมข้อมูลระบบบัญชี
forward
global type n_cst_account_prepare_vc_service_split from NonVisualObject
end type
end forward

/// <summary> ตัวบริการ เตรียมข้อมูลระบบบัญชี
/// </summary>
global type n_cst_account_prepare_vc_service_split from NonVisualObject
end type
global n_cst_account_prepare_vc_service_split n_cst_account_prepare_vc_service_split

type variables
public:
n_cst_progresscontrol	inv_progresscontrol
n_cst_account_service		inv_account_service

protected:
Exception		ithw_exception
transaction		itr_sqlca

string				is_acccash ,is_benifit_total_acc , is_benifit_account_id , is_pay[], is_rcv[] , is_vcdocno[]
string				is_account_pl_pf, is_finstatus_code, is_vctype_docno
integer			ii_present_year, ii_begin_year, ii_begin_period
datetime			idtm_beginning_of_accou,idtm_ending_of_account
integer			ii_split_vcdetail  = 0 , ii_set_vcdetail  = 1
string				is_vcpaydocno, is_vcrcvdocno,is_vcrcvtrndocno

n_cst_datetimeservice		inv_datetime
n_cst_doccontrolservice		inv_docservice
n_cst_stringservice			inv_string
n_cst_progresscontrol		inv_progress

datastore	ids_vcproc
n_ds			ids_vcrcvpay, ids_vcrcvpaydet,  ids_vcrcv, ids_vcrcvdet,  ids_vcpay, ids_vcpaydet, ids_voucher,ids_voucherdet 
n_ds			ids_acccont , ids_mapaccid
end variables

forward prototypes
public function integer of_settrans (n_cst_dbconnectservice anv_db)
private function any of_getattribmapaccid (string as_coopid, string as_system, string as_slipitem, string as_shrlontype, integer ai_itemstatus, string as_attribmap) throws Exception
public function integer of_vcproc (datetime adtm_sysdate, string as_sysgencode, string as_coopid, string as_userid) throws Exception
private function string of_getvoucher_no (datetime adtm_date, string as_voucher_type, ref string as_voucher_no, string as_coopid) throws Exception
private function integer of_vccashdppay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_addvoucher (string as_vcdocno, datetime adtm_vcdate, string as_vctype, string as_vcdesc, decimal adc_vcamt, DataStore ads_vchead, string as_system_code, string as_coopid, string as_userid) throws Exception
private function integer of_vccashlnpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashlnrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashdprcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashfinpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashfinrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_additem (string as_coopid, string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, long al_sortorder, ref n_ds ads_voucherdet, string as_userid) throws Exception
private function integer of_additemdesc (string as_coopid, string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, string as_desc, long al_sortorder, ref n_ds ads_voucherdet) throws Exception
private function integer of_vccashshrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashshpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnpayin (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnpayout (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrndppay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrndprcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnshrrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnshrpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnfinrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnfinpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnpayout_atm (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrn_kpmonth (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrn_cancel_kp_month (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrn_cancel_kp_month_slip (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnpayin_shr (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrndppay_dol (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashlnrcv_shr (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrndppay_rcv_dol (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
public function integer of_gen_vc_close_year (integer ai_year, integer ai_period, string as_coopid) throws Exception
private function integer of_vccashfinrcv_tax (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrn_kpmth_dppay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrn_kpmth_dprcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashfinpay_split (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnfinpay_split (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_set_voucher_no (datetime adtm_date, string as_coopid, string as_type) throws Exception
private function integer of_vctrn_lnrespons (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrndiv_avg_cbt (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrndiv_avg_dep (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrndiv_avg_payin (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
public function integer of_vctrndiv_avg_tbk (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashdiv_avgpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
public function integer of_vccashastpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
public function integer of_vctrnastpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
public function integer of_vctrndiv_avg_trn_etc (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
public function integer of_vctrndiv_avg_cmt (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
public function integer of_vccashdprcv_fee_split (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
end prototypes

public function integer of_settrans (n_cst_dbconnectservice anv_db);//////////////////////////////////////////////////////////////////////////////
//	Function Name:	of_init
//
//	Arguments:
//	anv_db			object ที่ใช้สำหรับการเชื่อมต่อฐานข้อมูล
//
//	Returns:  		integer
//						ค่าที่ส่งออกไป บอกผลลัพท์ว่า function นี้ถูกเรียกใช้แล้ว
//
//	Description: 	เพื่อทำการกำหนดค่าการเชื่อมต่อฐานข้อมูลให้กับ ตัวแปร instant itr_sqlca
//////////////////////////////////////////////////////////////////////////////

itr_sqlca	= anv_db.itr_dbconnection

inv_docservice				= create n_cst_doccontrolservice
inv_string					= create n_cst_stringservice
inv_datetime				= create n_cst_datetimeservice
inv_progresscontrol			= create n_cst_progresscontrol

inv_docservice.of_settrans( anv_db )

//หาบัญชีเงินสด
select  	cash_account_code
into		:is_acccash 
from		accconstant 
using    	itr_sqlca  ;	

//หาประเภทการรันเลขเอกสาร 00 = ขึ้นเลขใหม่ทุกวัน, 01 = ขึ้นเลขใหม่ทุกเดือน , 02= ขึ้นเลขใหม่ทุกปี
select  	finstatus_code
into		:is_vctype_docno 
from		accconstant 
using    	itr_sqlca  ;	

if IsNull( is_vctype_docno ) or is_vctype_docno = "" then is_vctype_docno = '02'

ids_vcrcv	= create n_ds
ids_vcrcv.dataobject	= "d_vc_gnrate_voucher"
ids_vcrcv.settransobject( itr_sqlca )

ids_vcrcvdet	= create n_ds
ids_vcrcvdet.dataobject	= "d_vc_gnrate_voucherdet"
ids_vcrcvdet.settransobject( itr_sqlca )

ids_vcpay	= create n_ds
ids_vcpay.dataobject	= "d_vc_gnrate_voucher"
ids_vcpay.settransobject( itr_sqlca )

ids_vcpaydet	= create n_ds
ids_vcpaydet.dataobject	= "d_vc_gnrate_voucherdet"
ids_vcpaydet.settransobject( itr_sqlca )

ids_vcrcvpay	= create n_ds
ids_vcrcvpay.dataobject	= "d_vc_gnrate_voucher"
ids_vcrcvpay.settransobject( itr_sqlca )

ids_vcrcvpaydet	= create n_ds
ids_vcrcvpaydet.dataobject	= "d_vc_gnrate_voucherdet"
ids_vcrcvpaydet.settransobject( itr_sqlca )

ids_voucher	= create n_ds
ids_voucher.dataobject	= "d_vc_gnrate_voucher"
ids_voucher.settransobject( itr_sqlca )

ids_voucherdet	= create n_ds
ids_voucherdet.dataobject	= "d_vc_gnrate_voucherdet"
ids_voucherdet.settransobject( itr_sqlca )

ids_mapaccid	= create n_ds
ids_mapaccid.dataobject	= "d_vc_mapaccid"
ids_mapaccid.settransobject( itr_sqlca )
ids_mapaccid.retrieve( )

ids_acccont 	= create n_ds
ids_acccont.dataobject	= "d_vc_acccont"
ids_acccont.settransobject( itr_sqlca )
ids_acccont.retrieve( )

return 1
end function

private function any of_getattribmapaccid (string as_coopid, string as_system, string as_slipitem, string as_shrlontype, integer ai_itemstatus, string as_attribmap) throws Exception;/***********************************************************
<description>
	ประมวลผลดึง รหัสบัญชี จาก vcmapaccid
</description>

<arguments>

</arguments> 

<return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

integer	li_row
any		la_attrib


if isnull( as_shrlontype ) or trim( as_shrlontype ) = "" then as_shrlontype = "00"

if isnull( ai_itemstatus ) then ai_itemstatus = 1

// validate parameter
li_row	= ids_mapaccid.find( " coop_id = '"+as_coopid+"' and system_code = '"+as_system+"' and slipitemtype_code = '"+as_slipitem+"' and shrlontype_code = '"+as_shrlontype+&
							   "' and shrlontype_status = "+string( ai_itemstatus )  , 0 , ids_mapaccid.rowcount() )
if li_row > 0 then	
	la_attrib	= ids_mapaccid.GetitemString( li_row,as_attribmap  )	
end if

return la_attrib
end function

public function integer of_vcproc (datetime adtm_sysdate, string as_sysgencode, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี
</description>
<arguments>
sysdate , sysgen , coopid , userid
</arguments>
<return> 
	Integer	1 = success,  throwable = failure
</return> 
<usage> 	
	Revision History:
	Version 1.0 (Initial version) Modified Date 27/07/2013 by Runja
</usage> 
***********************************************************/

//
string		ls_coopid ,  ls_userid , ls_sysgencode , ls_startacc, ls_check_voucherno
integer		li_shrcv, li_lnrcv, li_lnrcv_clc, li_dprcv, li_finrcv, li_shpay, li_lnpay, li_dppay, li_finpay, li_divpay, li_ast, li_trnast
integer		li_chk, li_row  , li_count, li_finpay_split, li_trnfinpay_split, li_check, li_trnrespons, li_trndivpay
datetime	ldtm_vcdate, ldtm_startacc, ldtm_end_year
boolean		lb_genamt
integer		li_trn_dprcv, li_trn_dppay, li_trnfinrcv, li_trnfinpay, li_trnpayin, li_trnpayout, li_keepmonth,li_trn_shrpay,li_trn_shrrcv,li_atm,li_kep,li_trnpayin_shr,li_trn_dppay_dol

ldtm_vcdate			=  adtm_sysdate
ls_sysgencode		=  as_sysgencode
ls_coopid			=	trim ( as_coopid )   
ls_userid			=  trim ( as_userid  ) 

////////////////////    set เลขที่ voucher_no   ///////////////////////////////////
li_check = this.of_set_voucher_no( adtm_sysdate , as_coopid, is_vctype_docno )  //00 = ขึ้นเลขใหม่ทุกวัน, 01 = ขึ้นเลขใหม่ทุกเดือน , 02= ขึ้นเลขใหม่ทุกปี

choose case ls_sysgencode
		
	case "ALL"	// ทั้งหมด ##	

		li_shrcv	=	1
		li_shpay	=	1
		li_lnrcv	=	1
		li_lnpay	=	1
		li_finrcv	=	1
		li_finpay_split	=	1
		li_dprcv	=	1	
		li_dppay	=	1
		li_divpay	=	1
		li_ast		=	1
//		li_trn_dprcv	=	1
		li_trn_dppay_dol	=	1   // กรมที่ดิน 
//		li_trn_dppay	=	1
		li_trnfinrcv	=	1
		li_trnfinpay	=	1
//		li_trnpayin	=	1
		li_trnpayin_shr	=	1    // กรมที่ดิน
		li_trnpayout	=	1
		li_trn_shrpay = 1
		li_trn_shrrcv = 1
		li_keepmonth = 1
		li_trndivpay = 1
		li_trnast		= 1
//		li_atm			= 1

	case  "ANC" //ทั้งหมดยกเว้นเงินสด ##
		li_trn_dppay_dol	=	1   // กรมที่ดิน 
		//li_trn_dprcv	=	1
		//li_trn_dppay	=	1
		li_trnfinrcv	=	1
		li_trnfinpay	=	1
//		li_trnpayin	=	1
		li_trnpayin_shr	=	1    // กรมที่ดิน
		li_trnpayout	=	1
		li_trn_shrpay = 1
		li_trn_shrrcv = 1
		li_keepmonth = 1
		li_trndivpay = 1
		li_trnast		= 1

	case "CSH"  //เงินสด ##
		li_shrcv	=	1
		li_shpay	=	1
		li_lnrcv	=	1
		li_lnrcv_clc	=	1
		li_lnpay	=	1
		li_finrcv	=	1
		li_finpay_split	=	1
		li_dprcv	=	1	
		li_dppay	=	1
		li_divpay	=	1
		li_ast		=	1

	case "LON"
		li_lnrcv	=	1
		li_lnrcv_clc	=	1
		li_lnpay	=	1
		li_trnpayout	=	1
		
	case "SHR"
		li_shrcv	=	1
		li_shpay	=	1
//		li_trnpayin	=	1
		li_trnpayin_shr	=	1    // กรมที่ดิน
		li_trn_shrrcv=1
		li_trn_shrpay=1
		
	case "DEP"
		li_dprcv	=	1	
		li_dppay	=	1
		li_trn_dppay_dol	=	1   // กรมที่ดิน 
//		li_trn_dprcv	=	1
//		li_trn_dppay	=	1

	case "FIN"		
		li_finrcv	=	1
		li_finpay_split	=	1
		li_trnfinrcv	=	1
		li_trnfinpay	=	1
		
	case "KEP"
		li_keepmonth = 1
		
	case "ATM"  //รายการ ATM
		li_atm			= 1
		
	case "DIV"
		li_trndivpay	= 1
		li_divpay		= 1

	case "AST"
		li_ast	= 1
		li_trnast	= 1

end choose		

//+++++++++++++++++++++++++++++++++++++++++++++
//รายการรับเงินสด  ===CSH
//+++++++++++++++++++++++++++++++++++++++++++++
//if li_shrcv = 1 then	
	
////รับชำระหุ้น เงินสด 
//	li_chk = this.of_vccashshrcv( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
//	if li_chk = 1 then
//		lb_genamt = true
//	else
//		rollback using itr_sqlca ;
//		throw ithw_exception
//	end if	
//end if

if li_lnrcv = 1 then
//รับชำระเงินสด + ซื้อหุ้น##
li_chk = this.of_vccashlnrcv_shr( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if
	
	if li_dprcv = 1 then
//รายการเงินฝาก
li_chk = this.of_vccashdprcv( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	//รายการ ค่าปรับ เงินฝาก
li_chk = this.of_vccashdprcv_fee_split( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if 

if li_finrcv = 1 then
//การเงินรับ
li_chk = this.of_vccashfinrcv( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	//รับภาษีหัก ณ ที่จ่าย
	li_chk = this.of_vccashfinrcv_tax( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	
	
end if

//+++++++++++++++++++++++++++++++++++++++++++++
//รายการจ่ายเงินสด  ====CSH
//+++++++++++++++++++++++++++++++++++++++++++++
if li_lnpay  = 1 then	
//จ่ายเงินกู้ เงินสด ##
	li_chk = this.of_vccashlnpay ( ldtm_vcdate , ls_coopid , ls_userid  )  
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	end if
	
if li_dppay=1 then	
//ถอนเงินรวมปิดบัญชี  ##
	li_chk = this.of_vccashdppay( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	end if	
	
if li_finpay=1 then
	//การเงินจ่ายของสหกรณ์
	li_chk = this.of_vccashfinpay( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
		if li_chk = 1 then
			lb_genamt = true
		else
			rollback using itr_sqlca ;
			throw ithw_exception
		end if
end if

if li_finpay_split =1 then
	//การเงินจ่ายของสหกรณ์แยก slip ละ 1 voucher
	li_chk = this.of_vccashfinpay_split( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if
		
if li_shpay =1 then		
		//ซื้อหุ้น เงินสด
	li_chk = this.of_vccashshpay( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if

if li_divpay = 1 then
		//จ่ายปันผล เฉลี่ยคืน เงินสด
	li_chk = this.of_vccashdiv_avgpay( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if 

if li_ast = 1 then
	// จ่ายสวัสดิการ เงินสด
	li_chk = this.of_vccashastpay( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	
end if

//+++++++++++++++++++++++++++++++++++++++++++++
//รายการเงินโอนการเงิน  ====TRN
//+++++++++++++++++++++++++++++++++++++++++++++

//if li_trnpayin = 1 then
//	
//	//รับชำระหนี้ ##
//li_chk = this.of_vctrnpayin( ldtm_vcdate , ls_coopid  , ls_userid  ) 
//	if li_chk = 1 then
//		lb_genamt = true
//	else
//		rollback using itr_sqlca ;
//		throw ithw_exception
//	end if	
//		end if	

if li_trnpayin_shr = 1 then
	
	//รับชำระหนี้ ##   (กรมที่ดิน)
li_chk = this.of_vctrnpayin_shr( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
		end if	
	
	if li_trnpayout = 1 then
		//จ่ายเงินกู้ + หักกลบ##
li_chk = this.of_vctrnpayout( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
		end if
		
		if li_trn_dprcv = 1 then
			//	โอนเงินรับฝาก
li_chk = this.of_vctrndprcv( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
		end if	
		
		if li_trn_dppay_dol =1 then
		//	ฝาก - ถอนเงินรับฝาก   แยกออมทรัพย์ ประจำ

//		li_chk = this.of_vctrndppay_dol( ldtm_vcdate , ls_coopid  , ls_userid  ) 
//			if li_chk = 1 then
//				lb_genamt = true
//			else
//				rollback using itr_sqlca ;
//				throw ithw_exception
//			end if	
	
		li_chk = this.of_vctrndppay_rcv_dol( ldtm_vcdate , ls_coopid  , ls_userid  ) 
			if li_chk = 1 then
				lb_genamt = true
			else
				rollback using itr_sqlca ;
				throw ithw_exception
			end if	
		end if	
		
		
	if li_trn_dppay =1 then
				//	ถอนเงินรับฝาก
li_chk = this.of_vctrndppay( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
		end if	
		
		if li_trn_shrrcv =1 then
				//โอนเงินซื้อหุ้น
li_chk = this.of_vctrnshrrcv( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if 
	
			if li_trn_shrpay =1 then
// คืนค่าหุ้น
li_chk = this.of_vctrnshrpay( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	end if 
	
	if li_trnfinrcv = 1 then
	// การเงินรับ
li_chk = this.of_vctrnfinrcv( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if 

if li_trnfinpay =1 then
	// การเงินจ่าย
li_chk = this.of_vctrnfinpay( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if 

if li_trnfinpay_split =1 then
	// การเงินจ่าย ลง 1 voucher /  1 slip 
li_chk = this.of_vctrnfinpay_split( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if 


//+++++++++++++++++++++++++++++++++++++++++++++
//รายการเงินโอนการเงิน ATM ====TRN
//+++++++++++++++++++++++++++++++++++++++++++++

if li_atm = 1 then
		//จ่ายเงินกู้ ATM##
li_chk = this.of_vctrnpayout_atm( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if


//+++++++++++++++++++++++++++++++++++++++++++++
//รายการเรียกเก็บประจำเดือน====TRN
//+++++++++++++++++++++++++++++++++++++++++++++

if 	li_keepmonth = 1 then
		//เรียกเก็บ
li_chk = this.of_vctrn_kpmonth( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	//ยกเลิกกระดาษทำการ(ยกเลิกเรียกเก็บ)
	li_chk = this.of_vctrn_cancel_kp_month( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	//ยกเลิกใบเสร็จ(ยกเลิกเรียกเก็บ)
	li_chk = this.of_vctrn_cancel_kp_month_slip( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	
		
	//รายการถอนจัดเก็บประจำเดือน
	li_chk = this.of_vctrn_kpmth_dppay( ldtm_vcdate , ls_coopid , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if


	//รายการฝากจัดเก็บประจำเดือน
	li_chk = this.of_vctrn_kpmth_dprcv( ldtm_vcdate , ls_coopid , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if

//+++++++++++++++++++++++++++++++++++++++++++++
//รายการโอนหนี้ให้ผู้ค้ำ====TRN
//+++++++++++++++++++++++++++++++++++++++++++++

if( ls_coopid = '023001') then //มีแต่ ไทยน้ำทิพย์ใช้
	li_trnrespons = 1
end if


if 	li_trnrespons = 1 then 
	li_chk = this.of_vctrn_lnrespons( ldtm_vcdate , ls_coopid , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if

//+++++++++++++++++++++++++++++++++++++++++++++
//รายการเงินโอนปันผลเเฉลี่ยคืน ====TRN
//+++++++++++++++++++++++++++++++++++++++++++++

if li_trndivpay = 1 then
	if( ls_coopid = '061001') then //MJU ไม่ดึงชำระหนี้จากปันผล ใช้จาก pay in แทน 
	 
	li_chk = this.of_vctrndiv_avg_cbt( ldtm_vcdate , ls_coopid  , ls_userid  ) //โอนปันผลจ่ายธนาคาร
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	
	li_chk = this.of_vctrndiv_avg_dep( ldtm_vcdate , ls_coopid  , ls_userid  ) //โอนปันผลเข้าเงินฝาก
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	li_chk = this.of_vctrndiv_avg_trn_etc( ldtm_vcdate , ls_coopid  , ls_userid  ) //โอนภายในจ่ายอื่นๆ 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
		li_chk = this.of_vctrndiv_avg_cmt( ldtm_vcdate , ls_coopid  , ls_userid  ) //หักฌาปนกิจ 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
else 
	li_chk = this.of_vctrndiv_avg_payin( ldtm_vcdate , ls_coopid  , ls_userid  ) //โอนปันผลชำระหนี้
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	
	li_chk = this.of_vctrndiv_avg_cbt( ldtm_vcdate , ls_coopid  , ls_userid  ) //โอนปันผลจ่ายธนาคาร
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	
	li_chk = this.of_vctrndiv_avg_dep( ldtm_vcdate , ls_coopid  , ls_userid  ) //โอนปันผลเข้าเงินฝาก
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if
end if
//++++++++++++++++++++++++++++++++++++++++++++++
//รายการเงินโอนสวัสดิการ
//++++++++++++++++++++++++++++++++++++++++++++++

if li_trnast = 1 then
	// จ่ายสวัสดิการ เงินโอน
	li_chk = this.of_vctrnastpay( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	
end if

//++++++++++++++++++++++++++++++++++++++++++++++++

//update
if ids_vcrcvdet.update() <> 1 then
	rollback using	itr_sqlca ; 
end if

if ids_vcpaydet.update() <> 1 then
	rollback using	itr_sqlca ; 
end if

if ids_vcrcvpaydet.update() <> 1 then
	rollback using	itr_sqlca ; 
end if 

commit  	using	itr_sqlca ; 

return 1
end function

private function string of_getvoucher_no (datetime adtm_date, string as_voucher_type, ref string as_voucher_no, string as_coopid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี  สร้างเลขที่เอกสาร
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string				ls_column, ls_year, ls_date, ls_month, ls_docno
integer			li_year, li_fount
datetime			ldtm_operate

ls_column			= "CMVOUCHERNO_" + trim (as_voucher_type)
ls_docno			= inv_docservice.of_getnewdocno( as_coopid ,ls_column )

ldtm_operate		= adtm_date
ls_date				= string(date(ldtm_operate),'dd')
ls_month			= string(date(ldtm_operate),'mm')
ls_year				= string(date(ldtm_operate),'yyyy')
li_year				= integer(ls_year)+543
ls_year				= RightA(string(li_year),2)
if (is_vctype_docno = "00") then  //ขึ้นเลขใหม่ทุกสิ้นวัน ต้องปรับ format vc ให้ โชว์วันที่ด้วย
	as_voucher_no		= as_voucher_type + ls_year+ ls_month + ls_date + rightA( ls_docno, 2 )
else
	as_voucher_no		= as_voucher_type + ls_year+ ls_month + rightA( ls_docno, 4 )
end if
li_fount				= 0

// ตรวจสอบดูว่ามีข้อมูลใน DB หรือยัง
select		count( * )
into		:li_fount
from		vcvoucher
where	coop_id			= :as_coopid  and  
			voucher_no		= :as_voucher_no 
using itr_sqlca ;

if isnull( li_fount ) then li_fount = 0

if ( li_fount > 0 ) then
	this.of_getvoucher_no( adtm_date , as_voucher_type , as_voucher_no ,as_coopid   )
end if

return  as_voucher_no
end function

private function integer of_vccashdppay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> ถอน + ปิดบัญชี แยกดอกเบี้ย เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/
string			ls_slipno, ls_accid, ls_accintarrid, ls_colname, ls_colsort, ls_depttype, ls_tofromaccid
string			ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_desc, ls_voucher_type, ls_slipno_bf
long			ll_index, ll_count, ll_sortacc
dec{2}			ldc_itempay, ldc_int_amt, ldc_intreturn, ldc_taxreturn, ldc_itempaynet, ldc_tax, ldc_orther
string			ls_acccash, ls_coopid, ls_accint, ls_tax, ls_feeid, ls_deptgroupcode, ls_recppay_desc, ls_memb_name, ls_deptno

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_cashdppay_split"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem					= "DEP"
ls_tmpvcgrp						= "PAY"

for ll_index = 1 to ll_count

	ls_slipno				= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_amt[ ll_index ]
	ldc_int_amt				= lds_slipdata.object.int_amt[ ll_index ]	
	ldc_intreturn			= lds_slipdata.object.int_return[ ll_index ]
	ls_deptgroupcode		= lds_slipdata.object.deptgroup_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_amt[ ll_index ] 
	ldc_taxreturn			= lds_slipdata.object.tax_return[ ll_index ]
	ldc_itempaynet			= lds_slipdata.object.deptslip_netamt[ ll_index ]
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ldc_tax					= lds_slipdata.object.tax_amt[ ll_index ] 
	ldc_orther				=  lds_slipdata.object.other_amt[ ll_index ]  //ค่าปรับเงินฝาก
	ls_recppay_desc			= lds_slipdata.object.recppaytype_desc[ ll_index ]
	ls_memb_name			= lds_slipdata.object.memb_name[ ll_index ]
	ls_deptno				= lds_slipdata.object.deptaccount_no[ ll_index ]
	
	if isnull( ldc_tax ) then ldc_tax = 0
	if isnull( ldc_int_amt ) then ldc_int_amt = 0
	if isnull( ldc_taxreturn ) then ldc_taxreturn = 0
	if isnull( ldc_intreturn ) then ldc_intreturn = 0
	if isnull( ldc_orther ) then ldc_orther = 0

	
		
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1,  "account_id"  ) )
	ls_accintarrid			= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
	ls_accint				= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accint_id"  ) )
	ls_tax					= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "acctax_id"  ) )	
	ls_feeid				= string( of_getattribmapaccid( as_coopid ,"DEP", "FEE", "00", 1,  "account_id"  ) ) //ค่าปรับ
	
	////// สร้างเลข Voucher
	 
	 if  ls_slipno_bf <> ls_slipno   then
			ls_voucher_type	= "PV"
			ls_desc  		= ls_recppay_desc + " " + ls_deptno + " " + ls_memb_name
			is_vcpaydocno	= this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_coopid  )
			this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcpay , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcpay.retrieve( is_vcpaydocno )
			ids_vcpaydet.retrieve( is_vcpaydocno )
	 end if 
			
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	
		// รายการฝั่ง DR
	if ( ldc_itempaynet > 0 ) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempaynet, "", ll_sortacc, ids_vcpaydet )  
	end if
	
	//	รายการฝั่ง CR
	if ( ldc_itempaynet > 0 ) then
		this.of_additem( as_coopid , is_vcpaydocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempaynet  , 1, ids_vcpaydet  , as_userid )
	end if

	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno_bf <> ls_slipno    	then
		update	dpdeptslip
		set		posttovc_flag	= 1,	
				voucher_no		= :is_vcpaydocno
		where	( deptslip_no	= :ls_slipno ) and
				( deptcoop_id 	= :as_coopid) and
				( coop_id 		= :ls_coopid)
		using itr_sqlca;
		
		ls_slipno_bf = ls_slipno
	end if
		
next

// update Vc
if ids_vcpay.update() <> 1 then
	return -1
end if
	
if ids_vcpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

destroy (lds_slipdata)
return 1
end function

private function integer of_addvoucher (string as_vcdocno, datetime adtm_vcdate, string as_vctype, string as_vcdesc, decimal adc_vcamt, DataStore ads_vchead, string as_system_code, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี  บันทึก รายการหลัก
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string				ls_userid
long				ll_row
datetime			ldtm_entry
integer			li_cash_type, li_vcdocmax

ldtm_entry			= datetime ( today() , now() )
ls_userid				= trim ( as_userid )

choose case as_vctype
	case  	'PV'
		li_cash_type			= 1	
	case	'RV'	
		li_cash_type			= 1	
	case	'JV'	
		li_cash_type			= 2	
	case else 
		li_cash_type			= 3
end choose		

ll_row	= ads_vchead.insertrow( 0 )

ads_vchead.setitem( ll_row, "coop_id", as_coopid ) 
ads_vchead.setitem( ll_row, "voucher_no", as_vcdocno )
ads_vchead.setitem( ll_row, "voucher_date", adtm_vcdate )
ads_vchead.setitem( ll_row, "voucher_type", as_vctype )
ads_vchead.setitem( ll_row, "voucher_desc", as_vcdesc )
ads_vchead.setitem( ll_row, "voucher_amt", adc_vcamt )
ads_vchead.setitem( ll_row, "entry_id", ls_userid )
ads_vchead.setitem( ll_row, "entry_date", ldtm_entry )
ads_vchead.setitem( ll_row, "system_code", as_system_code )
ads_vchead.setitem( ll_row, "cash_type", li_cash_type )

li_vcdocmax	= upperbound( is_vcdocno[] )

if isnull( li_vcdocmax ) then
	li_vcdocmax	= 0
end if

li_vcdocmax ++
is_vcdocno[ li_vcdocmax ]	= as_vcdocno

return 1
end function

private function integer of_vccashlnpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
 Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่ายเงินกู้ เงินสด  ยอดหักกลบลงรายการฝั่งรับ(RV)
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/
string		ls_slipno, ls_accid, ls_accintid, ls_accintarrid  ,ls_slipno_bf, ls_desc, ls_voucher_type
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_itemtypeshr, ls_accshr, ls_memno
string		ls_shrlontype, ls_sliptype, ls_itemtype, ls_tofromaccid, ls_slipitemtype_code, ls_loandesc
string		ls_slipclr, ls_accid_clc, ls_shrloncode, ls_memgroup, ls_coopid, ls_accid_bf, ls_itemdesc, ls_memb_name
integer		li_shrlonstatus, li_slipflag
long		ll_index, ll_count, ll_sortacc, ll_index2, ll_sortacc_clc
dec{2}		ldc_prinpay, ldc_intpay, ldc_intarrpay, ldc_itempay, ldc_int, ldc_shrpay


datastore	lds_slipdata

// ds สำหรับดึงข้อมูลการจ่ายเงินกู้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashlnpay_split"
lds_slipdata.settransobject( itr_sqlca )

ll_count			= lds_slipdata.retrieve( adtm_vcdate , as_coopid   )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if
ls_tmpsystem		= "LON"
ls_tmpvcgrp			= "PAY"
ll_index2 			= 1

	 
//ทำรายการ Voucher	 
for ll_index = 1 to ll_count 
	
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_slipno				= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_shrlontype			= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus			= 1
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay				= lds_slipdata.object.payout_amt[ ll_index ]
	ls_sliptype				= lds_slipdata.object.sliptype_code [ ll_index ]
	ls_slipclr				= lds_slipdata.object.slipclear_no[ ll_index ]
	ls_memgroup				= lds_slipdata.object.membgroup_code[ ll_index ]
	//ls_slipitemtype_code	= lds_slipdata.object.slipitemtype_code[ ll_index ]
	//ldc_shrpay				= lds_slipdata.object.item_payamt [ ll_index ]
	ls_memno				= lds_slipdata.object.member_no [ ll_index ]
	ls_memb_name			= lds_slipdata.object.memb_name [ ll_index ]
	ls_loandesc				= lds_slipdata.object.loantype_desc [ ll_index ]
	
	if isnull(ls_itemtype) or ls_itemtype = "" then ls_itemtype = 'LON'
	if isnull(ldc_prinpay) then ldc_prinpay = 0
	if isnull(ldc_itempay) then ldc_itempay = 0
	if isnull(ldc_int) then ldc_int = 0
	if isnull(ls_shrloncode) then ls_shrloncode = '00'
	
	choose case ls_sliptype
		case  'LWD'	
			ls_itemtype		= 'LON'
		case  'SWD'	,'SWT','SWP'
			ls_itemtype		= 'SHR'
	end choose		

	
	ls_accid		= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "account_id" ) )
	//ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", ls_itemtype , ls_shrloncode, li_shrlonstatus, "accint_id" ) )
	//ls_accintarrid	= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrloncode, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid(as_coopid,"LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ls_accid_clc	= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrloncode, li_shrlonstatus, "account_id" ) )
	ll_sortacc_clc	= long	( of_getattribmapaccid(as_coopid,"LON", ls_itemtype , ls_shrloncode, li_shrlonstatus, "sortacc_order"   ) )
	
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if
	
	 
	 if  ls_slipno	<> ls_slipno_bf	 then
			ls_voucher_type	= "PV"
			ls_desc  				= "จ่าย" + ls_loandesc + " " + ls_memb_name
			is_vcpaydocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_coopid  )
			this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcpay , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcpay.retrieve( is_vcpaydocno )
			ids_vcpaydet.retrieve( is_vcpaydocno )
	 end if 	

	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	


	//if  ls_accid_bf = ls_accid then
		//ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		//ll_index2 = ll_index2 + 1
	//else
		//ll_index2	=	1
		//ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		//ll_index2 = ll_index2 + 1
	//end if


	// รายการจ่ายเงิน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, "", ll_sortacc, ids_vcpaydet)
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then		
		this.of_additem( as_coopid , is_vcpaydocno ,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcpaydet  , as_userid )
	end if

	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayout
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcpaydocno
		where		( payoutslip_no		= :ls_slipno ) and
						(memcoop_id		= :as_coopid) and
						(coop_id				= :ls_coopid)

		using     itr_sqlca   ;							
	end if
	
	ls_slipno_bf		= ls_slipno
	ls_accid_bf		= ls_accid
	
next

destroy (lds_slipdata)

//update
if ids_vcpay.update() <> 1 then	
	return -1
end if
	
if ids_vcpaydet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vccashlnrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
 Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการชำระ เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/

string		ls_slipno, ls_accid, ls_accintid, ls_accintarrid, ls_slipno_bf, ls_desc
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_voucher_type
string		ls_shrlontype, ls_itemtype, ls_tofromaccid, ls_memgroup, ls_coopid
integer	li_shrlonstatus, li_slipflag
long		ll_index, ll_count, ll_sortacc, ll_sortint
dec{2}	ldc_prinpay, ldc_intpay, ldc_itempay, ldc_intarrpay, ldc_int

datastore	lds_slipdata 

// ds สำหรับเก็บการชำระหนี้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashlnrcv"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )


// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if
	
ls_tmpsystem	= "LON" 
ls_tmpvcgrp		= "RCV"

//สร้างเลขที่ Voucher
 if  is_vcrcvdocno = ""    then
		ls_voucher_type	= "RV"
		ls_desc  				= "เงินสดรับประจำวัน"		
		is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
		this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type ,  ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid  , as_userid )		
	else
		ids_vcrcv.retrieve( is_vcrcvdocno )
		ids_vcrcvdet.retrieve( is_vcrcvdocno )
 end if 	

// ชุดการรับชำระหนี้
for ll_index = 1 to ll_count

	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_slipno				= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= lds_slipdata.object.bfcontlaw_status[ ll_index ]
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt[ ll_index ]
	ldc_int				= lds_slipdata.object.interest_payamt[ ll_index ]
	ldc_intarrpay		= lds_slipdata.object.intarrear_payamt[ ll_index ]
	ls_memgroup		= lds_slipdata.object.membgroup_code[ ll_index ]
							
		
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_prinpay ) then ldc_prinpay = 0
	if isnull( ldc_intarrpay ) then ldc_intarrpay = 0
	if isnull( li_shrlonstatus) then li_shrlonstatus = 1
	
	if ( ldc_intarrpay > 0 ) then
		ldc_intpay	= ldc_intpay - ldc_intarrpay
	end if
		
	ls_accid			= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
		
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if
	
	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	
		// hare_code เพื่อแยกประเภทหุ้นของสมาชิกปกติ กับ สมทบ by Mike 04/09/2013 สำหรับระยอง
//	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'SHR' then
//		ls_accid = "311101"  
//	end if
//
	
// เงินต้น
		if ( ldc_prinpay > 0 ) then				
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_prinpay, "", ll_sortacc, ids_vcrcvdet)
			this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_prinpay  , 1, ids_vcrcvdet  , as_userid )
		end if
		
		// ดอกเบี้ย	
		if ( ldc_int > 0 ) then
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintid, ls_accside, ldc_int, "", ll_sortacc, ids_vcrcvdet)
			this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_int  , 1, ids_vcrcvdet  , as_userid )
		end if
		
		// ดอกเบี้ยค้าง
		if ( ldc_intarrpay > 0 ) then
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accside, ldc_intarrpay, "", ll_sortacc, ids_vcrcvdet)
			this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_intarrpay  , 1, ids_vcrcvdet  , as_userid )
		end if	
		
				//รายการชำระหักอื่น ๆ
		if ( ldc_itempay > 0 and  ldc_prinpay = 0 and ldc_int = 0 ) then
			this.of_additem( as_coopid , is_vcrcvdocno, ls_tmpsystem , ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay ,ll_sortint, ids_vcrcvdet  , as_userid )
			this.of_additem( as_coopid , is_vcrcvdocno , "CSH" , "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet  , as_userid )
		end if
		
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayin
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcrcvdocno
		where		payinslip_no			= :ls_slipno   and 
						memcoop_id		= :as_coopid and
						coop_id				= :ls_coopid
		using    		 itr_sqlca   ;							
	end if				
		
	ls_slipno_bf		= ls_slipno	
				
next

destroy (lds_slipdata)

//update
if ids_vcrcv.update() <> 1 then
	return -1
end if
	
if ids_vcrcvdet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if


return 1
end function

private function integer of_vccashdprcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> ฝาก + เปิดบัญชี เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/

string			ls_slipno, ls_accid, ls_accintarrid, ls_depttype, ls_tofromaccid, ls_desc, ls_slipno_bf
string			ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_depttype_group, ls_voucher_type
long			ll_index, ll_count, ll_sortacc
dec{2}			ldc_itempay, ldc_intarrpay
string			ls_coopid , ls_deptcoopid, ls_acccash, ls_recppay_desc, ls_memb_name, ls_deptno

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashdprcv_split"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem		= "DEP"
ls_tmpvcgrp			= "RCV"
is_vcrcvdocno = ""


for ll_index = 1 to ll_count
	
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_deptcoopid			= lds_slipdata.object.deptcoop_id[ ll_index ]
	ls_slipno				= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_netamt[ ll_index ]
	ls_recppay_desc			= lds_slipdata.object.recppaytype_desc[ ll_index ]
	ls_memb_name			= lds_slipdata.object.memb_name[ ll_index ]
	ls_deptno				= lds_slipdata.object.deptaccount_no[ ll_index ]
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "account_id"  ) )
	
	 if  ls_slipno_bf <> ls_slipno  then
			ls_voucher_type	= "RV"
			ls_desc  		= ls_recppay_desc + " " + ls_deptno + " " + ls_memb_name
			is_vcrcvdocno	= this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid,   as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	

	
	ls_accside			= "CR"
	ls_accrevside		= "DR"	
	
		if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
		
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, "", ll_sortacc, ids_vcrcvdet)
		this.of_additem( as_coopid ,is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet  , as_userid )
	end if
	
	//update สถานะการดึงข้อมูล
	if	ls_slipno_bf <> ls_slipno   	then
		update	dpdeptslip
		set		posttovc_flag	= 1,	
				voucher_no		= :is_vcrcvdocno
		where	( deptslip_no	= :ls_slipno ) and
				( deptcoop_id 	= :as_coopid) and
				( coop_id 		= :ls_coopid)
		using itr_sqlca;
		
		ls_slipno_bf = ls_slipno
	end if
	

next

//update
if ids_vcrcv.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvdet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if
	
destroy( lds_slipdata )	
return 1
end function

private function integer of_vccashfinpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
 Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่ายการเงิน เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/
string			ls_slipno, ls_slipprior, ls_accid, ls_tofromaccid, ls_desc
string			ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp ,ls_slipitem_desc
long			ll_index, ll_count
dec{2}		ldc_itempay
string			ls_itemdesc , ls_coopid, ls_voucher_type

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashfnpay"
lds_slipdata.settransobject( itr_sqlca )
 
ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

//ls_desc	= "จ่ายเงิน"
ls_tmpsystem		= "FIN"
ls_tmpvcgrp			= "DAY"

// สร้างเลข Voucher

	 if  is_vcpaydocno    =  ""  then
			ls_voucher_type	= "PV"
			ls_desc  				= "เงินสดจ่ายประจำวัน"		
			is_vcpaydocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_coopid  )
			this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcpay , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcpay.retrieve( is_vcpaydocno )
			ids_vcpaydet.retrieve( is_vcpaydocno )
	 end if 	

for ll_index = 1 to ll_count
	ls_slipno					= lds_slipdata.object.slip_no[ ll_index ]
	ldc_itempay				= lds_slipdata.object.itempay_amt[ ll_index ]	
	ls_accid					= lds_slipdata.object.account_id[ ll_index ]
	ls_slipitem_desc		= trim( lds_slipdata.object.slipitem_desc[ ll_index ] )
	ls_tofromaccid			= trim( lds_slipdata.object.tofrom_accid[ ll_index ] )
	ls_coopid					= lds_slipdata.object.coop_id[ ll_index ]
	
	if isnull( ldc_itempay ) then ldc_itempay = 0
			
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	
	//รายการการเงิน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_slipitem_desc, 1, ids_vcpaydet)
		this.of_additem( as_coopid ,is_vcpaydocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcpaydet  , as_userid )
	end if	
		
	//update สถานะการดึงข้อมูล
	if ls_slipno <> ls_slipprior then
		update	finslipdet
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcpaydocno
		where	( slip_no			= :ls_slipno ) and
					( coop_id 		= :ls_coopid)
		
		using    	itr_sqlca   ;	
		
		ls_slipprior	= ls_slipno
		
	end if

next

destroy (lds_slipdata)
// update Vc
if ids_vcpay.update() <> 1 then	
	return -1
end if
	
if ids_vcpaydet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then	
	return -1
end if
	
if ids_voucherdet.update() <> 1 then	
	return -1
end if


return 1
end function

private function integer of_vccashfinrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
 Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการรับการเงิน เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/
string		ls_slipno, ls_slipprior, ls_accid, ls_tofromaccid, ls_slipitem_desc
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
long		ll_index, ll_count
dec{2}		ldc_itempay
string		ls_desc, ls_voucher_type , ls_coopid, ls_detail

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashfnrcv_split"
lds_slipdata.settransobject( itr_sqlca )

// reset เงินสดรับ
ll_count	= lds_slipdata.retrieve( adtm_vcdate,as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if


ls_tmpsystem		= "FIN"
ls_tmpvcgrp			= "DAY"
is_vcrcvdocno = ""



for ll_index = 1 to ll_count
	ls_slipno					= trim( lds_slipdata.object.slip_no[ ll_index ] )
	ldc_itempay					= lds_slipdata.object.itempay_amt[ ll_index ]	
	ls_accid					= lds_slipdata.object.account_id[ ll_index ]
	ls_slipitem_desc			= trim( lds_slipdata.object.slipitem_desc[ ll_index ] )
	ls_tofromaccid				= trim( lds_slipdata.object.tofrom_accid[ ll_index ] )
	ls_coopid					= lds_slipdata.object.coop_id[ ll_index ]	
	ls_detail					= lds_slipdata.object.nonmember_detail[ ll_index ]	
	
	// สร้างเลข Voucher

	 if  ls_slipno <> ls_slipprior  then
			ls_voucher_type		= "RV"
			ls_desc  			= ls_detail	
			is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	
	
	ls_accside			= "CR"
	ls_accrevside		= "DR"
	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	
		// รายการการเงิน
	if ( ldc_itempay > 0 ) then		
		this.of_additemdesc( as_coopid , is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_slipitem_desc, 0, ids_vcrcvdet)
		this.of_additem( as_coopid ,is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet  , as_userid )
	end if

	// Update สถานะการผ่าน Voucher
	if( ls_slipno <> ls_slipprior ) then 
		update	finslipdet
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvdocno
		where	( slip_no			= :ls_slipno )  and
					( coop_id 		= :ls_coopid)
		using     itr_sqlca   ;	
		
		ls_slipprior = ls_slipno
	end if
next

//update
if ids_vcrcv.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvdet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

destroy (lds_slipdata)
return 1
end function

private function integer of_additem (string as_coopid, string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, long al_sortorder, ref n_ds ads_voucherdet, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   เพิ่มรายการด้านเงินสด 
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string		ls_colname , ls_coopcontrol
long		ll_find, ll_seqno
dec{2}	ldc_itembal

if as_accside = "DR" then
	ls_colname	= "dr_amt"
else
	ls_colname	= "cr_amt"
end if


ll_find	= ads_voucherdet.find( "coop_id = '"+as_coopid+  "'  and account_id = '"+as_accid+  "'  and voucher_no = '"+  as_voucherno + "' and system_code = '"+as_syscode+"'" + &
									" and vcgrp_no = '"+as_vcgrpno+"' and account_side = '"+as_accside+"'", 1, ads_voucherdet.rowcount() )	
			
if ll_find <= 0 then
	ll_find		= ads_voucherdet.insertrow( 0 )
	
	ll_seqno	= long( ads_voucherdet.describe( "evaluate( 'max( seq_no for all )', "+string( ll_find )+") " ) )
	
	if isnull( ll_seqno ) then ll_seqno = 0
	
	ll_seqno ++
	
	ads_voucherdet.setitem( ll_find, "coop_id", as_coopid ) 
	ads_voucherdet.setitem( ll_find, "voucher_no", as_voucherno )
	ads_voucherdet.setitem( ll_find, "seq_no", ll_seqno )
	ads_voucherdet.setitem( ll_find, "system_code", as_syscode )
	ads_voucherdet.setitem( ll_find, "vcgrp_no", as_vcgrpno )
	ads_voucherdet.setitem( ll_find, "account_id", as_accid )
	ads_voucherdet.setitem( ll_find, "account_side", as_accside )
	ads_voucherdet.setitem( ll_find, "sort_order", al_sortorder )
	ads_voucherdet.setitem( ll_find, "POSTTOGL_ALLFLAG", 1 )
	
end if
			
ldc_itembal		= ads_voucherdet.getitemdecimal( ll_find, ls_colname )
ldc_itembal		= ldc_itembal + adc_itemamt
			
ads_voucherdet.setitem( ll_find, ls_colname, ldc_itembal )

if ii_set_vcdetail = 0 then
	ads_voucherdet.setitem( ll_find, "POSTTOGL_FLAG", 0 )
else
	ads_voucherdet.setitem( ll_find, "POSTTOGL_FLAG", 1 )
end if

ads_voucherdet.accepttext( )

return 1
end function

private function integer of_additemdesc (string as_coopid, string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, string as_desc, long al_sortorder, ref n_ds ads_voucherdet) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี  
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string		ls_colname, ls_itemdesc, ls_min, ls_max, ls_desc, ls_coopcontrol
long		ll_find, ll_seqno, ll_pos
dec{2}	ldc_itembal

ls_itemdesc	= ''
ls_min		= ''
ls_max		= ''
ls_desc		= ''

if as_accside = "DR" then
	ls_colname	= "dr_amt"
else
	ls_colname	= "cr_amt"
end if					

ll_find	= ads_voucherdet.find( "coop_id = '"+as_coopid+  "'  and account_id = '"+as_accid+  "'  and voucher_no = '"+  as_voucherno + "' and system_code = '"+as_syscode+"'" + &
									" and vcgrp_no = '"+as_vcgrpno+"' and account_side = '"+as_accside+"'", 1, ads_voucherdet.rowcount() )	


if ll_find <= 0 then
	ll_find		= ads_voucherdet.insertrow( 0 )
	
	ll_seqno	= long( ads_voucherdet.describe( "evaluate( 'max( seq_no for all )', "+string( ll_find )+") " ) )
	
	if isnull( ll_seqno ) then ll_seqno = 0
	
	ll_seqno ++
	ads_voucherdet.setitem( ll_find, "coop_id", as_coopid ) 
	ads_voucherdet.setitem( ll_find, "voucher_no", as_voucherno )
	ads_voucherdet.setitem( ll_find, "seq_no", ll_seqno )
	ads_voucherdet.setitem( ll_find, "system_code", as_syscode )
	ads_voucherdet.setitem( ll_find, "vcgrp_no", as_vcgrpno )
	ads_voucherdet.setitem( ll_find, "account_id", as_accid )
	ads_voucherdet.setitem( ll_find, "account_side", as_accside )
	ads_voucherdet.setitem( ll_find, "sort_order", al_sortorder )
	ads_voucherdet.setitem( ll_find, "POSTTOGL_ALLFLAG", 1 )
	ads_voucherdet.setitem( ll_find, "POSTTOGL_FLAG", 1 )
	

end if					
			
ldc_itembal		= ads_voucherdet.getitemdecimal( ll_find, ls_colname )
ldc_itembal		= ldc_itembal + adc_itemamt
			
ads_voucherdet.setitem( ll_find, ls_colname, ldc_itembal )
ads_voucherdet.setitem( ll_find, "item_desc", as_desc )

if ii_set_vcdetail = 0 then
	ads_voucherdet.setitem( ll_find, "POSTTOGL_FLAG", 0 )
else
	ads_voucherdet.setitem( ll_find, "POSTTOGL_FLAG", 1 )
end if
	
ads_voucherdet.accepttext( )

return 1
end function

private function integer of_vccashshrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
 Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการรับซื้อหุ้น เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/

string		ls_slipno, ls_accid , ls_slipno_bf, ls_desc
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string		ls_shrlontype, ls_itemtype, ls_tofromaccid
integer	li_shrlonstatus, li_slipflag
long		ll_index, ll_count, ll_sortacc, ll_index2
dec{2}	ldc_itempay
string		ls_loangroup_code, ls_accid_bf, ls_vcrcvdocno_prnc ,ls_coopcontrol , ls_coopid
string		ls_voucher_type, ls_memgroup, ls_itemdesc

datastore	lds_slipdata 

// ds สำหรับเก็บการซื้อหุ้น
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashshrcv"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

// สร้างเลข Voucher
	 if  is_vcrcvdocno    =  ""  then
			ls_voucher_type	= "RV"
			ls_desc  				= "เงินสดรับประจำวัน"		
			is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	


ls_tmpsystem	= "SHR" 
ls_tmpvcgrp		= "PAY"
ls_accid_bf		= ''
ll_index2			=	1
// ชุดการรับชำระหนี้
for ll_index = 1 to ll_count

	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_slipno				= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= 1
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ls_memgroup		= lds_slipdata.object.membgroup_code[ ll_index ]
		
	if isnull( ldc_itempay ) then ldc_itempay = 0

		
	ls_accid			= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
		
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if


	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	
	// hare_code เพื่อแยกประเภทหุ้นของสมาชิกปกติ กับ สมทบ by Mike 04/09/2013 สำหรับระยอง
//	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'SHR' then
//		ls_accid = "311101"  
//	end if

	if  ls_accid_bf = ls_accid then
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	else
		ll_index2	=	1
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	end if
		
	// ยอดทำรายการ
	if ( ldc_itempay > 0 ) then				
		this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_itemdesc, ll_sortacc, ids_vcrcvdet)
	end if
	
	// รายการเงินสดฝั่งตรงข้าม
	if	( ldc_itempay > 0  ) then
		this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet  , as_userid )
	end if		
	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayin
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcrcvdocno
		where		payinslip_no			= :ls_slipno   and 
						memcoop_id		= :as_coopid and
						coop_id 				= :ls_coopid
		using    		 itr_sqlca   ;							
	end if				
		
	ls_accid_bf		= ls_accid
	ls_slipno_bf		= ls_slipno	
				
next

destroy (lds_slipdata)

if ids_vcrcv.update() <> 1 then
	return -1
end if
	
if ids_vcrcvdet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if


return 1
end function

private function integer of_vccashshpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; ///***********************************************************
 //Version 2.0
//<description>
	//ประมวลผลดึงรายการบัญชี   ==> รายการจ่าย เงินสด
//</description>
//
//<arguments>
//
//</arguments> 
//
//<return> 
	//Integer	1 = success,  throwable = failure
//</return> 
//
//<usage> 
	//
	//Revision History:
	//Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	//Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
//</usage> 
//***********************************************************/
string	ls_slipno, ls_accid, ls_accintid, ls_accintarrid , ls_slipno_bf, ls_desc
string	ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_acccash
string	ls_moneygrp, ls_shrlontype, ls_sliptype, ls_itemtype, ls_tofromaccid
integer	li_slipflag, li_shrlonclc_status, li_shareclc_status
long	ll_index, ll_count, ll_sortacc, ll_index2, ll_row, ll_sortacc_clc
dec{2}	ldc_prinpay, ldc_intpay, ldc_intarrpay, ldc_itempay
dec{2}	ldc_int, ldc_total
string	ls_tofromaccid_bf,  ls_shrloncode, ls_slipclr, ls_accid_clc
string	ls_voucher_type,ls_coopid, ls_itemdesc, ls_memno, ls_memb_name

datastore	lds_slipdata

// ds สำหรับดึงข้อมูลการถอนหุ้นลาออก
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashshpay_split"
lds_slipdata.settransobject( itr_sqlca )

ll_count			= lds_slipdata.retrieve( adtm_vcdate , as_coopid   )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem		= "SHR"
ls_tmpvcgrp			= "PAY"
ls_tofromaccid_bf	= ""
ll_index2				=	1


for ll_index = 1 to ll_count 
		
	ls_slipno			= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_slipflag			= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.payout_amt[ ll_index ]
	ls_sliptype			= lds_slipdata.object.sliptype_code [ ll_index ]
	ldc_total			= lds_slipdata.object.payoutnet_amt [ ll_index ]
	ls_coopid			= lds_slipdata.object.coop_id [ ll_index ]
	ls_slipclr			= lds_slipdata.object.slipclear_no[ ll_index ]
	ls_memno			= lds_slipdata.object.member_no[ ll_index ]
	ls_memb_name        = lds_slipdata.object.memb_name[ ll_index ] 
	
	if isnull(ldc_itempay) then ldc_itempay = 0
	
	ls_accid		= string	( of_getattribmapaccid( as_coopid, "LON", "SHR" , ls_shrlontype, li_shareclc_status, "account_id" ) )
	//ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", "LON" , ls_shrloncode, li_shrlonclc_status, "accint_id" ) )
	//ls_accintarrid	= string	( of_getattribmapaccid( as_coopid, "LON", "LON" , ls_shrloncode, li_shrlonclc_status, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid(as_coopid,"LON", "SHR" , ls_shrlontype, li_shrlonclc_status, "sortacc_order"   ) )
	//ls_accid_clc	= string	( of_getattribmapaccid( as_coopid, "LON", "LON" , ls_shrloncode, li_shrlonclc_status, "account_id" ) )
	//ll_sortacc_clc	= long	( of_getattribmapaccid(as_coopid,"LON", "LON" , ls_shrloncode, li_shrlonclc_status, "sortacc_order"   ) )
	
	//สร้างเลขที่ Voucher

	 if ls_slipno_bf <> ls_slipno then
			ls_voucher_type	= "PV"
			ls_desc  		= "ถอนหุ้นเงินสด " + ls_memb_name	
			is_vcpaydocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_coopid  )
			this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcpay , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcpay.retrieve( is_vcpaydocno )
			ids_vcpaydet.retrieve( is_vcpaydocno )
	 end if 
	
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if
	
	//หาบัญชีเงินสด
	select  	cash_account_code
	into		:ls_acccash 
	from		accconstant 
	where 		coop_id = :as_coopid
	using    	 itr_sqlca   ;	
	
	//
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  ls_acccash then
		ls_tofromaccid		= 	ls_acccash
	end if
	
	
	//if ls_slipno_bf <> ls_slipno then
		//ls_itemdesc  = string( ll_index2 ) + '  รายการ'
		//ll_index2 = ll_index2 + 1
	//else
		//ll_index2	=	1
		//ls_itemdesc  =  string ( ll_index2 ) + '  รายการ'
		//ll_index2 = ll_index2 + 1
	//end if
//

//if isnull (ls_slipclr) or ls_slipclr = "" then //เช็คว่ามีหักกลบรึป่าว
	// รายการจ่ายเงิน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, "", ll_sortacc, ids_vcpaydet)
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then		
		this.of_additem( as_coopid , is_vcpaydocno ,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcpaydet  , as_userid )
	end if
	
//else
	/////////////////////////////////////ท่อนนี้ยิงลง PV/////////////////////////////////////////////////////
			//// รายการจ่ายเงิน
	//if(ls_slipno_bf <> ls_slipno) then
		//if ( ldc_itempay > 0 ) then
			//this.of_additemdesc( as_coopid ,  is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, ls_itemdesc, ll_sortacc, ids_vcpaydet)
		//end if
		//// รายการฝั่งตรงข้าม
		//if (ldc_itempay > 0) then
			//this.of_additem( as_coopid , is_vcpaydocno ,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcpaydet  , as_userid )
		//end if
	//end if
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////ท่อนนี้ยิงลง RV////////////////////////////////////////////////////
	//if 	( ldc_prinpay > 0 ) then	
		//this.of_additemdesc( as_coopid ,is_vcrcvdocno, "LON", "RCV", ls_accid_clc, ls_accrevside, ldc_prinpay, "", ll_sortacc_clc, ids_vcrcvdet)
		//this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accside, ldc_prinpay  , 1, ids_vcrcvdet  , as_userid )
	//end if
//
	//if ( ldc_int > 0 ) then
		//this.of_additemdesc( as_coopid ,  is_vcrcvdocno, "LON", "RCV", ls_accintid , ls_accrevside, ldc_int, "", ll_sortacc_clc, ids_vcrcvdet)
		//this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accside, ldc_int  , 1, ids_vcrcvdet  , as_userid )
	//end if
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
//end if
	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayout
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcpaydocno
		where		( payoutslip_no		= :ls_slipno ) and
						(memcoop_id		= :as_coopid) and
						(coop_id				= :ls_coopid)

		using     itr_sqlca   ;							
	end if
	
	ls_slipno_bf		= ls_slipno
	
next

destroy (lds_slipdata)

//update
if ids_vcpay.update() <> 1 then	
	return -1
end if
	
if ids_vcpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vctrnpayin (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการชำระหนี้  เงินโอน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string		ls_slipno, ls_refopeno, ls_accid, ls_accintid, ls_accintarrid, ls_vc_type , ls_cash , ls_slipno_bf
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string		ls_moneygrp, ls_shrlontype, ls_itemtype, ls_tofromaccid
string		ls_branchid,ls_mbbranch_id,ls_acccr_id,ls_accdr_id,ls_desc,ls_year,ls_vcdocno,ls_docno,ls_mbbranch_idold
integer	li_shrlonstatus, li_slipflag, li_seqno,li_flag
long		ll_index, ll_count, ll_sortacc, ll_sortint, ll_sortintarr, ll_index2
dec{2}	ldc_prinpay, ldc_intpay, ldc_itempay, ldc_intarrpay,ldc_fineamt, ldc_intarrear
string		ls_shrlontypeold,ls_document_no,ls_itemdesc,ls_maxdoc,ls_mindoc, ls_date, ls_month, ls_slipitem_desc
datetime	ldtm_operate
string		ls_vc_desc, ls_loangroup_code, ls_accid_bf, ls_vcrcvdocno_prnc, ls_accintid_bf
string		ls_vcrcvdocno_int , ls_vcrcvdocno_etc , ls_voucher_type , as_vcdocno , ls_coopid, ls_memgroup

datastore	lds_slipdata ,lds_countitem

// ds สำหรับเก็บการชำระหนี้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnlnrcv"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

// สร้างเลข Voucher
is_vcrcvtrndocno = ""

	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "รับค่าหุ้น + รับชำระหนี้จากสมาชิก"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	



ls_tmpvcgrp		= "PAY"
ls_accid_bf		= ''
ll_index2			=	1
// ชุดการรับชำระหนี้
for ll_index = 1 to ll_count
	
	ls_slipno				= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_document_no	= lds_slipdata.object.document_no[ ll_index ]
	ls_moneygrp		= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= lds_slipdata.object.bfcontlaw_status[ ll_index ]
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt[ ll_index ]
	ldc_intpay			= lds_slipdata.object.interest_payamt[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ls_slipitem_desc	= trim(lds_slipdata.object.slipitem_desc[ ll_index ])
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_memgroup		= lds_slipdata.object.membgroup_code[ ll_index ]
	ldc_intarrear		= lds_slipdata.object.intarrear_payamt[ ll_index ]
		
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_prinpay ) then ldc_prinpay = 0
	if isnull( li_shrlonstatus) then li_shrlonstatus = 1
	if isnull( ldc_intarrear ) then ldc_intarrear = 0
	
	// ด/บ จ่าย - ดอกเบี้ยคืน
	ldc_intpay = ldc_intpay - ldc_intarrear
	
	ls_accid			= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid( as_coopid ,"LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
		
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if

					
	if  ls_accid_bf = ls_accid then
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	else
		ll_index2	=	1
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	end if
	
		// hare_code เพื่อแยกประเภทหุ้นของสมาชิกปกติ กับ สมทบ by Mike 04/09/2013
	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'SHR' then
		ls_accid = "311101"  
	end if
		
		// เงินต้น
		if ( ldc_prinpay > 0 ) then				
			this.of_additem( as_coopid ,is_vcrcvtrndocno , "LON" , "TRN", ls_accid, ls_accside , ldc_prinpay, ll_sortacc, ids_vcrcvpaydet  , as_userid )
		end if
		
		// ดอกเบี้ย	
		if ( ldc_intpay > 0 ) then
			this.of_additem( as_coopid ,is_vcrcvtrndocno, "LON"  , "TRN", ls_accintid, ls_accside, ldc_intpay,ll_sortint, ids_vcrcvpaydet  , as_userid )
		end if
		//รายการชำระหักอื่น ๆ
		if ( ldc_itempay > 0 and  ldc_prinpay = 0 and ldc_intpay = 0 ) then
			this.of_additem( as_coopid , is_vcrcvtrndocno, "LON" , "TRN", ls_accid, ls_accside, ldc_itempay ,ll_sortint, ids_vcrcvpaydet  , as_userid )
		end if
		
			//รายการ ด/บ คืน
		if ( ldc_intarrear> 0) then
			this.of_additem( as_coopid , is_vcrcvtrndocno, "LON" , "TRN", ls_accintarrid, ls_accside, ldc_intarrear ,ll_sortintarr, ids_vcrcvpaydet  , as_userid )
		end if
		
		// รายการฝั่งตรงข้าม
		if	( ldc_itempay > 0  ) then
			this.of_additem( as_coopid ,is_vcrcvtrndocno , "LON" , "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvpaydet  , as_userid )
		end if
		

	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayin
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcrcvtrndocno
		where		( payinslip_no		= :ls_slipno ) and
						( memcoop_id		= :as_coopid  )
		using     itr_sqlca   ;							
	end if			

	ls_accid_bf		= ls_accid
	ls_accintid_bf	= ls_accintid
	ls_slipno_bf		= ls_slipno			
next

destroy( lds_slipdata )

if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vctrnpayout (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่ายเงินกู้+หักกลบ ราการโอน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/04/2016 by Sakuraii
</usage> 
***********************************************************/
string		ls_slipno, ls_accid, ls_accintid, ls_accintarrid  ,ls_slipno_bf
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_desc
string		ls_shrlontype, ls_sliptype, ls_itemtype, ls_tofromaccid
integer		li_shrlonstatus, li_slipflag,li_flag
long		ll_index, ll_count, ll_find, ll_sortacc, ll_index2
dec{2}		ldc_prinpay, ldc_intpay, ldc_intarrpay, ldc_itempay,ldc_intreturn
string		ls_accid_bf, ls_accid_clc, ls_itemdesc
dec{2}		ldc_int, ldc_total, ldc_shrpay
string		ls_voucher_type, ls_memno,ls_memb_name
string		ls_slipitem_desc, ls_coopid, ls_shrloncode, ls_slipclr, ls_slipitemtype_code, ls_accshr, ls_itemtypeshr,ls_accintreturn

datastore	lds_slipdata

// ds สำหรับดึงข้อมูลการจ่ายเงินกู้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnlnpay_split"
lds_slipdata.settransobject( itr_sqlca )

ll_count			= lds_slipdata.retrieve( adtm_vcdate , as_coopid   )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpvcgrp			= "PAY"
ls_accid_bf			= ""
ll_index2				=	1

 
for ll_index = 1 to ll_count
		
	ls_slipno				= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_shrlontype			= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus			= 1
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay				= lds_slipdata.object.payout_amt[ ll_index ]
	ls_sliptype				= lds_slipdata.object.sliptype_code [ ll_index ]
	ls_coopid				= lds_slipdata.object.coop_id [ ll_index ]
	ls_slipclr				= lds_slipdata.object.slipclear_no[ ll_index ]
	ls_slipitemtype_code	= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_shrloncode			= lds_slipdata.object.slslippayindet_shrlontype_code [ ll_index ]
	ldc_int					= lds_slipdata.object.interest_payamt [ ll_index ]
	ldc_prinpay				= lds_slipdata.object.principal_payamt [ ll_index ]
	ldc_total				= lds_slipdata.object.payoutnet_amt [ ll_index ]
	ldc_shrpay				= lds_slipdata.object.item_payamt [ ll_index ]
	ldc_intreturn			= lds_slipdata.object.returnetc_amt [ ll_index ] //ดบ.คืน
	ls_memno				= lds_slipdata.object.member_no[ ll_index ]
	ls_memb_name        = lds_slipdata.object.memb_name[ ll_index ] 

//	if isnull(ls_itemtype) or ls_itemtype = "" then ls_itemtype = 'LON'
	if isnull(ldc_prinpay) then ldc_prinpay = 0
	if isnull(ldc_itempay) then ldc_itempay = 0
	if isnull(ldc_int) then ldc_int = 0
	if isnull(ldc_total) then ldc_total = 0
	if isnull(ldc_intreturn) then ldc_intreturn = 0   
	if isnull(ls_shrloncode) then ls_shrloncode = '00'
	if ls_itemtype = 'INF'   then   ls_shrlontype = '00'
	
	
	//// สร้างเลข Voucher
	//is_vcrcvtrndocno = ""
	 if  ls_slipno	<> ls_slipno_bf  then
			ls_voucher_type	= "JV"
			ls_desc  				= "จ่ายเงินกู้แก่สมาชิก"	+ " "+ls_memno+" " + ls_memb_name	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	
	
	
	choose case ls_sliptype
		case  'LWD'	
			ls_itemtype		= 'LON'
		case  'SWD'	,'SWT','SWP'
			ls_itemtype		= 'SHR'
	end choose				
	
	ls_accid			= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid			= string	( of_getattribmapaccid(as_coopid, "LON", ls_itemtype , ls_shrloncode, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid		= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrloncode, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc			= long	( of_getattribmapaccid(as_coopid,"LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ls_accid_clc		= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrloncode, li_shrlonstatus, "account_id" ) )
	ls_accintreturn		= string	( of_getattribmapaccid(as_coopid, "LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	
	if trim(ls_slipitemtype_code) = 'LON' then 
				
	else
		choose case ls_slipitemtype_code
				
			case  'SHR' //ค่าหุ้น
				ls_itemtypeshr		= 'SHR'
				ls_shrlontype	= '01'
				ls_accshr = string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtypeshr , ls_shrlontype, li_shrlonstatus, "account_id" ))
				
					if ls_coopid = '034001' then
						// hare_code เพื่อแยกประเภทหุ้นของสมาชิกปกติ กับ สมทบ by Mike 04/09/2013
						if(left(ls_memno,3) = '00S' ) and ls_itemtypeshr = 'SHR' then
							ls_accshr = string( of_getattribmapaccid( as_coopid, "LON", "SHR" , "S1", 1, "account_id" ) )  
						end if
					end if
				
				
			case  'INF' //ค่าดอกเบี้ยล่วงหน้า
				ls_itemtypeshr		= trim(ls_slipitemtype_code)
				ls_accshr = string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtypeshr , ls_shrlontype, li_shrlonstatus, "account_id" ) )
			case else
				ls_itemtypeshr		= trim(ls_slipitemtype_code)
				ls_shrlontype	= '00'
				ls_accshr = string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtypeshr , ls_shrlontype, li_shrlonstatus, "account_id" ) )
			
		end choose
	end if
	
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if			
	
		
	//if  ls_accid_bf = ls_accid then
		//ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		//ll_index2 = ll_index2 + 1
	//else
		//ll_index2	=	1
		//ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		//ll_index2 = ll_index2 + 1
	//end if
	
	if isnull (ls_slipclr) or ls_slipclr = "" then //เช็คว่ามีหักกลบรึป่าว
	// รายการจ่ายเงิน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, ls_itemdesc, ll_sortacc, ids_vcrcvpaydet)
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then		
		this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	
	else
	
	// รายการจ่ายเงิน
	if(ls_slipno_bf <> ls_slipno) then
		if ( ldc_itempay > 0 ) then
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, ls_itemdesc, ll_sortacc, ids_vcrcvpaydet)
		end if
	//ดอกเบี้ยคืน
	if ( ldc_intreturn > 0 ) then
	this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accintreturn  , ls_accside, ldc_intreturn, ls_itemdesc, ll_sortacc, ids_vcrcvpaydet)
	end if
		
		if (ldc_total > 0) then
			this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_total  , 1, ids_vcrcvpaydet  , as_userid )
		end if
	end if
		choose case ls_slipitemtype_code
			case 'SHR'
		if (ldc_shrpay > 0) then //ยอดซื้อหุ้น
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accshr , ls_accrevside, ldc_shrpay, "", ll_sortacc, ids_vcrcvpaydet)
		end if

			case 'LON'
		// รายการฝั่งตรงข้าม
		if 	( ldc_itempay > 0 ) then	
			this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_accid_clc , ls_accrevside, ldc_prinpay  , 1, ids_vcrcvpaydet  , as_userid )
		end if
	
		if ( ldc_int > 0 ) then
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accintid , ls_accrevside, ldc_int, "", ll_sortacc, ids_vcrcvpaydet)
		end if
			case 'INF'//ดอกเบี้ยล่วงหน้า
		if 	( ldc_shrpay > 0 ) then	
			this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_accintid , ls_accrevside, ldc_shrpay  , 1, ids_vcrcvpaydet  , as_userid )
		end if
			case else
		if (ldc_shrpay > 0) then //ยอดค่าธรรมเนียม
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accshr , ls_accrevside, ldc_shrpay, "", ll_sortacc, ids_vcrcvpaydet)
		end if		
			end choose
//end if
end if
	
			
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayout
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcrcvtrndocno
		where		( payoutslip_no		= :ls_slipno ) and
						( memcoop_id		= :as_coopid )
		using     itr_sqlca   ;							
	end if
	
	ls_accid_bf		= ls_accid
	ls_slipno_bf		= ls_slipno
	
next

destroy( lds_slipdata )
//update
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if


return 1
end function

private function integer of_vctrndppay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> ถอน + ปิดบัญชี แยกดอกเบี้ย เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_colsort, ls_month, ls_date
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp, ls_feeid
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			s_acccr_id,ls_accdr_id,ls_branchid,ls_branchorigin,ls_desc,ls_oldbranchid,ls_cash
integer		li_slipflag,ll_find,li_flag, li_payfee_meth
long			ll_index, ll_count, ll_sortacc, ll_sortintarr, ll_index2
dec{2}		ldc_itempay, ldc_intarrpay,ldc_prncbal,ldc_int_amt,ldc_accuint_amt, ldc_intreturn, ldc_slipnetamt
string			ls_deptgroupcode, ls_itemgroup, ls_accid_bf, ls_depttype_code, ls_vc_desc, ls_itemdesc  
string			ls_depttype_group, ls_refsystem, ls_depttype_group_temp, ls_voucher_type , ls_vc_type , as_vcdocno
dec{2}		ldc_other_amt, ldc_intbfyear , ldc_itempaynet, ldc_tax_return, ldc_tax, ldc_orther
datetime		ldtm_operate
string			ls_accid_old, ls_acccash, ls_depttype_bf, ls_itemtype_bf, ls_accint, ls_acctax

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_trndppay"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem					= "DEP"
ls_tmpvcgrp						= "DAY"
ls_depttype_group_temp		= ""
ls_accid_bf 						= ""
ll_index2							=	1
is_vcrcvtrndocno				= ""
//สร้างเลข Voucher
	 if  is_vcrcvtrndocno = ""   then
			ls_voucher_type	= "JV"	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , "รายการถอนเงินประจำวัน", 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
	else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

for ll_index = 1 to ll_count

	ls_slipno					= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_itemtype				= lds_slipdata.object.recppaytype_code[ ll_index ]
	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_mapacc				= lds_slipdata.object.accmap_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_amt[ ll_index ]
	ldc_int_amt				= lds_slipdata.object.int_amt[ ll_index ]	
	ldc_accuint_amt		= lds_slipdata.object.accuint_amt[ ll_index ]
	ldc_intreturn			= lds_slipdata.object.int_return[ ll_index ]
	ls_deptgroupcode		= lds_slipdata.object.deptgroup_code[ ll_index ]
	ls_itemgroup			= lds_slipdata.object.group_itemtpe[ ll_index ]
	ldc_itempaynet			= lds_slipdata.object.deptslip_netamt[ ll_index ]
	ldc_other_amt			= lds_slipdata.object.other_amt[ ll_index ] ; 
	li_payfee_meth			= lds_slipdata.object.payfee_meth[ ll_index ] ; 
	ldc_intbfyear			= lds_slipdata.object.int_bfyear[ ll_index ]
	ls_desc					= trim(lds_slipdata.object.compute_3[ ll_index ])
	ldc_tax_return			= lds_slipdata.object.tax_return[ ll_index ]
	ldc_tax					= lds_slipdata.object.tax_amt[ ll_index ]	
	ldc_orther				=  lds_slipdata.object.other_amt[ ll_index ]  //ค่าปรับเงินฝาก
	
//	if isnull (ls_tofromaccid)  then ls_tofromaccid = '000000'	
	if isnull( ldc_orther ) then ldc_orther = 0
	if isnull( li_payfee_meth ) then li_payfee_meth = 0
	if isnull( ldc_int_amt ) then ldc_int_amt = 0
	if isnull( ldc_accuint_amt ) then ldc_accuint_amt = 0
	if isnull( ldc_intreturn ) then ldc_intreturn = 0
	if isnull(ldc_intbfyear) then ldc_intbfyear = 0
		
	choose case ls_mapacc
		case "AIT"
			ls_accintarrid	= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
			ll_sortintarr		= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, "sortintarr_order" ) )
			ldc_itempay		= ldc_itempay 
			ls_colname		= "accint_id"
			ls_colsort		= "sortint_order"
		case "ATX"
			ls_colname		= "acctax_id"
			ls_colsort		= "sorttax_order"
			ldc_intbfyear	= 0.00
		case else
			ls_colname		= "account_id"
			ls_colsort		= "sortacc_order"
			ldc_intbfyear	= 0.00
	end choose
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, ls_colname  ) )
	ls_accint				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "accint_id"  ) )
	ls_accintarrid		= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
	ls_acctax				= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "acctax_id"  ) )
	ll_sortacc			= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, ls_colsort  ) )		
	ls_feeid				= string( of_getattribmapaccid( as_coopid ,"DEP", "FEE", "00", 1,  "account_id"  ) ) //ค่าปรับ
	
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	
//	choose case ls_itemtype
//		case "FEE"
//			ls_accid = '4200300'
//			ls_accside		= "CR"
//			ls_accrevside	= "DR"	
//		case "WFS"
//			ls_accid = '3100100'
//			ls_accside		= "CR"
//			ls_accrevside	= "DR"
//		case else
//			ls_accid = ls_accid
//	end choose
		

	//รายการถอน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_int_amt > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accint, ls_accside, ldc_int_amt, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_tax_return > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_acctax, ls_accside, ldc_tax_return, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempaynet > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_itempaynet  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	if 	( ldc_intreturn > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_accintarrid , ls_accrevside, ldc_intreturn  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	if 	( ldc_tax > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_acctax , ls_accrevside, ldc_tax  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	if( ldc_orther > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_feeid , ls_accrevside, ldc_orther  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcrcvtrndocno)    	then
		update	dpdeptslip
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( deptslip_no	= :ls_slipno ) and
					( coop_id 		= :as_coopid)
		using itr_sqlca;
	end if
	
	ls_accid_bf 				= ls_accid
	ls_depttype_bf			= ls_depttype
	ls_itemtype_bf			= ls_itemtype
		
next

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vctrndprcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> ฝาก + เปิดบัญชี เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string			ls_slipno, ls_mapacc, ls_accid, ls_accintarrid, ls_colname, ls_colsort, ls_date, ls_month
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_branchid,ls_branchorigin,ls_acccr_id,ls_accdr_id,ls_desc,ls_oldbranchid
integer		li_slipflag,ll_seqno,ll_find,li_flag
long			ll_index, ll_count, ll_sortacc, ll_sortintarr
dec{2}		ldc_itempay, ldc_intarrpay
datetime		ldtm_operate
string			ls_depttype_group, ls_vcrcvdocno, ls_cash, ls_depttype_code, ls_vc_desc, ls_voucher_type
string			ls_accid_bf, ls_refsystem, ls_depttype_group_temp , as_vcdocno , ls_itemdesc
string			ls_coopid , ls_deptcoopid, ls_acccash, ls_depttype_bf, ls_itemtype_bf, ls_recppay

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trndprcv"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem		= "DEP"
ls_tmpvcgrp			= "DAY"
ls_accid_bf 			= ""
is_vcrcvtrndocno	= ""

	 if  is_vcrcvtrndocno = ""  then
			ls_voucher_type	= "JV"	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , "รายการฝากเงินประจำวัน", 0 , ids_vcrcvpay , 'TRN'  , as_coopid,   as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 


for ll_index = 1 to ll_count
	
	ls_coopid					= lds_slipdata.object.coop_id[ ll_index ]
	ls_deptcoopid			= lds_slipdata.object.deptcoop_id[ ll_index ]
	ls_slipno					= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_itemtype				= lds_slipdata.object.recppaytype_code[ ll_index ]
	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_mapacc				= lds_slipdata.object.accmap_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_netamt[ ll_index ]
	ls_desc					= trim(lds_slipdata.object.compute_3[ ll_index ])
	ls_recppay				= lds_slipdata.object.recppaytype_code[ ll_index ]  
		
//	if isnull (ls_tofromaccid)  then ls_tofromaccid = '000000'	

	// ตรวจว่าเป็นรายการเกี่ยวกับอะไร
choose case ls_mapacc
		case "AIT"
			ls_accintarrid	= string( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
			ll_sortintarr		= long( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "sortintarr_order" ) )
			ldc_itempay		= ldc_itempay 
			ls_colname		= "accint_id"
			ls_colsort		= "sortint_order"
		case "ATX"
			ls_colname		= "acctax_id"
			ls_colsort		= "sorttax_order"
		case else
			ls_colname		= "account_id"
			ls_colsort		= "sortacc_order"			
	end choose
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, ls_colname  ) )
	ll_sortacc			= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, ls_colsort  ) )	
	
	if( trim(ls_recppay) = 'INT' ) then  //ทำเงื่อนไขเพื่อให้รายการพวกที่เป็นรายการถอนดอกเบี้ยมาเข้าเงินฝากลงให้ถูกฝั่ง DR CR  //Edit by Mike 03/04/2014
		ls_accside			= "DR"
		ls_accrevside		= "CR"
	else
		ls_accside			= "CR"
		ls_accrevside		= "DR"	
	end if
	
					
	// รายการเงินฝาก
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, "", ll_sortacc, ids_vcrcvpaydet)
	end if
	
	/// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
		this.of_additem( as_coopid ,is_vcrcvtrndocno,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	
	//update สถานะการดึงข้อมูล
	if	not isnull(is_vcrcvtrndocno)    	then
		update	dpdeptslip
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( deptslip_no	= :ls_slipno ) and
					( coop_id 		= :as_coopid)
		using itr_sqlca;
	end if
	
	ls_accid_bf 						= ls_accid
	ls_depttype_group_temp		= ls_depttype_group
	ls_depttype_bf					= ls_depttype
	ls_itemtype_bf					= ls_itemtype
	
next

destroy( lds_slipdata )

//update
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if
	
return 1
end function

private function integer of_vctrnshrrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการชำระหนี้  เงินโอน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string		ls_slipno, ls_accid, ls_accintid, ls_accintarrid, ls_slipno_bf
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_desc
string		ls_shrlontype, ls_itemtype, ls_tofromaccid
integer		li_shrlonstatus, li_slipflag, li_flag
long		ll_index, ll_count, ll_sortacc, ll_index2
dec{2}		ldc_prinpay, ldc_intpay, ldc_itempay, ldc_intarrpay
string		ls_itemdesc,  ls_slipitem_desc
string		ls_vc_desc, ls_loangroup_code, ls_accid_bf, ls_accintid_bf
string		ls_voucher_type  , ls_coopid

datastore	lds_slipdata ,lds_countitem

// ds สำหรับเก็บการชำระหนี้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnshrrcv"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

// สร้างเลข Voucher
is_vcrcvtrndocno = ""

 
	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "โอนภายในซื้อหุ้น"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	



ls_tmpvcgrp		= "PAY"
ls_accid_bf		= ''
ll_index2			=	1
// ชุดการรับชำระหนี้
for ll_index = 1 to ll_count
	
	ls_slipno			= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= 1
	li_slipflag			= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt[ ll_index ]
	ldc_intpay			= lds_slipdata.object.interest_payamt[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ls_slipitem_desc	= trim(lds_slipdata.object.slipitem_desc[ ll_index ])
	ls_coopid			= lds_slipdata.object.coop_id[ ll_index ]
		
	if isnull( ldc_prinpay ) then ldc_prinpay = 0
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_itempay ) then ldc_itempay = 0

	
	ls_accid			= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )

		
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if

					
	if  ls_accid_bf = ls_accid then
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	else
		ll_index2	=	1
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	end if	
	
		
		//รายการชำระหักอื่น ๆ
		if	( ldc_itempay > 0  ) then
			this.of_additem( as_coopid , is_vcrcvtrndocno, "LON" , "TRN", ls_accid, ls_accside, ldc_itempay ,1, ids_vcrcvpaydet  , as_userid )
		end if
		
		// รายการฝั่งตรงข้าม
		if	( ldc_itempay > 0  ) then
			this.of_additemdesc( as_coopid ,is_vcrcvtrndocno , "LON" , "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay , "ซื้อหุ้น"  , 1, ids_vcrcvpaydet )
		end if
		

	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayin
		set			posttovc_flag		= 1,	
					voucher_no			= :is_vcrcvtrndocno
		where		( payinslip_no		= :ls_slipno ) and
					( memcoop_id		= :as_coopid  )
		using		itr_sqlca   ;							
	end if			

	ls_accid_bf		= ls_accid
	ls_accintid_bf	= ls_accintid
	ls_slipno_bf	= ls_slipno			
next

destroy( lds_slipdata )

if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vctrnshrpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการถอนหุ้นลาออก เงินโอน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/04/2016 by Sakuraii
</usage> 
***********************************************************/
string		ls_slipno, ls_accid, ls_accintid, ls_accintarrid  ,ls_slipno_bf
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_desc
string		ls_shrlontype, ls_sliptype, ls_itemtype, ls_tofromaccid
integer		li_shrlonstatus, li_slipflag,li_bfcontlaw
long		ll_index, ll_count, ll_sortacc
dec{2}		ldc_prinpay, ldc_intpay, ldc_intarrpay, ldc_itempay
string		ls_vc_desc, ls_itemdesc, ls_voucher_type
dec{2}		ldc_total, ldc_int
string		ls_coopid, ls_slipclr, ls_accid_clc, ls_shrloncode, ls_memno

datastore	lds_slipdata

// ds สำหรับดึงข้อมูลการจ่ายเงินกู้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnshrpay"
lds_slipdata.settransobject( itr_sqlca )

ll_count			= lds_slipdata.retrieve( adtm_vcdate , as_coopid   )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if
ls_tmpsystem		= "SHR"
ls_tmpvcgrp			= "PAY"
is_vcrcvtrndocno	= ""

	//สร้าง voucher
		 if is_vcrcvtrndocno = ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "จ่ายหุ้นคืนสมาชิก"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	
	 
for ll_index = 1 to ll_count 
		
	ls_slipno			= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= lds_slipdata.object.bfshare_status[ ll_index ]
	li_slipflag			= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.payout_amt[ ll_index ]
	ls_sliptype			= lds_slipdata.object.sliptype_code [ ll_index ]
	ldc_int				= lds_slipdata.object.interest_payamt [ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt [ ll_index ]
	ls_shrloncode		= lds_slipdata.object.slslippayindet_shrlontype_code [ ll_index ]
	ldc_total			= lds_slipdata.object.payoutnet_amt [ ll_index ]
	ls_coopid			= lds_slipdata.object.coop_id [ ll_index ]
	ls_slipclr			= lds_slipdata.object.slipclear_no[ ll_index ]
	li_bfcontlaw		= lds_slipdata.object.bfcontlaw_status[ ll_index ]
	ls_memno			= lds_slipdata.object.member_no[ ll_index ]
	
	if isnull(ldc_total) then ldc_total = 0
	if isnull(ldc_int) then ldc_int = 0
	if isnull(ldc_prinpay) then ldc_prinpay = 0
	if isnull(ldc_itempay) then ldc_itempay = 0
	if isnull(li_bfcontlaw) or li_bfcontlaw = 0  then li_bfcontlaw = 1
	
	ls_accid			= string	( of_getattribmapaccid( as_coopid, "LON", "SHR" , ls_shrlontype, li_shrlonstatus, "account_id" ) )
     ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", "LON" , ls_shrloncode, li_bfcontlaw, "accint_id" ) )
	ls_accintarrid		= string	( of_getattribmapaccid( as_coopid, "LON", "LON" , ls_shrloncode, li_bfcontlaw, "accintarr_id"  ) )
	ll_sortacc			= long	( of_getattribmapaccid(as_coopid,"LON", "SHR" , ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ls_accid_clc		= string	( of_getattribmapaccid( as_coopid, "LON", "LON" , ls_shrloncode, li_bfcontlaw, "account_id" ) )
	
	
	if ls_coopid = '034001' then
			// hare_code เพื่อแยกประเภทหุ้นของสมาชิกปกติ กับ สมทบ by Mike 04/09/2013
		if(left(ls_memno,3) = 'S' ) and ls_itemtype = 'SHR' then
			ls_accid = string( of_getattribmapaccid( as_coopid, "LON", "SHR" , "S1", 1, "account_id" ) )  
		end if
	end if


	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if


if isnull (ls_slipclr) or ls_slipclr = "" then //เช็คว่ามีหักกลบรึป่าว
	// รายการจ่ายเงิน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, "", ll_sortacc, ids_vcrcvpaydet)
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then		
		this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	
else
	
			// รายการจ่ายเงิน
	if(ls_slipno_bf <> ls_slipno) then
		if ( ldc_itempay > 0 ) then
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, "", ll_sortacc, ids_vcrcvpaydet)
		end if
		// รายการฝั่งตรงข้าม
		if (ldc_total > 0) then
			this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_total  , 1, ids_vcrcvpaydet  , as_userid )
		end if
	end if
	if 	( ldc_itempay > 0 ) then	
		this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_accid_clc , ls_accrevside, ldc_prinpay  , 1, ids_vcrcvpaydet  , as_userid )
	end if

	if ( ldc_int > 0 ) then
		this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accintid , ls_accrevside, ldc_int, "", ll_sortacc, ids_vcrcvpaydet)
	end if
	
end if
	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayout
		set			posttovc_flag		= 1,	
					voucher_no			= :is_vcrcvtrndocno
		where		( payoutslip_no		= :ls_slipno ) and
					(memcoop_id		= :as_coopid) and
					(coop_id				= :ls_coopid)

		using     itr_sqlca   ;							
	end if
	
	ls_slipno_bf		= ls_slipno
	
next

destroy (lds_slipdata)

//update
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vctrnfinrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการรับการเงิน เงินโอน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string		ls_slipno, ls_slipprior, ls_mapacc, ls_accid
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string		ls_itemtype, ls_tofromaccid, ls_itemdesc,ls_detail
long		ll_index, ll_count, ll_index2
dec{2}		ldc_itempay
string		ls_slipitem_desc, ls_accid_bf
string		ls_desc, ls_voucher_type , ls_cash, ls_coopid

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnfnrcv_split"
lds_slipdata.settransobject( itr_sqlca )

// retrieve 
ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if


ls_tmpsystem		= "FIN"
ls_tmpvcgrp			= "DAY"
ls_accid_bf			= ""
ll_index2				=	1
is_vcrcvtrndocno	= ""



for ll_index = 1 to ll_count
	ls_slipno				= trim( lds_slipdata.object.slip_no[ ll_index ] )
	ldc_itempay				= lds_slipdata.object.itempay_amt[ ll_index ]	
	ls_accid				= lds_slipdata.object.account_id[ ll_index ]
	ls_itemdesc				= trim( lds_slipdata.object.slipitem_desc[ ll_index ] )
	ls_tofromaccid			= trim( lds_slipdata.object.tofrom_accid[ ll_index ] )
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_detail				= trim( lds_slipdata.object.nonmember_detail[ ll_index ] )
	
	// สร้างเลข Voucher
	 if  ls_slipno	<> ls_slipprior  then
			ls_voucher_type	= "JV"
			ls_desc  				= "รายการโอน(การเงินรับ)"+" " +ls_detail		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	
	
	ls_accside			= "CR"
	ls_accrevside		= "DR"
	
	//if  ls_accid_bf = ls_accid then
		//ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		//ll_index2 = ll_index2 + 1
	//else
		//ll_index2	=	1
		//ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		//ll_index2 = ll_index2 + 1
	//end if
			
	// รายการการเงิน
	if ( ldc_itempay > 0 ) then		
		this.of_additemdesc(  as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay , ls_itemdesc , 55555, ids_vcrcvpaydet )
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid , ls_accrevside, ldc_itempay , ls_itemdesc , 55555, ids_vcrcvpaydet )
	end if

	// Update สถานะการผ่าน Voucher
	if ls_slipno <> ls_slipprior then
		update	finslipdet
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( slip_no			= :ls_slipno ) and
					( coop_id			= :ls_coopid ) 
		using     itr_sqlca   ;
		
		ls_slipprior	= ls_slipno
	end if
	
	ls_accid_bf	= ls_accid
	
next

destroy( lds_slipdata )
//update
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vctrnfinpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่ายการเงิน เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_slipprior, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_vc_type,ls_taxid
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp ,ls_slipitem_desc
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_branchid,ls_accmaster_branch_id,ls_acccr_id,ls_accdr_id,ls_oldbranchid,ls_desc,ls_vcbrdocno
integer		li_slipflag,ll_seqno
long			ll_index, ll_count,ll_find, ll_index2
dec{2}		ldc_itempay,ldc_tax_amt,ldc_itembal, ldc_itemamtnet,ldc_tax_det
string			ls_slipitemtype_code,ls_vcrcvno,ls_acctaxid,ls_cashcode ,ls_account_id 
string			ls_accid_bf, ls_vcrcvdocno_tax , ls_itemdesc , ls_cash, ls_coopid , ls_detail
string			ls_finno, ls_finno_temp, ls_tofromaccid_bf, ls_voucher_type , as_vcdocno

n_ds			lds_vcpay, lds_vcpaydet, lds_vcpaydetail
datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnfnpay_split_cloud"
lds_slipdata.settransobject( itr_sqlca )
 
ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

//ls_desc	= "จ่ายเงิน"
ls_tmpsystem		= "FIN"
ls_tmpvcgrp			= "DAY"
ls_accid_bf			= ""
ls_vcrcvdocno_tax	= ""
ls_finno_temp		= ""
ll_index2				=	1




for ll_index = 1 to ll_count
	ls_slipno					= lds_slipdata.object.slip_no[ ll_index ]
	ldc_itempay				= lds_slipdata.object.itempay_amt[ ll_index ]	
	ls_accid					= lds_slipdata.object.account_id[ ll_index ]
	ls_slipitem_desc		= trim( lds_slipdata.object.slipitem_desc[ ll_index ] )
	ls_tofromaccid			= trim( lds_slipdata.object.tofrom_accid[ ll_index ] )
	ls_finno					= trim( ls_slipno )	
	ldc_tax_amt				= lds_slipdata.object.tax_amt[ ll_index ]
	ldc_itemamtnet			= lds_slipdata.object.itempayamt_net[ ll_index ]
	ls_coopid					= lds_slipdata.object.coop_id[ ll_index ]
	ls_detail					=  trim(lds_slipdata.object.nonmember_detail[ ll_index ])
	ldc_tax_det				= lds_slipdata.object.tax_det[ ll_index ]   // ใช้ tax จาก finslipdet เพราะมี detail หลายแถว
	
	if isnull( ldc_tax_amt ) then ldc_tax_amt = 0
	if isnull( ldc_tax_det ) then ldc_tax_det = 0
	ls_taxid	= string( of_getattribmapaccid( as_coopid ,"FIN", "TAX", "01", 1, "account_id"  ) )
	
	ls_accside		= "DR"
	ls_accrevside	= "CR"			

	// สร้างเลข Voucher
	//is_vcrcvtrndocno = ""

	 if  ls_slipno	<> ls_slipprior then
			ls_voucher_type	= "JV"
			ls_desc  				= "รายการโอน(การเงินจ่าย)"+" "+	ls_detail	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

	//if  ls_accid_bf = ls_accid then
		//ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		//ll_index2 = ll_index2 + 1
	//else
		//ll_index2	=	1
		//ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		//ll_index2 = ll_index2 + 1
	//end if
	
	//รายการการเงิน
if (ldc_tax_det > 0) then
	if ( ldc_itempay > 0 ) then
		ldc_itempay = ldc_itemamtnet + ldc_tax_det
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_itemdesc, 77777, ids_vcrcvpaydet )
		this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid, ls_accrevside, ldc_itemamtnet, ls_itemdesc, 77777, ids_vcrcvpaydet)
		this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_taxid, ls_accrevside, ldc_tax_det, ls_itemdesc, 77777, ids_vcrcvpaydet)
	end if
else
	if ( ldc_itemamtnet > 0 ) then
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_itemdesc, 77777, ids_vcrcvpaydet )
		this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid, ls_accrevside, ldc_itempay, ls_itemdesc, 77777, ids_vcrcvpaydet)
	end if
end if
		
	//update สถานะการดึงข้อมูล
	if ls_slipno <> ls_slipprior then
		update	finslipdet
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( slip_no			= :ls_slipno ) and
					( coop_id			= :ls_coopid )
		using    	 itr_sqlca   ;	
		
		ls_slipprior	= ls_slipno
	end if
	
	ls_accid_bf	= ls_accid
	ls_finno_temp	= ls_finno
	ls_tofromaccid_bf	= ls_tofromaccid
next

destroy( lds_slipdata )
// update Vc
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then	
	return -1
end if
	
if ids_voucherdet.update() <> 1 then	
	return -1
end if

return 1
end function

private function integer of_vctrnpayout_atm (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่าย เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string		ls_slipno, ls_refopeno, ls_accid, ls_accintid, ls_accintarrid , ls_cash ,ls_slipno_bf,ls_taxid
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string		ls_moneygrp, ls_shrlontype, ls_sliptype, ls_itemtype, ls_tofromaccid
string		ls_shrcvno[]
string		ls_branchid,ls_mbbranch_id,ls_acccr_id,ls_accdr_id,ls_desc,ls_year,ls_vcdocno,ls_docno,ls_mbbranch_idold
integer	li_shrlonstatus, li_slipflag, li_seqno,li_flag, li_addflag, li_clear_flag
long		ll_index, ll_count, ll_sindex, ll_scount, ll_find, ll_sortacc, ll_sortint, ll_sortintarr, ll_index2
dec{2}	ldc_prinpay, ldc_intpay, ldc_intarrpay, ldc_itempay, ldc_loanrcv, ldc_loanfine
dec{2}	ldc_loanrcvnet, ldc_clcfee, ldc_sharebuy, ldc_wrtfund_amt
datetime	ldtm_operate
string		ls_month, ls_date, ls_tofromaccid_bf, ls_accid_bf, ls_accintid_bf, ls_loangroup_code, ls_accid_clc
string		ls_vc_desc, ls_vcdocno_prnc, ls_itemdesc, ls_vcdocno_int, ls_vcdocno_etc, ls_payoutno
string		ls_loantype_pay, ls_loantype_rcv, ls_sliplwd_no, ls_slipclc_no
string		ls_vccash_tran_01, ls_vccash_tran_02, ls_vccash_tran_03, ls_vccash_01, ls_vccash_02, ls_vccash_03
string		ls_laonrcv_temp, ls_laonrcv_current, ls_receiptno , ls_document_no  ,  as_vcdocno
dec{2}	ldc_clcprnc, ldc_clcint, ldc_fineall, ldc_feeall,  ldc_int, ldc_total, ldc_shrpay
string		ls_tran01, ls_tran02, ls_tran03, ls_tran2, ls_tran3, ls_tran4, ls_vccash_tran2, ls_vccash_tran3, ls_vc_type , ls_voucher_type
string		ls_slipitem_desc, ls_coopid, ls_shrloncode, ls_loangroup, ls_slipclr, ls_memgroup, ls_slipitemtype_code, ls_accshr, ls_itemtypeshr

datastore	lds_slipdata

// ds สำหรับดึงข้อมูลการจ่ายเงินกู้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnlnpay_atm"
lds_slipdata.settransobject( itr_sqlca )

ll_count			= lds_slipdata.retrieve( adtm_vcdate , as_coopid   )
is_vcrcvtrndocno = ""
// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpvcgrp			= "PAY"
ls_tofromaccid_bf	= ""
ls_accid_bf			= ""
ls_accintid_bf		= ""
ls_laonrcv_temp	= ""
ll_index2				=	1
//// สร้างเลข Voucher
is_vcrcvtrndocno = ""
	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "จ่ายเงินกู้แก่สมาชิก(ตู้ ATM)"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

//end if		

//
for ll_index = 1 to ll_count
		
	ls_slipno				= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_document_no	= lds_slipdata.object.document_no[ ll_index ]
	ls_moneygrp		= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= 1
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.payout_amt[ ll_index ]
	ls_sliptype			= lds_slipdata.object.sliptype_code [ ll_index ]
	ls_coopid				= lds_slipdata.object.coop_id [ ll_index ]
	ls_loangroup		= lds_slipdata.object.loangroup_code[ ll_index ]
	ls_slipclr				= lds_slipdata.object.slipclear_no[ ll_index ]
	ls_memgroup		= lds_slipdata.object.membgroup_code[ ll_index ]
	ls_slipitemtype_code			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_shrloncode		= lds_slipdata.object.slslippayindet_shrlontype_code [ ll_index ]
	ldc_int				= lds_slipdata.object.interest_payamt [ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt [ ll_index ]
	ldc_total				= lds_slipdata.object.payoutnet_amt [ ll_index ]
	ldc_shrpay			= lds_slipdata.object.item_payamt [ ll_index ]


//	if isnull(ls_itemtype) or ls_itemtype = "" then ls_itemtype = 'LON'
	if isnull(ldc_prinpay) then ldc_prinpay = 0
	if isnull(ldc_itempay) then ldc_itempay = 0
	if isnull(ldc_int) then ldc_int = 0
	if isnull(ldc_total) then ldc_total = 0
	if isnull(ls_shrloncode) or  ls_shrloncode = '' then ls_shrloncode = '88'

	
	choose case ls_sliptype
		case  'LWD'	
			ls_itemtype		= 'LON'
		case  'SWD'	,'SWT','SWP'
			ls_itemtype		= 'SHR'
	end choose				
	
	ls_accid			= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid(as_coopid,"LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid(as_coopid, "LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid( as_coopid,"LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
	ls_accid_clc		= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrloncode, li_shrlonstatus, "account_id" ) )
	ls_taxid				= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "acctax_id" ) )
	
	if trim(ls_tofromaccid) = '12345678' then  ls_tofromaccid = ls_taxid
	
	
	if trim(ls_slipitemtype_code) = 'LON' then 
				
	else
		choose case ls_slipitemtype_code
				
			case  'SHR' //ค่าหุ้น
				ls_itemtypeshr		= 'SHR'
				ls_shrlontype	= '01'
				ls_accshr = string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtypeshr , ls_shrlontype, li_shrlonstatus, "account_id" ) )
			case else
				ls_itemtypeshr		= trim(ls_slipitemtype_code)
				ls_shrlontype	= '00'
				ls_accshr = string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtypeshr , ls_shrlontype, li_shrlonstatus, "account_id" ) )
			
		end choose
	end if
	
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if			
	
			// hare_code เพื่อแยกประเภทหุ้นของสมาชิกปกติ กับ สมทบ by Mike 04/09/2013
	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'SHR' then
		ls_accid = "311101"  
	end if
		
	if  ls_accid_bf = ls_accid then
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	else
		ll_index2	=	1
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	end if
	
	if isnull (ls_slipclr) or ls_slipclr = "" then //เช็คว่ามีหักกลบรึป่าว
	// รายการจ่ายเงิน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, ls_itemdesc, ll_sortacc, ids_vcrcvpaydet)
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then		
		this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	
	else
	
	// รายการจ่ายเงิน
	if(ls_slipno_bf <> ls_slipno) then
		if ( ldc_itempay > 0 ) then
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, ls_itemdesc, ll_sortacc, ids_vcrcvpaydet)
		end if
		if (ldc_total > 0) then
			this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_total  , 1, ids_vcrcvpaydet  , as_userid )
		end if
	end if
		choose case ls_slipitemtype_code
			case 'SHR'
		if (ldc_shrpay > 0) then //ยอดซื้อหุ้น
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accshr , ls_accrevside, ldc_shrpay, "", ll_sortacc, ids_vcrcvpaydet)
		end if

			case 'LON'
		// รายการฝั่งตรงข้าม
		if 	( ldc_itempay > 0 ) then	
			this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_accid_clc , ls_accrevside, ldc_prinpay  , 1, ids_vcrcvpaydet  , as_userid )
		end if
	
		if ( ldc_int > 0 ) then
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accintid , ls_accrevside, ldc_int, "", ll_sortacc, ids_vcrcvpaydet)
		end if
	
			case else
		if (ldc_shrpay > 0) then //ยอดค่าธรรมเนียม
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accshr , ls_accrevside, ldc_shrpay, "", ll_sortacc, ids_vcrcvpaydet)
		end if		
			end choose
//end if
end if
	
			
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayout
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcrcvtrndocno
		where		( payoutslip_no		= :ls_slipno ) and
						( memcoop_id		= :as_coopid )
		using     itr_sqlca   ;							
	end if
	
	ls_accid_bf		= ls_accid
	ls_accintid_bf	= ls_accintid
	ls_slipno_bf		= ls_slipno
	
next

destroy( lds_slipdata )
//update
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if


return 1
end function

private function integer of_vctrn_kpmonth (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการเรียกเก็บประจำเดือน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_slipprior, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_vc_type
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp ,ls_slipitem_desc
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_branchid,ls_accmaster_branch_id,ls_acccr_id,ls_accdr_id,ls_oldbranchid,ls_desc,ls_vcbrdocno
integer		li_slipflag,ll_seqno, li_shrlonstatus
long			ll_index, ll_count,ll_find, ll_index2, ll_sortacc, ll_sortint, ll_sortintarr
dec{2}		ldc_itempay,ldc_tax_amt,ldc_itembal, ldc_itemamtnet, ldc_principal, ldc_int, ldc_deptamt, ldc_total, ldc_intarrear
int				ll_num_D00, ll_num_D01, ll_num_S01, ll_num_WF, ll_num_OTH, ll_num_FFE, ll_num_L01, ll_num_L02, ll_num_L03
string			ls_slipitemtype_code,ls_vcrcvno,ls_acctaxid,ls_cashcode ,ls_account_id 
string			ls_accid_bf, ls_vcrcvdocno_tax , ls_itemdesc , ls_cash, ls_shrlontype, ls_membno, ls_membno_last
string			ls_finno, ls_finno_temp, ls_tofromaccid_bf, ls_voucher_type , as_vcdocno, ls_deptaccount
string			ls_itemdesc_D00, ls_itemdesc_D01, ls_itemdesc_S01, ls_itemdesc_WF, ls_itemdesc_OTH, ls_itemdesc_FFE
string			ls_itemdesc_L01, ls_itemdesc_L02, ls_itemdesc_L03, ls_system_code, ls_accintid, ls_recv_period, ls_kpaccid

n_ds			lds_vcpay, lds_vcpaydet
datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_kp_month"
lds_slipdata.settransobject( itr_sqlca )
 
ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

//ls_desc	= "จ่ายเงิน"
ls_tmpsystem		= "KEP"
ls_tmpvcgrp			= "MTH"
ls_accid_bf			= ""
ls_vcrcvdocno_tax	= ""
ls_finno_temp		= ""
ll_index2				=	1
ls_membno_last	=	""
ll_num_D00			=	1
ll_num_D01			=	1
ll_num_S01			=	1
ll_num_WF			=	1
ll_num_OTH			=	1
ll_num_FFE			=	1
ll_num_L01			=	1
ll_num_L02			=	1
ll_num_L03			=	1
is_vcrcvtrndocno	= ""
// สร้างเลข Voucher

	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "รายการเรียกเก็บรายเดือน"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	


for ll_index = 1 to ll_count
//	ls_slipno					= lds_slipdata.object.kpslip_no[ ll_index ]
	ldc_itempay				= lds_slipdata.object.item_payment[ ll_index ]	
	ldc_principal				= lds_slipdata.object.principal_payment[ ll_index ]
	ldc_int					= lds_slipdata.object.interest_payment[ ll_index ]
	ls_itemtype				= lds_slipdata.object.keepitemtype_code[ ll_index ]
	ls_shrlontype			= lds_slipdata.object.shrlontype_code[ ll_index ]
//	ls_deptaccount			= trim(lds_slipdata.object.description[ ll_index ])
//	ls_membno				= trim(lds_slipdata.object.member_no[ ll_index ])
	ls_system_code		= trim(lds_slipdata.object.system_code[ ll_index ])
	li_shrlonstatus			= lds_slipdata.object.bfcontlaw_status[ ll_index ] 
	ldc_intarrear			= lds_slipdata.object.intarrear_payment[ ll_index ] 
	ls_recv_period			= lds_slipdata.object.recv_period[ ll_index ]  

	if isnull( ldc_principal ) then ldc_principal = 0
	if isnull( ldc_int ) then ldc_int = 0
	ldc_intarrear = 0    // ตียอดดอกเบี้ยค้าง = 0  เพราะที่ยกมาจากยอดก่อน+ ยอดประจำงวด จะเท่ากับยอด intarrear_payment อยู่แล้ว edit by Apple 30/09/2558
	if isnull(ls_shrlontype)	 then ls_shrlontype	= '00'
	if ( ls_itemtype = 'FFE' ) then
		ls_shrlontype	= '00'
	end if
	
	choose case ls_itemtype
		case  'S01'	
			ls_system_code		= 'SHR'
		case 'FFE'
			ls_system_code		= 'FFE'
//		case 'FEE'
//			ls_system_code		= 'FEE'
//		case 'ISF'   //ลูกหนี้ค่าเบี้ยประกัน
//			ls_system_code		= 'ISF'
//		case 'IAR'   //ดอกเบี้ยค้างรับ
//			ls_system_code		= 'IAR'
		end choose		
	
	ls_accid			= string	( of_getattribmapaccid( as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid(as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid,"LON", ls_system_code, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid(as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid(as_coopid, "LON", ls_system_code, ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
	ls_vc_type		= string	( of_getattribmapaccid(as_coopid, "LON", ls_system_code, ls_shrlontype, li_shrlonstatus, "prefix_recv"  ) )
	ls_kpaccid		= string	( of_getattribmapaccid( as_coopid, "KEP", "KEP" , "01", 1, "account_id" ) ) //รหัสลูกหนี้ตัวแทน
	
	
		
	ls_accside		= "DR"
	ls_accrevside	= "CR"			
	
	if(ldc_itempay > 0) then  //ลูกหนี้ตัวแทน ฝั่ง DR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_kpaccid, ls_accside, ldc_itempay, "", 77777, ids_vcrcvpaydet )
	end if
	
	choose case ls_itemtype
		case 'L01','L02','L03'
			
	if(ldc_principal > 0) then //ฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_principal, "", 77777, ids_vcrcvpaydet )
	end if
	if(ldc_int > 0) then //ดอกเบี้ยฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintid, ls_accrevside, ldc_int, "", 77777, ids_vcrcvpaydet )
	end if
	if(ldc_intarrear > 0) then //ฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accrevside, ldc_intarrear, "", 77777, ids_vcrcvpaydet )
	end if

	case else
	if(ldc_itempay > 0) then  //
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_itempay, "", 77777, ids_vcrcvpaydet )
	end if

end choose


	ls_accid_bf	= ls_accid
	ls_finno_temp	= ls_finno
	ls_tofromaccid_bf	= ls_tofromaccid
	ls_membno_last = ls_membno
next

	//update สถานะการดึงข้อมูล
		update	kpmastreceivedet
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( recv_period	= :ls_recv_period ) and
					( coop_id			= :as_coopid ) //and 
//					(keepitemtype_code	not like '%D%') and
//					(keepitem_status = 1)
		using    	 itr_sqlca   ;

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then	
	return -1
end if
	
if ids_voucherdet.update() <> 1 then	
	return -1
end if

return 1
end function

private function integer of_vctrn_cancel_kp_month (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการเรียกเก็บประจำเดือน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_slipprior, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_vc_type
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp ,ls_slipitem_desc
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_branchid,ls_accmaster_branch_id,ls_acccr_id,ls_accdr_id,ls_oldbranchid,ls_desc,ls_vcbrdocno
integer		li_slipflag,ll_seqno, li_shrlonstatus
long			ll_index, ll_count,ll_find, ll_index2, ll_sortacc, ll_sortint, ll_sortintarr
dec{2}		ldc_itempay,ldc_tax_amt,ldc_itembal, ldc_itemamtnet, ldc_principal, ldc_int, ldc_deptamt, ldc_total, ldc_intarrear
int				ll_num_D00, ll_num_D01, ll_num_S01, ll_num_WF, ll_num_OTH, ll_num_FFE, ll_num_L01, ll_num_L02, ll_num_L03
string			ls_slipitemtype_code,ls_vcrcvno,ls_acctaxid,ls_cashcode ,ls_account_id 
string			ls_accid_bf, ls_vcrcvdocno_tax , ls_itemdesc , ls_cash, ls_shrlontype, ls_membno, ls_membno_last
string			ls_finno, ls_finno_temp, ls_tofromaccid_bf, ls_voucher_type , as_vcdocno, ls_deptaccount
string			ls_itemdesc_D00, ls_itemdesc_D01, ls_itemdesc_S01, ls_itemdesc_WF, ls_itemdesc_OTH, ls_itemdesc_FFE
string			ls_itemdesc_L01, ls_itemdesc_L02, ls_itemdesc_L03, ls_system_code, ls_accintid, ls_recv_period,ls_kpaccintid,ls_kpaccid

n_ds			lds_vcpay, lds_vcpaydet
datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cancel_kp_month"
lds_slipdata.settransobject( itr_sqlca )
 
ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

//ls_desc	= "จ่ายเงิน"
ls_tmpsystem		= "KEP"
ls_tmpvcgrp			= "MTH"
ls_accid_bf			= ""
ls_vcrcvdocno_tax	= ""
ls_finno_temp		= ""
ll_index2				=	1
ls_membno_last	=	""
ll_num_D00			=	1
ll_num_D01			=	1
ll_num_S01			=	1
ll_num_WF			=	1
ll_num_OTH			=	1
ll_num_FFE			=	1
ll_num_L01			=	1
ll_num_L02			=	1
ll_num_L03			=	1
is_vcrcvtrndocno	= ""
// สร้างเลข Voucher

	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "รายการยกเลิกกระดาษทำการ"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	


for ll_index = 1 to ll_count
//	ls_slipno					= lds_slipdata.object.kpslip_no[ ll_index ]
	ldc_itempay				= lds_slipdata.object.item_payment[ ll_index ]	
	ldc_principal				= lds_slipdata.object.principal_payment[ ll_index ]
	ldc_int					= lds_slipdata.object.interest_payment[ ll_index ]
	ls_itemtype				= lds_slipdata.object.keepitemtype_code[ ll_index ]
	ls_shrlontype			= lds_slipdata.object.shrlontype_code[ ll_index ]
//	ls_deptaccount			= trim(lds_slipdata.object.description[ ll_index ])
//	ls_membno				= trim(lds_slipdata.object.member_no[ ll_index ])
	ls_system_code		= trim(lds_slipdata.object.system_code[ ll_index ])
	li_shrlonstatus			= lds_slipdata.object.bfcontlaw_status[ ll_index ]     
	ldc_intarrear			= lds_slipdata.object.intarrear_payment[ ll_index ] 
	ls_recv_period			= lds_slipdata.object.recv_period[ ll_index ]  

	if isnull( ldc_principal ) then ldc_principal = 0
	if isnull( ldc_int ) then ldc_int = 0
	ldc_intarrear = 0    // ตียอดดอกเบี้ยค้าง = 0  เพราะที่ยกมาจากยอดก่อน+ ยอดประจำงวด จะเท่ากับยอด intarrear_payment อยู่แล้ว edit by Apple 30/09/2558
	if isnull(ls_shrlontype)	then ls_shrlontype	= '00'
	if ( ls_itemtype = 'FFE' ) then
		ls_shrlontype	= '00'
	end if
	choose case ls_itemtype
		case  'S01'	
			ls_system_code		= 'SHR'
		case 'FFE'
			ls_system_code		= 'FFE'
		case 'FEE'
			ls_system_code		= 'FEE'
		case 'ISF'  //ลูกหนี้ค่าเบี้ยประกันภัย
			ls_system_code		= 'ISF'
		end choose		
	
	ls_accid			= string	( of_getattribmapaccid( as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid(as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid,"LON", ls_system_code, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid(as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid(as_coopid, "LON", ls_system_code, ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
	ls_vc_type		= string	( of_getattribmapaccid(as_coopid, "LON", ls_system_code, ls_shrlontype, li_shrlonstatus, "prefix_recv"  ) )
//	ls_kpaccid		= string	( of_getattribmapaccid( as_coopid, "KEP", "KEP" , "01", 1, "account_id" ) ) //รหัสลูกหนี้ตัวแทน
 	ls_kpaccintid	= string	( of_getattribmapaccid(as_coopid, "KEP", "KEP" , "01", 1, "accint_id" ) )
		
	ls_accside		= "CR"
	ls_accrevside	= "DR"			
	
	if(ldc_itempay > 0) then  //ลูกหนี้ตัวแทน ฝั่ง DR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_kpaccintid, ls_accside, ldc_itempay, "ยกเลิกกระดาษทำการ", 77777, ids_vcrcvpaydet )
	end if
	
	choose case ls_itemtype
		case 'L01','L02','L03'
	if(ldc_principal > 0) then //ฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_principal, "ยกเลิก", 77777, ids_vcrcvpaydet )
	end if
	if(ldc_int > 0) then //ดอกเบี้ยฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintid, ls_accrevside, ldc_int, "ยกเลิก", 77777, ids_vcrcvpaydet )
	end if
	if(ldc_intarrear > 0) then //ฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accrevside, ldc_intarrear, "ยกเลิก", 77777, ids_vcrcvpaydet )
	end if

		case else
	
	if(ldc_itempay > 0) then  //
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_itempay, "ยกเลิก", 77777, ids_vcrcvpaydet )
	end if

end choose


	ls_accid_bf	= ls_accid
	ls_finno_temp	= ls_finno
	ls_tofromaccid_bf	= ls_tofromaccid
	ls_membno_last = ls_membno
next

	//update สถานะการดึงข้อมูล
		update	kpmastreceivedet
		set			canceltovc_flag	= 1,	
					cancelvc_no			= :is_vcrcvtrndocno
		where	( recv_period	= :ls_recv_period ) and
					( coop_id			= :as_coopid ) and 
//					(keepitemtype_code	not like '%D%') and
					( keepitem_status	= -9)
		using    	 itr_sqlca   ;

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then	
	return -1
end if
	
if ids_voucherdet.update() <> 1 then	
	return -1
end if

return 1
end function

private function integer of_vctrn_cancel_kp_month_slip (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการเรียกเก็บประจำเดือน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_slipprior, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_vc_type
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp ,ls_slipitem_desc
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_branchid,ls_accmaster_branch_id,ls_acccr_id,ls_accdr_id,ls_oldbranchid,ls_desc,ls_vcbrdocno
integer		li_slipflag,ll_seqno, li_shrlonstatus
long			ll_index, ll_count,ll_find, ll_index2, ll_sortacc, ll_sortint, ll_sortintarr
dec{2}		ldc_itempay,ldc_tax_amt,ldc_itembal, ldc_itemamtnet, ldc_principal, ldc_int, ldc_deptamt, ldc_total, ldc_intarrear
int				ll_num_D00, ll_num_D01, ll_num_S01, ll_num_WF, ll_num_OTH, ll_num_FFE, ll_num_L01, ll_num_L02, ll_num_L03
string			ls_slipitemtype_code,ls_vcrcvno,ls_acctaxid,ls_cashcode ,ls_account_id 
string			ls_accid_bf, ls_vcrcvdocno_tax , ls_itemdesc , ls_cash, ls_shrlontype, ls_membno, ls_membno_last
string			ls_finno, ls_finno_temp, ls_tofromaccid_bf, ls_voucher_type , as_vcdocno, ls_deptaccount
string			ls_itemdesc_D00, ls_itemdesc_D01, ls_itemdesc_S01, ls_itemdesc_WF, ls_itemdesc_OTH, ls_itemdesc_FFE
string			ls_itemdesc_L01, ls_itemdesc_L02, ls_itemdesc_L03, ls_system_code, ls_accintid, ls_recv_period,ls_sys_code

n_ds			lds_vcpay, lds_vcpaydet
datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cancel_mth_slip2"
lds_slipdata.settransobject( itr_sqlca )
 
ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

//ls_desc	= "จ่ายเงิน"
ls_tmpsystem		= "KEP"
ls_tmpvcgrp			= "MTH"
ls_accid_bf			= ""
ls_vcrcvdocno_tax	= ""
ls_finno_temp		= ""
ll_index2				=	1
ls_membno_last	=	""
ll_num_D00			=	1
ll_num_D01			=	1
ll_num_S01			=	1
ll_num_WF			=	1
ll_num_OTH			=	1
ll_num_FFE			=	1
ll_num_L01			=	1
ll_num_L02			=	1
ll_num_L03			=	1
is_vcrcvtrndocno	= ""
// สร้างเลข Voucher

	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "ยกเลิกใบเสร็จประจำเดือน"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	


for ll_index = 1 to ll_count
//	ls_slipno					= lds_slipdata.object.kpslip_no[ ll_index ]
	ldc_itempay				= lds_slipdata.object.item_adjamt[ ll_index ]	
	ldc_principal				= lds_slipdata.object.principal_adjamt[ ll_index ]
	ldc_int					= lds_slipdata.object.interest_adjamt[ ll_index ]
	ls_itemtype				= lds_slipdata.object.bfmthpay_kpitemtyp[ ll_index ]
	ls_shrlontype			= lds_slipdata.object.shrlontype_code[ ll_index ]
//	ls_deptaccount			= trim(lds_slipdata.object.description[ ll_index ])
//	ls_membno				= trim(lds_slipdata.object.member_no[ ll_index ])
	ls_system_code		= trim(lds_slipdata.object.system_code[ ll_index ])
	li_shrlonstatus			= lds_slipdata.object.bfcontlaw_status[ ll_index ]
	ldc_intarrear			= lds_slipdata.object.intarrear_adjamt[ ll_index ] 
	ls_recv_period			= lds_slipdata.object.ref_recvperiod[ ll_index ]  
	ls_tofromaccid			= trim(lds_slipdata.object.tofrom_accid[ ll_index ] )

	if isnull( ldc_principal ) then ldc_principal = 0
	if isnull( ldc_int ) then ldc_int = 0
	if isnull( ldc_intarrear ) then ldc_intarrear = 0
	
	if isnull(ls_shrlontype)	then ls_shrlontype	= '00'
	if isnull(li_shrlonstatus) or li_shrlonstatus = 0 	then li_shrlonstatus	= 1
	if ( ls_itemtype = 'FFE' ) then
		ls_shrlontype	= '00'
	end if
	choose case ls_itemtype
		case  'S01'	
			ls_system_code		= 'SHR'
		case 'FFE'
			ls_system_code		= 'FFE'
		case 'FEE'
			ls_system_code		= 'FEE'
		case 'ISF'
			ls_system_code		= 'ISF'
		end choose		
	
	if ( ls_system_code = 'DEP' ) then
		ls_sys_code	= 'DEP'
	else 
		ls_sys_code = 'LON'
	end if
	
	ls_accid			= string	( of_getattribmapaccid( as_coopid, ls_sys_code, ls_system_code , ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, ls_sys_code, ls_system_code , ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid(as_coopid, ls_sys_code, ls_system_code , ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid,ls_sys_code, ls_system_code, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid(as_coopid, ls_sys_code, ls_system_code , ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid(as_coopid, ls_sys_code, ls_system_code, ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
	ls_vc_type		= string	( of_getattribmapaccid(as_coopid, ls_sys_code, ls_system_code, ls_shrlontype, li_shrlonstatus, "prefix_recv"  ) )
	
		
	ls_accside		= "CR"
	ls_accrevside	= "DR"			
	
	if(ldc_itempay > 0) then  //ลูกหนี้ตัวแทน ฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid, ls_accside, ldc_itempay, "ยกเลิก", 77777, ids_vcrcvpaydet )
	end if
	
	choose case ls_itemtype
		case 'S01','FFE','FEE','ISF'
	if(ldc_itempay > 0) then  //
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_itempay, "ยกเลิก", 77777, ids_vcrcvpaydet )
	end if
			
		case else
	
	if(ldc_principal > 0) then //ฝั่ง DR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_principal, "ยกเลิก", 77777, ids_vcrcvpaydet )
	end if
	if(ldc_int > 0) then //ดอกเบี้ยฝั่ง DR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintid, ls_accrevside, ldc_int, "ยกเลิก", 77777, ids_vcrcvpaydet )
	end if
	if(ldc_intarrear > 0) then //ฝั่ง DR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accrevside, ldc_intarrear, "ยกเลิก", 77777, ids_vcrcvpaydet )
	end if
end choose


	ls_accid_bf	= ls_accid
	ls_finno_temp	= ls_finno
	ls_tofromaccid_bf	= ls_tofromaccid
	ls_membno_last = ls_membno
next

	//update สถานะการดึงข้อมูล
		update	slslipadjust
		set		posttovc_flag	= 1,	
				voucher_no			= :is_vcrcvtrndocno
		where	( ref_recvperiod	= :ls_recv_period ) and
				( coop_id			= :as_coopid ) and 
				( adjslip_date		= :adtm_vcdate )
					
		using    	 itr_sqlca   ;

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then	
	return -1
end if
	
if ids_voucherdet.update() <> 1 then	
	return -1
end if

return 1
end function

private function integer of_vctrnpayin_shr (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการชำระหนี้  เงินโอน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string		ls_slipno, ls_refopeno, ls_accid, ls_accintid, ls_accintarrid, ls_vc_type  , ls_slipno_bf,ls_itemtype_bf
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_moneygrp
string		ls_shrlontype, ls_itemtype, ls_tofromaccid,ls_moneytype_code, ls_memno, ls_memb_name
string		ls_desc
integer	    li_shrlonstatus, li_slipflag, li_seqno,li_flag,li_group,li_group_bf
long		ll_index, ll_count, ll_sortacc, ll_sortint, ll_sortintarr, ll_index2
dec{2}		ldc_prinpay, ldc_intpay, ldc_itempay, ldc_intarrpay,ldc_fineamt, ldc_intarrear
string		ls_document_no,ls_itemdesc, ls_slipitem_desc
string		ls_vc_desc, ls_loangroup_code, ls_accid_bf, ls_vcrcvdocno_prnc, ls_accintid_bf
string		ls_vcrcvdocno_int , ls_vcrcvdocno_etc , ls_voucher_type  , ls_coopid, ls_memgroup

datastore	lds_slipdata ,lds_countitem

// ds สำหรับเก็บการชำระหนี้
lds_slipdata	= create datastore

if( as_coopid = '061001') then
	lds_slipdata.dataobject	= "d_vc_slip_data_trnlnrcv_shr_split_mju"   // MJU ไม่ต้องเอา ref_system = DIV ออกเพราะดึงชำระหนี้าก payin ไม่เอาจากปันผล
	lds_slipdata.settransobject( itr_sqlca )
	ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )
else 
	lds_slipdata.dataobject	= "d_vc_slip_data_trnlnrcv_shr_split_cloud"
	lds_slipdata.settransobject( itr_sqlca )
	ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )
end if
// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if




ls_tmpvcgrp		= "PAY"
ls_accid_bf		= ''
ll_index2			=	1
// ชุดการรับชำระหนี้
for ll_index = 1 to ll_count
	
	ls_slipno			= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_document_no		= lds_slipdata.object.document_no[ ll_index ]
	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= lds_slipdata.object.bfcontlaw_status[ ll_index ]
	li_slipflag			= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt[ ll_index ]
	ldc_intpay			= lds_slipdata.object.interest_payamt[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ls_slipitem_desc	= trim(lds_slipdata.object.slipitem_desc[ ll_index ])
	ls_coopid			= lds_slipdata.object.coop_id[ ll_index ]
	ls_memgroup			= lds_slipdata.object.membgroup_code[ ll_index ]
	li_group			= lds_slipdata.object.compute_6[ ll_index ]
	ldc_intarrear		= lds_slipdata.object.intarrear_payamt[ ll_index ]
	ls_moneytype_code	= lds_slipdata.object.moneytype_code[ ll_index ]   // ใช้แยกเคส ของขวัญ ถ้าเป็น TRN (GSB)
	ls_memno			= lds_slipdata.object.member_no[ ll_index ]
	ls_memb_name        = lds_slipdata.object.memb_name[ ll_index ] 
		
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_prinpay ) then ldc_prinpay = 0
	if isnull( li_shrlonstatus) or li_shrlonstatus = 0  then li_shrlonstatus = 1
	if(ls_itemtype = 'FEE') then ls_itemtype = 'FFE'
	if isnull( ldc_intarrear ) then ldc_intarrear = 0
	if isnull( ls_shrlontype) or ls_shrlontype = ""  then ls_shrlontype = "00"
	if ls_itemtype <>  'LON'  and  ls_itemtype <> 'SHR' then   ls_shrlontype = "00"
	// ด/บ จ่าย - ดอกเบี้ยคืน
	ldc_intpay = ldc_intpay - ldc_intarrear
	
	
	// สร้างเลข Voucher
//is_vcrcvtrndocno = ""

//	 if  is_vcrcvtrndocno    =  ""  then
if ( ls_slipno  <> ls_slipno_bf  ) then
		ls_voucher_type	= "JV"
		if( as_coopid = '035001') then
						
			if(trim( ls_itemtype) = 'SHR' or trim( ls_itemtype) = 'FFE' ) then
				if(ls_moneytype_code ='TRN') then
						ls_desc  				= "รายการโอนภายในซื้อหุ้น"	
					else
						ls_desc  				= "รับซื้อหุ้น (รายการโอน) " + ls_memb_name	
					end if
				else
						ls_desc  				= "รับชำระเงินกู้ (รายการโอน) "	 + ls_memb_name	
			end if
				
		else
			
			if(trim( ls_itemtype) = 'LON') then
				ls_desc  				= "รับชำระเงินกู้ (รายการโอน) "	+ ls_memb_name
				else
					if(ls_moneytype_code ='TRN') then
						ls_desc  				= "รายการโอนภายในซื้อหุ้น "	 + ls_memb_name	
					else
						ls_desc  				= "รับซื้อหุ้น (รายการโอน) " + ls_memb_name		
					end if
			end if
		end if
		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

	
	
	
	ls_accid			= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid( as_coopid ,"LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
		
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if

					
	if  ls_accid_bf = ls_accid then
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	else
		ll_index2	=	1
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	end if
	
		
		// เงินต้น
		if ( ldc_prinpay > 0 ) then				
			this.of_additem( as_coopid ,is_vcrcvtrndocno , "LON" , "TRN", ls_accid, ls_accside , ldc_prinpay, ll_sortacc, ids_vcrcvpaydet  , as_userid )
		end if
		
		// ดอกเบี้ย	
		if ( ldc_intpay > 0 ) then
			this.of_additem( as_coopid ,is_vcrcvtrndocno, "LON"  , "TRN", ls_accintid, ls_accside, ldc_intpay,ll_sortint, ids_vcrcvpaydet  , as_userid )
		end if
		//รายการชำระหักอื่น ๆ
		if ( ldc_itempay > 0 and  ldc_prinpay = 0 and ldc_intpay = 0 ) then
			this.of_additem( as_coopid , is_vcrcvtrndocno, "LON" , "TRN", ls_accid, ls_accside, ldc_itempay ,ll_sortint, ids_vcrcvpaydet  , as_userid )
		end if
			//รายการ ด/บ คืน
		if ( ldc_intarrear> 0) then
			this.of_additem( as_coopid , is_vcrcvtrndocno, "LON" , "TRN", ls_accintarrid, ls_accside, ldc_intarrear ,ll_sortintarr, ids_vcrcvpaydet  , as_userid )
		end if
		
		// รายการฝั่งตรงข้าม
		if	( ldc_itempay > 0  ) then
			this.of_additem( as_coopid ,is_vcrcvtrndocno , "LON" , "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvpaydet  , as_userid )
		end if
		

	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayin
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcrcvtrndocno
		where		( payinslip_no		= :ls_slipno ) and
						( memcoop_id		= :as_coopid  )
		using     itr_sqlca   ;							
	end if			

	ls_accid_bf		= ls_accid
	ls_accintid_bf	= ls_accintid
	ls_slipno_bf		= ls_slipno	
	ls_itemtype_bf = ls_itemtype
	li_group_bf = li_group
next

destroy( lds_slipdata )

if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vctrndppay_dol (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> ถอน + ปิดบัญชี แยกดอกเบี้ย เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_colsort, ls_month, ls_date, ls_refer_cashtype
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp, ls_feeid
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			s_acccr_id,ls_accdr_id,ls_branchid,ls_branchorigin,ls_desc,ls_oldbranchid,ls_cash
integer		li_slipflag,ll_find,li_flag, li_payfee_meth,li_groupcode_bf,li_groupcode,li_accnature_flag
long			ll_index, ll_count, ll_sortacc, ll_sortintarr, ll_index2
dec{2}		ldc_itempay, ldc_intarrpay,ldc_prncbal,ldc_int_amt,ldc_accuint_amt, ldc_intreturn, ldc_slipnetamt,ldc_tax_2
string			ls_deptgroupcode, ls_itemgroup, ls_accid_bf, ls_depttype_code, ls_vc_desc, ls_itemdesc  
string			ls_depttype_group, ls_refsystem, ls_depttype_group_temp, ls_voucher_type , ls_vc_type , as_vcdocno
dec{2}		ldc_other_amt, ldc_intbfyear , ldc_itempaynet, ldc_tax_return, ldc_tax, ldc_orther, ldc_checkint
datetime		ldtm_operate
string			ls_accid_old, ls_acccash, ls_depttype_bf, ls_itemtype_bf, ls_accint, ls_acctax, ls_referslip, ls_grouptype

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_trndppay_dol"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem					= "DEP"
ls_tmpvcgrp						= "DAY"
ls_depttype_group_temp		= ""
ls_accid_bf 						= ""
ll_index2							=	1
//is_vcrcvtrndocno				= ""



for ll_index = 1 to ll_count

	ls_slipno					= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_itemtype				= lds_slipdata.object.recppaytype_code[ ll_index ]
	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_mapacc				= lds_slipdata.object.accmap_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_amt[ ll_index ]
//	ldc_int_amt				= lds_slipdata.object.int_amt[ ll_index ]	
	ldc_accuint_amt		= lds_slipdata.object.accuint_amt[ ll_index ]
//	ldc_intreturn			= lds_slipdata.object.int_return[ ll_index ]
	ls_deptgroupcode		= lds_slipdata.object.deptgroup_code[ ll_index ]
	ls_itemgroup			= lds_slipdata.object.group_itemtpe[ ll_index ]
	ldc_itempaynet			= lds_slipdata.object.deptslip_netamt[ ll_index ]
	ldc_other_amt			= lds_slipdata.object.other_amt[ ll_index ] ; 
	li_payfee_meth			= lds_slipdata.object.payfee_meth[ ll_index ] ; 
//	ldc_intbfyear			= lds_slipdata.object.int_bfyear[ ll_index ]
	ls_desc					= trim(lds_slipdata.object.compute_3[ ll_index ])
//	ldc_tax_return			= lds_slipdata.object.tax_return[ ll_index ]
//	ldc_tax					= lds_slipdata.object.tax_amt[ ll_index ]	
	li_groupcode			= lds_slipdata.object.compute_8[ ll_index ] ;   // แยกเคส ออมทรัพย์ , ประจำ
	ldc_orther				=  lds_slipdata.object.other_amt[ ll_index ]  //ค่าปรับเงินฝาก
	li_accnature_flag		= lds_slipdata.object.accnature_flag[ ll_index ] ; 
	ls_referslip				= lds_slipdata.object.refer_slipno[ ll_index ] ; 
	ldc_tax_2				= lds_slipdata.object.tax_2[ ll_index ]	
	ldc_checkint				= lds_slipdata.object.deptslip_amt[ ll_index ]
	ls_refer_cashtype		= lds_slipdata.object.refer_cashtype[ ll_index ]	
	ls_grouptype			= lds_slipdata.object.group_itemtpe[ ll_index ]	 //กลุ่มประเภทการทำรายการ
	
	if( ls_itemtype = 'INT') then ls_refer_cashtype = 'CSH'  //ให้พวก int ใช้ query แบบเงินสด
	
		if( ls_refer_cashtype = 'CSH') then
			select sum(int_bfyear) , sum(tax_amt), sum(tax_return), sum(int_amt), sum(int_return)
			into :ldc_intbfyear, :ldc_tax, :ldc_tax_return, :ldc_int_amt, :ldc_intreturn
			from dpdeptslip 
			where refer_slipno = :ls_referslip
			using itr_sqlca;
		else
			if(ls_grouptype = 'CLS') then //พวกปิดบัญชี ให้ดึงยอดดอกเบี้ยจากรายการ INT  เน้นพวกเงินฝากสังฆราช
				ldc_intbfyear 	= 0
				ldc_tax			= 0
				ldc_tax_return	= 0 
				ldc_int_amt		= 0
				ldc_intreturn	= 0
				ldc_itempay		= ldc_itempaynet
			else
				select sum(int_bfyear) , sum(tax_amt), sum(tax_return), sum(int_amt), sum(int_return)
				into :ldc_intbfyear, :ldc_tax, :ldc_tax_return, :ldc_int_amt, :ldc_intreturn
				from dpdeptslip 
				where refer_slipno = :ls_slipno
				using itr_sqlca;
			end if
		end if
	
//	if isnull (ls_tofromaccid)  then ls_tofromaccid = '000000'	
	if isnull( ldc_orther ) then ldc_orther = 0
	if isnull( li_payfee_meth ) then li_payfee_meth = 0
	if isnull( ldc_int_amt ) then ldc_int_amt = 0
	if isnull( ldc_accuint_amt ) then ldc_accuint_amt = 0
	if isnull( ldc_intreturn ) then ldc_intreturn = 0
	if isnull(ldc_intbfyear) then ldc_intbfyear = 0
	if isnull(ldc_tax) then ldc_tax = 0
	if isnull(ldc_tax_return) then ldc_tax_return = 0
	if isnull(ldc_tax_2) then ldc_tax_2 = 0
	if isnull(ldc_checkint) then ldc_checkint = 0
		
	//สร้างเลข Voucher
//	 if  is_vcrcvtrndocno = ""   then
	if ( li_groupcode_bf  <> li_groupcode )  then
		
			ls_voucher_type	= "JV"	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
				if(li_groupcode = 1) then
				ls_desc  				= "รายการฝากถอนเงินกลุ่มประจำ (รายการโอน)"		
				else
				ls_desc  				= "รายการฝากถอนเงินกลุ่มออมทรัพย์ (รายการโอน)"		
			end if
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
	else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	
	
		
	choose case ls_mapacc
		case "AIT"
			ls_accintarrid	= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
			ll_sortintarr		= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, "sortintarr_order" ) )
			ldc_itempay		= ldc_itempay 
			ls_colname		= "accint_id"
			ls_colsort		= "sortint_order"
		case "ATX"
			ls_colname		= "acctax_id"
			ls_colsort		= "sorttax_order"
//			ldc_intbfyear	= 0.00
		case else
			ls_colname		= "account_id"
			ls_colsort		= "sortacc_order"
//			ldc_intbfyear	= 0.00
	end choose
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, ls_colname  ) )
	ls_accint				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "accint_id"  ) )
	ls_accintarrid		= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
	ls_acctax				= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "acctax_id"  ) )
	ll_sortacc			= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, ls_colsort  ) )		
	ls_feeid				= string( of_getattribmapaccid( as_coopid ,"DEP", "FEE", "00", 1,  "account_id"  ) ) //ค่าปรับ
	
	if(li_accnature_flag = 1) then
	
	ls_accside		= "CR"
	ls_accrevside	= "DR"	
else 
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
end if 

if ls_itemtype =  'INY' then
		ls_accside			= "DR"
		ls_accrevside		= "CR"
end if

if ls_itemtype = 'INT' then
		ls_accside			= "DR"
		ls_accrevside		= "CR"
//		ls_tofromaccid2 	= ls_tofromaccid
		ldc_itempay  		= ldc_itempay - ldc_intbfyear
		if( ldc_itempay < 0 ) then ldc_itempay = 0.00   //กรณียอด ดบ.ตั้งค้าง > ดบ.จ่าย  ลงแต่ยอด ดบ.ตั้งค้าง  แล้ว cr ดอกเบี้ยเงินฝากประจำค้างจ่ายรับคืน 
		ldc_int_amt 			= 0.00
	end if
	
//	ls_accside		= "DR"
//	ls_accrevside	= "CR"	

		
if( li_accnature_flag = 1) then
		// รายการเงินฝาก
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay , "", ll_sortacc, ids_vcrcvpaydet)
	end if
	
	if (ldc_int_amt > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accint, ls_accside, ldc_int_amt , "", ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_tax_return > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_acctax, ls_accside, ldc_tax_return, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	//ดอกเบี้ยค้างจ่าย
	if (ldc_intbfyear > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accside, ldc_intbfyear, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	
	/// รายการฝั่งตรงข้าม
	if 	( ldc_itempaynet > 0 ) then
//		this.of_additem( as_coopid ,is_vcrcvtrndocno,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvpaydet  , as_userid )
		this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid, ls_accrevside, ldc_itempaynet - ldc_tax_2, "", ll_sortacc, ids_vcrcvpaydet)
	end if
	if 	(ldc_tax_2 > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_acctax , ls_accrevside, ldc_tax_2  , 1, ids_vcrcvpaydet  , as_userid )
	end if
		//กรณี ดบ.ตั้งค้าง มากกว่า ดบ.จ่าย ลงรายการ ดบ.เงินฝากประจำค้างจ่ายรับคืน 
	if( ldc_intbfyear > ldc_checkint) then 
		this.of_additem( as_coopid , is_vcrcvtrndocno,ls_tmpsystem, ls_tmpvcgrp, ls_accid , ls_accrevside, ldc_intbfyear - ldc_checkint  , 1, ids_vcrcvpaydet  , as_userid )
//		this.of_additem( as_coopid , is_vcrcvtrndocno,ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid2 , ls_accrevside, ldc_itempay  , 1, ids_vcrcvpaydet  , as_userid )
	end if
else

	//รายการถอน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, (ldc_itempay -(ldc_int_amt + ldc_tax_return) ) + (ldc_intreturn + ldc_tax), "", ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_int_amt > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accint, ls_accside, ldc_int_amt - ldc_intbfyear, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_tax_return > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_acctax, ls_accside, ldc_tax_return, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_intbfyear > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accside, ldc_intbfyear, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempaynet > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid, ls_accrevside, ldc_itempaynet - ldc_tax_2, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	if 	( ldc_intreturn > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accint , ls_accrevside, ldc_intreturn  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	if 	( ldc_tax > 0 ) or (ldc_tax_2 > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_acctax , ls_accrevside, ldc_tax +ldc_tax_2  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	if( ldc_orther > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp,ls_feeid , ls_accrevside, ldc_orther  , 1, ids_vcrcvpaydet  , as_userid )
	end if
end if
	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcrcvtrndocno)    	then
		update	dpdeptslip
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( deptslip_no	= :ls_slipno ) and
					( coop_id 		= :as_coopid)
		using itr_sqlca;
	end if
	
	ls_accid_bf 				= ls_accid
	ls_depttype_bf			= ls_depttype
	ls_itemtype_bf			= ls_itemtype
	li_groupcode_bf 		= li_groupcode
next

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vccashlnrcv_shr (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
 Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการชำระ เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/

string		ls_slipno, ls_accid, ls_accintid, ls_accintarrid, ls_slipno_bf, ls_voucher_type
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_desc
string		ls_shrlontype, ls_itemtype, ls_tofromaccid
integer		li_shrlonstatus, li_slipflag
long		ll_index, ll_count, ll_sortacc, ll_sortint
dec{2}		ldc_prinpay, ldc_intpay, ldc_itempay, ldc_intarrpay, ldc_int
string		ls_coopcontrol , ls_coopid
string		ls_loangroup, ls_memgroup, ls_memno, ls_loandesc, ls_memb_name

datastore	lds_slipdata ,lds_countitem

// ds สำหรับเก็บการชำระหนี้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashlnrcv_shr_split"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )

// ds สำหรับทำสำเนาเพื่อ หาเลขที่ใบเสร็จ
lds_countitem	= lds_slipdata

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if
	
ls_tmpsystem	= "LON" 
ls_tmpvcgrp		= "RCV"
is_vcrcvdocno = ""



// ชุดการรับชำระหนี้
for ll_index = 1 to ll_count

	ls_coopid			= lds_slipdata.object.coop_id[ ll_index ]
	ls_slipno			= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= lds_slipdata.object.bfcontlaw_status[ ll_index ]
	li_slipflag			= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt[ ll_index ]
	ldc_int				= lds_slipdata.object.interest_payamt[ ll_index ]
	ldc_intarrpay		= lds_slipdata.object.intarrear_payamt[ ll_index ]
	ls_memgroup			= lds_slipdata.object.membgroup_code[ ll_index ]
	ls_memno			= lds_slipdata.object.member_no[ ll_index ]
	ls_memb_name			= lds_slipdata.object.memb_name [ ll_index ]
	ls_loandesc				= lds_slipdata.object.loantype_desc [ ll_index ]
							
		
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_prinpay ) then ldc_prinpay = 0
	if isnull( ldc_intarrpay ) then ldc_intarrpay = 0
	if isnull( li_shrlonstatus) then li_shrlonstatus = 1
	if isnull( ls_shrlontype) or ls_shrlontype = ""  then ls_shrlontype = "00"
	
	if(ls_itemtype = 'SHR') then li_shrlonstatus = 1
	if(ls_itemtype = 'FEE') then ls_itemtype = 'FFE'
	if ( ldc_intarrpay > 0 ) then
		ldc_intpay	= ldc_intpay - ldc_intarrpay
	end if
		
	ls_accid			= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	
	//สร้างเลขที่ Voucher
 if  ls_slipno	<> ls_slipno_bf	  then
		ls_voucher_type	= "RV"
		ls_desc  				= "รับชำระหนี้เงินสด" + ls_memb_name		
		is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
		this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type ,  ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid  , as_userid )		
	else
		ids_vcrcv.retrieve( is_vcrcvdocno )
		ids_vcrcvdet.retrieve( is_vcrcvdocno )
 end if 	

		
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if
	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	
// เงินต้น
		if ( ldc_prinpay > 0 ) then				
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_prinpay, "", ll_sortacc, ids_vcrcvdet)
			this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_prinpay  , 1, ids_vcrcvdet  , as_userid )
		end if
		
		// ดอกเบี้ย	
		if ( ldc_int > 0 ) then
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintid, ls_accside, ldc_int, "", ll_sortacc, ids_vcrcvdet)
			this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_int  , 1, ids_vcrcvdet  , as_userid )
		end if
		
		// ดอกเบี้ยค้าง
		if ( ldc_intarrpay > 0 ) then
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accside, ldc_intarrpay, "", ll_sortacc, ids_vcrcvdet)
			this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_intarrpay  , 1, ids_vcrcvdet  , as_userid )
		end if	
		
				//รายการชำระหักอื่น ๆ
		if ( ldc_itempay > 0 and  ldc_prinpay = 0 and ldc_int = 0 and ldc_intarrpay = 0 ) then
			this.of_additem( as_coopid , is_vcrcvdocno, ls_tmpsystem , ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay ,ll_sortint, ids_vcrcvdet  , as_userid )
			this.of_additem( as_coopid , is_vcrcvdocno , "CSH" , "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet  , as_userid )
		end if
		
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayin
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcrcvdocno
		where		payinslip_no			= :ls_slipno   and 
						memcoop_id		= :as_coopid and
						coop_id				= :ls_coopid
		using    		 itr_sqlca   ;							
	end if				
		
	ls_slipno_bf		= ls_slipno	
				
next

destroy (lds_slipdata)

//update
if ids_vcrcv.update() <> 1 then
	return -1
end if
	
if ids_vcrcvdet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if


return 1
end function

private function integer of_vctrndppay_rcv_dol (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> ถอน + ปิดบัญชี รายการโอน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_colsort,  ls_feeid, ls_coopid, ls_desc,ls_deptname
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp , ls_deptgroup , ls_deptgroup_bf
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid,ls_group_itemtpe, ls_dept_refer, ls_slipno_bf,ls_deptno
integer			li_slipflag,ll_find,li_flag, li_payfee_meth, li_accflag, li_deptgroup_code_bf, li_deptgroup_code
long			ll_index, ll_count, ll_sortacc, ll_sortintarr, ll_index2
dec{2}			ldc_itempay, ldc_intarrpay,ldc_prncbal,ldc_int_amt,ldc_accuint_amt, ldc_intreturn, ldc_slipnetamt, ldc_pay
string			ls_deptgroupcode, ls_itemgroup, ls_accid_bf, ls_depttype_code, ls_vc_desc, ls_itemdesc  
string			ls_depttype_group, ls_refsystem, ls_depttype_group_temp, ls_voucher_type , ls_vc_type , as_vcdocno
dec{2}			ldc_other_amt, ldc_intbfyear , ldc_itempaynet, ldc_tax_return, ldc_tax, ldc_checkint,ldc_orther
datetime		ldtm_operate
string			ls_accid_old, ls_acccash, ls_depttype_bf, ls_itemtype_bf, ls_accint, ls_acctax, ls_refer_cashtype, ls_tofromaccid2

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_trndppay_rcv_dol_split"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem				= "DEP"
ls_tmpvcgrp					= "DAY"
ls_depttype_group_temp		= ""
ls_accid_bf 				= ""
ll_index2					=	1

for ll_index = 1 to ll_count

	ls_slipno				= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_itemtype				= lds_slipdata.object.recppaytype_code[ ll_index ]
	ls_moneygrp				= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_mapacc				= lds_slipdata.object.accmap_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_amt[ ll_index ]
	ldc_int_amt				= lds_slipdata.object.int_amt[ ll_index ]	
	ldc_accuint_amt			= lds_slipdata.object.accuint_amt[ ll_index ]
	ldc_intreturn			= lds_slipdata.object.int_return[ ll_index ]
	ls_deptgroupcode		= lds_slipdata.object.deptgroup_code[ ll_index ]
	ls_itemgroup			= lds_slipdata.object.group_itemtpe[ ll_index ]
	ldc_itempaynet			= lds_slipdata.object.deptslip_netamt[ ll_index ]
	ldc_other_amt			= lds_slipdata.object.other_amt[ ll_index ] ; 
	li_payfee_meth			= lds_slipdata.object.payfee_meth[ ll_index ] ; 
	ldc_intbfyear			= lds_slipdata.object.int_bfyear[ ll_index ]
	ls_desc					= trim(lds_slipdata.object.compute_3[ ll_index ])
	ldc_tax_return			= lds_slipdata.object.tax_return[ ll_index ]
	ldc_tax					= lds_slipdata.object.tax2[ ll_index ]	
	ls_refer_cashtype		= lds_slipdata.object.refer_cashtype[ ll_index ]	
	ls_tofromaccid2			= lds_slipdata.object.tofrom_accid2[ ll_index ]
	li_accflag				= lds_slipdata.object.accnature_flag[ ll_index ]
	li_deptgroup_code		= lds_slipdata.object.group_flag[ ll_index ]
	ldc_checkint			= lds_slipdata.object.deptslip_amt[ ll_index ]
	ldc_orther				=  lds_slipdata.object.other_amt[ ll_index ]  //ค่าปรับเงินฝาก
	ls_group_itemtpe		= lds_slipdata.object.group_itemtpe[ ll_index ]	
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]	
	ls_deptno				= lds_slipdata.object.deptaccount_no[ ll_index ]
	ls_deptname				= lds_slipdata.object.deptaccount_name[ ll_index ]
	
	if isnull (ls_tofromaccid2) or ls_tofromaccid2 = ""  then ls_tofromaccid2 = ls_tofromaccid
	if isnull( ldc_other_amt ) then ldc_other_amt = 0
	if isnull( ldc_tax ) then ldc_tax = 0
	if isnull( ldc_int_amt ) then ldc_int_amt = 0
	if isnull( ldc_accuint_amt ) then ldc_accuint_amt = 0
	if isnull( ldc_intreturn ) then ldc_intreturn = 0
	if isnull(ldc_intbfyear) then ldc_intbfyear = 0
	if isnull(ldc_checkint) then ldc_checkint = 0
	if isnull(ls_refer_cashtype) then ls_refer_cashtype = ""
	if ls_itemtype = 'WTI' then ldc_int_amt = 0      // ในแถว WTI มี int_amt จากเดิมใช้จาก INY ทำให้ดึงดอกเบี้ยจ่ายเกินมา เขียนไว้เพื่อตียอด int_amt จาก WTI เป็น 0
	if ls_itemtype = 'WTR' then ldc_int_amt = 0      // ในแถว WTR มี int_amt จากเดิมใช้จาก INT ทำให้ดึงดอกเบี้ยจ่ายเกินมา เขียนไว้เพื่อตียอด int_amt จาก WTR เป็น 0
	
	if as_coopid = '061001' then
		ldc_intbfyear = 0
		ldc_tax = 0
	end if	
	
	if ls_group_itemtpe = 'CLS' then 
		ldc_itempay = ldc_itempaynet
		ldc_intbfyear = 0
		ldc_int_amt = 0
		ldc_intreturn = 0
		ldc_tax = 0
		ldc_tax_return = 0
		
end if 
/////////////////////////////////////
if as_coopid = '035001' then
	if ls_itemtype = 'WTR' then   // ในแถว WTR มี int_amt จากเดิมใช้จาก INT ทำให้ดึงดอกเบี้ยจ่ายเกินมา เขียนไว้เพื่อตียอด int_amt จาก WTR เป็น 0
	
		//หาคู่บัญชีว่าถอนไปฝากที่รหัสอะไร
		select depttype_code 
		into :ls_dept_refer
		from dpdeptslip  
		where refer_slipno = :ls_slipno and 
		recppaytype_code = 'DTR'
		using itr_sqlca;
		
		ls_tofromaccid2		= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_dept_refer, 1, "account_id"  ) )
		if isnull (ls_tofromaccid2) or ls_tofromaccid2 = ""  then ls_tofromaccid2 = ls_tofromaccid
		
		ldc_itempay = ldc_itempaynet 
		ldc_int_amt = 0 
	end if
	
	if ls_itemtype = 'CTR' then
				
		select depttype_code 
		into :ls_dept_refer
		from dpdeptslip  
		where refer_slipno = :ls_slipno and 
		recppaytype_code in ('OTR','DTR')
		using itr_sqlca;
		
		ls_tofromaccid2		= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_dept_refer, 1, "account_id"  ) )
		if isnull (ls_tofromaccid2) or ls_tofromaccid2 = ""  then ls_tofromaccid2 = ls_tofromaccid
	end if
	
end if

////////////////////////////////////


	////////////สร้าง Voucher////////////////////////
	 //if  li_deptgroup_code <> li_deptgroup_code_bf    then
			//ls_voucher_type	= "JV"	
			//is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			//if(li_deptgroup_code = 1) then
				//ls_desc  				= "รายการฝากถอนเงินกลุ่มประจำ(รายการโอน)"		
				//else
				//ls_desc  				= "รายการฝากถอนเงินกลุ่มออมทรัพย์(รายการโอน)"		
			//end if
			//this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
	//else
			//ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			//ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 //end if
		
	choose case ls_mapacc
		case "AIT"
			ls_accintarrid	= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
			ll_sortintarr		= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, "sortintarr_order" ) )
			ldc_itempay		= ldc_itempay 
			ls_colname		= "accint_id"
			ls_colsort		= "sortint_order"
		case "ATX"
			ls_colname		= "acctax_id"
			ls_colsort		= "sorttax_order"
			ldc_intbfyear	= 0.00
		case else
			ls_colname		= "account_id"
			ls_colsort		= "sortacc_order"
			ldc_intbfyear	= 0.00
	end choose
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, ls_colname  ) )
	ls_accint				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "accint_id"  ) )
	ls_accintarrid		= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
	ls_acctax				= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "acctax_id"  ) )
	ll_sortacc			= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, ls_colsort  ) )		
	ls_feeid				= string( of_getattribmapaccid( as_coopid ,"DEP", "FEE", "00", 1,  "account_id"  ) ) //ค่าปรับ
	
	
	if(li_accflag = 1) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"	
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if
	
		 if  ls_slipno_bf <> ls_slipno    then
			ls_voucher_type	= "JV"	
			ls_desc  		= ls_desc + " " + ls_deptno + " " + ls_deptname
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
	else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if
	 
	if ls_itemtype = 'INY'  then
		ls_accside			= "DR"
		ls_accrevside		= "CR"
		ls_tofromaccid2 	= ls_tofromaccid
		ldc_int_amt  		= ldc_int_amt - ldc_intbfyear
		ldc_itempaynet		= 0.00
		ldc_itempay			= ( ldc_itempay - ldc_tax ) * -1  //ทำเพื่อลบค่าออกจากยอดเต็มของฝาก ถอน
		ls_accid			= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "account_id"  ) )
	end if
	
	if ls_itemtype = 'INT' then
		ls_accside			= "DR"
		ls_accrevside		= "CR"
		ls_tofromaccid2 	= ls_tofromaccid
		ldc_itempay  		= ldc_itempay - ldc_intbfyear
		if( ldc_itempay < 0 ) then ldc_itempay = 0.00   //กรณียอด ดบ.ตั้งค้าง > ดบ.จ่าย  ลงแต่ยอด ดบ.ตั้งค้าง  แล้ว cr ดอกเบี้ยเงินฝากประจำค้างจ่ายรับคืน 
		ldc_int_amt 			= 0.00
	end if
	
	if ls_itemtype = 'TAX' then
		ls_accside			= "CR"
		ls_accrevside		= "DR"
		ls_tofromaccid2 	= ls_tofromaccid
	end if
	
	choose case ls_itemtype
		case "FEE"
			ls_accid = '42003000'
			ls_accside		= "CR"
			ls_accrevside	= "DR"	
		case "WFS"
			ls_accid = '31001000'
			ls_accside		= "CR"
			ls_accrevside	= "DR"
		case else
			ls_accid = ls_accid
	end choose
	
		//ดอกเบี้ยหลังหักภาษี
		ldc_pay = ldc_int_amt - ldc_tax
		
	//case INR ที่ปิดด้วยเงินสด แต่ INR ลงรายการโอน ต้องนำมาลงที่รายการโอน Edit By Mike 15/10/2014
	//case INR ที่ปิดด้วยรายการโอน ไม่ต้องนำ INR มาลง เอายอดจาก int_return จากใบถอนมาลงรายการ
	
	//ทำกั้นไว้กรณีปิดเป็นเงินสด แล้วรายการ INR จะส่งคู่บัญชี ( tofrom_accid ) มาเป็นเงินสด ต้องส่งมาเป็นรหัสดอกเบี้ยจ่าย
	// ใช้ประเภทเงินฝาก แทน ดบ.จ่าย edit by Apple 19/11/2563
	if( ls_itemtype = 'INR' and ls_refer_cashtype = 'CSH') then
		ls_tofromaccid2 = string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "account_id"  ) )
	end if
	
	
	
	if( ls_itemtype = 'INR' and ls_refer_cashtype <> 'CSH') then
		//ls_tofromaccid2 = string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "accint_id"  ) )
		ls_accside			= "CR"
		ls_accrevside		="DR"
		ldc_itempay  		= ldc_itempay 
		ls_tofromaccid2 = string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "account_id"  ) )
end if
	//else
	
	//รายการถอน
	if ( ldc_itempay > 0 ) or ( ldc_itempay < 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_int_amt > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accint, ls_accside, ldc_int_amt , "", ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_tax_return > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_acctax, ls_accside, ldc_tax_return, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	//	//ดอกเบี้ยค้างรับค้างจ่าย
	if (ldc_intbfyear > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accside, ldc_intbfyear, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	//เพิ่มเติม ยิงข้อมูลเข้าแทนรายการ INR 03/10/2014 Edit By Mike
	if (ldc_intreturn > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_intreturn, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	
	
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempaynet > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno,ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid2 , ls_accrevside, ldc_itempaynet - ldc_tax  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	if 	( ldc_intreturn > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno,ls_tmpsystem, ls_tmpvcgrp, ls_accint , ls_accrevside, ldc_intreturn  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	if 	( ldc_tax > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno,ls_tmpsystem, ls_tmpvcgrp, ls_acctax , ls_accrevside, ldc_tax  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	//กรณี ดบ.ตั้งค้าง มากกว่า ดบ.จ่าย ลงรายการ ดบ.เงินฝากประจำค้างจ่ายรับคืน 
	if( ldc_intbfyear > ldc_checkint) then 
		this.of_additem( as_coopid , is_vcrcvtrndocno,ls_tmpsystem, ls_tmpvcgrp, ls_accint , ls_accrevside, ldc_intbfyear - ldc_checkint  , 1, ids_vcrcvpaydet  , as_userid )
//		this.of_additem( as_coopid , is_vcrcvtrndocno,ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid2 , ls_accrevside, ldc_itempay  , 1, ids_vcrcvpaydet  , as_userid )
	end if
		if( ldc_orther > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp,ls_feeid , ls_accrevside, ldc_orther  , 1, ids_vcrcvpaydet  , as_userid )
	end if
//end if
	
	
	
	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno_bf <> ls_slipno 	then
		update	dpdeptslip
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( deptslip_no		= :ls_slipno ) and
				( deptcoop_id 		= :as_coopid) and
				( coop_id 			= :ls_coopid)
		using itr_sqlca;
	end if
	
	ls_accid_bf 				= ls_accid
	ls_depttype_bf			= ls_depttype
	ls_itemtype_bf			= ls_itemtype
	li_deptgroup_code_bf		= li_deptgroup_code
	ls_slipno_bf = ls_slipno
		
next

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

public function integer of_gen_vc_close_year (integer ai_year, integer ai_period, string as_coopid) throws Exception; /***********************************************************
<description>
	ประมวลผลสร้าง Voucher ปิดสิ้นปี
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 10/02/2015 by Sakuraii
</usage> 
***********************************************************/
string		 ls_av_no, ls_vcno, ls_accid, ls_voucher_type, ls_benifit_total_acc
string		ls_accside, ls_accrevside
integer	li_vcno
long		ll_index, ll_count
datetime	adtm_date_end, ldtm_start_endperiod
dec{2}	ldc_forward_dr, ldc_forward_cr , ldc_pl_sumall

datastore	lds_slipdata, lds_slipdata2

// ds สำหรับดึงข้อมูลรายการโอนปิดบัญชี
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_gen_close_year"
lds_slipdata.settransobject( itr_sqlca )

ll_count			= lds_slipdata.retrieve( ai_year, ai_period  , as_coopid   )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return -1
end if
//หาวันที่สุดท้ายของปีบัญชี
select		ending_of_account
into		:adtm_date_end
from		accaccountyear
where	account_year	= :ai_year and
			coop_id		= :as_coopid using itr_sqlca;

if itr_sqlca.sqlcode <> 0 then
	ithw_exception.text	= "ไม่สามารถตรวจสอบช่วงวันที่ของปีบัญชีได้ " + itr_sqlca.sqlerrtext
	throw ithw_exception
end if

// สร้างเลข Voucher
is_vcrcvtrndocno = ""

//วันเริ่มต้นงวดสุดท้าย
	ldtm_start_endperiod = datetime( date( year( date( adtm_date_end ) ), month( date( adtm_date_end ) ), 1  ) )
	
	//หา voucher_JV ล่าสุดของงวดสุดท้าย
	select substr(max(voucher_no),7,4) , substr(max(voucher_no),1,6)
	into	:ls_av_no, :ls_vcno
	from  	vcvoucher
	where voucher_date between :ldtm_start_endperiod and :adtm_date_end and
			voucher_no	like 'AV%'		and
			coop_id		= :as_coopid	
			using itr_sqlca;
			
	if isnull(ls_av_no) or ls_av_no = "" then ls_av_no = '0000'
	if isnull(ls_vcno) or ls_vcno = "" then ls_vcno = 'AV' + mid(string( ai_year + 543), 3 , 2) + string(ai_period,'00')
	
	li_vcno = integer(ls_av_no) + 1
	
	ls_vcno = ls_vcno + string(li_vcno,'0000')

	//เพิ่มใหม่ ดึง voucher ทั้งหมดจากระบบนั้นๆ แล้วแยกใบ voucher ในท่อนโค๊ดนี้ตามประเภทรายการ
	if ( is_vcrcvtrndocno = "" ) then
		ls_voucher_type	= "AV"
//		is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_date_end , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
		is_vcrcvtrndocno  = ls_vcno
		this.of_addvoucher( is_vcrcvtrndocno , adtm_date_end , ls_voucher_type , "โอนปิดรายได้-ค่าใช้จ่ายเข้ากำไรสุทธิรอจัดสรร", 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , "ACC" )		
	else
		ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
		ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	
////////ยิงรายการที่ไม่มีข้องบประมาณ///////////////////////
for ll_index = 1 to ll_count
		
	ls_accid				= lds_slipdata.object.account_id[ ll_index ]
	ldc_forward_dr		= lds_slipdata.object.forward_dr_amount[ ll_index ]
	ldc_forward_cr		= lds_slipdata.object.forward_cr_amount[ ll_index ]


		ls_accside		= "DR"
		ls_accrevside	= "CR"
		
	// รายการจ่ายเงิน DR
	if ( ldc_forward_dr > 0 ) then
		this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, "TRN", "TRN", ls_accid  , ls_accrevside, ldc_forward_dr, "", 1, ids_vcrcvpaydet)
	end if
	
	// รายการฝั่งตรงข้าม CR
	if 	( ldc_forward_cr > 0 ) then		
		this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_accid , ls_accside, ldc_forward_cr  , 1, ids_vcrcvpaydet  , "ACC" )
	end if
			
next

//หายอดกำไรสุทธิ
//ldc_pl_sumall = inv_account_service.of_get_profit_period( ai_year, ai_period  , as_coopid )
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

dec{2}		ldc_fw_dr_rec, ldc_fw_cr_rec, ldc_fw_dr_pay, ldc_fw_cr_pay
dec{2}		 ldc_total_rec, ldc_total_pay

SELECT	sum(accsumledgerperiod.forward_dr_amount),   
			sum(accsumledgerperiod.forward_cr_amount)
INTO		:ldc_fw_dr_rec,   
			:ldc_fw_cr_rec
FROM		accmaster, accsumledgerperiod  
WHERE  	( accsumledgerperiod.account_id		= accmaster.account_id ) and  
			( ( accsumledgerperiod.account_year	= :ai_year ) AND  
			( accsumledgerperiod.period			= :ai_period ) AND  
			( accmaster.account_group_id			= '4' ) )  and
			( accsumledgerperiod.coop_id		= :as_coopid )  
			using itr_sqlca;

if isnull( ldc_fw_dr_rec ) then ldc_fw_dr_rec = 0.00
if isnull( ldc_fw_cr_rec ) then ldc_fw_cr_rec = 0.00

ldc_total_rec	= ldc_fw_cr_rec - ldc_fw_dr_rec

//ค่าใช้จ่าย
SELECT	sum(accsumledgerperiod.forward_dr_amount),   
			sum(accsumledgerperiod.forward_cr_amount)
INTO		:ldc_fw_dr_pay,   
			:ldc_fw_cr_pay
FROM		accmaster,   
			accsumledgerperiod  
WHERE		( accsumledgerperiod.account_id		= accmaster.account_id ) and  
			( ( accsumledgerperiod.account_year	= :ai_year ) AND  
			( accsumledgerperiod.period			= :ai_period ) AND  
			( accmaster.account_group_id			= '5' ) ) and
			( accsumledgerperiod.coop_id		= :as_coopid ) using itr_sqlca;

if isnull( ldc_fw_dr_pay ) then ldc_fw_dr_pay = 0.00
if isnull( ldc_fw_cr_pay ) then ldc_fw_cr_pay = 0.00

ldc_total_pay	= ldc_fw_dr_pay - ldc_fw_cr_pay

// ยอดคงเหลือจริง
ldc_pl_sumall	= ldc_total_rec - ldc_total_pay

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

select benifit_total_acco
into :ls_benifit_total_acc
from accconstant
where coop_id = :as_coopid
using itr_sqlca;

	if(ldc_pl_sumall > 0 ) then 
		this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, "TRN", "TRN", ls_benifit_total_acc  , ls_accrevside, ldc_pl_sumall, "", 1, ids_vcrcvpaydet)
	end if
	if(ldc_pl_sumall < 0 ) then 
		this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_benifit_total_acc , ls_accside, ldc_pl_sumall  , 1, ids_vcrcvpaydet  , "ACC" )
	end if
	

destroy( lds_slipdata )
destroy( lds_slipdata2 )
//update
if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

//update ให้ผ่านรายการไปแยกประเภทเลย
update vcvoucher
set posttoacc_flag = 1
where voucher_no = :is_vcrcvtrndocno
using itr_sqlca;


return 1
end function

private function integer of_vccashfinrcv_tax (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
 Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการรับการเงิน เงินสด  ภาษี
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/
string		ls_slipno, ls_slipprior, ls_accid, ls_tofromaccid, ls_slipitem_desc
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_desc, ls_voucher_type
long		ll_index, ll_count
dec{2}	ldc_itempay

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashfnrcv_tax"
lds_slipdata.settransobject( itr_sqlca )

// reset เงินสดรับ
ll_count	= lds_slipdata.retrieve( adtm_vcdate,as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if


ls_tmpsystem		= "FIN"
ls_tmpvcgrp			= "DAY"
is_vcrcvdocno    =  ""

// สร้างเลข Voucher

	 if  is_vcrcvdocno    =  ""  then
			ls_voucher_type	= "RV"
			ls_desc  				= "เงินสดรับประจำวัน"		
			is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	

//ทำรายการ Voucher
for ll_index = 1 to ll_count
	ls_slipno					= trim( lds_slipdata.object.slip_no[ ll_index ] )
	ldc_itempay				= lds_slipdata.object.tax_amt[ ll_index ]	
	ls_slipitem_desc		= trim( lds_slipdata.object.slipitem_desc[ ll_index ] )
	ls_tofromaccid			= trim( lds_slipdata.object.tofrom_accid[ ll_index ] )

	
	ls_accside			= "CR"
	ls_accrevside		= "DR"
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"FIN", "TAX", "01", 1, "account_id"  ) )
	
		if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	
		// รายการการเงิน
	if ( ldc_itempay > 0 ) then		
		this.of_additemdesc( as_coopid , is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_slipitem_desc, 0, ids_vcrcvdet)
		this.of_additem( as_coopid ,is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet  , as_userid )
	end if

	// Update สถานะการผ่าน Voucher
//		update	finslipdet
//		set			posttovc_flag	= 1,	
//					voucher_no		= :is_vcrcvdocno
//		where	( slip_no			= :ls_slipno )  and
//					( coop_id 		= :as_coopid)
//		using     itr_sqlca   ;	
next

//update
if ids_vcrcv.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvdet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

destroy (lds_slipdata)
return 1
end function

private function integer of_vctrn_kpmth_dppay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> ถอน + ปิดบัญชี แยกดอกเบี้ย เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_colsort, ls_month, ls_date
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			s_acccr_id,ls_accdr_id,ls_branchid,ls_branchorigin,ls_desc,ls_oldbranchid,ls_cash
integer		li_slipflag,ll_find,li_flag, li_payfee_meth
long			ll_index, ll_count, ll_sortacc, ll_sortintarr, ll_index2
dec{2}		ldc_itempay, ldc_intarrpay,ldc_prncbal,ldc_int_amt,ldc_accuint_amt, ldc_intreturn, ldc_slipnetamt
string			ls_deptgroupcode, ls_itemgroup, ls_accid_bf, ls_depttype_code, ls_vc_desc, ls_itemdesc  
string			ls_depttype_group, ls_refsystem, ls_depttype_group_temp, ls_voucher_type , ls_vc_type , as_vcdocno
dec{2}		ldc_other_amt, ldc_intbfyear , ldc_itempaynet, ldc_tax_return, ldc_tax
datetime		ldtm_operate
string			ls_accid_old, ls_acccash, ls_depttype_bf, ls_itemtype_bf, ls_accint, ls_acctax,ls_kpaccid

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_kp_trndppay_tks"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem					= "DEP"
ls_tmpvcgrp						= "MTH"
ls_depttype_group_temp		= ""
ls_accid_bf 						= ""
ll_index2							=	1
is_vcrcvtrndocno				= ""

	 if  is_vcrcvtrndocno = ""   then
			ls_voucher_type	= "JV"	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , "รายการถอนจัดเก็บประจำเดือน", 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
	else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

for ll_index = 1 to ll_count

	ls_slipno					= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_itemtype				= lds_slipdata.object.recppaytype_code[ ll_index ]
	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_mapacc				= lds_slipdata.object.accmap_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_amt[ ll_index ]
	ldc_int_amt				= lds_slipdata.object.int_amt[ ll_index ]	
	ldc_accuint_amt		= lds_slipdata.object.accuint_amt[ ll_index ]
	ldc_intreturn			= lds_slipdata.object.int_return[ ll_index ]
	ls_deptgroupcode		= lds_slipdata.object.deptgroup_code[ ll_index ]
	ls_itemgroup			= lds_slipdata.object.group_itemtpe[ ll_index ]
	ldc_itempaynet			= lds_slipdata.object.deptslip_netamt[ ll_index ]
	ldc_other_amt			= lds_slipdata.object.other_amt[ ll_index ] ; 
	li_payfee_meth			= lds_slipdata.object.payfee_meth[ ll_index ] ; 
	ldc_intbfyear			= lds_slipdata.object.int_bfyear[ ll_index ]
	ls_desc					= trim(lds_slipdata.object.compute_3[ ll_index ])
	ldc_tax_return			= lds_slipdata.object.tax_return[ ll_index ]
	ldc_tax					= lds_slipdata.object.tax_amt[ ll_index ]	
	
//	if isnull (ls_tofromaccid)  then ls_tofromaccid = '000000'	
	if isnull( ldc_other_amt ) then ldc_other_amt = 0
	if isnull( li_payfee_meth ) then li_payfee_meth = 0
	if isnull( ldc_int_amt ) then ldc_int_amt = 0
	if isnull( ldc_accuint_amt ) then ldc_accuint_amt = 0
	if isnull( ldc_intreturn ) then ldc_intreturn = 0
	if isnull(ldc_intbfyear) then ldc_intbfyear = 0
		
	choose case ls_mapacc
		case "AIT"
			ls_accintarrid	= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
			ll_sortintarr		= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, "sortintarr_order" ) )
			ldc_itempay		= ldc_itempay 
			ls_colname		= "accint_id"
			ls_colsort		= "sortint_order"
		case "ATX"
			ls_colname		= "acctax_id"
			ls_colsort		= "sorttax_order"
			ldc_intbfyear	= 0.00
		case else
			ls_colname		= "account_id"
			ls_colsort		= "sortacc_order"
			ldc_intbfyear	= 0.00
	end choose
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, ls_colname  ) )
	ls_accint				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "accint_id"  ) )
	ls_accintarrid		= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
	ls_acctax				= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "acctax_id"  ) )
	ll_sortacc			= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, ls_colsort  ) )	
	ls_kpaccid			= string	( of_getattribmapaccid( as_coopid, "KEP", "KEP" , "01", 1, "account_id" ) ) //รหัสลูกหนี้ตัวแทน
	
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	
	choose case ls_itemtype
		case "FEE"
			ls_accid = '42003000'
			ls_accside		= "CR"
			ls_accrevside	= "DR"	
		case "WFS"
			ls_accid = '31001000'
			ls_accside		= "CR"
			ls_accrevside	= "DR"
		case else
			ls_accid = ls_accid
	end choose
		


	//รายการถอน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_int_amt > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accint, ls_accside, ldc_int_amt, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_tax_return > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_acctax, ls_accside, ldc_tax_return, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempaynet > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_kpaccid , ls_accrevside, ldc_itempaynet  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	if 	( ldc_intreturn > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_accintarrid , ls_accrevside, ldc_intreturn  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	if 	( ldc_tax > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_acctax , ls_accrevside, ldc_tax  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	
	
	
	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcrcvtrndocno)    	then
		update	dpdeptslip
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( deptslip_no	= :ls_slipno ) and
					( coop_id 		= :as_coopid)
		using itr_sqlca;
	end if
	
	ls_accid_bf 				= ls_accid
	ls_depttype_bf			= ls_depttype
	ls_itemtype_bf			= ls_itemtype
		
next

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vctrn_kpmth_dprcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> ฝาก + เปิดบัญชี เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string			ls_slipno, ls_mapacc, ls_accid, ls_accintarrid, ls_colname, ls_colsort, ls_date, ls_month
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_branchid,ls_branchorigin,ls_acccr_id,ls_accdr_id,ls_desc,ls_oldbranchid
integer		li_slipflag,ll_seqno,ll_find,li_flag
long			ll_index, ll_count, ll_sortacc, ll_sortintarr
dec{2}		ldc_itempay, ldc_intarrpay
datetime		ldtm_operate
string			ls_depttype_group, ls_vcrcvdocno, ls_cash, ls_depttype_code, ls_vc_desc, ls_voucher_type
string			ls_accid_bf, ls_refsystem, ls_depttype_group_temp , as_vcdocno , ls_itemdesc
string			ls_coopid , ls_deptcoopid, ls_acccash, ls_depttype_bf, ls_itemtype_bf, ls_kpaccid

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_kp_trndprcv_tks"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem		= "DEP"
ls_tmpvcgrp			= "MTH"
ls_accid_bf 			= ""
is_vcrcvtrndocno	= ""

	 if  is_vcrcvtrndocno = ""  then
			ls_voucher_type	= "JV"	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , "รายการฝากจัดเก็บประจำเดือน", 0 , ids_vcrcvpay , 'TRN'  , as_coopid,   as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 


for ll_index = 1 to ll_count
	
	ls_coopid					= lds_slipdata.object.coop_id[ ll_index ]
	ls_deptcoopid			= lds_slipdata.object.deptcoop_id[ ll_index ]
	ls_slipno					= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_itemtype				= lds_slipdata.object.recppaytype_code[ ll_index ]
	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_mapacc				= lds_slipdata.object.accmap_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_netamt[ ll_index ]
	ls_desc					= trim(lds_slipdata.object.compute_3[ ll_index ])
		
//	if isnull (ls_tofromaccid)  then ls_tofromaccid = '000000'	

	// ตรวจว่าเป็นรายการเกี่ยวกับอะไร
choose case ls_mapacc
		case "AIT"
			ls_accintarrid	= string( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
			ll_sortintarr		= long( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "sortintarr_order" ) )
			ldc_itempay		= ldc_itempay 
			ls_colname		= "accint_id"
			ls_colsort		= "sortint_order"
		case "ATX"
			ls_colname		= "acctax_id"
			ls_colsort		= "sorttax_order"
		case else
			ls_colname		= "account_id"
			ls_colsort		= "sortacc_order"			
	end choose
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, ls_colname  ) )
	ll_sortacc			= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, ls_colsort  ) )	
	ls_kpaccid			= string	( of_getattribmapaccid( as_coopid, "KEP", "KEP" , "01", 1, "account_id" ) ) //รหัสลูกหนี้ตัวแทน
	
		ls_accside			= "CR"
		ls_accrevside		= "DR"	
		
		
			
	// รายการเงินฝาก
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, "", ll_sortacc, ids_vcrcvpaydet)
	end if
	
	/// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
		this.of_additem( as_coopid ,is_vcrcvtrndocno,"TRN", "TRN", ls_kpaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	
	//update สถานะการดึงข้อมูล
	if	not isnull(is_vcrcvtrndocno)    	then
		update	dpdeptslip
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( deptslip_no	= :ls_slipno ) and
					( coop_id 		= :as_coopid)
		using itr_sqlca;
	end if
	
	ls_accid_bf 						= ls_accid
	ls_depttype_group_temp		= ls_depttype_group
	ls_depttype_bf					= ls_depttype
	ls_itemtype_bf					= ls_itemtype
	
next

destroy( lds_slipdata )

//update
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if
	
return 1
end function

private function integer of_vccashfinpay_split (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
 Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่ายการเงิน เงินสด ลง voucher ตาม slip การเงิน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/
string			ls_slipno, ls_slipprior, ls_accid, ls_tofromaccid, ls_desc
string			ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp ,ls_slipitem_desc
long			ll_index, ll_count
dec{2}		ldc_itempay
string			ls_itemdesc , ls_coopid, ls_voucher_type

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashfnpay_split"
lds_slipdata.settransobject( itr_sqlca )
 
ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

//ls_desc	= "จ่ายเงิน"
ls_tmpsystem		= "FIN"
ls_tmpvcgrp			= "DAY"


for ll_index = 1 to ll_count
	ls_slipno				= lds_slipdata.object.slip_no[ ll_index ]
	ldc_itempay				= lds_slipdata.object.itempay_amt[ ll_index ]	//ปรับให้เป็นยอดจ่ายเต็ม เพราะภาษีลงฝั่งรับแล้ว edit by mike 12/1/2016
	ls_accid				= lds_slipdata.object.account_id[ ll_index ]
	ls_slipitem_desc		= trim( lds_slipdata.object.slipitem_desc[ ll_index ] )
	ls_tofromaccid			= trim( lds_slipdata.object.tofrom_accid[ ll_index ] )
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_desc					= trim(lds_slipdata.object.nonmember_detail[ ll_index ])
	
	if isnull( ldc_itempay ) then ldc_itempay = 0
	if IsNull( ls_desc ) or ls_desc = "" then ls_desc = "รายการจ่ายการเงิน"
			
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	
	// สร้างเลข Voucher

	 if  ls_slipno <> ls_slipprior then
			ls_voucher_type	= "PV"
			//ls_desc  				= "เงินสดจ่ายประจำวัน"		
			is_vcpaydocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_coopid  )
			this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcpay , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcpay.retrieve( is_vcpaydocno )
			ids_vcpaydet.retrieve( is_vcpaydocno )
	 end if 	
	
	//รายการการเงิน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_slipitem_desc, 1, ids_vcpaydet)
		this.of_additem( as_coopid ,is_vcpaydocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcpaydet  , as_userid )
	end if	
		
	//update สถานะการดึงข้อมูล
	if ls_slipno <> ls_slipprior then
		update		finslipdet
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcpaydocno
		where		( slip_no			= :ls_slipno ) and
					( coop_id 		= :ls_coopid)
		
		using    	itr_sqlca   ;	
		
		ls_slipprior	= ls_slipno
		
	end if

next

destroy (lds_slipdata)
// update Vc
if ids_vcpay.update() <> 1 then	
	return -1
end if
	
if ids_vcpaydet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then	
	return -1
end if
	
if ids_voucherdet.update() <> 1 then	
	return -1
end if


return 1
end function

private function integer of_vctrnfinpay_split (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่ายการเงิน เงินโอน ลงแยก slip ละ 1 voucher
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_slipprior, ls_accid, ls_taxid
string			ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp ,ls_slipitem_desc
string			ls_itemtype, ls_tofromaccid, ls_desc			
long			ll_index, ll_count,ll_find, ll_index2
dec{2}			ldc_itempay,ldc_tax_amt,ldc_itembal, ldc_itemamtnet
string			ls_accid_bf , ls_itemdesc , ls_coopid , ls_detail
string			ls_voucher_type 

datastore		lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnfnpay_split"
lds_slipdata.settransobject( itr_sqlca )
 
ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

//ls_desc	= "จ่ายเงิน"
ls_tmpsystem		= "FIN"
ls_tmpvcgrp			= "DAY"
ls_accid_bf			= ""
ll_index2			=	1

for ll_index = 1 to ll_count
	ls_slipno				= lds_slipdata.object.slip_no[ ll_index ]
	ldc_itempay				= lds_slipdata.object.itempay_amt[ ll_index ]	
	ls_accid				= lds_slipdata.object.account_id[ ll_index ]
	ls_slipitem_desc		= trim( lds_slipdata.object.slipitem_desc[ ll_index ] )
	ls_tofromaccid			= trim( lds_slipdata.object.tofrom_accid[ ll_index ] )	
	ldc_tax_amt				= lds_slipdata.object.tax_amt[ ll_index ]
	ldc_itemamtnet			= lds_slipdata.object.item_amtnet[ ll_index ]
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_detail				= lds_slipdata.object.nonmember_detail[ ll_index ]
	ls_desc					= lds_slipdata.object.payment_desc[ ll_index ]
	
	if isnull( ldc_tax_amt ) then ldc_tax_amt = 0
	ls_taxid				= string( of_getattribmapaccid( as_coopid ,"FIN", "TAX", "01", 1, "account_id"  ) )	
	ls_accside		= "DR"
	ls_accrevside	= "CR"			
	
	// สร้างเลข Voucher

	 if ( ls_slipprior <>  ls_slipno ) then
			ls_voucher_type	= "JV"
			//ls_desc  				= "รายการโอน(การเงินจ่าย)"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	
	
	//รายการการเงิน
if (ldc_tax_amt > 0) then
	if ( ldc_itempay > 0 ) then
		ldc_itempay = ldc_itemamtnet + ldc_tax_amt
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_slipitem_desc, 77777, ids_vcrcvpaydet )
		this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid, ls_accrevside, ldc_itemamtnet, ls_itemdesc, 77777, ids_vcrcvpaydet)
		this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_taxid, ls_accrevside, ldc_tax_amt, ls_itemdesc, 77777, ids_vcrcvpaydet)
	end if
else
	if ( ldc_itemamtnet > 0 ) then
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_slipitem_desc, 77777, ids_vcrcvpaydet )
		this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid, ls_accrevside, ldc_itempay, ls_itemdesc, 77777, ids_vcrcvpaydet)
	end if
end if
		
	//update สถานะการดึงข้อมูล
	if ls_slipno <> ls_slipprior then
		update	finslipdet
		set		posttovc_flag	= 1,	
				voucher_no		= :is_vcrcvtrndocno
		where	( slip_no		= :ls_slipno ) and
				( coop_id		= :ls_coopid )
		using   itr_sqlca   ;	
		
		ls_slipprior	= ls_slipno
	end if
	
	ls_accid_bf	= ls_accid

next

destroy( lds_slipdata )
// update Vc
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then	
	return -1
end if
	
if ids_voucherdet.update() <> 1 then	
	return -1
end if

return 1
end function

private function integer of_set_voucher_no (datetime adtm_date, string as_coopid, string as_type) throws Exception;integer		li_pvno, li_rvno, li_jvno, li_year, li_period, li_avno, li_tvno
string		ls_pvno, ls_rvno, ls_jvno, ls_avno, ls_tvno
datetime	ldtm_endperiod, ldtm_start_endperiod, ldtm_start_year

	select min(period_end_date)
	into	:ldtm_endperiod
	from	accperiod
	where	period_end_date >= :adtm_date and 
				coop_id		  = :as_coopid	
	using itr_sqlca;
	
	if IsNull(ldtm_endperiod) then 
		ldtm_start_endperiod	= datetime( date( year( date( adtm_date ) ) , month( date( adtm_date ) ), 1  ) )
		ldtm_endperiod			= datetime( date( year( date( adtm_date ) )  , month( date( adtm_date ) ), 30 ) )
	else
	
	//วันเริ่มต้นงวด
	if (as_type = '01') then  //ขึ้นเลขใหม่ทุกสิ้นเดือน
		ldtm_start_endperiod	= datetime( date( year( date( ldtm_endperiod ) ) , month( date( ldtm_endperiod ) ), 1  ) )
	else
		//หาวันที่เริ่มต้นปีบัญชี
		select beginning_of_accou
		into	:ldtm_start_year
		from accconstant
		where coop_id = :as_coopid
		using itr_sqlca;
		
		ldtm_start_endperiod	= datetime( date( year( date( ldtm_start_year ) ) , month( date( ldtm_start_year ) ), 1  ) )
	end if
	ldtm_endperiod			= datetime( date( year( date( ldtm_endperiod ) )  , month( date( ldtm_endperiod ) ),  day( date( ldtm_endperiod ) ) ) )
	end if
	
	if (as_type = '00') then  //ขึ้นเลขใหม่ทุกสิ้นวัน
		ldtm_start_endperiod  = adtm_date
		ldtm_endperiod = adtm_date
	end if
		
		
	//////////หาเลขที่เอกสารของปีเก่า//////////////////
	select substring(max(voucher_no),7,4)
	into	:ls_pvno
	from	vcvoucher
	where voucher_date between :ldtm_start_endperiod and :ldtm_endperiod   and
			voucher_no	like 'PV%'		and
			coop_id			= :as_coopid	
	using itr_sqlca;
	
	select substring(max(voucher_no),7,4)
	into	:ls_rvno
	from	vcvoucher
	where voucher_date between :ldtm_start_endperiod and :ldtm_endperiod   and
			voucher_no	like 'RV%'		and
			coop_id			= :as_coopid	
	using itr_sqlca;
	
	select substring(max(voucher_no),7,4)
	into	:ls_jvno
	from	vcvoucher
	where voucher_date between :ldtm_start_endperiod and :ldtm_endperiod   and
			voucher_no	like 'JV%'		and
			coop_id			= :as_coopid	
	using itr_sqlca;
	
	select substring(max(voucher_no),7,4)
	into	:ls_avno
	from	vcvoucher
	where voucher_date between :ldtm_start_endperiod and :ldtm_endperiod   and
			voucher_no	like 'AV%'		and
			coop_id			= :as_coopid	
	using itr_sqlca;
	
	select substring(max(voucher_no),7,4)
	into	:ls_tvno
	from	vcvoucher
	where voucher_date between :ldtm_start_endperiod and :ldtm_endperiod   and
			voucher_no	like 'TV%'		and
			coop_id			= :as_coopid	
	using itr_sqlca;
	

	
	if isnull(ls_pvno) or ls_pvno = "" then ls_pvno = '0'
	if isnull(ls_rvno) or ls_rvno = "" then ls_rvno = '0'
	if isnull(ls_jvno) or ls_jvno = "" then ls_jvno = '0'
	if isnull(ls_avno) or ls_avno = "" then ls_avno = '0'
	if isnull(ls_tvno) or ls_tvno = "" then ls_tvno = '0'

	
	li_pvno	= integer(ls_pvno)
	li_rvno	= integer(ls_rvno)
	li_jvno	= integer(ls_jvno)
	li_avno	= integer(ls_avno)
	li_tvno	= integer(ls_tvno)
	
	
	//update เลขที่เอกสาร Voucher
update 	cmdocumentcontrol
set			last_documentno	= :li_pvno
where 	( document_code = 'CMVOUCHERNO_PV' ) and
			( coop_id			= :as_coopid	  )
using itr_sqlca;

update 	cmdocumentcontrol
set			last_documentno	= :li_rvno
where 	( document_code = 'CMVOUCHERNO_RV' ) and
			( coop_id				= :as_coopid	  )
using itr_sqlca;

update 	cmdocumentcontrol
set			last_documentno	= :li_jvno
where 	( document_code = 'CMVOUCHERNO_JV' ) and
			( coop_id			= :as_coopid	 )
using itr_sqlca;

update 	cmdocumentcontrol
set			last_documentno	= :li_avno
where 	( document_code = 'CMVOUCHERNO_AV' ) and
			( coop_id			= :as_coopid	 )
using itr_sqlca;

update 	cmdocumentcontrol
set			last_documentno	= :li_tvno
where 	( document_code = 'CMVOUCHERNO_TV' ) and
			( coop_id			= :as_coopid	 )
using itr_sqlca;


if itr_sqlca.sqlcode <> 0 then
	ithw_exception.text	= "ไม่สามารถอัพเดทเลขที่เอกสาร Voucher ได้  " + itr_sqlca.sqlerrtext
	rollback using itr_sqlca ;
	throw ithw_exception
end if

return 1
	
	/////////////////////////////////////////////////////////////////////////////////////
end function

private function integer of_vctrn_lnrespons (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> โอนหนี้ให้ผู้ค้ำ
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 29/08/2017 by Sakuraii
</usage> 
***********************************************************/
string		ls_slipno, ls_loantype, ls_accid, ls_slipno_bf
string		ls_accside, ls_accrevside, ls_voucher_type
long		ll_index, ll_count
dec{2}		ldc_itempay

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_trnlnrespons"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

is_vcrcvtrndocno				= ""

	 if  is_vcrcvtrndocno = ""   then
			ls_voucher_type	= "JV"	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , "รายการโอนหนี้ให้ผู้ค้ำ", 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
	else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

for ll_index = 1 to ll_count

	ls_slipno			= lds_slipdata.object.trnlnreq_docno[ ll_index ]
	ls_loantype			= lds_slipdata.object.loantype_code[ ll_index ]
	ldc_itempay			= lds_slipdata.object.trnln_prnamt[ ll_index ]
	
	if isnull( ldc_itempay ) then ldc_itempay = 0

	ls_accid	= string( of_getattribmapaccid( as_coopid, "LON", "LON", ls_loantype, 1, "account_id"  ) )
	
	ls_accside		= "DR"
	ls_accrevside	= "CR"	

	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, "LON", "TRN", ls_accid, ls_accside, ldc_itempay, "", 1, ids_vcrcvpaydet )
		this.of_additem( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_accid , ls_accrevside, ldc_itempay  , 2, ids_vcrcvpaydet  , as_userid )
	end if

	
	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno_bf <> ls_slipno    	then
		update	lnreqtrnlnrespons
		set		posttovc_flag		= 1,	
				voucher_no			= :is_vcrcvtrndocno
		where	( trnlnreq_docno	= :ls_slipno ) and
				( coop_id 			= :as_coopid)
		using itr_sqlca;
	end if
	
	ls_slipno_bf 				= ls_slipno
		
next

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vctrndiv_avg_cbt (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> จ่ายเงินปันผลเฉลี่ยคืน รายการโอน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified by Sakuraii
</usage> 
***********************************************************/
string			ls_slipno, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_colsort, ls_month, ls_date
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp, ls_bizztype
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_desc,ls_cash, ls_itemdesc
long			ll_index, ll_count, ll_sortacc
dec{2}			ldc_itempay, ldc_intarrpay,ldc_prncbal,ldc_int_amt,ldc_accuint_amt, ldc_intreturn, ldc_slipnetamt
string			ls_deptgroupcode, ls_itemgroup, ls_accid_bf, ls_depttype_code, ls_vc_desc  
string			ls_depttype_group, ls_refsystem,  ls_voucher_type , ls_vc_type , as_vcdocno
dec{2}			ldc_other_amt, ldc_intbfyear , ldc_itempaynet, ldc_tax_return, ldc_tax, ldc_pay, ldc_div, ldc_avg, ldc_fee, ldc_etc
datetime		ldtm_operate
string			ls_acccash, ls_depttype_bf, ls_itemtype_bf, ls_accint, ls_acctax,ls_divyear, ls_methpaytype, ls_methpaytype_bf
string			ls_divid, ls_avgid, ls_feeid

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_trndiv_avg_cbt"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem				= "DIV"
ls_tmpvcgrp					= "TRN"
ls_accid_bf 				= ""
is_vcrcvtrndocno			= ""

ls_divyear 			=	lds_slipdata.object.div_year[ 1 ]

	 if  is_vcrcvtrndocno = ""   then
			ls_voucher_type	= "JV"	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , "รายการโอนจ่ายเงินปันผล-เฉลี่ยคืน ผ่านธนาคาร" , 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
	else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

for ll_index = 1 to ll_count

	ls_slipno				= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_methpaytype			= lds_slipdata.object.methpaytype_code[ ll_index ]
	ls_bizztype				= lds_slipdata.object.bizztype_code[ ll_index ]
	ldc_div					= lds_slipdata.object.div_payment[ ll_index ]
	ldc_avg					= lds_slipdata.object.avg_payment[ ll_index ]
	ldc_fee					= lds_slipdata.object.fee_amt[ ll_index ]
	ldc_etc					= lds_slipdata.object.etc_payment[ ll_index ]
	ldc_itempay				= lds_slipdata.object.item_payment[ ll_index ]
	ls_accid				= lds_slipdata.object.tofrom_accid[ ll_index ]

	
	if isnull (ls_accid) or ls_accid = ""  then ls_accid = '11401000'	
	if isnull( ldc_div ) then ldc_div = 0
	if isnull( ldc_avg ) then ldc_avg = 0
	if isnull( ldc_fee ) then ldc_fee = 0
	if isnull( ldc_etc ) then ldc_etc = 0
			

	if ( trim(ls_methpaytype)  = "DEP") then //รายการโอนเข้าเงินฝาก
		ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_bizztype, 1, "account_id"  ) )
	end if
	
	ls_divid				= string( of_getattribmapaccid( as_coopid ,"DIV", "DIV", '01', 1, "account_id"  ) )
	ls_avgid				= string( of_getattribmapaccid( as_coopid, "DIV", "AVG", '01', 1, "account_id"  ) )
	ls_feeid				= string( of_getattribmapaccid( as_coopid, "DIV", "FEE", '01', 1, "account_id"  ) )
	
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	

	//รายการถอน
	if ( ldc_div > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_divid, ls_accside, ldc_div, "", 99, ids_vcrcvpaydet )
	end if
	if (ldc_avg > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_avgid, ls_accside, ldc_avg, "", 99, ids_vcrcvpaydet )
	end if
	if (ldc_fee > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_feeid, ls_accside, ldc_fee, "", 99, ids_vcrcvpaydet )
	end if
//	if (ldc_etc > 0) then
//		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_acctax, ls_accside, ldc_etc, ls_itemdesc, ll_sortacc, ids_vcrcvpaydet )
//	end if
	
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
			this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_itempay + ldc_fee, ls_itemdesc , 99, ids_vcrcvpaydet )
	end if

	
	
	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcrcvtrndocno)    	then
		update	yrslippayout
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( payoutslip_no	= :ls_slipno ) and
					( coop_id 		= :as_coopid)
		using itr_sqlca;
		
	end if
	
	ls_accid_bf 				= ls_accid
	ls_depttype_bf			= ls_depttype
	ls_itemtype_bf			= ls_itemtype
	ls_methpaytype_bf		= ls_methpaytype
		
next

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vctrndiv_avg_dep (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> จ่ายเงินปันผลเฉลี่ยคืน รายการโอนเข้าเงินฝาก
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified by Sakuraii
</usage> 
***********************************************************/
string			ls_slipno, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_colsort, ls_month, ls_date
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp, ls_bizztype
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_desc,ls_cash, ls_itemdesc
long			ll_index, ll_count, ll_sortacc
dec{2}			ldc_itempay, ldc_intarrpay,ldc_prncbal,ldc_int_amt,ldc_accuint_amt, ldc_intreturn, ldc_slipnetamt
string			ls_deptgroupcode, ls_itemgroup, ls_accid_bf, ls_depttype_code, ls_vc_desc  
string			ls_depttype_group, ls_refsystem,  ls_voucher_type , ls_vc_type , as_vcdocno
dec{2}			ldc_other_amt, ldc_intbfyear , ldc_itempaynet, ldc_tax_return, ldc_tax, ldc_pay, ldc_div, ldc_avg, ldc_fee, ldc_etc
datetime		ldtm_operate
string			ls_acccash, ls_depttype_bf, ls_itemtype_bf, ls_accint, ls_acctax,ls_divyear, ls_methpaytype, ls_methpaytype_bf
string			ls_divid, ls_avgid, ls_feeid

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_trndiv_avg_dep"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem				= "DIV"
ls_tmpvcgrp					= "TRN"
ls_accid_bf 				= ""
is_vcrcvtrndocno			= ""

ls_divyear 			=	lds_slipdata.object.div_year[ 1 ]

	 if  is_vcrcvtrndocno = ""   then
			ls_voucher_type	= "JV"	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , "รายการโอนจ่ายเงินปันผล-เฉลี่ยคืน เข้าเงินฝาก" , 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
	else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

for ll_index = 1 to ll_count

	ls_slipno				= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_methpaytype			= lds_slipdata.object.methpaytype_code[ ll_index ]
	ls_bizztype				= lds_slipdata.object.depttype[ ll_index ]
	ldc_div					= lds_slipdata.object.div_payment[ ll_index ]
	ldc_avg					= lds_slipdata.object.avg_payment[ ll_index ]
	ldc_fee					= lds_slipdata.object.fee_amt[ ll_index ]
	ldc_etc					= lds_slipdata.object.etc_payment[ ll_index ]
	ldc_itempay				= lds_slipdata.object.item_payment[ ll_index ]
	ls_accid				= lds_slipdata.object.tofrom_accid[ ll_index ]

	
	//if isnull (ls_accid) or ls_accid = ""  then ls_accid = '11401000'	
	if isnull( ldc_div ) then ldc_div = 0
	if isnull( ldc_avg ) then ldc_avg = 0
	if isnull( ldc_fee ) then ldc_fee = 0
	if isnull( ldc_etc ) then ldc_etc = 0
			

	if ( trim(ls_methpaytype)  = "DEP") then //รายการโอนเข้าเงินฝาก
		ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_bizztype, 1, "account_id"  ) )
	end if
	
	ls_divid				= string( of_getattribmapaccid( as_coopid ,"DIV", "DIV", '01', 1, "account_id"  ) )
	ls_avgid				= string( of_getattribmapaccid( as_coopid, "DIV", "AVG", '01', 1, "account_id"  ) )
	ls_feeid				= string( of_getattribmapaccid( as_coopid, "DIV", "FEE", '01', 1, "account_id"  ) )
	
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	

	//รายการถอน
	if ( ldc_div > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_divid, ls_accside, ldc_div, "", 99, ids_vcrcvpaydet )
	end if
	if (ldc_avg > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_avgid, ls_accside, ldc_avg, "", 99, ids_vcrcvpaydet )
	end if
	if (ldc_fee > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_feeid, ls_accside, ldc_fee, "", 99, ids_vcrcvpaydet )
	end if
//	if (ldc_etc > 0) then
//		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_acctax, ls_accside, ldc_etc, ls_itemdesc, ll_sortacc, ids_vcrcvpaydet )
//	end if
	
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
			this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_itempay + ldc_fee, ls_itemdesc , 99, ids_vcrcvpaydet )
	end if

	
	
	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcrcvtrndocno)    	then
		update	yrslippayout
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( payoutslip_no	= :ls_slipno ) and
					( coop_id 		= :as_coopid)
		using itr_sqlca;
		
	end if
	
	ls_accid_bf 				= ls_accid
	ls_depttype_bf			= ls_depttype
	ls_itemtype_bf			= ls_itemtype
	ls_methpaytype_bf		= ls_methpaytype
		
next

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vctrndiv_avg_payin (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;
/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> จ่ายเงินปันผลเฉลี่ยคืน รายการโอนภายในชำระหนี้
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified by Sakuraii
</usage> 
***********************************************************/
string			ls_slipno, ls_accid, ls_accintarrid, ls_itemtype, ls_accintid, ls_payinslipno
string			ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_bizztype, ls_slipno_bf
integer		li_shrlonstatus
long			ll_index, ll_count
dec{2}		ldc_itempay, ldc_prinpay, ldc_intpay, ldc_div, ldc_avg, ldc_fee, ldc_etc, ldc_intarrear
string			ls_methpaytype, ls_divid, ls_avgid, ls_feeid, ls_shrlontype, ls_divyear

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_trndiv_avg_payin"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem					= "DIV"
ls_tmpvcgrp						= "TRN"
is_vcrcvtrndocno			= ""

ls_divyear 			=	lds_slipdata.object.div_year[ 1 ]

	 if  is_vcrcvtrndocno = ""   then
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , "JV" , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , "JV" , "รายการโอนจ่ายเงินปันผล-เฉลี่ยคืน ชำระหนี้" , 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
	else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

for ll_index = 1 to ll_count

	ls_slipno					= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_payinslipno			= lds_slipdata.object.payinslip_no[ ll_index ]
//	ls_methpaytype			= lds_slipdata.object.methpaytype_code[ ll_index ]
//	ls_bizztype				= lds_slipdata.object.bizztype_code[ ll_index ]
	ldc_div					= lds_slipdata.object.div_payment[ ll_index ]
	ldc_avg					= lds_slipdata.object.avg_payment[ ll_index ]
	ldc_fee					= lds_slipdata.object.fee_amt[ ll_index ]
	ldc_etc					= lds_slipdata.object.etc_payment[ ll_index ]
//	ldc_itempay				= lds_slipdata.object.item_payment[ ll_index ]
	ldc_prinpay				= lds_slipdata.object.principal_payamt[ ll_index ]
	ldc_intpay				= lds_slipdata.object.interest_payamt[ ll_index ]
	ldc_itempay				= lds_slipdata.object.item_payamt[ ll_index ]
	ldc_intarrear			= lds_slipdata.object.intarrear_payamt[ ll_index ]
	li_shrlonstatus			= lds_slipdata.object.slslippayindet_bfcontlaw_status[ ll_index ]
	ls_shrlontype			= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype				= lds_slipdata.object.slipitemtype_code[ ll_index ]

	
	if isnull( ldc_div ) then ldc_div = 0
	if isnull( ldc_avg ) then ldc_avg = 0
	if isnull( ldc_fee ) then ldc_fee = 0
	if isnull( ldc_etc ) then ldc_etc = 0
	if isnull( ldc_prinpay ) then ldc_prinpay = 0
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_intarrear ) then ldc_intarrear = 0
	if isnull( ldc_itempay ) then ldc_itempay = 0
	if isnull(li_shrlonstatus) or li_shrlonstatus = 0 then li_shrlonstatus = 1
	
		// ด/บ จ่าย - ดอกเบี้ยคืน
	ldc_intpay = ldc_intpay - ldc_intarrear
	
	ls_divid				= string( of_getattribmapaccid( as_coopid ,"DIV", "DIV", '01', 1, "account_id"  ) )
	ls_avgid				= string( of_getattribmapaccid( as_coopid, "DIV", "AVG", '01', 1, "account_id"  ) )
	ls_feeid				= string( of_getattribmapaccid( as_coopid, "DIV", "FEE", '01', 1, "account_id"  ) )
	ls_accid				= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid			= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid		= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	
	
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	
if( ls_slipno <> ls_slipno_bf ) then 
	//รายการถอน
	if ( ldc_div > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_divid, ls_accside, ldc_div, "", 99, ids_vcrcvpaydet )
	end if
	if (ldc_avg > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_avgid, ls_accside, ldc_avg, "", 99, ids_vcrcvpaydet )
	end if
	if (ldc_fee > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_feeid, ls_accside, ldc_fee, "", 99, ids_vcrcvpaydet )
	end if

end if
	
		// เงินต้น
		if ( ldc_prinpay > 0 ) then				
			this.of_additem( as_coopid ,is_vcrcvtrndocno , ls_tmpsystem , ls_tmpvcgrp, ls_accid, ls_accrevside , ldc_prinpay, 99, ids_vcrcvpaydet  , as_userid )
		end if
		
		// ดอกเบี้ย	
		if ( ldc_intpay > 0 ) then
			this.of_additem( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem  , ls_tmpvcgrp, ls_accintid, ls_accrevside, ldc_intpay,99, ids_vcrcvpaydet  , as_userid )
		end if
		//รายการชำระหักอื่น ๆ
		if ( ldc_itempay > 0 and  ldc_prinpay = 0 and ldc_intpay = 0 and ldc_intarrear = 0 ) then
			this.of_additem( as_coopid , is_vcrcvtrndocno, ls_tmpsystem , ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_itempay ,99, ids_vcrcvpaydet  , as_userid )
		end if
		
		//รายการ ด/บ พิเศษ
		if ( ldc_intarrear> 0) then
			this.of_additem( as_coopid , is_vcrcvtrndocno, ls_tmpsystem , ls_tmpvcgrp, ls_accintarrid, ls_accrevside, ldc_intarrear ,99, ids_vcrcvpaydet  , as_userid )
		end if
	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcrcvtrndocno)    	then
		update	yrslippayout
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( payoutslip_no	= :ls_slipno ) and
					( coop_id 		= :as_coopid)
		using itr_sqlca;
		
		update		slslippayin
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcrcvtrndocno
		where		( payinslip_no		= :ls_payinslipno ) and
						( memcoop_id		= :as_coopid  )
		using     itr_sqlca   ;		
		
	end if
	
	ls_slipno_bf				= ls_slipno
		
next

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

public function integer of_vctrndiv_avg_tbk (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> จ่ายเงินปันผลเฉลี่ยคืน รายการโอน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified by Sakuraii
</usage> 
***********************************************************/
string			ls_slipno, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_colsort, ls_month, ls_date
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp, ls_bizztype
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_desc,ls_cash, ls_itemdesc
long			ll_index, ll_count, ll_sortacc
dec{2}		ldc_itempay, ldc_intarrpay,ldc_prncbal,ldc_int_amt,ldc_accuint_amt, ldc_intreturn, ldc_slipnetamt
string			ls_deptgroupcode, ls_itemgroup, ls_accid_bf, ls_depttype_code, ls_vc_desc  
string			ls_depttype_group, ls_refsystem,  ls_voucher_type , ls_vc_type , as_vcdocno
dec{2}		ldc_other_amt, ldc_intbfyear , ldc_itempaynet, ldc_tax_return, ldc_tax, ldc_pay, ldc_div, ldc_avg, ldc_fee, ldc_etc
datetime		ldtm_operate
string			ls_acccash, ls_depttype_bf, ls_itemtype_bf, ls_accint, ls_acctax,ls_divyear, ls_methpaytype, ls_methpaytype_bf
string			ls_divid, ls_avgid, ls_feeid

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_trndiv_avg_tbk"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem				= "DIV"
ls_tmpvcgrp					= "TRN"
ls_accid_bf 				= ""
is_vcrcvtrndocno			= ""

ls_divyear 			=	lds_slipdata.object.div_year[ 1 ]

	 if  is_vcrcvtrndocno = ""   then
			ls_voucher_type	= "JV"	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , "รายการโอนจ่ายเงินปันผล-เฉลี่ยคืน โอนภายนอก" , 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
	else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

for ll_index = 1 to ll_count

	ls_slipno				= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_methpaytype			= lds_slipdata.object.methpaytype_code[ ll_index ]
	ls_bizztype				= lds_slipdata.object.bizztype_code[ ll_index ]
	ldc_div					= lds_slipdata.object.div_payment[ ll_index ]
	ldc_avg					= lds_slipdata.object.avg_payment[ ll_index ]
	ldc_fee					= lds_slipdata.object.fee_amt[ ll_index ]
	ldc_etc					= lds_slipdata.object.etc_payment[ ll_index ]
	ldc_itempay				= lds_slipdata.object.item_payment[ ll_index ]
	ls_accid				= lds_slipdata.object.tofrom_accid[ ll_index ]

	
	if isnull (ls_accid) or ls_accid = ""  then ls_accid = '11401000'	
	if isnull( ldc_div ) then ldc_div = 0
	if isnull( ldc_avg ) then ldc_avg = 0
	if isnull( ldc_fee ) then ldc_fee = 0
	if isnull( ldc_etc ) then ldc_etc = 0
			

	if ( trim(ls_methpaytype)  = "DEP") then //รายการโอนเข้าเงินฝาก
		ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_bizztype, 1, "account_id"  ) )
	end if
	
	ls_divid				= string( of_getattribmapaccid( as_coopid ,"DIV", "DIV", '01', 1, "account_id"  ) )
	ls_avgid				= string( of_getattribmapaccid( as_coopid, "DIV", "AVG", '01', 1, "account_id"  ) )
	ls_feeid				= string( of_getattribmapaccid( as_coopid, "DIV", "FEE", '01', 1, "account_id"  ) )
	
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	

	//รายการถอน
	if ( ldc_div > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_divid, ls_accside, ldc_div, "", 99, ids_vcrcvpaydet )
	end if
	if (ldc_avg > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_avgid, ls_accside, ldc_avg, "", 99, ids_vcrcvpaydet )
	end if
	if (ldc_fee > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_feeid, ls_accside, ldc_fee, "", 99, ids_vcrcvpaydet )
	end if
//	if (ldc_etc > 0) then
//		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_acctax, ls_accside, ldc_etc, ls_itemdesc, ll_sortacc, ids_vcrcvpaydet )
//	end if
	
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
			this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_itempay + ldc_fee, ls_itemdesc , 99, ids_vcrcvpaydet )
	end if

	
	
	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcrcvtrndocno)    	then
		update	yrslippayout
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( payoutslip_no	= :ls_slipno ) and
					( coop_id 		= :as_coopid)
		using itr_sqlca;
		
	end if
	
	ls_accid_bf 				= ls_accid
	ls_depttype_bf			= ls_depttype
	ls_itemtype_bf			= ls_itemtype
	ls_methpaytype_bf		= ls_methpaytype
		
next

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vccashdiv_avgpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่ายปันผลเฉลี่ยคืน เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 27/11/2017 by Sakuraii
</usage> 
***********************************************************/
string			ls_slipno, ls_accid,  ls_voucher_type
string			ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_bizztype
string			ls_moneygrp, ls_tofromaccid
long			ll_index, ll_count
dec{2}			ldc_div, ldc_avg, ldc_fee, ldc_etc, ldc_itempay
string			ls_acccash, ls_divyear, ls_methpaytype
string			ls_divid, ls_avgid, ls_feeid

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_cashdiv_avg"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem				= "DIV"
ls_tmpvcgrp					= "DAY"
is_vcpaydocno = ""

ls_divyear 			=	lds_slipdata.object.div_year[ 1 ]

	 if  is_vcpaydocno = ""   then
			ls_voucher_type	= "PV"	
			is_vcpaydocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_coopid  )
			this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , "จ่ายปันผลเฉลี่ยคืนเงินสด" , 0 , ids_vcpay , 'CSH'  , as_coopid  , as_userid )		
	else
			ids_vcpay.retrieve( is_vcpaydocno )
			ids_vcpaydet.retrieve( is_vcpaydocno )
	 end if 	

for ll_index = 1 to ll_count

	ls_slipno				= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_methpaytype			= lds_slipdata.object.methpaytype_code[ ll_index ]
	ls_bizztype				= lds_slipdata.object.bizztype_code[ ll_index ]
	ldc_div					= lds_slipdata.object.div_payment[ ll_index ]
	ldc_avg					= lds_slipdata.object.avg_payment[ ll_index ]
	ldc_fee					= lds_slipdata.object.fee_amt[ ll_index ]
	ldc_etc					= lds_slipdata.object.etc_payment[ ll_index ]
	ldc_itempay				= lds_slipdata.object.item_payment[ ll_index ]

	
//	if isnull (ls_tofromaccid)  then ls_tofromaccid = '000000'	
	if isnull( ldc_div ) then ldc_div = 0
	if isnull( ldc_avg ) then ldc_avg = 0
	if isnull( ldc_fee ) then ldc_fee = 0
	if isnull( ldc_etc ) then ldc_etc = 0
	
		//หาบัญชีเงินสด
	select  	cash_account_code
	into		:ls_acccash 
	from		accconstant 
	where 		coop_id = :as_coopid
	using    	 itr_sqlca   ;	
	
	//
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  ls_acccash then
		ls_tofromaccid		= 	ls_acccash
	end if
		

	
	//ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_bizztype, 1, "account_id"  ) )
	ls_divid				= string( of_getattribmapaccid( as_coopid ,"DIV", "DIV", '01', 1, "account_id"  ) )
	ls_avgid				= string( of_getattribmapaccid( as_coopid, "DIV", "AVG", '01', 1, "account_id"  ) )
	ls_feeid				= string( of_getattribmapaccid( as_coopid, "DIV", "FEE", '01', 1, "account_id"  ) )
	
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	

	//รายการถอน
	if ( ldc_div > 0 ) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_divid, ls_accside, ldc_div, "จ่ายเงินปันผล-เฉลี่ยคืนปี " + ls_divyear, 99, ids_vcpaydet )
	end if
	if (ldc_avg > 0) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_avgid, ls_accside, ldc_avg, "จ่ายเงินปันผล-เฉลี่ยคืนปี " + ls_divyear, 99, ids_vcpaydet )
	end if
	if (ldc_fee > 0) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_feeid, ls_accside, ldc_fee, "จ่ายเงินปันผล-เฉลี่ยคืนปี " + ls_divyear, 99, ids_vcpaydet )
	end if
//	if (ldc_etc > 0) then
//		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_acctax, ls_accside, ldc_etc, "จ่ายเงินปันผล-เฉลี่ยคืนปี " + ls_divyear, ll_sortacc, ids_vcpaydet )
//	end if
	
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
			//this.of_additemdesc( as_coopid , is_vcpaydocno, "CSH", "CSH", ls_tofromaccid, ls_accrevside, ldc_itempay, "จ่ายเงินปันผล-เฉลี่ยคืนปี " + ls_divyear, 99, ids_vcpaydet )
			this.of_additem( as_coopid , is_vcpaydocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcpaydet  , as_userid )
	end if
	
	
	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcpaydocno)    	then
		update		yrslippayout
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcpaydocno
		where	( payoutslip_no	= :ls_slipno ) and
				( coop_id 		= :as_coopid)
		using itr_sqlca;
		
	end if
		
next

destroy (lds_slipdata)
// update Vc
if ids_vcpay.update() <> 1 then
	return -1
end if
	
if ids_vcpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

public function integer of_vccashastpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> จ่ายสวัสดิการ เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 21/06/2018 by Sakuraii
</usage> 
***********************************************************/
string			ls_slipno, ls_colname, ls_colsort, ls_asttype, ls_tofromaccid
string			ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_desc, ls_voucher_type
long			ll_index, ll_count, ll_sortacc
dec{2}			ldc_itempay
string			ls_acccash, ls_coopid, ls_accid

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_cashastpay"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem					= "AST"
ls_tmpvcgrp						= "PAY"
////// สร้างเลข Voucher
	 
	 if  is_vcpaydocno    =  ""  then
			ls_voucher_type	= "PV"
			ls_desc  		= "เงินสดจ่ายประจำวัน"		
			is_vcpaydocno	= this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_coopid  )
			this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcpay , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcpay.retrieve( is_vcpaydocno )
			ids_vcpaydet.retrieve( is_vcpaydocno )
	 end if 	

//end if		

for ll_index = 1 to ll_count

	ls_slipno				= lds_slipdata.object.assslippayoutdet_assistslip_no[ ll_index ]
	ls_asttype				= lds_slipdata.object.assisttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ldc_itempay				= lds_slipdata.object.itempay_amt[ ll_index ]
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]

	
	if isnull( ldc_itempay ) then ldc_itempay = 0

		
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"AST", "AST", ls_asttype, 1,  "account_id"  ) )

			
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	
		// รายการฝั่ง DR
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, "", ll_sortacc, ids_vcpaydet )  
	end if
	
	//	รายการฝั่ง CR
	if ( ldc_itempay > 0 ) then
		this.of_additem( as_coopid , is_vcpaydocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcpaydet  , as_userid )
	end if
	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcpaydocno)    	then
		update	assslippayoutdet
		set		posttovc_flag	= 1,	
				voucher_no		= :is_vcpaydocno
		where	( assistslip_no	= :ls_slipno ) and
				( coop_id 		= :ls_coopid)
		using itr_sqlca;
	end if
		
next

// update Vc
if ids_vcpay.update() <> 1 then
	return -1
end if
	
if ids_vcpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

destroy (lds_slipdata)
return 1
end function

public function integer of_vctrnastpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> จ่ายสวัสดิการ เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 21/06/2018 by Sakuraii
</usage> 
***********************************************************/
string			ls_slipno, ls_colname, ls_colsort, ls_asttype, ls_tofromaccid
string			ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_desc, ls_voucher_type
long			ll_index, ll_count, ll_sortacc
dec{2}			ldc_itempay
string			ls_acccash, ls_coopid, ls_accid

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_trnastpay_new"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem					= "AST"
ls_tmpvcgrp						= "PAY"
is_vcrcvtrndocno				= ""
//สร้างเลข Voucher
	 if  is_vcrcvtrndocno = ""   then
			ls_voucher_type	= "JV"	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , "รายการจ่ายสวัสดิการ", 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
	else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

for ll_index = 1 to ll_count

	ls_slipno				= lds_slipdata.object.assslippayoutdet_assistslip_no[ ll_index ]
	ls_asttype				= lds_slipdata.object.assisttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ldc_itempay				= lds_slipdata.object.itempay_amt[ ll_index ]
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	
if isnull( ldc_itempay ) then ldc_itempay = 0
		
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"AST", "AST", ls_asttype, 1,  "account_id"  ) )
	
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	

	//รายการถอน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, "", ll_sortacc, ids_vcrcvpaydet )
	end if
		
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvpaydet  , as_userid )
	end if

	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcrcvtrndocno)    	then
		update	assslippayoutdet
		set		posttovc_flag	= 1,	
				voucher_no		= :is_vcrcvtrndocno
		where	( assistslip_no	= :ls_slipno ) and
				( coop_id 		= :ls_coopid)
		using itr_sqlca;
	end if
	

		
next

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

public function integer of_vctrndiv_avg_trn_etc (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> จ่ายเงินปันผลเฉลี่ยคืน รายการโอนเข้าเงินฝาก
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified by Sakuraii
</usage> 
***********************************************************/
string			ls_slipno, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_colsort, ls_month, ls_date
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp, ls_bizztype
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_desc,ls_cash, ls_itemdesc
long			ll_index, ll_count, ll_sortacc
dec{2}			ldc_itempay, ldc_intarrpay,ldc_prncbal,ldc_int_amt,ldc_accuint_amt, ldc_intreturn, ldc_slipnetamt
string			ls_deptgroupcode, ls_itemgroup, ls_accid_bf, ls_depttype_code, ls_vc_desc  
string			ls_depttype_group, ls_refsystem,  ls_voucher_type , ls_vc_type , as_vcdocno
dec{2}			ldc_other_amt, ldc_intbfyear , ldc_itempaynet, ldc_tax_return, ldc_tax, ldc_pay, ldc_div, ldc_avg, ldc_fee, ldc_etc
datetime		ldtm_operate
string			ls_acccash, ls_depttype_bf, ls_itemtype_bf, ls_accint, ls_acctax,ls_divyear, ls_methpaytype, ls_methpaytype_bf
string			ls_divid, ls_avgid, ls_feeid

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_trndiv_avg_trn_etc"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem				= "DIV"
ls_tmpvcgrp					= "TRN"
ls_accid_bf 				= ""
is_vcrcvtrndocno			= ""

ls_divyear 			=	lds_slipdata.object.div_year[ 1 ]

	 if  is_vcrcvtrndocno = ""   then
			ls_voucher_type	= "JV"	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , "รายการโอนจ่ายเงินปันผล-เฉลี่ยคืน จ่ายอื่นๆ" , 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
	else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

for ll_index = 1 to ll_count

	ls_slipno				= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_methpaytype			= lds_slipdata.object.methpaytype_code[ ll_index ]
	ls_bizztype				= lds_slipdata.object.depttype[ ll_index ]
	ldc_div					= lds_slipdata.object.div_payment[ ll_index ]
	ldc_avg					= lds_slipdata.object.avg_payment[ ll_index ]
	ldc_fee					= lds_slipdata.object.fee_amt[ ll_index ]
	ldc_etc					= lds_slipdata.object.etc_payment[ ll_index ]
	ldc_itempay				= lds_slipdata.object.item_payment[ ll_index ]
	ls_accid				= lds_slipdata.object.tofrom_accid[ ll_index ]

	
	//if isnull (ls_accid) or ls_accid = ""  then ls_accid = '11401000'	
	if isnull( ldc_div ) then ldc_div = 0
	if isnull( ldc_avg ) then ldc_avg = 0
	if isnull( ldc_fee ) then ldc_fee = 0
	if isnull( ldc_etc ) then ldc_etc = 0
			

	if ( trim(ls_methpaytype)  = "DEP") then //รายการโอนเข้าเงินฝาก
		ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_bizztype, 1, "account_id"  ) )
	end if
	
	ls_divid				= string( of_getattribmapaccid( as_coopid ,"DIV", "DIV", '01', 1, "account_id"  ) )
	ls_avgid				= string( of_getattribmapaccid( as_coopid, "DIV", "AVG", '01', 1, "account_id"  ) )
	ls_feeid				= string( of_getattribmapaccid( as_coopid, "DIV", "FEE", '01', 1, "account_id"  ) )
	
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	

	//รายการถอน
	if ( ldc_div > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_divid, ls_accside, ldc_div, "", 99, ids_vcrcvpaydet )
	end if
	if (ldc_avg > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_avgid, ls_accside, ldc_avg, "", 99, ids_vcrcvpaydet )
	end if
	if (ldc_fee > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_feeid, ls_accside, ldc_fee, "", 99, ids_vcrcvpaydet )
	end if
//	if (ldc_etc > 0) then
//		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_acctax, ls_accside, ldc_etc, ls_itemdesc, ll_sortacc, ids_vcrcvpaydet )
//	end if
	
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
			this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_itempay + ldc_fee, ls_itemdesc , 99, ids_vcrcvpaydet )
	end if

	
	
	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcrcvtrndocno)    	then
		update	yrslippayout
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( payoutslip_no	= :ls_slipno ) and
					( coop_id 		= :as_coopid)
		using itr_sqlca;
		
	end if
	
	ls_accid_bf 				= ls_accid
	ls_depttype_bf			= ls_depttype
	ls_itemtype_bf			= ls_itemtype
	ls_methpaytype_bf		= ls_methpaytype
		
next

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

public function integer of_vctrndiv_avg_cmt (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> จ่ายเงินปันผลเฉลี่ยคืน รายการโอนเข้าเงินฝาก
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified by Sakuraii
</usage> 
***********************************************************/
string			ls_slipno, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_colsort, ls_month, ls_date
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp, ls_bizztype
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_desc,ls_cash, ls_itemdesc
long			ll_index, ll_count, ll_sortacc
dec{2}			ldc_itempay, ldc_intarrpay,ldc_prncbal,ldc_int_amt,ldc_accuint_amt, ldc_intreturn, ldc_slipnetamt
string			ls_deptgroupcode, ls_itemgroup, ls_accid_bf, ls_depttype_code, ls_vc_desc  
string			ls_depttype_group, ls_refsystem,  ls_voucher_type , ls_vc_type , as_vcdocno
dec{2}			ldc_other_amt, ldc_intbfyear , ldc_itempaynet, ldc_tax_return, ldc_tax, ldc_pay, ldc_div, ldc_avg, ldc_fee, ldc_etc
datetime		ldtm_operate
string			ls_acccash, ls_depttype_bf, ls_itemtype_bf, ls_accint, ls_acctax,ls_divyear, ls_methpaytype, ls_methpaytype_bf
string			ls_divid, ls_avgid, ls_feeid

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_trndiv_avg_cmt"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem				= "DIV"
ls_tmpvcgrp					= "TRN"
ls_accid_bf 				= ""
is_vcrcvtrndocno			= ""

ls_divyear 			=	lds_slipdata.object.div_year[ 1 ]

	 if  is_vcrcvtrndocno = ""   then
			ls_voucher_type	= "JV"	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , "รายการโอนจ่ายเงินปันผล-เฉลี่ยคืน ฌาปนกิจ" , 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
	else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

for ll_index = 1 to ll_count

	ls_slipno				= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_methpaytype			= lds_slipdata.object.methpaytype_code[ ll_index ]
	ls_bizztype				= lds_slipdata.object.depttype[ ll_index ]
	ldc_div					= lds_slipdata.object.div_payment[ ll_index ]
	ldc_avg					= lds_slipdata.object.avg_payment[ ll_index ]
	ldc_fee					= lds_slipdata.object.fee_amt[ ll_index ]
	ldc_etc					= lds_slipdata.object.etc_payment[ ll_index ]
	ldc_itempay				= lds_slipdata.object.item_payment[ ll_index ]
	ls_accid				= lds_slipdata.object.tofrom_accid[ ll_index ]

	
	//if isnull (ls_accid) or ls_accid = ""  then ls_accid = '11401000'	
	if isnull( ldc_div ) then ldc_div = 0
	if isnull( ldc_avg ) then ldc_avg = 0
	if isnull( ldc_fee ) then ldc_fee = 0
	if isnull( ldc_etc ) then ldc_etc = 0
			

	if ( trim(ls_methpaytype)  = "DEP") then //รายการโอนเข้าเงินฝาก
		ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_bizztype, 1, "account_id"  ) )
	end if
	
	ls_divid				= string( of_getattribmapaccid( as_coopid ,"DIV", "DIV", '01', 1, "account_id"  ) )
	ls_avgid				= string( of_getattribmapaccid( as_coopid, "DIV", "AVG", '01', 1, "account_id"  ) )
	ls_feeid				= string( of_getattribmapaccid( as_coopid, "DIV", "FEE", '01', 1, "account_id"  ) )
	
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	

	//รายการถอน
	if ( ldc_div > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_divid, ls_accside, ldc_div, "", 99, ids_vcrcvpaydet )
	end if
	if (ldc_avg > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_avgid, ls_accside, ldc_avg, "", 99, ids_vcrcvpaydet )
	end if
	if (ldc_fee > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_feeid, ls_accside, ldc_fee, "", 99, ids_vcrcvpaydet )
	end if
//	if (ldc_etc > 0) then
//		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_acctax, ls_accside, ldc_etc, ls_itemdesc, ll_sortacc, ids_vcrcvpaydet )
//	end if
	
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
			this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_itempay + ldc_fee, ls_itemdesc , 99, ids_vcrcvpaydet )
	end if

	
	
	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcrcvtrndocno)    	then
		update	yrslippayout
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( payoutslip_no	= :ls_slipno ) and
					( coop_id 		= :as_coopid)
		using itr_sqlca;
		
	end if
	
	ls_accid_bf 				= ls_accid
	ls_depttype_bf			= ls_depttype
	ls_itemtype_bf			= ls_itemtype
	ls_methpaytype_bf		= ls_methpaytype
		
next

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

public function integer of_vccashdprcv_fee_split (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> ฝาก + ค่าธรรมเนียมถอน เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii  
	Version 3.0 (Initial version) Modified Date 19/02/2021 by Apple
</usage> 
***********************************************************/

string			ls_slipno, ls_accid, ls_accintarrid, ls_depttype, ls_tofromaccid, ls_desc, ls_slipno_bf
string			ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_depttype_group, ls_voucher_type
long			ll_index, ll_count, ll_sortacc
dec{2}			ldc_itempay, ldc_intarrpay
string			ls_coopid , ls_deptcoopid, ls_acccash, ls_recppay_desc, ls_memb_name, ls_deptno

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashdprcv_fee_split"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem		= "DEP"
ls_tmpvcgrp			= "RCV"
is_vcrcvdocno = ""


for ll_index = 1 to ll_count
	
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_deptcoopid			= lds_slipdata.object.deptcoop_id[ ll_index ]
	ls_slipno				= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_netamt[ ll_index ]
	ls_recppay_desc			= lds_slipdata.object.recppaytype_desc[ ll_index ]
	ls_memb_name			= lds_slipdata.object.memb_name[ ll_index ]
	ls_deptno				= lds_slipdata.object.deptaccount_no[ ll_index ]
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "FEE", "00", 1,  "account_id"  ) ) //ค่าปรับ
	
	 if  ls_slipno_bf <> ls_slipno  then
			ls_voucher_type	= "RV"
			ls_desc  		= "ค่าธรรมเนียม " + ls_deptno + " " + ls_memb_name
			is_vcrcvdocno	= this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid,   as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	

	
	ls_accside			= "CR"
	ls_accrevside		= "DR"	
	
		if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
		
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, "", ll_sortacc, ids_vcrcvdet)
		this.of_additem( as_coopid ,is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet  , as_userid )
	end if
	
	//update สถานะการดึงข้อมูล
	if	ls_slipno_bf <> ls_slipno   	then
		update	dpdeptslip
		set		posttovc_flag	= 1,	
				voucher_no		= :is_vcrcvdocno
		where	( deptslip_no	= :ls_slipno ) and
				( deptcoop_id 	= :as_coopid) and
				( coop_id 		= :ls_coopid)
		using itr_sqlca;
		
		ls_slipno_bf = ls_slipno
	end if
	

next

//update
if ids_vcrcv.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvdet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if
	
destroy( lds_slipdata )	
return 1
end function

on n_cst_account_prepare_vc_service_split.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_account_prepare_vc_service_split.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ithw_exception		= create Exception
end event

event destructor;destroy ( ids_mapaccid )
destroy ( ids_acccont )
end event
