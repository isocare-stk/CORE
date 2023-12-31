$PBExportHeader$n_cst_keeping_request_all.sru
$PBExportComments$ใบคำขอเกี่ยวกับระบบจัดเก็บ
forward
global type n_cst_keeping_request_all from nonvisualobject
end type
end forward

global type n_cst_keeping_request_all from nonvisualobject
end type
global n_cst_keeping_request_all n_cst_keeping_request_all

type variables
n_ds	ids_loandata, ids_contintspc, ids_inttable

string		is_recvperiod, is_arg[], is_userid, is_branchid
string		is_coopcontrol , is_coopid
integer	ii_proctype
datetime	idtm_operate

n_cst_progresscontrol		inv_progress
n_cst_dbconnectservice		inv_transection
n_cst_dwxmlieservice			inv_dwxmliesrv
n_cst_doccontrolservice		inv_docsrv

transaction	itr_sqlca
Exception	ithw_exception

constant integer	STATUS_CLOSE = -1
end variables

forward prototypes
public function integer of_setprogress (ref n_cst_progresscontrol anv_progress) throws Exception
public function integer of_setsrvdwxmlie (boolean ab_switch) throws Exception
public function integer of_init_req_expense (ref str_keep_request astr_keep_request) throws Exception
public function integer of_init_req_expense_main (n_ds ads_info_mem, ref n_ds ads_reqexp_main) throws Exception
public function integer of_init_req_expense_detail (n_ds ads_info_memexp, ref n_ds ads_reqexp_det) throws Exception
public function integer of_post_kpmembexp (n_ds ads_reqexp_main, n_ds ads_reqexp_det) throws Exception
public function integer of_save_req_expense (str_keep_request astr_keep_request) throws Exception
public function integer of_init_req_expense_trn (ref str_keep_request astr_keep_request) throws Exception
public function integer of_save_req_expense_trn (str_keep_request astr_keep_request) throws Exception
public function integer of_init_req_expense_approve (ref str_keep_request astr_keep_request) throws Exception
public function integer of_save_req_expense_approve (ref str_keep_request astr_keep_request) throws Exception
public function integer of_save_req_expense_trn_approve (str_keep_request astr_keep_request) throws Exception
private function integer of_chk_approve_wait (string as_memcoopid, string as_memno, ref string as_reqdocno)
public function integer of_init_req_expense_ccl (ref str_keep_request astr_keep_request) throws Exception
public function integer of_initservice (n_cst_dbconnectservice atr_dbtrans)
protected function integer of_setdsmodify (ref n_ds ads_requester, long al_row, boolean ab_keymodify)
protected function integer of_setsrvdoccontrol (boolean ab_switch)
end prototypes

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

public function integer of_setsrvdwxmlie (boolean ab_switch) throws Exception;// Check argument
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

public function integer of_init_req_expense (ref str_keep_request astr_keep_request) throws Exception;/***********************************************************
<description>
	สำหรับ Init ใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน
</description>

<arguments>  
	str_keep_adjust.xml_main{Ref}	String		xml หัวใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน
	str_keep_adjust.xml_detail{Ref}	String		xml รายละเอียดใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน
</arguments> 

<return> 
	1						Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 27/05/2012 by Godji
</usage> 
***********************************************************/
string		ls_xmlmain , ls_xmldetail
string		ls_memno , ls_reqdocno , ls_memcoopid 
long		ll_chkrow
dec{2}	ldc_prinbalance
datetime	ldtm_opedate, ldtm_slipdate
boolean lb_err = false

n_ds lds_info_mem , lds_info_memexp
n_ds lds_reqexp_main , lds_reqexp_det

this.of_setsrvdwxmlie( true )

lds_info_mem = create n_ds
lds_info_mem.dataobject = "d_kp_info_memdetail"
lds_info_mem.settransobject( itr_sqlca )

lds_info_memexp = create n_ds
lds_info_memexp.dataobject = "d_kp_info_mem_expense"
lds_info_memexp.settransobject( itr_sqlca )

lds_reqexp_main = create n_ds
lds_reqexp_main.dataobject = "d_kp_req_expense_main"
lds_reqexp_main.settransobject( itr_sqlca )

lds_reqexp_det = create n_ds
lds_reqexp_det.dataobject = "d_kp_req_expense_detail"
lds_reqexp_det.settransobject( itr_sqlca )

ls_xmlmain		= astr_keep_request.xml_main

if inv_dwxmliesrv.of_xmlimport( lds_reqexp_main , ls_xmlmain ) < 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาดในการนำเข้าข้อมูลใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

ls_memno		= lds_reqexp_main.object.member_no[1]
ls_memcoopid	= lds_reqexp_main.object.memcoop_id[1]

if this.of_chk_approve_wait( ls_memcoopid , ls_memno , ls_reqdocno ) <> 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาด มีคำขอรออนุมัติอยู่ "
	ithw_exception.text += "~r~nเลขที่ใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน : " + ls_reqdocno
	ithw_exception.text += "~r~nทะเบียนสมาชิก : " + ls_memno
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

ll_chkrow	= lds_info_mem.retrieve( ls_memcoopid , ls_memno )
if ll_chkrow < 1 then
	ithw_exception.text = "ไม่พบข้อมูลทะเบียนสมาชิก : " + ls_memno
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

lds_info_memexp.retrieve( ls_memcoopid , ls_memno )

//init main
if this.of_init_req_expense_main( lds_info_mem , lds_reqexp_main ) <> 1 then
	lb_err = true ; Goto objdestroy
end if

//init detail
if this.of_init_req_expense_detail( lds_info_memexp , lds_reqexp_det ) <> 1 then
	lb_err = true ; Goto objdestroy
end if

astr_keep_request.xml_main	= inv_dwxmliesrv.of_xmlexport( lds_reqexp_main )
astr_keep_request.xml_detail	= inv_dwxmliesrv.of_xmlexport( lds_reqexp_det )

objdestroy:
if isvalid( lds_reqexp_det ) then destroy lds_reqexp_det ;
if isvalid( lds_reqexp_main ) then destroy lds_reqexp_main ;
if isvalid( lds_info_mem ) then destroy lds_info_mem ;
if isvalid( lds_info_memexp ) then destroy lds_info_memexp ;

this.of_setsrvdwxmlie( false )

if lb_err then
	astr_keep_request.xml_main	= ""
	astr_keep_request.xml_detail	= ""
	rollback using itr_sqlca ;
	throw ithw_exception
end if

return 1
end function

public function integer of_init_req_expense_main (n_ds ads_info_mem, ref n_ds ads_reqexp_main) throws Exception;/***********************************************************
<description>
	สำหรับ Init รายการปรับปรุงใบเสร็จประจำเดือน( main )
</description>

<arguments>  
	ads_info_mem					n_ds		n_ds ข้อมูลสมาชิก
	ads_reqexp_main{Ref}		n_ds		n_ds รายการหัวใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน
</arguments> 

<return> 
	1						Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 27/05/2012 by Godji
</usage> 
***********************************************************/
integer li_row

li_row				= ads_reqexp_main.rowcount()

ads_reqexp_main.object.memb_name[ li_row ]			= ads_info_mem.object.memb_name[ 1 ]
ads_reqexp_main.object.memb_surname[ li_row ]		= ads_info_mem.object.memb_surname[ 1 ]
ads_reqexp_main.object.membgroup_code[ li_row ]		= ads_info_mem.object.membgroup_code[ 1 ]
ads_reqexp_main.object.membgroup_desc[ li_row ]		= ads_info_mem.object.membgroup_desc[ 1 ]
ads_reqexp_main.object.prename_desc[ li_row ]			= ads_info_mem.object.prename_desc[ 1 ]
ads_reqexp_main.object.kpreqexpense_status[ li_row ]	= 1
ads_reqexp_main.object.approve_status[ li_row ]		= 8

return 1
end function

public function integer of_init_req_expense_detail (n_ds ads_info_memexp, ref n_ds ads_reqexp_det) throws Exception;/***********************************************************
<description>
	สำหรับ Init รายละเอียดใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน( detail )
</description>

<arguments>  
	ads_info_memexp					n_ds		n_ds ข้อมูลประเภทการหักเงินประจำเดือน
	ads_reqexp_det{n_ds}			n_ds		n_ds รายละเอียดใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน
</arguments> 

<return> 
	1						Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 27/05/2012 by Godji
</usage> 
***********************************************************/
integer li_nwrow
long ll_index , ll_count

ll_count	= ads_info_memexp.rowcount()

for ll_index = 1 to ll_count
	li_nwrow		= ads_reqexp_det.insertrow(0)
	ads_reqexp_det.object.coop_id[li_nwrow]						= is_coopid
	ads_reqexp_det.object.kpreqexpense_docno[li_nwrow]		= "Auto"
	ads_reqexp_det.object.seq_no[li_nwrow]						= ads_info_memexp.object.seq_no[ll_index]
	ads_reqexp_det.object.chg_status[li_nwrow]					= 0
	ads_reqexp_det.object.moneytype_code[li_nwrow]			= ads_info_memexp.object.moneytype_code[ll_index]
	ads_reqexp_det.object.expense_bank[li_nwrow]				= ads_info_memexp.object.expense_bank[ll_index]
	ads_reqexp_det.object.expense_branch[li_nwrow]			= ads_info_memexp.object.expense_branch[ll_index]
	ads_reqexp_det.object.expense_accid[li_nwrow]				= ads_info_memexp.object.expense_accid[ll_index]
	ads_reqexp_det.object.monthlycut_type[li_nwrow]			= ads_info_memexp.object.monthlycut_type[ll_index]
	ads_reqexp_det.object.monthlycut_percent[li_nwrow]		= ads_info_memexp.object.monthlycut_percent[ll_index]
	ads_reqexp_det.object.monthlycut_value[li_nwrow]			= ads_info_memexp.object.monthlycut_value[ll_index]
	ads_reqexp_det.object.sort_in_monthlycut[li_nwrow]			= ads_info_memexp.object.sort_in_monthlycut[ll_index]
	ads_reqexp_det.object.bfmoneytype_code[li_nwrow]			= ads_info_memexp.object.moneytype_code[ll_index]
	ads_reqexp_det.object.bfexpense_bank[li_nwrow]			= ads_info_memexp.object.expense_bank[ll_index]
	ads_reqexp_det.object.bfexpense_branch[li_nwrow]			= ads_info_memexp.object.expense_branch[ll_index]
	ads_reqexp_det.object.bfexpense_accid[li_nwrow]			= ads_info_memexp.object.expense_accid[ll_index]
	ads_reqexp_det.object.bfmonthlycut_type[li_nwrow]			= ads_info_memexp.object.monthlycut_type[ll_index]
	ads_reqexp_det.object.bfmonthlycut_percent[li_nwrow]		= ads_info_memexp.object.monthlycut_percent[ll_index]
	ads_reqexp_det.object.bfmonthlycut_value[li_nwrow]		= ads_info_memexp.object.monthlycut_value[ll_index]
	ads_reqexp_det.object.bfsort_in_monthlycut[li_nwrow]		= ads_info_memexp.object.sort_in_monthlycut[ll_index]
next

return 1
end function

public function integer of_post_kpmembexp (n_ds ads_reqexp_main, n_ds ads_reqexp_det) throws Exception;/***********************************************************
<description>
	อัพเดทรายการเรียกเก็บประจำเดือนของสมาชิก
</description>

<arguments>  
	ads_reqexp_det				n_ds				n_ds ข้อมูลเปลี่ยนแปลงเรียกเก็บประจำเดือน
</arguments> 

<return> 
	Integer
	1		ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	Revision History:
	Version 1.0 (Initial version) Modified Date 02/06/2012 by Godji
</usage> 
***********************************************************/
string ls_coopid , ls_memno , ls_memcoop
string ls_moneytype , ls_expbank , ls_expbranch , ls_expaccid
string ls_mthtype , ls_approveid , ls_kpdocno
integer li_approve
integer li_seqno , li_mthcut , li_chgstatus , li_kpreqstatus , li_udstatus
integer li_index , li_count
dec{2} ldc_mthvalue
dec{6} ldc_mthpercent
datetime ldtm_approve

ls_coopid	 		= ads_reqexp_main.object.coop_id[1]
ls_memno 		= ads_reqexp_main.object.member_no[1]
ls_memcoop		= ads_reqexp_main.object.memcoop_id[1]
ls_kpdocno		= ads_reqexp_main.object.kpreqexpense_docno[1]
ls_approveid	= ads_reqexp_main.object.approve_id[1]
li_approve		= ads_reqexp_main.object.approve_status[1]
li_kpreqstatus	= ads_reqexp_main.object.kpreqexpense_status[1]
ldtm_approve	= ads_reqexp_main.object.approve_date[1]

// ลบข้อมูลเดิมก่อนทำการ insert เข้าไปใหม่
delete from kpmembexpense where coop_id = :ls_coopid and member_no = :ls_memno and memcoop_id = :ls_memcoop using itr_sqlca ;
if itr_sqlca.sqlcode <> 0 then
	ithw_exception.text = "ลบข้อมูลประเภทการเรียกเก็บประจำเดือน พบข้อผิดพลาด"  
	ithw_exception.text += "~r~nทะเบียน : "+ ls_memno
	ithw_exception.text += "~r~n"+ string( itr_sqlca.sqlcode )
	ithw_exception.text += "~r~n"+ itr_sqlca.sqlerrtext
	throw ithw_exception
end if

li_count	= ads_reqexp_det.rowcount()

for li_index = 1 to li_count
	
	li_chgstatus			= ads_reqexp_det.object.chg_status[li_index]
//	li_udstatus			= ads_reqexp_det.object.update_status[li_index]
//	if isnull( li_udstatus ) then li_udstatus = 0
	
	// ถ้าใบทำรายการยกเลิกให้ถอยกลับให้หมด
//	if li_kpreqstatus = -9 then li_chgstatus = 0
	choose case li_chgstatus
		case -1 // ยกเลิก
			continue ;
		case 0 // ไม่เปลี่ยนแปลง
			ls_moneytype 		= ads_reqexp_det.object.bfmoneytype_code[li_index]
			ls_expbank 			= ads_reqexp_det.object.bfexpense_bank[li_index]
			ls_expbranch 		= ads_reqexp_det.object.bfexpense_branch[li_index]
			ls_expaccid			= ads_reqexp_det.object.bfexpense_accid[li_index]
			ls_mthtype			= ads_reqexp_det.object.bfmonthlycut_type[li_index]
			li_seqno 				= ads_reqexp_det.object.seq_no[li_index]
			li_mthcut				= ads_reqexp_det.object.bfsort_in_monthlycut[li_index]
			ldc_mthvalue		= ads_reqexp_det.object.bfmonthlycut_value[li_index]
			ldc_mthpercent		= ads_reqexp_det.object.bfmonthlycut_percent[li_index]			
		case 1 // เปลี่ยนแปลง
			ls_moneytype 		= ads_reqexp_det.object.moneytype_code[li_index]
			ls_expbank 			= ads_reqexp_det.object.expense_bank[li_index]
			ls_expbranch 		= ads_reqexp_det.object.expense_branch[li_index]
			ls_expaccid			= ads_reqexp_det.object.expense_accid[li_index]
			ls_mthtype			= ads_reqexp_det.object.monthlycut_type[li_index]
			li_seqno 				= ads_reqexp_det.object.seq_no[li_index]
			li_mthcut				= ads_reqexp_det.object.sort_in_monthlycut[li_index]
			ldc_mthvalue		= ads_reqexp_det.object.monthlycut_value[li_index]
			ldc_mthpercent		= ads_reqexp_det.object.monthlycut_percent[li_index]
		case else
			ithw_exception.text = "ไม่พบข้อมูลการทำรายการ พบข้อผิดพลาด"  
			ithw_exception.text += "~r~nทะเบียน : "+ ls_memno
			return -1
	end choose
	
//	if li_udstatus = 0 then
		insert into kpmembexpense
		(	coop_id , 				member_no , 			seq_no , 				memcoop_id , 			moneytype_code ,
			expense_bank ,		expense_branch ,		expense_accid ,	monthlycut_type ,		monthlycut_percent ,
			monthlycut_value ,	sort_in_monthlycut , 	bizzcoop_id
		)
		values
		(	:ls_coopid ,			:ls_memno ,					:li_seqno ,			:ls_memcoop ,			:ls_moneytype ,
			:ls_expbank ,		:ls_expbranch ,			:ls_expaccid ,		:ls_mthtype ,			:ldc_mthpercent ,
			:ldc_mthvalue ,		:li_mthcut ,					:is_coopid
		)
		using itr_sqlca ;
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text = "ทำรายการนำเข้าข้อมูลเรียกเก็บประจำเดือน พบข้อผิดพลาด"  
			ithw_exception.text += "~r~nทะเบียน : "+ ls_memno
			ithw_exception.text += "~r~n"+ string( itr_sqlca.sqlcode )
			ithw_exception.text += "~r~n"+ itr_sqlca.sqlerrtext
			throw ithw_exception
		end if
//	else
//		update 	kpmembexpense
//		set 		moneytype_code 		= :ls_moneytype,
//					expense_bank 			= :ls_expbank,
//					expense_branch 		= :ls_expbranch,
//					expense_accid 			= :ls_expaccid,
//					monthlycut_type 		= :ls_mthtype,
//					monthlycut_percent 	= :ldc_mthpercent,
//					monthlycut_value 		= :ldc_mthvalue,
//					sort_in_monthlycut 	= :li_mthcut
//		where 	coop_id 					= :ls_coopid
//		and 		member_no 			= :ls_memno
//		and 		seq_no 					= :li_seqno
//		using itr_sqlca ;
//		if itr_sqlca.sqlcode <> 0 then
//			ithw_exception.text = "ทำรายการอัพเดทข้อมูลเรียกเก็บประจำเดือน พบข้อผิดพลาด"  
//			ithw_exception.text += "~r~nทะเบียน : "+ ls_memno
//			ithw_exception.text += "~r~n"+ string( itr_sqlca.sqlcode )
//			ithw_exception.text += "~r~n"+ itr_sqlca.sqlerrtext
//			return -1
//		end if		
//	end if

	update kpreqchgexpense
	set approve_status = :li_approve ,
	approve_id = :ls_approveid ,
	approve_date = :ldtm_approve
	where coop_id = :ls_coopid
	and kpreqexpense_docno = :ls_kpdocno
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text = "อัพเดทผู้ทำรายการอนุมัติ พบข้อผิดพลาด"  
		ithw_exception.text += "~r~nทะเบียน : "+ ls_memno
		ithw_exception.text += "~r~n"+ string( itr_sqlca.sqlcode )
		ithw_exception.text += "~r~n"+ itr_sqlca.sqlerrtext
		throw ithw_exception
	end if
next

return 1
end function

public function integer of_save_req_expense (str_keep_request astr_keep_request) throws Exception;/***********************************************************
<description>
	สำหรับบันทึกใบคำขอเปลี่ยนแปลงการส่งหักประจำเดือน
</description>

<arguments>  
	astr_keep_adjust.xml_main				String			xml ข้อมุลใบทำรายการปรับปรุงส่วน main
	astr_keep_adjust.xml_detail			String			xml ข้อมุลใบทำรายการปรับปรุงส่วน detail
</arguments> 

<return> 
	Integer
	1		ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	Revision History:
	Version 1.0 (Initial version) Modified Date 02/06/2012 by Godji
</usage> 
***********************************************************/
string ls_xmlmain , ls_xmldet
string ls_kpreqdocno
integer li_approve
long ll_index , ll_count
datetime ldtm_entry
boolean lb_err = false

n_ds lds_reqexp_main , lds_reqexp_det

ls_xmlmain		= astr_keep_request.xml_main
ls_xmldet		= astr_keep_request.xml_detail

this.of_setsrvdwxmlie( true )

lds_reqexp_main = create n_ds
lds_reqexp_main.dataobject = "d_kp_req_expense_main"
lds_reqexp_main.settransobject( itr_sqlca )

lds_reqexp_det = create n_ds
lds_reqexp_det.dataobject = "d_kp_req_expense_detail"
lds_reqexp_det.settransobject( itr_sqlca )

if inv_dwxmliesrv.of_xmlimport( lds_reqexp_main , ls_xmlmain ) < 1 then
	ithw_exception.text = "พบขอผิดพลาดในการนำเข้าข้อมูลใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน ( Main )"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

if inv_dwxmliesrv.of_xmlimport( lds_reqexp_det , ls_xmldet ) < 1 then
	ithw_exception.text = "พบขอผิดพลาดในการนำเข้าข้อมูลใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน ( Detail )"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

//// ตรวจสอบการทำรายการ **ยังไมได้ทำ
//if this.of_check_req_expense( lds_reqexp_main , lds_reqexp_det ) <> 1 then
//	return -1
//end if

// ขอเลขที่เอกสารการเปลี่ยนแปลง
this.of_setsrvdoccontrol( true )
ls_kpreqdocno	= inv_docsrv.of_getnewdocno( is_coopid , "KPREQMEMEXP")
this.of_setsrvdoccontrol( false )

li_approve		= lds_reqexp_main.object.approve_status[1]
ldtm_entry		= datetime( today() , now() )

lds_reqexp_main.object.coop_id[1]					= is_coopid
lds_reqexp_main.object.kpreqexpense_docno[1]	= ls_kpreqdocno
lds_reqexp_main.object.entry_date[1]				= ldtm_entry
lds_reqexp_main.object.kpreqexpense_status[1]	= 1

ll_count	= lds_reqexp_det.rowcount()
for ll_index = 1 to ll_count
	lds_reqexp_det.object.coop_id[ll_index]						= is_coopid
	lds_reqexp_det.object.kpreqexpense_docno[ll_index]		= ls_kpreqdocno
	lds_reqexp_det.object.seq_no[ll_index]						= ll_index
next

// -----------------------
// เริ่มกระบวนการบันทึก
// -----------------------
// บันทึก Master
if lds_reqexp_main.update() <> 1 then
	ithw_exception.text	= "บันทึกข้อมูลการใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน (Kpreqexpense Master) ไม่ได้  "
	ithw_exception.text	+= "~r~n" + ls_kpreqdocno 
	ithw_exception.text	+= "~r~n" + lds_reqexp_main.of_geterrormessage()
	ithw_exception.text	+= "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

// บันทึก Detail
if lds_reqexp_det.update() <> 1 then
	ithw_exception.text	= "บันทึกข้อมูลใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน (Kpreqexpensedet Detail) ไม่ได้  "
	ithw_exception.text	+= "~r~n" + ls_kpreqdocno 
	ithw_exception.text	+= "~r~n" + lds_reqexp_det.of_geterrormessage()
	ithw_exception.text	+= "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

// 1 อนุมัติทันที , 8 รออนุมัติ
if li_approve = 1 then

	lds_reqexp_main.object.approve_id[1]					= lds_reqexp_main.object.entry_id[1]
	lds_reqexp_main.object.approve_date[1]				= lds_reqexp_main.object.operate_date[1]
	// อัพเดทการเรียกเก็บประจำเดือน
	try
		this.of_post_kpmembexp( lds_reqexp_main , lds_reqexp_det )
	catch( Exception lthw_reqexp )
		ithw_exception.text	= lthw_reqexp.text
		lb_err = true
	end try
end if

objdestroy:
if isvalid( lds_reqexp_det ) then destroy lds_reqexp_det ;
if isvalid( lds_reqexp_main ) then destroy lds_reqexp_main ;

this.of_setsrvdwxmlie( false )

if lb_err then
	rollback using itr_sqlca ;
	throw ithw_exception
end if

commit using itr_sqlca ;

return 1
end function

public function integer of_init_req_expense_trn (ref str_keep_request astr_keep_request) throws Exception;/***********************************************************
<description>
	สำหรับ Init ใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน( สำหรับผ่านรายการเพื่อขอเปลี่ยนแปลง )
</description>

<arguments>  
	str_keep_adjust.member_no			String		ทะเบียนที่ต้องการทำรายการเปลี่ยนแปลงประเภทหักรายเดือน
	str_keep_adjust.memcoop_id			String		สาขาของทะเบียนสมาชิกที่ทำรายการเปลี่ยนแปลงประเภทหักรายเดือน
	str_keep_adjust.xml_detail{Ref}		String		xml รายละเอียดใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน
</arguments> 

<return> 
	1						Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 27/05/2012 by Godji
</usage> 
***********************************************************/
string		ls_xmlmain , ls_xmldetail
string		ls_memno , ls_reqdocno , ls_memcoopid
long		ll_chkrow
dec{2}	ldc_prinbalance
datetime	ldtm_opedate, ldtm_slipdate
boolean	lb_err = false

n_ds lds_info_mem , lds_info_memexp
n_ds lds_reqexp_main , lds_reqexp_det

this.of_setsrvdwxmlie( true )

lds_info_memexp = create n_ds
lds_info_memexp.dataobject = "d_kp_info_mem_expense"
lds_info_memexp.settransobject( itr_sqlca )

lds_reqexp_det = create n_ds
lds_reqexp_det.dataobject = "d_kp_req_expense_detail"
lds_reqexp_det.settransobject( itr_sqlca )

ls_memno		= astr_keep_request.member_no
ls_memcoopid	= astr_keep_request.memcoop_id

if this.of_chk_approve_wait( ls_memcoopid , ls_memno , ls_reqdocno ) <> 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาด มีคำขอรออนุมัติอยู่ "
	ithw_exception.text += "~r~nเลขที่ใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน : " + ls_reqdocno
	ithw_exception.text += "~r~nทะเบียนสมาชิก : " + ls_memno
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

lds_info_memexp.retrieve( ls_memcoopid , ls_memno )

//init detail
if this.of_init_req_expense_detail( lds_info_memexp , lds_reqexp_det ) <> 1 then
	lb_err = true ; Goto objdestroy
end if

astr_keep_request.xml_detail	= inv_dwxmliesrv.of_xmlexport( lds_reqexp_det )

objdestroy:
if isvalid( lds_reqexp_det ) then destroy lds_reqexp_det ;
if isvalid( lds_reqexp_main ) then destroy lds_reqexp_main ;
if isvalid( lds_info_memexp ) then destroy lds_info_memexp ;
if isvalid( lds_info_mem ) then destroy lds_info_mem ;

this.of_setsrvdwxmlie( false )

if lb_err then
	astr_keep_request.xml_detail		= ""
	rollback using itr_sqlca ;
	throw ithw_exception
end if

return 1
end function

public function integer of_save_req_expense_trn (str_keep_request astr_keep_request) throws Exception;/***********************************************************
<description>
	สำหรับบันทึกใบคำขอเปลี่ยนแปลงการส่งหักประจำเดือน( สำหรับผ่านรายการเพื่อขอเปลี่ยนแปลง )
</description>

<arguments>  
	str_keep_request.refchggrp_docno		String			เลขที่ใบคำขอเปลี่ยนแปลงสังกัด
	str_keep_request.memcoop_id				String			สาขาที่สมัครสมาชิก
	str_keep_request.member_no				String			ทะเบียนสมาชิก
	str_keep_request.entry_id					String			ผู้ทำรายการ
	str_keep_request.approve_status		Integer		สถานะอนุมัติ ( 1 อนุมัติ / 8 รออนุมัติ )
	str_keep_request.operate_date			Datetime		วันที่ทำรายการ
	str_keep_adjust.xml_detail					String			xml ข้อมุลใบทำรายการปรับปรุงส่วน detail
</arguments> 

<return> 
	Integer
	1		ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	Revision History:
	Version 1.0 (Initial version) Modified Date 09/10/2012 by Godji
</usage> 
***********************************************************/
string ls_xmlmain , ls_xmldet
string ls_memcoop , ls_memno , ls_entry
string ls_kpreqdocno , ls_refchggrp , ls_null
integer li_approve , li_chgstatus , li_null , li_row
integer li_seq
long ll_index , ll_count , ll_chkrow
datetime ldtm_operate , ldtm_entry
boolean lb_err = false

n_ds lds_info_mem
n_ds lds_reqexp_main , lds_reqexp_det

ls_xmldet		= astr_keep_request.xml_detail

ls_refchggrp		= astr_keep_request.refchggrp_docno
ls_memcoop	= astr_keep_request.memcoop_id
ls_memno		= astr_keep_request.member_no
ls_entry			= astr_keep_request.entry_id
li_approve		= astr_keep_request.approve_status
ldtm_operate	= astr_keep_request.operate_date

this.of_setsrvdwxmlie( true )
this.of_setsrvdoccontrol( true )

lds_info_mem = create n_ds
lds_info_mem.dataobject = "d_kp_info_memdetail"
lds_info_mem.settransobject( itr_sqlca )

lds_reqexp_main = create n_ds
lds_reqexp_main.dataobject = "d_kp_req_expense_main"
lds_reqexp_main.settransobject( itr_sqlca )

lds_reqexp_det = create n_ds
lds_reqexp_det.dataobject = "d_kp_req_expense_detail"
lds_reqexp_det.settransobject( itr_sqlca )

ldtm_entry		= datetime( today() , now() )

//// ตรวจสอบการทำรายการ **ยังไมได้ทำ
//if this.of_check_req_expense( lds_reqexp_main , lds_reqexp_det ) <> 1 then
//	return -1
//end if

if inv_dwxmliesrv.of_xmlimport( lds_reqexp_det , ls_xmldet ) < 1 then
	return 1 // กรณีไม่เปลี่ยนแปลง
	ithw_exception.text = "พบขอผิดพลาดในการนำเข้าข้อมูลใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน ( Detail )"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

select kpreqexpense_docno
into :ls_kpreqdocno
from kpreqchgexpense
where memcoop_id = :ls_memcoop
and member_no = :ls_memno
and kpreqexpense_status = 1
and approve_status = 8
using itr_sqlca ;
if isnull( ls_kpreqdocno ) or trim( ls_kpreqdocno ) = '' then ls_kpreqdocno = ''
// ขอเลขที่เอกสารการเปลี่ยนแปลง
if ls_kpreqdocno = '' then
	
	ll_chkrow	= lds_info_mem.retrieve( ls_memcoop , ls_memno )
	if ll_chkrow < 1 then
		ithw_exception.text = "ไม่พบข้อมูลทะเบียนสมาชิก : " + ls_memno
		ithw_exception.text += "~r~nกรุณาตรวจสอบ"
		lb_err = true ; Goto objdestroy
	end if
	
	li_row		= lds_reqexp_main.insertrow(0)
	lds_reqexp_main.object.coop_id[li_row]					= is_coopid
	lds_reqexp_main.object.refchggrp_docno[li_row]		= ls_refchggrp
	lds_reqexp_main.object.memcoop_id[li_row]			= ls_memcoop
	lds_reqexp_main.object.member_no[li_row]			= ls_memno
	lds_reqexp_main.object.operate_date[li_row]			= ldtm_operate
	lds_reqexp_main.object.approve_status[li_row]		= li_approve
	lds_reqexp_main.object.entry_id[li_row]					= ls_entry
	lds_reqexp_main.object.entry_date[li_row]				= ldtm_entry
	lds_reqexp_main.object.kpreqexpense_status[li_row]	= 1
//	//init main
//	if this.of_init_req_expense_main( lds_info_mem , lds_reqexp_main ) <> 1 then
//		lb_err = true ; Goto objdestroy
//	end if
	
	ls_kpreqdocno	= inv_docsrv.of_getnewdocno( is_coopid , "KPREQMEMEXP")

	lds_reqexp_main.object.kpreqexpense_docno[1]	= ls_kpreqdocno
	
	ll_count	= lds_reqexp_det.rowcount()
	for ll_index = 1 to ll_count
		lds_reqexp_det.object.coop_id[ll_index]						= is_coopid
		lds_reqexp_det.object.kpreqexpense_docno[ll_index]		= ls_kpreqdocno
		lds_reqexp_det.object.seq_no[ll_index]						= ll_index
		
		li_chgstatus			= lds_reqexp_det.object.chg_status[ll_index]
		
		if li_chgstatus = 0 then
			lds_reqexp_det.object.moneytype_code[ll_index]		= ls_null
			lds_reqexp_det.object.expense_bank[ll_index]			= ls_null
			lds_reqexp_det.object.expense_branch[ll_index]			= ls_null
			lds_reqexp_det.object.expense_accid[ll_index]			= ls_null
			lds_reqexp_det.object.monthlycut_type[ll_index]			= ls_null
//			lds_reqexp_det.object.seq_no[ll_index]						= li_null
			lds_reqexp_det.object.sort_in_monthlycut[ll_index]		= li_null
			lds_reqexp_det.object.monthlycut_value[ll_index]		= li_null
			lds_reqexp_det.object.monthlycut_percent[ll_index]		= li_null
		end if
		
	next
	
else
	
	lds_reqexp_main.retrieve( is_coopid , ls_kpreqdocno )
	lds_reqexp_main.object.entry_id[1]					= ls_entry
	lds_reqexp_main.object.entry_date[1]				= ldtm_entry
	this.of_setdsmodify( lds_reqexp_main, 1, false )
	ll_count = lds_reqexp_det.rowcount()
	for ll_index = 1 to ll_count
		this.of_setdsmodify( lds_reqexp_det, ll_index, true )
	next
end if

// -----------------------
// เริ่มกระบวนการบันทึก
// -----------------------
// บันทึก Master
if lds_reqexp_main.update() <> 1 then
	ithw_exception.text	= "บันทึกข้อมูลการใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน (Kpreqexpense Master) ไม่ได้  "
	ithw_exception.text	+= "~r~n เลขที่ใบคำขอ" + ls_kpreqdocno 
	ithw_exception.text	+= "~r~n" + lds_reqexp_main.of_geterrormessage()
	ithw_exception.text	+= "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

// บันทึก Detail
if lds_reqexp_det.update() <> 1 then
	ithw_exception.text	= "บันทึกข้อมูลใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน (Kpreqexpensedet Detail) ไม่ได้  "
	ithw_exception.text	+= "~r~n เลขที่ใบคำขอ" + ls_kpreqdocno 
	ithw_exception.text	+= "~r~n" + lds_reqexp_det.of_geterrormessage()
	ithw_exception.text	+= "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

// 1 อนุมัติทันที , 8 รออนุมัติ
if li_approve = 1 then
	
	lds_reqexp_main.object.approve_id[1]					= lds_reqexp_main.object.entry_id[1]
	lds_reqexp_main.object.approve_date[1]				= ldtm_operate
	// อัพเดทการเรียกเก็บประจำเดือน
	try
		this.of_post_kpmembexp( lds_reqexp_main , lds_reqexp_det )
	catch( Exception lthw_reqexp )
		ithw_exception.text		= lthw_reqexp.text
		lb_err = true
	end try
	
end if

objdestroy:
if isvalid( lds_reqexp_det ) then destroy lds_reqexp_det ;
if isvalid( lds_reqexp_main ) then destroy lds_reqexp_main ;
if isvalid( lds_info_mem ) then destroy lds_info_mem ;

this.of_setsrvdwxmlie( false )
this.of_setsrvdoccontrol( false )

if lb_err then
	rollback using itr_sqlca ;
	throw ithw_exception
end if

return 1
end function

public function integer of_init_req_expense_approve (ref str_keep_request astr_keep_request) throws Exception;/***********************************************************
<description>
	สำหรับ Init อนุมัติเปลี่ยนแปลงประเภทเงินหักรายเดือน
</description>

<arguments>  
	str_keep_adjust.xml_option{Ref}	String		xml เงื่อนไขการดึงข้อมูลอนุมัติเปลี่ยนแปลงประเภทเงินหักรายเดือน
	str_keep_adjust.xml_list{Ref}		String		xml รายละเอียดการอนุมัติใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน
</arguments> 

<return> 
	1						Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 12/10/2012 by Godji
</usage> 
***********************************************************/
string ls_xmloption , ls_coopid
string ls_smemgrp , ls_ememgrp , ls_smemno , ls_ememno
string ls_memname , ls_memsurn
string ls_ordertype
string ls_sql , ls_sqlext , ls_column , ls_coldb , ls_value , ls_tag , ls_columntyp
integer li_index , li_num_cols
datetime	ldtm_date
boolean lb_err = false

n_ds lds_xmloption , lds_xmllist

this.of_setsrvdwxmlie( true )

lds_xmloption = create n_ds
lds_xmloption.dataobject = "d_kp_req_expense_approve_option"
lds_xmloption.settransobject( itr_sqlca )

lds_xmllist = create n_ds
lds_xmllist.dataobject = "d_kp_req_expense_approve_list"
lds_xmllist.settransobject( itr_sqlca )

ls_xmloption		= astr_keep_request.xml_option

//** เฉพาะกิจทำไปก่อน

//if inv_dwxmliesrv.of_xmlimport( lds_xmloption , ls_xmloption ) < 1 then
//	ithw_exception.text = "~r~nพบขอผิดพลาด ในการนำเข้าข้อมูล(1)"
//	ithw_exception.text += "~r~nเงื่อนไขการดึงข้อมูลเปลี่ยนแปลงประเภทเงินหักรายเดือน"
//	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
//	lb_err = true ; Goto objdestroy
//end if

li_num_cols 	= Integer (lds_xmloption.Describe ( "DataWindow.Column.Count" )) 

for li_index = 1 to li_num_cols
	ls_column 		= trim(lds_xmloption.Describe ( "#" + String(li_index) + ".Name" ))
	ls_tag				= trim(lds_xmloption.Describe ( "#" + String(li_index) + ".Tag" ))
	ls_columntyp	= lds_xmloption.Describe ( "#" + String(li_index) + ".ColType" )
	ls_columntyp	= upper( left( lds_xmloption.Describe ( "#" + String(li_index) + ".ColType" ) , 4 ) )
//	ls_coldb 			= trim(lds_xmloption.Describe ("#" + string (li_index) + ".dbName"))
	choose case ls_columntyp
		case "CHAR"
			if lower( right( ls_column , 4 ) ) = "date" or lower( trim( ls_column ) ) = "ordertype_code" then continue ;// หมายเหตุ เป็นวันที่ให้ข้ามไป ให้ใช้จาก Type DateTime
			ls_value		= lds_xmloption.getitemstring( 1 , ls_column )
			if lower(right( ls_tag , 4 )) = "like" then ls_value = "%" + ls_value + "%"
		case "DATE"
			ldtm_date	= lds_xmloption.getitemdatetime( 1 , ls_column )
			ls_value		= string( ldtm_date , "dd/mm/yyyy" )
			ls_value		= string( lds_xmloption.getitemdatetime( 1 , ls_column ) , "dd/mm/yyyy" )
	end choose
	
	if (not IsNull(ls_value)) and trim(ls_value) <> "" then ls_sqlext += " and " + ls_tag + " '" + ls_value + "' "
	
next

ls_sql		= lds_xmllist.getsqlselect()

ls_sql		+= ls_sqlext

if lds_xmllist.setsqlselect( ls_sql ) <> 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาด ในการนำเข้าข้อมูล(2)"
	ithw_exception.text += "~r~nเงื่อนไขการดึงข้อมูลเปลี่ยนแปลงประเภทเงินหักรายเดือน"
	ithw_exception.text += "~r~n" + lds_xmllist.of_geterrormessage()
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

if lds_xmllist.retrieve() < 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาด ในการดึงข้อมูล(3)"
	ithw_exception.text += "~r~nข้อมูลเปลี่ยนแปลงประเภทเงินหักรายเดือน"
	ithw_exception.text += "~r~n" + lds_xmllist.of_geterrormessage()
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

astr_keep_request.xml_option		= inv_dwxmliesrv.of_xmlexport( lds_xmloption )
astr_keep_request.xml_list			= inv_dwxmliesrv.of_xmlexport( lds_xmllist )

/*
	FOR i=1 TO li_colcount
		ls_colnm = dw_1.describe ("#" + string (i) + ".name")
		ls_coldb = dw_1.describe ("#" + string (i) + ".dbName")
		if lb_muti then 
			if  dw_1.iuo_ddMultiSelect.of_IsRegistered(ls_colnm) then 
				ls_value = dw_1.iuo_ddMultiSelect.of_GetData(ls_colnm)
				if not IsNull(ls_value) then &
				ls_cond += ls_coldb + " in (" + ls_value + ") and "
			else
				CHOOSE CASE Lower(Left(dw_1.Describe(ls_colnm + ".Coltype"),4))
					CASE 'char'
						 ls_value = dw_1.GetItemString( dw_1.GetRow(), ls_colnm)
						 if (not IsNull(ls_value)) and trim(ls_value) <> '' then &
						 ls_cond += ls_coldb + " like  ~'" + ls_value + "%~' and "
					CASE 'date'
						ll_index = of_SearchItem(ls_colnm)
						if ll_index > 0 then
							ld_startdate = iu_dddwcal1[ll_index].of_GetDate()
							ld_endate = iu_dddwcal2[ll_index].of_GetDate()
							if Not IsNull(ls_startdate) and trim(ls_startdate) <> '' then ls_cond += "trunc(" + ls_coldb + ")>=~'" + ls_startdate + "~' and "
							if Not IsNull(ls_enddate) and trim(ls_enddate) <> '' then ls_cond += "trunc(" + ls_coldb + ")<=~'" + ls_enddate + "~' and "
						End If
					CASE 'deci'
						ll_value = dw_1.GetItemdecimal( dw_1.GetRow(), ls_colnm)
						if (not IsNull(ll_value))  then &
						ls_cond += ls_coldb + " = " + string(ll_value) + " and "
					CASE Else
						//    MessageBox(ls_colnm, Lower(Left(dw_1.Describe(ls_colnm + ".Coltype"),4)))
				END CHOOSE
			end if
		else
			CHOOSE CASE Lower(Left(dw_1.Describe(ls_colnm + ".Coltype"),4))
				CASE 'char'
					ls_value = dw_1.GetItemString( dw_1.GetRow(), ls_colnm)
					if (not IsNull(ls_value)) and trim(ls_value) <> '' then &
					ls_cond += ls_coldb + " like ~'" + ls_value + "%~' and "
				CASE 'date'
					ll_index = of_SearchItem(ls_colnm)
					if ll_index > 0 then
						ld_startdate = iu_dddwcal1[ll_index].of_GetDate()
						ld_endate = iu_dddwcal2[ll_index].of_GetDate()
						if Not IsNull(ld_startdate)  then ls_cond += "trunc(" + ls_coldb + ")>=to_date(~'" + string(ld_startdate) + "~', ~'DD/MM/YYYY~') and "
						if Not IsNull(ld_endate) then ls_cond += "trunc(" + ls_coldb + ")<=to_date(~'" + string(ld_endate) + "~', ~'DD/MM/YYYY~') and "
					End If
				CASE 'deci'
					ll_value = dw_1.GetItemdecimal( dw_1.GetRow(), ls_colnm)
					if (not IsNull(ll_value))  then &
					ls_cond += ls_coldb + " = " + string(ll_value) + " and "
			END CHOOSE
		end if
	NEXT
if right(ls_cond, 4) = 'and ' then ls_cond = mid(ls_cond,1, len(ls_cond) - 4)
*/
//= ' and member_no = ~'' + ls_memno + '~''
//= " and member_no = ~'" + ls_memno + "~'"

//ls_coopid				= lds_xmloption.object.coop_id[1]					; if isnull(ls_coopid) then ls_coopid = ""
//ls_smemgrp			= lds_xmloption.object.membgroup_scode[1]		; if isnull(ls_smemgrp) then ls_smemgrp = ""
//ls_ememgrp			= lds_xmloption.object.membgroup_ecode[1]		; if isnull(ls_ememgrp) then ls_ememgrp = ""
//ls_smemno			= lds_xmloption.object.member_sno[1]				; if isnull(ls_smemno) then ls_smemno = ""
//ls_ememno			= lds_xmloption.object.member_eno[1]				; if isnull(ls_ememno) then ls_ememno = ""
//ls_memname		= lds_xmloption.object.memb_name[1]				; if isnull(ls_memname) then ls_memname = ""
//ls_memsurn			= lds_xmloption.object.memb_surname[1]			; if isnull(ls_memsurn) then ls_memsurn = ""
//ls_ordertype		= lds_xmloption.object.ordertype_code[1]			; if isnull(ls_ordertype) then ls_ordertype = ""
//ldtm_soper			= lds_xmloption.object.operate_sdate[1]			; if isnull(ldtm_soper) then ldtm_soper = datetime(date( "1900/01/01" ))
//ldtm_eoper			= lds_xmloption.object.operate_edate[1]			; if isnull(ldtm_eoper) then ldtm_eoper = datetime(date( "1900/01/01" ))
//
//if len( trim(ls_coopid) ) > 0 then ls_sqlext += ""
//if len( trim(ls_smemgrp) ) > 0 then ls_sqlext += ""
//if len( trim(ls_ememgrp) ) > 0 then ls_sqlext += ""
//if len( trim(ls_smemno) ) > 0 then ls_sqlext += ""
//if len( trim(ls_ememno) ) > 0 then ls_sqlext += ""
//if len( trim(ls_memname) ) > 0 then ls_sqlext += ""
//if len( trim(ls_memsurn) ) > 0 then ls_sqlext += ""
//
//if string( ldtm_soper , "dd/mm/yyyy" ) = "01/01/1900" or isnull( ldtm_soper ) then ls_sqlext += ""
//if string( ldtm_eoper , "dd/mm/yyyy" ) = "01/01/1900" or isnull( ldtm_eoper ) then ls_sqlext += ""
//
//if len( trim() ) > 0 then ls_sqlext += ""
//
//ls_sql		= lds_xmllist.getsqlselect()

objdestroy:
if isvalid( lds_xmllist ) then destroy lds_xmllist ;
if isvalid( lds_xmloption ) then destroy lds_xmloption ;

this.of_setsrvdwxmlie( false )

if lb_err then
	astr_keep_request.xml_option		= ""
	astr_keep_request.xml_list			= ""
	rollback using itr_sqlca ;
	throw ithw_exception
end if

return 1
end function

public function integer of_save_req_expense_approve (ref str_keep_request astr_keep_request) throws Exception;/***********************************************************
<description>
	สำหรับ Init อนุมัติเปลี่ยนแปลงประเภทเงินหักรายเดือน
</description>

<arguments>  
	str_keep_adjust.xml_option{Ref}	String		xml เงื่อนไขการดึงข้อมูลอนุมัติเปลี่ยนแปลงประเภทเงินหักรายเดือน
	str_keep_adjust.xml_list{Ref}		String		xml รายละเอียดการอนุมัติใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน
</arguments> 

<return> 
	1						Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 12/10/2012 by Godji
</usage> 
***********************************************************/
string ls_xmloption , ls_xmllist
string ls_coopid, ls_reqdocno , ls_memno
string ls_approveid
integer li_approve
long ll_index , ll_count
datetime ldtm_approve
boolean lb_err = false

n_ds lds_reqexp_main , lds_reqexp_det
n_ds lds_xmloption , lds_xmllist

inv_progress.istr_progress.progress_text		= "อนุมัติใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน"
inv_progress.istr_progress.subprogress_text	=  "กำลังดึงข้อมูล"
inv_progress.istr_progress.progress_index = 0
inv_progress.istr_progress.progress_max = 1
inv_progress.istr_progress.subprogress_index	= 0
inv_progress.istr_progress.subprogress_max	= 1
inv_progress.istr_progress.status = 8

this.of_setsrvdwxmlie( true )

lds_xmloption = create n_ds
lds_xmloption.dataobject = "d_kp_req_expense_approve_option"
lds_xmloption.settransobject( itr_sqlca )

lds_xmllist = create n_ds
lds_xmllist.dataobject = "d_kp_req_expense_approve_list"
lds_xmllist.settransobject( itr_sqlca )

lds_reqexp_main = create n_ds
lds_reqexp_main.dataobject = "d_kp_req_expense_main"
lds_reqexp_main.settransobject( itr_sqlca )

lds_reqexp_det = create n_ds
lds_reqexp_det.dataobject = "d_kp_req_expense_detail"
lds_reqexp_det.settransobject( itr_sqlca )

ls_xmloption		= astr_keep_request.xml_option
ls_xmllist			= astr_keep_request.xml_list

if inv_dwxmliesrv.of_xmlimport( lds_xmloption , ls_xmloption ) < 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาด ในการนำเข้าข้อมูล(1)"
	ithw_exception.text += "~r~nเงื่อนไขการดึงข้อมูลเปลี่ยนแปลงประเภทเงินหักรายเดือน"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

if inv_dwxmliesrv.of_xmlimport( lds_xmllist , ls_xmllist ) < 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาด ในการนำเข้าข้อมูล(2)"
	ithw_exception.text += "~r~nข้อมูลเปลี่ยนแปลงประเภทเงินหักรายเดือน"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

// กรองให้เหลือแต่พวกที่ทำรายการเท่านั้น
lds_xmllist.setfilter( "approve_status <> 8" )
lds_xmllist.filter()

// ลบพวกไม่ทำรายการทิ้งไป
lds_xmllist.rowsdiscard( 1, lds_xmllist.filteredcount(), filter! )

// ตรวจเช็คจำนวนแถวอีกที
ll_count	= lds_xmllist.rowcount()
if ll_count <= 0 then
	ithw_exception.text = "~r~nไม่พบข้อมุลการทำรายการ(3)"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
else
	inv_progress.istr_progress.subprogress_max	= ll_count
end if

for ll_index = 1 to ll_count
	inv_progress.istr_progress.subprogress_index	= ll_index

	// ตรวจสอบการสั่งหยุดทำงาน
	yield()
	if inv_progress.of_is_stop() then
		ithw_exception.text = "~r~nยกเลิกการทำรายการโดยผู้ใช้(4)"
		lb_err = true ; Goto objdestroy
	end if
	
	ls_coopid				= lds_xmllist.object.coop_id[1]
	ls_reqdocno			= lds_xmllist.object.kpreqexpense_docno[1]
	ls_approveid		= lds_xmllist.object.approve_id[1]
	li_approve			= lds_xmllist.object.approve_status[1]
	ldtm_approve		= lds_xmllist.object.approve_date[1]
	
	lds_reqexp_main.retrieve( ls_coopid , ls_reqdocno )
	lds_reqexp_det.retrieve( ls_coopid , ls_reqdocno )
	
	lds_reqexp_main.object.approve_status[1]				= li_approve
	lds_reqexp_main.object.approve_id[1]					= ls_approveid
	lds_reqexp_main.object.approve_date[1]				= ldtm_approve
	
	if li_approve = 1 then
		// อนุมัติ ผ่านรายการ
		try
			this.of_post_kpmembexp( lds_reqexp_main , lds_reqexp_det )
		catch( Exception lthw_reqexp )
			ithw_exception.text		= lthw_reqexp.text
			lb_err = true
		end try
		if lb_err then Goto objdestroy
	else
		// ไม่อนุมัติ ผ่านรายการ
		ls_memno	= lds_xmllist.object.member_no[1]
		update kpreqchgexpense
		set approve_status = :li_approve ,
		approve_id = :ls_approveid ,
		approve_date = :ldtm_approve
		where coop_id = :ls_coopid
		and kpreqexpense_docno = :ls_reqdocno
		using itr_sqlca;
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text = "อัพเดทผู้ทำรายการอนุมัติ พบข้อผิดพลาด"  
			ithw_exception.text += "~r~nเลขที่เอกสาร : "+ ls_reqdocno
			ithw_exception.text += "~r~nทะเบียน : "+ ls_memno
			ithw_exception.text += "~r~n"+ string( itr_sqlca.sqlcode )
			ithw_exception.text += "~r~n"+ itr_sqlca.sqlerrtext
			lb_err = true ; Goto objdestroy
		end if
	end if
	
	inv_progress.istr_progress.subprogress_text = string(ll_index,"#,##0") + "/" + string(ll_count,"#,##0") +" ทะเบียน "+ls_memno
	
next

objdestroy:
if isvalid( lds_reqexp_det ) then destroy lds_reqexp_det ;
if isvalid( lds_reqexp_main ) then destroy lds_reqexp_main ;
if isvalid( lds_xmllist ) then destroy lds_xmllist ;
if isvalid( lds_xmloption ) then destroy lds_xmloption ;

this.of_setsrvdwxmlie( false )

inv_progress.istr_progress.status = 1

if lb_err then
	rollback using itr_sqlca ;
	throw ithw_exception
end if

commit using itr_sqlca ;

return 1
end function

public function integer of_save_req_expense_trn_approve (str_keep_request astr_keep_request) throws Exception;/***********************************************************
<description>
	สำหรับบันทึกการอนุมัติใบคำขอเปลี่ยนแปลงการส่งหักประจำเดือน( สำหรับผ่านรายการเพื่อขอเปลี่ยนแปลง )
</description>

<arguments>  
	str_keep_request.refchggrp_docno		String			เลขที่ใบคำขอเปลี่ยนแปลงสังกัด
	str_keep_request.entry_id					String			ผู้ทำรายการ
	str_keep_approve_status					Integer		สถานะการอนุมัติ( 1 อนุมัติ / 8 รออนุมัติ / -9 ไม่อนุมัติ )
	str_keep_request.operate_date			Datetime		วันที่ทำรายการ
</arguments> 

<return> 
	Integer
	1		ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	Revision History:
	Version 1.0 (Initial version) Modified Date 09/10/2012 by Godji
</usage> 
***********************************************************/
string ls_xmlmain
string ls_memcoop , ls_memno , ls_entry
string ls_kpreqdocno , ls_refchggrp
integer li_approve
long ll_index , ll_count , ll_chkrow
datetime ldtm_operate , ldtm_entry
boolean lb_err = false

n_ds lds_reqexp_main , lds_reqexp_det

ls_refchggrp	= astr_keep_request.refchggrp_docno
ls_entry			= astr_keep_request.entry_id
li_approve		= astr_keep_request.approve_status
ldtm_operate	= astr_keep_request.operate_date

this.of_setsrvdwxmlie( true )

lds_reqexp_main = create n_ds
lds_reqexp_main.dataobject = "d_kp_req_expense_main"
lds_reqexp_main.settransobject( itr_sqlca )

lds_reqexp_det = create n_ds
lds_reqexp_det.dataobject = "d_kp_req_expense_detail"
lds_reqexp_det.settransobject( itr_sqlca )

// ดึงข้อมูลใบคำขอ
select kpreqexpense_docno
into :ls_kpreqdocno
from kpreqchgexpense
where coop_id				= :is_coopid
and refchggrp_docno		= :ls_refchggrp
using itr_sqlca ;
if itr_sqlca.sqlcode <> 0 or isnull( ls_kpreqdocno ) or len( trim ( ls_kpreqdocno ) ) = 0 then
	return 1 // กรณีไม่มีการทำรายการ
	ithw_exception.text = "หาข้อมูลใบทำรายการเปลี่ยนแปลงการส่งหักประจำเดือน พบข้อผิดพลาด"  
	ithw_exception.text += "~r~nเลขที่ใบคำขอเปลี่ยนแปลงย้ายสังกัด(อ้างอิง) : "+ ls_refchggrp
	ithw_exception.text += "~r~nทะเบียนสมาชิก : " + ls_memno
	ithw_exception.text += "~r~n"+ string( itr_sqlca.sqlcode )
	ithw_exception.text += "~r~n"+ itr_sqlca.sqlerrtext
	lb_err = true ; Goto objdestroy
end if

if lds_reqexp_main.retrieve( is_coopid , ls_kpreqdocno ) < 1 then
	ithw_exception.text	= "ไม่พบข้อมูล ทะเบียนสมาชิก : " + ls_memno
	ithw_exception.text	+= "~r~n เลขที่ใบคำขอ" + ls_kpreqdocno 
	ithw_exception.text	+= "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

if lds_reqexp_det.retrieve( is_coopid , ls_kpreqdocno ) < 1 then
	ithw_exception.text	= "บันทึกข้อมูลการใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน (Kpreqexpense Master) ไม่ได้  "
	ithw_exception.text	+= "~r~n เลขที่ใบคำขอ" + ls_kpreqdocno 
	ithw_exception.text	+= "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

ldtm_entry		= datetime( today() , now() )

lds_reqexp_main.object.approve_status[1]				= li_approve
lds_reqexp_main.object.approve_id[1]					= ls_entry
lds_reqexp_main.object.approve_date[1]				= ldtm_operate

if li_approve = 1 then
	// อัพเดทการเรียกเก็บประจำเดือน
	try
		this.of_post_kpmembexp( lds_reqexp_main , lds_reqexp_det )
	catch( Exception lthw_reqexp )
		ithw_exception.text		= lthw_reqexp.text
		lb_err = true
	end try
else
	update kpreqchgexpense
	set approve_status = :li_approve ,
	kpreqexpense_status = -9 ,
	cancel_id = :ls_entry ,
	cancel_date = :ldtm_operate
	where coop_id = :is_coopid
	and kpreqexpense_docno = :ls_kpreqdocno
	using itr_sqlca;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text = "อัพเดทผู้ทำรายการอนุมัติ พบข้อผิดพลาด"  
		ithw_exception.text += "~r~nทะเบียน : "+ ls_memno
		ithw_exception.text += "~r~n"+ string( itr_sqlca.sqlcode )
		ithw_exception.text += "~r~n"+ itr_sqlca.sqlerrtext
		lb_err = true
	end if
end if

objdestroy:
if isvalid( lds_reqexp_det ) then destroy lds_reqexp_det ;
if isvalid( lds_reqexp_main ) then destroy lds_reqexp_main ;

this.of_setsrvdwxmlie( false )

if lb_err then
	rollback using itr_sqlca ;
	throw ithw_exception
end if

return 1
end function

private function integer of_chk_approve_wait (string as_memcoopid, string as_memno, ref string as_reqdocno);/***********************************************************
<description>
	สำหรับ ตรวจใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือนที่รออนุมัติ
</description>

<arguments>  
	as_coopid					String		รหัสสหกรณ์
	as_kpreqdocno				String		เลขที่ใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน
</arguments> 

<return> 
	1						Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 15/10/2012 by Godji
</usage> 
***********************************************************/
integer li_chk

select		count( kpreqexpense_docno ) , max( kpreqexpense_docno )
into		:li_chk , :as_reqdocno
from		kpreqchgexpense
where	memcoop_id			= :as_memcoopid
and		member_no				= :as_memno
and		kpreqexpense_status	= 1
and		approve_status		= 8
using itr_sqlca ;
if li_chk > 0 then
	return -1
end if


return 1
end function

public function integer of_init_req_expense_ccl (ref str_keep_request astr_keep_request) throws Exception;/***********************************************************
<description>
	สำหรับ Init ยกเลิกใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน
</description>

<arguments>  
	str_keep_adjust.xml_main{Ref}	String		xml ข้อมูลทะเบียนสมาชิก
	str_keep_adjust.xml_list{Ref}		String		xml แสดงรายการใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือนที่อนุมัติแล้ว
	str_keep_adjust.xml_detail{Ref}	String		xml แสดงรายละเอียดใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือนที่อนุมัติแล้ว
</arguments> 

<return> 
	1						Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 15/10/2012 by Godji
</usage> 
***********************************************************/
string		ls_xmlmain , ls_xmldetail
string		ls_memno , ls_reqdocno , ls_memcoopid 
long		ll_chkrow
dec{2}	ldc_prinbalance
datetime	ldtm_opedate, ldtm_slipdate
boolean lb_err = false

n_ds lds_info_mem , lds_info_memexp
n_ds lds_reqexp_main , lds_reqexp_det

this.of_setsrvdwxmlie( true )

lds_info_mem = create n_ds
lds_info_mem.dataobject = "d_kp_info_memdetail"
lds_info_mem.settransobject( itr_sqlca )

lds_info_memexp = create n_ds
lds_info_memexp.dataobject = "d_kp_info_mem_expense"
lds_info_memexp.settransobject( itr_sqlca )

lds_reqexp_main = create n_ds
lds_reqexp_main.dataobject = "d_kp_req_expense_main"
lds_reqexp_main.settransobject( itr_sqlca )

lds_reqexp_det = create n_ds
lds_reqexp_det.dataobject = "d_kp_req_expense_detail"
lds_reqexp_det.settransobject( itr_sqlca )

ls_xmlmain		= astr_keep_request.xml_main

if inv_dwxmliesrv.of_xmlimport( lds_reqexp_main , ls_xmlmain ) < 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาดในการนำเข้าข้อมูลใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

ls_memno		= lds_reqexp_main.object.member_no[1]
ls_memcoopid	= lds_reqexp_main.object.memcoop_id[1]

if this.of_chk_approve_wait( ls_memcoopid , ls_memno , ls_reqdocno ) <> 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาด มีคำขอรออนุมัติอยู่ "
	ithw_exception.text += "~r~nเลขที่ใบคำขอเปลี่ยนแปลงประเภทเงินหักรายเดือน : " + ls_reqdocno
	ithw_exception.text += "~r~nทะเบียนสมาชิก : " + ls_memno
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

ll_chkrow	= lds_info_mem.retrieve( ls_memcoopid , ls_memno )
if ll_chkrow < 1 then
	ithw_exception.text = "ไม่พบข้อมูลทะเบียนสมาชิก : " + ls_memno
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

lds_info_memexp.retrieve( ls_memcoopid , ls_memno )

//init main
if this.of_init_req_expense_main( lds_info_mem , lds_reqexp_main ) <> 1 then
	lb_err = true ; Goto objdestroy
end if

//init detail
if this.of_init_req_expense_detail( lds_info_memexp , lds_reqexp_det ) <> 1 then
	lb_err = true ; Goto objdestroy
end if

astr_keep_request.xml_main	= inv_dwxmliesrv.of_xmlexport( lds_reqexp_main )
astr_keep_request.xml_detail	= inv_dwxmliesrv.of_xmlexport( lds_reqexp_det )

objdestroy:
if isvalid( lds_reqexp_det ) then destroy lds_reqexp_det ;
if isvalid( lds_reqexp_main ) then destroy lds_reqexp_main ;
if isvalid( lds_info_mem ) then destroy lds_info_mem ;
if isvalid( lds_info_memexp ) then destroy lds_info_memexp ;

this.of_setsrvdwxmlie( false )

if lb_err then
	astr_keep_request.xml_main	= ""
	astr_keep_request.xml_detail	= ""
	rollback using itr_sqlca ;
	throw ithw_exception
end if

return 1
end function

public function integer of_initservice (n_cst_dbconnectservice atr_dbtrans);/***********************************************************
<description>
	ใช้สำหรับ Intial service
</description>

<arguments>  
	atr_dbtrans			n_cst_dbconnectservice	รายละเอียดการเชื่อมต่อฐานข้อมูล
</arguments> 

<return> 
	Integer				1 = success
</return> 

<usage> 
	เรียกใช้ครั้งเดียว และต้องเรียกใช้เป็นฟังก์ชั่นแรกหลังจาก create instance
	ก่อนที่จะเรียกใช้ฟังก์ชั่นอื่น ๆ
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 28/9/2010 by MiT
</usage> 
***********************************************************/

itr_sqlca = atr_dbtrans.itr_dbconnection
is_coopcontrol	= atr_dbtrans.is_coopcontrol
is_coopid = atr_dbtrans.is_coopid

// Service Transection
if isnull( inv_transection ) or not isvalid( inv_transection ) then
	inv_transection	= create n_cst_dbconnectservice
	inv_transection	= atr_dbtrans
end if

itr_sqlca 		= inv_transection.itr_dbconnection

// สร้าง Progress สำหรับแสดงสถานะการประมวลผล
inv_progress	= create n_cst_progresscontrol

return 1
end function

protected function integer of_setdsmodify (ref n_ds ads_requester, long al_row, boolean ab_keymodify);string		ls_iskey
long		ll_index, ll_count

ads_requester.setitemstatus( al_row, 0, primary!, datamodified! )

// ปรับ Attrib ทุก Column ให้เป็น Update ซะ
ll_count	= long( ads_requester.describe( "DataWindow.Column.Count" ) )
for ll_index = 1 to ll_count
	
	ls_iskey	= ads_requester.describe("#"+string( ll_index )+".Key")
	
	// ถ้าเป็น PK และเงื่อนไขคือไม่ปรับ Key ไม่ต้องปรับสถานะ
	if upper( ls_iskey ) = "YES" and not( ab_keymodify ) then
		continue
	end if
	
	ads_requester.setitemstatus( 1, ll_index, primary!, datamodified! )
next

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

on n_cst_keeping_request_all.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_keeping_request_all.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ithw_exception = create Exception
end event

event destructor;if isvalid( ithw_exception ) then destroy ithw_exception
if isvalid( inv_progress ) then destroy inv_progress

end event

