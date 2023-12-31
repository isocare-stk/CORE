$PBExportHeader$n_cst_calendarservice.sru
forward
global type n_cst_calendarservice from nonvisualobject
end type
end forward

global type n_cst_calendarservice from nonvisualobject
end type
global n_cst_calendarservice n_cst_calendarservice

type variables
n_ds				ids_calendarinfo
transaction		itr_sqlca
Exception		ithw_exception
end variables

forward prototypes
public function integer of_getdaysinyear (integer ai_year) throws Exception
public function integer of_getcalendarinfo (integer ai_year, integer ai_month, ref integer ai_firstworkday, ref integer ai_lastworkday, ref integer ai_dayofmonth, ref string as_daysetting) throws Exception
public function integer of_getdayattrib (datetime adtm_date, ref character ac_dayattrib) throws Exception
public function datetime of_getfirstdayofmonth (datetime adtm_date) throws Exception
public function datetime of_getlastdayofyear (datetime adtm_date) throws Exception
public function integer of_getnextworkday (datetime adtm_fromdate, ref datetime adtm_nextworkdate) throws Exception
public function datetime of_getpostingdate (datetime adtm_current) throws Exception
public function datetime of_getpostingdate (integer ai_year, integer ai_month) throws Exception
public function integer of_getprevworkday (datetime adtm_fromdate, ref datetime adtm_prevdate) throws Exception
public function datetime of_getprocessdate (datetime adtm_current) throws Exception
public function datetime of_getprocessdate (integer ai_year, integer ai_month) throws Exception
public function boolean of_isworkingdate (datetime adtm_checkdate) throws Exception
public function datetime of_relativeworkdate (datetime adtm_currentdate, integer ai_increase) throws Exception
public function datetime of_relativeworkdate (datetime adtm_currentdate, integer ai_increase, boolean ab_chkcurrentholiday) throws Exception
public function integer of_getaccountdate (integer ai_year, ref datetime adtm_start, ref datetime adtm_end) throws Exception
public function integer of_getaccountyear (datetime adtm_chkdate) throws Exception
public function integer of_initservice (n_cst_dbconnectservice atr_dbtrans)
public function datetime of_getfirstdayofyear (datetime adtm_chkdate) throws Exception
public function datetime of_getfirstdayofyear (integer ai_accyear) throws Exception
public function datetime of_getlastdayofyear (integer ai_year) throws Exception
public function datetime of_getnextprocessdate (datetime adtm_current) throws Exception
public function datetime of_getlastdayofmonth (datetime adtm_date) throws Exception
public function datetime of_getenddayofmonth (datetime adtm_date) throws Exception
end prototypes

public function integer of_getdaysinyear (integer ai_year) throws Exception;datetime	ldtm_start, ldtm_end
integer	li_dayinyear

of_getaccountdate( ai_year, ldtm_start, ldtm_end )

li_dayinyear = daysafter( date( ldtm_end ), date( ldtm_start ) ) + 1

return li_dayinyear
end function

public function integer of_getcalendarinfo (integer ai_year, integer ai_month, ref integer ai_firstworkday, ref integer ai_lastworkday, ref integer ai_dayofmonth, ref string as_daysetting) throws Exception;integer		li_row

li_row = ids_calendarinfo.find( "year = " + string( ai_year ) + " and  month = " + string( ai_month ), 1, ids_calendarinfo.rowcount() )

if li_row = 0 then
	ithw_exception.text	= "ไม่พบข้อมูลปฏิทินประจำปี ("+string( ai_year )+") เดือน ("+string( ai_month )+") กรุณาติดต่อผู้ดูแลระบบ"
	throw ithw_exception
end if

ai_firstworkday	= ids_calendarinfo.getitemnumber( li_row, "firstworkdate" )
ai_lastworkday	= ids_calendarinfo.getitemnumber( li_row, "lastworkdate" )
ai_dayofmonth	= ids_calendarinfo.getitemnumber( li_row, "daysinmonth" )
as_daysetting	= ids_calendarinfo.getitemstring( li_row, "workdays" )

return 1
end function

public function integer of_getdayattrib (datetime adtm_date, ref character ac_dayattrib) throws Exception;// สำหรับดูว่าวันที่ส่งเข้ามาเป็นวันอะไร ทำงาน/วันหยุด

integer	li_firstworkday, li_lastworkday, li_daysofmonth
char 	larrc_workingdays[]
string	ls_workingdays

integer	li_year, li_month, li_day

// Check Parameter
if date(adtm_date) = date('1900-01-01') or isnull(adtm_date) then
	ithw_exception.text	= "วันที่ที่จะตรวจสอบสถานะวัน (of_getdayattrib) มีค่าเป็น Null"
	throw ithw_exception
end if

li_year 	= year( date( adtm_date ) ) + 543
li_month	= month( date( adtm_date ) ) 
li_day		= day( date( adtm_date ) ) 

this.of_getcalendarinfo(li_year, li_month, li_firstworkday, li_lastworkday, li_daysofmonth, ls_workingdays)

larrc_workingdays[]	= ls_workingdays

ac_dayattrib	= larrc_workingdays[li_day]

choose case upper(ac_dayattrib)
	case "W", "H", "S"
	case else
		return -1
end choose

return 1
end function

public function datetime of_getfirstdayofmonth (datetime adtm_date) throws Exception;integer		li_row, li_year, li_month, li_day
date		ld_date
datetime	ldtm_firstdate

setnull(ldtm_firstdate)

ld_date		= date(adtm_date)
li_year		= year(ld_date)
li_month		= month(ld_date)

li_row		= ids_calendarinfo.find( "year = " + string( li_year + 543) + " and  month = " + string( li_month ), 1, ids_calendarinfo.rowcount( ) )

if li_row <= 0 then 
	ithw_exception.text	= "ไม่พบข้อมูลปฏิทินประจำปี ("+string( li_year )+") เดือน ("+string( li_month )+") กรุณาติดต่อผู้ดูแลระบบ"
	throw ithw_exception
end if

li_day		= ids_calendarinfo.getitemnumber(li_row, "firstworkdate")

ldtm_firstdate	= datetime(date(li_year, li_month, li_day))

return ldtm_firstdate
end function

public function datetime of_getlastdayofyear (datetime adtm_date) throws Exception;integer	li_year

li_year		= this.of_getaccountyear( adtm_date )

return this.of_getlastdayofyear( li_year )
end function

public function integer of_getnextworkday (datetime adtm_fromdate, ref datetime adtm_nextworkdate) throws Exception;integer	li_firstworkday, li_lastworkday, li_daysofmonth
char 	larrc_workingdays[]
string	ls_workingdays
integer	li_year, li_month, li_day

li_year 		= year( date( adtm_fromdate ) ) + 543
li_month	= month( date( adtm_fromdate ) ) 
li_day		= day( date( adtm_fromdate ) ) 

// validate
string ls_datestring
ls_datestring = string( li_year - 543 ) + "/" + string(li_month) +"/" + string( li_day )
if not isdate( ls_datestring ) then 
	return -1
end if

if of_getcalendarinfo( li_year, li_month, li_firstworkday, li_lastworkday, li_daysofmonth, ls_workingdays ) <> 1 then 
	return -1
end if

if li_day >= li_lastworkday then 
	li_month ++
	if li_month = 13 then
		li_year ++
		li_month = 1
	end if
	if of_getcalendarinfo( li_year, li_month, li_firstworkday, li_lastworkday, li_daysofmonth, ls_workingdays ) <> 1 then 
		return -1
	end if
	li_day = li_firstworkday
	adtm_nextworkdate = datetime( date( li_year - 543, li_month, li_day ) )
	return 1
end if

larrc_workingdays[] = ls_workingdays

do while li_day < li_lastworkday
	li_day ++
	if larrc_workingdays[ li_day ] = "W" then
		exit
	end if
loop

adtm_nextworkdate = datetime( date( li_year - 543, li_month, li_day ) )

return 1
end function

public function datetime of_getpostingdate (datetime adtm_current) throws Exception;integer		li_year, li_month
datetime		ldtm_postdate

li_year		= year( date( adtm_current ) ) + 543
li_month		= month( date( adtm_current ) )

ldtm_postdate	= this.of_getpostingdate( li_year, li_month )

if adtm_current > ldtm_postdate then
	li_month		= li_month + 1
	if li_month > 12 then
		li_month		= 1
		li_year		= li_year + 1
	end if
	ldtm_postdate	= this.of_getpostingdate( li_year, li_month )
end if

return ldtm_postdate
end function

public function datetime of_getpostingdate (integer ai_year, integer ai_month) throws Exception;integer		li_row, li_day
datetime	ldtm_postdate

setnull( ldtm_postdate )

li_row	= ids_calendarinfo.find( "year = " + string( ai_year ) + " and  month = " + string( ai_month ), 1, ids_calendarinfo.rowcount() )

if li_row <= 0 then return ldtm_postdate

li_day	= ids_calendarinfo.getitemnumber( li_row, "postingdate" )

ldtm_postdate	= datetime( date( ai_year - 543 , ai_month, li_day ) )

return ldtm_postdate

end function

public function integer of_getprevworkday (datetime adtm_fromdate, ref datetime adtm_prevdate) throws Exception;

int		li_firstworkday, li_lastworkday, li_daysofmonth
char 	larrc_workingdays[]
string	ls_workingdays

integer	li_year, li_month, li_day

li_year 	= year( date( adtm_fromdate ) ) + 543
li_month	= month( date( adtm_fromdate ) ) 
li_day		= day( date( adtm_fromdate ) ) 

// validate
string ls_datestring

ls_datestring = string( li_year - 543 ) + "/" + string(li_month) +"/" + string( li_day )
if not isdate( ls_datestring ) then 
	return -1
end if

if of_getcalendarinfo( li_year, li_month, li_firstworkday, li_lastworkday, li_daysofmonth, ls_workingdays ) <> 1 then 
	return -1
end if
if li_day <= li_firstworkday then 
	li_month --
	if li_month = 0 then
		li_year --
		li_month = 12
	end if
	if of_getcalendarinfo( li_year, li_month, li_firstworkday, li_lastworkday, li_daysofmonth, ls_workingdays ) <> 1 then 
		return -1
	end if
	li_day = li_lastworkday
	adtm_prevdate = datetime( date( li_year - 543, li_month, li_day ) )
	return 1
end if

larrc_workingdays[] = ls_workingdays

do while li_day >li_firstworkday
	li_day --
	if larrc_workingdays[ li_day ] = "W" then
		exit
	end if
loop

adtm_prevdate = datetime( date( li_year - 543, li_month, li_day ) )

return 1
end function

public function datetime of_getprocessdate (datetime adtm_current) throws Exception;integer		li_year, li_month
datetime		ldtm_procdate, ldtm_postdate

li_year		= year( date( adtm_current ) ) + 543
li_month		= month( date( adtm_current ) )

ldtm_procdate	= this.of_getprocessdate( li_year, li_month )
ldtm_postdate	= this.of_getpostingdate( li_year, li_month )

if adtm_current > ldtm_postdate then
	li_month		= li_month + 1
	if li_month > 12 then
		li_month		= 1
		li_year		= li_year + 1
	end if
	ldtm_procdate	= this.of_getprocessdate( li_year, li_month )
end if

return ldtm_procdate
end function

public function datetime of_getprocessdate (integer ai_year, integer ai_month) throws Exception;integer	li_row, li_day
datetime	ldtm_procdate

setnull( ldtm_procdate )

li_row	= ids_calendarinfo.find( "year = " + string( ai_year ) + " and  month = " + string( ai_month ), 1, ids_calendarinfo.rowcount() )

if li_row <= 0 then
	ithw_exception.text	= "ไม่พบข้อมูลปฏิทินประจำปี ("+string( ai_year )+") เดือน ("+string( ai_month )+") กรุณาติดต่อผู้ดูแลระบบ"
	throw ithw_exception
end if

li_day	= ids_calendarinfo.getitemnumber( li_row, "processdate" )

if li_day > 15 then
	ai_month		= ai_month - 1
	
	if ai_month = 0 then
		ai_month		= 12
		ai_year		= ai_year - 1
	end if
end if

ldtm_procdate	= datetime( date( ai_year - 543, ai_month, li_day ) )

return ldtm_procdate
end function

public function boolean of_isworkingdate (datetime adtm_checkdate) throws Exception;char	lch_daytype

this.of_getdayattrib( adtm_checkdate, lch_daytype )

if lch_daytype = "W" then
	return true
end if

return false
end function

public function datetime of_relativeworkdate (datetime adtm_currentdate, integer ai_increase) throws Exception;return this.of_relativeworkdate( adtm_currentdate, ai_increase, false )
end function

public function datetime of_relativeworkdate (datetime adtm_currentdate, integer ai_increase, boolean ab_chkcurrentholiday) throws Exception;string		ls_workingdays
char 		lch_dayattrib, larrc_workingdays[]
integer		li_firstworkday, li_lastworkday, li_daysofmonth
integer		li_year, li_month, li_day, li_incnum, li_step
datetime	ldtm_fromdate, ldtm_return

li_year 		= year( date( adtm_currentdate ) ) + 543
li_month	= month( date( adtm_currentdate ) ) 
li_day		= day( date( adtm_currentdate ) ) 

setnull( ldtm_return )

// validate
if string( adtm_currentdate, "yyyymmdd" ) = "19000101" then 
	return ldtm_return
end if

if this.of_getdayattrib( adtm_currentdate, lch_dayattrib ) <> 1 then
	return ldtm_return
end if

// ตรวจว่ามีการขยับวันเนื่องจากวันหยุดหรือเปล่า
if ab_chkcurrentholiday and lch_dayattrib <> "W" and ai_increase <> 0 then
	if ai_increase < 0 then
		this.of_getprevworkday( adtm_currentdate, ldtm_fromdate )
	elseif ai_increase > 0 then
		this.of_getnextworkday( adtm_currentdate, ldtm_fromdate )
	end if
else
	ldtm_fromdate	= adtm_currentdate
end if

li_incnum	= 0
li_step		= ( ai_increase / abs( ai_increase ) )

do while li_incnum <> ai_increase
	// ตรวจไล่ไปทีละวันของปฏิทิน
	ldtm_fromdate		= datetime( relativedate( date( ldtm_fromdate ), li_step ) )
	
	if this.of_getdayattrib( ldtm_fromdate, lch_dayattrib ) <> 1 then
		return ldtm_return
	end if
	
	if lch_dayattrib = "W" then
		li_incnum	= li_incnum + li_step
	end if
loop

ldtm_return		= ldtm_fromdate

return ldtm_return
end function

public function integer of_getaccountdate (integer ai_year, ref datetime adtm_start, ref datetime adtm_end) throws Exception;select accstart_date, accend_date
into	:adtm_start, :adtm_end
from 	cmaccountyear
where	( account_year = :ai_year )
using	itr_sqlca;

if ( itr_sqlca.sqlcode <> 0 ) then
	ithw_exception.text	= "ไม่พบข้อมูลปีบัญชีที่ระบุมา ("+string( ai_year )+")"
	throw ithw_exception
end if

return 1
end function

public function integer of_getaccountyear (datetime adtm_chkdate) throws Exception;integer	li_year

select	account_year
into	:li_year
from	cmaccountyear
where	( accstart_date <= :adtm_chkdate )  and
			( accend_date >= :adtm_chkdate )
using	itr_sqlca ;
		
if sqlca.sqlcode = 0 then
	ithw_exception.text	= "วันที่ที่ระบุมา ("+string( adtm_chkdate, "dd/mm/" )+string( year( date( adtm_chkdate ) )+543 )+") ไม่พบข้อมูลปีบัญชี"
	throw ithw_exception
end if

return li_year
end function

public function integer of_initservice (n_cst_dbconnectservice atr_dbtrans);itr_sqlca = atr_dbtrans.itr_dbconnection

ids_calendarinfo = create n_ds
ids_calendarinfo.dataobject = "d_calendarsrv_info_workdate"
ids_calendarinfo.settransobject( itr_sqlca )
ids_calendarinfo.retrieve()

return 1
end function

public function datetime of_getfirstdayofyear (datetime adtm_chkdate) throws Exception;integer	li_year

li_year		= this.of_getaccountyear( adtm_chkdate )

return this.of_getfirstdayofyear( li_year )
end function

public function datetime of_getfirstdayofyear (integer ai_accyear) throws Exception;integer	li_row, li_year, li_month, li_day
datetime	ldtm_startacc, ldtm_endacc, ldtm_firstdate

of_getaccountdate( ai_accyear, ldtm_startacc, ldtm_endacc )

li_year		= year( date( ldtm_startacc ) )
li_month		= month( date( ldtm_startacc ) )

li_row			= ids_calendarinfo.find( "year = " + string( li_year + 543) + " and  month = " + string( li_month ), 1, ids_calendarinfo.rowcount( ) )

if li_row <= 0 then
	ithw_exception.text	= "ไม่พบข้อมูลปฏิทินประจำปี ("+string( li_year )+") เดือน ("+string( li_month )+") กรุณาติดต่อผู้ดูแลระบบ"
	throw ithw_exception
end if

li_day			= ids_calendarinfo.getitemnumber(li_row, "firstworkdate")

ldtm_firstdate	= datetime(date(li_year, li_month, li_day))

return ldtm_firstdate
end function

public function datetime of_getlastdayofyear (integer ai_year) throws Exception;integer	li_row, li_year, li_month, li_day
date		ld_date
datetime	ldtm_lastdate, ldtm_startacc, ldtm_endacc

this.of_getaccountdate( ai_year, ldtm_startacc, ldtm_endacc )

ld_date		= date( ldtm_endacc )
li_year		= year( ld_date )
li_month		= month( ld_date )

li_row		= ids_calendarinfo.find( "year = " + string( li_year + 543) + " and  month = " + string( li_month ), 1, ids_calendarinfo.rowcount( ) )

if li_row <= 0 then
	ithw_exception.text	= "ไม่พบข้อมูลปฏิทินประจำปี ("+string( li_year )+") เดือน ("+string( li_month )+") กรุณาติดต่อผู้ดูแลระบบ"
	throw ithw_exception
end if

li_day		= ids_calendarinfo.getitemnumber(li_row, "lastworkdate")

ldtm_lastdate	= datetime(date(li_year, li_month, li_day))

return ldtm_lastdate
end function

public function datetime of_getnextprocessdate (datetime adtm_current) throws Exception;integer		li_year, li_month
datetime		ldtm_procdate

li_year		= year( date( adtm_current ) ) + 543
li_month		= month( date( adtm_current ) )

ldtm_procdate	= this.of_getprocessdate( li_year, li_month )

// ถ้าวันที่ตรวจสอบเป็นวันที่ที่เกินวันประมวลผลรอบนี้ไปแล้วต้องดึงเดือนหน้ามาแทน
if adtm_current > ldtm_procdate then
	li_month ++
	if li_month > 12 then
		li_year ++
		li_month	= 1
	end if
	
	ldtm_procdate	= this.of_getprocessdate( li_year, li_month )
end if

return ldtm_procdate
end function

public function datetime of_getlastdayofmonth (datetime adtm_date) throws Exception;integer		li_row, li_year, li_month, li_day
date		ld_date
datetime	ldtm_lastdate

setnull(ldtm_lastdate)

ld_date		= date(adtm_date)
li_year		= year(ld_date)
li_month		= month(ld_date)

li_row		= ids_calendarinfo.find( "year = " + string( li_year + 543) + " and  month = " + string( li_month ), 1, ids_calendarinfo.rowcount( ) )

if li_row <= 0 then
	ithw_exception.text	= "ไม่พบข้อมูลปฏิทินประจำปี ("+string( li_year )+") เดือน ("+string( li_month )+") กรุณาติดต่อผู้ดูแลระบบ"
	throw ithw_exception
end if

li_day		= ids_calendarinfo.getitemnumber(li_row, "lastworkdate")

ldtm_lastdate	= datetime(date(li_year, li_month, li_day))

return ldtm_lastdate
end function

public function datetime of_getenddayofmonth (datetime adtm_date) throws Exception;integer		li_row, li_year, li_month, li_day
date		ld_date
datetime	ldtm_lastdate

setnull(ldtm_lastdate)

ld_date		= date(adtm_date)
li_year		= year(ld_date)
li_month		= month(ld_date)

li_row		= ids_calendarinfo.find( "year = " + string( li_year + 543) + " and  month = " + string( li_month ), 1, ids_calendarinfo.rowcount( ) )

if li_row <= 0 then
	ithw_exception.text	= "ไม่พบข้อมูลปฏิทินประจำปี ("+string( li_year )+") เดือน ("+string( li_month )+") กรุณาติดต่อผู้ดูแลระบบ"
	throw ithw_exception
end if

li_day		= ids_calendarinfo.getitemnumber(li_row, "daysinmonth")

ldtm_lastdate	= datetime(date(li_year, li_month, li_day))

return ldtm_lastdate
end function

event constructor;ithw_exception		= create Exception
end event

on n_cst_calendarservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_calendarservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;if isvalid( ithw_exception ) then destroy ithw_exception
if isvalid( ids_calendarinfo ) then destroy ids_calendarinfo

end event

