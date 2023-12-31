using System.ServiceModel; 
using System.Runtime.Serialization; 
namespace Sybase.PowerBuilder.WCFNVO
{
	[DataContract]
	public struct str_money_return_xml
	{
		internal str_money_return_xml(c__str_money_return_xml __x__)
		{
			CopyFrom(out this, __x__);
		}
		internal void CopyFrom(c__str_money_return_xml __x__)
		{
			CopyFrom(out this, __x__);
		}
		[DataMember] 
		public string xml_option;
		[DataMember] 
		public string xml_main;
		[DataMember] 
		public string xml_detail;
		[DataMember] 
		public string xml_list;
		[DataMember] 
		public string xml_report_detail_mem;
		[DataMember] 
		public string xml_report_detail_grp;
		[DataMember] 
		public string xml_report_summary;
		internal void CopyTo(c__str_money_return_xml __x__)
		{
			__x__.xml_option = xml_option;
			__x__.xml_main = xml_main;
			__x__.xml_detail = xml_detail;
			__x__.xml_list = xml_list;
			__x__.xml_report_detail_mem = xml_report_detail_mem;
			__x__.xml_report_detail_grp = xml_report_detail_grp;
			__x__.xml_report_summary = xml_report_summary;
		}
		internal static void CopyFrom(out str_money_return_xml __this__, c__str_money_return_xml __x__)
		{
			__this__.xml_option = __x__.xml_option;
			__this__.xml_main = __x__.xml_main;
			__this__.xml_detail = __x__.xml_detail;
			__this__.xml_list = __x__.xml_list;
			__this__.xml_report_detail_mem = __x__.xml_report_detail_mem;
			__this__.xml_report_detail_grp = __x__.xml_report_detail_grp;
			__this__.xml_report_summary = __x__.xml_report_summary;
		}
		public static explicit operator object[](str_money_return_xml __this__)
		{
			return new object[] {
				__this__.xml_option
				,__this__.xml_main
				,__this__.xml_detail
				,__this__.xml_list
				,__this__.xml_report_detail_mem
				,__this__.xml_report_detail_grp
				,__this__.xml_report_summary
			};
		}
	}
} 