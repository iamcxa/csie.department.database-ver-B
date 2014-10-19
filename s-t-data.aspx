<%@ Page Language="VB" MasterPageFile="~/St1-MasterPage.master" Title="未命名頁面" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
    .style5
    {
        font-family: 標楷體;
    }
    .style6
    {
        font-family: 標楷體;
        font-size: large;
    }
        .style7
        {
            font-family: 金梅樹枝美工字體;
        }
        .style9
        {
            width: 152px;
        }
        .style11
        {
            text-align: center;
            font-size: xx-large;
            font-weight: bold;
            font-family: 金梅黑框浮體字形;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1" style="width: 102%">
    <tr>
        <td>
            <div class="style11">
                <br />
                教師簡介<br />
                <br />
            </div>
            <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" 
                HorizontalAlign="Center" BackColor="#DEBA84" BorderColor="#DEBA84" 
                BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" 
                Font-Names="金梅黑框浮體字形" Font-Size="X-Large" GridLines="Both" 
                style="font-size: x-large; font-family: 金梅樹枝美工字體">
                <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                <EditItemTemplate>
                    姓名:
                    <asp:TextBox ID="姓名TextBox" runat="server" Text='<%# Bind("姓名") %>' />
                    <br />
                    郵件地址:
                    <asp:TextBox ID="郵件地址TextBox" runat="server" Text='<%# Bind("郵件地址") %>' />
                    <br />
                    系別:
                    <asp:TextBox ID="系別TextBox" runat="server" Text='<%# Bind("系別") %>' />
                    <br />
                    職稱:
                    <asp:TextBox ID="職稱TextBox" runat="server" Text='<%# Bind("職稱") %>' />
                    <br />
                    辦公電話號碼:
                    <asp:TextBox ID="辦公電話號碼TextBox" runat="server" Text='<%# Bind("辦公電話號碼") %>' />
                    <br />
                    行動電話號碼:
                    <asp:TextBox ID="行動電話號碼TextBox" runat="server" Text='<%# Bind("行動電話號碼") %>' />
                    <br />
                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                        CommandName="Update" Text="更新" />
                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                        CausesValidation="False" CommandName="Cancel" Text="取消" />
                </EditItemTemplate>
                <InsertItemTemplate>
                    姓名:
                    <asp:TextBox ID="姓名TextBox" runat="server" Text='<%# Bind("姓名") %>' />
                    <br />
                    郵件地址:
                    <asp:TextBox ID="郵件地址TextBox" runat="server" Text='<%# Bind("郵件地址") %>' />
                    <br />
                    系別:
                    <asp:TextBox ID="系別TextBox" runat="server" Text='<%# Bind("系別") %>' />
                    <br />
                    職稱:
                    <asp:TextBox ID="職稱TextBox" runat="server" Text='<%# Bind("職稱") %>' />
                    <br />
                    辦公電話號碼:
                    <asp:TextBox ID="辦公電話號碼TextBox" runat="server" Text='<%# Bind("辦公電話號碼") %>' />
                    <br />
                    行動電話號碼:
                    <asp:TextBox ID="行動電話號碼TextBox" runat="server" Text='<%# Bind("行動電話號碼") %>' />
                    <br />
                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                        CommandName="Insert" Text="插入" />
                    &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                        CausesValidation="False" CommandName="Cancel" Text="取消" />
                </InsertItemTemplate>
                <ItemTemplate>
                    <table class="style1" style="width: 119%">
                        <tr>
                            <td class="style9">
                                <span class="style5"><span class="style7"><b>姓名</b></span></span></td>
                            <td>
                                <span class="style5"><span class="style7"><b>:<asp:Label ID="姓名Label" 
                                    runat="server" Text='<%# Bind("姓名") %>' />
                                </b></span></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="style9">
                                <span class="style5"><span class="style7"><b>系別</b></span></span></td>
                            <td>
                                <span class="style5"><span class="style7"><b>:<asp:Label ID="郵件地址Label" 
                                    runat="server" Text='<%# Bind("郵件地址") %>' />
                                </b></span></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="style9">
                                <span class="style5"><span class="style7"><b>職稱</b></span></span></td>
                            <td>
                                <span class="style5"><span class="style7"><b>:<asp:Label ID="系別Label" 
                                    runat="server" Text='<%# Bind("系別") %>' />
                                </b></span></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="style9">
                                <span class="style5"><span class="style7"><b>行動電話號碼</b></span></span></td>
                            <td>
                                <span class="style5"><span class="style7"><b>:<asp:Label ID="職稱Label" 
                                    runat="server" Text='<%# Bind("職稱") %>' />
                                </b></span></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="style9">
                                <span class="style5"><span class="style7"><b>辦公電話號碼</b></span></span></td>
                            <td>
                                <span class="style5"><span class="style7"><b>:<asp:Label ID="辦公電話號碼Label" 
                                    runat="server" Text='<%# Bind("辦公電話號碼") %>' />
                                </b></span></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="style9">
                                <span class="style5"><span class="style7"><b>郵件地址</b></span></span></td>
                            <td>
                                <span class="style5"><span class="style7"><b>:<asp:Label ID="行動電話號碼Label" 
                                    runat="server" Text='<%# Bind("行動電話號碼") %>' />
                                </b></span></span>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
                <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
            </asp:FormView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT [姓名], [郵件地址], [系別], [職稱], [辦公電話號碼], [行動電話號碼] FROM [教師]">
            </asp:SqlDataSource>
        </td>
    </tr>
</table>
</asp:Content>

