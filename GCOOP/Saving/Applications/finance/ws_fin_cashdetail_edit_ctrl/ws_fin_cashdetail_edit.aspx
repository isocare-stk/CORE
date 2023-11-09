<%@ Page Title="" Language="C#" MasterPageFile="~/Frame.Master" AutoEventWireup="true" CodeBehind="ws_fin_cashdetail_edit.aspx.cs" Inherits="Saving.Applications.finance.ws_fin_cashdetail_edit_ctrl.ws_fin_cashdetail_edit" %>
<%@ Register Src="DsMain.ascx" TagName="DsMain" TagPrefix="uc1" %>
<%@ Register Src="DsRecv.ascx" TagName="DsRecv" TagPrefix="uc2" %>
<%@ Register Src="DsPay.ascx" TagName="DsPay" TagPrefix="uc3" %>
<%@ Register Src="DsProc.ascx" TagName="DsProc" TagPrefix="uc4" %>
<%@ Register Src="DsUser.ascx" TagName="dsUser" TagPrefix="uc5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <script type="text/javascript">

         //ประกาศตัวแปร ควรอยู่บริเวณบนสุดใน tag <script>
         var dsMain = new DataSourceTool();
         var dsRecv = new DataSourceTool();
         var dsPay = new DataSourceTool();
         var dsUser = new DataSourceTool();

         function MenubarOpen() {
             Gcoop.OpenIFrame2(550, 550, 'wd_fin_showuser.aspx', '')
         }
         //ประกาศฟังก์ชันสำหรับ event ItemChanged
         function OnDsUserItemChanged(s, r, c, v) {
             if (c == "as_userid") {                 
                 PostPayRecv();                 
             }else if (c == "adtm_date") {                 
                 PostPayRecv();                 
             }
         }
         function GetUsesNameDlg(username) {
             dsUser.SetItem(0, "as_userid", username);
             PostPayRecv();
         }
         function OnDsUserClicked(s, r, c, v) { 
             if (c == "b_user") {
                 Gcoop.OpenIFrame2(550, 550, 'wd_fin_showuser.aspx', '')
             } 
         }
         function OnDsMainClicked(s, r, c, v) {
             if (c == "b_process") {
                 PostProcess();
             }
         }
         function OnDsRecvClicked(s, r, c, v) {
             if (c == "b_del") {
				  var confirmText = "ยืนยันการลบแถวที่ " + dsRecv.GetItem(r,"rownumber");
                    if (confirm(confirmText)) {
                        PostDelRec();
                    }   
             }
         }
         function OnDsPayClicked(s, r, c, v) {
             if (c == "b_del") {
				  var confirmText = "ยืนยันการลบแถวที่ " + dsPay.GetItem(r,"rownumber");
                    if (confirm(confirmText)) {
                        PostDelPay();
                    }                 
             }
         }
         function OnDsListClicked(s, r, c) {
          
         }
         function Validate() {
             return confirm("ยืนยันการบันทึกข้อมูล");
         }

         function SheetLoadComplete() {
            dsRecv.GetElement(0, "rownumber").style.display = "none";
            dsRecv.GetElement(0, "itemtype_desc").style.fontWeight = "bold";
            dsRecv.GetElement(0, "amount").style.Color = "#A52A2A";
            dsRecv.GetElement(0, "amount").style.fontWeight = "bold";
            dsPay.GetElement(0, "rownumber").style.display = "none";
            dsPay.GetElement(0, "amount").style.fontWeight = "bold";
            dsPay.GetElement(0, "itemtype_desc").style.textDecoration = "none";
            dsPay.GetElement(0, "itemtype_desc").style.fontWeight = "bold"; 
         }
		function OnClickInsertRowRec() {
            PostInsertRowRec(); 
        }
		function OnClickInsertRowPay() {
            PostInsertRowPay(); 
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlace" runat="server">
    <asp:Literal ID="LtServerMessage" runat="server"></asp:Literal>
<table width="100%">
    <tr>
	<td style="width:28%">
	    <uc5:DsUser ID="dsUser" runat="server" />
	</td>
	<td style="width:60.5%">
	    <uc1:DsMain ID="dsMain" runat="server" />
	</td> 
    </tr>
</table>

<table width="100%">
     <tr>
	<td>
	   <div style="font-weight:bolder;font-size:17px;text-decoration: underline;color:#000099">รายรับ</div>   
	</td>
	<td>
		<span onclick="OnClickInsertRowRec()" style="cursor: pointer;">
		<asp:Label ID="LbInsert1" runat="server" Text="เพิ่มแถว" Font-Bold="False" Font-Names="Tahoma"
                Font-Size="14px" Font-Underline="True" ForeColor="#006600" /></span>
	</td>
	<td>
	    <div style="font-weight:bolder;font-size:17px;text-decoration: underline;color:#000099">รายจ่าย</div>
	</td>
		<td>
			<span onclick="OnClickInsertRowPay()" style="cursor: pointer;">
		<asp:Label ID="LbInsert2" runat="server" Text="เพิ่มแถว" Font-Bold="False" Font-Names="Tahoma"
                Font-Size="14px" Font-Underline="True" ForeColor="#006600" /></span>
		</td>
    </tr>                      
</table>
<table width="100%">
     <tr>
	<td>
	   <uc2:DsRecv ID="dsRecv" runat="server" />
	</td>
	<td>
	    <uc3:DsPay ID="dsPay" runat="server"  />
	</td>
    </tr>                      
</table>
    <%=outputProcess%>
</asp:Content>
