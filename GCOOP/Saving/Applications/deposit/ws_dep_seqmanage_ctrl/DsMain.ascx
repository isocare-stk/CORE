<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DsMain.ascx.cs" Inherits="Saving.Applications.deposit.ws_dep_seqmanage_ctrl.DsMain" %>
<link id="css1" runat="server" href="../../../JsCss/DataSourceTool.css" rel="stylesheet" type="text/css" />
<asp:FormView ID="FormView1" runat="server" DefaultMode="Edit">
    <EditItemTemplate>
        <table class="DataSourceFormView" style="width:800px">           
            <tr>
                <td width="18%">
                     <asp:Button ID="update_seq" runat="server" Text="อัพเดทลำดับรายการ" Width="100%" Height="30px"/>
                </td>
                <td>
                </td>
                <td width="18%">
                     <asp:Button ID="update_balance" runat="server" Text="อัพเดทจำนวนคงเหลือ" Width="100%" Height="30px"/>
                </td>
                 <td>
                </td>
                <td width="18%">
                     <asp:Button ID="update_money" runat="server" Text="อัพเดทต้นเงิน" Width="100%" Height="30px"/>
                </td>
            </tr> 
            <tr></tr>
            <tr>
                <td width="18%">
                   <asp:Button ID="check_seq" runat="server" Text="ตรวจสอบลำดับรายการ" Width="100%" Height="40px"/>
                </td>
                <td>
                </td>
                <td width="18%">
                   <asp:Button ID="check_balance" runat="server" Text="ตรวจสอบจำนวนคงเหลือ" Width="100%" Height="40px"/>
                </td>
                 <td>
                </td>
                <td width="18%">
                   <asp:Button ID="check_money" runat="server" Text="ตรวจสอบต้นเงิน" Width="100%" Height="40px"/>
                </td>
            </tr>
        </table>
    </EditItemTemplate>
</asp:FormView>
