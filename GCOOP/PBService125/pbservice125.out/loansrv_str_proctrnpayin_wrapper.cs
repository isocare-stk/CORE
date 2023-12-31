using System.ServiceModel; 
using System.Runtime.Serialization; 
namespace Sybase.PowerBuilder.WCFNVO
{
	[DataContract]
	public struct str_proctrnpayin
	{
		internal str_proctrnpayin(c__str_proctrnpayin __x__)
		{
			CopyFrom(out this, __x__);
		}
		internal void CopyFrom(c__str_proctrnpayin __x__)
		{
			CopyFrom(out this, __x__);
		}
		[DataMember] 
		public string coop_id;
		[DataMember] 
		public string source_code;
		[DataMember] 
		public System.DateTime trans_date;
		[DataMember] 
		public string entry_id;
		[DataMember] 
		public string contcoop_id;
		[DataMember] 
		public string payinslip_startno;
		[DataMember] 
		public string payinslip_endno;
		internal void CopyTo(c__str_proctrnpayin __x__)
		{
			__x__.coop_id = coop_id;
			__x__.source_code = source_code;
			__x__.trans_date = trans_date;
			__x__.entry_id = entry_id;
			__x__.contcoop_id = contcoop_id;
			__x__.payinslip_startno = payinslip_startno;
			__x__.payinslip_endno = payinslip_endno;
		}
		internal static void CopyFrom(out str_proctrnpayin __this__, c__str_proctrnpayin __x__)
		{
			__this__.coop_id = __x__.coop_id;
			__this__.source_code = __x__.source_code;
			__this__.trans_date = __x__.trans_date;
			__this__.entry_id = __x__.entry_id;
			__this__.contcoop_id = __x__.contcoop_id;
			__this__.payinslip_startno = __x__.payinslip_startno;
			__this__.payinslip_endno = __x__.payinslip_endno;
		}
		public static explicit operator object[](str_proctrnpayin __this__)
		{
			return new object[] {
				__this__.coop_id
				,__this__.source_code
				,__this__.trans_date
				,__this__.entry_id
				,__this__.contcoop_id
				,__this__.payinslip_startno
				,__this__.payinslip_endno
			};
		}
	}
} 