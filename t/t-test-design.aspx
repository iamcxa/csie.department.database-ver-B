<%@ Page Language="VB" MasterPageFile="~/t/t-MasterPage.master" Title="OTS:Online Test System" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim x As Integer
        For index_count As Integer = 0 To ListBox1.Items.Count - 1
            If ListBox1.Items(index_count).Selected Then
                x = x + 1
            End If
        Next
        
        Dim Q1(x - 1) As Integer
        Dim no As String = ""
        Dim y As Integer
        For index As Integer = 0 To ListBox1.Items.Count - 1
            If ListBox1.Items(index).Selected Then
                Q1(y) = ListBox1.Items(index).Value
                y = y + 1
                no += "第" & ListBox1.Items(index).Text & "章"
            End If
        Next
        
        Dim conn As Data.SqlClient.SqlConnection, cmd As Data.SqlClient.SqlCommand
        Dim Rd As Data.SqlClient.SqlDataReader, SQL As String
        Dim num As Integer
        Dim max As Integer
        
        conn = New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
        For m As Integer = 0 To x - 1 Step 1
            conn.Open()
            SQL = "Select * From 題庫 Where 課程編號 = '" & Me.DropDownList1.SelectedValue & "' and 所屬章節='" & Q1(m) & "'"
            cmd = New Data.SqlClient.SqlCommand(SQL, conn)
            Rd = cmd.ExecuteReader()
        
            While Rd.Read()
                num = num + 1
            End While
            conn.Close()
        Next
        max = num - 1
        
        Dim quantum(max) As Integer
        Dim quantum2(max) As Integer
        Dim i As Integer
        For n As Integer = 0 To x - 1 Step 1
            conn.Open()
            SQL = "Select * From 題庫 Where 課程編號 = '" & Me.DropDownList1.SelectedValue & "' and 所屬章節='" & Q1(n) & "'"
            cmd = New Data.SqlClient.SqlCommand(SQL, conn)
            Rd = cmd.ExecuteReader()
            While Rd.Read()
                quantum(i) = Rd.GetValue(0)
                i = i + 1
            End While
            conn.Close()
        Next
        
        conn.Open()
        SQL = "Insert Into 試卷 (課程編號,命題數量,試卷別) Values ('" & Me.DropDownList1.SelectedValue & "','" & Me.TextBox2.Text & "','" & Me.DropDownList2.SelectedValue & "')"
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        cmd.ExecuteNonQuery()
        conn.Close()
        
        conn.Open()
        cmd.CommandText = "Insert Into 命題範圍 (試卷編號,所屬章節) Values ('" & value() & "','" & no & "')"
        cmd.Connection = conn
        cmd.ExecuteNonQuery()
        conn.Close()
                        
        Dim generator As New Random
        Dim randomValue As Integer
        Dim miss_null As Integer
        Dim miss As Integer
        Dim j As Integer
        For hit As Integer = 1 To Me.TextBox2.Text Step 1
            randomValue = generator.Next(0, max)
            If quantum2(randomValue) = 0 Then
                quantum2(randomValue) = quantum(randomValue)
                conn.Open()
                cmd.CommandText = "Insert Into 試題 (題目編號,試卷編號) Values ('" & quantum2(randomValue) & "','" & value() & "')"
                cmd.Connection = conn
                cmd.ExecuteNonQuery()
                conn.Close()
               
            ElseIf quantum2(max) = 0 Then
                quantum2(max) = quantum(max)
                conn.Open()
                cmd.CommandText = "Insert Into 試題 (題目編號,試卷編號) Values ('" & quantum2(max) & "','" & value() & "')"
                cmd.Connection = conn
                cmd.ExecuteNonQuery()
                conn.Close()
                max = max - 1
            Else
                max = max - 1
                miss = miss + 1
            End If
        Next
        For miss_null = 0 To Me.TextBox2.Text - 1 Step 1
            If quantum2(miss_null) = 0 Then
                quantum2(miss_null) = quantum(miss_null)
                If j < miss Then
                    conn.Open()
                    cmd.CommandText = "Insert Into 試題 (題目編號,試卷編號) Values ('" & quantum2(miss_null) & "','" & value() & "')"
                    cmd.Connection = conn
                    cmd.ExecuteNonQuery()
                    conn.Close()
                    j = j + 1
                End If
            End If
        Next
        Me.GridView1.DataBind()
    End Sub
    
    Function value() As Integer
        Dim conn As Data.SqlClient.SqlConnection, cmd As Data.SqlClient.SqlCommand
        Dim Rd As Data.SqlClient.SqlDataReader, SQL As String
        Dim max_id As Integer
        conn = New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
        conn.Open()
        SQL = "Select MAX(試卷編號) FROM 試卷"
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        Rd = cmd.ExecuteReader()
        If Rd.Read() Then
            max_id = Rd.GetValue(0)
            Return max_id
        End If
        conn.Close()
    End Function

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("test_select_class_no") = Me.DropDownList1.SelectedValue
        RequiredFieldValidator2.Enabled = True
        Label3.Visible = True
        Label4.Visible = True
        TextBox2.Visible = True
        Button1.Visible = True
        ListBox1.Visible = True
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
                                        <asp:Label ID="Label_notice" runat="server" Font-Bold="True" ForeColor="Red" Font-Size="XX-Large">試卷編輯</asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <div id="Div_UpdateProgress" style="width: 100%; height: 20px; margin-right: auto;
                                position: static;">
                                <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0">
                                    <ProgressTemplate>
                                        <div style="text-align: center;">
                                            <img alt="loading" src="images/ajax-loader.gif" /></div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </div>
                            <div id="MutiView">
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                        <asp:MultiView ID="MultiView_Notice" runat="server">
                                        </asp:MultiView>

                                <asp:MultiView ID="MultiView_Main" runat="server" ActiveViewIndex="0">
                                 
                                    <asp:View ID="View_ADDNotice" runat="server">
                                            <table class="style1">
        <tr>
            <td style="text-align: center">
            
                <br />
      
                <br />
                    試卷別：<span class="style9"><asp:DropDownList ID="DropDownList2" runat="server" 
                        style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large">
                        <asp:ListItem Value="期中測驗">期中測驗</asp:ListItem>
                        <asp:ListItem Value="期末測驗">期末測驗</asp:ListItem>
                        <asp:ListItem Value="平時測驗">平時測驗</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="DropDownList2" ErrorMessage="RequiredFieldValidator" 
                        style="font-size: large" Display="Dynamic">尚未輸入試卷別!</asp:RequiredFieldValidator>
          
          
                  
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 選擇課程：</span><span class="style9"><span class="style10"><asp:DropDownList 
                    ID="DropDownList1" runat="server" 
                    DataSourceID="SqlDataSource1" DataTextField="課程名稱" DataValueField="課程編號" 
                        style="font-size: large; font-weight: 700">
                </asp:DropDownList>
                　  
                    <asp:Button ID="Button2" runat="server" onclick="Button2_Click" Text="選定試卷與課程" 
                        BackColor="#6699FF" BorderColor="#999999" Height="22px" 
                        style="font-size: large; font-weight: 700" 
                        BorderStyle="Outset" Width="174px" />
                    <br />
                    <br />
                    &nbsp;&nbsp;&nbsp;<asp:Label ID="Label4" runat="server" Text="命題數量：" Visible="False"></asp:Label>
                    <asp:TextBox ID="TextBox2" 
                    runat="server" Width="148px" Visible="False"></asp:TextBox>
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="TextBox2" Display="Dynamic" Enabled="False" 
                        ErrorMessage="RequiredFieldValidator">尚未輸入數量!</asp:RequiredFieldValidator>
               
                <p>
                    <span class="style8"><b><span class="style9"><span class="style10">
                    <table class="style1">
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td>
                                <span class="style8"><b><span class="style9"><span class="style10">
                                <asp:Label ID="Label3" runat="server" Text="所屬章節：" Visible="False"></asp:Label>
                                <br />
                                <asp:ListBox ID="ListBox1" runat="server" DataSourceID="SqlDataSource3" 
                                    DataTextField="所屬章節" DataValueField="所屬章節" SelectionMode="Multiple" 
                                    Visible="False" style="font-weight: 700"></asp:ListBox>
                                <br />
                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                        SelectCommand="SELECT DISTINCT 題庫.所屬章節, 課程.課程編號 FROM 題庫 INNER JOIN 課程 ON 題庫.課程編號 = 課程.課程編號 WHERE (課程.課程編號 = @課程編號)">
                        <SelectParameters>
                            <asp:SessionParameter Name="課程編號" SessionField="test_select_class_no" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
                    style="font-size: medium; font-weight: 700;" 
                    Text="隨機出題" BackColor="#6699FF" BorderColor="#999999" Visible="False" 
                                    BorderStyle="Outset" />
                </span></span></b></span>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                    </table>
                </span></span></b></span>
                </p>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label2" runat="server" 
                    style="text-align: center; font-family: 金梅樹枝美工字體; font-weight: 700"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="text-align: center">
                <br />
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                    AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="試卷編號" 
                    DataSourceID="SqlDataSource2" HorizontalAlign="Center" BackColor="#DEBA84" 
                    BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                    CellSpacing="2" 
                    style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large">
                    <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                    <Columns>
                        <asp:BoundField DataField="試卷編號" HeaderText="試卷編號" ReadOnly="True" 
                            SortExpression="試卷編號" />
                        <asp:TemplateField HeaderText="試卷別" SortExpression="試卷別">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("試卷別") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("試卷別") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="命題數量" HeaderText="命題數量" SortExpression="命題數量" />
                        <asp:BoundField DataField="課程名稱" HeaderText="課程名稱" SortExpression="課程名稱" />
                        <asp:BoundField DataField="所屬章節" HeaderText="所屬章節" SortExpression="所屬章節" 
                            FooterText="章" />
                    </Columns>
                    <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    SelectCommand="SELECT 試卷.試卷編號, 試卷.試卷別, 試卷.命題數量, 課程.課程名稱, 命題範圍.所屬章節 FROM 試卷 INNER JOIN 課程 ON 試卷.課程編號 = 課程.課程編號 INNER JOIN 命題範圍 ON 試卷.試卷編號 = 命題範圍.試卷編號">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    SelectCommand="SELECT * FROM [課程]">
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
                                    
                                    </asp:View>
                                </asp:MultiView>                                    </ContentTemplate>
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
    








</asp:Content>

