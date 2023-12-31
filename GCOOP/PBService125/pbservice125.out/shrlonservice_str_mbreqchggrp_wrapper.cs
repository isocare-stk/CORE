using System.ServiceModel; 
using System.Runtime.Serialization; 
namespace Sybase.PowerBuilder.WCFNVO
{
	[DataContract]
	public struct str_mbreqchggrp
	{
		internal str_mbreqchggrp(c__str_mbreqchggrp __x__)
		{
			CopyFrom(out this, __x__);
		}
		internal void CopyFrom(c__str_mbreqchggrp __x__)
		{
			CopyFrom(out this, __x__);
		}
		[DataMember] 
		public string member_no;
		[DataMember] 
		public string xml_reqopt;
		[DataMember] 
		public string xml_reqlist;
		[DataMember] 
		public string xml_reqdetail;
		[DataMember] 
		public string xml_reqhistory;
		[DataMember] 
		public string entry_id;
		[DataMember] 
		public string regchgdoc_no;
		[DataMember] 
		public string message;
		internal void CopyTo(c__str_mbreqchggrp __x__)
		{
			__x__.member_no = member_no;
			__x__.xml_reqopt = xml_reqopt;
			__x__.xml_reqlist = xml_reqlist;
			__x__.xml_reqdetail = xml_reqdetail;
			__x__.xml_reqhistory = xml_reqhistory;
			__x__.entry_id = entry_id;
			__x__.regchgdoc_no = regchgdoc_no;
			__x__.message = message;
		}
		internal static void CopyFrom(out str_mbreqchggrp __this__, c__str_mbreqchggrp __x__)
		{
			__this__.member_no = __x__.member_no;
			__this__.xml_reqopt = __x__.xml_reqopt;
			__this__.xml_reqlist = __x__.xml_reqlist;
			__this__.xml_reqdetail = __x__.xml_reqdetail;
			__this__.xml_reqhistory = __x__.xml_reqhistory;
			__this__.entry_id = __x__.entry_id;
			__this__.regchgdoc_no = __x__.regchgdoc_no;
			__this__.message = __x__.message;
		}
		public static explicit operator object[](str_mbreqchggrp __this__)
		{
			return new object[] {
				__this__.member_no
				,__this__.xml_reqopt
				,__this__.xml_reqlist
				,__this__.xml_reqdetail
				,__this__.xml_reqhistory
				,__this__.entry_id
				,__this__.regchgdoc_no
				,__this__.message
			};
		}
	}
} 