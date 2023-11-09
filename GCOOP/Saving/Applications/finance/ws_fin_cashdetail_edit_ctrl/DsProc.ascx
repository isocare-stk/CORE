<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DsProc.ascx.cs" Inherits="Saving.Applications.finance.ws_fin_cashdetail_edit_ctrl.DsProc" %>
<link id="css1" runat="server" href="../../../JsCss/DataSourceTool.css" rel="stylesheet" type="text/css" />
<asp:FormView ID="FormView1" runat="server" DefaultMode="Edit">
    <EditItemTemplate>
        <table class="DataSourceFormView">            
            <tr>
                <td>
                    <asp:CheckBox ID="process_shl" runat="server" Text="รับชำระหุ้นหนี้" Checked="true" ></asp:CheckBox>               
                </td>
            </tr>
            <tr>
                <td>
                     <asp:CheckBox ID="process_dep" runat="server" Text="เงินฝาก" Checked="true"></asp:CheckBox>     
                </td>
            </tr>
            <tr>
                <td>
                     <asp:CheckBox ID="process_shr" runat="server" Text="จ่ายถอนหุ้นคืน" Checked="true"></asp:CheckBox>     
                </td>
            </tr>
            <tr>
                <td>
                     <asp:CheckBox ID="process_lon" runat="server" Text="จ่ายเงินกู้" Checked="true"></asp:CheckBox>     
                </td>
            </tr>
            <tr>
                <td>
                     <asp:CheckBox ID="process_div" runat="server" Text="ปันผล" Checked="true"></asp:CheckBox>     
                </td>                             
            </tr>           
        </table>
    </EditItemTemplate>
</asp:FormView>



