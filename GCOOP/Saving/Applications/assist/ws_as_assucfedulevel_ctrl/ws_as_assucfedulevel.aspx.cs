﻿using System;
using CoreSavingLibrary;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLibrary;

namespace Saving.Applications.assist.ws_as_assucfedulevel_ctrl
{
    public partial class ws_as_assucfedulevel : PageWebSheet, WebSheet
    {
        [JsPostBack]
        public String PostInsertRow { get; set; }
        [JsPostBack]
        public String PostDeleteRow { get; set; }

        public void InitJsPostBack()
        {
            dsDetail.InitDsDetail(this);
        }

        public void WebSheetLoadBegin()
        {
            if (!IsPostBack)
            {
                dsDetail.Retrieve();
            }

        }

        public void CheckJsPostBack(string eventArg)
        {
            if (eventArg == PostInsertRow)
            {
                dsDetail.InsertLastRow();
                dsDetail.FindTextBox(dsDetail.RowCount - 1, "edulevel_code").Focus();
                int row = dsDetail.RowCount - 1;
                dsDetail.DATA[row].COOP_ID = state.SsCoopId;
            }
            if (eventArg == PostDeleteRow)
            {
                int row = dsDetail.GetRowFocus();
                string edulevel_code = dsDetail.DATA[row].EDULEVEL_CODE;
                dsDetail.DeleteRow(row);
                try
                {
                    string ls_del = @"delete from assucfedulevel where edulevel_code ={0}";
                    ls_del = WebUtil.SQLFormat(ls_del,state.SsCoopId, edulevel_code);
                    WebUtil.ExeSQL(ls_del);
                    //dsDetail.Retrieve();
                    LtServerMessage.Text = WebUtil.CompleteMessage("ลบข้อมูลสำเร็จ");
                }
                catch
                {
                    LtServerMessage.Text = WebUtil.ErrorMessage("ลบข้อมูลไม่สำเสร็จ");
                }
            }
        }

        public void SaveWebSheet()
        {
            try
            {
                try
                {
                    ExecuteDataSource exc = new ExecuteDataSource(this);
                    exc.AddRepeater(dsDetail);
                    exc.Execute();
                    dsDetail.Retrieve();
                    LtServerMessage.Text = WebUtil.CompleteMessage("บันทึกรายการระดับชั้นการศึกษา สำเร็จ");
                }
                catch (Exception ex)
                {
                    LtServerMessage.Text = WebUtil.ErrorMessage(ex.Message);
                }

            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex);
            }
        }

        public void WebSheetLoadEnd()
        {

        }
    }
}