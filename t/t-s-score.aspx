<%@ Page Language="VB" MasterPageFile="~/t/t-MasterPage.master" Title="OTS:Online Test System" %>

<script runat="server">

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("class_name_no") = DropDownList1.SelectedValue
        Session("class_no") = DropDownList2.SelectedValue
        Session("t_day") = DropDownList3.SelectedValue
        Me.GridView1.Visible = True
        Me.Label2.Visible = False
        Me.DropDownList3.Visible = False
        Me.Button1.Visible = False
        Me.Button2.Visible = True
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("class_no") = DropDownList2.SelectedValue
    End Sub

    Protected Sub Button2_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("class_no") = DropDownList2.SelectedValue
        Me.Label2.Visible = True
        Me.DropDownList3.Visible = True
        Me.Button1.Visible = True
        Me.Button2.Visible = False
        Me.GridView1.Visible = False
    End Sub
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../javascripts/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../javascripts/jquery.curvycorners.min.js" type="text/javascript"></script>
    <script src="../javascripts/corner.js" type="text/javascript"></script>
    <script src="../javascripts/wait.js" type="text/javascript"></script>
    <script src="../javascripts/T-display.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="../style.css" />
    <style type="text/css">
        .style7
        {
            font-family: 金梅黑框浮體字形;
            font-weight: bold;
            font-size: xx-large;
        }
        .style9
        {
            font-size: x-large;
            font-weight: bold;
        }
        .style10
        {
            font-size: x-large;
        }
        .style11
        {
            width: 100%;
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="Main" class="Main">
        <div id="container2" class="container2">
            <div id="mainContent">
                <table style="width: 100%;">
                    <tr>
                        <td style="text-align: center;border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: #C0C0C0;
                            height: 30px;">
                            <asp:Label ID="Label_notice" runat="server" Font-Bold="True" ForeColor="Red" 
                                Font-Size="XX-Large">成績列表</asp:Label>
                        </td>
                    </tr>
                </table>
                <div id="Div_UpdateProgress" style="width: 100%; height: 20px; margin-right: auto;
                    position: static;">
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0">
                        <ProgressTemplate>
                            <div style="text-align: center;">
                                <img alt="loading" src="../images/ajax-loader.gif" /></div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </div>
                <div id="MutiView">
                    <asp:MultiView ID="MultiView_Main" runat="server" ActiveViewIndex="0">
                        <asp:View ID="View1" runat="server">
                         
                            <table align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <table class="style11">
                                      
                                                <td class="style11">
                                                 
                                                
                                                    <span><b><span class="style10">&nbsp;&nbsp; 班級：<asp:DropDownList ID="DropDownList1"
                                                        runat="server" DataSourceID="SqlDataSource1" DataTextField="班級別" DataValueField="班級編號"
                                                        Style="font-weight: 700; font-size: large;">
                                                    </asp:DropDownList>
                                                        &nbsp; 課程：<asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource3"
                                                            DataTextField="課程名稱" DataValueField="課程編號" Style="font-weight: 700; font-size: large;">
                                                        </asp:DropDownList>
                                                        &nbsp;<asp:Button ID="Button2" runat="server" BackColor="#6699FF" BorderColor="#999999"
                                                            BorderStyle="Outset" Height="24px" OnClick="Button2_Click1" Style="font-weight: 700;
                                                            font-size: large" Text="確認" />
                                                        &nbsp;<br />
                                                        <asp:Label ID="Label2" runat="server" Text="測驗日期：" Visible="False"></asp:Label>
                                                        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource4"
                                                            DataTextField="測驗日期" DataValueField="測驗日期" Style="font-weight: 700; font-size: large;"
                                                            Visible="False">
                                                        </asp:DropDownList>
                                                    </span></b></span><span class="style8"><span class="style9">
                                                        <asp:Button ID="Button1" runat="server" BackColor="#6699FF" BorderColor="#999999"
                                                            BorderStyle="Outset" Height="22px" OnClick="Button1_Click" Style="font-size: large;
                                                            font-weight: 700" Text="查詢" Visible="False" Width="49px" />
                                                    </span></span>
                                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                                        SelectCommand="SELECT [班級編號], [班級別] FROM [班級]"></asp:SqlDataSource>
                                                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                                        SelectCommand="SELECT DISTINCT 課程.課程編號, 課程.課程名稱 FROM 開課 INNER JOIN 課程 ON 開課.課程編號 = 課程.課程編號">
                                                    </asp:SqlDataSource>
                                                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                                        SelectCommand="SELECT DISTINCT 課程.課程編號, 應試.測驗日期 FROM 題庫 INNER JOIN 課程 ON 題庫.課程編號 = 課程.課程編號 INNER JOIN 試題 ON 題庫.題目編號 = 試題.題目編號 INNER JOIN 命題範圍 ON 試題.試卷編號 = 命題範圍.試卷編號 INNER JOIN 應試 ON 命題範圍.試卷編號 = 應試.試卷編號 WHERE (課程.課程編號 = @課程編號)">
                                                        <SelectParameters>
                                                            <asp:SessionParameter Name="課程編號" SessionField="class_no" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                        BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px"
                                                        CellPadding="3" CellSpacing="2" DataKeyNames="學號" DataSourceID="SqlDataSource2"
                                                        HorizontalAlign="Center" Style="font-size: large; font-weight: 700" Visible="False">
                                                        <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                                                        <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                                                        <Columns>
                                                            <asp:BoundField DataField="學號" HeaderText="學號" ReadOnly="True" SortExpression="學號" />
                                                            <asp:BoundField DataField="班級別" HeaderText="班級別" SortExpression="班級別" />
                                                            <asp:BoundField DataField="課程名稱" HeaderText="課程名稱" SortExpression="課程名稱" />
                                                            <asp:BoundField DataField="測試成績" HeaderText="測試成績" SortExpression="測試成績" />
                                                            <asp:BoundField DataField="測驗日期" HeaderText="測驗日期" SortExpression="測驗日期" />
                                                        </Columns>
                                                        <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                                                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                                                        <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                                                    </asp:GridView>
                                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                                        SelectCommand="SELECT DISTINCT 學生.學號, 班級.班級別, 課程.課程名稱, 應試.測試成績, 應試.測驗日期 FROM 學生 INNER JOIN 班級 ON 學生.班級編號 = 班級.班級編號 INNER JOIN 開課 ON 班級.班級編號 = 開課.班級編號 INNER JOIN 課程 ON 開課.課程編號 = 課程.課程編號 INNER JOIN 答案卡 ON 學生.學號 = 答案卡.學號 INNER JOIN 應試 ON 答案卡.答案卡編號 = 應試.答案卡編號 INNER JOIN 命題範圍 ON 應試.試卷編號 = 命題範圍.試卷編號 WHERE (班級.班級編號 = @班級編號) AND (課程.課程編號 = @課程編號) AND (應試.測驗日期 = @測驗日期)">
                                                        <SelectParameters>
                                                            <asp:SessionParameter Name="班級編號" SessionField="class_name_no" />
                                                            <asp:SessionParameter Name="課程編號" SessionField="class_no" />
                                                            <asp:SessionParameter DefaultValue="" Name="測驗日期" SessionField="t_day" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:View>
                    </asp:MultiView>
                </div>
                <!-- end #mainContent -->
            </div>
            <!-- end #container -->
        </div>
    </div>
</asp:Content>
