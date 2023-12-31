$PBExportHeader$n_cst_insurance_keeping_process.sru
forward
global type n_cst_insurance_keeping_process from nonvisualobject
end type
end forward

global type n_cst_insurance_keeping_process from nonvisualobject
end type
global n_cst_insurance_keeping_process n_cst_insurance_keeping_process

type variables
datetime	idtm_datepro, idtm_keepdate, idtm_post
n_ds		ids_loandata, ids_contintspc, ids_inttable
n_ds		ids_constant

n_cst_loansrv_interest		inv_intsrv
n_cst_progresscontrol		inv_progress


transaction	itr_sqlca
Exception	ithw_exception

end variables

forward prototypes
public function integer of_xmlimport (n_ds ads_info, string as_dwobjname, string as_xmlinfo)
public function string of_xmlexport (n_ds ads_info)
public function integer of_rcvprocess (string as_xmldata) throws Exception
public function integer of_initservice (n_cst_dbconnectservice atr_dbtrans)
public function integer of_deletemonth (string as_recvperiod, string as_temp) throws Exception
public function integer of_setprogress (ref n_cst_progresscontrol anv_progress)
public function integer of_insurance_proc (string as_period, string as_instype) throws Exception
public function integer of_postprocess (string as_xmldata) throws Exception
public function integer of_insurance_post (string as_period, string as_instype) throws Exception
public function integer of_posttomastdet (string as_memno, string as_recvperiod, string as_refmemno, integer ai_seqno, datetime adtm_postdate) throws Exception
public function integer of_posttomast (string as_memno, string as_recvperiod, string as_refmemno) throws Exception
public function integer of_analyzestring (string as_soucetext, ref string as_arg[]) throws Exception
public function integer of_buildsqlext (string as_arg[], string as_column, ref string as_sqlext)
public function integer of_post_insert_update_ins (str_ins_post_forinsertupdate astr_inspost) throws Exception
public function integer of_insurance_postfrom_kp (integer ai_year, integer ai_month, integer ai_proctype, string as_arg[], string as_entryid, datetime adtm_receipt) throws Exception
end prototypes

public function integer of_xmlimport (n_ds ads_info, string as_dwobjname, string as_xmlinfo);/***********************************************************
<description>
	Import Xml
</description>

<arguments>  
	ads_info				n_ds		datastore ที่จะ import ข้อมูลเข้า
	as_dwobjname		String		ชื่อ dw object
	as_xmlinfo			String		ข้อมูลในรูปแบบ xml ที่ต้องการ import
</arguments> 

<return> 
	Integer	 	จำนวนแถวที่ import ได้
					-1   No rows or startrow value supplied is greater than the number of rows in the string
					-3   Invalid argument
					-4   Invalid input
					-11   XML Parsing Error; XML parser libraries not found or XML not well formed
					-12   XML Template does not exist or does not match the DataWindow
					-13    Unsupported DataWindow style for import
					-14    Error resolving DataWindow nesting
</return> 

<usage> 
	Revision History:
	Version 1.0 (Initial version) Modified Date 13/10/2010 by MiT
</usage> 
***********************************************************/
integer	li_row

if not isvalid( ads_info ) or isnull( ads_info ) then
	ads_info = create n_ds
end if

ads_info.dataobject = as_dwobjname
ads_info.settransobject( itr_sqlca )

if ( as_xmlinfo = "" ) then return 0

li_row = ads_info.importstring( XML!, as_xmlinfo )

return li_row
end function

public function string of_xmlexport (n_ds ads_info);/***********************************************************
<description>
	Export xml เข้าสู่ datastore
</description>

<arguments>  
	ads_info				n_ds		datastore ที่จะ export ข้อมูล
</arguments> 

<return> 
	String		 	xml ที่ export ได้
</return> 

<usage> 
	Revision History:
	Version 1.0 (Initial version) Modified Date 13/10/2010 by MiT
</usage> 
***********************************************************/
string		ls_xml

if ( ads_info.rowcount() > 0 ) then
	ls_xml = string( ads_info.describe( "Datawindow.data.XML" ) )
else
	ls_xml = ""
end if

return ls_xml
end function

public function integer of_rcvprocess (string as_xmldata) throws Exception;string		ls_period, ls_temp
integer	li_chk, li_ins1, li_year, li_month, li_ins2, li_ins3, li_ins4, li_ins5, li_ins6, li_ins7, li_ins8
integer	li_maxproc, li_count, li_rowcount
datetime	ldtm_keepdate

n_ds lds_prokeeping_ins

// ดึงข้อมูลรายละเอียด
inv_progress.istr_progress.subprogress_text	= "โหลดข้อมูล"

//of_xmlimport( lds_prokeeping_ins, "d_ins_process_keeping", as_xmldata )
lds_prokeeping_ins = create n_ds
lds_prokeeping_ins.dataobject = "d_ins_process_keeping"
lds_prokeeping_ins.settransobject( itr_sqlca )
li_rowcount = lds_prokeeping_ins.importstring( XML!, as_xmldata )

li_year			= lds_prokeeping_ins.getitemnumber( 1, "year" ) //ปี
li_month 			= lds_prokeeping_ins.getitemnumber( 1, "month" ) //เดือน
idtm_keepdate	= datetime( date( '01/'+string( li_month )+ '/' + string( li_year - 543 ) ) )
ls_period			= string( li_year ) + string( li_month, "00" )
li_ins1			= lds_prokeeping_ins.getitemnumber( 1, "ins_1" )  //ประเภทประกัน
li_ins2			= lds_prokeeping_ins.getitemnumber( 1, "ins_2" )
li_ins3			= lds_prokeeping_ins.getitemnumber( 1, "ins_3" )
li_ins4			= lds_prokeeping_ins.getitemnumber( 1, "ins_4" )
li_ins5			= lds_prokeeping_ins.getitemnumber( 1, "ins_5" )
li_ins6			= lds_prokeeping_ins.getitemnumber( 1, "ins_6" )
li_ins7			= lds_prokeeping_ins.getitemnumber( 1, "ins_7" )
li_ins8			= lds_prokeeping_ins.getitemnumber( 1, "ins_8" )
idtm_datepro	= lds_prokeeping_ins.getitemdatetime( 1, "pro_date")

li_maxproc = li_ins1 + li_ins2 + li_ins3 + li_ins4
li_maxproc +=  li_ins5 + li_ins6 + li_ins7 + li_ins8
inv_progress.istr_progress.progress_max = li_maxproc
inv_progress.istr_progress.status = 8

ls_temp = '('
if li_ins1 = 1 then ls_temp += "'01'"
if li_ins2 = 1 then ls_temp += "',02'"
if li_ins3 = 1 then ls_temp += "',03'"
if li_ins4 = 1 then ls_temp += "',04'"
if li_ins5 = 1 then ls_temp += "',05'"
if li_ins6 = 1 then ls_temp += "',06'"
if li_ins7 = 1 then ls_temp += "',07'"
if li_ins8 = 1 then ls_temp += "',08'"
 
ls_temp += ')'

li_count ++
inv_progress.istr_progress.progress_index = li_count

if this.of_deletemonth( ls_period, ls_temp ) <> 1 then
	rollback using itr_sqlca ;
	return -1
end if

if li_ins1 = 1 then // ประเภท 01 
	// ลบข้อมูลเรียกเก็บ
	delete from insreceivemonth
	where recv_period	= :ls_period
	and instype_code = '01'
	using itr_sqlca;


	li_count ++
	inv_progress.istr_progress.progress_index = li_count	
	li_chk	= this.of_insurance_proc( ls_period, '01' )
	if li_chk = 1 then
//		lb_genamt = true
		commit using itr_sqlca ;
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if 

if li_ins2 = 1 then // ประเภท 02
// ลบข้อมูลเรียกเก็บ
	delete from insreceivemonth
	where recv_period	= :ls_period
	and instype_code = '02'
	using itr_sqlca;
	li_count ++
	inv_progress.istr_progress.progress_index = li_count	
	li_chk	= this.of_insurance_proc( ls_period, '02' )
	if li_chk = 1 then
//		lb_genamt = true
		commit using itr_sqlca ;
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if 

if li_ins3 = 1 then // ประเภท 03
// ลบข้อมูลเรียกเก็บ
	delete from insreceivemonth
	where recv_period	= :ls_period
	and instype_code = '03'
	using itr_sqlca;
	li_count ++
	inv_progress.istr_progress.progress_index = li_count	
	li_chk	= this.of_insurance_proc( ls_period, '03' )
	if li_chk = 1 then
//		lb_genamt = true
		commit using itr_sqlca ;
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if 
if li_ins4 = 1 then // ประเภท 04
	// ลบข้อมูลเรียกเก็บ
	delete from insreceivemonth
	where recv_period	= :ls_period
	and instype_code = '04'
	using itr_sqlca;
	li_count ++
	inv_progress.istr_progress.progress_index = li_count	
	li_chk	= this.of_insurance_proc( ls_period, '04' )
	if li_chk = 1 then
//		lb_genamt = true
		commit using itr_sqlca ;
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if 
if li_ins5 = 1 then // ประเภท 05
	// ลบข้อมูลเรียกเก็บ
	delete from insreceivemonth
	where recv_period	= :ls_period
	and instype_code = '05'
	using itr_sqlca;
	li_count ++
	inv_progress.istr_progress.progress_index = li_count	
	li_chk	= this.of_insurance_proc( ls_period, '05' )
	if li_chk = 1 then
//		lb_genamt = true
		commit using itr_sqlca ;
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if 
if li_ins6 = 1 then // ประเภท 06
	// ลบข้อมูลเรียกเก็บ
	delete from insreceivemonth
	where recv_period	= :ls_period
	and instype_code = '06'
	using itr_sqlca;
	
	li_count ++
	inv_progress.istr_progress.progress_index = li_count	
	li_chk	= this.of_insurance_proc( ls_period, '06' )
	if li_chk = 1 then
//		lb_genamt = true
		commit using itr_sqlca ;
		//ithw_exception.text = "ประมวลเรียบร้อยส่วนหนึ่ง ready"
		//throw ithw_exception
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if 
inv_progress.istr_progress.progress_max = li_maxproc	
inv_progress.istr_progress.status = 1

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

// สร้าง Progress สำหรับแสดงสถานะการประมวลผล
inv_progress = create n_cst_progresscontrol

return 1
end function

public function integer of_deletemonth (string as_recvperiod, string as_temp) throws Exception;integer	li_chk

inv_progress.istr_progress.progress_text		= "กำลัง Clear ข้อมูล"
inv_progress.istr_progress.subprogress_text	= "กำลัง Clear ข้อมูล"


//ลบข้อมูลเรียกเก็บเดือนก่อน
delete from insreceivemonth
where recv_period	 < :as_recvperiod using itr_sqlca;

yield()
if ( itr_sqlca.sqlcode <> 0 ) then
	ithw_exception.text += "พบข้อผิดพลาด ขณะ Clear ข้อมูลเรียกเก็บ~r~n"+ string( itr_sqlca.sqlcode ) + "  " + itr_sqlca.sqlerrtext
	throw ithw_exception
end if

// ลบข้อมูลเรียกเก็บ
delete from insreceivemonth
where recv_period	= :as_recvperiod
and instype_code in :as_temp
using itr_sqlca;

yield()
if ( itr_sqlca.sqlcode <> 0 ) then
	ithw_exception.text += "พบข้อผิดพลาด ขณะ Clear ข้อมูลเรียกเก็บ~r~n"+ string( itr_sqlca.sqlcode ) + "  " + itr_sqlca.sqlerrtext
	throw ithw_exception
end if


return 1
end function

public function integer of_setprogress (ref n_cst_progresscontrol anv_progress);/***********************************************************
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

public function integer of_insurance_proc (string as_period, string as_instype) throws Exception;string		ls_member, ls_level_code, ls_instype_code
dec{2}	ldc_inspayment_amt, ldc_inspaymentarrmth, ldc_inspaymentarr, ldc_insperiodpay
long  		ll_rowcount, ll_row, ll_insgroup_id
n_ds		lds_keeping_ins
inv_progress.istr_progress.progress_text		= "ประกันชีวิต " + as_instype
inv_progress.istr_progress.subprogress_text	= "กำลังดึงข้อมูล"
inv_progress.istr_progress.subprogress_index	= 0
inv_progress.istr_progress.subprogress_max	= 0

lds_keeping_ins = create n_ds
if as_instype = '01' or as_instype = '02' or as_instype = '03' or as_instype = '06' then
	lds_keeping_ins.dataobject = "d_ins_pro_keeping"
else
	lds_keeping_ins.dataobject = "d_ins_pro_keeping_arr"
end if
lds_keeping_ins.settransobject( itr_sqlca )
lds_keeping_ins.retrieve( as_instype, idtm_keepdate )

ll_rowcount = lds_keeping_ins.rowcount( )

inv_progress.istr_progress.subprogress_max = ll_rowcount


if ( ll_rowcount < 1 ) then 
	destroy lds_keeping_ins
	ithw_exception.text += "ประมวลประกัน~nไม่พบข้อมูลรายการประกัน"
	throw ithw_exception	
	
end if

for ll_row = 1 to ll_rowcount	
	inv_progress.istr_progress.subprogress_index	= ll_row
	// ตรวจสอบการสั่งหยุดทำงาน
	yield()
	if inv_progress.of_is_stop() then
		destroy lds_keeping_ins
		return 0
	end if
	ls_member 				= trim( lds_keeping_ins.getitemstring( ll_row, "member_no" ) )
	ls_level_code 			= trim( lds_keeping_ins.getitemstring( ll_row, "level_code" ) )
	ls_instype_code 		= trim( lds_keeping_ins.getitemstring( ll_row, "instype_code" ) )
	ll_insgroup_id 			= lds_keeping_ins.getitemnumber( ll_row, "insgroup_id" ) 
	ldc_inspayment_amt 	= lds_keeping_ins.getitemdecimal( ll_row, "inspayment_amt" )	
	ldc_inspaymentarrmth  = lds_keeping_ins.getitemdecimal( ll_row, "insarrear_month" )	
	ldc_inspaymentarr  = lds_keeping_ins.getitemdecimal( ll_row, "inspayment_arrear" )	
	ldc_insperiodpay	 = lds_keeping_ins.getitemdecimal( ll_row, "insperod_payment" )	
	inv_progress.istr_progress.subprogress_text	= "ประมวลผลของประกัน " + ls_member + "  " + string( ll_row ) + '/' + string( ll_rowcount )
	
	if isnull(ldc_inspaymentarrmth) then ldc_inspaymentarrmth = 0
	if isnull(ldc_insperiodpay) then ldc_insperiodpay = 0
	if isnull(ldc_inspaymentarr) then ldc_inspaymentarr = 0
	
	if as_instype = '01' or as_instype = '02' or as_instype = '03'  or as_instype = '06'  then
		ldc_insperiodpay = ldc_inspayment_amt + ldc_inspaymentarrmth
	else
		ldc_insperiodpay = ldc_insperiodpay + ldc_inspaymentarrmth
		if ldc_insperiodpay > ldc_inspaymentarr then
			ldc_insperiodpay = ldc_inspaymentarr 
		end if
	end if
	
	inv_progress.istr_progress.subprogress_text = string( ll_row ) +". ทะเบียน "+ ls_member +" >  จำนวนเงิน "+string( ldc_insperiodpay, "#,##0.00" )

	INSERT INTO INSRECEIVEMONTH  
				( 	INSGROUP_ID,   		MEMBER_NO,   		RECV_PERIOD,   		INSTYPE_CODE,   		RECEIVE_AMT,   
					OPERATE_DATE,   	OPERATE_ID,   		POST_STATUS,   		POST_ID,   				POST_DATE,   
					CANCEL_STATUS,   	CANCEL_ID,   		CANCEL_DATE,   		KPMEMBER_NO )  
	  VALUES  
			(	:ll_insgroup_id,		:ls_member,		:as_period,				:ls_instype_code,		:ldc_insperiodpay,
				:idtm_datepro,			'',						8,							'',							null,
				null,							'',						null,					:ls_member
	  )using itr_sqlca  ;

	if ( itr_sqlca.sqlcode <> 0 ) then
		ithw_exception.text += "ไม่สามารถบันทึกข้อมูลการเรียกเก็บเลขสมชิก #" + ls_member + '  ' + ls_instype_code + '  ' + string(ll_insgroup_id) + string( itr_sqlca.sqlcode ) + "  " + itr_sqlca.sqlerrtext
		rollback using itr_sqlca;
		throw ithw_exception
	end if
next

destroy lds_keeping_ins

return 1
end function

public function integer of_postprocess (string as_xmldata) throws Exception;string		ls_period, ls_temp
integer	li_chk, li_ins1, li_year, li_month, li_ins2, li_ins3, li_ins4, li_ins5, li_ins6, li_ins7, li_ins8
integer	li_maxproc, li_count, li_rowcount
datetime	ldtm_keepdate

n_ds lds_prokeeping_ins

// ดึงข้อมูลรายละเอียด
inv_progress.istr_progress.subprogress_text	= "โหลดข้อมูล"

lds_prokeeping_ins = create n_ds
lds_prokeeping_ins.dataobject = "d_ins_process_keeping"
lds_prokeeping_ins.settransobject( itr_sqlca )
li_rowcount = lds_prokeeping_ins.importstring( XML!, as_xmldata )

li_year			= lds_prokeeping_ins.getitemnumber( 1, "year" ) //ปี
li_month 			= lds_prokeeping_ins.getitemnumber( 1, "month" ) //เดือน
idtm_post	= datetime( date( '01/'+string( li_month )+ '/' + string( li_year - 543 ) ) )
ls_period			= string( li_year ) + string( li_month, "00" )
li_ins1			= lds_prokeeping_ins.getitemnumber( 1, "ins_1" )  //ประเภทประกัน
li_ins2			= lds_prokeeping_ins.getitemnumber( 1, "ins_2" )
li_ins3			= lds_prokeeping_ins.getitemnumber( 1, "ins_3" )
li_ins4			= lds_prokeeping_ins.getitemnumber( 1, "ins_4" )
li_ins5			= lds_prokeeping_ins.getitemnumber( 1, "ins_5" )
li_ins6			= lds_prokeeping_ins.getitemnumber( 1, "ins_6" )
li_ins7			= lds_prokeeping_ins.getitemnumber( 1, "ins_7" )
li_ins8			= lds_prokeeping_ins.getitemnumber( 1, "ins_8" )
idtm_datepro	= lds_prokeeping_ins.getitemdatetime( 1, "pro_date")

li_maxproc = li_ins1 + li_ins2 + li_ins3 + li_ins4
li_maxproc +=  li_ins5 + li_ins6 + li_ins7 + li_ins8
//li_maxproc += 1
inv_progress.istr_progress.progress_max = li_maxproc
inv_progress.istr_progress.status = 8



if li_ins1 = 1 then // ประเภท 01 
	li_count ++
	inv_progress.istr_progress.progress_index = li_count	
	li_chk	= this.of_insurance_post( ls_period, '01' )
	if li_chk = 1 then
//		lb_genamt = true
		commit using itr_sqlca ;
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if 

if li_ins2 = 1 then // ประเภท 01 
	li_count ++
	inv_progress.istr_progress.progress_index = li_count	
	li_chk	= this.of_insurance_post( ls_period, '02' )
	if li_chk = 1 then
//		lb_genamt = true
		commit using itr_sqlca ;
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if 

if li_ins3 = 1 then // ประเภท 01 
	li_count ++
	inv_progress.istr_progress.progress_index = li_count	
	li_chk	= this.of_insurance_post( ls_period, '03' )
	if li_chk = 1 then
//		lb_genamt = true
		commit using itr_sqlca ;
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if 


inv_progress.istr_progress.progress_max = li_maxproc	
inv_progress.istr_progress.status = 1

return 1
end function

public function integer of_insurance_post (string as_period, string as_instype) throws Exception;string		ls_member, ls_level_code, ls_instype_code
dec{2}	ldc_inspayment_amt
long  		ll_rowcount, ll_row, ll_insgroup_id, ll_seq_no, ll_last_stm
integer	li_post_status
n_ds		lds_post_ins
inv_progress.istr_progress.progress_text		= "ประกันชีวิต"
inv_progress.istr_progress.subprogress_text	= "กำลฌังดึงข้อมูล"
inv_progress.istr_progress.subprogress_index	= 0
inv_progress.istr_progress.subprogress_max	= 0

lds_post_ins = create n_ds
lds_post_ins.dataobject = "d_post_ins"
lds_post_ins.settransobject( itr_sqlca )
lds_post_ins.retrieve( as_period, as_instype )

ll_rowcount = lds_post_ins.rowcount( )

inv_progress.istr_progress.subprogress_max = ll_rowcount


if ( ll_rowcount < 1 ) then 
	return -1
	destroy lds_post_ins
	ithw_exception.text += "~nพบข้อผิดพลาดในการสร้างชุด SQL รายการประกัน"
	throw ithw_exception	
end if

for ll_row = 1 to ll_rowcount	
	inv_progress.istr_progress.subprogress_index	= ll_row
	// ตรวจสอบการสั่งหยุดทำงาน
	yield()
	ls_member 				= trim( lds_post_ins.getitemstring( ll_row, "member_no" ) )
	ls_instype_code 		= trim( lds_post_ins.getitemstring( ll_row, "instype_code" ) )
	ll_insgroup_id 			= lds_post_ins.getitemnumber( ll_row, "insgroup_id" ) 
	ldc_inspayment_amt 	= lds_post_ins.getitemdecimal( ll_row, "receive_amt" )	
	ll_last_stm				= lds_post_ins.getitemnumber( ll_row, "last_stm_no" )	
	li_post_status			= lds_post_ins.getitemnumber( ll_row, "post_status" )
	
//	select max( SEQ_NO )
//	into	:ll_seq_no
//	from INSGROUPSTATEMENT
//	where INSGROUP_ID = :ll_insgroup_id 
//	and	instype_code  = :ls_instype_code using itr_sqlca ;

	if isnull( ll_last_stm ) then ll_last_stm =	 0
	ll_last_stm ++

choose case li_post_status 
		
	case 1 //รายการปกติ
		
		inv_progress.istr_progress.subprogress_text	= "ประมวลตัดยอด " + ls_member + "  " + string( ll_row ) + '/' + string( ll_rowcount )
		
		  INSERT INTO INSGROUPSTATEMENT  
				( MEMBER_NO,   				SEQ_NO,   					INSTYPE_CODE,   			INSITEMTYPE_CODE,   		INSPERIOD_AMT,   
				  INSPERIOD_PAYMENT,   	OPERATE_DATE,   		INSGROUPSLIP_DATE,   	ENTRY_DATE,   				ENTRY_ID,   
				  INSPAYMENT_ARREAR,   	INSPRINCE_BALANCE,   	REFDOC_NO,   				COOPBRANCH_ID,   			MONEYTYPE_CODE,   
				  INSGROUPDOC_NO,   		INSARREAR_MONTH,   	INSGROUP_ID )  
	  VALUES 
			( :ls_member,					:ll_last_stm,					:ls_instype_code,			'IPM',								null,
			  '',								:idtm_post,					:idtm_post,					null,								'',
			  0.00,							:ldc_inspayment_amt,	'',								null,								'TRN',
			  :ll_insgroup_id,				null,							:ll_insgroup_id) using itr_sqlca  ;
	
	yield()
	
	if ( itr_sqlca.sqlcode <> 0 ) then
		ithw_exception.text += "........~r~n"+ string( itr_sqlca.sqlcode ) + "  " + itr_sqlca.sqlerrtext
		throw ithw_exception
	end if
	
	update 	insgroupmaster
	set			last_stm_no 		= :ll_last_stm,
				process_date 		= :idtm_post
	where 	INSGROUP_ID 		= :ll_insgroup_id
	and 		INSTYPE_CODE 	= :ls_instype_code using itr_sqlca ;
	
	yield()
	
	if ( itr_sqlca.sqlcode <> 0 ) then
		ithw_exception.text += "ไม่สมารถ updateรายการปกติ ลง insgroupmaster ได้~r~n"+ string( itr_sqlca.sqlcode ) + "  " + itr_sqlca.sqlerrtext
		throw ithw_exception
	end if
	
case -1 //รายการยกเลิก
	
	update 	insgroupmaster
	set			process_date 		= :idtm_post,
				misspay_amt		= misspay_amt + :ldc_inspayment_amt
	where 	INSGROUP_ID 		= :ll_insgroup_id
	and 		INSTYPE_CODE 	= :ls_instype_code using itr_sqlca ;
	
	yield()
	
	if ( itr_sqlca.sqlcode <> 0 ) then
		ithw_exception.text += "ไม่สมารถ updateรายการยกเลิก ลง insgroupmaster ได้~r~n"+ string( itr_sqlca.sqlcode ) + "  " + itr_sqlca.sqlerrtext
		throw ithw_exception
	end if
	
end choose 

next

destroy lds_post_ins

return 1
end function

public function integer of_posttomastdet (string as_memno, string as_recvperiod, string as_refmemno, integer ai_seqno, datetime adtm_postdate) throws Exception;integer li_seqno
// บันทึกการผ่านรายการ
update	kptempreceivedet
set		posting_status	= 1,
		posting_date	= :adtm_postdate
where	( kptempreceivedet.member_no	= :as_memno ) and
		( kptempreceivedet.recv_period	= :as_recvperiod ) and
		( kptempreceivedet.ref_membno	= :as_refmemno ) and 
		( kptempreceivedet.seq_no		= :ai_seqno ) ;
if sqlca.sqlcode <> 0 then
	return -1
end if

//select max( seq_no )
//into :li_seqno
//from kpmastreceivedet  
//where  ( kpmastreceivedet.member_no	= :as_memno ) and
//		( kpmastreceivedet.recv_period	= :as_recvperiod ) and
//		( kpmastreceivedet.ref_membno	= :as_refmemno ) ;
//		
//if isnull( li_seqno ) then li_seqno = 0
//li_seqno ++

insert into kpmastreceivedet
		( member_no, recv_period, ref_membno, seq_no, keepitemtype_code, shrlontype_code, item_seqno, 
		  loancontract_no, description, period, principal_payment, interest_payment, intarrear_payment, item_payment,
		  item_balance, principal_balance, calintfrom_date, calintto_date, principal_period, interest_period, bfprinbalance_amt,
		  bfperiod, bflastcalint_date, bflastpay_date, bfinterest_arrear, bfintmonth_arrear, bfcontract_status, bfcontract_type,
		  keepitem_status, posting_date, cancel_id, cancel_date )
select	member_no, recv_period, ref_membno, seq_no , keepitemtype_code, shrlontype_code, item_seqno, 
		loancontract_no, description, period, principal_payment, interest_payment, intarrear_payment, item_payment,
		item_balance, principal_balance, calintfrom_date, calintto_date, principal_period, interest_period, bfprinbalance_amt,
		bfperiod, bflastcalint_date, bflastpay_date, bfinterest_arrear, bfintmonth_arrear, bfcontract_status, bfcontract_type,
		keepitem_status, posting_date, cancel_id, cancel_date
from	kptempreceivedet
where	( member_no	= :as_memno ) and
		( recv_period	= :as_recvperiod ) and
		( ref_membno	= :as_refmemno ) and
		( seq_no		= :ai_seqno ) ;
if sqlca.sqlcode <> 0 then
	ithw_exception.text += "พบข้อผิดพลาด ขณะ Clear ข้อมูลเรียกเก็บ~r~n"+ string( itr_sqlca.sqlcode ) + "  " + itr_sqlca.sqlerrtext
	throw ithw_exception
	return -1
end if

return 1
end function

public function integer of_posttomast (string as_memno, string as_recvperiod, string as_refmemno) throws Exception;integer		li_count
li_count = 0
select	count( member_no )
into		:li_count
from	kpmastreceive
where	( member_no	= :as_memno ) and
		( recv_period	= :as_recvperiod ) and 
		( ref_membno	= :as_refmemno ) ;

if li_count = 0 or isnull( li_count ) then
	insert into kpmastreceive
			( member_no, recv_period, ref_membno, membgroup_code, process_date, receipt_no, receipt_date,
			  operate_date, sharestk_value, interest_accum, keeping_status, receive_amt,
			  grt_list, money_text, moneytype_code, tofrom_accid, subgroup_code )
	select	member_no, recv_period, ref_membno, membgroup_code, process_date, receipt_no, receipt_date,
			operate_date, sharestk_value, interest_accum, keeping_status, receive_amt,
			grt_list, money_text, moneytype_code, tofrom_accid, subgroup_code
	from	kptempreceive
	where	( member_no	= :as_memno ) and
			( recv_period	= :as_recvperiod ) and
			( ref_membno	= :as_refmemno ) ;
	if sqlca.sqlcode = -1 then
		ithw_exception.text += "พบข้อผิดพลาด ขณะ Clear ข้อมูลเรียกเก็บ~r~n"+ string( itr_sqlca.sqlcode ) + "  " + itr_sqlca.sqlerrtext
		throw ithw_exception
	end if
end if
return 1
end function

public function integer of_analyzestring (string as_soucetext, ref string as_arg[]) throws Exception;string	ls_souce[], ls_dessingle[], ls_desbetween[], ls_desless[], ls_desmore[]
string	ls_temp[], ls_empty[], ls_text
integer	li_count, li_index, li_csingle, li_ctemp
n_cst_stringservice	lnv_string

lnv_string.of_parsetoarray ( as_soucetext, ",", ls_souce[] )
li_count = upperbound(ls_souce[])

for li_index = 1 to li_count
	ls_text = trim(ls_souce[li_index])
	if lnv_string.of_isalphanumthai(ls_text) then
		li_csingle++
		ls_dessingle[li_csingle] = "'"+trim(ls_text)+"'"
	else
		if pos(ls_text, "-", 1) = 0 then
			messagebox("ประมวลผล",ls_text + " รหัสที่ใส่ เครื่องดูแล้วไม่เข้าใจ (งง) ใส่ใหม่นะ...")
			return -1
		end if
		
		lnv_string.of_parsetoarray ( ls_text, "-", ls_temp[] )
		choose case upperbound(ls_temp[])
			case 1		// ประเภท ขีด ตามหลัง เช่น   11030-
				li_ctemp	= upperbound(ls_desmore[])
				if isnull(li_ctemp) then li_ctemp = 0
				ls_desmore[li_ctemp +1] = "'"+trim(ls_temp[1])+"'"
				
			case 2		// ประเภท มีขีด ตรงกลาง หรือ ขีดนำหน้า เช่น 11030-11040, -11050
				if trim(ls_temp[1]) = "" or isnull(ls_temp[1]) then
					li_ctemp	= upperbound(ls_desless[])
					if isnull(li_ctemp) then li_ctemp = 0
					ls_desless[li_ctemp +1] = "'"+trim(ls_temp[2])+"'"
				else
					li_ctemp	= upperbound(ls_desbetween[])
					if isnull(li_ctemp) then li_ctemp = 0
					ls_desbetween[li_ctemp +1] = "'"+trim(ls_temp[1])+"' and '"+trim(ls_temp[2])+"'"
				end if
				
			case else	// ประเภทใส่ขีดมากกว่า 1 ขีด
				messagebox("ประมวลผล",ls_text + " รหัสที่ใส่ เครื่องดูแล้วไม่เข้าใจ (งง) ใส่ใหม่นะ...")
				return -1
		end choose
		ls_temp[] = ls_empty[]
	end if
next

// ตรวจ between
li_count = upperbound(ls_desbetween[])
for li_index = 1 to li_count
	as_arg[li_index] = " between "+ls_desbetween[li_count]
next

// ตรวจ less than
li_count = upperbound(ls_desless[])
for li_index = 1 to li_count
	li_ctemp	= upperbound(as_arg[])
	if isnull(li_ctemp) then li_ctemp = 0
	as_arg[li_ctemp + 1] = " <= "+ls_desless[li_count]
next

// ตรวจ more than
li_count = upperbound(ls_desmore[])
for li_index = 1 to li_count
	li_ctemp	= upperbound(as_arg[])
	if isnull(li_ctemp) then li_ctemp = 0
	as_arg[li_ctemp + 1] = " >= "+ls_desmore[li_count]
next

// ตรวจ single
ls_text = ""
lnv_string.of_arraytostring(ls_dessingle[],",",ls_text)

if len(ls_text) > 0 then
	li_index = upperbound(as_arg[])
	if isnull(li_index) then li_index = 0
	as_arg[li_index+1] = " in ("+ls_text+") "
end if

return 1
end function

public function integer of_buildsqlext (string as_arg[], string as_column, ref string as_sqlext);integer	li_index, li_count

li_count = upperbound(as_arg[])
if isnull(li_count) then li_count = 0

for li_index = 1 to li_count
	if li_index = 1 then
		as_sqlext = " ( "+as_column+as_arg[li_index]+" ) "
	else
		as_sqlext += " or ( "+as_column+as_arg[li_index]+" ) "
	end if
next

if len(as_sqlext) > 0 then
	as_sqlext = "( "+as_sqlext+" )"
end if

return 1

end function

public function integer of_post_insert_update_ins (str_ins_post_forinsertupdate astr_inspost) throws Exception;/*
of_post_insert_update_ins  ฟังก์ชั่น ให้ระบบอื่น เรียกใช้ กรณีต้อง เพิ่ม statement และ ปรับปรุงรายการประกัน

	long		al_insgroupid		      = "เลขที่ประกัน"
	string		as_memberno		      = "เลขที่สมชิก"
	string		as_instypecode		      = "ประเภทประกัน"
	string		as_insitemtype		      = "ประเภทรหัสรายการ"
	decimal { 2 }		adc_itempayment		      = "จำนวนเงิน"
	string		as_refdocno		      = "เลขที่ใบเสร็จ"
	datetime		adtm_operate		      = "วันที่ทำรายการ"
	datetime		adtm_slip		      = "วันที่ใบเสร็จ"
	datetime		adtm_entry		      = "วันที่บันทึกของเครือง"
	string		as_entryid		      = "รหัสผู้บันทึก"
	string		as_moneytype		      = "ประเภทเงิน

*/

string		ls_member, ls_level_code, ls_instype_code,ls_instypecode,ls_receiptno
string		ls_memno, ls_refmemno, ls_sqlext, ls_temp, ls_sqlexttemp, ls_recvperiod, ls_insureno, ls_insgroupno,ls_moneytypecode
string		ls_memprior, ls_refprior, ls_moneytypepri, ls_itemtypecode, ls_entryid, ls_branchid, ls_moneytype
integer		li_rcvseqno, li_stepvalue, li_chk,	li_period,	li_laststmt, li_lastperiod, li_laststmno
long		ll_index, ll_count, ll_insgroupid
dec{2}		ldc_stkins,	ldc_inpayarr,	ldc_insureamt, ldc_inspayment, ldc_inspayarrbal
dec{2}	ldc_inspayment_amt, ldc_bfinspayarrear, ldc_insbalance
long  		ll_rowcount, ll_row, ll_insgroup_id, ll_seq_no, ll_last_stm
integer	li_post_status, li_signflag
datetime ldtm_receiptdate, ldtm_entrydate, ldtm_operate, ldtm_slip

ll_insgroupid = astr_inspost.al_insgroupid
ls_member = astr_inspost.as_memberno
ls_instype_code = astr_inspost.as_instypecode
ls_itemtypecode = astr_inspost.as_insitemtype
ldc_insureamt = astr_inspost.adc_itempayment
ls_receiptno = astr_inspost.as_refdocno
ldtm_operate = astr_inspost.adtm_operate
ldtm_slip = astr_inspost.adtm_slip
ldtm_entrydate = astr_inspost.adtm_entry
ls_entryid = astr_inspost.as_entryid
ls_moneytype   = astr_inspost.as_moneytype

select  inspayment_amt, INSPAYMENT_ARREAR , INSSTK_BLANCE, LAST_PERIOD,  LAST_STM_NO
into :ldc_inspayment, :ldc_bfinspayarrear,  :ldc_insbalance,  :li_lastperiod, :li_laststmno
from insgroupmaster where insgroup_id  = :ll_insgroupid using itr_sqlca ;

if itr_sqlca.sqlcode = 100 then
	ithw_exception.text += "พบข้อผิดพลาด ไม่พบข้อมูลประกัน~r~n"+ string( itr_sqlca.sqlcode ) + "  " + itr_sqlca.sqlerrtext
	throw ithw_exception
	return -1
end if
if isnull( li_lastperiod ) then  li_lastperiod = 0
if isnull( li_laststmno ) then  li_laststmno = 0
if isnull( ldc_insbalance ) then  ldc_insbalance = 0
if isnull( ldc_bfinspayarrear ) then  ldc_bfinspayarrear = 0
if isnull( ldc_inspayment ) then  ldc_inspayment = 0


select sign_flag 
into :li_signflag
from insucfitemptype where insitemtype_code = :ls_itemtypecode using itr_sqlca ;

if li_signflag  > 0 then
	ldc_inspayarrbal = ldc_bfinspayarrear - ldc_insureamt
	ldc_stkins = ldc_insbalance + ldc_insureamt
else
	ldc_inspayarrbal = ldc_bfinspayarrear +  ldc_insureamt
	ldc_stkins = ldc_insbalance - ldc_insureamt
end if

 INSERT INTO INSGROUPSTATEMENT  
			( 	MEMBER_NO,			SEQ_NO,   						INSTYPE_CODE,   		INSITEMTYPE_CODE,   	INSPERIOD_AMT,   			INSPERIOD_PAYMENT,   
				OPERATE_DATE,   	INSGROUPSLIP_DATE	,   	ENTRY_DATE,   		ENTRY_ID,   				INSPAYMENT_ARREAR,  	 INSPRINCE_BALANCE,   
				REFDOC_NO,   		COOPBRANCH_ID,    	          MONEYTYPE_CODE ,	insgroupdoc_no )  
 VALUES 
		( 		:ls_memno,              	:li_laststmt,   			   	      :ls_instypecode,        :ls_itemtypecode,   	:li_period,   					      	:ldc_insureamt,   
				:ldtm_operate,       	:ldtm_slip,   						 :ldtm_entrydate,      :ls_entryid,  			     :ldc_inspayarrbal,   				 :ldc_stkins,   
				:ls_receiptno,         	:ls_branchid,   					 :ls_moneytype,		:ls_insgroupno )   		using itr_sqlca   ;
 if sqlca.sqlcode <> 0 then
		ithw_exception.text += "พบข้อผิดพลาด ไม่สามารถเพิ่มรายการstatement~r~n"+ string( itr_sqlca.sqlcode ) + "  " + itr_sqlca.sqlerrtext
		throw ithw_exception
		return -1
end if
	
	
update	INSGROUPMASTER
set		INSSTK_BLANCE	= :ldc_stkins,
			LAST_PERIOD		= :li_period,
			LAST_STM_NO		= :li_laststmt,
			process_date 		= :ldtm_slip,
			INSPAYMENT_ARREAR =  :ldc_inspayarrbal
where	( member_no 	= :ls_memno )  and ( INSTYPE_CODE = :ls_instypecode )  and ( insgroup_id  = :ll_insgroupid  )   using itr_sqlca  ;
if sqlca.sqlcode <> 0 then
	ithw_exception.text += "พบข้อผิดพลาด ไม่สามารถปรับปรุง master ได้~r~n"+ string( itr_sqlca.sqlcode ) + "  " + itr_sqlca.sqlerrtext
	throw ithw_exception
	return -1
end if

return 1
end function

public function integer of_insurance_postfrom_kp (integer ai_year, integer ai_month, integer ai_proctype, string as_arg[], string as_entryid, datetime adtm_receipt) throws Exception;/*
of_insurance_postfrom_kp  ฟังก์ชัน ประมวลผ่านรายการตัดยอด
integer   ai_year  ปี
integer   ai_month เดือน
integer   ai_proctype รูปแบบการประมวลผล
string   as_arg[]  ระบุหน่วย   ระบุเลขที่สมาชก
string  as_entryid  รหัสผู้ใช้


*/


string		ls_member, ls_level_code, ls_instype_code,ls_instypecode,ls_receiptno
string		ls_memno, ls_refmemno, ls_sqlext, ls_temp, ls_sqlexttemp, ls_recvperiod, ls_insureno, ls_insgroupno,ls_moneytypecode
string		ls_memprior, ls_refprior, ls_moneytypepri, ls_itemtypecode, ls_entryid, ls_branchid
integer		li_rcvseqno, li_stepvalue, li_chk,	li_period,	li_laststmt
long		ll_index, ll_count, ll_insgroupid
dec{2}		ldc_stkins,	ldc_inpayarr,	ldc_insureamt
dec{2}	ldc_inspayment_amt
long  		ll_rowcount, ll_row, ll_insgroup_id, ll_seq_no, ll_last_stm
integer	li_post_status
datetime ldtm_receiptdate, ldtm_entrydate
n_ds		lds_insure
inv_progress.istr_progress.progress_text		= "ประกันชีวิต"
inv_progress.istr_progress.subprogress_text	= "กำลฌังดึงข้อมูล"
inv_progress.istr_progress.subprogress_index	= 0
inv_progress.istr_progress.subprogress_max	= 0

ls_recvperiod	= string( ai_year )+string( ai_month, "00" )
ls_sqlexttemp	= "and ( kptempreceive.recv_period = '"+ls_recvperiod+"' ) "

choose case ai_proctype
	case 1
		ls_sqlext	= ls_sqlexttemp
	case 2
		this.of_buildsqlext( as_arg[], "mbmembmaster.membgroup_code", ls_sqlext )
		ls_sqlext	= ls_sqlexttemp+" and "+ls_sqlext
	case 3
		this.of_buildsqlext( as_arg[], "mbmembmaster.member_no", ls_sqlext )
		ls_sqlext	= ls_sqlexttemp+" and "+ls_sqlext
	case 4
		of_buildsqlext(as_arg[], "kptempreceive.emp_type", ls_sqlext )
		ls_sqlext	= ls_sqlexttemp+" and "+ls_sqlext
end choose
//ls_sqlexttemp	= "and ( kptempreceive.recv_period = '"+is_recvperiod+"' ) "
//
//choose case li_proctype
//	case 1
//		ls_sqlext	= ls_sqlexttemp
//	case 2
//		of_buildsqlext( is_arg[], "kptempreceive.membgroup_code", ls_sqlext )
//		ls_sqlext	= ls_sqlexttemp+" and "+ls_sqlext
//	case 3
//		of_buildsqlext( is_arg[], "kptempreceive.member_no", ls_sqlext )
//		ls_sqlext	= ls_sqlexttemp+" and "+ls_sqlext
//	case 4
//		of_buildsqlext( is_arg[], "kptempreceive.emp_type", ls_sqlext )
//		ls_sqlext	= ls_sqlexttemp+" and "+ls_sqlext
//end choose

ls_sqlext += " and kptempreceive.receipt_date = to_date( '"  + string( adtm_receipt, 'yyyy/mm/dd'  ) + "' , 'yyyy/mm/dd' )"
// สำหรับการไฟฟ้าเพิ่ม
ls_sqlext += " and kptempreceivedet.paytype_code = 'SAL' "

//ads_info.settransobject( itr_sqlca )

//if ( ls_sqlext <> "" ) then
//	ls_temp	= ads_info.getsqlselect()
//	ls_temp	+= ls_sqlext
//	li_ret 		= ads_info.setsqlselect( ls_temp )
//	if ( li_ret <> 1 ) then
//		return -1
//	end if
//	
//	ads_info.settransobject( itr_sqlca )
//end if
lds_insure = create n_ds
lds_insure.dataobject = "d_ins_post_keep_from_kptemp"
lds_insure.settransobject( itr_sqlca )

if ls_sqlext <> "" then
	ls_temp	= lds_insure.getsqlselect()
	ls_temp	+= ls_sqlext
	lds_insure.setsqlselect( ls_temp )
	lds_insure.settransobject( itr_sqlca )
end if

ll_rowcount = lds_insure.retrieve(  )

inv_progress.istr_progress.subprogress_max = ll_rowcount


if ( ll_rowcount < 1 ) then 
	return -1
	destroy lds_insure
	ithw_exception.text += "~nพบข้อผิดพลาดในการสร้างชุด SQL รายการประกัน"
	throw ithw_exception	
end if

for ll_row = 1 to ll_rowcount	
	inv_progress.istr_progress.subprogress_index	= ll_row
	// ตรวจสอบการสั่งหยุดทำงาน
	//yield()
	if inv_progress.of_is_stop() then
		destroy lds_insure
		return 0
	end if
	
	ls_memno		= trim( lds_insure.getitemstring( ll_index, "member_no" ) )
	ls_refmemno	= trim( lds_insure.getitemstring( ll_index, "ref_membno" ) )
	ls_instypecode = trim( lds_insure.getitemstring( ll_index, "shrlontype_code" ) )
	ls_receiptno	= 	trim( lds_insure.getitemstring( ll_index, "receipt_no" ) )
	ls_moneytypecode = trim( lds_insure.getitemstring( ll_index, "moneytype_code" ) )
	ldtm_receiptdate	= 	lds_insure.getitemdatetime( ll_index, "receipt_date" ) 
	ls_insureno		= trim( lds_insure.getitemstring( ll_index, "description" ) )
	ldc_insureamt	= lds_insure.getitemdecimal( ll_index, "item_payment" )
	li_period 		=  lds_insure.getitemNumber( ll_index, "period" ) 
	li_rcvseqno	= lds_insure.getitemnumber( ll_index, "seq_no" )
	ls_instypecode = right(ls_instypecode,2)
	ls_insgroupno	=  trim( lds_insure.getitemstring( ll_index, "insgroupdoc_no" ) )
	ldc_stkins	= lds_insure.getitemdecimal( ll_index, "INSSTK_BLANCE" )
	ldc_inpayarr	= lds_insure.getitemdecimal( ll_index, "INSPAYMENT_ARREAR" )
	li_period	= lds_insure.getitemdecimal( ll_index, "LAST_PERIOD" )
	li_laststmt	= lds_insure.getitemdecimal( ll_index, "LAST_STM_NO" )
	ll_insgroupid  =  long( lds_insure.getitemstring( ll_index, "loancontract_no" ) )
	if isnull( ll_last_stm ) then ll_last_stm =	 0
	
	if ls_memno <> ls_memprior or ls_refmemno <> ls_refprior    then
		this.of_posttomast( ls_memno, ls_recvperiod, ls_refmemno )
		ls_memprior	= ls_memno
		ls_refprior		= ls_refmemno
	end if
	
	// ผ่านรายการไป master det
	if this.of_posttomastdet( ls_memno, ls_recvperiod, ls_refmemno, li_rcvseqno, ldtm_entrydate ) <> 1 then
		li_chk	= messagebox( "ประมวลผล","พบข้อผิดพลาดในการผ่านรายการ คุณต้องการประมวลผลต่อหรือไม่~r~n"+sqlca.sqlerrtext, stopsign!, okcancel!, 2 )
		if li_chk = 2 then
			destroy lds_insure
			return -1
		end if
	end if
	
	ll_last_stm ++

	 if isnull(ldc_stkins) then  ldc_stkins = 0
	 if isnull(li_period) then  li_period = 0
	 if isnull(li_laststmt) then  li_laststmt = 0
	 if isnull(ldc_inpayarr) then  ldc_inpayarr = 0 
	 ldc_stkins += ldc_insureamt
	 li_period ++
	 li_laststmt ++
	 ls_itemtypecode = 'IPM'
	update	INSGROUPMASTER
	set		INSSTK_BLANCE	= :ldc_stkins,
				LAST_PERIOD		= :li_period,
				LAST_STM_NO		= :li_laststmt,
				rkeep_insvalue 		= 0 ,
				process_date 		= :ldtm_receiptdate,
				INSPAYMENT_ARREAR = INSPAYMENT_ARREAR - :ldc_insureamt
	where	( member_no 	= :ls_memno )  and (INSTYPE_CODE = :ls_instypecode)  and ( insgroup_id = :ll_insgroupid) using itr_sqlca ;
	if sqlca.sqlcode <> 0 then
		ithw_exception.text += "พบข้อผิดพลาด ไม่สามารถปรับปรุง master ได้~r~n"+ string( itr_sqlca.sqlcode ) + "  " + itr_sqlca.sqlerrtext
		throw ithw_exception
	end if
		
	 INSERT INTO INSGROUPSTATEMENT  
				( 		MEMBER_NO,			SEQ_NO,   						INSTYPE_CODE,   	INSITEMTYPE_CODE,   	INSPERIOD_AMT,   			INSPERIOD_PAYMENT,   
				OPERATE_DATE,   	INSGROUPSLIP_DATE	,   	ENTRY_DATE,   		ENTRY_ID,   					INSPAYMENT_ARREAR,   INSPRINCE_BALANCE,   
				REFDOC_NO,   		COOPBRANCH_ID,    	      MONEYTYPE_CODE ,		insgroupdoc_no , insgroup_id )  
	 VALUES 
			( 		:ls_memno,              	:li_laststmt,   			   	        :ls_instypecode,         :ls_itemtypecode,   	           :li_period,   					        :ldc_insureamt,   
						:ldtm_receiptdate,       :ldtm_receiptdate,   		        :ldtm_entrydate,          :ls_entryid,  			           0,   									  :ldc_stkins,   
						:ls_receiptno,         		:ls_branchid,   				        'TRN',			:ls_insgroupno, :ll_insgroupid )   using itr_sqlca  ;
	 if sqlca.sqlcode <> 0 then
			ithw_exception.text += "พบข้อผิดพลาด ไม่สามารถเพิ่มรายการstatement~r~n"+ string( itr_sqlca.sqlcode ) + "  " + itr_sqlca.sqlerrtext
			throw ithw_exception
	end if
		// บันทึกการผ่านรายการ
		update	kptempreceivedet
		set		posting_status	= 1,
				posting_date	= :ldtm_entrydate
		where	( kptempreceivedet.member_no	= :ls_memno ) and
				( kptempreceivedet.recv_period	= :ls_recvperiod ) and
				( kptempreceivedet.ref_membno	= :ls_refmemno ) and
				( kptempreceivedet.seq_no		= :li_rcvseqno )   using itr_sqlca  ;
		if sqlca.sqlcode <> 0 then
			ithw_exception.text += "พบข้อผิดพลาด ขณะ Clear ข้อมูลเรียกเก็บ~r~n"+ string( itr_sqlca.sqlcode ) + "  " + itr_sqlca.sqlerrtext
			throw ithw_exception
		end if
		ls_memprior =  ls_memno 
		ls_refprior  =  ls_refmemno
next
commit using itr_sqlca;
destroy lds_insure

return 1
end function

on n_cst_insurance_keeping_process.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_insurance_keeping_process.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ithw_exception = create Exception
end event

event destructor;if isvalid( ithw_exception ) then destroy ithw_exception
if isvalid( inv_progress ) then destroy inv_progress
end event

