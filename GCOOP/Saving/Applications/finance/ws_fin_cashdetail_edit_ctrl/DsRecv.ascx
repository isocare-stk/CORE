<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DsRecv.ascx.cs" Inherits="Saving.Applications.finance.ws_fin_cashdetail_edit_ctrl.DsRecv" %>
<link id="css1" runat="server" href="../../../JsCss/DataSourceTool.css" rel="stylesheet"
    type="text/css" />
<asp:Panel ID="Panel1" runat="server"  Height="450px" ScrollBars="Auto" HorizontalAlign="Left">    
    <table class="DataSourceRepeater" style="width:422px">
        <tr>
             <th>                                
            </th>
            <th>  
                ลำดับ              
            </th>
            <th>
                รายการ
            </th>
            <th>
                จำนวนเงิน
            </th>
            <th>
                ลบ
            </th>
        </tr>
        <asp:Repeater ID="Repeater1"  runat="server">
            <ItemTemplate>
                <tr>
                    <td width="3%" style="border: 0px;">
                        <asp:CheckBox ID="AI_RECV" runat="server" ></asp:CheckBox>
                    </td>
                    <td width="3%" style="border: 0px;">
                        <asp:TextBox ID="rownumber" runat="server" Style="text-align:center;" ReadOnly="true"></asp:TextBox>
                    </td>
                    <td  width="60%" style="border: 0px;">
                        <asp:TextBox ID="itemtype_desc"  runat="server" Style="border-bottom: 1px solid black;" ></asp:TextBox>
                    </td>
                    <td width="37%" style="border: 0px;">
                        <asp:TextBox ID="amount" runat="server" Style="text-align:right;border-bottom: 1px solid black;"  ToolTip="#,##0.00" BackColor="#CCCCCC"></asp:TextBox>
                    </td>
                    <td width="3%" style="border: 0px;">
                        <asp:Button ID="b_del" Text="-" runat="server"/>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
</asp:Panel>
