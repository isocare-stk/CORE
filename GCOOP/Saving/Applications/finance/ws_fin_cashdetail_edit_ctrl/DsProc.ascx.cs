using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CoreSavingLibrary;

namespace Saving.Applications.finance.ws_fin_cashdetail_edit_ctrl
{
    public partial class DsProc : DataSourceFormView
    {
        public DataSet1.DataTable2DataTable DATA { get; set; }

        public void InitDsProc(PageWeb pw)
        {
            css1.Visible = false;
            DataSet1 ds = new DataSet1();
            this.DATA = ds.DataTable2;
            this.InitDataSource(pw, FormView1, this.DATA, "dsProc");
            this.EventItemChanged = "OnDsProcItemChanged";
            this.EventClicked = "OnDsProcClicked";
            this.Register();
        }
    }
}