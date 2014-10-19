<%@ Page Language="VB" MasterPageFile="~/St1-MasterPage.master" Title="未命名頁面" %>

<script runat="server">

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("OK_class") = Me.DropDownList1.SelectedValue
        Session("t_day") = Me.DropDownList2.SelectedValue
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
    .style5
    {
        font-size: x-large;
        font-family: 標楷體;
        font-weight: bold;
    }
    .style12
    {
        font-size: x-large;
    }
    .style13
    {
        font-family: 金梅樹枝美工字體;
    }
    .style15
    {
        font-family: 金梅黑框浮體字形;
        font-size: xx-large;
            font-weight: bold;
        }
    .style16
    {
        width: 717px;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1" style="width: 98%">
        <tr>
            <td style="text-align: center">
                <span class="style12"><span class="style13"><b>
                <br />
                </b>
                </span></span>
                <span class="style16"><span class="style15">成績查詢</span></span><b><span class="style12"><span class="style13"><br />
                <br />
                課程：<asp:DropDownList 
                    ID="DropDownList1" runat="server" 
                    DataSourceID="SqlDataSource2" DataTextField="課程名稱" DataValueField="課程編號" 
                    style="font-size: large; font-family: 金梅樹枝美工字體; font-weight: 700">
                </asp:DropDownList>
                </span></span>
                </b>　<asp:Label ID="Label2" runat="server" Text="測驗日期：" 
                    style="font-size: x-large; font-weight: 700"></asp:Label>
                <asp:DropDownList ID="DropDownList2" runat="server" 
                    DataSourceID="SqlDataSource3" DataTextField="測驗日期" DataValueField="測驗日期" 
                    style="font-size: large; font-weight: 700">
                </asp:DropDownList>
                <span class="style13"><b>&nbsp;<asp:Button ID="Button1" 
                    runat="server" onclick="Button1_Click" Text="查詢" BackColor="#FF9933" 
                    BorderColor="#999999" Height="28px" 
                    style="font-size: large; font-family: 金梅樹枝美工字體; font-weight: 700" 
                    BorderStyle="Outset" />
                </b></span>　<asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    SelectCommand="SELECT 課程.課程編號, 課程.課程名稱 FROM 課程 INNER JOIN 開課 ON 課程.課程編號 = 開課.課程編號 INNER JOIN 修課 ON 開課.開課編號 = 修課.修課編號 WHERE (修課.學號 = @學號)">
                    <SelectParameters>
                        <asp:SessionParameter Name="學號" SessionField="OK_STU" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    SelectCommand="SELECT DISTINCT 測驗日期 FROM 應試"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSource1" HorizontalAlign="Center" BackColor="#DEBA84" 
                    BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                    CellSpacing="2" 
                    style="font-size: large; font-family: 金梅樹枝美工字體; font-weight: 700;">
                    <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                    <Columns>
                        <asp:BoundField DataField="學號" HeaderText="學號" SortExpression="學號" />
                        <asp:BoundField DataField="課程名稱" HeaderText="課程名稱" SortExpression="課程名稱" />
                        <asp:BoundField DataField="測試成績" HeaderText="測試成績" SortExpression="測試成績" />
                        <asp:BoundField DataField="所屬章節" HeaderText="所屬章節" SortExpression="所屬章節" />
                        <asp:BoundField DataField="測驗日期" HeaderText="測驗日期" SortExpression="測驗日期" />
                    </Columns>
                    <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    
                    
                    SelectCommand="SELECT DISTINCT 答案卡.學號, 課程.課程名稱, 應試.測試成績, 命題範圍.所屬章節, 應試.測驗日期 FROM 答案卡 INNER JOIN 題庫 ON 答案卡.題目編號 = 題庫.題目編號 INNER JOIN 課程 ON 題庫.課程編號 = 課程.課程編號 INNER JOIN 應試 ON 答案卡.答案卡編號 = 應試.答案卡編號 INNER JOIN 命題範圍 ON 應試.試卷編號 = 命題範圍.試卷編號 WHERE (答案卡.學號 = @學號) AND (題庫.課程編號 = @課程編號) AND (應試.測驗日期 = @測驗日期)">
                    <SelectParameters>
                        <asp:SessionParameter Name="學號" SessionField="OK_STU" />
                        <asp:SessionParameter Name="課程編號" SessionField="OK_class" />
                        <asp:SessionParameter DefaultValue="" Name="測驗日期" SessionField="t_day" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>

