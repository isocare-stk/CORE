using System.ServiceModel; 
using System.Runtime.Serialization; 
using System.Net.Security; 
using System.ServiceModel.Web; 
using System.ServiceModel.Activation; 
using System.Transactions; 
using Sybase.PowerBuilder.WCFNVO; 
namespace pbservice125
{
	[System.Diagnostics.DebuggerStepThrough]
	[ServiceContract(Name="n_budget",Namespace="http://tempurl.org")]
	public class n_budget : System.IDisposable 
	{
		internal pbservice125.c__n_budget __nvo__;
		private bool ____disposed____ = false;
		public void Dispose()
		{
			if (____disposed____)
				return;
			____disposed____ = true;
			c__pbservice125.InitSession(__nvo__.Session);
			Sybase.PowerBuilder.WPF.PBSession.CurrentSession.DestroyObject(__nvo__);
			c__pbservice125.RestoreOldSession();
		}
		public n_budget()
		{
			
			c__pbservice125.InitAssembly();
			__nvo__ = (pbservice125.c__n_budget)Sybase.PowerBuilder.WPF.PBSession.CurrentSession.CreateInstance(typeof(pbservice125.c__n_budget));
			c__pbservice125.RestoreOldSession();
		}
		internal n_budget(pbservice125.c__n_budget nvo)
		{
			__nvo__ = nvo;
		}
		[OperationContract(Name="of_test")]
		public virtual string of_test(string as_test)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			string __retval__;
			Sybase.PowerBuilder.PBString as_test__temp__;
			as_test__temp__ = new Sybase.PowerBuilder.PBString((string)as_test);
			__retval__ = ((pbservice125.c__n_budget)__nvo__).of_test(as_test__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_save_budget_year")]
		public virtual System.Int16 of_save_budget_year(string as_wspass, string as_budget_xml)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			System.Int16 __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBString as_budget_xml__temp__;
			as_budget_xml__temp__ = new Sybase.PowerBuilder.PBString((string)as_budget_xml);
			__retval__ = ((pbservice125.c__n_budget)__nvo__).of_save_budget_year(as_wspass__temp__, as_budget_xml__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_save_budget_type")]
		public virtual System.Int16 of_save_budget_type(string as_wspass, string as_budgettype_xml)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			System.Int16 __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBString as_budgettype_xml__temp__;
			as_budgettype_xml__temp__ = new Sybase.PowerBuilder.PBString((string)as_budgettype_xml);
			__retval__ = ((pbservice125.c__n_budget)__nvo__).of_save_budget_type(as_wspass__temp__, as_budgettype_xml__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_save_budget_group")]
		public virtual System.Int16 of_save_budget_group(string as_wspass, string as_budgetgroup_xml)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			System.Int16 __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBString as_budgetgroup_xml__temp__;
			as_budgetgroup_xml__temp__ = new Sybase.PowerBuilder.PBString((string)as_budgetgroup_xml);
			__retval__ = ((pbservice125.c__n_budget)__nvo__).of_save_budget_group(as_wspass__temp__, as_budgetgroup_xml__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_save_fromedit_pay")]
		public virtual System.Int16 of_save_fromedit_pay(string as_wspass, string as_cutpay_xml)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			System.Int16 __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBString as_cutpay_xml__temp__;
			as_cutpay_xml__temp__ = new Sybase.PowerBuilder.PBString((string)as_cutpay_xml);
			__retval__ = ((pbservice125.c__n_budget)__nvo__).of_save_fromedit_pay(as_wspass__temp__, as_cutpay_xml__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_get_year_budget")]
		public virtual System.Int16 of_get_year_budget(string as_wspass, System.DateTime adtm_date)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			System.Int16 __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBDateTime adtm_date__temp__;
			adtm_date__temp__ = new Sybase.PowerBuilder.PBDateTime((System.DateTime)adtm_date);
			__retval__ = ((pbservice125.c__n_budget)__nvo__).of_get_year_budget(as_wspass__temp__, adtm_date__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_save_budget_typeyear")]
		public virtual System.Int16 of_save_budget_typeyear(string as_wspass, string as_budgettypeyear_xml)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			System.Int16 __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBString as_budgettypeyear_xml__temp__;
			as_budgettypeyear_xml__temp__ = new Sybase.PowerBuilder.PBString((string)as_budgettypeyear_xml);
			__retval__ = ((pbservice125.c__n_budget)__nvo__).of_save_budget_typeyear(as_wspass__temp__, as_budgettypeyear_xml__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_close_month")]
		public virtual System.Int16 of_close_month(string as_wspass, System.Int16 ai_year, System.Int16 ai_month)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			System.Int16 __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBInt ai_year__temp__;
			ai_year__temp__ = new Sybase.PowerBuilder.PBInt((System.Int16)ai_year);
			Sybase.PowerBuilder.PBInt ai_month__temp__;
			ai_month__temp__ = new Sybase.PowerBuilder.PBInt((System.Int16)ai_month);
			__retval__ = ((pbservice125.c__n_budget)__nvo__).of_close_month(as_wspass__temp__, ai_year__temp__, ai_month__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_save_budget_groupyear")]
		public virtual System.Int16 of_save_budget_groupyear(string as_wspass, string as_budgetgroupyear_xml)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			System.Int16 __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBString as_budgetgroupyear_xml__temp__;
			as_budgetgroupyear_xml__temp__ = new Sybase.PowerBuilder.PBString((string)as_budgetgroupyear_xml);
			__retval__ = ((pbservice125.c__n_budget)__nvo__).of_save_budget_groupyear(as_wspass__temp__, as_budgetgroupyear_xml__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_get_bg_movment_year")]
		public virtual string of_get_bg_movment_year(string as_wspass, System.Int16 an_year, string as_group, string as_type)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			string __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBInt an_year__temp__;
			an_year__temp__ = new Sybase.PowerBuilder.PBInt((System.Int16)an_year);
			Sybase.PowerBuilder.PBString as_group__temp__;
			as_group__temp__ = new Sybase.PowerBuilder.PBString((string)as_group);
			Sybase.PowerBuilder.PBString as_type__temp__;
			as_type__temp__ = new Sybase.PowerBuilder.PBString((string)as_type);
			__retval__ = ((pbservice125.c__n_budget)__nvo__).of_get_bg_movment_year(as_wspass__temp__, an_year__temp__, as_group__temp__, as_type__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_get_bgtype_nonaccid")]
		public virtual string of_get_bgtype_nonaccid(string as_wspass)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			string __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			__retval__ = ((pbservice125.c__n_budget)__nvo__).of_get_bgtype_nonaccid(as_wspass__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
	}
} 