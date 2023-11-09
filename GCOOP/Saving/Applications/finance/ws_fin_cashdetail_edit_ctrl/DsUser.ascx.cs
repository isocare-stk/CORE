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
    public partial class DsUser : DataSourceFormView
    {
        public DataSet1.DataUserDataTable DATA { get; set; }
        
        public void InitDsUser(PageWeb pw)
        {
            css1.Visible = false;
            DataSet1 ds = new DataSet1();
            this.DATA = ds.DataUser;
            this.InitDataSource(pw, FormView1, this.DATA, "dsUser");
            this.EventItemChanged = "OnDsUserItemChanged";
            this.EventClicked = "OnDsUserClicked";
            this.Button.Add("b_user");
            this.Register();
        }
        public void DDCoopName(string coop_id)
        {
            string sql = @" select coop_id as as_coopid,coop_name  from cmcoopmaster where coop_id='"+coop_id+"' ";
            DataTable dt = WebUtil.Query(sql);
            this.DropDownDataBind(dt, "as_coopid", "coop_name", "as_coopid");
        }
    }
}