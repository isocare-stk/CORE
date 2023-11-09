﻿using System;
using CoreSavingLibrary;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Saving.CriteriaIReport.u_cri_coopid_date_depttype_recppaytype
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
            sql = WebUtil.SQLFormat(sql);
            DataTable dt = WebUtil.Query(sql);
            this.DropDownDataBind(dt, "as_coopid", "coop_name", "coop_id");
        }
        
        public void DdDepttype()
        {
            String sql = @"    SELECT DEPTTYPE_CODE,
                        DEPTTYPE_CODE +'  ' + DEPTTYPE_DESC AS DEPTTYPE_DESC,    
                        1 as sorter    
                        FROM DPDEPTTYPE
                        union
                        select '','',0 from cmcoopmaster order by sorter,DEPTTYPE_CODE";
                        
            sql = WebUtil.SQLFormat(sql);
            DataTable dt = WebUtil.Query(sql);
            this.DropDownDataBind(dt, "depttype_scode", "DEPTTYPE_DESC", "DEPTTYPE_CODE");
            
        }
        public void DdDepttypee()
        {
            String sql = @"    SELECT DEPTTYPE_CODE,   
                        DEPTTYPE_CODE ||'  ' ||DEPTTYPE_DESC AS DEPTTYPE_DESC,    
                        1 as sorter     
                        FROM DPDEPTTYPE
                        union
                        select '','',0 from dual order by sorter,DEPTTYPE_CODE";
                       
            sql = WebUtil.SQLFormat(sql);
            DataTable dt = WebUtil.Query(sql);
            this.DropDownDataBind(dt, "depttype_ecode", "DEPTTYPE_DESC", "DEPTTYPE_CODE");
        }

        public void DdRecpaytype()
        {
            String sql = @"    SELECT RECPPAYTYPE_CODE,
                        RECPPAYTYPE_CODE +'  ' + RECPPAYTYPE_DESC AS RECPPAYTYPE_DESC,1 as sorter                                   
                        FROM DPUCFRECPPAYTYPE
                        union
                        select '','',0 from  cmcoopmaster order by sorter,RECPPAYTYPE_CODE";
                        
            sql = WebUtil.SQLFormat(sql);
            DataTable dt = WebUtil.Query(sql);
            this.DropDownDataBind(dt, "RECPPAYTYPE_CODE", "RECPPAYTYPE_DESC", "RECPPAYTYPE_CODE");
        }
    }
}