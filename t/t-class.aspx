<%@ Page Language="VB" MasterPageFile="~/t/t-MasterPage.master" Title="OTS:Online Test System" %>

<script runat="server">
        
    Protected Sub Button6_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Me.FormView2.Visible = False Then
            Me.FormView2.Visible = True
            Me.GridView2.Visible = True
        ElseIf Me.FormView2.Visible = True Then
            Me.FormView2.Visible = False
        End If
        
    End Sub

    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Me.GridView2.Visible = True Then
            Me.GridView2.Visible = False
        ElseIf Me.GridView2.Visible = False Then
            Me.GridView2.Visible = True
        End If
        Me.FormView2.Visible = False
    End Sub

    Protected Sub InsertButton_Click1(ByVal sender As Object, ByVal e As System.EventArgs)

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
               .style5
        {
            width: 100%;
        }


        .style12
        {
            font-size: xx-large;
            font-family: 金梅黑框浮體字形;
            font-weight: bold;
        }
        .style9
        {
            font-size: x-large;
            font-family: 標楷體;
        }
        .style10
        {
            font-size: xx-large;
            font-family: 金梅黑框浮體字形;
            font-weight: 700;
        }
        .style11
        {
            font-size: x-large;
        }
        .style13
    {
        font-size: x-large;
        font-family: 金梅樹枝美工字體;
        font-weight: bold;
    }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="Main" class="Main">
        <div id="container2" class ="container2">
            <div id="mainContent0">
 <table style="width: 100%; text-align: center;">
                                <tr>
                                    <td style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: #C0C0C0;
                                        height: 30px;">
                                        <asp:Label ID="Label_notice" runat="server" Font-Bold="True" ForeColor="Red" Font-Size="XX-Large">課程規劃</asp:Label>
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
                                    <asp:View ID="View1" runat="server">
                                        <table align="center" cellpadding="0" cellspacing="0" class="style5">
                                            <tr>
                                                <td>
                                                    <table class="style5">
                                                                                                                <tr>
                                                            <td style="text-align: center">
                                                                <asp:FormView ID="FormView2" runat="server" BackColor="#DEBA84" 
                                                                    BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                                                                    CellSpacing="2" DataKeyNames="課程編號" DataSourceID="SqlDataSource2" 
                                                                    DefaultMode="Insert" GridLines="Both" HorizontalAlign="Center" 
                                                                    style="font-family: 金梅樹枝美工字體">
                                                                    <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                                                                    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                                                                    <EditItemTemplate>
                                                                        課程編號:
                                                                        <asp:Label ID="課程編號Label1" runat="server" Text='<%# Eval("課程編號") %>' />
                                                                        <br />
                                                                        課程名稱:
                                                                        <asp:TextBox ID="課程名稱TextBox" runat="server" Text='<%# Bind("課程名稱") %>' />
                                                                        <br />
                                                                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                                                                            CommandName="Update" Text="更新" />
                                                                        &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                                                                            CausesValidation="False" CommandName="Cancel" Text="取消" />
                                                                    </EditItemTemplate>
                                                                    <InsertItemTemplate>
                                                                        <span class="style9">&nbsp;</span><span class="style10">新增課程<br /> </span>
                                                                        <br />
                                                                        <b><span class="style11">&nbsp;課程名稱:
                                                                        <asp:TextBox ID="課程名稱TextBox0" runat="server" 
                                                                            style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large;" 
                                                                            Text='<%# Bind("課程名稱") %>' />
                                                                        </span>
                                                                        <br class="style11" />
                                                                        <span class="style11">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                                                            ControlToValidate="課程名稱TextBox0" Display="Dynamic" 
                                                                            ErrorMessage="RequiredFieldValidator" style="font-size: large">請輸入課程名稱!</asp:RequiredFieldValidator>
                                                                        &nbsp;
                                                                        <br />
                                                                        &nbsp;&nbsp;
                                                                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                                                                            CommandName="Insert" onclick="InsertButton_Click1" Text="登錄" />
                                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                                                                            CausesValidation="False" CommandName="Cancel" Text="取消" />
                                                                        </span></b>
                                                                    </InsertItemTemplate>
                                                                    <ItemTemplate>
                                                                        課程編號:
                                                                        <asp:Label ID="課程編號Label" runat="server" Text='<%# Eval("課程編號") %>' />
                                                                        <br />
                                                                        課程名稱:
                                                                        <asp:Label ID="課程名稱Label" runat="server" Text='<%# Bind("課程名稱") %>' />
                                                                        <br />
                                                                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" 
                                                                            CommandName="Edit" Text="編輯" />
                                                                        &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" 
                                                                            CommandName="Delete" Text="刪除" />
                                                                        &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" 
                                                                            CommandName="New" Text="新增" />
                                                                    </ItemTemplate>
                                                                    <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                                                                    <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                                                                    <EditRowStyle BackColor="#FFF7E7" Font-Bold="True" ForeColor="#8C4510" />
                                                                </asp:FormView>
                                                                <br />
                                                                <span class="style13">已開設課程</span><br />
                                                                <br />
                                                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                                                                    BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" 
                                                                    CellPadding="3" CellSpacing="2" DataKeyNames="課程編號" 
                                                                    DataSourceID="SqlDataSource2" HorizontalAlign="Center" 
                                                                    style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large">
                                                                    <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                                                                    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                                                                    <Columns>
                                                                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                                                                        <asp:BoundField DataField="課程名稱" HeaderText="課程名稱" SortExpression="課程名稱" />
                                                                    </Columns>
                                                                    <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                                                                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                                                                    <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                                                    ConflictDetection="CompareAllValues" 
                                                                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                                                    DeleteCommand="DELETE FROM [課程] WHERE [課程編號] = @original_課程編號 AND (([課程名稱] = @original_課程名稱) OR ([課程名稱] IS NULL AND @original_課程名稱 IS NULL))" 
                                                                    InsertCommand="INSERT INTO [課程] ([課程名稱]) VALUES (@課程名稱)" 
                                                                    OldValuesParameterFormatString="original_{0}" 
                                                                    SelectCommand="SELECT * FROM [課程]" 
                                                                    UpdateCommand="UPDATE [課程] SET [課程名稱] = @課程名稱 WHERE [課程編號] = @original_課程編號 AND (([課程名稱] = @original_課程名稱) OR ([課程名稱] IS NULL AND @original_課程名稱 IS NULL))">
                                                                    <DeleteParameters>
                                                                        <asp:Parameter Name="original_課程編號" Type="Byte" />
                                                                        <asp:Parameter Name="original_課程名稱" Type="String" />
                                                                    </DeleteParameters>
                                                                    <UpdateParameters>
                                                                        <asp:Parameter Name="課程名稱" Type="String" />
                                                                        <asp:Parameter Name="original_課程編號" Type="Byte" />
                                                                        <asp:Parameter Name="original_課程名稱" Type="String" />
                                                                    </UpdateParameters>
                                                                    <InsertParameters>
                                                                        <asp:Parameter Name="課程名稱" Type="String" />
                                                                    </InsertParameters>
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

