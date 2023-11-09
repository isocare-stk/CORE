using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CoreSavingLibrary;
using System.Data;

namespace Saving.Applications.finance.ws_fin_cashdetail_edit_ctrl
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
            this.Button.Add("b_process");    
            this.Register();
        }
        public void RetrieveData(string coop_id, DateTime work_date,string username)
        {
            string sql = @"SELECT FINTABLEUSERMASTER.USER_NAME,   
                 FINTABLEUSERMASTER.APPLICATION,   
                 FINTABLEUSERMASTER.OPDATEWORK,   
                 FINTABLEUSERMASTER.STATUS,
                (CASE WHEN  FINTABLEUSERMASTER.STATUS ='11' THEN 'เปิดลิ้นชัก' ELSE 'ปิดลิ้นชัก' END)STATUS_DESC,   
                 FINTABLEUSERMASTER.AMOUNT_BALANCE,   
                 AMSECUSERS.FULL_NAME,   
                 CMCOOPMASTER.COOP_NAME,   
                 FINTABLEUSERMASTER.COOP_ID,
                 FINTABLEUSERMASTER.LASTSTM_NO  
            FROM FINTABLEUSERMASTER,   
                 AMSECUSERS,   
                 CMCOOPMASTER  
           WHERE ( FINTABLEUSERMASTER.USER_NAME = AMSECUSERS.USER_NAME ) and  
                 ( FINTABLEUSERMASTER.COOP_ID = CMCOOPMASTER.COOP_ID ) and  
                 ( FINTABLEUSERMASTER.COOP_ID = AMSECUSERS.COOP_ID ) and  
                 ( FINTABLEUSERMASTER.USER_NAME = {2} ) AND  
                 ( FINTABLEUSERMASTER.OPDATEWORK = {1}) AND  
                 ( FINTABLEUSERMASTER.COOP_ID = {0} )    ";
            sql = WebUtil.SQLFormat(sql, coop_id, work_date, username);
            DataTable dt = WebUtil.Query(sql);
            ImportData(dt);
        }
    }
}