$PBExportHeader$n_cst_xml.sru
$PBExportComments$XML Parser v.3.0.1 from ATM kernel to PBService.
forward
global type n_cst_xml from n_cst_base
end type
end forward

global type n_cst_xml from n_cst_base
end type
global n_cst_xml n_cst_xml

type variables
Public:	

constant	string version		= "3.0.1"
constant	string build			= string(ProfileInt(".\Builds.ini", "n_cst_xml", "build", 0) + 1)

constant	string XMLTypeNode		= "Node"
constant	string XMLTypeData		= "Data"

constant	string XMLTagOpen			= "<"
constant	string XMLTagClose			= ">"
constant	string XMLEndTagOpen		= "</"
constant	string XMLShortTagClose		= "/>"
constant	string XMLHdr			= "<?XML"
constant	string XMLTail			= "?>"
constant	string XMLCommentHdr		= "<!--"
constant	string XMLCommentTail		= "-->"
constant	string XMLDOCTYPEHdr		= "<!DOCTYPE"
constant	string XMLDOCTYPETail		= ">"
constant	string XMLSpecification		= "<?"

constant	string XMLTextQuote		= '"'
constant	string XMLTextToken		= "+="
constant	string XMLTextAssign		= "="

string			Tag 		= ""
string			XMLType 	= XMLTypeData
string			Text 		= ""
string			AttributeName[]
string			AttributeValue[]
string			Comment[]
string			Specification[]	
n_cst_xml	Element[]

string			DOCType[]
string			ErrorText		= ""

string			XMLversion	= "1.0"
string			XMLencoding	= "iso-8859-1"
string			XMLstandalone	= ""


Protected:

long			LastFoundIndex		= 0
string			LastFoundTagNamed	= ""			//pz.ตั้งให้เป็น "" เพื่อเรียกฟังชั่น of_getnextelement ในครั้งแรกมีความหมายเท่ากับ of_getfirstelement.

string			nullStrings[]
n_cst_xml	nullElement
n_cst_xml	nullElements[]
//	char		WhiteSpace[]		= {char(9),char(13),char(10),char(32)}
string			EndOfLineChars		= char(13) + char(10)
string			TabChar			= char(9)

integer		TempBuild 		= SetProfileString(".\version.ini", "n_cst_xml", "build", string(ProfileInt(".\version.ini", "n_cst_xml", "build", 0) + 1))

string			Author			= "Prazit (R) Jitmanozot"
string			ContactEmail	= "gensoft.art@gmail.com"
string			License			= "Copyright (C) 2004 - 2011 Isocare System Co,.Ltd"

string			XMLKeywordsOpen[] 	= {XMLTextAssign, XMLTextQuote, XMLHdr, XMLCommentHdr, XMLDOCTYPEHdr, XMLSpecification, XMLEndTagOpen, XMLShortTagClose, XMLCommentTail, XMLTail, XMLTagOpen, XMLTagClose}
string			XMLKeywordsClose[] 	= {"", XMLTextQuote , "", XMLCommentTail, "", "", "", "", "", "", "", ""}
boolean		XMLNeedWhiteSpaceAfterKeywords[] = {false, false , true, true , true, false , false, false, false, false, false, false}
boolean		XMLDataKeywords[] 	= {false, true , false, true , false, true , false, false, false, false, false, true}

string			XMLEntities[] 		= {"&", "<", ">", '"', "'"}
string			XMLEscapeEntities[] 	= {"&amp;", "&lt;", "&gt;", "&quot;", "&apos;"}

end variables

forward prototypes
public function n_cst_xml getelement (string as_tagname)
public function n_cst_xml getelement (long al_index)
public function long gettotalelements ()
public function string getattributevalue (string as_attributename)
public subroutine reset ()
public subroutine deleteallelements ()
public subroutine deleteallattributes ()
public function string findattribute (long al_index)
public subroutine deleteattribute (string as_attributename)
public subroutine deleteattribute (long al_index)
public subroutine deleteelement (long al_index)
public subroutine deleteelement (string as_tagname)
public subroutine deleteelementnamed (string as_tagname)
public function n_cst_xml findelementnamed (string as_tagname)
public function n_cst_xml addelement (ref n_cst_xml aux_newelement)
public function n_cst_xml addelement (string as_tagname, string as_text)
public function n_cst_xml addelement (string as_tagname)
public function n_cst_xml getelementnamed (string as_tagname)
public function n_cst_xml getnextelement ()
public function long saveas (ref datawindow adw_obj, string as_tagname)
protected function date uf_string2date (string as_data, string as_format)
protected function datetime uf_string2datetime (string as_data, string as_format)
protected subroutine uf_addtab (ref string as_data)
protected subroutine uf_setitem (ref string as_columnname[], ref string as_columntype[], long ll_totalcolumns, ref datawindow adw_obj, long al_row, n_cst_xml aux_obj)
protected subroutine uf_setitem (datawindow adw_obj, long al_row, string as_columnname, string as_data, string as_columntype, string as_format)
public subroutine deleteelement (n_cst_xml aux_elementobj)
public function long saveas (ref datastore ads_obj, string as_tagname)
public function string generatexml (boolean ab_header)
public function string trimwhitespace (string as_data)
public function string righttrimwhitespace (string as_data)
public function string lefttrimwhitespace (string as_data)
protected function long uf_xml2token (string as_data, ref string as_result[])
protected function boolean uf_is_xml (ref string as_data[])
protected function long uf_scan_xmlheader (ref string as_data[], ref string as_version, ref string as_encoding, ref string as_standalone, long al_token_index)
protected function long uf_scan_definition (ref string as_data[], ref string as_comment[], ref string as_doctype[], ref string as_specification[], long al_token_index)
protected function string uf_implode (ref string as_data[], string as_delimeter)
protected function long uf_explode (ref string as_return[], string as_data, string as_delimeter)
protected function string uf_token2data (string as_data)
protected function boolean uf_is_data (string as_data)
protected function long uf_pos (ref string as_data[], ref string as_value[], long al_token_index, long al_last_token_index)
protected function long uf_pos_tagend (ref string as_data[], string as_tag, long al_token_index)
protected function long uf_scan_element (ref string as_data[], long al_token_index)
public function boolean createdatawindow (ref datawindow adw_obj)
public function long export (ref datawindow adw_obj, string as_tagname, boolean ab_reset_data)
public subroutine generatetreeviewitem (treeview atv_treeviewobject, long al_parenthandle)
protected function long uf_create_column_syntax (ref string as_table_column, ref string as_text_object, ref string as_column_object, ref long al_id, ref long al_x)
protected function string uf_replacetext (string as_data, string as_from, string as_to)
protected function string uf_xmlentities (string as_data)
public function long addattribute (string as_newattributename, string as_newattributevalue)
public function boolean loadxml (string as_xmldata)
end prototypes

public function n_cst_xml getelement (string as_tagname);return GetElementNamed(as_tagname)
end function

public function n_cst_xml getelement (long al_index);if al_index <= getTotalElements() then
	LastFoundIndex = al_index
	LastFoundTagNamed = Element[al_index].Tag
	return Element[al_index]
else
	return nullElement
end if
end function

public function long gettotalelements ();return Upperbound(Element)
end function

public function string getattributevalue (string as_attributename);long	ll_index, ll_total_attributes
//
as_attributename = upper(as_attributename)
ll_index = 1
ll_total_attributes = upperbound(AttributeName)
//
do while ll_index <= ll_total_attributes
	if upper(AttributeName[ll_index]) = as_attributename then
		return AttributeValue[ll_index]
	end if
	ll_index ++;
loop
return ""
end function

public subroutine reset ();Tag = ""
Text = ""
XMLType = XMLTypeData
// and more ...
//
deleteAllElements()
deleteAllAttributes()

end subroutine

public subroutine deleteallelements ();long	ll_total_elements
//
ll_total_elements = getTotalElements()
do while ll_total_elements > 0
	destroy Element[ll_total_elements]
	ll_total_elements --;
loop
Element = nullElements
end subroutine

public subroutine deleteallattributes ();AttributeName = nullStrings
AttributeValue = nullStrings

end subroutine

public function string findattribute (long al_index);long		ll_index, ll_total_attributes
string 	ls_attribute_name
//
ls_attribute_name = ""
ll_total_attributes = upperbound(AttributeName)
//
for ll_index = 1 to ll_total_attributes
	if ll_index = al_index then
		ls_attribute_name = AttributeName[ll_index]
		exit
	end if
next
return ls_attribute_name
end function

public subroutine deleteattribute (string as_attributename);long		ll_index, ll_total_attributes
string	ls_attribute_name[], ls_attribute_value[]
//
ls_attribute_name = AttributeName
ls_attribute_value = AttributeValue
deleteallattributes()
//
as_attributename = upper(as_attributename)
ll_total_attributes = upperbound(ls_attribute_name)
//
for ll_index = 1 to ll_total_attributes
	if upper(ls_attribute_name[ll_index]) <> as_attributename then
		addattribute(ls_attribute_name[ll_index], ls_attribute_value[ll_index])
	end if
next
end subroutine

public subroutine deleteattribute (long al_index);//return deleteattribute(findattribute(al_index))
long		ll_index, ll_total_attributes
string	ls_attribute_name[], ls_attribute_value[]
//
ls_attribute_name = AttributeName
ls_attribute_value = AttributeValue
deleteallattributes()
//
ll_total_attributes = upperbound(ls_attribute_name)
for ll_index = 1 to ll_total_attributes
	if ll_index <> al_index then
		addattribute(ls_attribute_name[ll_index], ls_attribute_value[ll_index])
	end if
next
end subroutine

public subroutine deleteelement (long al_index);if al_index <= getTotalElements() and al_index > 0 then
	deleteelement(Element[al_index])
end if
end subroutine

public subroutine deleteelement (string as_tagname);deleteElementNamed(as_tagname)
end subroutine

public subroutine deleteelementnamed (string as_tagname);long						ll_index, ll_total_elements, ll_new_index
n_cst_xml	lux_element[]
//
as_tagname = upper(as_tagname)
ll_total_elements = getTotalElements()
for ll_new_index = 1 to ll_total_elements
	if upper(Element[ll_index].Tag) <> as_tagname then
		lux_element[upperbound(lux_element) + 1] = Element[ll_index]
	else
		destroy Element[ll_index]
	end if
next
Element = lux_element
end subroutine

public function n_cst_xml findelementnamed (string as_tagname);if upper(Tag) = upper(as_tagname) then 
	return This
else
	n_cst_xml	lux_result
	long						ll_index
	long						ll_totals_elements
	//
	ll_totals_elements = getTotalElements()
	//
	for ll_index = 1 to ll_totals_elements
		lux_result = Element[ll_index].FindElementNamed(as_tagname)
		if isValid(lux_result) then
			exit
		end if
	next
	return lux_result
end if
end function

public function n_cst_xml addelement (ref n_cst_xml aux_newelement);if isValid(aux_newelement) then
	XMLType = XMLTypeNode;	
	Element[getTotalElements() + 1] = aux_newelement
else
	setnull(aux_newelement)
end if
return aux_newelement
end function

public function n_cst_xml addelement (string as_tagname, string as_text);n_cst_xml	XMLTemp
//
XMLTemp			= create n_cst_xml
XMLTemp.Tag		= as_tagname
XMLTemp.Text	= as_text
//
return addElement(XMLTemp)

end function

public function n_cst_xml addelement (string as_tagname);return addElement(as_tagname, "")

end function

public function n_cst_xml getelementnamed (string as_tagname);long						ll_index, ll_total_elements
n_cst_xml	lux_result
//
as_tagname = upper(as_tagname)
ll_index = 1
ll_total_elements = getTotalElements()
//
do while ll_index <= ll_total_elements
	if upper(Element[ll_index].Tag) = as_tagname or as_tagname = "" then
		LastFoundIndex = ll_index
		LastFoundTagNamed = as_tagname
		lux_result = Element[ll_index]
		exit
	end if
	ll_index ++;
loop
return lux_result
end function

public function n_cst_xml getnextelement ();long						ll_index, ll_total_elements
n_cst_xml	lux_result
//
ll_index = LastFoundIndex + 1
ll_total_elements = getTotalElements()
//
do while ll_index <= ll_total_elements
	if LastFoundTagNamed = "" or upper(Element[ll_index].Tag) = upper(LastFoundTagNamed) then
		LastFoundIndex = ll_index
		lux_result = Element[ll_index]
		exit
	end if
	ll_index ++;
loop
return lux_result
end function

public function long saveas (ref datawindow adw_obj, string as_tagname);// Obsolete function, please use Export() instead
return Export(adw_obj, as_tagname, true)
end function

protected function date uf_string2date (string as_data, string as_format);integer	li_day, li_month, li_year
string	ls_value[]
//
choose case lower(as_format)
	case 'yyyymmdd'
		li_month = integer(mid(as_data, 5, 2))
		li_day = integer(right(as_data, 2))
		li_year = integer(left(as_data, 4))
	case 'yyyy-mm-dd'
		uf_explode(ls_value, as_data, '-')
		li_month = integer(ls_value[2])
		li_day = integer(ls_value[3])
		li_year = integer(ls_value[1])
	case 'mm/dd/yy'
		uf_explode(ls_value, as_data, '/')
		li_month = integer(ls_value[1])
		li_day = integer(ls_value[2])
		li_year = integer(ls_value[3]) + 2000
	case 'mm/dd/yyyy'
		uf_explode(ls_value, as_data, '/')
		li_month = integer(ls_value[1])
		li_day = integer(ls_value[2])
		li_year = integer(ls_value[3])
	case 'dd/mm/yy'
		uf_explode(ls_value, as_data, '/')
		li_month = integer(ls_value[2])
		li_day = integer(ls_value[1])
		li_year = integer(ls_value[3]) + 2000
	case 'dd/mm/yyyy'
		uf_explode(ls_value, as_data, '/')
		li_month = integer(ls_value[2])
		li_day = integer(ls_value[1])
		li_year = integer(ls_value[3])
	case 'dd-mmm-yy'
		uf_explode(ls_value, as_data, '-')
		li_day = integer(ls_value[1])
		li_year = integer(ls_value[3]) + 2000
		choose case Upper(ls_value[2])
			case 'JAN'
				li_month = 1
			case 'FEB'
				li_month = 2
			case 'MAR'
				li_month = 3
			case 'APR'
				li_month = 4
			case 'MAY'
				li_month = 5
			case 'JUN'
				li_month = 6
			case 'JUL'
				li_month = 7
			case 'AUG'
				li_month = 8
			case 'SEP'
				li_month = 9
			case 'OCT'
				li_month = 10
			case 'NOV'
				li_month = 11
			case 'DEC'
				li_month = 12
		end choose
end choose
return date(li_year, li_month, li_day)
end function

protected function datetime uf_string2datetime (string as_data, string as_format);integer	li_day, li_month, li_year
integer li_hour, li_min, li_sec
//
choose case lower(as_format)
	case 'yyyymmddhhmmss'
		li_month = integer(mid(as_data, 5, 2))
		li_day = integer(mid(as_data, 7, 2))
		li_year = integer(left(as_data, 4))
		li_hour = integer(mid(as_data, 9, 2))
		li_min = integer(mid(as_data, 11, 2))
		li_sec = integer(mid(as_data, 13, 2))
end choose
return datetime(date(li_year, li_month, li_day), time(li_hour, li_min, li_sec))
end function

protected subroutine uf_addtab (ref string as_data);as_data = uf_replacetext(TabChar + as_data, EndOfLineChars, EndOfLineChars + TabChar)
end subroutine

protected subroutine uf_setitem (ref string as_columnname[], ref string as_columntype[], long ll_totalcolumns, ref datawindow adw_obj, long al_row, n_cst_xml aux_obj);if isvalid(adw_obj) then
	long ll_columnindex
	for ll_columnindex = 1 to ll_totalcolumns
		uf_setitem(adw_obj, al_row, as_columnname[ll_columnindex], aux_obj.getAttributeValue(as_columnname[ll_columnindex]), as_columntype[ll_columnindex], adw_obj.Describe(as_columnname[ll_columnindex] + ".Format"))
		if upper(as_columnname[ll_columnindex]) = upper(aux_obj.Tag) then
			uf_setitem(adw_obj, al_row, as_columnname[ll_columnindex], aux_obj.text, as_columntype[ll_columnindex], adw_obj.Describe(as_columnname[ll_columnindex] + ".Format"))
		end if
	next		
end if
end subroutine

protected subroutine uf_setitem (datawindow adw_obj, long al_row, string as_columnname, string as_data, string as_columntype, string as_format);/*
	04-Mar-2003	Fixed bug: It does nothing if datatype is long, ulong
					Thanks to Alexander P.Proskurin
*/		
if isvalid(adw_obj) and as_data <> "" then
	choose case as_columntype
		case "lo","ul"
			adw_obj.setItem(al_row, as_columnname, Long(as_data))
		case "ch","va"
			adw_obj.setItem(al_row, as_columnname, as_data)
		case "nu","de"
			adw_obj.setItem(al_row, as_columnname, double(as_data))
		case "da"
			string	ls_format
			ls_format = adw_obj.describe(as_columnname + ".Format")
			if ls_format <> "?" then
				if pos(ls_format, 'h') > 0 then
					adw_obj.SetItem(al_row, as_columnname, uf_string2datetime(as_data, as_format))
				else
					adw_obj.SetItem(al_row, as_columnname, uf_string2date(as_data, as_format))
				end if
			end if
	end choose
end if

end subroutine

public subroutine deleteelement (n_cst_xml aux_elementobj);long						ll_index, ll_total_elements
n_cst_xml	lux_element[]
//
ll_total_elements = getTotalElements()
for ll_index = 1 to ll_total_elements
	if Element[ll_index] <> aux_elementobj then
		lux_element[upperbound(lux_element) + 1] = Element[ll_index]
	else
		destroy Element[ll_index]
	end if
next
Element = lux_element
end subroutine

public function long saveas (ref datastore ads_obj, string as_tagname);// Obsoleted Function
return 0
end function

public function string generatexml (boolean ab_header);/*
	04-May-2003	use function uf_xml_entities() to escape some entities in Text and Attribute Value.
					by Yuthasak Buasuwan
*/
string	ls_result
if ab_header then 
	ls_result = lower(XMLHdr)
	if XMLversion <> '' then ls_result += ' version="' + XMLversion + '"' 
	if XMLencoding <> '' then ls_result += ' encoding="' + XMLencoding + '"'  
	if XMLstandalone <> '' then ls_result += ' standalone="' + XMLstandalone + '"'  
	ls_result += XMLTail + EndOfLineChars
end if
// specification
long	ll_spec_index
ll_spec_index = 1
do while ll_spec_index <= upperbound(Specification)
	ls_result += XMLSpecification + Specification[ll_spec_index] + XMLTail + EndOfLineChars
	ll_spec_index ++;
loop
// comments
long	ll_comment_index
ll_comment_index = 1
do while ll_comment_index <= upperbound(Comment)
	ls_result += XMLCommentHdr + ' ' + trim(Comment[ll_comment_index]) + ' ' + XMLCommentTail + EndOfLineChars
	ll_comment_index ++;
loop
// doc type
if upperbound(DOCType) > 0 then
	ls_result += XMLDOCTYPEHdr + ' ' + uf_implode(DOCType, ' ') + XMLDOCTYPETail + EndOfLineChars
end if
//
if Tag <> '' then
	ls_result += XMLTagOpen + Tag
	long		ll_index, ll_total_attributes, ll_total_elements
	ll_total_elements = getTotalElements()
	ll_total_attributes = upperbound(AttributeName)
	//
	for ll_index = 1 to ll_total_attributes
		ls_result += ' ' + AttributeName[ll_index] + '="' + uf_xmlentities(AttributeValue[ll_index]) + '"'
	next
	if Text = "" and ll_total_elements = 0 then
		ls_result += XMLShortTagClose
	else
		ls_result += XMLTagClose + uf_xmlentities(Text)
		//
		for ll_index = 1 to ll_total_elements
			string	ls_sub_xml
			ls_sub_xml = Element[ll_index].generateXML(false)
			uf_addtab(ls_sub_xml)
			ls_result += EndOfLineChars + ls_sub_xml
		next
		//
		if XMLType <> XMLTypeNode then
			ls_result += XMLEndTagOpen + Tag + XMLTagClose
		else
			ls_result += EndOfLineChars + XMLEndTagOpen + Tag + XMLTagClose
		end if
	end if
end if
return ls_result
end function

public function string trimwhitespace (string as_data);//
as_data = trim(as_data)
if len(as_data) > 0 then
	long	ll_index, ll_lenstring
	ll_index = 1
	ll_lenstring = len(as_data)
	//
	do while ll_index <= ll_lenstring
		if asc(mid(as_data, ll_index, 1)) <= 32 then
			ll_index ++;
		else
			exit
		end if
	loop
	if ll_index > 1 then as_data = right(as_data, ll_lenstring - ll_index + 1)
	//
	ll_lenstring = len(as_data)
	do while ll_lenstring > 0
		if asc(mid(as_data, ll_lenstring, 1)) <= 32 then
			ll_lenstring --;
		else
			exit
		end if
	loop
	if ll_lenstring >= 0 then
		as_data = left(as_data, ll_lenstring)
	end if
end if
return as_data
end function

public function string righttrimwhitespace (string as_data);//
if len(as_data) > 0 then
	long	ll_index, ll_lenstring
	//
	ll_lenstring = len(as_data)
	do while ll_lenstring > 0
		if asc(mid(as_data, ll_lenstring, 1)) <= 32 then
			ll_lenstring --;
		else
			exit
		end if
	loop
	if ll_lenstring >= 0 then
		as_data = left(as_data, ll_lenstring)
	end if
end if
return as_data
end function

public function string lefttrimwhitespace (string as_data);//
if len(as_data) > 0 then
	long	ll_index, ll_lenstring
	ll_index = 1
	ll_lenstring = len(as_data)
	//
	do while ll_index <= ll_lenstring
		if asc(mid(as_data, ll_index, 1)) <= 32 then
			ll_index ++;
		else
			exit
		end if
	loop
	if ll_index > 1 then as_data = right(as_data, ll_lenstring - ll_index + 1)
end if
return as_data
end function

protected function long uf_xml2token (string as_data, ref string as_result[]);/*
	23-Dec-2003	Fix bug: 
					"The problem is when you have the ='s sign in the text between tags (ex. this text=more text),
					the parser mistakenly tokenizes this and you lose all the text after the ='s. ..."
					Thanks to Jim Ward (Cont, ARL/ARO).

*/		
as_result = nullStrings

string	ls_state, ls_uppercase_data, ls_test_char
string	ls_state_key = "KEY"
string	ls_state_data = "DATA"
boolean	lb_data_stream
long		ll_index, ll_len_string, ll_keyword_index, ll_keyword_count, ll_token_index

ll_keyword_count = upperbound(XMLKeywordsOpen)
ls_uppercase_data = upper(as_data)
ll_len_string = len(as_data)

ls_state = ls_state_key
lb_data_stream = false
ll_token_index = 0
ll_index = 1

do while ll_index <= ll_len_string
	ls_test_char = mid(as_data, ll_index, 1)
	if asc(ls_test_char) <= 32 and ls_state = ls_state_key then
		ll_index ++;
	elseif asc(ls_test_char) <= 32 and ls_state = ls_state_data and not lb_data_stream then
		ls_state = ls_state_key
		ll_index ++;
	else
		for ll_keyword_index = 1 to ll_keyword_count
			if mid(ls_uppercase_data, ll_index, len(XMLKeywordsOpen[ll_keyword_index])) = XMLKeywordsOpen[ll_keyword_index] then
				// Added by Jim
				boolean	lb_tag
				if mid(XMLKeywordsOpen[ll_keyword_index], len(XMLKeywordsOpen[ll_keyword_index]), 1) = ">" then
					lb_tag = false
				elseif mid(XMLKeywordsOpen[ll_keyword_index], 1, 1) = "<" then
					lb_tag = true
				end if
				if (not lb_tag and XMLKeywordsOpen[ll_keyword_index] = "=") then
					continue
				end if 
				// End of added code 

				if XMLNeedWhiteSpaceAfterKeywords[ll_keyword_index] then
					if asc(mid(as_data, ll_index + len(XMLKeywordsOpen[ll_keyword_index]), 1)) <= 32 then exit
				else
					exit
				end if
			end if
		next
		if ll_keyword_index > ll_keyword_count then
			if ls_state = ls_state_key then
				ll_token_index ++
				as_result[ll_token_index] = XMLTextToken
				ls_state = ls_state_data
			end if
			as_result[ll_token_index] += ls_test_char
			ll_index ++;
		else
			lb_data_stream = XMLDataKeywords[ll_keyword_index]
			ll_token_index ++
			as_result[ll_token_index] = XMLKeywordsOpen[ll_keyword_index]
			ll_index += len(as_result[ll_token_index])
			ls_state = ls_state_key
			//
			if XMLKeywordsClose[ll_keyword_index] <> "" then
				long	ll_find_close
				ll_find_close = pos(ls_uppercase_data, XMLKeywordsClose[ll_keyword_index], ll_index)
				if ll_find_close > 0 then
					ll_token_index ++
					as_result[ll_token_index] = mid(as_data, ll_index, ll_find_close - ll_index)
					ll_index += len(as_result[ll_token_index])
					//
					ll_token_index ++
					as_result[ll_token_index] = XMLKeywordsClose[ll_keyword_index]
					ll_index += len(XMLKeywordsClose[ll_keyword_index])
				end if
			end if
		end if
	end if
loop
return ll_token_index
end function

protected function boolean uf_is_xml (ref string as_data[]);// will be implemented in version 2.1.0
ErrorText = ""
return true
end function

protected function long uf_scan_xmlheader (ref string as_data[], ref string as_version, ref string as_encoding, ref string as_standalone, long al_token_index);as_version = ""
as_encoding = ""
as_standalone = ""
if upper(as_data[al_token_index]) = XMLHdr then
	al_token_index ++;
	do while as_data[al_token_index] <> XMLTail
		choose case upper(as_data[al_token_index])
			case XMLTextToken + 'VERSION'
				as_version = as_data[al_token_index + 3]
				al_token_index += 5;
			case XMLTextToken + 'ENCODING'
				as_encoding = as_data[al_token_index + 3]
				al_token_index += 5;
			case XMLTextToken + 'STANDALONE'
				as_standalone = as_data[al_token_index + 3]
				al_token_index += 5;
			case else
				al_token_index ++;
		end choose
	loop
	al_token_index ++;
end if
return al_token_index
end function

protected function long uf_scan_definition (ref string as_data[], ref string as_comment[], ref string as_doctype[], ref string as_specification[], long al_token_index);as_comment = nullStrings
as_doctype = nullStrings
as_specification = nullStrings
//
long	ll_total_tokens
ll_total_tokens = upperbound(as_data)
do while al_token_index <= ll_total_tokens
	if as_data[al_token_index] <> XMLTagOpen then
		choose case upper(as_data[al_token_index])
			case XMLCommentHdr
				as_comment[upperbound(as_comment) +  1] = as_data[al_token_index + 1]
				al_token_index += 3;
			case XMLDOCTYPEHdr
				al_token_index ++;
				do while as_data[al_token_index] <> XMLDOCTYPETail
					if as_data[al_token_index] <> XMLTextQuote then
						as_doctype[upperbound(as_doctype) + 1] = uf_token2data(as_data[al_token_index])
						al_token_index ++;
					else
						as_doctype[upperbound(as_doctype) + 1] = XMLTextQuote + as_data[al_token_index + 1] + XMLTextQuote
						al_token_index += 3;
					end if
				loop
			case XMLSpecification
				as_specification[upperbound(as_specification) +  1] = as_data[al_token_index + 1]
				al_token_index += 3;
			case else
				al_token_index ++;
		end choose
	else
		exit
	end if
loop
return al_token_index
end function

protected function string uf_implode (ref string as_data[], string as_delimeter);string	ls_result
ls_result = ""

long		ll_index, ll_count 
ll_count = upperbound(as_data)

for ll_index = 1 to ll_count
	if ls_result <> "" then ls_result += as_delimeter
	ls_result += as_data[ll_index]
next
return ls_result
end function

protected function long uf_explode (ref string as_return[], string as_data, string as_delimeter);as_return = NullStrings
long	ll_delimeter_len
ll_delimeter_len = len(as_delimeter)

if len(as_data) > 0 then
	long	ll_counter, ll_found_index, ll_next_index
	ll_found_index = 1
	//
   ll_next_index = pos(as_data, as_delimeter, ll_found_index)
   do while ll_next_index > 0
     	as_return[upperbound(as_return) + 1] = mid(as_data, ll_found_index, ll_next_index - ll_found_index)
      ll_found_index = ll_next_index + ll_delimeter_len
     	ll_next_index = pos(as_data, as_delimeter, ll_found_index)
	loop
	as_return[upperbound(as_return) + 1] = mid(as_data, ll_found_index, len(as_data))
end if
return upperbound(as_return)
end function

protected function string uf_token2data (string as_data);return right(as_data, len(as_data) - 2)
end function

protected function boolean uf_is_data (string as_data);if left(as_data, len(XMLTextToken)) = XMLTextToken then
	return true
else
	return false
end if
end function

protected function long uf_pos (ref string as_data[], ref string as_value[], long al_token_index, long al_last_token_index);if al_last_token_index = 0 then al_last_token_index = upperbound(as_data)

long	ll_index, ll_value_count
ll_value_count = upperbound(as_value)

do while al_token_index <= al_last_token_index
	if as_data[al_token_index] = as_value[1] then
		for ll_index = 2 to ll_value_count
			if as_data[al_token_index + ll_index - 1] <> as_value[ll_index] then exit
		next
		if ll_index > ll_value_count then exit
	end if
	al_token_index ++;
loop
if al_token_index > al_last_token_index then al_token_index = 0
return al_token_index
end function

protected function long uf_pos_tagend (ref string as_data[], string as_tag, long al_token_index);string	ls_value[]
ls_value[1] = XMLEndTagOpen
ls_value[2] = XMLTextToken	+ as_tag
ls_value[3] = XMLTagClose
return uf_pos(as_data, ls_value, al_token_index, 0)
end function

protected function long uf_scan_element (ref string as_data[], long al_token_index);long	ll_last_token_index
//
al_token_index = uf_scan_definition(as_data, Comment, DOCType, Specification, al_token_index)

if al_token_index <= upperbound(as_data) then
	if as_data[al_token_index] = XMLTagOpen then
		al_token_index ++;
		
		// tag name
		Tag = uf_token2data(as_data[al_token_index])
		al_token_index ++;
		
		// attribute(s)
		do while uf_is_data(as_data[al_token_index])
			addAttribute(uf_token2data(as_data[al_token_index]), as_data[al_token_index + 3])
			al_token_index += 5
		loop
	
		Text = ""
		XMLType = XMLTypeData
		// text or element(s)
		if as_data[al_token_index] <> XMLShortTagClose then
			if as_data[al_token_index] = XMLTagClose then
				al_token_index ++;
				if uf_is_data(as_data[al_token_index]) then
					// text
					Text = uf_token2data(as_data[al_token_index])
					al_token_index += 4
				else
					if as_data[al_token_index] = XMLEndTagOpen then
						al_token_index += 3
					else
						// more element(s)
						XMLType = XMLTypeNode
						
						long	ll_end_tag_index
						ll_end_tag_index = uf_pos_tagend(as_data, Tag, al_token_index)
						
						n_cst_xml	lux_element
							
						do while al_token_index < ll_end_tag_index
							lux_element = create n_cst_xml
							al_token_index = lux_element.uf_scan_element(as_data, al_token_index)
							if lux_element.Tag <> '' then addElement(lux_element)
						loop
	
						al_token_index = ll_end_tag_index + 3
					end if
				end if
			end if
		else
			al_token_index ++;
		end if
	end if
end if
return al_token_index
end function

public function boolean createdatawindow (ref datawindow adw_obj);string	ls_error_text,	ls_dwsyntax
boolean	lb_result
//
lb_result = false
if isvalid(adw_obj) then
	ls_dwsyntax	= 'release 6;' + &
					'datawindow(units=0 timer_interval=0 color=16777215 processing=1 print.documentname="" print.orientation = 0 print.margin.left = 110 print.margin.right = 110 print.margin.top = 96 print.margin.bottom = 96 print.paper.source = 0 print.paper.size = 0 print.prompt=no print.buttons=no print.preview.buttons=no )' + &
					'header(height=84 color="536870912" )' + &
					'summary(height=0 color="536870912" )' + &
					'footer(height=0 color="536870912" )' + &
					'detail(height=88 color="536870912" )' + &
					'table('
	//
	string	ls_table_column, ls_text_object, ls_column_object, ls_column_name, ls_last_tag
	long		ll_id, ll_x, ll_width
	n_cst_xml	lux_element
	lux_element = getElement("")
	ll_id = 1
	ll_x = 10
	ls_last_tag = ""
	do while isvalid(lux_element)
		if lux_element.Tag = ls_last_tag then exit
		ls_last_tag = lux_element.Tag
		lux_element.uf_create_column_syntax(ls_table_column, ls_text_object, ls_column_object, ll_id, ll_x)
		lux_element = getNextElement()
	loop
	ls_dwsyntax += ls_table_column + ' )' + ls_text_object +	ls_column_object
	ls_dwsyntax += 'htmltable(border="1" cellpadding="0" cellspacing="0" generatecss="no" nowrap="yes")'
	
	adw_obj.create(ls_dwsyntax, ls_error_text)
	if len(ls_error_text) = 0 then lb_result = true
end if
return lb_result
end function

public function long export (ref datawindow adw_obj, string as_tagname, boolean ab_reset_data);if isvalid(adw_obj) then
	if ab_reset_data then adw_obj.reset()
	//
	long		ll_total_columns
	long		ll_new_row, ll_total_new_row
	long		ll_column_index
	string	ls_columnname[]
	string	ls_columntype[]
	string	ls_data_text
	//
	ll_total_columns = long(adw_obj.object.DataWindow.Column.Count)
	for ll_column_index = 1 to ll_total_columns
		ls_columnname[ll_column_index] = adw_obj.Describe("#" + string(ll_column_index) + ".Name")
		ls_columntype[ll_column_index] = left(adw_obj.Describe("#" + string(ll_column_index) + ".ColType"), 2)
	next
	//
	n_cst_xml	lux_data, lux_root, lux_pk
	n_cst_xml	lux_parent, lux_item
	//	
	ll_total_new_row = 0
	if as_tagname <> '' then
		lux_root = getElementNamed(as_tagname)
		if isvalid(lux_root) then lux_data = lux_root.getElementNamed("")
	else
		// default is one XML record.
		lux_root = create n_cst_xml
		lux_root.addElement(lux_data)
		lux_data = this			

		// guess what type of XML structure
		n_cst_xml	lux_first_element, lux_second_element
		
		lux_first_element = getElement("")
		if lux_first_element.getTotalElements() > 0 then
			lux_second_element = getNextElement()
			if isvalid(lux_second_element) then
				if lux_first_element.Tag = lux_second_element.Tag then
					lux_root = this
					lux_data = getElement("")
				end if
			end if
		end if
	end if
	do while isvalid(lux_data)
		ll_total_new_row ++;
		ll_new_row = adw_obj.InsertRow(0)
		if as_tagname <> '' then
			uf_setitem(ls_columnname, ls_columntype, ll_total_columns, adw_obj, ll_new_row, this)
			lux_pk = getElementNamed("")
			do while isvalid(lux_pk) and lux_pk.Tag <> as_tagname
				uf_setitem(ls_columnname, ls_columntype, ll_total_columns, adw_obj, ll_new_row, lux_pk)
				lux_pk = getNextElement()
			loop
		end if
		uf_setitem(ls_columnname, ls_columntype, ll_total_columns, adw_obj, ll_new_row, lux_root)
		uf_setitem(ls_columnname, ls_columntype, ll_total_columns, adw_obj, ll_new_row, lux_data)
		//
		if lux_data.gettotalelements() > 0 then
			lux_parent = lux_data.getElementNamed("")
			do while isvalid(lux_parent)
				uf_setitem(ls_columnname, ls_columntype, ll_total_columns, adw_obj, ll_new_row, lux_parent)
				//
				if lux_parent.gettotalelements() > 0 then
					lux_item = lux_parent.getElementNamed("")
					do while isvalid(lux_item)
						uf_setitem(ls_columnname, ls_columntype, ll_total_columns, adw_obj, ll_new_row, lux_item)
						lux_item = lux_parent.getNextElement()
					loop
				end if
				lux_parent = lux_data.getNextElement()
			loop
		end if
		if isnull(lux_root) then exit
		lux_data = lux_root.getNextElement()
	loop
	return ll_total_new_row
end if
return 0
end function

public subroutine generatetreeviewitem (treeview atv_treeviewobject, long al_parenthandle);string	ls_tag_data
long		ll_index, ll_total_attributes, ll_totals_elements
long		ll_active_item
//
ll_totals_elements = getTotalElements()
ll_total_attributes = upperbound(AttributeName)
//
ls_tag_data = Tag
for ll_index = 1 to ll_total_attributes
	ls_tag_data += " " + AttributeName[ll_index] + '=' + AttributeValue[ll_index]
next
if al_parenthandle = 0 then
	ll_active_item = atv_treeviewobject.InsertItemLast(al_parenthandle, ls_tag_data, 3)
elseif ll_totals_elements > 0 then
	ll_active_item = atv_treeviewobject.InsertItemLast(al_parenthandle, ls_tag_data, 4)
else
	ll_active_item = atv_treeviewobject.InsertItemLast(al_parenthandle, ls_tag_data, 5)
end if
// specification
long	ll_spec_index
ll_spec_index = 1
do while ll_spec_index <= upperbound(Specification)
	atv_treeviewobject.InsertItemLast(ll_active_item, Specification[ll_spec_index], 2)
	ll_spec_index ++;
loop
// text
if Text <> "" then atv_treeviewobject.InsertItemLast(ll_active_item,Text, 6)
// comments
long	ll_comment_index
ll_comment_index = 1
do while ll_comment_index <= upperbound(Comment)
	atv_treeviewobject.InsertItemLast(ll_active_item, Comment[ll_comment_index], 1)
	ll_comment_index ++;
loop
// doc type
if upperbound(DOCType) > 0 then
	atv_treeviewobject.InsertItemLast(ll_active_item, uf_implode(DOCType, ' '), 2)
end if
//
for ll_index = 1 to ll_totals_elements
	Element[ll_index].generateTreeviewItem(atv_treeviewobject, ll_active_item)
next
end subroutine

protected function long uf_create_column_syntax (ref string as_table_column, ref string as_text_object, ref string as_column_object, ref long al_id, ref long al_x);long		ll_width
string	ls_column_name
//
if getTotalElements() = 0 then
	ls_column_name = Tag
	ll_width = len(ls_column_name)*50
	if len(Text) > len(ls_column_name) then ll_width = len(Text)*50

	as_table_column += 'column=(type=char(0) updatewhereclause=no name=' + ls_column_name + ' dbname="' + ls_column_name + '" )'
	as_text_object += 'text(band=header alignment="0" text="' + ls_column_name + '" border="0" color="0" x="' + string(al_x) + '" y="4" height="64" width="' + string(ll_width) + '" name=' + ls_column_name + '_t  font.face="Arial" font.height="-10" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912" )'
	as_column_object += 'column(band=detail id=' + string(al_id) + ' alignment="0" tabsequence=10 border="0" color="0" x="' + string(al_x) + '" y="4" height="76" width="' + string(ll_width) + '" format="[general]"  name=' + ls_column_name + ' edit.limit=0 edit.case=any edit.autoselect=yes  font.face="Arial" font.height="-10" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="16777215" )'
	
	al_id++;
	al_x += ll_width
end if
	
long		ll_index, ll_attribute_count
ll_attribute_count = upperbound(AttributeName)

for ll_index = 1 to ll_attribute_count
	ls_column_name = AttributeName[ll_index]
	ll_width = len(ls_column_name)*60

	as_table_column += 'column=(type=char(0) updatewhereclause=no name=' + ls_column_name + ' dbname="' + ls_column_name + '" )'
	as_text_object += 'text(band=header alignment="0" text="' + ls_column_name + '" border="0" color="0" x="' + string(al_x) + '" y="4" height="64" width="' + string(ll_width) + '" name=' + ls_column_name + '_t  font.face="Arial" font.height="-10" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912" )'
	as_column_object += 'column(band=detail id=' + string(al_id) + ' alignment="0" tabsequence=10 border="0" color="0" x="' + string(al_x) + '" y="4" height="76" width="' + string(ll_width) + '" format="[general]"  name=' + ls_column_name + ' edit.limit=0 edit.case=any edit.autoselect=yes  font.face="Arial" font.height="-10" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="16777215" )'
		
	al_id++;
	al_x += ll_width	
next

if getTotalElements() > 0 then
	string	ls_last_tag
	n_cst_xml	lux_element
	lux_element = getElement("")
	ls_last_tag = ""
	do while isvalid(lux_element)
		if lux_element.Tag = ls_last_tag then exit
		ls_last_tag = lux_element.Tag
		lux_element.uf_create_column_syntax(as_table_column, as_text_object, as_column_object, al_id, al_x)
		lux_element = getNextElement()
	loop
end if
return al_id
end function

protected function string uf_replacetext (string as_data, string as_from, string as_to);/*
	03-May-2003	Fixed problem of generating invalid XML. When entity contains special characters (&, < , > , ', ")
					- add function uf_replacetext(...),
					Thanks to Jawaid Maqbool
					
	04-May-2003	Fixed bug in do ... loop
					by Yuthasak Buasuwan
*/			
long	ll_len_from, ll_len_to
long	ll_index

ll_len_from = len(as_from)
ll_len_to = len(as_to)

ll_index = pos(as_data, as_from, 1)
do while ll_index > 0
	as_data = Replace(as_data, ll_index, ll_len_from, as_to)
	ll_index = pos(as_data, as_from, ll_index + ll_len_to + 1)
loop
return as_data
end function

protected function string uf_xmlentities (string as_data);/*
	03-May-2003	Fixed problem of generating invalid XML. When entity contains special characters (&, < , > , ', ")
					- add function uf_xmlentities(...)
					Thanks to Jawaid Maqbool
					
	04-May-2003	Modified and Fixed bug in for ... next
					by Yuthasak Buasuwan
*/		
long	ll_index, ll_total_entities
ll_total_entities = upperbound(XMLEntities)

for ll_index = 1 to ll_total_entities
	as_data = uf_replacetext(as_data, XMLEntities[ll_index], XMLEscapeEntities[ll_index])	
next

return as_data 
end function

public function long addattribute (string as_newattributename, string as_newattributevalue);long	ll_total_attributes
//
if isnull(as_newattributename) then as_newattributename = ""
if isnull(as_newattributevalue) then as_newattributevalue = ""
//
ll_total_attributes = upperbound(AttributeName)
ll_total_attributes ++
//
AttributeName[ll_total_attributes] = as_newattributename
AttributeValue[ll_total_attributes] = as_newattributevalue
//
return ll_total_attributes
end function

public function boolean loadxml (string as_xmldata);boolean	lb_result
lb_result = false

// - - ----- - - ----- - - ----- - - ----- - - ----- - - ----- - - ----- - - ----- - - -----
// prazit - เพิ่มการตรวจสอบกรณีไม่ใช่ข้อมูล XML .
// - - ----- - - ----- - - ----- - - ----- - - ----- - - ----- - - ----- - - ----- - - -----
as_xmldata	= trim(as_xmldata)
if( lower( left( as_xmldata, len(XMLHdr) ) ) <> lower( XMLHdr ) )then
	return false
end if
// - - ----- - - ----- - - ----- - - ----- - - ----- - - ----- - - ----- - - ----- - - -----

string	ls_xml_tokens[]
long		ll_total_token
ll_total_token = uf_xml2token(as_xmldata, ls_xml_tokens)

if ll_total_token > 0 and uf_is_xml(ls_xml_tokens) then
	uf_scan_element(ls_xml_tokens, uf_scan_xmlheader(ls_xml_tokens, XMLversion, XMLencoding, XMLstandalone, 1))
	lb_result = true
end if
return lb_result
end function

on n_cst_xml.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_xml.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;reset()
end event

