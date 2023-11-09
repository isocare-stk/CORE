<%@ Page Title="" Language="C#" MasterPageFile="~/Frame.Master" AutoEventWireup="true" CodeBehind="ws_dep_seqmanage.aspx.cs" Inherits="Saving.Applications.deposit.ws_dep_seqmanage_ctrl.ws_dep_seqmanage" %>
<%@ Register Src="DsMain.ascx" TagName="DsMain" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <script type="text/javascript">
         var dsMain = new DataSourceTool();

         function OnDsMainClicked(s, r, c) {
             if (c == "update_seq") {
                 update_seq();
             } else if (c == "update_balance") {
                 update_balance();
             } else if (c == "update_money") {
                 update_money();
             } else if (c == "check_seq") {
                 check_seq();
             } else if (c == "check_balance") {
                 check_balance();
             } else if (c == "check_money") {
                 check_money();
             }
         }

     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlace" runat="server">
    <uc1:DsMain ID="dsMain" runat="server" />
    <br />
   
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" class="DataSourceRepeater"  Width="100%" ShowHeader="true" >
            <Columns>
                 <asp:BoundField DataField="seq_no" HeaderText="ลำดับ" >
                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                </asp:BoundField>
                <asp:BoundField DataField="deptaccount_no" HeaderText="เลขที่บัญชี" >
                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                </asp:BoundField>                            
                <asp:BoundField DataField="deptaccount_name" HeaderText="ชื่อบัญชี" >
                        <ItemStyle HorizontalAlign="Left" Width="25%" />
                </asp:BoundField>
                <asp:BoundField DataField="mst" HeaderText="ลำดับรายการ(หลัก)" DataFormatString="{0:#,##0}">
                        <ItemStyle HorizontalAlign="Center" Width="8%" />
                </asp:BoundField>
                <asp:BoundField DataField="stm" HeaderText="ลำดับรายการ" DataFormatString="{0:#,##0}">
                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                </asp:BoundField>
                <asp:BoundField DataField="mprn" HeaderText="ต้นเงิน(หลัก)" DataFormatString="{0:#,##0}">
                        <ItemStyle HorizontalAlign="Right" Width="5%" />
                </asp:BoundField>     
                <asp:BoundField DataField="sprn" HeaderText="ต้นเงิน" DataFormatString="{0:#,##0}">
                        <ItemStyle HorizontalAlign="Right" Width="5%" />
                </asp:BoundField> 
                <asp:BoundField DataField="prncbal" HeaderText="จำนวนเงิน" DataFormatString="{0:#,##0.00}">
                        <ItemStyle HorizontalAlign="Right" Width="10%" />
                </asp:BoundField>    
             </Columns> 
        </asp:GridView>    
</asp:Content>
