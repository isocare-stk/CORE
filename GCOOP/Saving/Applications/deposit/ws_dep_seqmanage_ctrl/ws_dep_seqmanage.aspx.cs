using CoreSavingLibrary;
using DataLibrary;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Saving.Applications.deposit.ws_dep_seqmanage_ctrl
{
    public partial class ws_dep_seqmanage : PageWebSheet, WebSheet
    {
        [JsPostBack]
        public string update_seq { get; set; }
        [JsPostBack]
        public string update_balance { get; set; }
        [JsPostBack]
        public string update_money { get; set; }
        [JsPostBack]
        public string check_seq { get; set; }
        [JsPostBack]
        public string check_balance { get; set; }
        [JsPostBack]
        public string check_money { get; set; }
        public void CheckJsPostBack(string eventArg)
        {
            string sql = "";
            if (eventArg == check_seq)
            {
                RetriveSeq();
            }
            else if (eventArg == check_balance)
            {
                RetrivePrncbal();
            }
            else if (eventArg == check_money)
            {
                RetrivePrnno();
            }
            else if (eventArg == update_seq)
            {
                try
                {
                    sql = @"update dpdeptmaster 
                    set dpdeptmaster.laststmseq_no = ( select max(ds.seq_no) from dpdeptstatement ds 
                    where dpdeptmaster.deptaccount_no = ds.deptaccount_no )";
                    sql = WebUtil.SQLFormat(sql);
                    WebUtil.ExeSQL(sql);
                    RetriveSeq();
                    LtServerMessage.Text = WebUtil.CompleteMessage("อัพเดทรายการสำเร็จ");
                }
                catch (Exception ex)
                {
                    LtServerMessage.Text = WebUtil.ErrorMessage(ex);
                }

            }
            else if (eventArg == update_balance)
            {
                try
                {
                    sql = @"update dpdeptmaster 
                    set dpdeptmaster.laststmseq_no = ( select max(ds.seq_no) from dpdeptstatement ds 
                    where dpdeptmaster.deptaccount_no = ds.deptaccount_no )";
                    sql = WebUtil.SQLFormat(sql);
                    WebUtil.ExeSQL(sql);
                    sql = @"update dpdeptmaster
                    set dpdeptmaster.prncbal = (select b.prncbal from dpdeptstatement b where dpdeptmaster.coop_id = b.coop_id and dpdeptmaster.deptaccount_no = b.deptaccount_no and dpdeptmaster.laststmseq_no = b.seq_no )
                    where dpdeptmaster.deptclose_status = 0";
                    sql = WebUtil.SQLFormat(sql);
                    WebUtil.ExeSQL(sql);
                    sql = @"update dpdeptmaster set withdrawable_amt  = prncbal where deptclose_status = 0 and withdrawable_amt  <> prncbal ";
                    sql = WebUtil.SQLFormat(sql);
                    WebUtil.ExeSQL(sql);
                    RetrivePrncbal();
                    LtServerMessage.Text = WebUtil.CompleteMessage("อัพเดทรายการสำเร็จ");
                }
                catch (Exception ex)
                {
                    LtServerMessage.Text = WebUtil.ErrorMessage(ex);

                }
            }
            else if (eventArg == update_money)
            {
                try
                {
                    sql = @"update dpdeptmaster set	dpdeptmaster.prnc_no  = (select isnull( max(dpdeptprncfixed.prnc_no), 0 ) from dpdeptprncfixed  where dpdeptmaster.coop_id = dpdeptprncfixed.coop_id 
				    and dpdeptmaster.deptaccount_no = dpdeptprncfixed.deptaccount_no )";
                    sql = WebUtil.SQLFormat(sql);
                    WebUtil.ExeSQL(sql);
                    RetrivePrnno();
                    LtServerMessage.Text = WebUtil.CompleteMessage("อัพเดทรายการสำเร็จ");
                }
                catch (Exception ex)
                {
                    LtServerMessage.Text = WebUtil.ErrorMessage(ex);

                }
            }
        }

        public void RetriveSeq()
        {
            try
            {
                string sql = "";
                sql = @"select ROW_NUMBER() OVER(ORDER BY a.deptaccount_no) as seq_no,
                    a.deptaccount_no,a.deptaccount_name, 
                    a.laststmseq_no as  mst,b.seq_no as stm,a.prncbal,0 as mprn,0 as sprn  
                    from dpdeptmaster a
                    inner join( select a.* from dpdeptstatement a
                                inner join (
                                select deptaccount_no, max(seq_no) seq_no from dpdeptstatement group by deptaccount_no
                                )b on a.deptaccount_no = b.deptaccount_no and a.seq_no = b.seq_no
                   )b on a.deptaccount_no = b.deptaccount_no
                    where a.laststmseq_no<>b.seq_no
                    order by a.deptaccount_no";
                sql = WebUtil.SQLFormat(sql);
                DataTable dt = WebUtil.Query(sql);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex);

            }

        }

        public void RetrivePrncbal()
        {
            try
            {
                string sql = "";
                sql = @"select ROW_NUMBER() OVER(ORDER BY a.deptaccount_no) as seq_no,
                    a.deptaccount_no,a.deptaccount_name,a.laststmseq_no as  mst,b.seq_no as stm ,0 as mprn,0 as sprn,a.prncbal  
                    from dpdeptmaster a 
                    join (select deptaccount_no, max(seq_no) seq_no from dpdeptstatement group by deptaccount_no)b on a.deptaccount_no = b.deptaccount_no 
                      where a.prncbal 
                    <>(select b.prncbal from dpdeptstatement b where b.seq_no = a.laststmseq_no and a.deptaccount_no = b.deptaccount_no)
                     and a.deptclose_status =0
                    ORDER BY a.deptaccount_no";
                sql = WebUtil.SQLFormat(sql);
                DataTable dt = WebUtil.Query(sql);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex);

            }
        }

        public void RetrivePrnno()
        {
            try
            {
                string sql = "";
                sql = @"select ROW_NUMBER() OVER(ORDER BY a.deptaccount_no) as seq_no,
                    a.deptaccount_no,
                    a.deptaccount_name, 
                    a.laststmseq_no as  mst,
                    st.seq_no as stm, 
                    a.prnc_no as mprn,
                    b.prnc_no as sprn,
                    a.prncbal
                     from dpdeptmaster a
                    join (select deptaccount_no, max(seq_no) seq_no from dpdeptstatement group by deptaccount_no)st on a.deptaccount_no = st.deptaccount_no 
                    inner join
                    (
                    select a.* from dpdeptprncfixed a
                    inner join (
                    select deptaccount_no, max(prnc_no) prnc_no from dpdeptprncfixed group by deptaccount_no
                    )b on a.deptaccount_no = b.deptaccount_no and a.prnc_no = b.prnc_no
                    )b on a.deptaccount_no = b.deptaccount_no
                    where
                    a.prnc_no<>b.prnc_no";
                sql = WebUtil.SQLFormat(sql);
                DataTable dt = WebUtil.Query(sql);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex);

            }
        }

        public void InitJsPostBack()
        {
            dsMain.InitDsMain(this);
        }


        public void SaveWebSheet()
        {
           
        }

        public void WebSheetLoadBegin()
        {
            
        }

        public void WebSheetLoadEnd()
        {
          
        }
    }
}