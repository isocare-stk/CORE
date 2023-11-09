<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DsUser.ascx.cs" Inherits="Saving.Applications.finance.ws_fin_cashdetail_edit_ctrl.DsUser" %>
<link id="css1" runat="server" href="../../../JsCss/DataSourceTool.css" rel="stylesheet" type="text/css" />
<asp:FormView ID="FormView1" runat="server" DefaultMode="Edit">
    <EditItemTemplate>
        <table class="DataSourceFormView" width="100px">
            <tr>
                 <td colspan="2">
                    <div  style="font-weight:bolder;font-size:17px;text-decoration: underline;color:#000099">ตรวจสอบเงินสด</span>                    
                </td>               
            </tr>
            <tr>
                <td width="35%">
                    <span>สาขา:</span>                    
                </td>
                <td>
                    <asp:DropDownList ID="as_coopid" runat="server">
                    </asp:DropDownList>
                </td>                                          
            </tr>
            <tr>
                <td>
                    <span>วันทำการ:</span>                    
                </td>
                <td>
                    <asp:TextBox ID="adtm_date" runat="server" style="text-align:center"></asp:TextBox>
                </td>                            
            </tr>
            <tr>
                <td>
                    <span>รหัสผู้ใช้:</span>
                </td>
                <td>
                    <asp:TextBox ID="as_userid" runat="server" Width="85%" style="text-align:center" BackColor="Yellow" ForeColor="Red"></asp:TextBox>                                   
                    <asp:Button ID="b_user" runat="server" Text="..." Width="10%" />    
                 </td>           
            </tr>
        </table>
    </EditItemTemplate>
</asp:FormView>