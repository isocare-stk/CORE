$PBExportHeader$n_cst_datawindowsservice.sru
$PBExportComments$สำหรับจัดการดาต้าวินโดว์
forward
global type n_cst_datawindowsservice from nonvisualobject
end type
end forward

global type n_cst_datawindowsservice from nonvisualobject
end type
global n_cst_datawindowsservice n_cst_datawindowsservice

type variables

PUBLIC:

/*สถานะการทำงาน*/
CONSTANT INTEGER STATUS_RUNNING = 8		//กำลังทำงานอยู่.
CONSTANT INTEGER STATUS_SUCCESS = 1		//ทำงานเสร็จแล้ว และเรียบร้อยดี.
CONSTANT INTEGER STATUS_FAILURE = -1		//ทำงานเสร็จแล้ว แต่ล้มเหลวไม่ประสบความสำเร็จ.
CONSTANT INTEGER STATUS_STOP = 0			//ถูกสั่งหยุดการทำงาน.

str_progress istr_progress	//สถานะและความคืบหน้าการประมวลผล.

transaction	itr_sqlca
Exception	ithw_exception

PROTECTED:

boolean ib_stop = false		//คำสั่งหยุดการทำงาน ซึ่งจะมีผลโดยตรงกับสถานะการทำงานใน progress struct.ถูกเปลี่ยนค่าด้วยฟังชั่น of_stop_process.ตรวจสอบค่าด้วยฟังชั่น of_is_stop. 

end variables

forward prototypes
public function integer of_create_dw (ref n_ds ads_data, string as_sql, string as_type) throws Exception
public function integer of_initservice (n_cst_dbconnectservice atr_dbtrans)
public function integer of_update_dw (ref n_ds ads_data, string as_table, string as_column[], string as_keycolumn[], string as_whereoption, boolean ab_kepupdateinplace) throws Exception
end prototypes

public function integer of_create_dw (ref n_ds ads_data, string as_sql, string as_type) throws Exception;/***********************************************************
<description>
	สร้าง n_ds จาก sql
</description>

<arguments>
	ads_data				N_ds			dw ที่ต้องการนำ sql เข้า
	as_sql				String			sql ที่ต้องการในการนำเข้า dw
	as_type				String			ประเภทของ dw ( Tablular , Grid ) default Tablular
</arguments> 

<return> 
	Integer	1 = success,  Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 01/02/2012 by Godji
</usage> 
***********************************************************/
string ls_errors
string ls_presentation , ls_dwsyntax

as_type		= trim( as_type )
if isnull( as_type ) or as_type = "" then as_type = "Tabular"

ls_presentation		= "style(type="+as_type+")"

ls_dwsyntax	= itr_sqlca.SyntaxFromSQL( as_sql , ls_presentation , ls_errors )

if len( ls_errors ) > 0 then
	ithw_exception.text += "Caution :> Create syntax from sql these errors: " 
	ithw_exception.text += "~r~n"+ ls_errors
	rollback using itr_sqlca ;
	throw ithw_exception	
end if

ads_data.Create( ls_dwsyntax, ls_errors)

IF Len(ls_errors) > 0 THEN

	ithw_exception.text += "Caution :> Create cause these errors: "
	ithw_exception.text += "~r~n"+ ls_errors
	rollback using itr_sqlca ;
	throw ithw_exception	

END IF

return 1
end function

public function integer of_initservice (n_cst_dbconnectservice atr_dbtrans);itr_sqlca = atr_dbtrans.itr_dbconnection

return 1
end function

public function integer of_update_dw (ref n_ds ads_data, string as_table, string as_column[], string as_keycolumn[], string as_whereoption, boolean ab_kepupdateinplace) throws Exception;string ls_mod_string , ls_column
integer li_num_cols , li_num_updateable , li_num_keys
integer li_updcol , li_keycol , li_rc
boolean lb_is_key

// Get the number of columns on the datawindow.
li_num_cols = Integer (ads_data.Describe ( "DataWindow.Column.Count" )) 

// (start new string) Set the Update Table.
ls_mod_string = "DataWindow.Table.UpdateTable='" + as_table +"' "

// Set the Update Where Option.
ls_mod_string += "DataWindow.Table.UpdateWhere=" + as_whereoption + " "

// Set the Update Key in Place flag.
If ab_kepupdateinplace THEN
	ls_mod_string += "DataWindow.Table.UpdateKeyInPlace=yes " 
Else
	ls_mod_string += "DataWindow.Table.UpdateKeyInPlace=no " 
End If

//// Get the number of UpdateColumns and Keys.
li_num_updateable = UpperBound ( as_column )
li_num_keys = UpperBound ( as_keycolumn )

for li_updcol = 1 to li_num_cols
	ls_column = ads_data.Describe ( "#" + String(li_updcol) + ".Name" )
	
	ls_mod_string += ls_column + ".Update=Yes "
	
	lb_is_key = false
	for li_keycol = 1 to li_num_keys
		if lower(ls_column) = lower( as_keycolumn[li_num_keys] ) then
			lb_is_key = true
			exit
		end if
	next
	
	if lb_is_key then
		ls_mod_string += ls_column + ".Key=Yes "
	else
		ls_mod_string += ls_column + ".Key=No "
	end if
	
next
string ls_error
ls_error = ads_data.modify ( ls_mod_string )

if ads_data.modify ( ls_mod_string ) <> "" then 
	return -2
end if

return 1
end function

on n_cst_datawindowsservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_datawindowsservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
ithw_exception = create Exception
end event

event destructor;if isvalid( ithw_exception ) then destroy ithw_exception

end event

