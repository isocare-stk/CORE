<%@ Page Title="" Language="C#" MasterPageFile="~/Report.Master" AutoEventWireup="true" CodeBehind="u_cri_coopid_date_resign.aspx.cs" 
Inherits="Saving.CriteriaIReport.u_cri_coopid_date_resign.u_cri_coopid_date_resign" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link id="css1" runat="server" href="../../../JsCss/DataSourceTool.css" rel="stylesheet"
        type="text/css" />
    <style type="text/css">
        .style1
        {
            width: 200px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            AutoSlash('input[name="ctl00$ContentPlace$adtm_date"]');
        });

        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlace" runat="server">
<center>
        <asp:Label ID="Label1" runat="server" Font-Bold="true" Font-Size="Medium">[--------] - รายงาน--------  </asp:Label>
        <br />
        <asp:Label ID="lbError" runat="server" Style="color: Red"></asp:Label>
    </center>
    <br />
    <table class="iReportDataSourceFormView">
<%--        <tr>
            <td width="30%">
                <div align="right">
                    <span>สาขา : </span>
                </div>
            </td>
            <td>
               <div><asp:DropDownList ID="coop_id" runat="server">
                    <asp:ListItem Value="010001"> -----ชื่อ------- </asp:ListItem>
                </asp:DropDownList></div> 
            </td>
        </tr>--%>
        <tr>
            <td class="style1">
                <div>
                    <span>วันที่เริ่มเป็นสมาชิก :</span></div>
            </td>
            <td>
               <asp:TextBox ID="adtm_date" class="start_tdate" runat="server" ></asp:TextBox>
                </td>
        </tr>
          <tr>
            <td class="style1">
                <div>
                    <span>ตั้งแต่สถานะ :</span></div>
            </td>
            <td>
               <asp:DropDownList ID="resign_sstatus" runat="server">
                        <asp:ListItem Value="" Text="--กรุณาเลือกสถานะสมาชิก--"></asp:ListItem>
                        <asp:ListItem Value="0">สมาชิกปกติ</asp:ListItem>
                        <asp:ListItem Value="1">ลาออก</asp:ListItem>
                    </asp:DropDownList>
        </tr>
          <tr>
            <td class="style1">
                <div>
                    <span>ถึงสถานะ :</span></div>
            </td>
            <td>
                <asp:DropDownList ID="resign_estatus" runat="server">
                        <asp:ListItem Value="" Text="--กรุณาเลือกสถานะสมาชิก--"></asp:ListItem>
                        <asp:ListItem Value="0">สมาชิกปกติ</asp:ListItem>
                        <asp:ListItem Value="1">ลาออก</asp:ListItem>
                    </asp:DropDownList>
        </tr>

        
    </table>
</asp:Content>
