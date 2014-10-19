<%@ Page Language="VB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        
        FormView1.Enabled = False
        If verify(TextBox1.Text, TextBox2.Text) Then
            Session("OK_STU") = TextBox1.Text
            Response.Redirect("st-home.aspx")
        Else
            Label1.Visible = True
            Label1.ForeColor = Drawing.Color.Red
            Label1.Text = "帳號或密碼錯誤, 請重新輸入!"
        End If
    End Sub
    Function verify(ByVal ACCOUNT As String, ByVal PSWD As String) As Boolean
        Dim conn As Data.SqlClient.SqlConnection, cmd As Data.SqlClient.SqlCommand
        Dim Rd As Data.SqlClient.SqlDataReader, SQL As String

        conn = New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
        conn.Open()
        SQL = "Select * From 學生 Where " & "學號='" & ACCOUNT & "'" & " And 密碼='" & PSWD & "'"
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        Rd = cmd.ExecuteReader()
        If Rd.Read() Then
            conn.Close()
            Return True
        Else
            conn.Close()
            Return False
        End If
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        MultiView1.ActiveViewIndex = 0
       
    End Sub

    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("st-new.aspx")
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.TextBox1.Text = ""
        Me.TextBox2.Text = ""
    End Sub

    Protected Sub InsertButton_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Label2.Text = "註冊成功!"
        MultiView1.ActiveViewIndex = 0
    End Sub

    Protected Sub Button_check_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        MultiView1.ActiveViewIndex = 2
        Dim conn As Data.SqlClient.SqlConnection, cmd As Data.SqlClient.SqlCommand
        Dim Rd As Data.SqlClient.SqlDataReader, SQL As String
        Dim check As Boolean
        Dim x As Integer
        
        If CType(FormView1.Row.Cells(0).FindControl("學號TextBox"), TextBox).Text.Length  = 0 Then
            CType(FormView1.Row.Cells(0).FindControl("Label3"), Label).Text = "帳號不能為空"
        Else
            For i = 1 To Len(CType(FormView1.Row.Cells(0).FindControl("學號TextBox"), TextBox).Text)
                x = Asc(Mid(CType(FormView1.Row.Cells(0).FindControl("學號TextBox"), TextBox).Text, i, 1))
                If x >= 48 And x <= 57 Then
                    Continue For
                Else
                    CType(FormView1.Row.Cells(0).FindControl("Label3"), Label).Text = "學號只能為數字"
                    check = False
                    Return 
                End If
            Next i
            
            conn = New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
            conn.Open()
            SQL = "SELECT * FROM 學生 WHERE 學號 = '" & CType(FormView1.Row.Cells(0).FindControl("學號TextBox"), TextBox).Text & "'"
            cmd = New Data.SqlClient.SqlCommand(SQL, conn)
            Rd = cmd.ExecuteReader
            If Rd.Read() Then
                check = True
                conn.Close()
            Else
                check = False
                conn.Close()
            End If
        
            If check = True Then
                CType(FormView1.Row.Cells(0).FindControl("Label3"), Label).Text = "已有人使用，請重新輸入"
                CType(FormView1.Row.Cells(0).FindControl("學號TextBox"), TextBox).Text = ""
                CType(FormView1.Row.Cells(0).FindControl("InsertButton"), LinkButton).Enabled = False
            Else
                CType(FormView1.Row.Cells(0).FindControl("InsertButton"), LinkButton).Enabled = True
                CType(FormView1.Row.Cells(0).FindControl("Label3"), Label).Text = "可以使用"
                CType(FormView1.Row.Cells(0).FindControl("CompareValidator1"), CompareValidator).Enabled = True
                CType(FormView1.Row.Cells(0).FindControl("RequiredFieldValidator4"), RequiredFieldValidator).Enabled = True
                CType(FormView1.Row.Cells(0).FindControl("RequiredFieldValidator5"), RequiredFieldValidator).Enabled = True
                CType(FormView1.Row.Cells(0).FindControl("RegularExpressionValidator2"), RegularExpressionValidator).Enabled = True
            End If

        End If
        
    End Sub

    Protected Sub Button2_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
        If Application("open_close") = "close" Then
            MultiView1.ActiveViewIndex = 1
        Else
            Application("open_close") = "open"
            MultiView1.ActiveViewIndex = 2
        End If
        CType(FormView1.Row.Cells(0).FindControl("Label3"), Label).Text = ""
        CType(FormView1.Row.Cells(0).FindControl("InsertButton"), LinkButton).Enabled = False
        CType(FormView1.Row.Cells(0).FindControl("CompareValidator1"), CompareValidator).Enabled = False
        CType(FormView1.Row.Cells(0).FindControl("RequiredFieldValidator4"), RequiredFieldValidator).Enabled = False
        CType(FormView1.Row.Cells(0).FindControl("RequiredFieldValidator5"), RequiredFieldValidator).Enabled = False
        CType(FormView1.Row.Cells(0).FindControl("RegularExpressionValidator2"), RegularExpressionValidator).Enabled = False
        CType(FormView1.Row.Cells(0).FindControl("學號TextBox"), TextBox).Text = ""
        CType(FormView1.Row.Cells(0).FindControl("密碼TextBox"), TextBox).Text = ""
        CType(FormView1.Row.Cells(0).FindControl("TextBox3"), TextBox).Text = ""
        CType(FormView1.Row.Cells(0).FindControl("姓名TextBox"), TextBox).Text = ""
        CType(FormView1.Row.Cells(0).FindControl("電子郵件地址TextBox"), TextBox).Text = ""
    End Sub


    Protected Sub FormView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewPageEventArgs)

    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>未命名頁面</title>
    <style type="text/css">
        .style1
        {
            font-size: xx-large;
            font-family: 標楷體;
            text-align: right;
            height: 25px;
            width: 287px;
        }
        .style9
        {
            width: 966px;
            padding: 1px 4px;
        }
        #form1
        {
            width: 961px;
        }
        .style16
        {
            font-size: large;
            font-family: 金梅特黑吐舌頭字;
            text-align: left;
        }
        .style17
        {
            width: 94px;
            font-size: xx-large;
            font-family: 標楷體;
            font-weight: bold;
        }
        .style18
        {
            width: 964px;
            height: 429px;
        }
        .style19
        {
            width: 347px;
            height: 348px;
        }
        .style21
        {
            width: 50px;
            height: 348px;
        }
        .style27
        {
            font-size: x-large;
            font-family: 標楷體;
            font-weight: bold;
            }
        .style29
        {
            width: 312px;
            font-size: x-large;
            font-family: 標楷體;
            font-weight: bold;
            text-align: center;
        }
        .style31
        {
            padding: 1px 4px;
            font-size: 52px;
            font-family: 金梅特黑吐舌頭字;
            border-bottom-style: solid;
            border-bottom-width: 1px;
            text-align: center;
        }
        .style33
        {
            height: 44px;
            text-align: center;
        }
        .style35
        {
            font-size: x-large;
            font-family: 金梅重圓破裂字形;
        }
        .style36
        {
            font-family: 金梅特黑吐舌頭字;
            text-align: center;
        }
        .style38
        {
            font-size: x-large;
        }
        .style39
        {
            border-style: solid;
            border-width: 2px;
            padding: 1px 4px;
            width: 100%;
                height: 258px;
        }
        .style45
        {
            border-style: outset;
            border-color: #000000;
        }
        .style47
        {
            text-align: center;
        }
        .style48
        {
            font-family: 金梅特黑吐舌頭字;
            text-align: center;
            font-size: xx-large;
        }
        .style49
        {
            font-family: 金梅特黑吐舌頭字;
        }
        .style50
        {
            font-family: 金梅特黑吐舌頭字;
            font-size: large;
        }
        .style51
        {
            width: 100%;
        }
        .style52
        {
            font-family: 標楷體;
            text-align: right;
            height: 25px;
            width: 287px;
        }
        .style53
        {
            font-family: 金梅特黑吐舌頭字;
            text-align: left;
        }
        .style54
        {
            font-family: 金梅特黑吐舌頭字;
            text-align: center;
            font-size: x-large;
            font-weight: bold;
        }
        .style55
        {
            text-align: right;
            height: 25px;
            width: 287px;
        }
        .style56
        {
            height: 17px;
            text-align: center;
        }
        .style57
        {
            font-family: 金梅特黑吐舌頭字;
            text-align: left;
            font-size: x-large;
            font-weight: bold;
        }
        .style58
        {
            font-size: large;
        }
        .style60
        {
            width: 148px;
            font-size: x-large;
        }
        .style61
        {
            font-size: x-large;
            font-weight: bold;
        }
        </style>
</head>
<body background="未命名%20-10.jpg">
    <form id="form1" runat="server" 
    style="background-image: none; height: 495px;" dir="ltr">
   
    
        <table class="style9">
            <tr>
                <td class="style17">
                </td>
                <td class="style31">
                    線上測驗系統</td>
            </tr>
            </table>
        <table class="style18">
            <tr>
                <td class="style21" rowspan="2">
                    &nbsp;</td>
                <td class="style33" colspan="3">
                    &nbsp;<br />
                    <span class="style35">&nbsp;&nbsp;&nbsp;&nbsp; <span class="style49">&nbsp;&nbsp; 登入學生子系統<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span 
                        class="style49">(第一次使用請先註冊帳號!)</span>&nbsp;&nbsp;&nbsp;&nbsp; </td>
            </tr>
            <tr>
                <td class="style19">
                    <br />
</td>
                <td class="style19">
                    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="2">
                        <asp:View ID="View3" runat="server">
                            <table class="style39">
                                <tr>
                                    <td class="style45">
                                       
                                        <table class="style51">
                                            <tr>
                                                <td class="style47">
                                                  
                                                    <span class="style53"><span class="style52"><span class="style57">學號：</span></span></span><span 
                                                        class="style38"><b></b></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></b></span><span 
                                                     
                                                        class="style36"><span class="style38"><span class="style38"><b><asp:TextBox 
                                                        ID="TextBox1" runat="server" Height="16px" Width="120px" 
                                                        style="font-family: 金梅樹枝美工字體; font-weight: 700"></asp:TextBox>
                                                    </b>
                                                    <br class="style45" />
                                                    </span>
                                                 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style54">
                                                    <span class="style36"><span class="style53"><span class="style55">
                                                    <span>密碼</span></span></span><span class="style53"><span class="style55"><span>：</span></span></span><span 
                                                        class="style16"><span class="style1"><span class="style27"><span 
                                                        class="style38"><span class="style49"><span class="style58"><span 
                                                        class="style38"><asp:TextBox ID="TextBox2" runat="server" Height="16px" 
                                                        TextMode="Password" Width="117px" 
                                                        style="font-family: 金梅樹枝美工字體; font-weight: 700"></asp:TextBox>
                                                    <br class="style45" />
                                                    </span></span>
                                                    </span></span></span></span></span></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center">
                                                    
                                                    <asp:Label ID="Label1" runat="server" 
                                                        style="font-size: large; font-family: 金梅黑框浮體字形; font-weight: 700;" 
                                                        Visible="False"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center">
                                                    <asp:Button ID="Button1" runat="server" Height="24px" onclick="Button1_Click" 
                                                        style="font-family: 金梅特黑吐舌頭字; font-size: large; font-weight: 700;" 
                                                        Text="登入" Width="51px" 
                                                        BackColor="#FF9933" BorderColor="#999999" BorderStyle="Outset" />
                                                  
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                  
                                                    <asp:Button ID="Button2" runat="server" onclick="Button2_Click1" 
                                                        style="font-family: 金梅特黑吐舌頭字; font-weight: 700; font-size: large;" 
                                                        Text="註冊" BackColor="#FF9933" BorderColor="#999999" Height="22px" 
                                                        BorderStyle="Outset" />
                                                    
                                    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style56">
                                                    <asp:Label ID="Label2" runat="server" 
                                                        style="font-size: x-large; text-align: center;"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                       
                                    </td>
                                </tr>
                            </table>
                        </asp:View>
                        <asp:View ID="View2" runat="server">
                            <div class="style47">
                                <br><span class="style48">帳號註冊</span><br>
                                <br></br>
                                <span class="style50">註冊尚未開放!</span><br class="style50" />
                                <span class="style50">請洽任課老師!</span><br></br>
                                </br>
                                </br>
                            </div>
                        </asp:View>
                        <asp:View ID="View1" runat="server">
                            <div class="style47">
                                <br />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label4" runat="server" style="font-size: xx-large" Text="帳號註冊"></asp:Label>
                                <span class="style36"> <br />
                                </span>
                            </div>
                            <asp:FormView ID="FormView1" runat="server" DataKeyNames="學號" 
                                DataSourceID="SqlDataSource1" DefaultMode="Insert" Height="253px" 
                                style="border: 2px groove #000000; padding: 1px 4px; font-size: large; font-family: 金梅特黑吐舌頭字; text-align: left;" 
                                Width="546px" onpageindexchanging="FormView1_PageIndexChanging">
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
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                                        CommandName="Update" Text="更新" />
                                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                                        CausesValidation="False" CommandName="Cancel" Text="取消" />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <table class="style51">
                                        <tr>
                                            <td class="style60">
                                                學號</td>
                                            <td class="style61">
                                                :s+<span class="style38"><asp:TextBox ID="學號TextBox" runat="server" 
                                                    style="font-family: 金梅樹枝美工字體; font-weight: 700" Text='<%# Bind("學號") %>' />
                                                <asp:Label ID="Label3" runat="server" ForeColor="Red" 
                                                    style="font-size: large; font-family: 金梅樹枝美工字體"></asp:Label>
                                                <asp:Button ID="Button_check" runat="server" BackColor="#FF9933" BorderColor="#999999" 
                                                    onclick="Button_check_Click" style="font-family: 金梅樹枝美工字體" Text="檢查" />
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style60">
                                                密碼</td>
                                            <td class="style61">
                                                :<span class="style38"><asp:TextBox ID="密碼TextBox" runat="server" 
                                                    style="font-family: 金梅樹枝美工字體; font-weight: 700" Text='<%# Bind("密碼") %>' 
                                                    TextMode="Password" />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                                    ControlToValidate="密碼TextBox" Display="Dynamic" Enabled="False" 
                                                    ErrorMessage="※請輸入密碼!" style="font-size: large"></asp:RequiredFieldValidator>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style60">
                                                確認密碼</td>
                                            <td class="style61">
                                                :<span class="style38"><asp:TextBox ID="TextBox3" runat="server" 
                                                    style="font-family: 金梅樹枝美工字體; font-weight: 700" TextMode="Password"></asp:TextBox>
                                                <asp:CompareValidator ID="CompareValidator1" runat="server" 
                                                    ControlToCompare="密碼TextBox" ControlToValidate="TextBox3" 
                                                    ErrorMessage="※密碼兩次輸入不一致" style="font-size: large"></asp:CompareValidator>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style60">
                                                姓名</td>
                                            <td class="style61">
                                                :<span class="style38"><asp:TextBox ID="姓名TextBox" runat="server" 
                                                    style="font-family: 金梅樹枝美工字體; font-weight: 700" Text='<%# Bind("姓名") %>' />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                                    ControlToValidate="姓名TextBox" Enabled="False" ErrorMessage="※請輸入姓名" 
                                                    style="font-size: large"></asp:RequiredFieldValidator>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style60">
                                                班級編號</td>
                                            <td class="style61">
                                                :<span class="style38"><asp:DropDownList ID="DropDownList1" runat="server" 
                                                    DataSourceID="SqlDataSource2" DataTextField="班級別" DataValueField="班級編號" 
                                                    SelectedValue='<%# Bind("班級編號") %>' 
                                                    style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large">
                                                </asp:DropDownList>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style60">
                                                電子郵件地址</td>
                                            <td class="style61">
                                                :<span class="style38"><asp:TextBox ID="電子郵件地址TextBox" runat="server" 
                                                    style="font-family: 金梅樹枝美工字體; font-weight: 700" Text='<%# Bind("電子郵件地址") %>' />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                                    ControlToValidate="電子郵件地址TextBox" Display="Dynamic" Enabled="False" 
                                                    ErrorMessage="※請輸入郵件地址!" style="font-size: large"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                                                    ControlToValidate="電子郵件地址TextBox" Display="Dynamic" Enabled="False" 
                                                    ErrorMessage="※請輸入正確的郵件地址" style="font-size: large" 
                                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style60">
                                                &nbsp;</td>
                                            <td class="style38">
                                                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                                                    CommandName="Insert" Enabled="False" onclick="InsertButton_Click" Text="註冊" />
                                                &nbsp;&nbsp;
                                                <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" 
                                                    CommandName="Cancel" Text="取消" />
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
                                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" 
                                        CommandName="Edit" Text="編輯" />
                                    &nbsp;&nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" 
                                        CommandName="Delete" Text="刪除" />
                                    &nbsp;&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" 
                                        CommandName="New" Text="新增" />
                                </ItemTemplate>
                            </asp:FormView>
                            <span class="style27">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                DeleteCommand="DELETE FROM 學生 WHERE (學號 = @學號)" 
                                InsertCommand="INSERT INTO 學生(學號, 密碼, 姓名, 班級編號, 電子郵件地址) VALUES (@學號, @密碼, @姓名, @班級編號, @電子郵件地址)" 
                                SelectCommand="SELECT 學號, 密碼, 姓名, 班級編號, 電子郵件地址 FROM 學生" 
                                UpdateCommand="UPDATE 學生 SET 學號 = @學號, 密碼 = @密碼, 姓名 = @姓名, 電子郵件地址 = @電子郵件地址">
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
                            </span><span class="style27">
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                SelectCommand="SELECT [班級別], [班級編號] FROM [班級]"></asp:SqlDataSource>
                            </span>
                        </asp:View>
                    </asp:MultiView>
                </td>
                <td class="style29">
                    &nbsp;</td>
            </tr>
            </table>
    </form>
</body>
</html>
