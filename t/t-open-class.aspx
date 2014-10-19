<%@ Page Language="VB" MasterPageFile="~/t/t-MasterPage.master" Title="OTS:Online Test System" %>

<script runat="server">

    Protected Sub InsertButton_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub InsertButton_Click1(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">

        .style10
        {
            font-family: 金梅黑框浮體字形;
            font-weight: bold;
            font-size: xx-large;
        }
        .style11
        {
            font-size: x-large;
            font-family: 金梅黑框浮體字形;
            text-align: left;
        }
        .style12
        {
            font-family: 金梅樹枝美工字體;
        }
        .style13
        {
            text-align: center;
        }
        .style14
        {
            font-size: xx-large;
            font-family: 金梅黑框浮體字形;
            text-align: center;
        }
        .style15
        {
            font-size: large;
            font-family: 金梅黑框浮體字形;
            text-align: center;
        }
        .style23
        {
            font-family: 金梅黑框浮體字形;
            text-align: center;
        }
        .style24
        {
            width: 459px;
        }
        .style26
        {
            text-align: left;
            width: 103px;
        }
        .style27
        {
            text-align: left;
        }
        .style28
    {
        font-size: xx-large;
        font-weight: bold;
    }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
        <tr>
            <td colspan="3" style="text-align: center">
                <br />
&nbsp;<span class="style10">開班授課</span><br />
                　</td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:FormView ID="FormView3" runat="server" DataKeyNames="開課編號" 
                    DataSourceID="SqlDataSource3" DefaultMode="Insert" 
                    HorizontalAlign="Center" BackColor="#DEBA84" BorderColor="#DEBA84" 
                    BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" 
                    GridLines="Both">
                    <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                    <EditItemTemplate>
                        開課編號:
                        <asp:Label ID="開課編號Label1" runat="server" Text='<%# Eval("開課編號") %>' />
                        <br />
                        學期別:
                        <asp:TextBox ID="學期別TextBox" runat="server" Text='<%# Bind("學期別") %>' />
                        <br />
                        班級別:
                        <asp:TextBox ID="課程編號TextBox" runat="server" Text='<%# Bind("課程編號") %>' />
                        <br />
                        班級編號:
                        <asp:TextBox ID="班級編號TextBox" runat="server" Text='<%# Bind("班級編號") %>' />
                        <br />
                        課程編號:
                        <asp:TextBox ID="課程名稱TextBox" runat="server" Text='<%# Bind("課程名稱") %>' />
                        <br />
                        課程名稱:
                        <asp:TextBox ID="班級別TextBox" runat="server" Text='<%# Bind("班級別") %>' />
                        <br />
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                            CommandName="Update" Text="更新" />
                        &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                            CausesValidation="False" CommandName="Cancel" Text="取消" />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <div class="style13">
                            <span class="style11"><br />
                            <table class="style24">
                                <tr>
                                    <td class="style13">
                                        <span class="style14">開課<br />
                                        </span>
                                        <table class="style1">
                                            <tr>
                                                <td class="style26">
                                                    <span class="style11"><span class="style12"><b><b style="text-align: left;">開課編號</b></b></span></span></td>
                                                <td class="style27">
                                                    <span class="style11"><span class="style12"><b><b style="text-align: left;">:</b><asp:TextBox 
                                                        ID="開課編號TextBox" runat="server" 
                                                        style="font-size: large; font-family: 金梅樹枝美工字體; font-weight: 700; text-align: left;" 
                                                        Text='<%# Bind("開課編號") %>' />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                                        ControlToValidate="開課編號TextBox" ErrorMessage="RequiredFieldValidator" 
                                                        style="font-size: large; font-weight: 700">請輸入編號!</asp:RequiredFieldValidator>
                                                    </b></span></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style26">
                                                    <span class="style11"><span class="style12"><b>學期別</b></span></span></td>
                                                <td class="style27">
                                                    <span class="style11"><span class="style12"><b>:<asp:TextBox ID="學期別TextBox0" 
                                                        runat="server" 
                                                        style="font-family: 金梅樹枝美工字體; font-size: large; font-weight: 700" 
                                                        Text='<%# Bind("學期別") %>' />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                                        ControlToValidate="學期別TextBox0" Display="Dynamic" 
                                                        ErrorMessage="RequiredFieldValidator" style="font-size: large">請輸入學期別!</asp:RequiredFieldValidator>
                                                    </b></span></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style26">
                                                    <span class="style11"><span class="style12"><b>班級別</b></span></span></td>
                                                <td class="style27">
                                                    <span class="style11"><span class="style12"><b>:<asp:DropDownList 
                                                        ID="DropDownList6" runat="server" DataSourceID="SqlDataSource4" 
                                                        DataTextField="班級別" DataValueField="班級編號" SelectedValue='<%# Bind("班級編號") %>' 
                                                        style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large;">
                                                    </asp:DropDownList>
                                                    </b></span></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style26">
                                                    <span class="style11"><span class="style12"><b><span class="style13">課程名稱</span></b></span></span></td>
                                                <td class="style27">
                                                    <span class="style11"><span class="style12"><b><span class="style23">
                                                    <span class="style13">:<span class="style15"><asp:DropDownList 
                                                        ID="DropDownList7" runat="server" DataSourceID="SqlDataSource5" 
                                                        DataTextField="課程名稱" DataValueField="課程編號" SelectedValue='<%# Bind("課程編號") %>' 
                                                        style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large;">
                                                    </asp:DropDownList>
                                                    </span></span></span></b></span></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style26">
                                                    &nbsp;</td>
                                                <td class="style27">
                                                    <span class="style11"><span class="style12"><b>&nbsp;<asp:LinkButton 
                                                        ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" 
                                                        Text="確定" />
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" 
                                                        CommandName="Cancel" Text="取消" />
                                                    </b></span></span>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            </span>
                        </div>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        開課編號:
                        <asp:Label ID="開課編號Label" runat="server" Text='<%# Eval("開課編號") %>' />
                        <br />
                        學期別:
                        <asp:Label ID="學期別Label" runat="server" Text='<%# Bind("學期別") %>' />
                        <br />
                        班級別:
                        <asp:Label ID="課程編號Label" runat="server" Text='<%# Bind("課程編號") %>' />
                        <br />
                        班級編號:
                        <asp:Label ID="班級編號Label" runat="server" Text='<%# Bind("班級編號") %>' />
                        <br />
                        課程編號:
                        <asp:Label ID="課程名稱Label" runat="server" Text='<%# Bind("課程名稱") %>' />
                        <br />
                        課程名稱:
                        <asp:Label ID="班級別Label" runat="server" Text='<%# Bind("班級別") %>' />
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
                </td>
        </tr>
        <tr>
            <td colspan="3" style="text-align: center">
                <br />
                <span class="style28">已開課程<br />
                </span>
                <asp:GridView ID="GridView3" runat="server" AllowSorting="True" 
                    AutoGenerateColumns="False" DataKeyNames="開課編號" 
                    DataSourceID="SqlDataSource3" AllowPaging="True" HorizontalAlign="Center" 
                    BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" 
                    CellPadding="3" CellSpacing="2" 
                    style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large">
                    <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:BoundField DataField="開課編號" HeaderText="開課編號" ReadOnly="True" 
                            SortExpression="開課編號" />
                        <asp:BoundField DataField="學期別" HeaderText="學期別" SortExpression="學期別" />
                        <asp:TemplateField HeaderText="課程名稱" SortExpression="課程名稱">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList8" runat="server" AutoPostBack="True" 
                                    DataSourceID="SqlDataSource5" DataTextField="課程名稱" DataValueField="課程編號" 
                                    SelectedValue='<%# Bind("課程編號") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("課程名稱") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="班級別" SortExpression="班級別">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList9" runat="server" AutoPostBack="True" 
                                    DataSourceID="SqlDataSource4" DataTextField="班級別" DataValueField="班級編號" 
                                    SelectedValue='<%# Bind("班級編號") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("班級別") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    InsertCommand="INSERT INTO 開課(開課編號, 學期別, 課程編號, 班級編號) VALUES (@開課編號, @學期別, @課程編號, @班級編號)" 
                    
                    
                    SelectCommand="SELECT 開課.開課編號, 開課.學期別, 開課.課程編號, 開課.班級編號, 課程.課程名稱, 班級.班級別 FROM 開課 INNER JOIN 課程 ON 開課.課程編號 = 課程.課程編號 INNER JOIN 班級 ON 開課.班級編號 = 班級.班級編號" 
                    DeleteCommand="DELETE FROM 開課 WHERE (開課編號 = @開課編號)" 
                    
                    UpdateCommand="UPDATE 開課 SET 開課編號 = @開課編號, 學期別 = @學期別, 課程編號 = @課程編號, 班級編號 = @班級編號 WHERE (開課編號 = @開課編號)">
                    <DeleteParameters>
                        <asp:Parameter Name="開課編號" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="開課編號" />
                        <asp:Parameter Name="學期別" />
                        <asp:Parameter Name="課程編號" />
                        <asp:Parameter Name="班級編號" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="開課編號" />
                        <asp:Parameter Name="學期別" />
                        <asp:Parameter Name="課程編號" />
                        <asp:Parameter Name="班級編號" />
                    </InsertParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    SelectCommand="SELECT * FROM [班級]">
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    SelectCommand="SELECT * FROM [課程]"></asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>

