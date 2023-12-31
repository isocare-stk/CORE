$PBExportHeader$n_cst_dwxmlieservice.sru
$PBExportComments$ส่วนบริการความคืบหน้าสำหรับงานประมวลผล
forward
global type n_cst_dwxmlieservice from NonVisualObject
end type
end forward

/// <summary> ส่วนบริการความคืบหน้าสำหรับงานประมวลผล
/// </summary>
global type n_cst_dwxmlieservice from NonVisualObject
end type
global n_cst_dwxmlieservice n_cst_dwxmlieservice

forward prototypes
public function string of_xmlexport (ref n_ds ads_requestor) throws Exception
public function long of_xmlimport (ref n_ds ads_requestor, string as_xmltext) throws Exception
public function string of_getdataobject (string as_xmltext)
public function long of_xmlimport (ref n_ds ads_requestor, string as_xmltext, boolean ab_chksourcecol, boolean ab_chkdestcol) throws Exception
public function long of_xmlimport (ref DataWindow adw_requestor, string as_xmltext, boolean ab_chksourcecol, boolean ab_chkdestcol) throws Exception
public function long of_xmlimport (ref DataWindow adw_requestor, string as_xmltext) throws Exception
public function string of_xmlexport (ref DataWindow adw_requestor) throws Exception
public function long of_rowcount (string as_xmltext)
private function long of_importdatadw (ref n_ds ads_requestor, string as_xmltext, boolean ab_chksourcecol, boolean ab_chkdestcol) throws Exception
private function long of_importdataweb (ref n_ds ads_requestor, string as_xmltext) throws Exception
private function string of_globalreplace (string as_source, string as_old, string as_new, boolean ab_ignorecase)
private function long of_importdataweb (ref DataWindow adw_requestor, string as_xmltext) throws Exception
private function long of_importdatadw (ref DataWindow adw_requestor, string as_xmltext, boolean ab_chksourcecol, boolean ab_chkdestcol) throws Exception
end prototypes

public function string of_xmlexport (ref n_ds ads_requestor) throws Exception;string			ls_xmlreturn
Exception	lthw_imperr

lthw_imperr		= create Exception

if not( isvalid( ads_requestor ) ) or isnull( ads_requestor ) then
	lthw_imperr.text	= "(Service) Datawindow ที่ต้องการ Export ข้อมูลไม่มีค่า กรุณาติดต่อโปรแกรมเมอร์"
	throw lthw_imperr
end if

if ads_requestor.rowcount() > 0 then
	ls_xmlreturn		= ads_requestor.describe( "Datawindow.Data.XML" )
else
	ls_xmlreturn		= ""
end if

return ls_xmlreturn
end function

public function long of_xmlimport (ref n_ds ads_requestor, string as_xmltext) throws Exception;return this.of_xmlimport( ads_requestor, as_xmltext, true, true )
end function

public function string of_getdataobject (string as_xmltext);string		ls_dwobject, ls_detail
long		ll_postag, ll_posend

if trim( as_xmltext ) = "" or isnull( as_xmltext ) then
	return ""
end if

// ตัดให้เหลือแต่ส่วนรายละเอียด
ll_postag		= pos( as_xmltext, "<?" )
ll_posend	= pos( as_xmltext, "?>" )
ls_detail		= mid( as_xmltext, ll_posend + 2 )

// ตรวจสอบก่อนว่า xml ที่ส่งมามีส่วนของข้อมูลหรือเปล่า
ll_posend	= pos( ls_detail, "/>" )
if ll_posend > 0 then
	ll_postag		= pos( ls_detail, "<" )
	ls_dwobject	= mid( ls_detail, ll_postag + 1, ll_posend - ll_postag - 1 )
else
	ll_postag		= pos( ls_detail, "<" )
	ll_posend	= pos( ls_detail, ">" )
	ls_dwobject	= mid( ls_detail, ll_postag + 1, ll_posend - ll_postag - 1 )
end if

return ls_dwobject
end function

public function long of_xmlimport (ref n_ds ads_requestor, string as_xmltext, boolean ab_chksourcecol, boolean ab_chkdestcol) throws Exception;string		ls_header, ls_detail
long		ll_postag, ll_posend, ll_count
string		ls_cnewline, ls_creturn, ls_ctab
Exception	lthw_imperr

lthw_imperr		= create Exception
ll_count			= 0

if not( isvalid( ads_requestor ) ) or isnull( ads_requestor ) then
	lthw_imperr.text	= "(Service) Datawindow ที่ต้องการนำข้อมูลเข้าไม่มีค่า กรุณาแจ้งข้อผิดพลาดนี้กับโปรแกรมเมอร์"
	throw lthw_imperr
end if

if trim( as_xmltext ) = "" or isnull( as_xmltext ) then
	return 0
end if

ls_cnewline	= charA(10)
ls_creturn	= charA(13)
ls_ctab		= charA(9)
as_xmltext	= this.of_globalreplace( as_xmltext, "\r", ls_creturn, true )
as_xmltext	= this.of_globalreplace( as_xmltext, "\n", ls_cnewline, true )
as_xmltext	= this.of_globalreplace( as_xmltext, "\t", ls_ctab, true )
as_xmltext	= this.of_globalreplace( as_xmltext, '\"', "", true )

// แยกส่วน Header กับ รายละเอียดออกจากกัน
ll_postag		= pos( as_xmltext, "<?" )
ll_posend	= pos( as_xmltext, "?>" )
ls_header	= mid( as_xmltext, ll_postag, ll_posend + 1 )
ls_detail		= mid( as_xmltext, ll_posend + 2 )

// ตรวจสอบก่อนว่ามีแถวหรือเปล่า
ll_posend	= pos( ls_detail, "/>" )
if ll_posend > 0 then
	return 0
end if

// ตรวจสอบว่าเป็น XML แบบไหน มาจาก Webdata หรือ Dw.net
// DW Object
ll_postag		= pos( ls_detail, "iscxml_data" )

if ll_postag > 0 then
	ll_count	= this.of_importdataweb( ads_requestor, ls_detail )
else
	ll_count	= this.of_importdatadw( ads_requestor, ls_detail, ab_chksourcecol, ab_chkdestcol )
end if

return ll_count
end function

public function long of_xmlimport (ref DataWindow adw_requestor, string as_xmltext, boolean ab_chksourcecol, boolean ab_chkdestcol) throws Exception;string		ls_header, ls_detail
long		ll_postag, ll_posend, ll_count
Exception	lthw_imperr

lthw_imperr		= create Exception
ll_count			= 0

if not( isvalid( adw_requestor ) ) or isnull( adw_requestor ) then
	lthw_imperr.text	= "(Service) Datawindow ที่ต้องการนำข้อมูลเข้าไม่มีค่า กรุณาแจ้งข้อผิดพลาดนี้กับโปรแกรมเมอร์"
	throw lthw_imperr
end if

if trim( as_xmltext ) = "" or isnull( as_xmltext ) then
	return 0
end if

as_xmltext	= this.of_globalreplace( as_xmltext, "\n", "", true )
as_xmltext	= this.of_globalreplace( as_xmltext, "\t", "", true )
as_xmltext	= this.of_globalreplace( as_xmltext, '\"', "", true )

// แยกส่วน Header กับ รายละเอียดออกจากกัน
ll_postag		= pos( as_xmltext, "<?" )
ll_posend	= pos( as_xmltext, "?>" )
ls_header	= mid( as_xmltext, ll_postag, ll_posend + 1 )
ls_detail		= mid( as_xmltext, ll_posend + 2 )

// ตรวจสอบก่อนว่ามีแถวหรือเปล่า
ll_posend	= pos( ls_detail, "/>" )
if ll_posend > 0 then
	return 0
end if

// ตรวจสอบว่าเป็น XML แบบไหน มาจาก Webdata หรือ Dw.net
// DW Object
ll_postag		= pos( ls_detail, "iscxml_data" )

if ll_postag > 0 then
	ll_count	= this.of_importdataweb( adw_requestor, ls_detail )
else
	ll_count	= this.of_importdatadw( adw_requestor, ls_detail, ab_chksourcecol, ab_chkdestcol )
end if

return ll_count
end function

public function long of_xmlimport (ref DataWindow adw_requestor, string as_xmltext) throws Exception;return of_xmlimport( adw_requestor, as_xmltext, true, true )
end function

public function string of_xmlexport (ref DataWindow adw_requestor) throws Exception;string			ls_xmlreturn
Exception	lthw_imperr

lthw_imperr		= create Exception

if not( isvalid( adw_requestor ) ) or isnull( adw_requestor ) then
	lthw_imperr.text	= "(Service) Datawindow ที่ต้องการ Export ข้อมูลไม่มีค่า กรุณาติดต่อโปรแกรมเมอร์"
	throw lthw_imperr
end if

if adw_requestor.rowcount() > 0 then
	ls_xmlreturn		= adw_requestor.describe( "Datawindow.Data.XML" )
else
	ls_xmlreturn		= ""
end if

return ls_xmlreturn
end function

public function long of_rowcount (string as_xmltext);string		ls_header, ls_detail, ls_dwobject, ls_tagfind
long		ll_postag, ll_posend, ll_lendata, ll_count, ll_taglen

ll_count		= 0

if trim( as_xmltext ) = "" or isnull( as_xmltext ) then
	return 0
end if

// แยกส่วน Header กับ รายละเอียดออกจากกัน
ll_postag		= pos( as_xmltext, "<?" )
ll_posend	= pos( as_xmltext, "?>" )
ls_header	= mid( as_xmltext, ll_postag, ll_posend + 1 )
ls_detail		= mid( as_xmltext, ll_posend + 2 )

// ตรวจสอบก่อนว่ามีแถวหรือเปล่า
ll_posend	= pos( ls_detail, "/>" )
if ll_posend > 0 then
	return 0
end if

ls_dwobject	= this.of_getdataobject( as_xmltext )

ll_lendata	= len( ls_detail )
ls_tagfind	= "</"+ls_dwobject+"_row>"
ll_taglen		= len( ls_tagfind )

ll_posend	= pos( ls_detail, ls_tagfind )

do while ll_posend > 0
	ll_count++
	
	ll_posend	= pos( ls_detail, ls_tagfind, ll_posend + ll_taglen + 1 )
loop

return ll_count
end function

private function long of_importdatadw (ref n_ds ads_requestor, string as_xmltext, boolean ab_chksourcecol, boolean ab_chkdestcol) throws Exception;string ls_detail, ls_dwobject, ls_alldata, ls_rowdata, ls_column, ls_coltype, ls_puredata
string ls_datatmp
long ll_postag, ll_posend, ll_startdata, ll_lendata, ll_row, ll_count
integer li_colcount, li_colindex, li_pos
any la_data
dec ldc_data
date ld_data
time lt_data
datetime ldtm_data

Exception lthw_imperr

lthw_imperr = create Exception
ll_count = 0

ls_detail = as_xmltext

// DW Object
ll_postag = pos(ls_detail, "<")
ll_posend = pos(ls_detail, ">")
ls_dwobject = mid(ls_detail, ll_postag + 1, ll_posend - ll_postag - 1)
ls_detail = mid(ls_detail, ll_posend + 1)

// ALL Data
ll_postag = pos(ls_detail, "<")
ll_posend = pos(ls_detail, "</" + ls_dwobject + ">")
ls_alldata = mid(ls_detail, ll_postag, ll_posend - ll_postag)

// ดูว่าต้องตรวจต้นทาง ว่ามี Column เท่ากับปลายทางหรือเปล่า
if ab_chkdestcol then
	ls_datatmp = Lower(ls_alldata)
	li_colcount = integer(ads_requestor. describe ("DataWindow.Column.Count"))
	
	for li_colindex = 1 to li_colcount
		ls_column = lower(ads_requestor. describe ("#" + string(li_colindex)+".Name"))
		
		ll_postag = pos(ls_datatmp, "<"+ls_column+">")
		
		if ll_postag <= 0 then
			lthw_imperr.text = "XML ที่ส่งมาให้ไม่มี Column (" + ls_column + ") ซึ่งอาจทำให้ฝั่งรับข้อมูลไปทำงานต่อ อาจจะทำงานไม่สมบูรณ์ได้ กรุณาตรวจสอบ"
			throw lthw_imperr
		end if
	next
	
end if

// Row Data
ll_postag = pos(ls_alldata, "<" + ls_dwobject + "_row>")
ll_posend = pos(ls_alldata, "</" + ls_dwobject + "_row>")

do while ll_posend > 0
	ll_startdata = ll_postag + len(ls_dwobject)+6
	ll_lendata = ll_posend - ll_startdata
	
	ls_rowdata = mid(ls_alldata, ll_startdata, ll_lendata)
	ls_alldata = mid(ls_alldata, (ll_posend + len("</" + ls_dwobject + "_row>")))
	
	ll_row = ads_requestor.insertrow(0)
	ll_count++
	
	// วนลูปใส่ข้อมูลให้ dw
	do
		// column
		ll_postag = pos(ls_rowdata, "<")
		ll_posend = pos(ls_rowdata, ">")
		ls_column = mid(ls_rowdata, ll_postag + 1, ll_posend - ll_postag - 1)
		
		// data
		ll_startdata = ll_posend + 1
		ll_posend = pos(ls_rowdata, "</" + ls_column)
		ls_puredata = mid(ls_rowdata, ll_startdata, ll_posend - ll_startdata)
		
		// ข้อมุลใน row ที่เหลือ
		ls_rowdata = mid(ls_rowdata, ll_posend + len("</" + ls_column + ">"))
		
		// Check column เพื่อตรวจสอบว่ามี column ที่ระบุหรือเปล่า
		ls_coltype = ads_requestor.describe(ls_column + ".ColType")
		
		// ถ้าไม่มี column ที่ระบุ
		if ls_coltype = "!" then
			if ab_chksourcecol then
				lthw_imperr.text = "Column (" + ls_column + ") ไม่มีในฝั่งรับกรุณาตรวจสอบด้วย Service จะหยุดการนำเข้าเพียงเท่านี้"
				throw lthw_imperr
			else
				continue
			end if
		end if
		
		// ตรวจสอบข้อมูล
		if ll_startdata = ll_posend then
			setnull(la_data)
			ads_requestor.setitem(ll_row, ls_column, la_data)
		else
			// ตรวจสอบ Column ว่าเป็น Datatype แบบไหน
			// Fix Bug 2011-05-04 ปรับเป็นตัวแปรของใครของมัน
			// แก้ไขแทนของเดิมที่เป็นตัวแปรแบบ Any
			// จิงๆ Any ก็ใช้ได้แต่เจอปัญหาที่ type datetime ซึ่งมีเวลาติดมาด้วย
			choose case lower(left(ls_coltype, 5))
				case "char(", "char"
					ads_requestor.setitem(ll_row, ls_column, ls_puredata)
				case "date"
					ld_data = date(ls_puredata)
					ads_requestor.setitem(ll_row, ls_column, ld_data)
				case "datet"
					
					li_pos = Pos(ls_puredata, " ")
					
					if li_pos > 0 then
						ld_data = date(left(ls_puredata, li_pos - 1))
						lt_data = time(mid(ls_puredata, li_pos + 1))
						ldtm_data = datetime(ld_data, lt_data)
					else
						ld_data = date(ls_puredata)
						ldtm_data = datetime(ld_data)
					end if
					
					
					ads_requestor.setitem(ll_row, ls_column, ldtm_data)
				case "decim"
					ldc_data = dec(ls_puredata)
					ads_requestor.setitem(ll_row, ls_column, ldc_data)
				case "numbe", "long", "ulong", "real", "int"
					ldc_data = dec(ls_puredata)
					ads_requestor.setitem(ll_row, ls_column, ldc_data)
				case else
					setnull(la_data)
					ads_requestor.setitem(ll_row, ls_column, la_data)
			end choose
		end if
		loop until len(ls_rowdata) <= 0
	
		if len(ls_alldata) = 0 then
			exit
		end if
	
		ll_posend = pos(ls_alldata, "</" + ls_dwobject + "_row>")
loop

return ll_count
end function

private function long of_importdataweb (ref n_ds ads_requestor, string as_xmltext) throws Exception;string		ls_detail, ls_dwobject, ls_webtable, ls_alldata, ls_column, ls_rowdata, ls_puredata, ls_coltype
long		ll_postag, ll_posend, ll_startdata, ls_lendata, ll_posspc
long		ll_count, ll_row, ll_lendata
integer	li_colcount, li_colindex
any		la_data
dec		ldc_data
date		ld_data
time		lt_data
datetime	ldtm_data

ls_detail		= as_xmltext

// DW Object
ll_postag		= pos( ls_detail, "<iscxml_data_table" )
ll_posend	= pos( ls_detail, ">", ll_postag )
ls_dwobject	= mid( ls_detail, ll_postag, ll_posend - ll_postag + 1 )
ls_detail		= mid( ls_detail, ll_posend + 1 )

// ALL Data
ll_postag		= pos( ls_detail, "<" )
ll_posend	= pos( ls_detail, "</iscxml_data_table>" )
ls_alldata	= mid( ls_detail, ll_postag, ll_posend - ll_postag )

// Row Data
ll_postag		= pos( ls_alldata, "<iscxml_data_row>" )
ll_posend	= pos( ls_alldata, "</iscxml_data_row>" )

do while ll_posend > 0
	ll_startdata	= ll_postag + len( "<iscxml_data_row>" )
	ll_lendata	= ll_posend - ll_startdata
	
	ls_rowdata	= mid( ls_alldata, ll_startdata, ll_lendata )
	ls_alldata	= mid( ls_alldata, ( ll_posend + len( "</iscxml_data_row>" ) ) )
	
	ll_row			= ads_requestor.insertrow( 0 )
	ll_count++
	
	// วนลูปใส่ข้อมูลให้ dw
	do
		// column
		ll_postag		= pos( ls_rowdata, "<" )
		ll_posend	= pos( ls_rowdata, ">", ll_postag )
		ls_column	= mid( ls_rowdata, ll_postag + 1, ll_posend - ll_postag - 1 )
		
		// tag ของ webdata มันไม่ใช่ชื่ออย่างเดียวหาช่องว่างเพื่อเอาชื่ออย่างเดียว
		ll_posspc		= pos( ls_column, " " )
		if ll_posspc > 0 then
			ls_column	= mid( ls_column, 1, ll_posspc - 1 )
		end if
		
		// data
		ll_startdata	= ll_posend + 1
		ll_posend	= pos( ls_rowdata, "</"+ls_column )
		ls_puredata	= mid( ls_rowdata, ll_startdata, ll_posend - ll_startdata )
		
		// ข้อมุลใน row ที่เหลือ
		ls_rowdata	= mid( ls_rowdata, ll_posend + len( "</"+ls_column+">" ) )
		
		if ls_column = "row_status" then
			continue
		end if
		
		// Check column เพื่อตรวจสอบว่ามี column ที่ระบุหรือเปล่า
		ls_coltype	= ads_requestor.describe( ls_column+".ColType")
		
		// ถ้าไม่มี column ที่ระบุ (บน WebData ให้ข้ามไป)
		if ls_coltype = "!" then
			continue
		end if
		
		// ตรวจสอบข้อมูล
		if ll_startdata = ll_posend then
			setnull( la_data )
			ads_requestor.setitem( ll_row, ls_column, la_data )
		else
			// ตรวจสอบ Column ว่าเป็น Datatype แบบไหน
			// Fix Bug 2011-05-04 ปรับเป็นตัวแปรของใครของมัน
			// แก้ไขแทนของเดิมที่เป็นตัวแปรแบบ Any 
			// จิงๆ Any ก็ใช้ได้แต่เจอปัญหาที่ type datetime ซึ่งมีเวลาติดมาด้วย
			choose case lower( left( ls_coltype, 5 ) )
				case "char(", "char"
					ads_requestor.setitem( ll_row, ls_column, ls_puredata )
				case "date"
					ld_data		= date( ls_puredata )
					ads_requestor.setitem( ll_row, ls_column, ld_data )
				case "datet"
					ld_data		= date( left( ls_puredata, 10 ) )
					lt_data		= time( mid( ls_puredata, 12, 8 ) )
					ldtm_data	= datetime( ld_data, lt_data )
					ads_requestor.setitem( ll_row, ls_column, ldtm_data )
				case "decim"
					ldc_data		= dec( ls_puredata )
					ads_requestor.setitem( ll_row, ls_column, ldc_data )
				case "numbe", "long", "ulong", "real", "int"
					ldc_data		= dec( ls_puredata )
					ads_requestor.setitem( ll_row, ls_column, ldc_data )
				case else
					setnull( la_data )
					ads_requestor.setitem( ll_row, ls_column, la_data )
			end choose
		end if
	loop until len( ls_rowdata ) <= 0
	
	if len( ls_alldata ) = 0 then
		exit
	end if
	
	ll_posend	= pos( ls_alldata, "</iscxml_data_row>" )
loop

return ll_count
end function

private function string of_globalreplace (string as_source, string as_old, string as_new, boolean ab_ignorecase);Long	ll_Start
Long	ll_OldLen
Long	ll_NewLen
String ls_Source

//Check parameters
If IsNull(as_source) or IsNull(as_old) or IsNull(as_new) or IsNull(ab_ignorecase) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

//Get the string lenghts
ll_OldLen = Len(as_Old)
ll_NewLen = Len(as_New)

//Should function respect case.
If ab_ignorecase Then
	as_old = Lower(as_old)
	ls_source = Lower(as_source)
Else
	ls_source = as_source
End If

//Search for the first occurrence of as_Old
ll_Start = Pos(ls_Source, as_Old)

Do While ll_Start > 0
	// replace as_Old with as_New
	as_Source = Replace(as_Source, ll_Start, ll_OldLen, as_New)
	
	//Should function respect case.
	If ab_ignorecase Then 
		ls_source = Lower(as_source)
	Else
		ls_source = as_source
	End If
	
	// find the next occurrence of as_Old
	ll_Start = Pos(ls_Source, as_Old, (ll_Start + ll_NewLen))
Loop

Return as_Source
end function

private function long of_importdataweb (ref DataWindow adw_requestor, string as_xmltext) throws Exception;string		ls_detail, ls_dwobject, ls_webtable, ls_alldata, ls_column, ls_rowdata, ls_puredata, ls_coltype
long		ll_postag, ll_posend, ll_startdata, ls_lendata, ll_posspc
long		ll_count, ll_row, ll_lendata
integer	li_colcount, li_colindex
any		la_data
dec		ldc_data
date		ld_data
time		lt_data
datetime	ldtm_data

ls_detail		= as_xmltext

// DW Object
ll_postag		= pos( ls_detail, "<iscxml_data_table" )
ll_posend	= pos( ls_detail, ">", ll_postag )
ls_dwobject	= mid( ls_detail, ll_postag, ll_posend - ll_postag + 1 )
ls_detail		= mid( ls_detail, ll_posend + 1 )

// ALL Data
ll_postag		= pos( ls_detail, "<" )
ll_posend	= pos( ls_detail, "</iscxml_data_table>" )
ls_alldata	= mid( ls_detail, ll_postag, ll_posend - ll_postag )

// Row Data
ll_postag		= pos( ls_alldata, "<iscxml_data_row>" )
ll_posend	= pos( ls_alldata, "</iscxml_data_row>" )

do while ll_posend > 0
	ll_startdata	= ll_postag + len( "<iscxml_data_row>" )
	ll_lendata	= ll_posend - ll_startdata
	
	ls_rowdata	= mid( ls_alldata, ll_startdata, ll_lendata )
	ls_alldata	= mid( ls_alldata, ( ll_posend + len( "</iscxml_data_row>" ) ) )
	
	ll_row			= adw_requestor.insertrow( 0 )
	ll_count++
	
	// วนลูปใส่ข้อมูลให้ dw
	do
		// column
		ll_postag		= pos( ls_rowdata, "<" )
		ll_posend	= pos( ls_rowdata, ">", ll_postag )
		ls_column	= mid( ls_rowdata, ll_postag + 1, ll_posend - ll_postag - 1 )
		
		// tag ของ webdata มันไม่ใช่ชื่ออย่างเดียวหาช่องว่างเพื่อเอาชื่ออย่างเดียว
		ll_posspc		= pos( ls_column, " " )
		if ll_posspc > 0 then
			ls_column	= mid( ls_column, 1, ll_posspc - 1 )
		end if
		
		// data
		ll_startdata	= ll_posend + 1
		ll_posend	= pos( ls_rowdata, "</"+ls_column )
		ls_puredata	= mid( ls_rowdata, ll_startdata, ll_posend - ll_startdata )
		
		// ข้อมุลใน row ที่เหลือ
		ls_rowdata	= mid( ls_rowdata, ll_posend + len( "</"+ls_column+">" ) )
		
		if ls_column = "row_status" then
			continue
		end if
		
		// Check column เพื่อตรวจสอบว่ามี column ที่ระบุหรือเปล่า
		ls_coltype	= adw_requestor.describe( ls_column+".ColType")
		
		// ถ้าไม่มี column ที่ระบุ (บน WebData ให้ข้ามไป)
		if ls_coltype = "!" then
			continue
		end if
		
		// ตรวจสอบข้อมูล
		if ll_startdata = ll_posend then
			setnull( la_data )
			adw_requestor.setitem( ll_row, ls_column, la_data )
		else
			// ตรวจสอบ Column ว่าเป็น Datatype แบบไหน
			// Fix Bug 2011-05-04 ปรับเป็นตัวแปรของใครของมัน
			// แก้ไขแทนของเดิมที่เป็นตัวแปรแบบ Any 
			// จิงๆ Any ก็ใช้ได้แต่เจอปัญหาที่ type datetime ซึ่งมีเวลาติดมาด้วย
			choose case lower( left( ls_coltype, 5 ) )
				case "char(", "char"
					adw_requestor.setitem( ll_row, ls_column, ls_puredata )
				case "date"
					ld_data		= date( ls_puredata )
					adw_requestor.setitem( ll_row, ls_column, ld_data )
				case "datet"
					ld_data		= date( left( ls_puredata, 10 ) )
					lt_data		= time( mid( ls_puredata, 12, 8 ) )
					ldtm_data	= datetime( ld_data, lt_data )
					adw_requestor.setitem( ll_row, ls_column, ldtm_data )
				case "decim"
					ldc_data		= dec( ls_puredata )
					adw_requestor.setitem( ll_row, ls_column, ldc_data )
				case "numbe", "long", "ulong", "real", "int"
					ldc_data		= dec( ls_puredata )
					adw_requestor.setitem( ll_row, ls_column, ldc_data )
				case else
					setnull( la_data )
					adw_requestor.setitem( ll_row, ls_column, la_data )
			end choose
		end if
	loop until len( ls_rowdata ) <= 0
	
	if len( ls_alldata ) = 0 then
		exit
	end if
	
	ll_posend	= pos( ls_alldata, "</iscxml_data_row>" )
loop

return ll_count
end function

private function long of_importdatadw (ref DataWindow adw_requestor, string as_xmltext, boolean ab_chksourcecol, boolean ab_chkdestcol) throws Exception;string		ls_detail, ls_dwobject, ls_alldata, ls_rowdata, ls_column, ls_coltype, ls_puredata
long		ll_postag, ll_posend, ll_startdata, ll_lendata, ll_row, ll_count
integer	li_colcount, li_colindex
any		la_data
dec		ldc_data
date		ld_data
time		lt_data
datetime	ldtm_data

Exception	lthw_imperr

lthw_imperr		= create Exception
ll_count			= 0

ls_detail			= as_xmltext

// DW Object
ll_postag		= pos( ls_detail, "<" )
ll_posend	= pos( ls_detail, ">" )
ls_dwobject	= mid( ls_detail, ll_postag + 1, ll_posend - ll_postag - 1 )
ls_detail		= mid( ls_detail, ll_posend + 1 )

// ALL Data
ll_postag		= pos( ls_detail, "<" )
ll_posend	= pos( ls_detail, "</"+ls_dwobject+">" )
ls_alldata	= mid( ls_detail, ll_postag, ll_posend - ll_postag )

// ดูว่าต้องตรวจต้นทาง ว่ามี Column เท่ากับปลายทางหรือเปล่า
if ab_chkdestcol then
	li_colcount	= integer( adw_requestor.describe("DataWindow.Column.Count") )
	
	for li_colindex = 1 to li_colcount
		ls_column	= adw_requestor.describe( "#"+string( li_colindex )+".Name")
		
		ll_postag		= pos( ls_alldata, ls_column )
		
		if ll_postag <= 0 then
			lthw_imperr.text	= "XML ที่ส่งมาให้ไม่มี Column ("+ls_column+") ซึ่งอาจทำให้ฝั่งรับข้อมูลไปทำงานต่อ อาจจะทำงานไม่สมบูรณ์ได้ กรุณาตรวจสอบ"
			throw lthw_imperr
		end if
	next
	
end if

// Row Data
ll_postag		= pos( ls_alldata, "<"+ls_dwobject+"_row>" )
ll_posend	= pos( ls_alldata, "</"+ls_dwobject+"_row>" )

do while ll_posend > 0
	ll_startdata	= ll_postag + len( ls_dwobject ) + 6
	ll_lendata	= ll_posend - ll_startdata
	
	ls_rowdata	= mid( ls_alldata, ll_startdata, ll_lendata )
	ls_alldata	= mid( ls_alldata, ( ll_posend + len( "</"+ls_dwobject+"_row>" ) ) )
	
	ll_row			= adw_requestor.insertrow( 0 )
	ll_count++
	
	// วนลูปใส่ข้อมูลให้ dw
	do
		// column
		ll_postag		= pos( ls_rowdata, "<" )
		ll_posend	= pos( ls_rowdata, ">" )
		ls_column	= mid( ls_rowdata, ll_postag + 1, ll_posend - ll_postag - 1 )
		
		// data
		ll_startdata	= ll_posend + 1
		ll_posend	= pos( ls_rowdata, "</"+ls_column )
		ls_puredata	= mid( ls_rowdata, ll_startdata, ll_posend - ll_startdata )
		
		// ข้อมุลใน row ที่เหลือ
		ls_rowdata	= mid( ls_rowdata, ll_posend + len( "</"+ls_column+">" ) )
		
		// Check column เพื่อตรวจสอบว่ามี column ที่ระบุหรือเปล่า
		ls_coltype	= adw_requestor.describe( ls_column+".ColType")
		
		// ถ้าไม่มี column ที่ระบุ
		if ls_coltype = "!" then
			if ab_chksourcecol then
				lthw_imperr.text	= "Column ("+ls_column+") ไม่มีในฝั่งรับกรุณาตรวจสอบด้วย Service จะหยุดการนำเข้าเพียงเท่านี้"
				throw lthw_imperr
			else
				continue
			end if
		end if
		
		// ตรวจสอบข้อมูล
		if ll_startdata = ll_posend then
			setnull( la_data )
			adw_requestor.setitem( ll_row, ls_column, la_data )
		else
			// ตรวจสอบ Column ว่าเป็น Datatype แบบไหน
			// Fix Bug 2011-05-04 ปรับเป็นตัวแปรของใครของมัน
			// แก้ไขแทนของเดิมที่เป็นตัวแปรแบบ Any 
			// จิงๆ Any ก็ใช้ได้แต่เจอปัญหาที่ type datetime ซึ่งมีเวลาติดมาด้วย
			choose case lower( left( ls_coltype, 5 ) )
				case "char(", "char"
					adw_requestor.setitem( ll_row, ls_column, ls_puredata )
				case "date"
					ld_data		= date( ls_puredata )
					adw_requestor.setitem( ll_row, ls_column, ld_data )
				case "datet"
					ld_data		= date( left( ls_puredata, 10 ) )
					lt_data		= time( mid( ls_puredata, 12, 8 ) )
					ldtm_data	= datetime( ld_data, lt_data )
					adw_requestor.setitem( ll_row, ls_column, ldtm_data )
				case "decim"
					ldc_data		= dec( ls_puredata )
					adw_requestor.setitem( ll_row, ls_column, ldc_data )
				case "numbe", "long", "ulong", "real", "int"
					ldc_data		= dec( ls_puredata )
					adw_requestor.setitem( ll_row, ls_column, ldc_data )
				case else
					setnull( la_data )
					adw_requestor.setitem( ll_row, ls_column, la_data )
			end choose
		end if
	loop until len( ls_rowdata ) <= 0
	
	if len( ls_alldata ) = 0 then
		exit
	end if
	
	ll_posend	= pos( ls_alldata, "</"+ls_dwobject+"_row>" )
loop

return ll_count
end function

on n_cst_dwxmlieservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_dwxmlieservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on
