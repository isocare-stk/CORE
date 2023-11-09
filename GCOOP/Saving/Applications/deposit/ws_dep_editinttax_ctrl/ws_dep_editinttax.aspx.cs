using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CoreSavingLibrary;
using DataLibrary;

namespace Saving.Applications.deposit.ws_dep_editinttax_ctrl
{
    public partial class ws_dep_editinttax : PageWebSheet, WebSheet
    {
        [JsPostBack]
        public String JsPostRetrive { get; set; }
        public void InitJsPostBack()
        {
            dsMain.InitDsMain(this);
            dsList.InitDsList(this);
        }

        public void WebSheetLoadBegin()
        {
            if (!IsPostBack)
            {
                dsMain.DATA[0].START_DATE = state.SsWorkDate;
            } 
        }

        public void CheckJsPostBack(string eventArg)
        {
            if (eventArg == "JsPostRetrive")
            {
                RetriveDate();
            } 
        }
        private void RetriveDate()
        {
            try
            {
                string ls_deptno = "", ls_deptname = "", ls_memname = "", ls_memsurname = "";
                string ls_memno = "";
                string ls_sqlext = "";
                string coop_id = state.SsCoopControl;
                ls_deptno = dsMain.DATA[0].DEPTACCOUNT_NO.Trim();
                ls_deptno = wcf.NDeposit.of_analizeaccno(state.SsWsPass, ls_deptno);
                ls_deptname = dsMain.DATA[0].DEPTACCOUNT_NAME.Trim();
                ls_memno = dsMain.DATA[0].MEMBER_NO.Trim();
                ls_memname = dsMain.DATA[0].MEMB_NAME.Trim();
                ls_memsurname = dsMain.DATA[0].MEMB_SURNAME.Trim();
                DateTime start_date = dsMain.DATA[0].START_DATE;

                if (ls_deptno.Length > 0)
                {
                    ls_sqlext += " and (  DPDEPTMASTER.DEPTACCOUNT_NO like '%" + ls_deptno + "%') ";
                }
                if (ls_deptname.Length > 0)
                {
                    ls_sqlext += " and (  DPDEPTMASTER.DEPTACCOUNT_NAME like '%" + ls_deptname + "%') ";
                }
                if (ls_memno.Length > 0)
                {
                    ls_sqlext += " and ( DPDEPTMASTER.MEMBER_NO like '%" + ls_memno + "%') ";
                }
                if (ls_memname.Length > 0)
                {
                    ls_sqlext += " and ( mbmembmaster.memb_name like '%" + ls_memname + "%')";
                }
                if (ls_memsurname.Length > 0)
                {
                    ls_sqlext += " and ( mbmembmaster.memb_surname  like '%" + ls_memsurname + "%')";
                }

                dsList.Retrieve(coop_id, start_date, ls_sqlext);
            }
            catch (Exception ex) { LtServerMessage.Text = WebUtil.ErrorMessage(ex.Message); }

        }
        public void SaveWebSheet()
        {
            try
            {
                string ls_coopcontrol = state.SsCoopControl;
                string ls_coopid    = state.SsCoopId;
                string ls_deptaccountno = "",ls_groupitem=""; 
                DateTime entry_date = dsMain.DATA[0].START_DATE;
                string sql = "", ls_typecode = "", ls_slipno = "";
                decimal ld_deptamt = 0, ld_prncbal = 0, ld_seqno = 0, ld_intamt = 0, ld_taxamt = 0, ld_int_finslipamt = 0, ld_tax_finslipamt = 0, ld_prncno = 0, ld_slip_intamt = 0, ld_slip_taxamt = 0,ld_fix_taxamt= 0;
                for (int i = 0; i < dsList.RowCount; i++)
                {

                    if (dsList.DATA[i].CHOOSE_FLAG == 1)
                    {
                        ld_taxamt = 0; ld_int_finslipamt=0;
                        ls_deptaccountno = dsList.DATA[i].DEPTACCOUNT_NO;
                        ld_seqno = dsList.DATA[i].SEQ_NO;
                        ld_deptamt = dsList.DATA[i].DEPTSLIP_NETAMT;
                        ld_prncbal = dsList.DATA[i].PRNCBAL;
                        ls_typecode = dsList.DATA[i].RECPPAYTYPE_CODE;
                        ls_slipno = dsList.DATA[i].DEPTSLIP_NO;
                        ls_groupitem = dsList.DATA[i].GROUP_ITEMTYPE;
                        if (ls_typecode == "INT")
                        {
                            ld_intamt = ld_deptamt; ld_tax_finslipamt = dsList.DATA[i].TAX_AMT; ld_taxamt = dsList.DATA[i].TAX_AMT; ld_int_finslipamt = ld_deptamt; 
                        }
                        else if (ls_typecode == "TAX") { ld_taxamt = ld_deptamt; ld_fix_taxamt = ld_deptamt;}
                        ld_slip_intamt = ld_intamt; ld_slip_taxamt = ld_tax_finslipamt;                       

                        sql = @"update dpdeptstatement set deptitem_amt = {3},  prncbal = {4}
                            where coop_id = {0} and deptaccount_no = {1} and seq_no = {2} ";
                        sql = WebUtil.SQLFormat(sql, ls_coopcontrol, ls_deptaccountno, ld_seqno, ld_deptamt, ld_prncbal);
                        WebUtil.ExeSQL(sql);


                        if (dsList.DATA[i].DEPTGROUP_CODE == "01" && ls_typecode == "DTR")
                        {
                            //ต้นเก่า
                            sql = @"update dpdeptprncfixed set intpay_amt = {3},  taxpay_amt = {4}
                            where coop_id = {0} and deptaccount_no = {1} and prnc_no = {2}";
                            sql = WebUtil.SQLFormat(sql, ls_coopcontrol, ls_deptaccountno, ld_prncno, ld_intamt, ld_fix_taxamt);
                            WebUtil.ExeSQL(sql);
                            //ต้นใหม่
                            sql = @"update dpdeptprncfixed set prnc_amt = {3},  prnc_bal = {3}
                            where coop_id = {0} and deptaccount_no = {1} and deptslip_no = {2}";
                            sql = WebUtil.SQLFormat(sql, ls_coopcontrol, ls_deptaccountno, ls_slipno, ld_deptamt);
                            WebUtil.ExeSQL(sql);
                        }
                        if (ls_typecode == "TAX")
                        {
                            sql = @"update dpinttaxstatement set int_amt = {3}, int_amt_cyear = {3}, tax_amt = {4}
                            where coop_id = {0} and deptaccount_no = {1} and deptslip_no = {2}";
                            sql = WebUtil.SQLFormat(sql, ls_coopcontrol, ls_deptaccountno, ls_slipno, ld_intamt, ld_deptamt);
                            WebUtil.ExeSQL(sql);
                        }
                        //finslip finslipdet
                        if (ls_typecode == "INT")
                        {
                            sql = @"update finslipdet set finslipdet.itempay_amt={4} ,itempayamt_net={4}
                        from finslipdet inner join finslip on finslipdet.slip_no = finslip.slip_no  and finslip.coop_id = finslipdet.coop_id
                        inner join dpdeptslip on dpdeptslip.deptslip_no = finslip.ref_slipno and dpdeptslip.coop_id = finslip.coop_id and dpdeptslip.deptslip_date = finslip.entry_date
                        where dpdeptslip.deptcoop_id = {0} and  dpdeptslip.coop_id = {1} and dpdeptslip.deptslip_no = {2}  and dpdeptslip.deptslip_date = {3}
                        and finslipdet.slipitem_desc like 'ดอกเบี้ย%'";
                            sql = WebUtil.SQLFormat(sql, ls_coopcontrol, ls_coopid, ls_slipno, entry_date, ld_deptamt);
                            WebUtil.ExeSQL(sql);

                            sql = @"update finslipdet set finslipdet.itempay_amt={4} ,itempayamt_net={4}
                        from finslipdet inner join finslip on finslipdet.slip_no = finslip.slip_no  and finslip.coop_id = finslipdet.coop_id
                        inner join dpdeptslip on dpdeptslip.deptslip_no = finslip.ref_slipno and dpdeptslip.coop_id = finslip.coop_id and dpdeptslip.deptslip_date = finslip.entry_date
                        where dpdeptslip.deptcoop_id = {0} and  dpdeptslip.coop_id = {1} and dpdeptslip.deptslip_no = {2}  and dpdeptslip.deptslip_date = {3}
                        and finslipdet.slipitem_desc like 'ภาษี%'";
                            sql = WebUtil.SQLFormat(sql, ls_coopcontrol, ls_coopid, ls_slipno, entry_date, ld_tax_finslipamt, ld_intamt);
                            WebUtil.ExeSQL(sql);
                        }
                        else if (ls_typecode == "WTR")
                        {
                            ld_prncno = dsList.DATA[i].PRNC_NO;
                            sql = @"update finslipdet set finslipdet.itempay_amt={4} ,itempayamt_net={4},principal_payment = {4},tax_amt = {5},interest_payment = {6}
                        from finslipdet inner join finslip on finslipdet.slip_no = finslip.slip_no  and finslip.coop_id = finslipdet.coop_id
                        inner join dpdeptslip on dpdeptslip.deptslip_no = finslip.ref_slipno and dpdeptslip.coop_id = finslip.coop_id and dpdeptslip.deptslip_date = finslip.entry_date
                        where dpdeptslip.deptcoop_id = {0} and  dpdeptslip.coop_id = {1} and dpdeptslip.deptslip_no = {2}  and dpdeptslip.deptslip_date = {3}
                        ";
                            sql = WebUtil.SQLFormat(sql, ls_coopcontrol, ls_coopid, ls_slipno, entry_date, ld_deptamt, ld_tax_finslipamt, ld_intamt);
                            WebUtil.ExeSQL(sql);
                        }
                        else if (ls_groupitem == "CLS")
                        {
                            sql = @"update finslipdet set finslipdet.itempay_amt={4} ,itempayamt_net={4},interest_payment = {5}
                        from finslipdet inner join finslip on finslipdet.slip_no = finslip.slip_no  and finslip.coop_id = finslipdet.coop_id
                        inner join dpdeptslip on dpdeptslip.deptslip_no = finslip.ref_slipno and dpdeptslip.coop_id = finslip.coop_id and dpdeptslip.deptslip_date = finslip.entry_date
                        where dpdeptslip.deptcoop_id = {0} and  dpdeptslip.coop_id = {1} and dpdeptslip.deptslip_no = {2}  and dpdeptslip.deptslip_date = {3}
                        ";
                            sql = WebUtil.SQLFormat(sql, ls_coopcontrol, ls_coopid, ls_slipno, entry_date, ld_deptamt, ld_intamt);
                            WebUtil.ExeSQL(sql);
                        }
                        else
                        {
                            sql = @"update finslipdet set finslipdet.itempay_amt={4} ,itempayamt_net={4},principal_payment = {4}
                        from finslipdet inner join finslip on finslipdet.slip_no = finslip.slip_no  and finslip.coop_id = finslipdet.coop_id
                        inner join dpdeptslip on dpdeptslip.deptslip_no = finslip.ref_slipno and dpdeptslip.coop_id = finslip.coop_id and dpdeptslip.deptslip_date = finslip.entry_date
                        where dpdeptslip.deptcoop_id = {0} and  dpdeptslip.coop_id = {1} and dpdeptslip.deptslip_no = {2}  and dpdeptslip.deptslip_date = {3}
                        ";
                            sql = WebUtil.SQLFormat(sql, ls_coopcontrol, ls_coopid, ls_slipno, entry_date, ld_deptamt);
                            WebUtil.ExeSQL(sql);
                        }

                        if (ls_typecode == "TAX" || ls_typecode == "DTR")
                        {
                            ld_slip_intamt = 0; ld_slip_taxamt = 0;
                        }
                        if (ls_groupitem == "CLS")
                        {
                            sql = @"update dpdeptslip set deptslip_netamt = {4},  int_amt = {5}, tax_amt ={6}
                            where deptcoop_id = {0} and deptaccount_no = {1} and deptslip_no = {2} and deptslip_date = {3}";
                            sql = WebUtil.SQLFormat(sql, ls_coopcontrol, ls_deptaccountno, ls_slipno, entry_date, ld_deptamt, ld_slip_intamt, ld_slip_taxamt);
                            WebUtil.ExeSQL(sql);
                        }
                        else
                        {
                            sql = @"update dpdeptslip set deptslip_amt = {4},deptslip_netamt = {4},  int_amt = {5}, tax_amt ={6}
                            where deptcoop_id = {0} and deptaccount_no = {1} and deptslip_no = {2} and deptslip_date = {3}";
                            sql = WebUtil.SQLFormat(sql, ls_coopcontrol, ls_deptaccountno, ls_slipno, entry_date, ld_deptamt, ld_slip_intamt, ld_slip_taxamt);
                            WebUtil.ExeSQL(sql);
                        }
                        if (ls_typecode == "INT")
                        {
                            ld_deptamt = ld_slip_intamt - ld_slip_taxamt;
                        }
                        sql = @"update finslip set itempay_amt = {3},item_amtnet = {3},  accuint_amt = {4}, tax_amt ={5}
                            where coop_id = {0} and ref_slipno = {1} and entry_date = {2}";
                        sql = WebUtil.SQLFormat(sql, ls_coopid, ls_slipno, entry_date, ld_deptamt, ld_int_finslipamt, ld_taxamt);
                        WebUtil.ExeSQL(sql);

                        if (i == dsList.RowCount - 1)
                        {
                            sql = @"update dpdeptmaster set withdrawable_amt = {2},  prncbal = {2}
                            where coop_id = {0} and deptaccount_no = {1} ";
                            sql = WebUtil.SQLFormat(sql, ls_coopcontrol, ls_deptaccountno, ld_prncbal);
                            WebUtil.ExeSQL(sql);
                        }
                        if (dsList.DATA[i].CASH_TYPE == "CSH")
                        {
                            sql = @"update fintableuserdetail set amount = {3}
                            where coop_id = {0} and ref_docno = {1} and opdatework = {2}";
                            sql = WebUtil.SQLFormat(sql, ls_coopid, ls_slipno, entry_date, ld_deptamt);
                            WebUtil.ExeSQL(sql);

                            string ls_entry_id="";
                            sql = @"select user_name from  fintableuserdetail 
                            where  coop_id={0} and opdatework={1} and  fintableuserdetail.ref_docno={2}";
                            sql = WebUtil.SQLFormat(sql, ls_coopid,entry_date,ls_slipno);
                            Sdt dt = WebUtil.QuerySdt(sql);
                            if (dt.Next())
                            {
                                ls_entry_id = dt.GetString("user_name").Trim();
                            }
                            CalSavAmount(ls_coopid, ls_entry_id, entry_date);
                        }
                    }
                }
                LtServerMessage.Text = WebUtil.CompleteMessage("บันทึกการปรับปรุงบัญชี " + WebUtil.ViewAccountNoFormat(ls_deptaccountno) + " เรียบร้อยแล้ว");
            }catch(Exception ex){
                LtServerMessage.Text = WebUtil.ErrorMessage(ex);
            }
        }
        private void CalSavAmount(string coop_id,string user_name,DateTime entry_date) {
            try {
                decimal rec_amount = 0,pay_amount = 0,amount=0;
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

            }catch(Exception ex){
                LtServerMessage.Text = WebUtil.ErrorMessage(ex);
            }
        }
        public void WebSheetLoadEnd()
        {

        }
    }
}