using System.ServiceModel; 
using System.Runtime.Serialization; 
namespace Sybase.PowerBuilder.WCFNVO
{
	[DataContract]
	public struct str_contlaw
	{
		internal str_contlaw(c__str_contlaw __x__)
		{
			CopyFrom(out this, __x__);
		}
		internal void CopyFrom(c__str_contlaw __x__)
		{
			CopyFrom(out this, __x__);
		}
		[DataMember] 
		public string member_no;
		[DataMember] 
		public string memcoop_id;
		[DataMember] 
		public System.DateTime change_date;
		[DataMember] 
		public string loancontract_no;
		[DataMember] 
		public string contcoop_id;
		[DataMember] 
		public string xml_main;
		[DataMember] 
		public string xml_detail;
		[DataMember] 
		public string entry_id;
		[DataMember] 
		public string coop_id;
		internal void CopyTo(c__str_contlaw __x__)
		{
			__x__.member_no = member_no;
			__x__.memcoop_id = memcoop_id;
			__x__.change_date = change_date;
			__x__.loancontract_no = loancontract_no;
			__x__.contcoop_id = contcoop_id;
			__x__.xml_main = xml_main;
			__x__.xml_detail = xml_detail;
			__x__.entry_id = entry_id;
			__x__.coop_id = coop_id;
		}
		internal static void CopyFrom(out str_contlaw __this__, c__str_contlaw __x__)
		{
			__this__.member_no = __x__.member_no;
			__this__.memcoop_id = __x__.memcoop_id;
			__this__.change_date = __x__.change_date;
			__this__.loancontract_no = __x__.loancontract_no;
			__this__.contcoop_id = __x__.contcoop_id;
			__this__.xml_main = __x__.xml_main;
			__this__.xml_detail = __x__.xml_detail;
			__this__.entry_id = __x__.entry_id;
			__this__.coop_id = __x__.coop_id;
		}
		public static explicit operator object[](str_contlaw __this__)
		{
			return new object[] {
				__this__.member_no
				,__this__.memcoop_id
				,__this__.change_date
				,__this__.loancontract_no
				,__this__.contcoop_id
				,__this__.xml_main
				,__this__.xml_detail
				,__this__.entry_id
				,__this__.coop_id
			};
		}
	}
} 