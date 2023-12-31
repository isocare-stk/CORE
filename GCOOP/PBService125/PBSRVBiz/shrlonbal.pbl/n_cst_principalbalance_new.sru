$PBExportHeader$n_cst_principalbalance_new.sru
forward
global type n_cst_principalbalance_new from n_cst_base
end type
end forward

global type n_cst_principalbalance_new from n_cst_base
event type integer ue_processprepare ( )
event ue_processend ( )
event ue_process ( ) throws Exception
end type
global n_cst_principalbalance_new n_cst_principalbalance_new

type variables
Protected:

n_cst_progresscontrol inv_progress
Datetime idtm_operate
Datetime idtm_startyear

/* dataobject สำหรับดึงข้อมูลจาก statement */
String is_stm_dwshare = "d_shrlonbalance_share"
String is_stm_dwloan = "d_shrlonbalance_loan"

/* dataobject สำหรับดึงข้อมูลจาก master */
String is_mas_dwshare = "d_shrlonbalance_share_master"
String is_mas_dwloan = "d_shrlonbalance_loan_master"

/* ตัวเลือกข้อมูลว่าให้เอาจาก statement หรือว่า master, true=statement, false=master */
Boolean ib_usestatement = true

end variables

forward prototypes
public subroutine of_setprogress (ref n_cst_progresscontrol anv_progress)
public subroutine of_getprogress (ref n_cst_progresscontrol anv_progress)
public function integer of_settrans (n_cst_dbconnectservice anv_connected) throws Exception
public subroutine of_setoperatedate (datetime adtm_operate)
public subroutine of_setusestatement (boolean ab_usestatement)
public function long of_count (datetime adtm_operatedate)
public subroutine of_start () throws Exception
end prototypes

event type integer ue_processprepare();//อนุญาติให้ทำงานได้เฉพาะตอนที่มี progress แล้วเท่านั้น.(ไม่งั้น process จะทำงานครึ่งๆกลางๆและหยุดกลางคันอยู่ดีนั่นแหละ)
if( isvalid( inv_progress ) )then
	
	inv_progress.istr_progress.progress_text = "เริ่มต้นการประมวลผลหุ้นหนี้คงเหลือ"
	inv_progress.istr_progress.progress_max = 4
	inv_progress.istr_progress.progress_index = 0
	inv_progress.istr_progress.subprogress_text = "preparing..."
	inv_progress.istr_progress.subprogress_max = 100
	inv_progress.istr_progress.subprogress_index = 0
	yield();
	
	//วันเริ่มต้นปี.
	select accstart_date
	into :idtm_startyear
	from cmaccountyear
	where accstart_date <= :idtm_operate
	and accend_date >= :idtm_operate
	using itr_transaction;
	if( itr_transaction.sqlcode <> 0 or isnull(idtm_startyear) )then
		idtm_startyear = datetime( date( year(date(idtm_operate)), 1, 1 ) )
	end if
	
	return 1
end if
return -1

end event

event ue_processend();//เมื่อการประมวลผลสิ้นสุด ทั้งที่สำเร็จและไม่สำเร็จ(ตรวจสอบสถาน Process เอาเอง)

end event

event ue_process();string		ls_dwobject, ls_baltype, ls_memno, ls_memprior, ls_contno, ls_lngroup, ls_lntemp
string		ls_insert, ls_update, ls_baldate, ls_values, ls_where, ls_sql, ls_statusdesc,ls_coopid
integer	li_period, li_insureflag, li_trnrcvflag, li_contlaw, li_paystatus
long		ll_index, ll_count
integer	li_rowmem, li_rowshr, li_rowemer, li_rownorm, li_rowspec, li_rowtemp
dec{2}	ldc_balamt, ldc_intacc
datastore	lds_baldata
Exception	lthw_error

lthw_error	= create Exception
ls_coopid ='001001'

inv_progress.istr_progress.progress_text		= "ประมวลผลหุ้น-หนี้คงเหลือ"
inv_progress.istr_progress.progress_max		= 2
inv_progress.istr_progress.status					= 8

ls_baldate	= string( idtm_operate, "yyyymmdd" )
ls_insert		= " insert into cmshrlonbalanceday ( coop_id,balance_date, member_no, cloanint_amt, seq_no"
ls_update	= " update cmshrlonbalanceday set "

// ลบข้อมูลเก่าก่อน
inv_progress.istr_progress.subprogress_text	= "กำลังลบข้อมูลรายงานหุ้นหนี้คงเหลือเดิม..."
inv_progress.istr_progress.progress_index		= 1

delete from cmshrlonbalanceday
where	balance_date = :idtm_operate and
			coop_id =:ls_coopid
using		itr_transaction ;

//ใช้ข้อมูลจาก statement หรือว่า master.
if ib_usestatement then
	ls_dwobject		= "d_sl_shlnbal_info_balstatement"
else
	ls_dwobject		= "d_sl_shlnbal_info_balmaster"
end if

// ดึงข้อมูลหุ้น-หนี้คงเหลือ
inv_progress.istr_progress.subprogress_text	= "กำลังดึงข้อมูลหุ้นหนี้คงเหลือ..."

lds_baldata	= create datastore
lds_baldata.dataobject	= ls_dwobject
lds_baldata.settransobject( itr_transaction )

ll_count		= lds_baldata.retrieve( ls_coopid,idtm_operate )

inv_progress.istr_progress.progress_index		= 2
inv_progress.istr_progress.subprogress_max	= ll_count

for ll_index = 1 to ll_count
	
	yield()
	if inv_progress.of_is_stop() then
		destroy lds_baldata
		rollback using itr_transaction ;
		return
	end if
	
	ls_baltype		= lds_baldata.getitemstring( ll_index, "bal_type" )
	ls_memno		= lds_baldata.getitemstring( ll_index, "member_no" )
	ls_contno		= lds_baldata.getitemstring( ll_index, "loancontract_no" )
	ls_lngroup		= lds_baldata.getitemstring( ll_index, "lngroup_code" )
	li_period			= lds_baldata.getitemnumber( ll_index, "shln_period" )
	ldc_balamt		= lds_baldata.getitemdecimal( ll_index, "shln_balance" )
	ldc_intacc		= lds_baldata.getitemdecimal( ll_index, "accum_interest" )
	
	li_insureflag		= lds_baldata.getitemnumber( ll_index, "insurecoll_flag" )
	li_trnrcvflag		= lds_baldata.getitemnumber( ll_index, "transfer_status" )
	li_contlaw		= lds_baldata.getitemnumber( ll_index, "contlaw_status" )
	li_paystatus		= lds_baldata.getitemnumber( ll_index, "payment_status" )

	if ls_memno <> ls_memprior then
		ls_memprior	= ls_memno
		li_rowmem		= 0
		li_rowshr			= 0
		li_rowemer		= 0
		li_rownorm		= 0
		li_rowspec		= 0
	end if
	
	if li_rowmem > 0 then
		ldc_intacc		= 0
	end if
	
	ls_statusdesc	= ""
	
	ls_values		= " values ( '"+ls_coopid+"',to_date('"+ls_baldate+"', 'yyyymmdd'), '"+ls_memno+"', "+string( ldc_intacc )
	ls_where		= " where ( coop_id = '"+ls_coopid+"' ) and ( balance_date = to_date( '"+ls_baldate+"', 'yyyymmdd' ) ) and ( member_no = '"+ls_memno+"' ) and ( seq_no = "

	choose case ls_baltype
		case "SHR"
			if li_paystatus < 0 then
				ls_statusdesc	= ls_statusdesc + "S"
			end if
			
			li_rowshr ++
			if li_rowshr > li_rowmem then
				li_rowmem ++
				ls_sql	= ls_insert + " , share_amt, share_status ) "+ls_values+" ,"+string(li_rowmem)+", "+string(ldc_balamt)+", '"+ls_statusdesc+"' )"
			else
				ls_sql	= ls_update + " share_amt = "+string( ldc_balamt )+" , share_status = '"+ls_statusdesc+"' "+ls_where+string(li_rowshr)+" )"
			end if
		case "LON"
			// สถานะต่างๆของสัญญา
			if li_paystatus < 0 then
				ls_statusdesc	= ls_statusdesc + "S"
			end if

			if li_insureflag = 1 then
				ls_statusdesc	= ls_statusdesc + "I"
			end if
		
			if li_trnrcvflag = 1 then
				ls_statusdesc	= ls_statusdesc + "R"
			end if
			
			if li_contlaw = 3 then
				ls_statusdesc	= ls_statusdesc + "C"
			elseif li_contlaw = 4 then
				ls_statusdesc	= ls_statusdesc + "J"
			end if
			
			choose case ls_lngroup
				case "01"
					li_rowemer ++
					li_rowtemp		= li_rowemer
					ls_lntemp		= "E"
				case "02"
					li_rownorm ++
					li_rowtemp		= li_rownorm
					ls_lntemp		= "C"
				case "03"
					li_rowspec ++
					li_rowtemp		= li_rowspec
					ls_lntemp		= "S"
			end choose
			
			if li_rowtemp > li_rowmem then
				li_rowmem ++
				ls_sql	= ls_insert + ", "+ls_lntemp+"loancontract_no, "+ls_lntemp+"loanbalance_amt, "+ls_lntemp+"loan_status, "+ls_lntemp+"loan_contlaw ) "+ &
							ls_values + " ,"+string(li_rowmem)+", '"+ls_contno+"', "+string( ldc_balamt)+", '"+ls_statusdesc+"', "+string( li_contlaw )+" )"
			else
				ls_sql	= ls_update + ls_lntemp+"loancontract_no = '"+ls_contno+"', "+ls_lntemp+"loanbalance_amt = "+string( ldc_balamt )+", "+ls_lntemp+"loan_status = '"+ls_statusdesc+"', "+ls_lntemp+"loan_contlaw = "+string( li_contlaw )+ &
							ls_where + string(li_rowtemp)+" )"
			end if
	end choose
	
	inv_progress.istr_progress.subprogress_index	= ll_index
	inv_progress.istr_progress.subprogress_text	= "ทะเบียน "+ls_memno+" รายการ "+ls_contno+" คงเหลือ "+string( ldc_balamt, "#,##0.00" )
	
	execute immediate :ls_sql using itr_transaction ;
	
	if itr_transaction.sqlcode <> 0 then
		lthw_error.text	= "ไม่สามารถบันทึกข้อมูลหุ้นหนี้คงเหลือ ทะเบียน "+ls_memno+ "~n"+itr_transaction.sqlerrtext
		rollback using itr_transaction ;
		destroy lds_baldata
		throw lthw_error
	end if
next

// ถ้าไม่มี Error เลย
commit using itr_transaction ;

inv_progress.istr_progress.status	= 1

return
end event

public subroutine of_setprogress (ref n_cst_progresscontrol anv_progress);/***********************************************
<description>
กำหนด ProgressControl สำหรับใช้เก็บข้อมูลความคืบหน้าการทำงานภายใน object นี้.
ฟังชั่นที่มีผล: of_report_print, of_report_print_pdf, of_report_print_xml
</description>

<arguments>	
anv_progress   instance ของ n_cst_progresscontrol
</arguments>

<return>
</return>

<usage>
lnv_config.of_setprogress( inv_progress )
</usage>
************************************************/
inv_progress = anv_progress

end subroutine

public subroutine of_getprogress (ref n_cst_progresscontrol anv_progress);/***********************************************
<description>
กำหนด ProgressControl สำหรับใช้เก็บข้อมูลความคืบหน้าการทำงานภายใน object นี้.
ฟังชั่นที่มีผล: of_report_print, of_report_print_pdf, of_report_print_xml
</description>

<arguments>	
anv_progress   instance ของ n_cst_progresscontrol
</arguments>

<return>
</return>

<usage>
lnv_config.of_setprogress( inv_progress )
</usage>
************************************************/
anv_progress = inv_progress

end subroutine

public function integer of_settrans (n_cst_dbconnectservice anv_connected) throws Exception;/***********************************************
<description>
deprecated.กำหนด DBConnection สำหรับใช้เชื่อมต่อฐานข้อมูลสำหรับการทำงานภายใน PrintService นี้.
หาก Instance ของ DBConnection ที่ส่งมามี Debuglog กำหนดไว้แล้ว Debuglog นี้จะถูกกำหนดให้กับ PrintService นี้ทันที.

ฟังชั่นที่มีผล: of_report_print, of_report_print_pdf, of_report_print_xml
</description>

<arguments>	
anv_db   instance ของ n_cst_dbconnectservice
</arguments>

<return>
</return>

<usage>
lnv_config.of_settrans( inv_db.itr_dbconnect )
</usage>
************************************************/
Try
	itr_transaction = anv_connected.itr_dbconnection
	if( not isvalid( itr_transaction ) )then
		Exception thw
		thw = create Exception
		thw.setmessage( "Transaction is not valid !" )
		throw thw
	end if
Catch( Exception exception )
	Throw exception
End Try
return 1

end function

public subroutine of_setoperatedate (datetime adtm_operate);//call me first, before you call start.
idtm_operate = adtm_operate

end subroutine

public subroutine of_setusestatement (boolean ab_usestatement);//True=ให้ใช้ข้อมูลจาก statement
//False=ให้ใช้ข้อมูลจาก master
//ต้องกำหนดค่านี้ก่อนเรียกฟังชั่น of_start
ib_usestatement = ab_usestatement

end subroutine

public function long of_count (datetime adtm_operatedate);//ตรวจสอบว่ามีข้อมูลที่เคยประมวผลไว้แล้วหรือไม่ กี่รายการ สำหรับวันที่ที่ส่งมา.
if( isnull(adtm_operatedate) )then
	return 0
end if
long ll_count
select count(balance_date)
into :ll_count
from cmshrlonbalanceday
where balance_date = :adtm_operatedate
using itr_transaction;
if( itr_transaction.sqlcode<>0 )then
	/*debug*/ of_debuglog( "นับจำนวนรายการไม่สำเร็จ: date("+string(adtm_operatedate,"dd/mm/yyyy hh:mm:ss")+") "+itr_transaction.sqlerrtext )
	return 0
end if
return ll_count

end function

public subroutine of_start () throws Exception;inv_progress.istr_progress.status = inv_progress.status_running
yield();
if( event ue_processprepare() = 1 )then
	yield();
	event ue_process()
end if
if( inv_progress.istr_progress.status = inv_progress.status_running )then
	inv_progress.istr_progress.status = inv_progress.status_success
end if
yield();
event ue_processend()

end subroutine

on n_cst_principalbalance_new.create
call super::create
end on

on n_cst_principalbalance_new.destroy
call super::destroy
end on

event constructor;call super::constructor;/**
<description>
ประมวลผลหุ้นหนี้คงเหลือจาก statement (หุ้นหนี้คงเหลือรายวันย้อนหลังได้)
</description>

<usage>
n_cst_principalbalance lnv_bal
lnv_bal = create n_cst_principalbalance
lnv_bal.of_settransobject( sqlca )
lnv_bal.of_setoperatedate( idtm_operate )
lnv_bal.of_setprogress( inv_progress )
lnv_bal.of_start()
</usage>
**/
end event

