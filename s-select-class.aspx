<%@ Page Language="VB" MasterPageFile="~/St1-MasterPage.master" Title="未命名頁面" %>

<%@ Import Namespace="System.Data" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">
   

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim classname As String = ""
        Dim classvaule As String = ""
        For index As Integer = 0 To RadioButtonList1.Items.Count - 1
            If RadioButtonList1.Items(index).Selected Then
                classname += RadioButtonList1.Items(index).Text
                classvaule += RadioButtonList1.Items(index).Value
            End If
        Next
        If Label6.Text = "" Then
            Label6.Text = classname
            Label9.Text = classvaule
            Me.Button2.Visible = True
            Me.LinkButton6.Visible = True
        ElseIf Label7.Text = "" Then
            Label7.Text = classname
            Label10.Text = classvaule
            Me.Button2.Visible = True
            Me.LinkButton7.Visible = True
        Else : Label8.Text = classname
            Label11.Text = classvaule
            Me.Button2.Visible = True
            Me.LinkButton8.Visible = True
        End If
        MultiView1.ActiveViewIndex = 1
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim cn As New SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
        Dim cmd As New SqlCommand

        cn.Open()
        
        If Label6.Text <> "" Then
            cmd.CommandText = "Insert Into 修課 (學號,修課編號) Values ('" & CType(FormView2.Row.Cells(0).FindControl("學號Label"), Label).Text & "','" & Label9.Text & "')"
            cmd.Connection = cn
            cmd.ExecuteNonQuery()
        End If
        If Label7.Text <> "" Then
            cmd.CommandText = "Insert Into 修課 (學號,修課編號) Values ('" & CType(FormView2.Row.Cells(0).FindControl("學號Label"), Label).Text & "','" & Label10.Text & "')"
            cmd.Connection = cn
            cmd.ExecuteNonQuery()
        End If
        If Label8.Text <> "" Then
            cmd.CommandText = "Insert Into 修課 (學號,修課編號) Values ('" & CType(FormView2.Row.Cells(0).FindControl("學號Label"), Label).Text & "','" & Label11.Text & "')"
            cmd.Connection = cn
            cmd.ExecuteNonQuery()
        End If
            

        cmd.Dispose()

        If cn.State = ConnectionState.Open Then
            cn.Close()
        End If
        Me.GridView1.DataBind()
        Me.Label9.Text = ""
        Me.Label8.Text = ""
        Me.Label7.Text = ""
        Me.Label6.Text = ""
        Me.Label11.Text = ""
        Me.Label10.Text = ""
        Me.LinkButton6.Visible = False
        Me.LinkButton7.Visible = False
        Me.LinkButton8.Visible = False
        Me.MultiView1.ActiveViewIndex = 0
    End Sub

    Protected Sub LinkButton6_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.Label6.Text = ""
        Me.Label9.Text = ""
        Me.LinkButton6.Visible = False
        If Me.Label6.Text <> "" Or Me.Label7.Text <> "" Or Me.Label8.Text <> "" Then
            Me.Button2.Visible = True
        Else
            Me.Button2.Visible = False
        End If
    End Sub

    Protected Sub LinkButton7_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.Label7.Text = ""
        Me.Label10.Text = ""
        Me.LinkButton7.Visible = False
        If Me.Label6.Text <> "" Or Me.Label7.Text <> "" Or Me.Label8.Text <> "" Then
            Me.Button2.Visible = True
        Else
            Me.Button2.Visible = False
        End If
    End Sub

    Protected Sub LinkButton8_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.Label8.Text = ""
        Me.Label11.Text = ""
        Me.LinkButton8.Visible = False
        If Me.Label6.Text <> "" Or Me.Label7.Text <> "" Or Me.Label8.Text <> "" Then
            Me.Button2.Visible = True
        Else
            Me.Button2.Visible = False
        End If
    End Sub
    
    
    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        MultiView1.ActiveViewIndex = 0
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style5
        {
            font-size: x-large;
            font-family: 標楷體;
        text-align: center;
    }
        .style19
    {
        font-size: xx-large;
        text-align: center;
    }
    .style20
    {
        font-size: x-large;
        font-family: 金梅樹枝美工字體;
        text-align: center;
        font-weight: bold;
    }
    .style21
    {
        font-family: 金梅樹枝美工字體;
    }
        .style22
        {
            font-size: x-large;
        }
        .style24
        {
            font-size: x-large;
            font-weight: bold;
        }
    .style25
    {
        font-family: 金梅黑框浮體字形;
            font-weight: bold;
        }
        .style26
        {
            width: 897px;
        }
        .style27
        {
            width: 84px;
        }
        .style28
        {
            width: 714px;
        }
        .style29
        {
            width: 85px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p class="style5">
        <table class="style1" style="width: 100%">
            <tr>
                <td style="text-align: center">
                    <span class="style19">
                    <br />
                    <span class="style25">選課作業</span><br />
                    </span><asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    SelectCommand="SELECT 學生.學號, 學生.姓名, 學生.班級編號, 班級.班級別 FROM 學生 INNER JOIN 班級 ON 學生.班級編號 = 班級.班級編號 WHERE (學生.學號 = @學號)">
                    <SelectParameters>
                        <asp:SessionParameter Name="學號" SessionField="OK_STU" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:FormView ID="FormView2" runat="server" DataKeyNames="學號" 
                    DataSourceID="SqlDataSource4" 
                        
                        style="text-align: center; font-family: 金梅樹枝美工字體; font-size: x-large; font-weight: 700;" 
                        Width="358px">
                    <EditItemTemplate>
                        學號:
                        <asp:Label ID="學號Label1" runat="server" Text='<%# Eval("學號") %>' />
                        <br />
                        姓名:
                        <asp:TextBox ID="姓名TextBox" runat="server" Text='<%# Bind("姓名") %>' />
                        <br />
                        班級編號:
                        <asp:TextBox ID="班級編號TextBox" runat="server" Text='<%# Bind("班級編號") %>' />
                        <br />
                        班級別:
                        <asp:TextBox ID="班級別TextBox" runat="server" Text='<%# Bind("班級別") %>' />
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
                        班級編號:
                        <asp:TextBox ID="班級編號TextBox" runat="server" Text='<%# Bind("班級編號") %>' />
                        <br />
                        班級別:
                        <asp:TextBox ID="班級別TextBox" runat="server" Text='<%# Bind("班級別") %>' />
                        <br />
                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                            CommandName="Insert" Text="插入" />
                        &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                            CausesValidation="False" CommandName="Cancel" Text="取消" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        學號:
                        <asp:Label ID="學號Label" runat="server" Text='<%# Eval("學號") %>' />
                        　<br />
                        姓名:
                        <asp:Label ID="姓名Label0" runat="server" Text='<%# Bind("姓名") %>' />
                        　<br />
                        班級別:
                        <asp:Label ID="班級別Label0" runat="server" Text='<%# Bind("班級別") %>' />
                        <br />
                    </ItemTemplate>
                </asp:FormView>
                    <span class="style21">
                <span class="style20">&nbsp;</span><asp:MultiView ID="MultiView1" runat="server" 
                        ActiveViewIndex="0">
                        <asp:View ID="View1" runat="server">
                            <span class="style21"><span class="style20">
                            <br />
                            選取課程<span class="style21"><asp:RadioButtonList 
                                ID="RadioButtonList1" runat="server" DataSourceID="SqlDataSource2" 
                                DataTextField="課程名稱" DataValueField="開課編號" style="font-family: 金梅樹枝美工字體">
                            </asp:RadioButtonList>
                            <span class="style21">
                            <asp:Button ID="Button1" runat="server" BackColor="#FF9933" BorderColor="#999999" 
                                Height="32px" onclick="Button1_Click" 
                                style="font-size: x-large; font-family: 金梅樹枝美工字體; font-weight: 700" Text="確定" 
                                Width="78px" BorderStyle="Outset" />
                            <span class="style21"><span class="style21"><span class="style21">
                            <span class="style21"><span class="style21"><span class="style21">
                            <span class="style21"><span class="style21"><span class="style21">
                            <span class="style21"><span class="style21">
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                SelectCommand="SELECT 開課.開課編號, 開課.學期別, 開課.課程編號, 開課.班級編號, 班級.班級別, 課程.課程名稱, 學生.學號 FROM 開課 INNER JOIN 課程 ON 開課.課程編號 = 課程.課程編號 INNER JOIN 班級 ON 開課.班級編號 = 班級.班級編號 INNER JOIN 學生 ON 班級.班級編號 = 學生.班級編號 WHERE (學生.學號 = @學號)">
                                <SelectParameters>
                                    <asp:SessionParameter Name="學號" SessionField="OK_STU" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <span class="style24"><span class="style22"><b>
                            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                                AutoGenerateColumns="False" BackColor="#DEBA84" BorderColor="#DEBA84" 
                                BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" 
                                DataSourceID="SqlDataSource3" style="font-size: large; font-weight: 700;" 
                                Width="342px">
                                <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                                <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                                <Columns>
                                    <asp:BoundField DataField="學號" HeaderText="學號" SortExpression="學號" />
                                    <asp:BoundField DataField="修課編號" HeaderText="修課編號" SortExpression="修課編號" />
                                    <asp:BoundField DataField="課程名稱" HeaderText="課程名稱" SortExpression="課程名稱" />
                                </Columns>
                                <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                                SelectCommand="SELECT 修課.學號, 修課.修課編號, 開課.開課編號, 開課.課程編號, 課程.課程名稱 FROM 課程 INNER JOIN 開課 ON 課程.課程編號 = 開課.課程編號 INNER JOIN 修課 ON 開課.開課編號 = 修課.修課編號 WHERE (修課.學號 = @學號)">
                                <SelectParameters>
                                    <asp:SessionParameter Name="學號" SessionField="OK_STU" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            </b></span></span>
                            </span></span></span></span></span></span></span></span></span></span></span>
                            </span></span></span></span>
                        </asp:View>
                        <asp:View ID="View2" runat="server">
                            <table class="style26">
                                <tr>
                                    <td class="style27">
                                        &nbsp;</td>
                                    <td class="style28">
                                        <span class="style21"><span class="style21"><span class="style24">已選課程：<span 
                                            class="style21"><span class="style21"><span class="style21"><span 
                                            class="style22"><b><br />
                                        <asp:Label ID="Label9" runat="server"></asp:Label>
                                        <span class="style21"><span class="style21"><span class="style21">
                                        <span class="style22"><b>
                                        <asp:Label ID="Label6" runat="server"></asp:Label>
                                        <span class="style21"><span class="style21"><span class="style21">
                                        <span class="style22"><b>
                                        <asp:LinkButton ID="LinkButton6" runat="server" onclick="LinkButton6_Click" 
                                            Visible="False">取消</asp:LinkButton>
                                        <br />
                                        <span class="style21"><span class="style21"><span class="style21">
                                        <span class="style22"><b>
                                        <asp:Label ID="Label10" runat="server"></asp:Label>
                                        <span class="style21"><span class="style21"><span class="style21">
                                        <span class="style22"><b>
                                        <asp:Label ID="Label7" runat="server"></asp:Label>
                                        <span class="style21"><span class="style21"><span class="style21">
                                        <span class="style22"><b>
                                        <asp:LinkButton ID="LinkButton7" runat="server" onclick="LinkButton7_Click" 
                                            Visible="False">取消</asp:LinkButton>
                                        <br />
                                        <span class="style21"><span class="style21"><span class="style21">
                                        <span class="style22"><b>
                                        <asp:Label ID="Label11" runat="server"></asp:Label>
                                        <span class="style21"><span class="style21"><span class="style21">
                                        <span class="style22"><b>
                                        <asp:Label ID="Label8" runat="server"></asp:Label>
                                        <span class="style21"><span class="style21"><span class="style21">
                                        <span class="style22"><b>
                                        <asp:LinkButton ID="LinkButton8" runat="server" onclick="LinkButton8_Click" 
                                            Visible="False">取消</asp:LinkButton>
                                        <br />
                                        <span class="style21"><span class="style21"><span class="style21">
                                        <span class="style22"><b>請勿重複加選課程!<br />
                                        <span class="style21"><span class="style21"><span class="style21">
                                        <span class="style22"><b>
                                        <asp:Button ID="Button2" runat="server" BackColor="#FF9933" BorderColor="#999999" 
                                            Height="29px" onclick="Button2_Click" 
                                            style="font-size: x-large; font-family: 金梅樹枝美工字體; font-weight: 700" Text="加選" 
                                            Visible="False" BorderStyle="Outset" />
                                        <span class="style21"><span class="style21"><span class="style21">
                                        <span class="style22"><b>&nbsp;&nbsp;&nbsp;
                                        <asp:Button ID="Button3" runat="server" BackColor="#FF9933" BorderColor="#999999" 
                                            Height="29px" onclick="Button3_Click" 
                                            style="font-size: x-large; font-family: 金梅樹枝美工字體; font-weight: 700" 
                                            Text="取消" BorderStyle="Outset" />
                                        <br />
                                        <br />
                                        </b>
                                        </span></span></span></span></b></span>
                                        </span></span></span></b></span></span></span></span></b></span></span></span>
                                        </span></b></span></span></span></span></b></span></span></span></span></b>
                                        </span></span></span></span></b></span></span></span></span></b></span></span>
                                        </span></span></b></span></span></span></span></b></span></span></span></span>
                                        </b></span></span></span></span></span></span></span>
                                    </td>
                                    <td class="style29">
                                        &nbsp;</td>
                                </tr>
                            </table>
                        </asp:View>
                    </asp:MultiView>
                    <br />
                <br />
                <br />
                    </span>
                    <br />
                </td>
            </tr>
        </table>
</p>
<p class="style5">
        &nbsp;</p>
    </asp:Content>

