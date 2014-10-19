<%@ Page Language="VB" MasterPageFile="~/t/t-MasterPage.master" Title="OTS:Online Test System"  %>
<script runat="server">
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub SqlDataSource1_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs)
        
            
    End Sub
    Public Sub MsgBox(ByVal Message As String)
        Dim sScript As String
        Dim sMessage As String

        sMessage = Strings.Replace(Message, "'", "\'") '處理單引號
        sMessage = Strings.Replace(sMessage, vbNewLine, "\n") '處理換行
        sScript = String.Format("alert('{0}');", sMessage)
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", sScript, True)
    End Sub
    Protected Sub UpdateButton_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        MsgBox("即將登出，請重新登入！")
        Session.RemoveAll()
        FormsAuthentication.SignOut()
        Me.Response.Redirect("../login.aspx", False)
    End Sub

    Protected Sub InsertButton_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.Response.Redirect("t-data.aspx", False)
    End Sub

    Protected Sub InsertCancelButton_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.Response.Redirect("t-data.aspx", True )
    End Sub


    Protected Sub LinkButton_Config_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Me.CheckBox_IsDebug.Checked = True Then
            Application("IsDebug") = True
        Else
            Application("IsDebug") = False
        End If
        
        If Me.CheckBox_IsReg.Checked = True Then
            Application("IsReg") = True
        ElseIf Me.CheckBox_IsReg.Checked = False Then
            Application("IsReg") = False
        End If
        Dim sMessage As String
        sMessage = "DeBugMode is : " & Application("IsDebug") & vbNewLine & "Student Reg is : " & Application("IsReg")
        MsgBox(sMessage)
        
    End Sub

    Protected Sub LinkButton_ADDNotice_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.MultiView_Main.ActiveViewIndex = 1
        CType(Me.FormView_ADDNotice.FindControl("IDTextBox0"), TextBox).Text = Now
        CType(Me.FormView_ADDNotice.FindControl("TimeTextBox"), TextBox).Text = Now.Date
    End Sub

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As System.EventArgs)
        If Application("IsDebug") = False Then
            Me.CheckBox_IsDebug.Checked = False
        ElseIf Application("IsDebug") = True Then
            Me.CheckBox_IsDebug.Checked = True
        End If
        If Application("IsReg") = False Then
            Me.CheckBox_IsReg.Checked = False
        ElseIf Application("IsReg") = True Then
            Me.CheckBox_IsReg.Checked = True
        End If
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
            .style64
        {
            text-align: center;
            font-family: Corbel;
            font-size: 12px;
            color: #FFFFFF;
        }
        
        .style21
        {
            width: 100%;           
        }
                
        .style70
        {
            width: 170px;
        }
                        
        </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="Main" class="Main">
        <div id="container2" class ="container2">
            <div id="mainContent">
                            <table style="width: 100%;">
                                <tr>
                                    <td style=" text-align:center ;border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: #C0C0C0;
                                        height: 30px;">
                                        <asp:Label ID="Label_notice" runat="server" Font-Bold="True" ForeColor="Red">※首次使用請更改基本資料</asp:Label>
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
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                        <asp:MultiView ID="MultiView_Notice" runat="server" ActiveViewIndex="0">
                                            <asp:View ID="View_Notice" runat="server">
                                                <table class="style21">
                                                    <tr>
                                                        <td class="style70" style="text-align: center;">
                                                                                                                     <asp:Image ID="Image7" runat="server" ImageUrl="~/images/notice.png" />
                                                            <br />
                                                            <asp:LinkButton ID="LinkButton_ADDNotice" runat="server" 
                                                                onclick="LinkButton_ADDNotice_Click">添加新公告</asp:LinkButton>
                                                    <br />
                                                        </td>
                                                        <td style="width: 85%; text-align: left; border-left-style: solid; border-left-width: 1px;
                                                    border-left-color: #C0C0C0; padding-left: 20px">
                                                            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                                                                AutoGenerateColumns="False" AutoGenerateDeleteButton="True" 
                                                                AutoGenerateEditButton="True" DataKeyNames="ID" 
                                                                DataSourceID="NoticeADD_SqlDataSource" EnableModelValidation="True" 
                                                                GridLines="None" ShowHeader="False" Style="text-align: left" Width="100%">
                                                                <Columns>
                                                                    <asp:BoundField ApplyFormatInEditMode="True" DataField="Time" 
                                                                        DataFormatString="{0:yyyy-MM-dd}" HeaderText="Time" SortExpression="Time" >
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="NoticeText" HeaderText="NoticeText" 
                                                                        SortExpression="NoticeText">
                                                                    <ControlStyle Width="500px" />
                                                                    <ItemStyle Width="500px" />
                                                                    </asp:BoundField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:View>
                                        </asp:MultiView>
                                        <asp:MultiView ID="MultiView_Main" runat="server" ActiveViewIndex="0">
                                            <asp:View ID="View_Cantlogin" runat="server">
                                                <table class="style21" style="width: 100%">
                                                    <tr>
                                                        <td class="style70" style="text-align: center;">
                                                            <asp:Timer ID="Timer1" runat="server" ontick="Timer1_Tick">
                                                            </asp:Timer>
                                                            <asp:Image ID="Image8" runat="server" ImageUrl="~/images/setting.png" />
                                                    <br />
                                                            <asp:CheckBox ID="CheckBox_IsDebug" runat="server" Text="偵錯模式？" />
                                                    
                                                    <br />
                                                            <asp:CheckBox ID="CheckBox_IsReg" runat="server" Text="開放註冊？" />
                                                    <br />
                                                            <asp:LinkButton ID="LinkButton_Config" runat="server" CausesValidation="False" 
                                                                onclick="LinkButton_Config_Click">確定</asp:LinkButton>
                                                        </td>
                                                        <td style="width: 85%; text-align: left; border-left-style: solid; border-left-width: 1px;
                                                    border-left-color: #C0C0C0; padding-left: 20px">
                                                            <asp:FormView ID="FormView1" runat="server" CellPadding="4" DataKeyNames="ID" 
                                                                DataSourceID="SqlDataSource1" EnableModelValidation="True" ForeColor="#333333" 
                                                                style="font-size: x-large;font-weight: 700; text-align: left" 
                                                                Width="400px">
                                                                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                                                                <RowStyle BackColor="#E3EAEB" />
                                                                <EditItemTemplate>
                                                                    <table class="style14">
                                                                        <tr>
                                                                            <td class="style13">
                                                                                帳號</td>
                                                                            <td class="style15">
                                                                                :<asp:TextBox ID="帳號TextBox" runat="server" 
                                                                                    style="font-family: 金梅樹枝美工字體; font-weight: 700" Text='<%# Bind("帳號") %>' />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style13">
                                                                                密碼</td>
                                                                            <td class="style15">
                                                                                :<asp:TextBox ID="密碼TextBox" runat="server" 
                                                                                    style="font-family: 金梅樹枝美工字體; font-weight: 700" Text='<%# Bind("密碼") %>' />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style13">
                                                                                姓名</td>
                                                                            <td class="style15">
                                                                                :<asp:TextBox ID="姓名TextBox" runat="server" 
                                                                                    style="font-family: 金梅樹枝美工字體; font-weight: 700" Text='<%# Bind("姓名") %>' />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style13">
                                                                                郵件地址</td>
                                                                            <td class="style15">
                                                                                :<asp:TextBox ID="郵件地址TextBox" runat="server" 
                                                                                    style="font-family: 金梅樹枝美工字體; font-weight: 700" Text='<%# Bind("郵件地址") %>' />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style13">
                                                                                系別</td>
                                                                            <td class="style15">
                                                                                :<asp:TextBox ID="系別TextBox" runat="server" 
                                                                                    style="font-family: 金梅樹枝美工字體; font-weight: 700" Text='<%# Bind("系別") %>' />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style13">
                                                                                職稱</td>
                                                                            <td class="style15">
                                                                                :<asp:TextBox ID="職稱TextBox" runat="server" 
                                                                                    style="font-family: 金梅樹枝美工字體; font-weight: 700" Text='<%# Bind("職稱") %>' />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style13">
                                                                                辦公電話號碼</td>
                                                                            <td class="style15">
                                                                                :<asp:TextBox ID="辦公電話號碼TextBox" runat="server" 
                                                                                    style="font-family: 金梅樹枝美工字體; font-weight: 700" Text='<%# Bind("辦公電話號碼") %>' />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style13">
                                                                                行動電話號碼</td>
                                                                            <td class="style15">
                                                                                :<asp:TextBox ID="行動電話號碼TextBox" runat="server" 
                                                                                    style="font-family: 金梅樹枝美工字體; font-weight: 700" Text='<%# Bind("行動電話號碼") %>' />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style13">
                                                                                &nbsp;</td>
                                                                            <td class="style15">
                                                                                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                                                                                    CommandName="Update" onclick="UpdateButton_Click" Text="更新" />
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" 
                                                                                    CommandName="Cancel" Text="取消" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    &nbsp;
                                                                </EditItemTemplate>
                                                                <InsertItemTemplate>
                                                                    ID:
                                                                    <asp:TextBox ID="IDTextBox" runat="server" Text='<%# Bind("ID") %>' />
                                                            <br />
                                                                    帳號:
                                                                    <asp:TextBox ID="帳號TextBox0" runat="server" Text='<%# Bind("帳號") %>' />
                                                            <br />
                                                                    密碼:
                                                                    <asp:TextBox ID="密碼TextBox0" runat="server" Text='<%# Bind("密碼") %>' />
                                                            <br />
                                                                    姓名:
                                                                    <asp:TextBox ID="姓名TextBox0" runat="server" Text='<%# Bind("姓名") %>' />
                                                            <br />
                                                                    郵件地址:
                                                                    <asp:TextBox ID="郵件地址TextBox0" runat="server" Text='<%# Bind("郵件地址") %>' />
                                                            <br />
                                                                    系別:
                                                                    <asp:TextBox ID="系別TextBox0" runat="server" Text='<%# Bind("系別") %>' />
                                                            <br />
                                                                    職稱:
                                                                    <asp:TextBox ID="職稱TextBox0" runat="server" Text='<%# Bind("職稱") %>' />
                                                            <br />
                                                                    辦公電話號碼:
                                                                    <asp:TextBox ID="辦公電話號碼TextBox0" runat="server" Text='<%# Bind("辦公電話號碼") %>' />
                                                            <br />
                                                                    行動電話號碼:
                                                                    <asp:TextBox ID="行動電話號碼TextBox0" runat="server" Text='<%# Bind("行動電話號碼") %>' />
                                                            <br />
                                                                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                                                                        CommandName="Insert" Text="插入" />
                                                                    &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                                                                        CausesValidation="False" CommandName="Cancel" Text="取消" />
                                                                </InsertItemTemplate>
                                                                <ItemTemplate>
                                                                    <table class="style14">
                                                                        <tr>
                                                                            <td class="style13">
                                                                                帳號</td>
                                                                            <td class="style15">
                                                                                :<asp:Label ID="帳號Label" runat="server" Text='<%# Bind("帳號") %>' />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style13">
                                                                                密碼</td>
                                                                            <td class="style15">
                                                                                :<asp:Label ID="密碼Label" runat="server" Text='<%# Bind("密碼") %>' />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style13">
                                                                                姓名</td>
                                                                            <td class="style15">
                                                                                :<asp:Label ID="姓名Label" runat="server" Text='<%# Bind("姓名") %>' />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style13">
                                                                                郵件地址</td>
                                                                            <td class="style15">
                                                                                :<asp:Label ID="郵件地址Label" runat="server" Text='<%# Bind("郵件地址") %>' />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style13">
                                                                                系別</td>
                                                                            <td class="style15">
                                                                                :<asp:Label ID="系別Label" runat="server" Text='<%# Bind("系別") %>' />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style13">
                                                                                職稱</td>
                                                                            <td class="style15">
                                                                                :<asp:Label ID="職稱Label" runat="server" Text='<%# Bind("職稱") %>' />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style13">
                                                                                辦公電話號碼</td>
                                                                            <td class="style15">
                                                                                :<asp:Label ID="辦公電話號碼Label" runat="server" Text='<%# Bind("辦公電話號碼") %>' />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style13">
                                                                                行動電話號碼</td>
                                                                            <td class="style15">
                                                                                :<asp:Label ID="行動電話號碼Label" runat="server" Text='<%# Bind("行動電話號碼") %>' />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="style13">
                                                                                &nbsp;</td>
                                                                            <td class="style15">
                                                                                &nbsp;
                                                                                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" 
                                                                                    CommandName="Edit" Text="編輯" />
                                                                                &nbsp;&nbsp;
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    &nbsp;
                                                                </ItemTemplate>
                                                                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                                                                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                                                                <EditRowStyle BackColor="#7C6F57" />
                                                            </asp:FormView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:View>
                                            <asp:View ID="View_ADDNotice" runat="server">
                                        <br />
                                                <asp:FormView ID="FormView_ADDNotice" runat="server" BackColor="White" 
                                                    BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                                                    DataKeyNames="ID" DataSourceID="NoticeADD_SqlDataSource" DefaultMode="Insert" 
                                                    EnableModelValidation="True" GridLines="Horizontal" HorizontalAlign="Center" 
                                                    style="font-size: x-large;  vertical-align :middle ;font-weight: 700; text-align: left" 
                                                    Width="547px">
                                                    <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                    <InsertItemTemplate>
                                                        自動編號:
                                                        <asp:TextBox ID="IDTextBox0" runat="server" Enabled="False" 
                                                            Text='<%# Bind("ID") %>' />
                                                <br />
                                                        發佈時間:
                                                        <asp:TextBox ID="TimeTextBox" runat="server" Enabled="False" 
                                                            Text='<%# Bind("Time") %>' />
                                                <br />
                                                        公告內容:
                                                        <asp:TextBox ID="NoticeTextTextBox" runat="server" Rows="5" 
                                                            Text='<%# Bind("NoticeText") %>' TextMode="MultiLine" Width="400px" />
                                                <br />
                                                        <asp:LinkButton ID="InsertButton0" runat="server" CausesValidation="True" 
                                                            CommandName="Insert" onclick="InsertButton_Click" Text="插入" />
                                                        &nbsp;<asp:LinkButton ID="InsertCancelButton0" runat="server" 
                                                            CausesValidation="False" CommandName="Cancel" 
                                                            onclick="InsertCancelButton_Click" Text="取消" />
                                                    </InsertItemTemplate>
                                                    <ItemTemplate>
                                                        ID:
                                                        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                                                <br />
                                                        Time:
                                                        <asp:Label ID="TimeLabel" runat="server" Text='<%# Bind("Time") %>' />
                                                <br />
                                                        NoticeText:
                                                        <asp:Label ID="NoticeTextLabel" runat="server" 
                                                            Text='<%# Bind("NoticeText") %>' />
                                                <br />
                                                        <asp:LinkButton ID="EditButton0" runat="server" CausesValidation="False" 
                                                            CommandName="Edit" Text="編輯" />
                                                        &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" 
                                                            CommandName="Delete" Text="刪除" />
                                                        &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" 
                                                            CommandName="New" Text="新增" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        ID:
                                                        <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' />
                                                <br />
                                                        Time:
                                                        <asp:TextBox ID="TimeTextBox0" runat="server" Text='<%# Bind("Time") %>' />
                                                <br />
                                                        NoticeText:
                                                        <asp:TextBox ID="NoticeTextTextBox0" runat="server" 
                                                            Text='<%# Bind("NoticeText") %>' />
                                                <br />
                                                        <asp:LinkButton ID="UpdateButton0" runat="server" CausesValidation="True" 
                                                            CommandName="Update" Text="更新" />
                                                        &nbsp;<asp:LinkButton ID="UpdateCancelButton0" runat="server" 
                                                            CausesValidation="False" CommandName="Cancel" Text="取消" />
                                                    </EditItemTemplate>
                                                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                                                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                                </asp:FormView>
                                            </asp:View>
                                            <br />
                                        </asp:MultiView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>

                <!-- end #mainContent -->
            </div>
            <!-- end #container -->
        </div>
    </div>
    <div class="style64">
        - Powered-by-許鈞霆/陳獻欽/陳紀緯-©2011-CSU-CSIE - 99學年度學生專題 -
    </div>
    <br />
                                        <span class="style9"><b><span class="style16">
                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                            ConflictDetection="CompareAllValues" 
                                            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                            InsertCommand="INSERT INTO [教師] ([ID], [帳號], [密碼], [姓名], [郵件地址], [系別], [職稱], [辦公電話號碼], [行動電話號碼]) VALUES (@ID, @帳號, @密碼, @姓名, @郵件地址, @系別, @職稱, @辦公電話號碼, @行動電話號碼)" 
                                            OldValuesParameterFormatString="original_{0}" 
                                            SelectCommand="SELECT ID, 帳號, 密碼, 姓名, 郵件地址, 系別, 職稱, 辦公電話號碼, 行動電話號碼 FROM 教師 WHERE (帳號 = @帳號)" 
                                            
                                            UpdateCommand="UPDATE 教師 SET 帳號 = @帳號, 密碼 = @密碼, 姓名 = @姓名, 郵件地址 = @郵件地址, 系別 = @系別, 職稱 = @職稱, 辦公電話號碼 = @辦公電話號碼, 行動電話號碼 = @行動電話號碼 WHERE (ID = @original_ID) AND (帳號 = @original_帳號) AND (密碼 = @original_密碼) AND (姓名 = @original_姓名 OR 姓名 IS NULL AND @original_姓名 IS NULL) AND (郵件地址 = @original_郵件地址 OR 郵件地址 IS NULL AND @original_郵件地址 IS NULL) AND (系別 = @original_系別 OR 系別 IS NULL AND @original_系別 IS NULL) AND (職稱 = @original_職稱 OR 職稱 IS NULL AND @original_職稱 IS NULL) AND (辦公電話號碼 = @original_辦公電話號碼 OR 辦公電話號碼 IS NULL AND @original_辦公電話號碼 IS NULL) AND (行動電話號碼 = @original_行動電話號碼 OR 行動電話號碼 IS NULL AND @original_行動電話號碼 IS NULL)" 
                                            onselecting="SqlDataSource1_Selecting">
                                            <SelectParameters>
                                                <asp:SessionParameter Name="帳號" SessionField="OK_userid" Type="String" />
                                            </SelectParameters>
                                            <UpdateParameters>
                                                <asp:Parameter Name="帳號" Type="String" />
                                                <asp:Parameter Name="密碼" Type="String" />
                                                <asp:Parameter Name="姓名" Type="String" />
                                                <asp:Parameter Name="郵件地址" Type="String" />
                                                <asp:Parameter Name="系別" Type="String" />
                                                <asp:Parameter Name="職稱" Type="String" />
                                                <asp:Parameter Name="辦公電話號碼" Type="String" />
                                                <asp:Parameter Name="行動電話號碼" Type="String" />
                                                <asp:Parameter Name="original_ID" Type="Int32" />
                                                <asp:Parameter Name="original_帳號" Type="String" />
                                                <asp:Parameter Name="original_密碼" Type="String" />
                                                <asp:Parameter Name="original_姓名" Type="String" />
                                                <asp:Parameter Name="original_郵件地址" Type="String" />
                                                <asp:Parameter Name="original_系別" Type="String" />
                                                <asp:Parameter Name="original_職稱" Type="String" />
                                                <asp:Parameter Name="original_辦公電話號碼" Type="String" />
                                                <asp:Parameter Name="original_行動電話號碼" Type="String" />
                                            </UpdateParameters>
                                            <InsertParameters>
                                                <asp:Parameter Name="ID" Type="Int32" />
                                                <asp:Parameter Name="帳號" Type="String" />
                                                <asp:Parameter Name="密碼" Type="String" />
                                                <asp:Parameter Name="姓名" Type="String" />
                                                <asp:Parameter Name="郵件地址" Type="String" />
                                                <asp:Parameter Name="系別" Type="String" />
                                                <asp:Parameter Name="職稱" Type="String" />
                                                <asp:Parameter Name="辦公電話號碼" Type="String" />
                                                <asp:Parameter Name="行動電話號碼" Type="String" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>
    <asp:SqlDataSource ID="Notice_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT * FROM [公告]" ConflictDetection="CompareAllValues" 
        DeleteCommand="DELETE FROM [公告] WHERE [ID] = @original_ID AND [Time] = @original_Time AND (([NoticeText] = @original_NoticeText) OR ([NoticeText] IS NULL AND @original_NoticeText IS NULL))" 
        InsertCommand="INSERT INTO [公告] ([ID], [Time], [NoticeText]) VALUES (@ID, @Time, @NoticeText)" 
        OldValuesParameterFormatString="original_{0}" 
        UpdateCommand="UPDATE [公告] SET [Time] = @Time, [NoticeText] = @NoticeText WHERE [ID] = @original_ID AND [Time] = @original_Time AND (([NoticeText] = @original_NoticeText) OR ([NoticeText] IS NULL AND @original_NoticeText IS NULL))">
        <DeleteParameters>
            <asp:Parameter DbType="DateTimeOffset" Name="original_ID" />
            <asp:Parameter DbType="Date" Name="original_Time" />
            <asp:Parameter Name="original_NoticeText" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter DbType="DateTimeOffset" Name="ID" />
            <asp:Parameter DbType="Date" Name="Time" />
            <asp:Parameter Name="NoticeText" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter DbType="Date" Name="Time" />
            <asp:Parameter Name="NoticeText" Type="String" />
            <asp:Parameter DbType="DateTimeOffset" Name="original_ID" />
            <asp:Parameter DbType="Date" Name="original_Time" />
            <asp:Parameter Name="original_NoticeText" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="NoticeADD_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT ID, Time, NoticeText FROM 公告 ORDER BY ID DESC" ConflictDetection="CompareAllValues" 
        DeleteCommand="DELETE FROM [公告] WHERE [ID] = @original_ID AND [Time] = @original_Time AND (([NoticeText] = @original_NoticeText) OR ([NoticeText] IS NULL AND @original_NoticeText IS NULL))" 
        InsertCommand="INSERT INTO [公告] ([ID], [Time], [NoticeText]) VALUES (@ID, @Time, @NoticeText)" 
        OldValuesParameterFormatString="original_{0}" 
        
        
        UpdateCommand="UPDATE [公告] SET [Time] = @Time, [NoticeText] = @NoticeText WHERE [ID] = @original_ID AND [Time] = @original_Time AND (([NoticeText] = @original_NoticeText) OR ([NoticeText] IS NULL AND @original_NoticeText IS NULL))">
        <DeleteParameters>
            <asp:Parameter DbType="DateTimeOffset" Name="original_ID" />
            <asp:Parameter DbType="Date" Name="original_Time" />
            <asp:Parameter Name="original_NoticeText" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter DbType="DateTimeOffset" Name="ID" />
            <asp:Parameter DbType="Date" Name="Time" />
            <asp:Parameter Name="NoticeText" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter DbType="Date" Name="Time" />
            <asp:Parameter Name="NoticeText" Type="String" />
            <asp:Parameter DbType="DateTimeOffset" Name="original_ID" />
            <asp:Parameter DbType="Date" Name="original_Time" />
            <asp:Parameter Name="original_NoticeText" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
                                        </span></b></span>
    <br />
    <br />
</asp:Content>
