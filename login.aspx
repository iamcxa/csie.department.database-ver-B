<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script runat="server">
    Dim userData As String = ""
    Public Function verify(ByVal ACCOUNT As String, ByVal PSWD As String, ByVal IsTeacher As Boolean) As Boolean
        Dim conn As New SqlConnection   '宣告SqlConnection並實體化 
        Dim cmmd As New SqlCommand      '宣告SqlCommand並實體化 
        Dim pmtUserName As New SqlParameter     '宣告sqlParameter並實體化 
        Dim pmtUserPassword As New SqlParameter '宣告sqlParameter並實體化 
        Dim strSQL As String = ""
        Dim dr As SqlDataReader
        Try
            'conn = New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
            
            
            conn.ConnectionString = "Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True"
            'conn.ConnectionString = WebConfigurationManager.ConnectionStrings("INTE").ConnectionString
            conn.Open()
            cmmd.Connection = conn
            cmmd.CommandText = strSQL
            If IsTeacher = False Then
                strSQL = "Select * From 學生 Where " & "學號='" & ACCOUNT & "'" & " And 密碼='" & PSWD & "'"
            ElseIf IsTeacher = True Then
                strSQL = "Select * From 教師 Where " & "帳號='" & ACCOUNT & "'" & " And 密碼='" & PSWD & "'"
            End If
            cmmd = New Data.SqlClient.SqlCommand(strSQL, conn)
            dr = cmmd.ExecuteReader()
            If dr.HasRows Then
                '判斷有資料 
                userData = "gold_member,board_admin"
                verify = True
                Return True
            Else
                '發起錯誤 
                Throw New Exception("登入失敗!!")
            End If
        Catch ex As Exception
            If IsTeacher = 0 Then
                Me.Login_S.FailureText = ex.Message
            ElseIf IsTeacher = 1 Then
                Me.Login_T.FailureText = ex.Message
            End If
            verify = False
        Finally
            pmtUserName = Nothing
            pmtUserPassword = Nothing
            dr = Nothing
            cmmd = Nothing
            conn = Nothing
        End Try
     
        
    End Function

    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("st-new.aspx")
    End Sub


    Protected Sub InsertButton_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        MultiView_Main.ActiveViewIndex = 0
        CType(Login_S.FindControl("Label4"), Label).Text = "註冊成功!"
        Me.Login_S.UserName = CType(FormView_Reg.Row.Cells(0).FindControl("學號TextBox"), TextBox).Text
       
    End Sub
    
    
    Protected Sub LinkButton_Reg_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Application("IsReg") = False Then
            MultiView_Main.ActiveViewIndex = 3
        Else
            Application("IsReg") = True
            MultiView_Main.ActiveViewIndex = 2
            Eraser()
        End If
    End Sub
    Protected Sub InsertCancelButton_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Application("open_close") = "close" Then
            MultiView_Main.ActiveViewIndex = 2
        Else
            Application("open_close") = "open"
            MultiView_Main.ActiveViewIndex = 0
        End If
        Eraser()
    End Sub

    Sub Eraser()
        CType(FormView_Reg.Row.Cells(0).FindControl("學號TextBox"), TextBox).Enabled = True
        CType(FormView_Reg.Row.Cells(0).FindControl("Label3"), Label).Text = ""
        CType(FormView_Reg.Row.Cells(0).FindControl("InsertButton"), LinkButton).Enabled = False
        CType(FormView_Reg.Row.Cells(0).FindControl("CompareValidator1"), CompareValidator).Enabled = False
        CType(FormView_Reg.Row.Cells(0).FindControl("RequiredFieldValidator1"), RequiredFieldValidator).Enabled = False
        CType(FormView_Reg.Row.Cells(0).FindControl("RequiredFieldValidator4"), RequiredFieldValidator).Enabled = False
        CType(FormView_Reg.Row.Cells(0).FindControl("RequiredFieldValidator5"), RequiredFieldValidator).Enabled = False
        CType(FormView_Reg.Row.Cells(0).FindControl("RegularExpressionValidator2"), RegularExpressionValidator).Enabled = False
        CType(FormView_Reg.Row.Cells(0).FindControl("學號TextBox"), TextBox).Text = ""
        CType(FormView_Reg.Row.Cells(0).FindControl("密碼TextBox"), TextBox).Text = ""
        CType(FormView_Reg.Row.Cells(0).FindControl("TextBox3"), TextBox).Text = ""
        CType(FormView_Reg.Row.Cells(0).FindControl("姓名TextBox"), TextBox).Text = ""
        CType(FormView_Reg.Row.Cells(0).FindControl("電子郵件地址TextBox"), TextBox).Text = ""
    End Sub
        
    Protected Sub LinkButton_IsTeacher_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.MultiView_Main.ActiveViewIndex = 1
        Me.Login_T.UserNameLabelText = ""
        Me.Login_T.PasswordLabelText = ""
        CType(Login_T.FindControl("Label4"), Label).Text = ""
    End Sub
    Protected Sub LinkButton_IsStudent_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.MultiView_Main.ActiveViewIndex = 0
        Me.Login_S.UserNameLabelText = ""
        Me.Login_S.PasswordLabelText = ""
        CType(Login_S.FindControl("Label4"), Label).Text = ""
    End Sub

  
    Protected Sub FormView_Reg_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewPageEventArgs)

    End Sub

    Protected Sub LinkButton_Check_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim conn As Data.SqlClient.SqlConnection, cmd As Data.SqlClient.SqlCommand
        Dim Rd As Data.SqlClient.SqlDataReader, SQL As String
        Dim asc_check As Boolean = False
        Dim x, y As Integer
        Dim UserName As String = CType(FormView_Reg.Row.Cells(0).FindControl("學號TextBox"), TextBox).Text.ToString
        Select Case CType(FormView_Reg.Row.Cells(0).FindControl("學號TextBox"), TextBox).Text.ToString.Length
            Case Is = 0
                CType(FormView_Reg.Row.Cells(0).FindControl("Label3"), Label).Text = "必須填入學號！"
                Return
            Case Is > 8
                CType(FormView_Reg.Row.Cells(0).FindControl("Label3"), Label).Text = "學號太長！"
                Return
            Case Is < 2
                CType(FormView_Reg.Row.Cells(0).FindControl("Label3"), Label).Text = "學號太短！"
                Return
            Case Is > 1
                For i = 1 To (UserName.Length)
                    x = Asc(Mid(UserName, i, 1))
                    If x >= 48 And x <= 57 Then
                        y = y + 1
                    Else
                        y = y - 1
                    End If
                Next i
                If y = UserName.Length Then
                    asc_check = True
                Else
                    asc_check = False
                End If
        End Select
        If asc_check = True Then
            conn = New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
            conn.Open()
            SQL = "SELECT * FROM 學生 WHERE 學號 = '" & CType(FormView_Reg.Row.Cells(0).FindControl("學號TextBox"), TextBox).Text & "'"
            cmd = New Data.SqlClient.SqlCommand(SQL, conn)
            Rd = cmd.ExecuteReader
            If Rd.Read() = True Then
                CType(FormView_Reg.Row.Cells(0).FindControl("Label3"), Label).Text = "已有人使用，請重新輸入"
                CType(FormView_Reg.Row.Cells(0).FindControl("InsertButton"), LinkButton).Enabled = False
                CType(FormView_Reg.Row.Cells(0).FindControl("CompareValidator1"), CompareValidator).Enabled = False
                CType(FormView_Reg.Row.Cells(0).FindControl("RequiredFieldValidator4"), RequiredFieldValidator).Enabled = False
                CType(FormView_Reg.Row.Cells(0).FindControl("RequiredFieldValidator5"), RequiredFieldValidator).Enabled = False
                CType(FormView_Reg.Row.Cells(0).FindControl("RegularExpressionValidator2"), RegularExpressionValidator).Enabled = False
                CType(FormView_Reg.Row.Cells(0).FindControl("RequiredFieldValidator1"), RequiredFieldValidator).Enabled = False
            ElseIf Rd.Read() = False Then
                CType(FormView_Reg.Row.Cells(0).FindControl("Label3"), Label).Text = "可以使用"
                CType(FormView_Reg.Row.Cells(0).FindControl("學號TextBox"), TextBox).Enabled = False
                CType(FormView_Reg.Row.Cells(0).FindControl("InsertButton"), LinkButton).Enabled = True
                CType(FormView_Reg.Row.Cells(0).FindControl("CompareValidator1"), CompareValidator).Enabled = True
                CType(FormView_Reg.Row.Cells(0).FindControl("RequiredFieldValidator4"), RequiredFieldValidator).Enabled = True
                CType(FormView_Reg.Row.Cells(0).FindControl("RequiredFieldValidator5"), RequiredFieldValidator).Enabled = True
                CType(FormView_Reg.Row.Cells(0).FindControl("RequiredFieldValidator1"), RequiredFieldValidator).Enabled = True
                CType(FormView_Reg.Row.Cells(0).FindControl("RegularExpressionValidator2"), RegularExpressionValidator).Enabled = True
            End If
            conn.Close()
        ElseIf asc_check = False Then
            CType(FormView_Reg.Row.Cells(0).FindControl("Label3"), Label).Text = "學號只能為數字"
            CType(FormView_Reg.Row.Cells(0).FindControl("InsertButton"), LinkButton).Enabled = False
            CType(FormView_Reg.Row.Cells(0).FindControl("CompareValidator1"), CompareValidator).Enabled = False
            CType(FormView_Reg.Row.Cells(0).FindControl("RequiredFieldValidator1"), RequiredFieldValidator).Enabled = False
            CType(FormView_Reg.Row.Cells(0).FindControl("RequiredFieldValidator4"), RequiredFieldValidator).Enabled = False
            CType(FormView_Reg.Row.Cells(0).FindControl("RequiredFieldValidator5"), RequiredFieldValidator).Enabled = False
            CType(FormView_Reg.Row.Cells(0).FindControl("RegularExpressionValidator2"), RegularExpressionValidator).Enabled = False
            Return
        End If
    End Sub

    Protected Sub LinkButton_Eraser_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Eraser()
    End Sub
    
    Function Login(ByVal strUsername As String, ByVal strPWD As String, ByVal IsTeacher As Boolean) As Boolean
        
        If verify(strUsername, strPWD, IsTeacher) = True Then
            Dim isPersistent As Boolean = False
            Dim ticket As FormsAuthenticationTicket = New FormsAuthenticationTicket(1, strUsername, DateTime.Now, DateTime.Now.AddMinutes(30), isPersistent, userData, FormsAuthentication.FormsCookiePath)
            FormsAuthentication.RedirectFromLoginPage(strUsername, True)
            Dim encTicket = FormsAuthentication.Encrypt(ticket)
            Response.Cookies.Add(New HttpCookie(FormsAuthentication.FormsCookieName, encTicket))
            If IsTeacher = False Then
                Session ("OK_STU")=Me.Page.User.Identity.Name
                Response.Redirect("st-home.aspx", False)
            ElseIf IsTeacher = True Then
                Response.Redirect("./t/t-data.aspx", False)
            End If
            Return True
        Else
            If IsTeacher = False Then
                CType(Login_S.FindControl("Label4"), Label).Text = "登入失敗！"
            ElseIf IsTeacher = True Then
                CType(Login_T.FindControl("Label4"), Label).Text = "登入失敗！"
            End If
            Return False
        End If
    End Function
    Protected Sub LoginButton_S_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Session.RemoveAll()
        Login(Login_S.UserName, Login_S.Password, False)
    End Sub
    Protected Sub LoginButton_T_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Session.RemoveAll()
        Login(Login_T.UserName, Login_T.Password, True)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim conn As Data.SqlClient.SqlConnection, cmd As Data.SqlClient.SqlCommand
        Dim Rd As Data.SqlClient.SqlDataReader, SQL As String

        conn = New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
        conn.Open()
        SQL = "SELECT count(*) FROM 公告 "
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        Rd = cmd.ExecuteReader
        Rd.Read()
        If Rd.Read > 1 Then
            'Me.Notice_ListBox.SelectedIndex = 0
            
        Else
            Rd.Close()

        End If
                
    
       
    End Sub
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>:: 登入系統 </title>
    <script src="javascripts/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="javascripts/jquery.curvycorners.min.js" type="text/javascript"></script>
    <script src="javascripts/corner.js" type="text/javascript"></script>
    <script src="javascripts/wait.js" type="text/javascript"></script>
    <script src="javascripts/Login/Loading.js" type="text/javascript"></script>
    <script src="javascripts/Login/Loading_Done.js" type="text/javascript"></script>
    <style type="text/css">
        -- body
        {
            font: 100% Arial Unicode MS, 新細明體;
            font-size: small;
            margin: 0; /* 比較好的做法是將 Body 元素的邊界與欄位間隔調整為零，以處理不同的瀏覽器預設值 */
            padding: 0;
            text-align: center; /* 這樣會讓容器在 IE 5* 瀏覽器內置中對齊。然後，文字會在 #container 選取器中設定為靠左對齊預設值 */
            color: #000000;
        }
        .body
        {
            background-repeat: no-repeat;
            background-position: 0% 0%;
            background-attachment: fixed;
            background-color: #202020; /*background-image: url('images/cat10_5.jpg');*/
        }
        .container
        {
            background: #FFFFFF;
            height: 100%;
            width: 1000px; /* 這樣將會建立為 80% 瀏覽器寬度的容器 */
            background-repeat: no-repeat;
            background-position: 50% 0%;
            background-attachment: scroll;
            background-image: url(   'images/bg.jpg' );
            margin: 0 auto; /* 自動邊界 (搭配寬度) 會讓頁面置中對齊 */
            border: 1px solid #CCCCCC;
            text-align: left; /* 這樣做會覆寫 Body 元素上的 text-align: center。 */
            margin-top: -20px;
        }
        .oneColLiqCtr #mainContent
        {
            padding: 0 20px; /* 請記住，欄位間隔就是 Div 方塊內部的空間，而邊界就是 Div 方塊外部的空間 */
        }
        #Div_View_Login
        {
            margin-left: auto;
            text-align: center;
        }
        .title
        {
            font-weight: bold;
            color: #3366FF;
            font-size: medium;
        }
        .style3
        {
            width: 657px;
            height: 3px;
        }
        .style4
        {
            width: 836px;
            font-weight: bold;
            height: 3px;
        }
        .font-size-small
        {
            font-size: small;
        }
        .font-size-medium
        {
            font-size: medium;
        }
        .style12
        {
            width: 40px;
            text-align: center;
        }
        .style13
        {
            text-align: right;
        }
        .style17
        {
            width: 351px;
        }
        .bottom_copyright
        {
            text-align: center;
            font-family: Corbel;
            font-size: 12px;
        }
        .style21
        {
            width: 100%;
            align="center" 
        }
        .style22
        {
            width: 351px;
            height: 3px;
        }
        .style25
        {
            width: 180px;
            height: 32px;
        }
        .style28
        {
            height: 20px;
        }
        .style51
        {
            width: 100%;
        }
        .style60
        {
        }
        .style61
        {
            font-size: x-large;
            font-weight: bold;
        }
        .style38
        {
            font-size: x-large;
        }
        .style62
        {
            height: 20px;
            width: 396px;
            text-align: center;
        }
        .style63
        {
            color: black;
        }
        .style64
        {
            text-align: center;
            font-family: Corbel;
            font-size: 12px;
            color: #FFFFFF;
        }
        .style65
        {
            width: 148px;
            font-size: x-large;
            height: 36px;
        }
        .style66
        {
            font-size: x-large;
            font-weight: bold;
            height: 36px;
        }
        .style68
        {
            height: 21px;
            color: Red;
        }
        .style69
        {
            width: 309px;
        }
        .style70
        {
            width: 85px;
        }
        .style71
        {
            width: 239px;
        }
        .style73
        {
            width: 265px;
        }
        .style27
        {
            font-size: x-large;
            font-family: 標楷體;
            font-weight: bold;
        }
        #MutiView
        {
            text-align: center;
        }
    </style>
</head>
<body class="body">
    <form id="form1" runat="server">
    <asp:SqlDataSource ID="Notice_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT * FROM [公告] ORDER BY [ID] DESC"></asp:SqlDataSource>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <span class="style27">
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT [班級別], [班級編號] FROM [班級]"></asp:SqlDataSource>
    </span>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        DeleteCommand="DELETE FROM 學生 WHERE (學號 = @學號)" InsertCommand="INSERT INTO 學生(學號, 密碼, 姓名, 班級編號, 電子郵件地址) VALUES (@學號, @密碼, @姓名, @班級編號, @電子郵件地址)"
        SelectCommand="SELECT 學號, 密碼, 姓名, 班級編號, 電子郵件地址 FROM 學生" UpdateCommand="UPDATE 學生 SET 學號 = @學號, 密碼 = @密碼, 姓名 = @姓名, 電子郵件地址 = @電子郵件地址">
        <DeleteParameters>
            <asp:Parameter Name="學號" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="學號" />
            <asp:Parameter Name="密碼" />
            <asp:Parameter Name="姓名" />
            <asp:Parameter Name="電子郵件地址" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="學號" />
            <asp:Parameter Name="密碼" />
            <asp:Parameter Name="姓名" />
            <asp:Parameter Name="班級編號" />
            <asp:Parameter Name="電子郵件地址" />
        </InsertParameters>
    </asp:SqlDataSource>
    <div id="Main">
        <div id="container" class="container ">
            <div id="mainContent">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <p>
                            <table style="width: 100%;">
                                <tr>
                                    <td class="style22" style="width: 180px; vertical-align: top">
                                        <img alt="e-tasks" class="style25" src="images/logo.png" />
                                    </td>
                                    <td class="style3" style="vertical-align: top">
                                        &nbsp;
                                    </td>
                                    <td class="style4" style="vertical-align: top; text-align: right;">
                                        &nbsp;&nbsp; <span lang="zh-tw">
                                            <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: #C0C0C0;
                                        height: 30px;">
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                            <div id="Div_UpdateProgress" style="width: 100%; height: 20px; margin-right: auto;
                                position: static; padding-left: 20px;">
                                <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0">
                                    <ProgressTemplate>
                                        <div style="text-align: center;">
                                            <img alt="loading" src="images/ajax-loader.gif" /></div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </div>
                            <div id="MutiView">
                                <br />
                                <asp:MultiView ID="MultiView_Notice" runat="server" ActiveViewIndex="0">
                                    <asp:View ID="View_Notice" runat="server">
                                        <table class="style21">
                                            <tr>
                                                <td style="text-align: center;">
                                                    &nbsp;
                                                    <asp:Image ID="Image6" runat="server" ImageUrl="~/images/Chat_01.png" Width="128px" />
                                                    <asp:Image ID="Image7" runat="server" ImageUrl="~/images/notice.png" />
                                                </td>
                                                <td style="width: 55%; text-align: left; border-left-style: solid; border-left-width: 1px;
                                                    border-left-color: #C0C0C0; padding-left: 20px">
                                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID"
                                                        DataSourceID="Notice_SqlDataSource" EnableModelValidation="True" GridLines="None"
                                                        ShowHeader="False" Width="515px" Style="text-align: left" 
                                                        AllowPaging="True" PageSize="5">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Time" ShowHeader="False" SortExpression="ID">
                                                                <EditItemTemplate>
                                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Time", "{0:yyyy-MM-dd}") %>'></asp:Label>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Time", "{0:yyyy-MM-dd}") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="NoticeText" ShowHeader="False" SortExpression="ID">
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("NoticeText") %>'></asp:TextBox>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("NoticeText") %>' BorderWidth="0px"
                                                                        ReadOnly="True" Width="425px"></asp:TextBox>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:View>
                                </asp:MultiView>
                                <asp:MultiView ID="MultiView_Main" runat="server" ActiveViewIndex="0">
                                    <asp:View ID="View_STLogin" runat="server">
                                        <asp:Panel ID="Panel1" runat="server" meta:resourcekey="Panel1Resource1">
                                            <table style="width: 100%; vertical-align: middle;">
                                                <tr>
                                                    <td class="style12">
                                                        &nbsp;
                                                    </td>
                                                    <td id="TD_Right" rowspan="3" style="border-left-style: solid; border-left-width: 1px;
                                                        border-left-color: #C0C0C0; padding-left: 20px; width: 55%;">
                                                        <layouttemplate>
                                                        <table border="0" cellpadding="1" cellspacing="0" style="border-collapse: collapse;">
                                                            <tr>
                                                                <td class="style69">
                                                                    <table border="0" cellpadding="0" style="width: 358px">
                                                                        <tr>
                                                                            <td align="center" class="style73">
                                                                                <span lang="zh-tw">
                                                                                <asp:Login ID="Login_S" runat="server" DestinationPageUrl="~/st-data.aspx" 
                                                                                    FailureAction="RedirectToLoginPage">
                                                                                    <LayoutTemplate>
                                                                                        <table cellpadding="1" cellspacing="0" style="border-collapse:collapse;">
                                                                                            <tr>
                                                                                                <td class="style71">
                                                                                                    <table cellpadding="0">
                                                                                                        <tr>
                                                                                                            <td align="right">
                                                                                                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">學號：</asp:Label>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:TextBox ID="UserName" runat="server" BorderStyle="Dotted" 
                                                                                                                    BorderWidth="1px" Width="150px"></asp:TextBox>
                                                                                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                                                                                                    ControlToValidate="UserName" ErrorMessage="必須提供使用者名稱。" ToolTip="必須提供使用者名稱。" 
                                                                                                                    ValidationGroup="Login_S">*</asp:RequiredFieldValidator>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <tr>
                                                                                                            <td align="center" class="style68" colspan="2">
                                                                                                                
                                                                                                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal><asp:Label ID="Label4" runat="server" Text="   "></asp:Label>
                                                                                                               </td>
                                                                                                        </tr>
                                                                                                        <tr>
                                                                                                            <td colspan="2">
                                                                                                                <span lang="zh-tw">
                                                                                                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">密碼：</asp:Label>
                                                                                                                <asp:TextBox ID="Password" runat="server" BorderStyle="Dotted" 
                                                                                                                    BorderWidth="1px" TextMode="Password" Width="150px"></asp:TextBox>
                                                                                                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                                                                                                    ControlToValidate="Password" ErrorMessage="必須提供密碼。" ToolTip="必須提供密碼。" 
                                                                                                                    ValidationGroup="Login_S">*</asp:RequiredFieldValidator>
                                                                                                                </span>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <tr>
                                                                                                            <td align="right" colspan="2">
                                                                                                                &nbsp;</td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </LayoutTemplate>
                                                                                </asp:Login>
                                                                                </span></td>
                                                                            <td rowspan="5" class="style70" style="text-align: left">
                                                                                <span lang="zh-tw">
                                                                                <asp:Button ID="LoginButton_S" runat="server" CommandName="Login" Text="登入" 
                                                                                    ValidationGroup="Login_S" Height="124px" onclick="LoginButton_S_Click" 
                                                                                    Width="60px" />
                                                                                </span>
                                                                            </td>
                                                                        </tr>
                                                                      
                                                                        <tr>
                                                                            <td align="center" style="color: Red" class="style73">
                                                                                <span class="style63">您是教師嗎？　<asp:LinkButton ID="LinkButton_IsTeacher" 
                                                                                    runat="server" onclick="LinkButton_IsTeacher_Click">教師登入</asp:LinkButton>
                                                                                </span>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="center" style="color: Red;" class="style73">
                                                                                <span class="style63">您首次使用嗎？<asp:LinkButton ID="LinkButton_Reg" runat="server" 
                                                                                    CausesValidation="False" onclick="LinkButton_Reg_Click">點我註冊</asp:LinkButton>
                                                                                </span>
                                                                            </td>
                                                                        </tr>
                                                                      
                                                                        <tr>
                                                                            <td align="center" class="style73" style="color: Red;">
                                                                                <span class="style63">忘記密碼了嗎？</span><asp:LinkButton ID="LinkButton_SForget" 
                                                                                    runat="server" onclick="LinkButton_IsStudent_Click">忘記密碼</asp:LinkButton>
                                                                            </td>
                                                                        </tr>
                                                                      
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="style13">
                                                        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/school.png" Height="128px"
                                                            Width="128px" meta:resourcekey="Image1Resource1" />
                                                        <asp:Image ID="Image2" runat="server" ImageUrl="~/images/welcome.png" />
                                                        &nbsp;<span lang="zh-tw">&nbsp;&nbsp;&nbsp;</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </asp:View>
                                    <asp:View ID="View_TALogin" runat="server">
                                        <asp:Panel ID="Panel2" runat="server" meta:resourcekey="Panel1Resource1">
                                            <table style="width: 100%; vertical-align: middle;">
                                                <tr>
                                                    <td class="style12">
                                                        &nbsp;
                                                    </td>
                                                    <td id="TD_Right0" rowspan="3" style="border-left-style: solid; border-left-width: 1px;
                                                        border-left-color: #C0C0C0; padding-left: 20px; width: 55%;">
                                                        <layouttemplate>
                                                    <table border="0" cellpadding="1" cellspacing="0" 
                                                        style="border-collapse: collapse;">
                                                        <tr>
                                                            <td class="style17">
                                                                <table border="0" cellpadding="1" cellspacing="0" 
                                                                    style="border-collapse: collapse;">
                                                                    <tr>
                                                                        <td class="style69">
                                                                            <table border="0" cellpadding="0" style="width: 358px">
                                                                                <tr>
                                                                                    <td align="center" class="style73">
                                                                                        <span lang="zh-tw">
                                                                                        <asp:Login ID="Login_T" runat="server">
                                                                                            <LayoutTemplate>
                                                                                                <table cellpadding="1" cellspacing="0" style="border-collapse:collapse;">
                                                                                                    <tr>
                                                                                                        <td class="style71">
                                                                                                            <table cellpadding="0">
                                                                                                                <tr>
                                                                                                                    <td align="right">
                                                                                                                        <asp:Label ID="UserNameLabel0" runat="server" AssociatedControlID="UserName">帳號：</asp:Label>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:TextBox ID="UserName" runat="server" BorderStyle="Dotted" 
                                                                                                                            BorderWidth="1px" Width="150px"></asp:TextBox>
                                                                                                                        <asp:RequiredFieldValidator ID="UserNameRequired0" runat="server" 
                                                                                                                            ControlToValidate="UserName" ErrorMessage="必須提供使用者名稱。" ToolTip="必須提供使用者名稱。" 
                                                                                                                            ValidationGroup="Login_T">*</asp:RequiredFieldValidator>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td align="center" class="style68" colspan="2">
                                                                                                                        <span lang="zh-tw">
                                                                                                                        <asp:Label ID="Label4" runat="server" Text="   "></asp:Label>
                                                                                                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                                                                                                        </span>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td colspan="2">
                                                                                                                        <span lang="zh-tw">
                                                                                                                        <asp:Label ID="PasswordLabel0" runat="server" AssociatedControlID="Password">密碼：</asp:Label>
                                                                                                                        <asp:TextBox ID="Password" runat="server" BorderStyle="Dotted" 
                                                                                                                            BorderWidth="1px" TextMode="Password" Width="150px"></asp:TextBox>
                                                                                                                        <asp:RequiredFieldValidator ID="PasswordRequired0" runat="server" 
                                                                                                                            ControlToValidate="Password" ErrorMessage="必須提供密碼。" ToolTip="必須提供密碼。" 
                                                                                                                            ValidationGroup="Login_T">*</asp:RequiredFieldValidator>
                                                                                                                        </span>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td align="right" colspan="2">
                                                                                                                        &nbsp;</td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </LayoutTemplate>
                                                                                        </asp:Login>
                                                                                        </span>
                                                                                    </td>
                                                                                    <td class="style70" rowspan="5" style="text-align: left">
                                                                                        <span lang="zh-tw">
                                                                                        <asp:Button ID="LoginButton_T" runat="server" CommandName="Login" 
                                                                                            Height="124px" onclick="LoginButton_T_Click" style="text-align: center" Text="登入" 
                                                                                            ValidationGroup="Login_T" Width="60px" />
                                                                                        </span>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="center" >
                                                                                 <span class="style63">您是學生嗎？　</span><asp:LinkButton ID="LinkButton_IsStudent" 
                                                runat="server" onclick="LinkButton_IsStudent_Click">學生登入</asp:LinkButton>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="center" >
                                                                         
                                            忘記密碼了嗎？<asp:LinkButton ID="LinkButton_TForget" runat="server" 
                                                onclick="LinkButton_IsStudent_Click">忘記密碼</asp:LinkButton>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="center">
                                                                                        &nbsp;</td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="style13">
                                                        <asp:Image ID="Image5" runat="server" Height="128px" ImageUrl="~/images/Sign In.png"
                                                            meta:resourcekey="Image1Resource1" Width="128px" />
                                                        <asp:Image ID="Image4" runat="server" ImageUrl="~/images/welcome.png" />
                                                        &nbsp;<span lang="zh-tw">&nbsp;&nbsp;&nbsp;</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </asp:View>
                                    <asp:View ID="View_Regid" runat="server">
                                        <table class="style21">
                                            <tr>
                                                <td style="width: 20%;">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                        <table class="style21">
                                            <tr>
                                                <td class="style28">
                                                    &nbsp;
                                                </td>
                                                <td class="style62">
                                                    <br />
                                                    <asp:Image ID="Image3" runat="server" Height="125px" ImageUrl="~/images/User Info.png"
                                                        Width="157px" />
                                                    <br />
                                                    <br />
                                                    請詳細輸入右列資料，注意學號僅能為數字！
                                                </td>
                                                <td class="style28">
                                                    <asp:FormView ID="FormView_Reg" runat="server" DataKeyNames="學號" DataSourceID="SqlDataSource1"
                                                        DefaultMode="Insert" Height="253px" Style="border: 0px groove #000000; padding: 1px 4px;
                                                        font-size: large; text-align: left; margin-left: 0px;" Width="578px" BorderColor="White"
                                                        BorderWidth="0px" OnPageIndexChanging="FormView_Reg_PageIndexChanging">
                                                        <EditItemTemplate>
                                                            學號:
                                                            <asp:Label ID="學號Label1" runat="server" Text='<%# Eval("學號") %>' />
                                                            <br />
                                                            密碼:
                                                            <asp:TextBox ID="密碼TextBox" runat="server" Text='<%# Bind("密碼") %>' />
                                                            <br />
                                                            姓名:
                                                            <asp:TextBox ID="姓名TextBox" runat="server" Text='<%# Bind("姓名") %>' />
                                                            <br />
                                                            班級編號:
                                                            <asp:TextBox ID="班級編號TextBox" runat="server" Text='<%# Bind("班級編號") %>' />
                                                            <br />
                                                            電子郵件地址:
                                                            <asp:TextBox ID="電子郵件地址TextBox" runat="server" Text='<%# Bind("電子郵件地址") %>' />
                                                            <br />
                                                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                                                Text="更新" />
                                                            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False"
                                                                CommandName="Cancel" Text="取消" />
                                                        </EditItemTemplate>
                                                        <InsertItemTemplate>
                                                            <table class="style51">
                                                                <tr>
                                                                    <td class="style65">
                                                                        學號
                                                                    </td>
                                                                    <td class="style66">
                                                                        :<span class="style38"><asp:TextBox ID="學號TextBox" runat="server" Style="font-family: 金梅樹枝美工字體;
                                                                            font-weight: 700" Text='<%# Bind("學號") %>' AutoPostBack="True" CausesValidation="True"
                                                                            OnTextChanged="LinkButton_Check_Click" />
                                                                            <asp:Label ID="Label3" runat="server" ForeColor="Red" Style="font-size: large; font-family: 金梅樹枝美工字體"></asp:Label>
                                                                        </span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="style60">
                                                                        密碼
                                                                    </td>
                                                                    <td class="style61">
                                                                        :<span class="style38"><asp:TextBox ID="密碼TextBox" runat="server" Style="font-family: 金梅樹枝美工字體;
                                                                            font-weight: 700" Text='<%# Bind("密碼") %>' TextMode="Password" />
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="密碼TextBox"
                                                                                Display="Dynamic" Enabled="False" ErrorMessage="※請輸入密碼!" Style="font-size: large"></asp:RequiredFieldValidator>
                                                                        </span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="style60">
                                                                        確認密碼
                                                                    </td>
                                                                    <td class="style61">
                                                                        :<span class="style38"><asp:TextBox ID="TextBox3" runat="server" Style="font-family: 金梅樹枝美工字體;
                                                                            font-weight: 700" TextMode="Password"></asp:TextBox>
                                                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="密碼TextBox"
                                                                                ControlToValidate="TextBox3" ErrorMessage="※密碼兩次輸入不一致" Style="font-size: large"></asp:CompareValidator>
                                                                        </span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="style60">
                                                                        姓名
                                                                    </td>
                                                                    <td class="style61">
                                                                        :<span class="style38"><asp:TextBox ID="姓名TextBox" runat="server" Style="font-family: 金梅樹枝美工字體;
                                                                            font-weight: 700" Text='<%# Bind("姓名") %>' MaxLength="5" />
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="姓名TextBox"
                                                                                Enabled="False" ErrorMessage="※請輸入姓名" Style="font-size: large"></asp:RequiredFieldValidator>
                                                                        </span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="style60">
                                                                        班級編號
                                                                    </td>
                                                                    <td class="style61">
                                                                        :<span class="style38"><asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2"
                                                                            DataTextField="班級別" DataValueField="班級編號" SelectedValue='<%# Bind("班級編號") %>'
                                                                            Style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large">
                                                                        </asp:DropDownList>
                                                                        </span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="style60">
                                                                        電子郵件地址
                                                                    </td>
                                                                    <td class="style61">
                                                                        :<span class="style38"><asp:TextBox ID="電子郵件地址TextBox" runat="server" Style="font-family: 金梅樹枝美工字體;
                                                                            font-weight: 700" Text='<%# Bind("電子郵件地址") %>' />
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="電子郵件地址TextBox"
                                                                                Display="Dynamic" Enabled="False" ErrorMessage="※請輸入郵件地址!" Style="font-size: large"></asp:RequiredFieldValidator>
                                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="電子郵件地址TextBox"
                                                                                Display="Dynamic" Enabled="False" ErrorMessage="※請輸入正確的郵件地址" Style="font-size: large"
                                                                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                                        </span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="style60" colspan="2">
                                                                        &nbsp;
                                                                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                                                            Enabled="False" OnClick="InsertButton_Click" Text="註冊" />
                                                                        ｜<asp:LinkButton ID="LinkButton_Check" runat="server" OnClick="LinkButton_Check_Click">檢查</asp:LinkButton>
                                                                        ｜<asp:LinkButton ID="LinkButton_Eraser" runat="server" OnClick="LinkButton_Eraser_Click"
                                                                            CausesValidation="False">重填</asp:LinkButton>
                                                                        ｜<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False"
                                                                            CommandName="Cancel" OnClick="InsertCancelButton_Click" Text="取消" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </InsertItemTemplate>
                                                        <ItemTemplate>
                                                            學號:
                                                            <asp:Label ID="學號Label" runat="server" Text='<%# Eval("學號") %>' />
                                                            <br />
                                                            密碼:
                                                            <asp:Label ID="密碼Label" runat="server" Text='<%# Bind("密碼") %>' />
                                                            <br />
                                                            姓名:
                                                            <asp:Label ID="姓名Label" runat="server" Text='<%# Bind("姓名") %>' />
                                                            <br />
                                                            電子郵件地址:
                                                            <asp:Label ID="電子郵件地址Label" runat="server" Text='<%# Bind("電子郵件地址") %>' />
                                                            <br />
                                                            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                                                                Text="編輯" />
                                                            &nbsp;&nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False"
                                                                CommandName="Delete" Text="刪除" />
                                                            &nbsp;&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False"
                                                                CommandName="New" Text="新增" />
                                                        </ItemTemplate>
                                                    </asp:FormView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" rowspan="3">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:View>
                                    <asp:View ID="View_RegClose" runat="server">
                                        <table class="style21">
                                            <tr>
                                                <td align="center" class="style73" style="color: Red">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center">
                                                    <asp:Label ID="Label_RegClose" runat="server" ForeColor="Red" 
                                                        Text="未開放註冊，請洽任課老師" Font-Bold="True" Font-Size="Large"></asp:Label>
                                                    <br />
                                                    <br />
                                                </td>
                                            </tr>
                                        </table>
                                        <table class="style21">
                                            <tr>
                                                <td align="center">
                                                    <span class="style63">您是學生嗎？　</span><asp:LinkButton ID="LinkButton_IsStudent0" 
                                                        runat="server" onclick="LinkButton_IsStudent_Click">學生登入</asp:LinkButton>
                                                    <br />
                                                    <span class="style63">您是教師嗎？　<asp:LinkButton ID="LinkButton_IsTeacher1" 
                                                        runat="server" onclick="LinkButton_IsTeacher_Click">教師登入</asp:LinkButton>
                                                    <br />
                                                    忘記密碼了嗎？<asp:LinkButton ID="LinkButton_TForget0" runat="server" 
                                                        onclick="LinkButton_IsStudent_Click">忘記密碼</asp:LinkButton>
                                                    </span>
                                                    <br />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:View>
                                    <asp:View ID="View_GetPassword" runat="server">
                                        <table style="width: 100%;">
                                            <tr>
                                                <td style="width: 35%;">
                                                                                                  </td>
                                                <td>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                    </asp:View>
                                    <asp:View ID="View_Cantlogin" runat="server">
                                        <span lang="zh-tw">不能登入？</span>
                                    </asp:View>
                                </asp:MultiView>
                            </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <!-- end #mainContent -->
            </div>
            <!-- end #container -->
        </div>
    </div>
    <div class="style64">
        - Powered-by-許鈞霆/陳獻欽/陳紀緯-©2011-CSU-CSIE - 99學年度學生專題 -
    </div>
    </form>
</body>
</html>
