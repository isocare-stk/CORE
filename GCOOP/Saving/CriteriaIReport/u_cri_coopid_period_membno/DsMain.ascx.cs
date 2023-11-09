using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CoreSavingLibrary;
using System.Data;

namespace Saving.CriteriaIReport.u_cri_coopid_period_membno
{
    public partial class DsMain : DataSourceFormView
    {
        public DataSet1.DataTable1DataTable DATA { get; set; }
        public void InitDsMain(PageWeb pw)
        {
            css1.Visible = false;
            DataSet1 ds = new DataSet1();
            this.DATA = ds.DataTable1;
            this.EventItemChanged = "OnDsMainItemChanged";
            this.EventClicked = "OnDsMainClicked";
            this.InitDataSource(pw, FormView1, this.DATA, "dsMain");
            this.Register();
        }

        public void DdCoopId()
        {
            String sql = @"select coop_id, coop_name from cmcoopmaster ";
            DataTable dt = WebUtil.Query(sql);
            this.DropDownDataBind(dt, "coop_id", "coop_name", "coop_id");
        }

        public void DdSEmpno()
        {
            string sql = @"select mb.member_no as start_empno,
                mb.member_no+'-'+pn.prename_desc + mb.memb_name + '  ' + mb.memb_surname as semp_name,
                1 as sorter
                from mbmembmaster mb, mbucfprename pn 
                where mb.prename_code = pn.prename_code
                union
                select '','',0 
                order by sorter, member_no"
            ;
            sql = WebUtil.SQLFormat(sql);
            this.DropDownDataBind(sql, "start_empno", "semp_name", "start_empno");
        }
        public void DdEmpno()
        {
            string sql = @"select mb.member_no as end_empno,
                 mb.member_no+'-'+pn.prename_desc + mb.memb_name + '  ' + mb.memb_surname as eemp_name,
                1 as sorter
                from mbmembmaster mb, mbucfprename pn 
                where mb.prename_code = pn.prename_code
                union
                select '','',0
                order by sorter, member_no"
            ;
            sql = WebUtil.SQLFormat(sql);
            this.DropDownDataBind(sql, "end_empno", "eemp_name", "end_empno");
        }
    }
}