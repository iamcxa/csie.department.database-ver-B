<%@ Page Language="VB" MasterPageFile="~/t/t-MasterPage.master" Title="OTS:Online Test System" %>

<script runat="server">

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("OK_CLASS") = DropDownList2.Text
        Session("look_class") = DropDownList3.Text
        Me.Button1.Enabled = False
        Me.Button5.Visible = True
        Me.Label4.Visible = False
        Me.DropDownList3.Visible = False
        GridView1.Visible = True
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Application("open_close") = "close" Then
            Button3.Text = "開放學生帳號註冊"
        Else
            Button3.Text = "關閉學生帳號註冊"
        End If
        
        If Application("op_cl") = "cl" Then
            Button4.Text = "開放測驗"
        Else
            Button4.Text = "關閉測驗"
        End If
    End Sub

    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Application("open_close") = "close" Then
            Application("open_close") = "open"
            Button3.Text = "關閉學生帳號註冊"
        Else
            Application("open_close") = "close"
            Button3.Text = "開放學生帳號註冊"
        End If
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        GridView1.Visible = False
    End Sub

    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Application("op_cl") = "cl" Then
            Application("op_cl") = "op"
            Button4.Text = "關閉測驗"
        Else
            Application("op_cl") = "cl"
            Button4.Text = "開放測驗"
        End If
    End Sub

    Protected Sub Button5_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.Label4.Visible = True
        Me.DropDownList3.Visible = True
        Me.Button1.Enabled = True
        Me.Button5.Visible = False
        Session("look_class") = Me.DropDownList2.SelectedValue
    End Sub
    
    

    Protected Sub Button6_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim conn As Data.SqlClient.SqlConnection, cmd As Data.SqlClient.SqlCommand
        Dim SQL As String, RD As Data.SqlClient.SqlDataReader
        conn = New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
        
        Dim check1 As Boolean
        conn.Open()
        SQL = "SELECT * FROM 修課 WHERE 學號='" & Me.TextBox1.Text & "'"
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        RD = cmd.ExecuteReader
        If RD.Read() Then
            check1 = True
            conn.Close()
        Else
            check1 = False
            conn.Close()
        End If
        
        Dim check2 As Boolean
        conn.Open()
        SQL = "SELECT * FROM 修課 WHERE 修課編號='" & Me.TextBox2.Text & "'"
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        RD = cmd.ExecuteReader
        If RD.Read() Then
            check2 = True
            conn.Close()
        Else
            check2 = False
            conn.Close()
        End If
        
        If Me.TextBox1.Text <> "" And Me.TextBox2.Text <> "" And check1 = True And check2 = True Then
            conn.Open()
            SQL = "DELETE FROM 修課 WHERE " & "學號='" & Me.TextBox1.Text & "' And 修課編號='" & Me.TextBox2.Text & "'"
            cmd = New Data.SqlClient.SqlCommand(SQL, conn)
            cmd.ExecuteNonQuery()
            conn.Close()
            Me.Label7.ForeColor = Drawing.Color.Red
            Me.Label7.Text = "退選成功!"
        Else
            Me.Label7.ForeColor = Drawing.Color.Red
            Me.Label7.Text = "輸入錯誤!"
        End If
        Me.GridView1.DataBind()
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


        .style6
        {
            width: 912px;
        }
        .style7
        {
            width: 606px;
        }


    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"><div id="Main" class="Main">
        <div id="container2" class ="container2">
            <div id="mainContent">
                            <table style="width: 100%;">
                                <tr>
                                    <td style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: #C0C0C0;
                                        height: 30px;text-align: center;">
                                        <asp:Label ID="Label_notice" runat="server" Font-Bold="True" ForeColor="Red" Font-Size="XX-Large">學生資料列表</asp:Label>
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
                                        
                                    
                                      <table style="text-align:center; width: 100%;">
                                                        <tr>
                                                            <td>
                                                           
                                                             
                                                                <span class="style10"><b><span class="style11">班級：<asp:DropDownList 
                                                                    ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2" 
                                                                    DataTextField="班級別" DataValueField="班級別" 
                                                                    style="text-align: center;  font-weight: 700">
                                                                </asp:DropDownList>
                                                                &nbsp;</span><asp:Button ID="Button5" runat="server" BackColor="#6699FF" 
                                                                    BorderColor="#999999" BorderStyle="Outset" onclick="Button5_Click" Text="選擇" />
                                                                　</b><asp:Label ID="Label4" runat="server" 
                                                                    style="font-weight: 700; font-size: large" Text="科目：" Visible="False"></asp:Label>
                                                                </span>
                                                                <asp:DropDownList ID="DropDownList3" runat="server" 
                                                                    DataSourceID="SqlDataSource3" DataTextField="課程名稱" DataValueField="課程名稱" 
                                                                    style="font-weight: 700" Visible="False">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style6">
                                                                <span class="style10">
                                                                <asp:Button ID="Button1" runat="server" BackColor="#6699FF" 
                                                                    BorderColor="#999999" BorderStyle="Outset" Enabled="False" 
                                                                    onclick="Button1_Click" 
                                                                    style=" font-size: large; font-weight: 700" Text="查詢學生資料" 
                                                                    Width="181px" />
                                                                </span>　<span class="style10"><asp:Button ID="Button2" runat="server" 
                                                                    BackColor="#6699FF" BorderColor="#999999" onclick="Button2_Click" 
                                                                    style="font-size: large;  font-weight: 700" Text="取消查詢" 
                                                                    Width="187px" />
                                                                </span>　<span class="style10"><asp:Button ID="Button3" runat="server" 
                                                                    BackColor="#6699FF" BorderColor="#999999" onclick="Button3_Click" 
                                                                    style=" font-weight: 700; font-size: large" Text="開放學生註冊" 
                                                                    Width="183px" />
                                                                &nbsp;</span><asp:Button ID="Button4" runat="server" BackColor="#6699FF" 
                                                                    BorderColor="#999999" Height="28px" onclick="Button4_Click" 
                                                                    style=" font-weight: 700; font-size: large" Text="開放測驗" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style6">
                                                                <table class="style5">
                                                                    <tr>
                                                                        <td>
                                                                            &nbsp;</td>
                                                                        <td class="style7">
                                                                            <table class="style1">
                                                                                <tr>
                                                                                    <td class="style5">
                                                                                        <asp:Label ID="Label5" runat="server" Text="學號："></asp:Label>
                                                                                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                                                                        &nbsp;<asp:Label ID="Label6" runat="server" Text="修課編號："></asp:Label>
                                                                                        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                                                                                        &nbsp;<asp:Button ID="Button6" runat="server" onclick="Button6_Click" 
                                                                                            style="height: 21px" Text="退選" />
                                                                                        <asp:Label ID="Label7" runat="server" ForeColor="#CC3300"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                        <td>
                                                                            &nbsp;</td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                                                                    AllowSorting="True" AutoGenerateColumns="False" BackColor="#DEBA84" 
                                                                    BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                                                                    CellSpacing="2" DataKeyNames="學號" DataSourceID="SqlDataSource1" 
                                                                    HorizontalAlign="Center" 
                                                                    style=" font-weight: 700; font-size: medium">
                                                                    <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                                                                    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                                                                    <Columns>
                                                                        <asp:BoundField DataField="學號" HeaderText="學號" ReadOnly="True" 
                                                                            SortExpression="學號" />
                                                                        <asp:BoundField DataField="姓名" HeaderText="姓名" SortExpression="姓名" />
                                                                        <asp:BoundField DataField="課程名稱" HeaderText="課程名稱" SortExpression="課程名稱" />
                                                                        <asp:BoundField DataField="班級別" HeaderText="班級別" SortExpression="班級別" />
                                                                        <asp:BoundField DataField="電子郵件地址" HeaderText="電子郵件地址" 
                                                                            SortExpression="電子郵件地址" />
                                                                        <asp:BoundField DataField="家庭電話號碼" HeaderText="家庭電話號碼" 
                                                                            SortExpression="家庭電話號碼" />
                                                                        <asp:BoundField DataField="行動電話號碼" HeaderText="行動電話號碼" 
                                                                            SortExpression="行動電話號碼" />
                                                                        <asp:BoundField DataField="好友電話號碼" HeaderText="好友電話號碼" 
                                                                            SortExpression="好友電話號碼" />
                                                                    </Columns>
                                                                    <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                                                                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                                                                    <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                                                                </asp:GridView>
                                                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                                                    ConflictDetection="CompareAllValues" 
                                                                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                                                    DeleteCommand="DELETE FROM 修課 WHERE (學號 = @original_學號) AND (修課編號 = @修課編號)" 
                                                                    InsertCommand="INSERT INTO 學生(學號, 密碼, 姓名, 班級編號, 家庭電話號碼, 行動電話號碼, 好友電話號碼, 電子郵件地址) VALUES (@學號, @密碼, @姓名, @班級編號, @家庭電話號碼, @行動電話號碼, @好友電話號碼,)" 
                                                                    OldValuesParameterFormatString="original_{0}" 
                                                                    SelectCommand="SELECT 學生.學號, 學生.姓名, 班級.班級別, 學生.電子郵件地址, 學生.家庭電話號碼, 學生.行動電話號碼, 學生.好友電話號碼, 學生.班級編號, 課程.課程名稱 FROM 學生 INNER JOIN 班級 ON 學生.班級編號 = 班級.班級編號 INNER JOIN 修課 ON 學生.學號 = 修課.學號 INNER JOIN 開課 ON 班級.班級編號 = 開課.班級編號 AND 修課.修課編號 = 開課.開課編號 INNER JOIN 課程 ON 開課.課程編號 = 課程.課程編號 WHERE (班級.班級別 = @班級別) AND (課程.課程名稱 = @課程名稱)" 
                                                                    UpdateCommand="UPDATE 學生 SET 密碼 = @密碼, 姓名 = @姓名, 班級編號 = @班級編號, 電子郵件地址 = @電子郵件地址, 家庭電話號碼 = @家庭電話號碼, 行動電話號碼 = @行動電話號碼, 好友電話號碼 = @好友電話號碼 WHERE (學號 = @original_學號) AND (密碼 = @original_密碼) AND (姓名 = @original_姓名 OR 姓名 IS NULL AND @original_姓名 IS NULL) AND (班級編號 = @original_班級編號 OR 班級編號 IS NULL AND @original_班級編號 IS NULL) AND (電子郵件地址 = @original_電子郵件地址 OR 電子郵件地址 IS NULL AND @original_電子郵件地址 IS NULL) AND (家庭電話號碼 = @original_家庭電話號碼 OR 家庭電話號碼 IS NULL AND @original_家庭電話號碼 IS NULL) AND (行動電話號碼 = @original_行動電話號碼 OR 行動電話號碼 IS NULL AND @original_行動電話號碼 IS NULL) AND (好友電話號碼 = @original_好友電話號碼 OR 好友電話號碼 IS NULL AND @original_好友電話號碼 IS NULL)">
                                                                    <SelectParameters>
                                                                        <asp:SessionParameter Name="班級別" SessionField="OK_CLASS" />
                                                                        <asp:SessionParameter Name="課程名稱" SessionField="look_class" />
                                                                    </SelectParameters>
                                                                    <DeleteParameters>
                                                                        <asp:Parameter Name="original_學號" />
                                                                        <asp:Parameter Name="修課編號" />
                                                                    </DeleteParameters>
                                                                    <UpdateParameters>
                                                                        <asp:Parameter Name="密碼" Type="String" />
                                                                        <asp:Parameter Name="姓名" Type="String" />
                                                                        <asp:Parameter Name="班級編號" Type="Int32" />
                                                                        <asp:Parameter Name="電子郵件地址" Type="String" />
                                                                        <asp:Parameter Name="家庭電話號碼" Type="String" />
                                                                        <asp:Parameter Name="行動電話號碼" Type="String" />
                                                                        <asp:Parameter Name="好友電話號碼" Type="String" />
                                                                        <asp:Parameter Name="original_學號" Type="Int32" />
                                                                        <asp:Parameter Name="original_密碼" Type="String" />
                                                                        <asp:Parameter Name="original_姓名" Type="String" />
                                                                        <asp:Parameter Name="original_班級編號" Type="Int32" />
                                                                        <asp:Parameter Name="original_電子郵件地址" Type="String" />
                                                                        <asp:Parameter Name="original_家庭電話號碼" Type="String" />
                                                                        <asp:Parameter Name="original_行動電話號碼" Type="String" />
                                                                        <asp:Parameter Name="original_好友電話號碼" Type="String" />
                                                                    </UpdateParameters>
                                                                    <InsertParameters>
                                                                        <asp:Parameter Name="學號" Type="Int32" />
                                                                        <asp:Parameter Name="密碼" Type="String" />
                                                                        <asp:Parameter Name="姓名" Type="String" />
                                                                        <asp:Parameter Name="班級編號" Type="Int32" />
                                                                        <asp:Parameter Name="家庭電話號碼" Type="String" />
                                                                        <asp:Parameter Name="行動電話號碼" Type="String" />
                                                                        <asp:Parameter Name="好友電話號碼" Type="String" />
                                                                    </InsertParameters>
                                                                </asp:SqlDataSource>
                                                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                                                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                                                    SelectCommand="SELECT [班級編號], [班級別], [入學年別] FROM [班級]"></asp:SqlDataSource>
                                                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                                                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                                                    SelectCommand="SELECT 班級.班級別, 課程.課程名稱 FROM 開課 INNER JOIN 課程 ON 開課.課程編號 = 課程.課程編號 INNER JOIN 班級 ON 開課.班級編號 = 班級.班級編號 WHERE (班級.班級別 = @班級別)">
                                                                    <SelectParameters>
                                                                        <asp:SessionParameter Name="班級別" SessionField="look_class" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                                <br /></td>
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

