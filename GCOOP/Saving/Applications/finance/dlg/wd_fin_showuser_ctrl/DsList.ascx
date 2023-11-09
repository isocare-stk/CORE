<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DsList.ascx.cs" Inherits="Saving.Applications.finance.dlg.wd_fin_showuser_ctrl.DsList" %>
<link id="css1" runat="server" href="../../../../JsCss/DataSourceTool.css" rel="stylesheet"
    type="text/css" />
<div align="left">
    <asp:Panel ID="Panel1" runat="server" HorizontalAlign="Left">
        <table class="DataSourceRepeater">
            <tr>
                <th width="13.2%">
                    รหัสผู้ใช้
                </th>
                <th width="43%">
                    ชื่อ - นามสกุล
                </th>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="Panel2" runat="server" Height="500px" ScrollBars="Auto"  HorizontalAlign="Left">
        <table class="DataSourceRepeater">
            <asp:Repeater ID="Repeater1" runat="server">
                <ItemTemplate>
                    <tr>
                        <td width="14%">
                            <asp:TextBox ID="USER_NAME" runat="server" ReadOnly="true" Style="cursor: pointer"></asp:TextBox>
                        </td>
                        <td width="43%">
                            <asp:TextBox ID="FULL_NAME" runat="server" ReadOnly="true" Style="cursor: pointer"></asp:TextBox>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </asp:Panel>
</div>
