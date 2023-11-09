using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CoreSavingLibrary;
using System.Data;
using DataLibrary;

namespace Saving.Applications.finance.ws_fin_cashdetail_edit_ctrl
{
    public partial class DsPay : DataSourceRepeater
    {
        public DataSet1.FINTABLEUSERDETAILDataTable DATA { get; set; }

        public void InitDsPay(PageWeb pw)
        {
            css1.Visible = false;
            DataSet1 ds = new DataSet1();
            this.DATA = ds.FINTABLEUSERDETAIL;
            this.EventItemChanged = "OnDsPayItemChanged";
            this.EventClicked = "OnDsPayClicked";
            this.InitDataSource(pw, Repeater1, this.DATA, "dsPay");
            this.Button.Add("b_del");
            this.Register();
        }
        public void RetrieveList(string coopid, DateTime workdate, string username, string sort)
        {
            String sql = "";
            sql = @"SELECT * FROM
            (SELECT
            0 as rownumber,	    
            '' as COOP_ID  ,
            null as OPDATE,   
            null as OPDATEWORK,   
            '' as USER_NAME,   
            0 as SEQNO,   
            'ยอดรวม' as ITEMTYPE_DESC,
            isnull(sum(FINTABLEUSERDETAIL.AMOUNT),0.00) as AMOUNT,   
            0 as STATUS,   
            '' as DOC_NO,
			NULL AS FROM_SYSTEM,
			NULL AS ITEMPAYTYPE_CODE
            FROM FINTABLEUSERDETAIL  INNER JOIN FINUCFSTATUS ON FINTABLEUSERDETAIL.STATUS = FINUCFSTATUS.STATUS
            WHERE ( FINTABLEUSERDETAIL.USER_NAME = {2} ) AND  
            ( FINTABLEUSERDETAIL.OPDATEWORK = {1} ) AND  
            ( FINUCFSTATUS.FLAG in(-1,0) ) AND
            ( FINTABLEUSERDETAIL.COOP_ID = {0} )

            UNION

            SELECT
            ROW_NUMBER() OVER (PARTITION BY USER_NAME ORDER BY SEQNO asc ) as rownumber ,
            FINTABLEUSERDETAIL.COOP_ID  ,
            FINTABLEUSERDETAIL.OPDATE,   
            FINTABLEUSERDETAIL.OPDATEWORK,   
            FINTABLEUSERDETAIL.USER_NAME,   
            FINTABLEUSERDETAIL.SEQNO,   
            FINTABLEUSERDETAIL.ITEMTYPE_DESC,
            FINTABLEUSERDETAIL.AMOUNT,   
            FINTABLEUSERDETAIL.STATUS,   
            FINTABLEUSERDETAIL.DOC_NO,
			FINSLIP.FROM_SYSTEM,
			FINSLIP.ITEMPAYTYPE_CODE
            FROM FINTABLEUSERDETAIL  INNER JOIN FINUCFSTATUS ON FINTABLEUSERDETAIL.STATUS = FINUCFSTATUS.STATUS
            LEFT JOIN FINSLIP ON FINSLIP.COOP_ID = FINTABLEUSERDETAIL.COOP_ID AND FINSLIP.SLIP_NO =  FINTABLEUSERDETAIL.REF_DOCNO
            WHERE ( FINTABLEUSERDETAIL.USER_NAME = {2} ) AND  
            ( FINTABLEUSERDETAIL.OPDATEWORK = {1} ) AND  
            ( FINUCFSTATUS.FLAG in(-1,0) ) AND
            ( FINTABLEUSERDETAIL.COOP_ID = {0} )
            )fin
            order by  rownumber " + sort;            
            sql = WebUtil.SQLFormat(sql, coopid, workdate, username);
            DataTable dt = WebUtil.Query(sql);
            this.ImportData(dt);
        }
    }
}