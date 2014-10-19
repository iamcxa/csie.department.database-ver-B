<%@ Page Language="VB" MasterPageFile="~/St1-MasterPage.master" Title="未命名頁面" %>

<script runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.GridView1.DataBind()
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.Session("chapter") = Me.DropDownList2.Text
        Response.Redirect("test-page.aspx")
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.Session("class_test") = Me.DropDownList1.Text
        Me.Label2.Visible = True
        Me.DropDownList2.Visible = True
        Me.Button1.Visible = True
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
    .style12
    {
        font-size: x-large;
        font-weight: bold;
    }
    .style13
    {
        text-align: center;
        font-size: xx-large;
        font-family: 金梅黑框浮體字形;
        font-weight: bold;
    }
        .style14
        {
            font-size: xx-large;
            font-family: 金梅黑框浮體字形;
            height: 26px;
            width: 685px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1" style="width: 99%">
    <tr>
        <td style="text-align: center; font-size: large; font-family: 金梅樹枝美工字體;">
            <br />
            <span class="style12">
            <span class="style14">選擇考科<br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </span>課程：</span><asp:DropDownList ID="DropDownList1" runat="server" 
                DataSourceID="SqlDataSource2" DataTextField="課程名稱" DataValueField="課程編號" 
                Font-Names="金梅樹枝美工字體" Font-Size="Medium" style="font-weight: 700">
            </asp:DropDownList>
            <asp:Button ID="Button2" runat="server" onclick="Button2_Click" Text="選擇課程" 
                BackColor="#FF9933" BorderColor="#999999" Font-Names="金梅樹枝美工字體" Font-Size="Medium" 
                style="font-weight: 700" BorderStyle="Outset" Height="27px" />
            　<br />
            <asp:Label ID="Label2" runat="server" Text="試卷名稱：" Visible="False" 
                style="font-size: x-large; font-weight: 700"></asp:Label>
            <asp:DropDownList ID="DropDownList2" runat="server" 
                DataSourceID="SqlDataSource3" DataTextField="所屬章節" DataValueField="所屬章節" 
                Visible="False" 
                style="font-size: medium; font-family: 金梅樹枝美工字體; font-weight: 700">
            </asp:DropDownList>
            <asp:Button ID="Button1" runat="server" Text="進入考場" onclick="Button1_Click" 
                Visible="False" BackColor="#FF9933" BorderColor="#999999" Height="26px" 
                style="font-size: medium; font-family: 金梅樹枝美工字體; font-weight: 700" />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                
                SelectCommand="SELECT 課程.課程名稱, 開課.課程編號 FROM 課程 INNER JOIN 開課 ON 課程.課程編號 = 開課.課程編號 INNER JOIN 修課 ON 開課.開課編號 = 修課.修課編號 INNER JOIN 學生 ON 修課.學號 = 學生.學號 WHERE (學生.學號 = @學號)">
                <SelectParameters>
                    <asp:SessionParameter Name="學號" SessionField="OK_STU" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT DISTINCT 命題範圍.所屬章節, 試卷.課程編號 FROM 試卷 INNER JOIN 命題範圍 ON 試卷.試卷編號 = 命題範圍.試卷編號 WHERE (試卷.課程編號 = @課程編號)">
                <SelectParameters>
                    <asp:SessionParameter Name="課程編號" SessionField="class_test" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td class="style13">
            考試課程<br />
            <br />
        </td>
    </tr>
    <tr>
        <td>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="學號" DataSourceID="SqlDataSource1" AllowPaging="True" 
                AllowSorting="True" HorizontalAlign="Center" BackColor="#DEBA84" 
                BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                CellSpacing="2" 
                style="font-size: large; font-family: 金梅樹枝美工字體; font-weight: 700;">
                <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                <Columns>
                    <asp:BoundField DataField="課程名稱" HeaderText="課程名稱" SortExpression="課程名稱" />
                    <asp:TemplateField HeaderText="章節" SortExpression="所屬章節">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("所屬章節") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("所屬章節") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
            </asp:GridView>
        </td>
    </tr>
    <tr>
        <td>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                
                SelectCommand="SELECT DISTINCT 題庫.課程編號, 課程.課程名稱, 學生.學號, 命題範圍.所屬章節 FROM 開課 INNER JOIN 題庫 INNER JOIN 課程 ON 題庫.課程編號 = 課程.課程編號 ON 開課.課程編號 = 課程.課程編號 INNER JOIN 修課 INNER JOIN 學生 ON 修課.學號 = 學生.學號 ON 開課.開課編號 = 修課.修課編號 INNER JOIN 試卷 ON 課程.課程編號 = 試卷.課程編號 INNER JOIN 命題範圍 ON 試卷.試卷編號 = 命題範圍.試卷編號 WHERE (學生.學號 = @學號)">
                <SelectParameters>
                    <asp:SessionParameter Name="學號" SessionField="OK_STU" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
</table>
</asp:Content>

