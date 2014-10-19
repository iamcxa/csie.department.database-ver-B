<%@ Page Language="VB" MasterPageFile="~/t/t-MasterPage.master" Title="OTS:Online Test System" %>

<%@ Import Namespace="System.Data" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Drawing" %>

<script runat="server">

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("OK_CLASS") = DropDownList1.Text
        GridView2.Visible = True
    End Sub

    Protected Sub Button5_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim conn As Data.SqlClient.SqlConnection, cmd As Data.SqlClient.SqlCommand
        Dim SQL As String, RD As Data.SqlClient.SqlDataReader
        conn = New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
        
        Dim check As Boolean
        conn.Open()
        SQL = "SELECT * FROM 試題 WHERE 題目編號='" & Me.TextBox4.Text & "'"
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        RD = cmd.ExecuteReader
        If RD.Read() Then
            check = True
            conn.Close()
        Else
            check = False
            conn.Close()
        End If
        
        If check = False Then
            conn.Open()
            SQL = "DELETE FROM 答案 WHERE " & "題目編號='" & Me.TextBox4.Text & "'"
            cmd = New Data.SqlClient.SqlCommand(SQL, conn)
            cmd.ExecuteNonQuery()
            SQL = "DELETE FROM 題庫 WHERE " & "題目編號='" & Me.TextBox4.Text & "'"
            cmd = New Data.SqlClient.SqlCommand(SQL, conn)
            cmd.ExecuteNonQuery()
            conn.Close()
            Me.GridView2.DataBind()
        Else
            Me.Label8 .Text ="題目已建入試卷，無法刪除題目"
        End If
    End Sub

   


    Protected Sub Button7_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("OK_CLASS") = DropDownList1.Text
        GridView2.Visible = True
        Me.Button8.Enabled = True
        Me.GridView2.Visible = False
    End Sub



    Protected Sub DropDownList2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub Button9_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub Button8_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("OK_CLASS") = DropDownList1.Text
        Session("chapetr_select") = DropDownList2.Text
        Me.Button8.Enabled = False
        Me.GridView2.Visible = True
        
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
        .style12
        {
            font-size: x-large;
            text-align: center;
        }
       
        .style14
        {
            text-align: center;
                     font-weight: bold;
            color: #FF0000;
            font-size: x-large;
        }
        .style15
        {
                     font-size: x-large;
        }
        .style16
        {
            font-size: xx-large;
            text-align: center;
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
                                        <asp:Label ID="Label_notice" runat="server" Font-Bold="True" ForeColor="Red" Font-Size="XX-Large">刪除題目</asp:Label>
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
            <td>
                <br />
                <span class="style13">
                <span class="style12"><b>&nbsp;&nbsp;&nbsp;&nbsp; 
                </span>
                <span class="style16"></span><span class="style12"><br />
                <br />
                課程：<asp:DropDownList ID="DropDownList1" runat="server" 
                    DataSourceID="SqlDataSource2" DataTextField="課程名稱" DataValueField="課程編號" 
                    style="font-size: large; font-weight: 700;">
                </asp:DropDownList>
                &nbsp;&nbsp;
                <asp:Button ID="Button7" runat="server" BackColor="#6699FF" BorderColor="#999999" 
                    
                    
                    style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large; height: 28px;" Text="選擇" 
                    Width="51px" onclick="Button7_Click" BorderStyle="Outset" Height="25px" />
                        &nbsp;<asp:Label ID="Label10" runat="server" Text="章節："></asp:Label>
                <asp:DropDownList ID="DropDownList2" runat="server" 
                    DataSourceID="SqlDataSource4" DataTextField="所屬章節" DataValueField="所屬章節">
                </asp:DropDownList>
&nbsp;<asp:Button ID="Button8" runat="server" onclick="Button8_Click" Text="確定" 
                    Enabled="False" BackColor="#6699FF" BorderColor="#6699FF" />
                        &nbsp; 
                </span> </b>
                </span><asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    SelectCommand="SELECT * FROM [課程]">
                </asp:SqlDataSource>
                <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Size="Large" 
                    Text="題目編號："></asp:Label>
                <span class="style13"><span 
                            class="style12">
                <asp:TextBox 
                            ID="TextBox4" runat="server"></asp:TextBox>
                        </span></b></span>&nbsp;<span class="style13"><span 
                            class="style12"><b><asp:Button 
                            ID="Button5" runat="server" BackColor="#6699FF" BorderColor="#999999" 
                            onclick="Button5_Click" 
                            style="height: 21px; font-family: 金梅樹枝美工字體; font-size: large; font-weight: 700;" 
                            Text="刪除" BorderStyle="Outset" Height="28px" Width="54px" />
                        </b></span></span><b>
                        <br class="style15" />
                        </b>
                &nbsp;<asp:Label ID="Label8" runat="server" ForeColor="Red" 
                            style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large"></asp:Label>
                        <asp:GridView ID="GridView2" runat="server" AllowPaging="True" 
                            AllowSorting="True" AutoGenerateColumns="False" BackColor="#DEBA84" 
                            BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                            CellSpacing="2" DataKeyNames="題目編號" DataSourceID="SqlDataSource3" 
                            style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large" 
                    Visible="False">
                            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                            <Columns>
                                <asp:BoundField DataField="題目編號" HeaderText="題目編號" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="題目編號" />
                                <asp:BoundField DataField="題目敘述" HeaderText="題目敘述" SortExpression="題目敘述" />
                                <asp:BoundField DataField="題型" HeaderText="題型" SortExpression="題型" />
                                <asp:BoundField DataField="正確解答選項" HeaderText="正確解答選項" 
                                    SortExpression="正確解答選項" />
                                <asp:BoundField DataField="所屬章節" HeaderText="所屬章節" SortExpression="所屬章節" />
                                <asp:BoundField DataField="課程名稱" HeaderText="課程名稱" SortExpression="課程名稱" />
                            </Columns>
                            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
            </td>
        </tr>
        <tr>
            <td class="style14">
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    DeleteCommand="DELETE FROM [題庫] WHERE [題目編號] = @題目編號" 
                    InsertCommand="INSERT INTO 題庫(課程編號, 題目敘述, 題型, 正確解答選項, 所屬章節) VALUES (@課程編號, @題目敘述, @題型, @正確解答選項, @所屬章節)" 
                    SelectCommand="SELECT 題庫.題目編號, 題庫.課程編號, 題庫.題目敘述, 題庫.題型, 題庫.正確解答選項, 題庫.所屬章節, 課程.課程名稱 FROM 題庫 INNER JOIN 課程 ON 題庫.課程編號 = 課程.課程編號 WHERE (題庫.課程編號 = @課程編號) AND (題庫.所屬章節 = @所屬章節)" 
                    
                    
                    
                    UpdateCommand="UPDATE 題庫 SET 課程編號 = @課程編號, 題目敘述 = @題目敘述, 題型 = @題型, 正確解答選項 = @正確解答選項, 所屬章節 = @所屬章節 WHERE (題目編號 = @題目編號)">
                    <SelectParameters>
                        <asp:SessionParameter Name="課程編號" SessionField="OK_CLASS" />
                        <asp:SessionParameter Name="所屬章節" SessionField="chapetr_select" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="題目編號" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="課程編號" Type="Byte" />
                        <asp:Parameter Name="題目敘述" Type="String" />
                        <asp:Parameter Name="題型" Type="Byte" />
                        <asp:Parameter Name="正確解答選項" Type="String" />
                        <asp:Parameter Name="所屬章節" Type="Byte" />
                        <asp:Parameter Name="題目編號" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="課程編號" Type="Byte" />
                        <asp:Parameter Name="題目敘述" Type="String" />
                        <asp:Parameter Name="題型" Type="Byte" />
                        <asp:Parameter Name="正確解答選項" Type="String" />
                        <asp:Parameter Name="所屬章節" Type="Byte" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    SelectCommand="SELECT DISTINCT 題庫.所屬章節, 課程.課程編號 FROM 題庫 INNER JOIN 課程 ON 題庫.課程編號 = 課程.課程編號 WHERE (課程.課程編號 = @課程編號)">
                    <SelectParameters>
                        <asp:SessionParameter Name="課程編號" SessionField="OK_CLASS" />
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
    

    <br />
    </asp:Content>

