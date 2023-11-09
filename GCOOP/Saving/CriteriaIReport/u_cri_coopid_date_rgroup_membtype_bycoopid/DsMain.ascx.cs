﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CoreSavingLibrary;

namespace Saving.CriteriaIReport.u_cri_coopid_date_rgroup_membtype_bycoopid
{
    public partial class DsMain : DataSourceFormView
    {
        public DataSet1.DataTable1DataTable DATA { get; set; }

        public void InitDsMain(PageWeb pw)
        {
            css1.Visible = false;
            DataSet1 ds = new DataSet1();
            this.DATA = ds.DataTable1;
            this.InitDataSource(pw, FormView1, this.DATA, "dsMain");
            this.EventItemChanged = "OnDsMainItemChanged";
            this.EventClicked = "OnDsMainClicked";
            this.Register();
        }

        public void DdCoopid()
        {
            string sql = @"
                select coop_id,coop_id||' '||coop_name as display,1 as sorter from cmcoopmaster 
                union
                select '','',0 from dual
                order by sorter,coop_id"
            ;
            sql = WebUtil.SQLFormat(sql);
            this.DropDownDataBind(sql, "coop_id", "display", "coop_id");
            this.DropDownDataBind(sql, "coop_id2", "display", "coop_id");
        }

        public void DdMembgroup()
        {
            string sql = @"
                select membgroup_code,membgroup_code||' '||membgroup_desc as display,1 as sorter from mbucfmembgroup 
                union
                select '','',0 from dual
                order by sorter,membgroup_code"
            ;
            sql = WebUtil.SQLFormat(sql);
            this.DropDownDataBind(sql, "membgroup_start", "display", "membgroup_code");
            this.DropDownDataBind(sql, "membgroup_end", "display", "membgroup_code");
        }
    }
}