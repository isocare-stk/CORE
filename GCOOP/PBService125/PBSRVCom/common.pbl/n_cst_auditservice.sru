$PBExportHeader$n_cst_auditservice.sru
forward
global type n_cst_auditservice from nonvisualobject
end type
end forward

global type n_cst_auditservice from nonvisualobject
end type
global n_cst_auditservice n_cst_auditservice

type variables
Public:
// - Common return value constants:
constant integer 		SUCCESS = 1
constant integer 		FAILURE = -1
constant integer 		NO_ACTION = 0

// - Continue/Prevent return value constants:
constant integer 		CONTINUE_ACTION = 1
constant integer 		PREVENT_ACTION = 0

constant int STATUS_PENDING		= 8	// รออนุมัติ (สารพัด)
constant int STATUS_APPROVE		= 1	// อนุมัติ 
constant int STATUS_CLOSE		= -1 	// สถานะปิด
constant int STATUS_CANCEL		= -9 	// สถานะปิด

constant	integer	TYPE_STOP 		= 1
constant	integer	TYPE_CONTINUE	= 2
constant	integer	TYPE_INCREASE	= 3
constant	integer	 TYPE_DECREASE	= 4

transaction		itr_sqlca
Exception		ithw_exception

string		is_keycolumn[], is_keytype[], is_keydesc[]
string		is_auditjob
long		il_auditno
string		is_entryid
datetime	idtm_entrydate

n_cst_dwxmlieservice			inv_dwxmliesrv

end variables

forward prototypes
private function integer of_setsrvdwxmlie (boolean ab_switch)
public function integer of_initservice (n_cst_dbconnectservice anv_dbtrans) throws Exception
public function long of_getnextauditno ()
private function string of_cnvtostring (any aa_data, string as_datatype)
private function string of_cnvtostring (any aa_data, string as_datatype, string as_format)
public function integer of_savelog (string as_xmlbefore, string as_xmlafter, long al_auditno, string as_auditjob, string as_entryid) throws Exception
private function integer of_postedit (n_ds ads_before, n_ds ads_after, long al_rowbf, long al_rowaf, string as_keyvalue[]) throws Exception
private function integer of_postdelete (n_ds ads_before, long al_rowbf, string as_keyvalue[]) throws Exception
private function integer of_postadd (n_ds ads_after, long al_rowaf, string as_keyvalue[]) throws Exception
private function string of_genkeyfindsyntax (string as_keyvalue[])
private function string of_genkeyvalue (string as_keyvalue[])
private function string of_genkeyvaluedesc (string as_keyvalue[])
private function string of_getcheckboxvalue (n_ds ads_requestor, string as_colname, string as_value)
private function string of_getitemvaluedesc (n_ds ads_requestor, long al_row, string as_column) throws Exception
private function string of_getitemvaluefromsql (n_ds ads_requestor, long al_row, string as_sqlsyntax) throws Exception
private function integer of_getkeyvalue (n_ds ads_requestor, long al_row, ref string as_keyvalue[])
private function string of_gettagdesc (string as_tagsyntax, string as_tagfind) throws Exception
private function integer of_initkeycolumn (n_ds ads_requestor) throws Exception
private function boolean of_isvalidgrp (string as_grpcol[], string as_grpcheck)
end prototypes

private function integer of_setsrvdwxmlie (boolean ab_switch);// Check argument
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

public function integer of_initservice (n_cst_dbconnectservice anv_dbtrans) throws Exception;/***********************************************************
<description>
	ใช้สำหรับ Intial service
</description>

<arguments>  
	atr_dbtrans			n_cst_dbconnectservice	รายละเอียดการเชื่อมต่อฐานข้อมูล
</arguments> 

<return> 
	1						Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	เรียกใช้ครั้งเดียว และต้องเรียกใช้เป็นฟังก์ชั่นแรกหลังจาก create instance
	ก่อนที่จะเรียกใช้ฟังก์ชั่นอื่น ๆ
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 28/9/2010 by MiT
</usage> 
***********************************************************/

itr_sqlca = anv_dbtrans.itr_dbconnection

this.of_setsrvdwxmlie( true )

return 1
end function

public function long of_getnextauditno ();long		ll_auditno

select	max( audit_no )
into	:ll_auditno
from	cmaudithistory
using	itr_sqlca ;

if isnull( ll_auditno ) then ll_auditno = 0

ll_auditno ++

return ll_auditno
end function

private function string of_cnvtostring (any aa_data, string as_datatype);return this.of_cnvtostring( aa_data, as_datatype, "" )

end function

private function string of_cnvtostring (any aa_data, string as_datatype, string as_format);string		ls_kydata

if isnull( as_format ) then as_format = ""

as_format		= trim( as_format )

choose case lower( left( as_datatype, 5 ) )
	case "char(", "char"
		if as_format = "" then
			ls_kydata		= string( aa_data )
		else
			ls_kydata		= string( aa_data, as_format )
		end if
		
	case "date"
		if as_format = "" then
			ls_kydata		= string( date( aa_data ), "dd/mm/yyyy" )
		else
			ls_kydata		= string( date( aa_data ), as_format )
		end if
		
	case "datet"
		if as_format = "" then
			ls_kydata		= string( datetime( aa_data ), "dd/mm/yyyy" )
		else
			ls_kydata		=string( datetime( aa_data ), as_format )
		end if
		
	case "decim", "numbe", "long", "ulong", "real", "int"
		if as_format = "" then
			ls_kydata		= string( aa_data )
		else
			ls_kydata		= string( aa_data, as_format )
		end if
		
	case else
		if as_format = "" then
			ls_kydata		= string( aa_data )
		else
			ls_kydata		= string( aa_data, as_format )
		end if
		
end choose

return ls_kydata

end function

public function integer of_savelog (string as_xmlbefore, string as_xmlafter, long al_auditno, string as_auditjob, string as_entryid) throws Exception;string		ls_dataobject, ls_find, ls_keyvalue[]
long		ll_row, ll_countbf, ll_countaf, ll_index, ll_findaf
integer	li_colcount, li_keymax, li_keyindex
n_ds		lds_before, lds_after

is_entryid		= as_entryid
idtm_entrydate	= datetime( today(), now() )

// ชื่อ Dataobject
ls_dataobject	= inv_dwxmliesrv.of_getdataobject( as_xmlbefore )

// Create DS โดยใช้ Object ตัวเดียวกัน
lds_before	= create n_ds
lds_before.dataobject		= ls_dataobject

lds_after		= create n_ds
lds_after.dataobject		= ls_dataobject

// นำเข้าข้อมูล
ll_countbf	= inv_dwxmliesrv.of_xmlimport( lds_before, as_xmlbefore )
ll_countaf	= inv_dwxmliesrv.of_xmlimport( lds_after, as_xmlafter )

if ll_countbf <= 0 and ll_countaf <= 0 then
	return 1
end if

// Init ว่า DW นี้มี Key อะไรบ้าง
this.of_initkeycolumn( lds_before )

il_auditno	= al_auditno
is_auditjob	= as_auditjob

// ตรวจสอบต้นทางก่อนว่าแก้ไขหรือลบทิ้ง
for ll_index = 1 to ll_countbf
	this.of_getkeyvalue( lds_before, ll_index, ls_keyvalue	)
	
	ls_find	= this.of_genkeyfindsyntax( ls_keyvalue )
	
	ll_findaf	= lds_after.find( ls_find, 1, lds_after.rowcount() )
	
	try
		// ถ้าเจอที่ปลายทางแสดงว่าแค่แก้ไข ถ้าไม่เจอเป็นการลบทิ้ง #บันทึกลบ
		if ll_findaf > 0 then
			this.of_postedit( lds_before, lds_after, ll_index, ll_findaf, ls_keyvalue )
		else
			this.of_postdelete( lds_before, ll_index, ls_keyvalue )			
		end if
	catch( Exception lthw_error )
		rollback using itr_sqlca ;
		throw lthw_error
	end try
next

// ตรวจสอบปลายทางว่ามีการเพิ่มมาหรือเปล่า
for ll_index = 1 to ll_countaf
	this.of_getkeyvalue( lds_after, ll_index, ls_keyvalue	)
	
	ls_find	= this.of_genkeyfindsyntax( ls_keyvalue )
	
	ll_findaf	= lds_before.find( ls_find, 1, lds_before.rowcount() )
	
	try
		// ถ้าไม่เจอที่ต้นทางแสดงว่าเป็นการเพิ่มมา #บันทึกเพิ่ม
		if ll_findaf <= 0 then
			this.of_postadd( lds_after, ll_index, ls_keyvalue )
		end if
	catch( Exception lthw_erroradd )
		rollback using itr_sqlca ;
		throw lthw_erroradd
	end try
next

commit using itr_sqlca ;

return 1
end function

private function integer of_postedit (n_ds ads_before, n_ds ads_after, long al_rowbf, long al_rowaf, string as_keyvalue[]) throws Exception;string			ls_iskey, ls_colname, ls_coltag, ls_colstyle, ls_valueold, ls_valuenew
string			ls_taggrp, ls_tagname, ls_tagsql
string			ls_auditgrp, ls_auditkeydesc, ls_auditkeyvalue, ls_auditgrpdesc, ls_grpvalueold, ls_grpvaluenew
string			ls_grpcode[], ls_grpname[]
integer		li_colno, li_colcount, li_grpidx, li_grpcount, li_pos

ls_auditkeyvalue	= this.of_genkeyvalue( as_keyvalue )
ls_auditkeydesc		= this.of_genkeyvaluedesc( as_keyvalue )

li_colcount		= integer( ads_before.object.datawindow.column.count )

for li_colno = 1 to li_colcount
	ls_iskey		= trim( string( ads_before.describe( "#"+string( li_colno )+".Key" ) ) )
	
	if lower( ls_iskey ) = "yes" then
		continue
	end if
	
	// ดึงชื่อ column กับ tag ออกมา
	ls_colname		= trim( string( ads_before.describe( "#"+string( li_colno )+".name" ) ) )
	ls_coltag			= trim( string( ads_before.describe( "#"+string( li_colno )+".tag" ) ) )
	
	// ถ้าตัวแรกมีค่าเป็น 0 แสดงว่าไม่ต้องการให้มีการบันทึกประวัติ
	if mid( ls_coltag, 1, 1 ) = "0" then
		continue
	end if
	
	// เปรียบเทียบค่าเก่าใหม่
	ls_valueold		= trim( string( ads_before.of_getitemany( al_rowbf, ls_colname ) ) )
	ls_valuenew		= trim( string( ads_after.of_getitemany( al_rowaf, ls_colname ) ) )
		
	if isnull( ls_valueold ) then ls_valueold = ""
	if isnull( ls_valuenew ) then ls_valuenew = ""
		
	// ถ้าค่าเท่ากัน ข้ามทำอันถัดไป
	if ls_valueold = ls_valuenew then
		continue
	end if
	
	// ให้กลุ่มการแก้เป็นชื่อ Column ที่แก้ไว้ก่อน
	ls_auditgrp		= ls_colname
	ls_auditgrpdesc	= ls_colname
	
	ls_taggrp			= ""
	ls_tagname		= ""
	ls_tagsql			= ""
	
	// ถ้ามีการใส่ Tag ไว้
	if ls_coltag <> "?" and not isnull( ls_coltag ) then
		// ตรวจว่า Tag นั้นเป็นมีอะไรบ้าง
		ls_taggrp		= this.of_gettagdesc( ls_coltag, "G" )
		ls_tagname	= this.of_gettagdesc( ls_coltag, "N" )
		
		// ถ้าเป็นกลุ่มข้อมูลยัดใส่ array ไว้ก่อนยังไม่ทำอะไร
		if ls_taggrp <> "" and not isnull( ls_taggrp ) then
			// ถ้ายังไม่มีกลุ่มนี้ ใส่ข้อมูลกลุ่มเอาไว้
			if not this.of_isvalidgrp( ls_grpcode, ls_taggrp ) then
				li_grpidx		= upperbound( ls_grpcode )
				li_grpidx		= li_grpidx + 1
				
				ls_grpcode[ li_grpidx ]	= ls_taggrp
				ls_grpname[ li_grpidx ]	= ls_tagname
			end if
			
			// ข้ามไปตรวจสอบ column ถัดไป
			continue
		end if
	end if

	// ถ้ามีชื่อภาษาไทยให้เอาไปใส่ table ด้วย
	if ls_tagname <> "" and not isnull( ls_tagname ) then
		ls_auditgrpdesc		= ls_tagname
	end if
	
	// ค่าเปลี่ยนแปลงที่ผ่านกระบวนการจาก Data เป็น คำอธิบายแล้ว
	ls_valueold		= this.of_getitemvaluedesc( ads_before, al_rowbf, ls_colname )
	ls_valuenew		= this.of_getitemvaluedesc( ads_after, al_rowaf, ls_colname )
	
	// เริ่มการบันทึกลง Audit log
	insert into cmaudithistory
				( audit_no, audit_job, audit_grp, audit_type, audit_key, audit_grpdesc, audit_valuekey, audit_valueold, audit_valuenew, entry_id, entry_date )
	values	( :il_auditno, :is_auditjob, :ls_auditgrp, 'E', :ls_auditkeyvalue, :ls_auditgrpdesc, :ls_auditkeydesc, :ls_valueold, :ls_valuenew, :is_entryid, :idtm_entrydate )
	using		itr_sqlca ;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "ไม่สามารถบันทึกรายการแก้ไขลง Audit Log ได้ "+itr_sqlca.sqlerrtext
		throw ithw_exception
	end if
next

li_grpcount		= upperbound( ls_grpcode )

// บันทึกพวกที่เป็นกลุ่มข้อมูล
for li_grpidx = 1 to li_grpcount
	
	ls_auditgrp			= ls_grpcode[ li_grpidx ]
	ls_auditgrpdesc		= ls_grpname[ li_grpidx ]
	
	ls_grpvalueold		= ""
	ls_grpvaluenew		= ""
	
	for li_colno = 1 to li_colcount
		ls_coltag		= trim( string( ads_before.describe( "#"+string( li_colno )+".tag" ) ) )
		
		ls_taggrp		= ""
		
		if ls_coltag <> "?" and not isnull( ls_coltag ) then
			// ตรวจว่า Tag นั้นเป็นมีอะไรบ้าง
			ls_taggrp		= this.of_gettagdesc( ls_coltag, "G" )
		end if
		
		if ls_taggrp <> ls_grpcode[ li_grpidx ] then
			continue
		end if
		
		ls_colname		= trim( string( ads_before.describe( "#"+string( li_colno )+".name" ) ) )
		
		ls_valueold		= this.of_getitemvaluedesc( ads_before, al_rowbf, ls_colname )
		ls_valuenew		= this.of_getitemvaluedesc( ads_after, al_rowaf, ls_colname )
		
		ls_grpvalueold	= ls_grpvalueold +"  "+ ls_valueold
		ls_grpvaluenew	= ls_grpvaluenew +"  "+ ls_valuenew
	next
	
	ls_grpvalueold		= trim( ls_grpvalueold )
	ls_grpvaluenew		= trim( ls_grpvaluenew )

	// เริ่มการบันทึกลง Audit log
	insert into cmaudithistory
				( audit_no, audit_job, audit_grp, audit_type, audit_key, audit_grpdesc, audit_valuekey, audit_valueold, audit_valuenew, entry_id, entry_date )
	values	( :il_auditno, :is_auditjob, :ls_auditgrp, 'E', :ls_auditkeyvalue, :ls_auditgrpdesc, :ls_auditkeydesc, :ls_grpvalueold, :ls_grpvaluenew, :is_entryid, :idtm_entrydate )
	using		itr_sqlca ;
	
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "ไม่สามารถบันทึกรายการแก้ไขลง Audit Log ได้ (กลุ่ม)"+itr_sqlca.sqlerrtext
		throw ithw_exception
	end if
next

return 1
end function

private function integer of_postdelete (n_ds ads_before, long al_rowbf, string as_keyvalue[]) throws Exception;string			ls_iskey, ls_colname, ls_coltag, ls_colstyle, ls_valueold
string			ls_taggrp, ls_tagname, ls_tagsql
string			ls_auditgrp, ls_auditkeydesc, ls_auditkeyvalue, ls_auditgrpdesc, ls_grpvalueold
string			ls_grpcode[], ls_grpname[]
integer		li_colno, li_colcount, li_grpidx, li_grpcount

ls_auditkeyvalue	= this.of_genkeyvalue( as_keyvalue )
ls_auditkeydesc		= this.of_genkeyvaluedesc( as_keyvalue )

li_colcount		= integer( ads_before.object.datawindow.column.count )

for li_colno = 1 to li_colcount
	ls_iskey		= trim( string( ads_before.describe( "#"+string( li_colno )+".Key" ) ) )
	
	if lower( ls_iskey ) = "yes" then
		continue
	end if
	
	// ดึงชื่อ column กับ tag ออกมา
	ls_colname		= trim( string( ads_before.describe( "#"+string( li_colno )+".name" ) ) )
	ls_coltag			= trim( string( ads_before.describe( "#"+string( li_colno )+".tag" ) ) )
	
	// ถ้าตัวแรกมีค่าเป็น 0 แสดงว่าไม่ต้องการให้มีการบันทึกประวัติ
	if mid( ls_coltag, 1, 1 ) = "0" then
		continue
	end if
	
	// ค่าเก่าคืออะไร
	ls_valueold		= trim( string( ads_before.of_getitemany( al_rowbf, ls_colname ) ) )
		
	if isnull( ls_valueold ) then ls_valueold = ""
		
	// ถ้าค่าเก่าไม่มีค่า ข้ามทำอันถัดไป
	if ls_valueold = "" then
		continue
	end if
	
	// ให้กลุ่มการแก้เป็นชื่อ Column ที่แก้ไว้ก่อน
	ls_auditgrp		= ls_colname
	ls_auditgrpdesc	= ls_colname
	
	ls_taggrp			= ""
	ls_tagname		= ""
	ls_tagsql			= ""
	
	// ถ้ามีการใส่ Tag ไว้
	if ls_coltag <> "?" and not isnull( ls_coltag ) then
		// ตรวจว่า Tag นั้นเป็นมีอะไรบ้าง
		ls_taggrp		= this.of_gettagdesc( ls_coltag, "G" )
		ls_tagname	= this.of_gettagdesc( ls_coltag, "N" )
		
		// ถ้าเป็นกลุ่มข้อมูลยัดใส่ array ไว้ก่อนยังไม่ทำอะไร
		if ls_taggrp <> "" and not isnull( ls_taggrp ) then
			// ถ้ายังไม่มีกลุ่มนี้ ใส่ข้อมูลกลุ่มเอาไว้
			if not this.of_isvalidgrp( ls_grpcode, ls_taggrp ) then
				li_grpidx		= upperbound( ls_grpcode )
				li_grpidx		= li_grpidx + 1
				
				ls_grpcode[ li_grpidx ]	= ls_taggrp
				ls_grpname[ li_grpidx ]	= ls_tagname
			end if
			
			// ข้ามไปตรวจสอบ column ถัดไป
			continue
		end if
	end if

	// ถ้ามีชื่อภาษาไทยให้เอาไปใส่ table ด้วย
	if ls_tagname <> "" and not isnull( ls_tagname ) then
		ls_auditgrpdesc		= ls_tagname
	end if
	
	// ค่าเปลี่ยนแปลงที่ผ่านกระบวนการจาก Data เป็น คำอธิบายแล้ว
	ls_valueold		= this.of_getitemvaluedesc( ads_before, al_rowbf, ls_colname )
	
	// เริ่มการบันทึกลง Audit log
	insert into cmaudithistory
				( audit_no, audit_job, audit_grp, audit_type, audit_key, audit_grpdesc, audit_valuekey, audit_valueold, audit_valuenew, entry_id, entry_date )
	values	( :il_auditno, :is_auditjob, :ls_auditgrp, 'D', :ls_auditkeyvalue, :ls_auditgrpdesc, :ls_auditkeydesc, :ls_valueold, '', :is_entryid, :idtm_entrydate )
	using		itr_sqlca ;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "ไม่สามารถบันทึกรายการแก้ไขลง Audit Log ได้ "+itr_sqlca.sqlerrtext
		throw ithw_exception
	end if
next

li_grpcount		= upperbound( ls_grpcode )

// บันทึกพวกที่เป็นกลุ่มข้อมูล
for li_grpidx = 1 to li_grpcount
	
	ls_auditgrp			= ls_grpcode[ li_grpidx ]
	ls_auditgrpdesc		= ls_grpname[ li_grpidx ]
	
	ls_grpvalueold		= ""
	
	for li_colno = 1 to li_colcount
		ls_coltag		= trim( string( ads_before.describe( "#"+string( li_colno )+".tag" ) ) )
		
		ls_taggrp		= ""
		
		if ls_coltag <> "?" and not isnull( ls_coltag ) then
			// ตรวจว่า Tag นั้นเป็นมีอะไรบ้าง
			ls_taggrp		= this.of_gettagdesc( ls_coltag, "G" )
		end if
		
		if ls_taggrp <> ls_grpcode[ li_grpidx ] then
			continue
		end if
		
		ls_colname		= trim( string( ads_before.describe( "#"+string( li_colno )+".name" ) ) )
		
		ls_valueold		= this.of_getitemvaluedesc( ads_before, al_rowbf, ls_colname )
		
		ls_grpvalueold	= ls_grpvalueold +"  "+ ls_valueold
	next
	
	ls_grpvalueold		= trim( ls_grpvalueold )

	// เริ่มการบันทึกลง Audit log
	insert into cmaudithistory
				( audit_no, audit_job, audit_grp, audit_type, audit_key, audit_grpdesc, audit_valuekey, audit_valueold, audit_valuenew, entry_id, entry_date )
	values	( :il_auditno, :is_auditjob, :ls_auditgrp, 'D', :ls_auditkeyvalue, :ls_auditgrpdesc, :ls_auditkeydesc, :ls_grpvalueold, '', :is_entryid, :idtm_entrydate )
	using		itr_sqlca ;
	
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "ไม่สามารถบันทึกรายการแก้ไขลง Audit Log ได้ (กลุ่ม)"+itr_sqlca.sqlerrtext
		throw ithw_exception
	end if
next

return 1
end function

private function integer of_postadd (n_ds ads_after, long al_rowaf, string as_keyvalue[]) throws Exception;string			ls_iskey, ls_colname, ls_coltag, ls_colstyle, ls_valuenew
string			ls_taggrp, ls_tagname, ls_tagsql
string			ls_auditgrp, ls_auditkeydesc, ls_auditkeyvalue, ls_auditgrpdesc, ls_grpvaluenew
string			ls_grpcode[], ls_grpname[]
integer		li_colno, li_colcount, li_grpidx, li_grpcount, li_pos

ls_auditkeyvalue	= this.of_genkeyvalue( as_keyvalue )
ls_auditkeydesc		= this.of_genkeyvaluedesc( as_keyvalue )

li_colcount		= integer( ads_after.object.datawindow.column.count )

for li_colno = 1 to li_colcount
	ls_iskey		= trim( string( ads_after.describe( "#"+string( li_colno )+".Key" ) ) )
	
	if lower( ls_iskey ) = "yes" then
		continue
	end if
	
	// ดึงชื่อ column กับ tag ออกมา
	ls_colname		= trim( string( ads_after.describe( "#"+string( li_colno )+".name" ) ) )
	ls_coltag			= trim( string( ads_after.describe( "#"+string( li_colno )+".tag" ) ) )
	
	// ถ้าตัวแรกมีค่าเป็น 0 แสดงว่าไม่ต้องการให้มีการบันทึกประวัติ
	if mid( ls_coltag, 1, 1 ) = "0" then
		continue
	end if
	
	ls_valuenew		= trim( string( ads_after.of_getitemany( al_rowaf, ls_colname ) ) )
		
	if isnull( ls_valuenew ) then ls_valuenew = ""
		
	// ถ้าไม่มีค่า ข้ามทำอันถัดไป
	if ls_valuenew = "" then
		continue
	end if
	
	// ให้กลุ่มการแก้เป็นชื่อ Column ที่แก้ไว้ก่อน
	ls_auditgrp		= ls_colname
	ls_auditgrpdesc	= ls_colname
	
	ls_taggrp			= ""
	ls_tagname		= ""
	ls_tagsql			= ""
	
	// ถ้ามีการใส่ Tag ไว้
	if ls_coltag <> "?" and not isnull( ls_coltag ) then
		// ตรวจว่า Tag นั้นเป็นมีอะไรบ้าง
		ls_taggrp		= this.of_gettagdesc( ls_coltag, "G" )
		ls_tagname	= this.of_gettagdesc( ls_coltag, "N" )
		
		// ถ้าเป็นกลุ่มข้อมูลยัดใส่ array ไว้ก่อนยังไม่ทำอะไร
		if ls_taggrp <> "" and not isnull( ls_taggrp ) then
			// ถ้ายังไม่มีกลุ่มนี้ ใส่ข้อมูลกลุ่มเอาไว้
			if not this.of_isvalidgrp( ls_grpcode, ls_taggrp ) then
				li_grpidx		= upperbound( ls_grpcode )
				li_grpidx		= li_grpidx + 1
				
				ls_grpcode[ li_grpidx ]	= ls_taggrp
				ls_grpname[ li_grpidx ]	= ls_tagname
			end if
			
			// ข้ามไปตรวจสอบ column ถัดไป
			continue
		end if
	end if

	// ถ้ามีชื่อภาษาไทยให้เอาไปใส่ table ด้วย
	if ls_tagname <> "" and not isnull( ls_tagname ) then
		ls_auditgrpdesc		= ls_tagname
	end if
	
	// ค่าเปลี่ยนแปลงที่ผ่านกระบวนการจาก Data เป็น คำอธิบายแล้ว
	ls_valuenew		= this.of_getitemvaluedesc( ads_after, al_rowaf, ls_colname )
	
	// เริ่มการบันทึกลง Audit log
	insert into cmaudithistory
				( audit_no, audit_job, audit_grp, audit_type, audit_key, audit_grpdesc, audit_valuekey, audit_valueold, audit_valuenew, entry_id, entry_date )
	values	( :il_auditno, :is_auditjob, :ls_auditgrp, 'A', :ls_auditkeyvalue, :ls_auditgrpdesc, :ls_auditkeydesc, '', :ls_valuenew, :is_entryid, :idtm_entrydate )
	using		itr_sqlca ;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "ไม่สามารถบันทึกรายการแก้ไขลง Audit Log ได้ "+itr_sqlca.sqlerrtext
		throw ithw_exception
	end if
next

li_grpcount		= upperbound( ls_grpcode )

// บันทึกพวกที่เป็นกลุ่มข้อมูล
for li_grpidx = 1 to li_grpcount
	
	ls_auditgrp			= ls_grpcode[ li_grpidx ]
	ls_auditgrpdesc		= ls_grpname[ li_grpidx ]
	
	ls_grpvaluenew		= ""
	
	for li_colno = 1 to li_colcount
		ls_coltag		= trim( string( ads_after.describe( "#"+string( li_colno )+".tag" ) ) )
		
		ls_taggrp		= ""
		
		if ls_coltag <> "?" and not isnull( ls_coltag ) then
			// ตรวจว่า Tag นั้นเป็นมีอะไรบ้าง
			ls_taggrp		= this.of_gettagdesc( ls_coltag, "G" )
		end if
		
		if ls_taggrp <> ls_grpcode[ li_grpidx ] then
			continue
		end if
		
		ls_colname		= trim( string( ads_after.describe( "#"+string( li_colno )+".name" ) ) )
		
		ls_valuenew		= this.of_getitemvaluedesc( ads_after, al_rowaf, ls_colname )
		
		ls_grpvaluenew	= ls_grpvaluenew +"  "+ ls_valuenew
	next
	
	ls_grpvaluenew		= trim( ls_grpvaluenew )

	// เริ่มการบันทึกลง Audit log
	insert into cmaudithistory
				( audit_no, audit_job, audit_grp, audit_type, audit_key, audit_grpdesc, audit_valuekey, audit_valueold, audit_valuenew, entry_id, entry_date )
	values	( :il_auditno, :is_auditjob, :ls_auditgrp, 'A', :ls_auditkeyvalue, :ls_auditgrpdesc, :ls_auditkeydesc, '', :ls_grpvaluenew, :is_entryid, :idtm_entrydate )
	using		itr_sqlca ;
	
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "ไม่สามารถบันทึกรายการแก้ไขลง Audit Log ได้ (กลุ่ม)"+itr_sqlca.sqlerrtext
		throw ithw_exception
	end if
next

return 1
end function

private function string of_genkeyfindsyntax (string as_keyvalue[]);string		ls_kyfind, ls_kycol
long		ll_kyidx, ll_kycount

ls_kyfind		= ""

ll_kycount	= upperbound( is_keycolumn )

for ll_kyidx = 1 to ll_kycount
	ls_kycol	= is_keycolumn[ ll_kyidx ]
	
	choose case lower( left( is_keytype[ ll_kyidx ], 5 ) )
		case "char(", "char"
			ls_kyfind		+= " and ( "+ls_kycol+" = '"+as_keyvalue[ ll_kyidx ]+"' )"
			
		case "date"
			ls_kyfind		+= " and string( "+ls_kycol+", 'dd/mm/yyyy' ) = '"+as_keyvalue[ ll_kyidx ]+"'"
			
		case "datet"
			ls_kyfind		+= " and string( "+ls_kycol+", 'dd/mm/yyyy hh:mm:ss' ) = '"+as_keyvalue[ ll_kyidx ]+"'"
			
		case "decim", "numbe", "long", "ulong", "real", "int"
			ls_kyfind		+= " and ( "+ls_kycol+" = "+as_keyvalue[ ll_kyidx ]+" )"
			
		case "time", "times"
			ls_kyfind		+= " and string( "+ls_kycol+", 'hh:mm:ss' ) = '"+as_keyvalue[ ll_kyidx ]+"'"
			
	end choose
next

if trim( ls_kyfind ) <> "" then
	ls_kyfind	= mid( ls_kyfind, 5 )
end if

return ls_kyfind

end function

private function string of_genkeyvalue (string as_keyvalue[]);string		ls_kydesc
long		ll_kyidx, ll_kycount

ls_kydesc		= ""

ll_kycount	= upperbound( is_keycolumn )

for ll_kyidx = 1 to ll_kycount
	ls_kydesc	+= ", "+as_keyvalue[ ll_kyidx ]
next

if trim( ls_kydesc ) <> "" then
	ls_kydesc	= mid( ls_kydesc, 3 )
end if

return ls_kydesc
end function

private function string of_genkeyvaluedesc (string as_keyvalue[]);string		ls_kydesc
long		ll_kyidx, ll_kycount

ls_kydesc		= ""

ll_kycount	= upperbound( is_keycolumn )

for ll_kyidx = 1 to ll_kycount
	ls_kydesc	+= ", "+is_keydesc[ ll_kyidx ]+" "+as_keyvalue[ ll_kyidx ]
next

if trim( ls_kydesc ) <> "" then
	ls_kydesc	= mid( ls_kydesc, 3 )
end if

return ls_kydesc
end function

private function string of_getcheckboxvalue (n_ds ads_requestor, string as_colname, string as_value);string		ls_chkon, ls_chkoff, ls_chkother, ls_state

ls_chkon		= ads_requestor.describe( as_colname+".checkbox.on" )
ls_chkoff		= ads_requestor.describe( as_colname+".checkbox.off" )
ls_chkother	= ads_requestor.describe( as_colname+".checkbox.other" )

if as_value	= ls_chkon then
	ls_state	= "เลือก(ใช่)"
elseif as_value	= ls_chkoff then
	ls_state	= "เลือก(ไม่)"
elseif as_value	= ls_chkother then
	ls_state	= "เลือก(อื่นๆ)"
end if

return ls_state
end function

private function string of_getitemvaluedesc (n_ds ads_requestor, long al_row, string as_column) throws Exception;string		ls_valuedesc, ls_format
string		ls_stylechkbox, ls_styleddlb, ls_styledddw, ls_styleedit, ls_styleeditmask, ls_styleradio
string		ls_coltype, ls_coltag, ls_tagsql, ls_tagprefix
any		ls_anyvalue

ls_coltype		= trim( string( ads_requestor.describe( as_column+".ColType" ) ) )
ls_coltag			= trim( string( ads_requestor.describe( as_column+".tag" ) ) )
ls_tagsql			= this.of_gettagdesc( ls_coltag, "SQL" )
ls_tagprefix		= this.of_gettagdesc( ls_coltag, "P" )

// ถ้ามีการใส่ Tag SQL ไว้
if ls_tagsql <> "" then
	ls_valuedesc	= this.of_getitemvaluefromsql( ads_requestor, al_row, ls_tagsql )
else
	// ตรวจสอบว่าเป็น style checkbox หรือเปล่า
	
	ls_stylechkbox		= ads_requestor.describe( as_column+".checkbox.LeftText" )
	ls_styleddlb			= ads_requestor.describe( as_column+".ddlb.AllowEdit" )
	ls_styledddw		= ads_requestor.describe( as_column+".dddw.AllowEdit" )
	ls_styleedit			= ads_requestor.describe( as_column+".Edit.AutoHScroll" )
	ls_styleeditmask	= ads_requestor.describe( as_column+".EditMask.Mask" )
	ls_styleradio			= ads_requestor.describe( as_column+".RadioButtons.3D" )
	
	ls_format			= ads_requestor.describe( as_column+".format" )
	
	// ถ้าเป็น CheckBox
	if ls_stylechkbox <> "!" and ls_stylechkbox <> "?" and ls_stylechkbox <> "" and not isnull( ls_stylechkbox ) then
		ls_valuedesc		= string( ads_requestor.of_getitemany( al_row, as_column ) )
		ls_valuedesc		= this.of_getcheckboxvalue( ads_requestor, as_column, ls_valuedesc )
		
		return ls_valuedesc
	end if
	
	// ถ้าเป็น DropdownListBox
	if ls_styleddlb <> "!" and ls_styleddlb <> "?" and ls_styleddlb <> "" and not isnull( ls_styleddlb ) then
		ls_valuedesc		= ads_requestor.describe( "evaluate( 'lookupdisplay("+as_column+")', "+ string( al_row ) +" )" )
		
		return ls_valuedesc
	end if
	
	// ถ้าเป็น DropdownDataWindow
	if ls_styledddw <> "!" and ls_styledddw <> "?" and ls_styledddw <> "" and not isnull( ls_styledddw ) then
		ls_valuedesc		= string( ads_requestor.of_getitemany( al_row, as_column ) )
		
		return ls_valuedesc
	end if
	
	// ถ้าเป็น Edit
	if ls_styleedit <> "!" and ls_styleedit <> "?" and ls_styleedit <> "" and not isnull( ls_styleedit ) then
		ls_anyvalue		= ads_requestor.of_getitemany( al_row, as_column )
		ls_valuedesc	= this.of_cnvtostring( ls_anyvalue, ls_coltype, ls_format )
		
		return ls_valuedesc
	end if
	
	// ถ้าเป็น EditMask
	if ls_styleeditmask <> "!" and ls_styleeditmask <> "?" then
		ls_anyvalue		= ads_requestor.of_getitemany( al_row, as_column )
		ls_valuedesc	= this.of_cnvtostring( ls_anyvalue, ls_coltype, ls_format )
		
		return ls_valuedesc
	end if
	
	// ถ้าเป็น Radio Button
	if ls_styleradio <> "!" and ls_styleradio <> "?" and ls_styleradio <> "" and not isnull( ls_styleradio ) then
		ls_valuedesc		= string( ads_requestor.of_getitemany( al_row, as_column ) )
		return ls_valuedesc
	end if
end if

if ls_valuedesc <> "" then
	ls_valuedesc	= ls_tagprefix + ls_valuedesc	
end if

return ls_valuedesc
end function

private function string of_getitemvaluefromsql (n_ds ads_requestor, long al_row, string as_sqlsyntax) throws Exception;string		ls_valuedesc, ls_sqlsyntax, ls_colname, ls_coltype, ls_colval
integer	li_poss, li_pose, li_pos

ls_sqlsyntax		= as_sqlsyntax

// เริ่มแทนที่ตัวแปรด้วยค่าของข้อมูล
li_poss	= pos( ls_sqlsyntax, "[", 1 )
do while li_poss > 0
	li_pose	= pos( ls_sqlsyntax, "]", li_poss+1 )
	
	if li_pose <= 0 then
		li_pose	= len( ls_sqlsyntax )
	end if
	
	ls_colname	= mid( ls_sqlsyntax, li_poss + 1, li_pose - ( li_poss + 1 ) )
	
	ls_coltype	= trim( string( ads_requestor.describe( ls_colname+".ColType" ) ) )

	ls_colval		= this.of_cnvtostring( ads_requestor.of_getitemany( al_row, ls_colname ), ls_coltype )
	
	ls_sqlsyntax	= replace( ls_sqlsyntax, li_poss, ( li_pose - li_poss )+1, ls_colval )
	
	li_poss	= pos( ls_sqlsyntax, "[", 1 )
loop

DynamicStagingArea	l_sqlsa

l_sqlsa	= create DynamicStagingArea

declare my_cursor dynamic cursor for l_sqlsa ;
prepare l_sqlsa from :ls_sqlsyntax using itr_sqlca ;
open my_cursor ;
fetch my_cursor into :ls_valuedesc ;
close my_cursor ;

return ls_valuedesc
end function

private function integer of_getkeyvalue (n_ds ads_requestor, long al_row, ref string as_keyvalue[]);string		ls_kycol, ls_kystr, ls_empty[]
integer	li_kyidx, li_kycount
dec		ldc_kydec
date		ld_kydate
time		lt_kytime
datetime	ldtm_kydtetime

as_keyvalue	= ls_empty
li_kycount	= upperbound( is_keycolumn )

for li_kyidx = 1 to li_kycount
	ls_kycol	= is_keycolumn[ li_kyidx ]
	
	choose case lower( left( is_keytype[ li_kyidx ], 5 ) )
		case "char(", "char"
			ls_kystr						= ads_requestor.getitemstring( al_row, ls_kycol )
			as_keyvalue[ li_kyidx ]	= ls_kystr
			
		case "date"
			ld_kydate					= ads_requestor.getitemdate( al_row, ls_kycol )
			as_keyvalue[ li_kyidx ]	= string( ld_kydate, "dd/mm/yyyy" )
			
		case "datet"
			ldtm_kydtetime				= ads_requestor.getitemdatetime( al_row, ls_kycol )
			as_keyvalue[ li_kyidx ]	= string( ldtm_kydtetime, "dd/mm/yyyy hh:mm:ss" )
			
		case "decim", "numbe", "long", "ulong", "real", "int"
			ldc_kydec					= ads_requestor.getitemdecimal( al_row, ls_kycol )
			as_keyvalue[ li_kyidx ]	= string( ldc_kydec )
			
		case "time", "times"
			lt_kytime						= ads_requestor.getitemtime( al_row, ls_kycol )
			as_keyvalue[ li_kyidx ]	= string( lt_kytime, "HH:MM:SS" )
			
	end choose
next

return 1

end function

private function string of_gettagdesc (string as_tagsyntax, string as_tagfind) throws Exception;string			ls_tagstart, ls_tagend, ls_tagdesc
integer		li_poss, li_pose, li_lentagfind

as_tagsyntax	= lower( trim( as_tagsyntax ) )
as_tagfind		= lower( trim( as_tagfind ) )

if as_tagsyntax = "" then
	return ""
end if

if as_tagfind = "" then
	return ""
end if

li_lentagfind	= len( as_tagfind )
ls_tagstart	= "<"+as_tagfind
ls_tagend	= "/"+as_tagfind+">"

li_poss	= pos( as_tagsyntax, ls_tagstart, 1 )
li_pose	= pos( as_tagsyntax, ls_tagend, 1 )

if li_poss <= 0 and li_pose <= 0 then
	return ""
end if

if ( li_poss <= 0 and li_pose > 0 ) or ( li_poss > 0 and li_pose <= 0 ) then
	ithw_exception.text	= "Tag Syntax ที่ระบุมาไม่สมบูรณ์ กรุณาติดต่อผู้พัฒนาระบบ "+as_tagsyntax
	throw ithw_exception
end if

ls_tagdesc		= trim( mid( as_tagsyntax, li_poss + li_lentagfind + 1, li_pose - ( li_poss + li_lentagfind + 1 ) ) )

return ls_tagdesc
end function

private function integer of_initkeycolumn (n_ds ads_requestor) throws Exception;string			ls_iskey, ls_kytag, ls_kycolumn, ls_kydesc, ls_empty[]
integer		li_colno, li_colcount, li_index

is_keycolumn	= ls_empty
is_keytype		= ls_empty
li_colcount		= integer( ads_requestor.object.datawindow.column.count )

for li_colno = 1 to li_colcount
	ls_iskey		= trim( string( ads_requestor.describe( "#"+string( li_colno )+".Key" ) ) )
	
	if lower( ls_iskey ) = "yes" then
		li_index		= upperbound( is_keycolumn )
		li_index		= li_index + 1
		
		ls_kycolumn		= trim( string( ads_requestor.describe( "#"+string( li_colno )+".Name" ) ) )
		ls_kytag			= trim( string( ads_requestor.describe( "#"+string( li_colno )+".Tag" ) ) )
		
		if ls_kytag = "?" or ls_kytag = "" or isnull( ls_kytag ) then
			ls_kydesc	= ls_kycolumn
		else
			ls_kydesc	= this.of_gettagdesc( ls_kytag, "N" )
		end if
		
		is_keycolumn[ li_index ]	= ls_kycolumn
		is_keydesc[ li_index ]		= ls_kydesc
		is_keytype[ li_index ]		= trim( string( ads_requestor.describe( "#"+string( li_colno )+".ColType" ) ) )
	end if
next

return 1
end function

private function boolean of_isvalidgrp (string as_grpcol[], string as_grpcheck);integer		li_index, li_max

li_max		= upperbound( as_grpcol )

if li_max = 0 then
	return false
end if

for li_index = 1 to li_max
	if trim( as_grpcheck ) = trim( as_grpcol[ li_index ] ) then
		return true
	end if
next

return false
end function

on n_cst_auditservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_auditservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ithw_exception = create Exception
end event

event destructor;this.of_setsrvdwxmlie( false )
end event

