using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CoreSavingLibrary;
using DataLibrary;
using CoreSavingLibrary.WcfNFinance;

namespace Saving.Applications.finance.ws_fin_cashdetail_edit_ctrl
{
    public partial class ws_fin_cashdetail_edit : PageWebSheet, WebSheet
    {
        [JsPostBack]
        public string PostPayRecv { get; set; }
        [JsPostBack]
        public string PostProcess { get; set; }
        [JsPostBack]
        public string PostDelRec { get; set; }
        [JsPostBack]
        public string PostDelPay { get; set; }
        [JsPostBack]
        public string PostInsertRowRec { get; set; }
        [JsPostBack]
        public string PostInsertRowPay { get; set; }

        public string outputProcess;

        public void InitJsPostBack()
        {
            dsMain.InitDsMain(this);
            dsUser.InitDsUser(this);
            dsRecv.InitDsRecv(this);
            dsPay.InitDsPay(this);
            dsProc.InitDsProc(this);
        }

        public void WebSheetLoadBegin()
        {
            if (!IsPostBack)
            {
                LoadBegin();
            }
        }

        public void CheckJsPostBack(string eventArg)
        {
            if (eventArg == PostPayRecv)
            {
                RetrivePayRecv("seq_no");
            }
            else if (eventArg == PostProcess)
            {
                Process();
            }
            else if (eventArg == PostDelRec)
            {
                DelRec();
            }
            else if (eventArg == PostDelPay)
            {
                DelPay();
            }
            else if (eventArg == PostInsertRowRec)
            {
                dsRecv.InsertLastRow();
                decimal ld_seqno = 0;
                decimal[] ld_teller = financeFunction.of_is_teller(state.SsCoopId, dsUser.DATA[0].as_userid, dsUser.DATA[0].adtm_date);
                try { ld_seqno = ld_teller[3]; ld_seqno++; }
                catch { ld_seqno = 1; }
                dsRecv.DATA[dsRecv.RowCount - 1].SEQNO = ld_seqno;
            }
            else if (eventArg == PostInsertRowPay)
            {
                dsPay.InsertLastRow();
                decimal ld_seqno = 0;
                decimal[] ld_teller = financeFunction.of_is_teller(state.SsCoopId, dsUser.DATA[0].as_userid, dsUser.DATA[0].adtm_date);
                try { ld_seqno = ld_teller[3]; ld_seqno++; }
                catch { ld_seqno = 1; }
                dsPay.DATA[dsPay.RowCount - 1].SEQNO = ld_seqno;
            }
        }
        private void RetrivePayRecv(string sort)
        {
            decimal ld_rec = 0, ld_pay = 0;
            string ls_sort = "";
            DateTime workdate = dsUser.DATA[0].adtm_date;
            string ls_username = dsUser.DATA[0].as_userid.Trim();
            string ls_coopid = state.SsCoopId;
            dsMain.RetrieveData(ls_coopid, workdate, ls_username);
            if (sort == "seq_no")
            {
                ls_sort = ",SEQNO";
            }
            else if (sort == "system")
            {
                ls_sort = ",FROM_SYSTEM,ITEMPAYTYPE_CODE";
            }
            else
            {
                ls_sort = ",SEQNO";
            }
            if (dsMain.DATA[0].USER_NAME != "")
            {
                dsPay.RetrieveList(ls_coopid, workdate, ls_username, ls_sort);
                dsRecv.RetrieveList(ls_coopid, workdate, ls_username, ls_sort);
            }
            else
            {
                LtServerMessage.Text = WebUtil.ErrorMessage("ไม่พบข้อมูลบุคคลที่ระบุ");
                LoadBegin();
            }
        }
        private void Process()
        {
            string prcoXml = dsProc.ExportXml();
            string xmldate = dsUser.ExportXml();
            try
            {
                string process_name = "POSTTOFIN";
                int use_status = OfCheckUseProcess(process_name);
                if (use_status == 0)
                {
                    outputProcess = WebUtil.runProcessing(state, "POSTTOFIN", state.SsClientIp, prcoXml, xmldate);
                }
                else
                {
                    LtServerMessage.Text = WebUtil.WarningMessage2("ยังไม่สามารถทำการประมวลได้ กรุณารอสักครู่ เนื่องจากมีผู้ใช้งานอื่นทำการประมวล");
                    // NewClear();
                }
            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex);
            }
        }
        private void LoadBegin()
        {
            if (!IsPostBack)
            {
                dsMain.ResetRow();
                dsPay.ResetRow();
                dsRecv.ResetRow();
                dsUser.DATA[0].adtm_date = state.SsWorkDate;
                string ls_coopid = state.SsCoopId;
                dsUser.DATA[0].as_coopid = ls_coopid;
                dsUser.DDCoopName(ls_coopid);
            }
        }
        private int OfCheckUseProcess(string processsName)
        {
            int useprocess_status = 0;
            String sql = @"select count(1) as checkstate from cmprocessing 
                        where object_name = {0} and runtime_status = 0 and workdate = {1}";
            sql = WebUtil.SQLFormat(sql, processsName, state.SsWorkDate);
            Sdt ta = WebUtil.QuerySdt(sql);
            if (ta.Next())
            {
                useprocess_status = Convert.ToInt32(ta.GetDecimal("checkstate"));
            }
            return useprocess_status;
        }
        public void SaveWebSheet()
        {
            try
            {
                decimal ld_seqno = 0;
                string sql = "";
                string ls_coopid = state.SsCoopId;
                string ls_entry_id = dsUser.DATA[0].as_userid.Trim();
                DateTime entry_date = dsUser.DATA[0].adtm_date;
                decimal ls_itemamt = 0;
                //update lastseqno
                sql = @"update fintableusermaster set laststm_no = {3}
                where coop_id = {0} and opdatework = {1} and user_name = {2}";
                sql = WebUtil.SQLFormat(sql, ls_coopid, entry_date, ls_entry_id, dsMain.DATA[0].LASTSTM_NO);
                WebUtil.ExeSQL(sql);

                //rec
                for (int i = 0; i < dsRecv.RowCount; i++)
                {
                    if (i == 0) { continue; }
                    if (dsRecv.DATA[i].AI_RECV == 1)
                    {
                        ld_seqno = dsRecv.DATA[i].SEQNO;
                        ls_itemamt = dsRecv.DATA[i].AMOUNT;
                        int result = CheckAddData(ls_coopid, ls_entry_id, entry_date, ld_seqno);
                        if (result > 0)
                        {
                            sql = @"update fintableuserdetail set amount = {4}
                         where coop_id = {0} and user_name = {1} and opdatework = {2} and seqno = {3}";
                            sql = WebUtil.SQLFormat(sql, ls_coopid, ls_entry_id, entry_date, ld_seqno, ls_itemamt);
                            WebUtil.ExeSQL(sql);
                        }
                        else
                        {
                            sql = @"  INSERT INTO fintableuserdetail  
                                 ( coop_id,         user_name,          opdatework,   
                                   seqno,           status,             opdate,   
                                   amount,          itemtype_desc,      amount_balance,  
                                   nameapporve,     ref_status,         application)  
                          VALUES ( {0},             {1},                {2},
                                   {3},             {4},                {5},
                                   {6},             {7},                {8},
                                   {9},             {10},               {11}
                            )";
                            sql = WebUtil.SQLFormat(sql, ls_coopid, ls_entry_id, entry_date
                                , ld_seqno, 22, DateTime.Now
                                , ls_itemamt, dsRecv.DATA[i].ITEMTYPE_DESC, 0
                                , ls_entry_id, 22, "FIN");
                            WebUtil.ExeSQL(sql);

                            sql = @"update fintableusermaster set laststm_no = {3}
                where coop_id = {0} and opdatework = {1} and user_name = {2}";
                            sql = WebUtil.SQLFormat(sql, ls_coopid, entry_date, ls_entry_id, ld_seqno);
                            WebUtil.ExeSQL(sql);
                        }
                    }
                }
                //pay
                for (int i = 0; i < dsPay.RowCount; i++)
                {
                    if (i == 0) { continue; }
                    if (dsPay.DATA[i].AI_PAY == 1)
                    {
                        ld_seqno = dsPay.DATA[i].SEQNO;
                        ls_itemamt = dsPay.DATA[i].AMOUNT;
                        int result = CheckAddData(ls_coopid, ls_entry_id, entry_date, ld_seqno);
                        if (result > 0)
                        {
                            sql = @"update fintableuserdetail set amount = {4}
                         where coop_id = {0} and user_name = {1} and opdatework = {2} and seqno = {3}";
                            sql = WebUtil.SQLFormat(sql, ls_coopid, ls_entry_id, entry_date, ld_seqno, ls_itemamt);
                            WebUtil.ExeSQL(sql);
                        }
                        else
                        {
                            sql = @"  INSERT INTO fintableuserdetail  
                                 ( coop_id,         user_name,          opdatework,   
                                   seqno,           status,             opdate,   
                                   amount,          itemtype_desc,      amount_balance,  
                                   nameapporve,     ref_status,         application)  
                          VALUES ( {0},             {1},                {2},
                                   {3},             {4},                {5},
                                   {6},             {7},                {8},
                                   {9},             {10},               {11}
                            )";
                            sql = WebUtil.SQLFormat(sql, ls_coopid, ls_entry_id, entry_date
                                , ld_seqno, 21, DateTime.Now
                                , ls_itemamt, dsPay.DATA[i].ITEMTYPE_DESC, 0
                                , ls_entry_id, 21, "FIN");
                            WebUtil.ExeSQL(sql);

                            sql = @"update fintableusermaster set laststm_no = {3}
                where coop_id = {0} and opdatework = {1} and user_name = {2}";
                            sql = WebUtil.SQLFormat(sql, ls_coopid, entry_date, ls_entry_id, ld_seqno);
                            WebUtil.ExeSQL(sql);
                        }
                    }
                }
                CalSavAmount(ls_coopid, ls_entry_id, entry_date);
                RetrivePayRecv("seq_no");
                LtServerMessage.Text = WebUtil.CompleteMessage("ปรับปรุงข้อมูลสำเร็จ");
            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex);
            }

        }
        private void DelRec()
        {
            try
            {
                decimal ld_seqno = 0;
                string sql = "";
                string ls_coopid = state.SsCoopId;
                string ls_entry_id = dsUser.DATA[0].as_userid.Trim();
                DateTime entry_date = dsUser.DATA[0].adtm_date;
                int ln_row = dsRecv.GetRowFocus();
                ld_seqno = dsRecv.DATA[ln_row].SEQNO;
                sql = @"delete from fintableuserdetail where coop_id = {0} and user_name = {1} and opdatework = {2} and seqno = {3}";
                sql = WebUtil.SQLFormat(sql, ls_coopid, ls_entry_id, entry_date, ld_seqno);
                WebUtil.ExeSQL(sql);
                CalSavAmount(ls_coopid, ls_entry_id, entry_date);
                RetrivePayRecv("seq_no");
                LtServerMessage.Text = WebUtil.CompleteMessage("ปรับปรุงข้อมูลสำเร็จ");
            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex);
            }
        }
        private void DelPay()
        {
            try
            {
                decimal ld_seqno = 0;
                string sql = "";
                string ls_coopid = state.SsCoopId;
                string ls_entry_id = dsUser.DATA[0].as_userid.Trim();
                DateTime entry_date = dsUser.DATA[0].adtm_date;
                int ln_row = dsPay.GetRowFocus();
                ld_seqno = dsPay.DATA[ln_row].SEQNO;
                sql = @"delete from fintableuserdetail where coop_id = {0} and user_name = {1} and opdatework = {2} and seqno = {3}";
                sql = WebUtil.SQLFormat(sql, ls_coopid, ls_entry_id, entry_date, ld_seqno);
                WebUtil.ExeSQL(sql);
                CalSavAmount(ls_coopid, ls_entry_id, entry_date);
                RetrivePayRecv("seq_no");
                LtServerMessage.Text = WebUtil.CompleteMessage("ปรับปรุงข้อมูลสำเร็จ");
            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex);
            }
        }
        private void CalSavAmount(string coop_id, string user_name, DateTime entry_date)
        {
            try
            {
                decimal rec_amount = 0, pay_amount = 0, amount = 0;
                string sql = "";
                sql = @"SELECT
                SUM(CASE WHEN FINUCFSTATUS.FLAG = 1 THEN FINTABLEUSERDETAIL.AMOUNT ELSE 0 END) as REC_AMOUNT,
                SUM(CASE WHEN FINUCFSTATUS.FLAG <> 1 THEN FINTABLEUSERDETAIL.AMOUNT ELSE 0 END) AS PAY_AMOUNT
                FROM FINTABLEUSERDETAIL  INNER JOIN FINUCFSTATUS ON FINTABLEUSERDETAIL.STATUS = FINUCFSTATUS.STATUS
                WHERE ( FINTABLEUSERDETAIL.USER_NAME = {2} ) AND  
                ( FINTABLEUSERDETAIL.OPDATEWORK = {1}) AND 
                ( FINTABLEUSERDETAIL.COOP_ID ={0} )";
                sql = WebUtil.SQLFormat(sql, coop_id, entry_date, user_name);
                Sdt dt = WebUtil.QuerySdt(sql);
                if (dt.Next())
                {
                    rec_amount = dt.GetDecimal("rec_amount");
                    pay_amount = dt.GetDecimal("pay_amount");
                }
                amount = rec_amount - pay_amount;

                sql = @"update fintableusermaster set amount_balance = {3}
                where coop_id = {0} and opdatework = {1} and user_name = {2}";
                sql = WebUtil.SQLFormat(sql, coop_id, entry_date, user_name, amount);
                WebUtil.ExeSQL(sql);

            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex);
            }
        }
        private int CheckAddData(string coop_id, string user_name, DateTime entry_date, decimal seqno)
        {
            int result = 0;
            try
            {
                string sql = "";
                sql = @"SELECT SEQNO FROM FINTABLEUSERDETAIL WHERE ( FINTABLEUSERDETAIL.SEQNO = {3}) AND 
                ( FINTABLEUSERDETAIL.USER_NAME = {2} ) AND  
                ( FINTABLEUSERDETAIL.OPDATEWORK = {1}) AND 
                ( FINTABLEUSERDETAIL.COOP_ID ={0} )";
                sql = WebUtil.SQLFormat(sql, coop_id, entry_date, user_name, seqno);
                Sdt dt = WebUtil.QuerySdt(sql);
                if (dt.Next())
                {
                    result = dt.GetInt32("seqno");
                }
            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex);
            }
            return result;
        }
        public void WebSheetLoadEnd()
        {

        }
    }
}