<%@ Page Language="VB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If verify(TextBox1.Text, TextBox2.Text) Then
            Session("OK_userid") = TextBox1.Text
            Response.Redirect("t-data.aspx")
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

    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>未命名頁面</title>
    <style type="text/css">
        .style6
        {
            font-size: large;
            text-align: center;
            font-family: 金梅特黑吐舌頭字;
            font-weight: bold;
        }
        .style7
        {
            font-size: x-large;
            text-align: center;
        }
        .style17
        {
            width: 955px;
        }
        #form1
        {
            width: 815px;
            height: 507px;
        }
        .style22
        {
            width: 13px;
            font-size: xx-large;
            font-weight: bold;
            text-align: center;
        }
        .style25
        {
            font-size: xx-large;
            font-weight: bold;
            width: 15px;
        }
        .style27
        {
            font-size: x-large;
            height: 266px;
            width: 15px;
        }
        .style28
        {
            padding: 1px 4px;
            font-size: 52px;
                text-align: center;
                font-family: 金梅特黑吐舌頭字;
            border-bottom-style: solid;
            border-bottom-width: 1px;
        }
        .style29
        {
            font-size: x-large;
            text-align: center;
            font-family: 金梅特黑吐舌頭字;
            font-weight: bold;
        }
        .style30
        {
            font-size: xx-large;
            text-align: center;
        }
        .style31
        {
            font-size: x-large;
            text-align: center;
            width: 15px;
        }
        .style32
        {
            width: 124px;
            font-size: xx-large;
            font-weight: bold;
            text-align: center;
        }
        .style33
        {
            width: 568px;
            font-size: xx-large;
            font-weight: bold;
            text-align: center;
        }
        .style34
        {
            border: 2px solid #000000;
            padding: 1px 4px;
width: 55%;
                height: 164px;
        }
        .style35
        {
            font-family: 金梅特黑吐舌頭字;
        }
        .style36
        {
            font-size: x-large;
            text-align: center;
            font-family: 金梅特黑吐舌頭字;
        }
    </style>
</head>
<body background="未命名%20-12.jpg">
    <form id="form1" runat="server" style="width: 961px; height: 495px">
    <table class="style17">
        <tr>
            <td class="style25">
                &nbsp;</td>
            <td class="style28" colspan="3">
                線上測驗系統</td>
        </tr>
        <tr>
            <td class="style31">
            </td>
            <td class="style30" colspan="3">
                <span class="style29">教師登入</span>-<span class="style6">更方便管理學生成績</span><span 
                    class="style29">&nbsp;&nbsp;</span></td>
        </tr>
        <tr>
            <td class="style27">
                &nbsp;</td>
            <td class="style32">
                &nbsp;</td>
            <td class="style33">
                <span class="style7">
                <br />
                <table class="style34">
                    <tr>
                        <td class="style36">
                    帳號:<asp:TextBox 
                                    ID="TextBox1" runat="server" Height="19px" Width="130px" 
                                style="font-family: 金梅樹枝美工字體; font-weight: 700"></asp:TextBox>
                                <br />
                                <br />
                                </td>
                    </tr>
                    <tr>
                        <td class="style36">
                                                        密碼:<asp:TextBox 
                                    ID="TextBox2" runat="server" TextMode="Password" Height="19px" 
                        Width="127px" style="font-family: 金梅樹枝美工字體; font-weight: 700"></asp:TextBox>
                                                        <br />
                        </td>
                    </tr>
                    <tr>
                        <td>
                <span class="style7">
                                <asp:Label ID="Label1" runat="server" Height="28px" Visible="False" 
                                    Width="145px" style="text-align: center; font-family: 金梅特黑吐舌頭字;"></asp:Label>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="style7">
                    <asp:Button ID="Button1" runat="server" Height="25px" onclick="Button1_Click" 
                                    Text="登入" Width="62px" 
                                
                                style="text-align: center; font-family: 金梅特黑吐舌頭字; font-size: large; font-weight: 700;" BackColor="#6699FF" 
                                BorderColor="#999999" BorderStyle="Outset" />
                                </span>
                        </td>
                    </tr>
                </table>
                <br class="style35" />
                <span class="style35">&nbsp;第一次登入</span><br class="style36" />
                <span class="style35">帳號:00000</span><br class="style36" />
                <span class="style35">密碼:00000</span></span><br />
            </td>
            <td class="style22">
                &nbsp;</td>
        </tr>
    </table>
    </form>
</body>
</html>
