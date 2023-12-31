$PBExportHeader$n_cst_thailibservice.sru
$PBExportComments$Thai Library - Reading all number in thai language
forward
global type n_cst_thailibservice from nonvisualobject
end type
end forward

global type n_cst_thailibservice from nonvisualobject
end type
global n_cst_thailibservice n_cst_thailibservice

type prototypes

end prototypes

type variables

end variables

forward prototypes
public function string of_readnumber (long al_long)
public function string of_readnumber (date ad_date, boolean ab_includeday, boolean ab_includemonth, boolean ab_includeyear)
public function string of_readnumber (time at_time, boolean ab_includehour, boolean ab_includeminute, boolean ab_includesecond)
public function string of_readnumber (datetime adt_datetime, boolean ab_includeday, boolean ab_includemonth, boolean ab_includeyear, boolean ab_includehour, boolean ab_includeminute, boolean ab_includesecond)
public function string of_readnumber (decimal adc_decimal)
public function string of_readnumber (string as_number, boolean ab_posname)
public function string of_readnumber (string as_number)
public function string of_readthaibaht (string as_money)
public function string of_readthaibaht (decimal adc_money)
end prototypes

public function string of_readnumber (long al_long);
return of_readnumber( dec( al_long ) )
end function

public function string of_readnumber (date ad_date, boolean ab_includeday, boolean ab_includemonth, boolean ab_includeyear);if isnull( ad_date ) then return ""

string	ls_date
string	ls_month[ 12 ] = { "มกราคม", "กุมภาพันธ์", "มีนาคม", "เมษายน", "พฤษภาคม", "มิถุนายน", "กรกฎาคม", "สิงหาคม", "กันยายน", "ตุลาคม", "พฤศจิกายน", "ธันวาคม" }

ls_date		= ""

if ab_includeday then
	ls_date	+= "วันที่ "
end if
ls_date += string( ad_date, "dd" )+" "

if ab_includemonth then
	ls_date	+= "เดือน "
end if
ls_date += ls_month[ month( ad_date ) ] + " "

if ab_includeyear then
	ls_date	+= "พ.ศ. "
end if

ls_date += string( year( ad_date ) + 543 )

return ls_date
end function

public function string of_readnumber (time at_time, boolean ab_includehour, boolean ab_includeminute, boolean ab_includesecond);if isnull( at_time ) then return ""

string	ls_time, ls_temp

ls_time	= ""
ls_temp	= string( at_time, "hh:mm:ss" )

if ab_includehour then
	ls_time	+= mid( ls_temp, 1, 2 )+" นาฬิกา "
end if

if ab_includeminute then
	ls_time	+= mid( ls_temp, 4, 2 )+" นาที "
end if

if ab_includesecond then
	ls_time	+= mid( ls_temp, 7, 2 )+" วินาที"
end if

return 	ls_time 

end function

public function string of_readnumber (datetime adt_datetime, boolean ab_includeday, boolean ab_includemonth, boolean ab_includeyear, boolean ab_includehour, boolean ab_includeminute, boolean ab_includesecond);string		ls_date, ls_time

if isnull( adt_datetime ) then return ""

if ( not isdate( string( adt_datetime, 'yyyy-mm-dd' ) ) ) and ( not istime( string( adt_datetime, 'hh:mm:ss' ) ) ) then return ''

ls_date	= of_readnumber( date( adt_datetime ), ab_includeday, ab_includemonth, ab_includeyear )
ls_time	= of_readnumber( time( adt_datetime ), ab_includehour, ab_includeminute, ab_includesecond )

return  trim( ls_date+" "+ls_time )
end function

public function string of_readnumber (decimal adc_decimal);string ls_return, ls_number
string ls_integer, ls_fraction

ls_number = string( adc_decimal )

if pos(ls_number, "." ) > 0 then
	ls_integer	= left( ls_number, pos(ls_number, "." ) -1 )
	ls_fraction	= left( mid( ls_number, pos(ls_number, "." ) + 1 ) + "00", 2 )
	if ls_fraction = "00" then
		ls_fraction = ""
	end if
else
	ls_integer = ls_number
end if

if len( ls_integer ) > 0 then
	ls_return = of_readnumber( ls_integer )
	
	if len( ls_fraction ) = 0 then
		return ls_return
	end if
	
	ls_return	+= "จุด"
end if

if len( ls_fraction ) > 0 then 
	ls_return += of_readnumber( ls_fraction, false )
end if

return ls_return
end function

public function string of_readnumber (string as_number, boolean ab_posname);// Determine READNUMBER Option of this application
string ls_digitname[ 0 to 12 ]  = { "", "หนึ่ง", "สอง", "สาม", "สี่", "ห้า", "หก", "เจ็ด", "แปด", "เก้า", "ศูนย์" ,"เอ็ด" ,"ยี่" }
string ls_posname [ 0 to 6 ]  = { "", "สิบ", "ร้อย", "พัน", "หมื่น", "แสน", "ล้าน" }
string ls_numberword, ls_temp
char	larrc_number[]
int		li_digit_index, li_digit_max
int		li_block, li_adjust

as_number	= trim( as_number ) 

if len( as_number ) = 1 and as_number = "0" then
	return "ศูนย์"
end if

// determine how much loop(s) to be execute 6 character for each block
li_block	= ( len( as_number ) / 6 ) 
if mod( len( as_number ), 6 ) <> 0 then li_block++

do while li_block > 0
	ls_temp			= reverse( mid( reverse( as_number ), ( ( li_block -1 ) * 6 ) + 1, 6 ) )
	larrc_number	= ls_temp
	li_digit_max		= len( ls_temp )

	for li_digit_index = 1 to li_digit_max
		choose case larrc_number[ li_digit_index ] 
			case "0" 
				continue
			case "1"
				if ( li_digit_max > 1 ) and ( li_digit_index  = li_digit_max ) then
					ls_numberword			+= "เอ็ด"
				else
					if ( li_digit_max - li_digit_index ) = 1 then 
						// ถ้าเป็น 10-19 อ่านว่า สิบ ไม่ใช่ หนึ่งสิบ
						ls_numberword		+= ""
					else
						ls_numberword		+= "หนึ่ง" 
					end if
				end if
			case "2"
				if ( li_digit_max - li_digit_index ) = 1 then
					ls_numberword		+= "ยี่"
				else
					ls_numberword		+= "สอง"
				end if
				
			case "3"
				ls_numberword		+= "สาม"
				
			case "4"
				ls_numberword		+= "สี่"
				
			case "5"
				ls_numberword		+= "ห้า"
				
			case "6"
				ls_numberword		+= "หก"
				
			case "7"
				ls_numberword		+= "เจ็ด"
				
			case "8"
				ls_numberword		+= "แปด"
				
			case "9"
				ls_numberword		+= "เก้า"
		end choose
	
		// find out position name
		if ab_posname then
			ls_numberword += ls_posname[ li_digit_max - li_digit_index ]
		end if
		
	next
	
	li_block --
	
	if li_block > 0 then
		// each block that longer than 6 char mean that nermeric is more million
		if ab_posname then
			ls_numberword += "ล้าน"
		end if
	end if
loop 

return ls_numberword
end function

public function string of_readnumber (string as_number);return this.of_readnumber( as_number, true )
end function

public function string of_readthaibaht (string as_money);string ls_return, ls_number
string ls_integer, ls_fraction

ls_number = as_money

if pos(ls_number, "." ) > 0 then
	ls_integer	= left( ls_number, pos(ls_number, "." ) -1 )
	ls_fraction	= left( mid( ls_number, pos(ls_number, "." ) +1 ) + "00", 2 )
	
	if ls_fraction = "00" then
		ls_fraction = ""
	end if
else
	ls_integer = ls_number
end if

if len( ls_integer ) > 0 then
	ls_return = of_readnumber( ls_integer )
	
	if len( ls_fraction ) = 0 then
		ls_return	+= "บาทถ้วน"
	else
		if ls_return = "ศูนย์" then
			ls_return	= ""
		else
			ls_return	+= "บาท"
		end if
	end if
end if

if len( ls_fraction ) > 0 then 
	ls_return += of_readnumber( ls_fraction )
	ls_return += "สตางค์"
end if

return ls_return
end function

public function string of_readthaibaht (decimal adc_money);string		ls_moneytext, ls_moneyamt

ls_moneyamt	= string( adc_money, "0.00" )

ls_moneytext	= this.of_readthaibaht( ls_moneyamt )

return ls_moneytext
end function

on n_cst_thailibservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_thailibservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

