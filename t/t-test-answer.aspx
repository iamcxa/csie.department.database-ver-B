<%@ Page Language="VB" MasterPageFile="~/t/t-MasterPage.master" Title="OTS:Online Test System" %>

<script runat="server">

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.Session("class") = Me.DropDownList1.Text
        Me.Session("chapetr_select") = Me.DropDownList2.Text
        Me.GridView1.DataBind()
        Me.Button1.Visible = False
        Me.DropDownList2.Visible = False
        Me.Label11.Visible = False
    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.Session("class") = Me.DropDownList1.Text
        Me.Label11.Visible = True
        Me.DropDownList2.Visible = True
        Me.Button1.Visible = True
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../javascripts/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../javascripts/jquery.curvycorners.min.js" type="text/javascript"></script>
    <script src="../javascripts/corner.js" type="text/javascript"></script>
    <script src="../javascripts/wait.js" type="text/javascript"></script>
    <script src="../javascripts/T-display.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="../style.css" />
    <style type="text/css">
        .style7
        {
            height: 49px;
        }
        .style8
        {
            font-size: xx-large;
            font-family: 金梅黑框浮體字形;
            text-align: center;
        }
        .style9
        {
            text-align: center;
        }
        .style10
        {
            font-size: x-large;
            font-family: 金梅樹枝美工字體;
            text-align: center;
            font-weight: bold;
        }
    
        .Main
        {
              margin-top: -0px;

            }
        .container2
        {
            
            background: #FFFFFF url('../images/bg.jpg') no-repeat fixed 50% 0%;
            height: 100%;
            width: 1000px; /* 這樣將會建立為 80% 瀏覽器寬度的容器 */
            margin: 0 auto; /* 自動邊界 (搭配寬度) 會讓頁面置中對齊 */
            border: 1px solid #CCCCCC;
            text-align: left; /* 這樣做會覆寫 Body 元素上的 text-align: center。 */
            
             
        }
        

            .style64
        {
            text-align: center;
            font-family: Corbel;
            font-size: 12px;
            color: #FFFFFF;
        }
        
        
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

        <div id="Main" class="Main">
        <div id="container2" class ="container2">
            <div id="mainContent">
                            <table style="width: 100%;">
                                <tr>
                                    <td style="border-bottom: 1px solid #C0C0C0; height: 30px; text-align: center;">
                                        <asp:Label ID="Label_notice" runat="server" Font-Bold="True" ForeColor="Red" Font-Size="XX-Large">答案編輯</asp:Label>
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
                                <asp:MultiView ID="MultiView_Notice" runat="server">
                                </asp:MultiView>
                                <asp:MultiView ID="MultiView_Main" runat="server" ActiveViewIndex="0">
                                 
                                    <asp:View ID="View_ADDNotice" runat="server">
                                            <table class="style1">
    <tr>
        <td class="style9">

            <span class="style10">課程：</span><span class="style8"><asp:DropDownList 
                ID="DropDownList1" runat="server" 
                DataSourceID="SqlDataSource2" DataTextField="課程名稱" DataValueField="課程編號" 
                    onselectedindexchanged="DropDownList1_SelectedIndexChanged" 
                style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large" 
                Height="24px">
            </asp:DropDownList>
            &nbsp;<asp:Button ID="Button2" runat="server" onclick="Button2_Click" 
                Text="查詢" BackColor="#6699FF" BorderColor="#999999" Height="23px" 
                style="font-family: 金梅樹枝美工字體; font-size: large; font-weight: 700" 
                BorderStyle="Outset" />
            <br />
            <asp:Label ID="Label11" runat="server" Text="章節：" Visible="False" 
                style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: x-large"></asp:Label>
            <asp:DropDownList ID="DropDownList2" runat="server" Visible="False" 
                DataSourceID="SqlDataSource3" DataTextField="所屬章節" DataValueField="所屬章節" 
                style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large">
            </asp:DropDownList>
            &nbsp;<asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="確認" 
                BackColor="#6699FF" BorderColor="#999999" Height="23px" 
                style="font-size: large; font-family: 金梅樹枝美工字體; font-weight: 700" 
                Width="56px" Visible="False" BorderStyle="Outset" />
            </span>
        </td>
    </tr>
    <tr>
        <td>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                DataSourceID="SqlDataSource1" AllowPaging="True" 
                AllowSorting="True" HorizontalAlign="Center" BackColor="#DEBA84" 
                BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                CellSpacing="2" 
                style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: small" 
                DataKeyNames="選項編號">
                <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                <Columns>
                    <asp:CommandField ShowEditButton="True" />
                    <asp:TemplateField HeaderText="選項編號" InsertVisible="False" 
                        SortExpression="選項編號">
                        <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("選項編號") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("選項編號") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="題目編號" SortExpression="題目編號">
                        <EditItemTemplate>
                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("題目編號") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("題目編號") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="答案選項敘述" SortExpression="答案選項敘述">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("答案選項敘述") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("答案選項敘述") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="題目敘述" SortExpression="題目敘述">
                        <EditItemTemplate>
                            <asp:Label ID="Label8" runat="server" Text='<%# Bind("題目敘述") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("題目敘述") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="正確解答選項" SortExpression="正確解答選項">
                        <EditItemTemplate>
                            <asp:Label ID="Label9" runat="server" Text='<%# Bind("正確解答選項") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("正確解答選項") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="所屬章節" SortExpression="所屬章節">
                        <EditItemTemplate>
                            <asp:Label ID="Label10" runat="server" Text='<%# Bind("所屬章節") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("所屬章節") %>'></asp:Label>
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
        <td class="style7">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT 答案.選項編號, 答案.題目編號, 答案.答案選項敘述, 題庫.課程編號, 題庫.題目敘述, 題庫.正確解答選項, 題庫.所屬章節 FROM 答案 INNER JOIN 題庫 ON 答案.題目編號 = 題庫.題目編號 WHERE (題庫.課程編號 = @課程編號) AND (題庫.所屬章節 = @所屬章節)" 
                
                
                UpdateCommand="UPDATE 答案 SET 答案選項敘述 = @答案選項敘述 WHERE (選項編號 = @選項編號)">
                <SelectParameters>
                    <asp:SessionParameter Name="課程編號" SessionField="class" />
                    <asp:SessionParameter Name="所屬章節" SessionField="chapetr_select" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="答案選項敘述" Type="String" />
                    <asp:Parameter Name="選項編號" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                
                SelectCommand="SELECT DISTINCT 課程編號, 課程名稱 FROM 課程"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                
                SelectCommand="SELECT DISTINCT 題庫.所屬章節, 課程.課程編號 FROM 題庫 INNER JOIN 課程 ON 題庫.課程編號 = 課程.課程編號 WHERE (課程.課程編號 = @課程編號)">
                <SelectParameters>
                    <asp:SessionParameter Name="課程編號" SessionField="class" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
</table>
                                    
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        </asp:UpdatePanel>
                                    </asp:View>
                                </asp:MultiView>
                            </div>

                <!-- end #mainContent -->
            </div>
            <!-- end #container -->
        </div>
    </div>
    

    <div class="style64">
        - Powered-by-許鈞霆/陳獻欽/陳紀緯-©2011-CSU-CSIE - 99學年度學生專題 -
    </div>
        

</asp:Content>

