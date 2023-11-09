using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CoreSavingLibrary;
using System.Data;

namespace Saving.Applications.deposit.ws_dep_editinttax_ctrl
{
    public partial class DsList : DataSourceRepeater
    {
        public DataSet1.DPDEPTMASTERDataTable DATA { get; private set; }

        public void InitDsList(PageWeb pw)
        {
            css1.Visible = false;
            DataSet1 ds = new DataSet1();
            this.DATA = ds.DPDEPTMASTER;
            this.EventItemChanged = "OnDsListItemChanged";
            this.EventClicked = "OnDsListClicked";
            this.InitDataSource(pw, Repeater1, this.DATA, "dsList");
            this.Register();
        }
        public void Retrieve(string coop_id, DateTime start_date, string ls_sqlext)
        {
            string sql = @"SELECT              
            DPDEPTSTATEMENT.DEPTSLIP_NO AS DEPTSLIP_NO,      	DPDEPTSTATEMENT.OPERATE_DATE AS DEPTSLIP_DATE , DPDEPTSTATEMENT.DEPTITEMTYPE_CODE AS RECPPAYTYPE_CODE ,       
            DPDEPTSTATEMENT.ENTRY_ID ,      DPDEPTMASTER.DEPTACCOUNT_NO ,           DPDEPTSTATEMENT.ENTRY_DATE ,
            DPDEPTMASTER.MEMBER_NO ,        DPDEPTMASTER.DEPTACCOUNT_NAME ,         DPDEPTMASTER.DEPTTYPE_CODE ,          
            MBMEMBMASTER.MEMB_NAME ,        MBMEMBMASTER.MEMB_SURNAME ,           	MBMEMBMASTER.MEMBGROUP_CODE ,        
            DPDEPTSTATEMENT.DEPTITEM_AMT AS DEPTSLIP_NETAMT,  DPDEPTSTATEMENT.PRNCBAL  ,DPDEPTSTATEMENT.SEQ_NO,
            DPDEPTSTATEMENT.TAX_AMT,DPDEPTSTATEMENT.PRNC_NO,DPDEPTTYPE.DEPTGROUP_CODE,
            DPUCFRECPPAYTYPE.GROUP_ITEMTPE,DPDEPTSTATEMENT.CASH_TYPE
            FROM   DPDEPTMASTER INNER JOIN DPDEPTSTATEMENT ON ( DPDEPTMASTER.COOP_ID = DPDEPTSTATEMENT.COOP_ID) AND ( DPDEPTMASTER.DEPTACCOUNT_NO = DPDEPTSTATEMENT.DEPTACCOUNT_NO)  
            INNER JOIN DPDEPTTYPE ON   ( DPDEPTTYPE.COOP_ID = DPDEPTMASTER.COOP_ID) AND  ( DPDEPTTYPE.DEPTTYPE_CODE = DPDEPTMASTER.DEPTTYPE_CODE) 
            INNER JOIN DPUCFRECPPAYTYPE ON DPUCFRECPPAYTYPE.RECPPAYTYPE_CODE = DPDEPTSTATEMENT.DEPTITEMTYPE_CODE
            LEFT JOIN MBMEMBMASTER  ON   ( DPDEPTMASTER.COOP_ID = MBMEMBMASTER.COOP_ID) AND  ( DPDEPTMASTER.MEMBER_NO = MBMEMBMASTER.MEMBER_NO)          
            WHERE
            ( DPDEPTMASTER.COOP_ID = {0}) AND 
            ( DPDEPTSTATEMENT.OPERATE_DATE = {1}  " + ls_sqlext + ") ORDER BY DPDEPTSTATEMENT.SEQ_NO ";
            sql = WebUtil.SQLFormat(sql, coop_id, start_date);
            DataTable dt = WebUtil.Query(sql);
            this.ImportData(dt);          
        }
    }
}