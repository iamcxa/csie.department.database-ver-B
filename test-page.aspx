<%@ Page Language="VB" %>

<%@ Import Namespace="System.Data" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Application("op_cl") = "cl" Then
            Button1.Visible = False
           
        Else
            Application("op_cl") = "op"
            Button1.Visible = True
        End If
    End Sub
   
    Sub start_test()
        Dim conn As Data.SqlClient.SqlConnection, cmd As Data.SqlClient.SqlCommand
        Dim Rd As Data.SqlClient.SqlDataReader, SQL As String
        Dim Q1_max As Integer
        
        conn = New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
        conn.Open()
        SQL = "SELECT * FROM 試卷 WHERE 課程編號 = '" & Me.Session("class_test") & "'"
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        Rd = cmd.ExecuteReader
        While Rd.Read()
            Q1_max = Q1_max + 1
        End While
        Q1_max = Q1_max - 1
        conn.Close()
        
        conn.Open()
        Dim Q1(Q1_max) As Integer
        Dim a As Integer
        SQL = "SELECT * FROM 試卷 WHERE 課程編號 = '" & Me.Session("class_test") & "'"
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        Rd = cmd.ExecuteReader
        While Rd.Read()
            Q1(a) = Rd.GetValue(0)
            a = a + 1
        End While
        conn.Close()
        
        Dim Q2_chapter(Q1_max) As Integer
        Dim b As Integer
        For i As Integer = 0 To Q1_max Step 1
            conn.Open()
            SQL = "Select * From 命題範圍 Where 試卷編號 = '" & Q1(i) & "' and 所屬章節='" & Me.Session("chapter") & "'"
            cmd = New Data.SqlClient.SqlCommand(SQL, conn)
            Rd = cmd.ExecuteReader
            If Rd.Read() = True Then
                Q2_chapter(b) = Rd.GetValue(0)
                b = b + 1
                conn.Close()
            Else
                conn.Close()
            End If
        Next
        
        Dim RM As New Random
        Dim RM_Value As Integer
        RM_Value = RM.Next(0, b - 1)
        Session("test_no") = Q2_chapter(RM_Value)
        
        Dim tim As String
        Dim data As String
        tim = Now.Date & " " & Now.Hour & ":" & Now.Minute & ":" & Now.Second
        data = Now.Date
        conn.Open()
        cmd.CommandText = "Insert Into 應試 (試卷編號,始試時間,測驗日期) Values ('" & Q2_chapter(RM_Value) & "','" & tim & "','" & data & "')"
        cmd.Connection = conn
        cmd.ExecuteNonQuery()
        conn.Close()
        
        conn.Open()
        SQL = "SELECT MAX (答案卡編號) FROM 應試"
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        Rd = cmd.ExecuteReader
        If Rd.Read() Then
            Session("answer_no") = Rd.GetValue(0)
            conn.Close()
        End If
        conn.Close()
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        MultiView1.ActiveViewIndex = 1
        Me.Label1.Text = "題號1:"
        start_test()
        Session("no") = 0
        Session("test_select_no") = 0
        Me.TextBox1.Text = test_text()
        swiching()
        Me.Label12.Text = (Session("PicPath"))
        Me.Image1.ImageUrl = Session("PicPath")
        Timer1.Enabled = True
    End Sub
    
    Function swiching() As Integer
        Me.Label1.Visible = True
        Me.Label2.Visible = True
        Me.TextBox1.Visible = True
        Me.RadioButtonList1.Visible = True
        Me.TextBox2.Visible = False
        Me.Button1.Visible = False
        Me.Button_select_answer.Visible = True
    End Function
    
    Function test_count() As Integer
        Dim conn As Data.SqlClient.SqlConnection, cmd As Data.SqlClient.SqlCommand
        Dim Rd As Data.SqlClient.SqlDataReader, SQL As String
        Dim max As Integer
        conn = New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
        conn.Open()
        SQL = "SELECT * FROM 試題 WHERE 試卷編號 = '" & Session("test_no") & "'"
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        Rd = cmd.ExecuteReader
        While Rd.Read()
            max = max + 1
        End While
        conn.Close()
        max = max - 1
        Return max
    End Function
    
    Function test_text() As String
        Dim conn As Data.SqlClient.SqlConnection, cmd As Data.SqlClient.SqlCommand
        Dim Rd As Data.SqlClient.SqlDataReader, SQL As String
        Dim Q1_test_no(test_count()) As Integer
        Dim i As Integer
        conn = New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
        conn.Open()
        
        SQL = "SELECT * FROM 試題 WHERE 試卷編號 = '" & Session("test_no") & "'"
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        Rd = cmd.ExecuteReader
        While Rd.Read()
            Q1_test_no(i) = Rd.GetValue(1)
            i = i + 1
        End While
        If test_count() >= Session("test_select_no") Then
            Session("test_select") = Q1_test_no(Session("test_select_no")) '答案選項選擇之編號
            conn.Close()
        
            Dim test_data(test_count()) As String
            Dim k As Integer
            Dim no As Integer = 1
            For j As Integer = 0 To i - 1 Step 1
                conn.Open()
                SQL = "SELECT * FROM 題庫 WHERE 題目編號 = '" & Q1_test_no(j) & "'"
                cmd = New Data.SqlClient.SqlCommand(SQL, conn)
                Rd = cmd.ExecuteReader
                If Rd.Read() Then
                    test_data(k) = Rd.GetString(2)
                    k = k + 1
                    Session("PicPath") = Rd.Item("題目圖檔").ToString.Trim.Remove(0, 1)
                    conn.Close()
                End If
                conn.Close()
            Next
            Return test_data(Session("no"))
        End If
        Return ""
    End Function
    

    Protected Sub Button_select_answer_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Label8.Text = 0 And Label10.Text = 0 Then
            '時間到
            For x As Integer = Session("no") To test_count() Step 1
                Dim conn As Data.SqlClient.SqlConnection, cmd As Data.SqlClient.SqlCommand
                Dim SQL As String
                Dim j As Integer = x + 1 '題號
                conn = New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
                
                conn.Open()
                SQL = "Insert Into 答案卡 (作答答案,學號,題目編號,答案卡編號,題號) Values ('" & 0 & "','" & Session("OK_STU") & "','" & Session("test_select") & "','" & Session("answer_no") & "','" & j & "')"
                cmd = New Data.SqlClient.SqlCommand(SQL, conn)
                cmd.ExecuteNonQuery()
                conn.Close()
            Next
            Me.Button_select_answer.Visible = False
            Me.Button_answer_en.Visible = True
            Me.Button_chang_go.Enabled = False
        Else
            Dim conn As Data.SqlClient.SqlConnection, cmd As Data.SqlClient.SqlCommand
            Dim SQL As String
            Dim i As Integer = Session("no") + 1 '題號
            conn = New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
        
            If test_text() <> "" Then
                Me.Label1.Text = "題目" & i + 1 & ":"
                conn.Open()
                SQL = "Insert Into 答案卡 (作答答案,學號,題目編號,答案卡編號,題號) Values ('" & Me.RadioButtonList1.Text & "','" & Session("OK_STU") & "','" & Session("test_select") & "','" & Session("answer_no") & "','" & i & "')"
                cmd = New Data.SqlClient.SqlCommand(SQL, conn)
                cmd.ExecuteNonQuery()
                conn.Close()
      
                Session("no") = Session("no") + 1
                Session("test_select_no") = Session("test_select_no") + 1
                If test_text() <> "" Then
                    Me.TextBox1.Text = test_text()

                Else
                    Me.TextBox1.Text = "作答結束"
                    Me.Button_select_answer.Visible = False
                    Me.Button_answer_en.Visible = True
                    Me.RadioButtonList1.Visible = False
                    Me.Label1.Visible = False
                End If
            End If
        End If
    End Sub

    Protected Sub Button_answer_en_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim conn As Data.SqlClient.SqlConnection, cmd As Data.SqlClient.SqlCommand
        Dim SQL As String
        conn = New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
        
        Dim tim As String
        tim = Now.Date & " " & Now.Hour & ":" & Now.Minute & ":" & Now.Second
        conn.Open()
        SQL = "UPDATE 應試 SET 終試時間='" & tim & "' where 答案卡編號='" & Session("answer_no") & "'"
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        cmd.ExecuteNonQuery()
        conn.Close()
        
        MultiView1.ActiveViewIndex = 2
        Me.ListView1.DataBind()
    End Sub
       
    Sub chang_answer()
        Session("no") = Me.DropDownList1.SelectedIndex
        Session("test_select_no") = Me.DropDownList1.SelectedIndex
        Me.TextBox1.Text = test_text()
        Me.TextBox1.Visible = True
        Me.RadioButtonList1.Visible = True
        Button_chang_answer.Visible = True
        MultiView1.ActiveViewIndex = 1
    End Sub

    Protected Sub Button_chang_answer_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim conn As Data.SqlClient.SqlConnection, cmd As Data.SqlClient.SqlCommand
        Dim SQL As String
        conn = New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
        
        conn.Open()
        SQL = "UPDATE 答案卡 SET 作答答案='" & Me.RadioButtonList1.Text & "' where 答案卡編號='" & Session("answer_no") & "' and 題目編號='" & Session("test_select") & "'"
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        cmd.ExecuteNonQuery()
        conn.Close()
        Me.ListView1.DataBind()
        Button_chang_answer.Visible = False
        MultiView1.ActiveViewIndex = 2
    End Sub
   
    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        chang_answer()
        Me.Button_chang_answer.Visible = True
        Me.Button_answer_en.Visible = False
    End Sub

    Protected Sub Button2_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
        Label7.Visible = False
        Label8.Visible = False
        Label9.Visible = False
        Label10.Visible = False
        Label11.Visible = False
        Dim conn As Data.SqlClient.SqlConnection, cmd As Data.SqlClient.SqlCommand
        Dim Rd As Data.SqlClient.SqlDataReader, SQL As String
        Dim Q1_test_no(test_count()) As Integer
        Dim i As Integer
        conn = New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
        conn.Open()
        
        SQL = "SELECT * FROM 試題 WHERE 試卷編號 = '" & Session("test_no") & "'"
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        Rd = cmd.ExecuteReader
        While Rd.Read()
            Q1_test_no(i) = Rd.GetValue(1)
            i = i + 1
        End While
        conn.Close()
        
        Dim test_data_true(test_count()) As String
        Dim k As Integer
        Dim no As Integer = 1
        For j As Integer = 0 To i - 1 Step 1
            conn.Open()
            SQL = "SELECT * FROM 題庫 WHERE 題目編號 = '" & Q1_test_no(j) & "'"
            cmd = New Data.SqlClient.SqlCommand(SQL, conn)
            Rd = cmd.ExecuteReader
            If Rd.Read() Then
                test_data_true(k) = Rd.GetValue(6)
                k = k + 1
                conn.Close()
            End If
            conn.Close()
        Next
        
        Dim size As Integer
        conn.Open()
        SQL = "SELECT MAX(題號) FROM 答案卡 WHERE 答案卡編號='" & Session("answer_no") & "'"
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        Rd = cmd.ExecuteReader
        If Rd.Read() Then
            size = Rd.GetValue(0)
            conn.Close()
        End If
        conn.Close()
        
        Dim select_answer(size) As String
        Dim x As Integer
        For y As Integer = 1 To size Step 1
            conn.Open()
            SQL = "SELECT * FROM 答案卡 WHERE 答案卡編號='" & Session("answer_no") & "' AND 題號='" & y & "'"
            cmd = New Data.SqlClient.SqlCommand(SQL, conn)
            Rd = cmd.ExecuteReader
            If Rd.Read() Then
                select_answer(x) = Rd.GetValue(4)
                x = x + 1
                conn.Close()
            End If
            conn.Close()
        Next
        
        Dim answer_true As Integer
        Dim answer_false As Integer
        Dim score As Double
        For z As Integer = 0 To k - 1 Step 1
            If test_data_true(z) = select_answer(z) Then
                answer_true = answer_true + 1
            Else
                answer_false = answer_false + 1
            End If   
        Next
        score = Math.Round((answer_true / (answer_true + answer_false)) * 100, 2)
        
        conn.Open()
        SQL = "UPDATE 應試 SET 測試成績='" & score & "' where 答案卡編號='" & Session("answer_no") & "'"
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        cmd.ExecuteNonQuery()
        conn.Close()
        Me.MultiView1.ActiveViewIndex = 3
    End Sub

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As System.EventArgs)
        If Label10.Text <> "0" And Label8.Text <> 0 Then
            Label10.Text = (Integer.Parse(Label10.Text) - 1).ToString()
        ElseIf Label10.Text = "0" And Label8.Text <> 0 Then
            Label10.Text = "59"
            Label8.Text = (Integer.Parse(Label8.Text) - 1).ToString()
        ElseIf Label8.Text = 0 And Label10.Text <> 0 Then
            Label10.Text = (Integer.Parse(Label10.Text) - 1).ToString()
        Else
            Timer1 .Enabled =False 
        End If
    End Sub

    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("s-test-select.aspx")
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>未命名頁面</title>
    <style type="text/css">
        .style1
        {
            width: 105%;
        }
        .style2
        {
            font-size: large;
            font-family: 標楷體;
            text-align: center;
        }
        .style3
        {
            width: 97px;
        }
        .style4
        {
            width: 422px;
        }
        .style5
        {
            width: 599px;
        }
        .style6
        {
            width: 66px;
        }
        .style7
        {
            width: 102px;
        }
        .style8
        {
            width: 100%;
        }
        .style9
        {
            width: 315px;
        }
        .style10
        {
            width: 386px;
            text-align: left;
            font-weight: bold;
            font-size: x-large;
        }
    </style>
</head>
<body background="未命名%20-7.jpg">
    <form id="form1" runat="server">
    <div>
    
        <table class="style1">
            <tr>
                <td class="style2">
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                        SelectCommand="SELECT 課程編號, 課程名稱 FROM 課程 WHERE (課程編號 = @課程編號)">
                        <SelectParameters>
                            <asp:SessionParameter DefaultValue="" Name="課程編號" SessionField="class_test" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="課程編號" 
                        DataSourceID="SqlDataSource2" 
                        style="font-size: x-large; font-family: 金梅樹枝美工字體; font-weight: 700;">
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
                            課程編號:
                            <asp:TextBox ID="課程編號TextBox" runat="server" Text='<%# Bind("課程編號") %>' />
                            <br />
                            課程名稱:
                            <asp:TextBox ID="課程名稱TextBox" runat="server" Text='<%# Bind("課程名稱") %>' />
                            <br />
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                                CommandName="Insert" Text="插入" />
                            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                                CausesValidation="False" CommandName="Cancel" Text="取消" />
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="課程名稱Label" runat="server" Text='<%# Bind("課程名稱") %>' />
                            考試<br />
                        </ItemTemplate>
                    </asp:FormView>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:ScriptManager ID="ScriptManager1" runat="server">
                            </asp:ScriptManager>
                            <asp:Label ID="Label7" runat="server" Text="剩下:" 
                                style="font-family: 金梅樹枝美工字體; font-weight: 700"></asp:Label>
                            <asp:Label ID="Label8" runat="server" Text="60" 
                                style="font-family: 金梅樹枝美工字體; font-weight: 700"></asp:Label>
                            <asp:Label ID="Label11" runat="server" style="font-weight: 700" Text=":"></asp:Label>
                            <asp:Label ID="Label10" runat="server" Text="0" 
                                style="font-family: 金梅樹枝美工字體; font-weight: 700"></asp:Label>
                            <asp:Label ID="Label9" runat="server" Text="分鐘" 
                                style="font-family: 金梅樹枝美工字體; font-weight: 700"></asp:Label>
                            <asp:Timer ID="Timer1" runat="server" ontick="Timer1_Tick" Interval="1000" 
                                Enabled="False">
                            </asp:Timer>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <br />
                    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                        <asp:View ID="View1" runat="server">
                            <asp:TextBox ID="TextBox2" runat="server" EnableTheming="False" Height="86px" 
                                ReadOnly="True" TextMode="MultiLine" Width="268px" 
                                style="font-family: 標楷體; font-weight: 700; font-size: large" 
                                BackColor="#CCCCFF">考試為60分鍾!!請勿按瀏覽器的上下頁!否則會發生錯誤按&quot;開始測驗&quot;後即將考試!!</asp:TextBox>
                            <br />
                            <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
                                
                                style="margin-bottom: 0px; font-size: large; font-family: 金梅樹枝美工字體; font-weight: 700;" 
                                Text="開始測驗" BackColor="#FF9933" BorderColor="#999999" 
                                BorderStyle="Outset" />
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="Button4" runat="server" onclick="Button4_Click" Text="返回" 
                                BackColor="#FF9933" BorderColor="#999999" 
                                style="font-family: 金梅樹枝美工字體; font-size: large; font-weight: 700" 
                                BorderStyle="Outset" />
                        </asp:View>
                        <asp:View ID="View2" runat="server">
                            <table class="style8">
                                <tr>
                                    <td class="style9">
                                        &nbsp;</td>

                                    <td class="style10">
                                        <asp:Label ID="Label1" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                            </table>
                            <asp:TextBox ID="TextBox1" runat="server" EnableTheming="False" Height="111px" 
                                TextMode="MultiLine" Visible="False" Width="399px" 
                                
                                
                                style="text-align: center; font-family: 金梅樹枝美工字體; font-weight: 700; font-size: x-large;" 
                                BackColor="#CCCCFF" BorderColor="#999999" BorderStyle="Outset"></asp:TextBox>
                            <br />
                            <asp:Image ID="Image1" runat="server" />
                            <br />
                            <table class="style5">
                                <tr>
                                    <td class="style3">
                                        &nbsp;</td>
                                    <td class="style4">
                                        <asp:Label ID="Label2" runat="server" 
                                            style="font-weight: 700; font-family: 金梅樹枝美工字體" Text="選項：" Visible="False"></asp:Label>
                                        <asp:RadioButtonList ID="RadioButtonList1" runat="server" 
                                            DataSourceID="SqlDataSource1" DataTextField="答案選項敘述" DataValueField="答案選項敘述" 
                                            style="text-align: left; font-family: 金梅樹枝美工字體; font-weight: 700;" 
                                            Visible="False">
                                        </asp:RadioButtonList>
                                    </td>
                                    <td class="style6">
                                        &nbsp;</td>
                                </tr>
                            </table>
                            <br />
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                SelectCommand="SELECT 題目編號, 答案選項敘述 FROM 答案 WHERE (題目編號 = @題目編號)">
                                <SelectParameters>
                                    <asp:SessionParameter Name="題目編號" SessionField="test_select" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:Label ID="Label12" runat="server" Text="Label"></asp:Label>
                            <br />
                            <asp:Button ID="Button_select_answer" runat="server" 
                                onclick="Button_select_answer_Click" Text="確定" Visible="False" 
                                
                                style="text-align: left; font-family: 金梅樹枝美工字體; font-size: large; font-weight: 700;" 
                                BackColor="#FF9933" BorderColor="#999999" Height="23px" 
                                BorderStyle="Outset" />
                            <asp:Button ID="Button_answer_en" runat="server" 
                                onclick="Button_answer_en_Click" Text="測驗結束" Visible="False" 
                                BackColor="Yellow" BorderColor="#999999" Height="22px" 
                                style="font-family: 金梅樹枝美工字體; font-size: large; font-weight: 700" 
                                BorderStyle="Outset" />
                            <asp:Button ID="Button_chang_answer" runat="server" 
                                onclick="Button_chang_answer_Click" Text="確定更改" Visible="False" 
                                BackColor="#FF9933" BorderColor="#999999" Height="23px" 
                                style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large" 
                                BorderStyle="Outset" />
                        </asp:View>
                        <asp:View ID="View3" runat="server">
                            <asp:Label ID="Label5" runat="server" Text="題號：" 
                                style="font-family: 金梅樹枝美工字體; font-size: x-large; font-weight: 700"></asp:Label>
                            <asp:DropDownList ID="DropDownList1" runat="server" 
                                DataSourceID="SqlDataSource4" DataTextField="題號" DataValueField="題號" 
                                style="font-size: large; font-family: 金梅樹枝美工字體; font-weight: 700">
                            </asp:DropDownList>
                            <asp:Button ID="Button_chang_go" runat="server" onclick="Button2_Click" 
                                Text="更改答案" BackColor="#FF9933" BorderColor="#999999" Height="23px" 
                                style="font-size: large; font-family: 金梅樹枝美工字體; font-weight: 700" 
                                Width="102px" BorderStyle="Outset" />
                            <br />
                            <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource3" 
                                GroupItemCount="3">
                                <EmptyItemTemplate>
                                    <td runat="server" />
                                    </EmptyItemTemplate>
                                    <ItemTemplate>
                                        <td runat="server" style="background-color:#DCDCDC; color: #000000;">
                                            題號:
                                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("題號") %>'></asp:Label>
                                            <br />
                                            作答答案:
                                            <asp:Label ID="作答答案Label" runat="server" Text='<%# Bind("作答答案") %>' />
                                            <br />
                                        </td>
                                    </ItemTemplate>
                                    <AlternatingItemTemplate>
                                        <td runat="server" style="background-color:#FFF8DC;">
                                            題號:
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("題號") %>'></asp:Label>
                                            <br />
                                            作答答案:
                                            <asp:Label ID="作答答案Label" runat="server" Text='<%# Bind("作答答案") %>' />
                                            <br />
                                        </td>
                                    </AlternatingItemTemplate>
                                    <EmptyDataTemplate>
                                        <table runat="server" 
                                            style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                                            <tr>
                                                <td>
                                                    No data was returned.</td>
                                            </tr>
                                        </table>
                                    </EmptyDataTemplate>
                                    <InsertItemTemplate>
                                        <td runat="server" style="">
                                            題號:
                                            <asp:TextBox ID="題號TextBox" runat="server" Text='<%# Bind("題號") %>' />
                                            <br />
                                            作答答案:
                                            <asp:TextBox ID="作答答案TextBox" runat="server" Text='<%# Bind("作答答案") %>' />
                                            <br />
                                            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                                                Text="Insert" />
                                            <br />
                                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                                                Text="Clear" />
                                            <br />
                                        </td>
                                    </InsertItemTemplate>
                                    <LayoutTemplate>
                                        <table runat="server">
                                            <tr runat="server">
                                                <td runat="server">
                                                    <table ID="groupPlaceholderContainer" runat="server" border="1" 
                                                        style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                                        <tr ID="groupPlaceholder" runat="server">
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr runat="server">
                                                <td runat="server" 
                                                    style="text-align: center;background-color: #CCCCCC;font-family: Verdana, Arial, Helvetica, sans-serif;color: #000000;">
                                                    <asp:DataPager ID="DataPager1" runat="server" PageSize="12">
                                                        <Fields>
                                                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                                                                ShowLastPageButton="True" />
                                                        </Fields>
                                                    </asp:DataPager>
                                                </td>
                                            </tr>
                                        </table>
                                    </LayoutTemplate>
                                    <EditItemTemplate>
                                        <td runat="server" style="background-color:#008A8C;color: #FFFFFF;">
                                            題號:
                                            <asp:TextBox ID="題號TextBox" runat="server" Text='<%# Bind("題號") %>' />
                                            <br />
                                            作答答案:
                                            <asp:TextBox ID="作答答案TextBox" runat="server" Text='<%# Bind("作答答案") %>' />
                                            <br />
                                            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                                                Text="Update" />
                                            <br />
                                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                                                Text="Cancel" />
                                            <br />
                                        </td>
                                    </EditItemTemplate>
                                    <GroupTemplate>
                                        <tr ID="itemPlaceholderContainer" runat="server">
                                            <td ID="itemPlaceholder" runat="server">
                                            </td>
                                        </tr>
                                    </GroupTemplate>
                                    <SelectedItemTemplate>
                                        <td runat="server" 
                                            style="background-color:#008A8C;font-weight: bold;color: #FFFFFF;">
                                            題號:
                                            <asp:Label ID="題號Label" runat="server" Text='<%# Eval("題號") %>' />
                                            <br />
                                            作答答案:
                                            <asp:Label ID="作答答案Label" runat="server" Text='<%# Eval("作答答案") %>' />
                                            <br />
                                        </td>
                                    </SelectedItemTemplate>
                                </asp:ListView>
                                <asp:Button ID="Button2" runat="server" onclick="Button2_Click1" Text="結算成績" 
                                    BackColor="Yellow" BorderColor="#999999" 
                                    style="font-size: large; font-family: 金梅樹枝美工字體; font-weight: 700" 
                                    BorderStyle="Outset" />
                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                    SelectCommand="SELECT 題號, 作答答案 FROM 答案卡 WHERE (答案卡編號 = @答案卡編號)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="答案卡編號" SessionField="answer_no" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                    SelectCommand="SELECT 題號 FROM 答案卡 WHERE (答案卡編號 = @答案卡編號)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="答案卡編號" SessionField="answer_no" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </asp:View>
                            <asp:View ID="View4" runat="server">
                                <br />
                                <asp:Label ID="Label6" runat="server" 
                                    
                                    style="font-size: xx-large; text-align: center; font-family: 金梅黑框浮體字形; font-weight: 700;" 
                                    Text="成績列表"></asp:Label>
                                <br />
                                <br />
                                <asp:FormView ID="FormView2" runat="server" DataSourceID="SqlDataSource5" 
                                    DataKeyNames="學號" HorizontalAlign="Center" BackColor="#DEBA84" 
                                    BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                                    CellSpacing="2" GridLines="Both" 
                                    style="font-size: x-large; font-family: 金梅樹枝美工字體; font-weight: 700; text-align: left">
                                    <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                                    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                                    <EditItemTemplate>
                                        學號:
                                        <asp:Label ID="學號Label1" runat="server" Text='<%# Eval("學號") %>' />
                                        <br />
                                        姓名:
                                        <asp:TextBox ID="姓名TextBox" runat="server" Text='<%# Bind("姓名") %>' />
                                        <br />
                                        班級別:
                                        <asp:TextBox ID="班級別TextBox" runat="server" Text='<%# Bind("班級別") %>' />
                                        <br />
                                        始試時間:
                                        <asp:TextBox ID="始試時間TextBox" runat="server" Text='<%# Bind("始試時間") %>' />
                                        <br />
                                        終試時間:
                                        <asp:TextBox ID="終試時間TextBox" runat="server" Text='<%# Bind("終試時間") %>' />
                                        <br />
                                        測試成績:
                                        <asp:TextBox ID="測試成績TextBox" runat="server" Text='<%# Bind("測試成績") %>' />
                                        <br />
                                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                                            CommandName="Update" Text="更新" />
                                        &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                                            CausesValidation="False" CommandName="Cancel" Text="取消" />
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        學號:
                                        <asp:TextBox ID="學號TextBox" runat="server" Text='<%# Bind("學號") %>' />
                                        <br />
                                        姓名:
                                        <asp:TextBox ID="姓名TextBox" runat="server" Text='<%# Bind("姓名") %>' />
                                        <br />
                                        班級別:
                                        <asp:TextBox ID="班級別TextBox" runat="server" Text='<%# Bind("班級別") %>' />
                                        <br />
                                        始試時間:
                                        <asp:TextBox ID="始試時間TextBox" runat="server" Text='<%# Bind("始試時間") %>' />
                                        <br />
                                        終試時間:
                                        <asp:TextBox ID="終試時間TextBox" runat="server" Text='<%# Bind("終試時間") %>' />
                                        <br />
                                        測試成績:
                                        <asp:TextBox ID="測試成績TextBox" runat="server" Text='<%# Bind("測試成績") %>' />
                                        <br />
                                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                                            CommandName="Insert" Text="插入" />
                                        &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                                            CausesValidation="False" CommandName="Cancel" Text="取消" />
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <table class="style1">
                                            <tr>
                                                <td class="style7">
                                                    學號</td>
                                                <td>
                                                    :<asp:Label ID="學號Label" runat="server" Text='<%# Eval("學號") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style7">
                                                    姓名</td>
                                                <td>
                                                    :<asp:Label ID="姓名Label" runat="server" Text='<%# Bind("姓名") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style7">
                                                    班級別</td>
                                                <td>
                                                    :<asp:Label ID="班級別Label" runat="server" Text='<%# Bind("班級別") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style7">
                                                    始試時間</td>
                                                <td>
                                                    :<asp:Label ID="始試時間Label" runat="server" Text='<%# Bind("始試時間") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style7">
                                                    終試時間</td>
                                                <td>
                                                    :<asp:Label ID="終試時間Label" runat="server" Text='<%# Bind("終試時間") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style7">
                                                    測試成績</td>
                                                <td>
                                                    :<asp:Label ID="測試成績Label" runat="server" Text='<%# Bind("測試成績") %>' 
                                                        style="color: #FF0000" />
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                    <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                                    <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                                </asp:FormView>
                                <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                    
                                    SelectCommand="SELECT 學生.學號, 學生.姓名, 班級.班級別, 應試.始試時間, 應試.終試時間, 應試.測試成績 FROM 班級 INNER JOIN 學生 ON 班級.班級編號 = 學生.班級編號 CROSS JOIN 應試 WHERE (應試.答案卡編號 = @答案卡編號) AND (學生.學號 = @學號)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="答案卡編號" SessionField="answer_no" />
                                        <asp:SessionParameter Name="學號" SessionField="OK_STU" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <br />
                                <asp:Button ID="Button3" runat="server" PostBackUrl="~/st-home.aspx" 
                                    Text="返回學生測驗" BackColor="#FF9933" BorderColor="#999999" 
                                    style="font-family: 金梅樹枝美工字體; font-size: large; font-weight: 700" 
                                    Width="140px" BorderStyle="Outset" />
                            </asp:View>
                        </asp:MultiView>
                </td>
            </tr>
            </table>
    
    </div>
    </form>
</body>
</html>
