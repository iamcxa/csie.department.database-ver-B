<%@ Page Language="VB" MasterPageFile="~/St1-MasterPage.master" Title="未命名頁面" %>

<script runat="server">
    Protected Sub LinkButton5_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("st-data-class.aspx")
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style5
        {
            font-size: x-large;
            font-family: 標楷體;
        }
        .style16
    {
        font-size: smaller;
    }
    .style17
    {
        font-size: xx-large;
    }
        .style18
    {
        font-family: 金梅黑框浮體字形;
            font-weight: bold;
        }
        .style19
        {
    }
        .style20
        {
            width: 445px;
        }
        .style21
        {
            width: 283px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p class="style5" style="text-align: center">
        <table align="center" class="style1" style="width: 100%">
            <tr>
                <td>
                    <span class="style17">
                    <b>
                    <br />
                    </b>
                    <span class="style18">基本資料</span></span><span class="style16"><br />
                    <br />
                    </span>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="學號" 
            DataSourceID="SqlDataSource1" CaptionAlign="Top" HorizontalAlign="Center" 
                        
                        
                        
                        style="font-size: x-large; text-align: left; font-family: 金梅樹枝美工字體; font-weight: 700;" BackColor="#DEBA84" 
                        BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                        CellSpacing="2" GridLines="Both" Width="467px">
            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
            <EditItemTemplate>
                <table class="style20">
                    <tr>
                        <td class="style19">
                            學號</td>
                        <td class="style21">
                            :<asp:Label ID="學號Label1" runat="server" Text='<%# Eval("學號") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="style19">
                            密碼</td>
                        <td class="style21">
                            :<asp:TextBox ID="密碼TextBox" runat="server" Text='<%# Bind("密碼") %>' 
                                style="font-family: 金梅樹枝美工字體; font-weight: 700" />
                        </td>
                    </tr>
                    <tr>
                        <td class="style19">
                            姓名</td>
                        <td class="style21">
                            :<asp:TextBox ID="姓名TextBox" runat="server" Text='<%# Bind("姓名") %>' 
                                style="font-family: 金梅樹枝美工字體; font-weight: 700" />
                        </td>
                    </tr>
                    <tr>
                        <td class="style19">
                            班級別</td>
                        <td class="style21">
                            :<asp:Label ID="Label2" runat="server" Text='<%# Bind("班級別") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="style19">
                            家庭電話號碼</td>
                        <td class="style21">
                            :<asp:TextBox ID="家庭電話號碼TextBox" runat="server" Text='<%# Bind("家庭電話號碼") %>' 
                                style="font-family: 金梅樹枝美工字體; font-weight: 700" />
                        </td>
                    </tr>
                    <tr>
                        <td class="style19">
                            行動電話號碼</td>
                        <td class="style21">
                            :<asp:TextBox ID="行動電話號碼TextBox" runat="server" Text='<%# Bind("行動電話號碼") %>' 
                                style="font-family: 金梅樹枝美工字體; font-weight: 700" />
                        </td>
                    </tr>
                    <tr>
                        <td class="style19">
                            好友電話號碼</td>
                        <td class="style21">
                            :<asp:TextBox ID="好友電話號碼TextBox" runat="server" Text='<%# Bind("好友電話號碼") %>' 
                                style="font-family: 金梅樹枝美工字體; font-weight: 700" />
                        </td>
                    </tr>
                    <tr>
                        <td class="style19">
                            電子郵件信箱</td>
                        <td class="style21">
                            :<asp:TextBox ID="TextBox1" runat="server" 
                                style="font-family: 金梅樹枝美工字體; font-weight: 700" Text='<%# Bind("電子郵件地址") %>'></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style22">
                            </td>
                        <td class="style23">
                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                                CommandName="Update" Text="更新" />
                            &nbsp;&nbsp;&nbsp;
                            <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" 
                                CommandName="Cancel" Text="取消" />
                        </td>
                    </tr>
                </table>
            </EditItemTemplate>
            <InsertItemTemplate>
                學號:
                <asp:TextBox ID="學號TextBox" runat="server" Text='<%# Bind("學號") %>' />
                <br />
                密碼:
                <asp:TextBox ID="密碼TextBox" runat="server" Text='<%# Bind("密碼") %>' />
                <br />
                姓名:
                <asp:TextBox ID="姓名TextBox" runat="server" Text='<%# Bind("姓名") %>' />
                <br />
                班級別:
                <asp:TextBox ID="班級別TextBox" runat="server" Text='<%# Bind("班級別") %>' />
                <br />
                家庭電話號碼:
                <asp:TextBox ID="家庭電話號碼TextBox" runat="server" Text='<%# Bind("家庭電話號碼") %>' />
                <br />
                行動電話號碼:
                <asp:TextBox ID="行動電話號碼TextBox" runat="server" Text='<%# Bind("行動電話號碼") %>' />
                <br />
                好友電話號碼:
                <asp:TextBox ID="好友電話號碼TextBox" runat="server" Text='<%# Bind("好友電話號碼") %>' />
                <br />
                班級編號:
                <asp:TextBox ID="班級編號TextBox" runat="server" Text='<%# Bind("班級編號") %>' />
                <br />
                入學年別:
                <asp:TextBox ID="入學年別TextBox" runat="server" Text='<%# Bind("入學年別") %>' />
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" 
                    CausesValidation="True" CommandName="Insert" Text="插入" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" 
                    CommandName="Cancel" Text="取消" />
            </InsertItemTemplate>
            <ItemTemplate>
                <table class="style20">
                    <tr>
                        <td class="style19">
                            學號</td>
                        <td class="style21">
                            :<asp:Label ID="學號Label" runat="server" Text='<%# Eval("學號") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="style19">
                            密碼</td>
                        <td class="style21">
                            :<asp:Label ID="密碼Label" runat="server" Text='<%# Bind("密碼") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="style19">
                            姓名</td>
                        <td class="style21">
                            :<asp:Label ID="姓名Label" runat="server" Text='<%# Bind("姓名") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="style19">
                            班級別</td>
                        <td class="style21">
                            :<asp:Label ID="班級別Label" runat="server" Text='<%# Bind("班級別") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="style19">
                            家庭電話號碼</td>
                        <td class="style21">
                            :<asp:Label ID="家庭電話號碼Label" runat="server" Text='<%# Bind("家庭電話號碼") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="style19">
                            行動電話號碼</td>
                        <td class="style21">
                            :<asp:Label ID="行動電話號碼Label" runat="server" Text='<%# Bind("行動電話號碼") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="style19">
                            好友電話號碼</td>
                        <td class="style21">
                            :<asp:Label ID="好友電話號碼Label" runat="server" Text='<%# Bind("好友電話號碼") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="style19">
                            電子郵件信箱</td>
                        <td class="style21">
                            :<asp:Label ID="Label3" runat="server" 
                                style="font-family: 金梅樹枝美工字體; font-weight: 700" Text='<%# Bind("電子郵件地址") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="style19">
                            &nbsp;</td>
                        <td class="style21">
                            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" 
                                CommandName="Edit" Text="編輯" />
                            &nbsp;</td>
                    </tr>
                </table>
            </ItemTemplate>
            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#FFF7E7" Font-Bold="True" ForeColor="#8C4510" />
        </asp:FormView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            InsertCommand="INSERT INTO 學生(學號, 密碼, 姓名, 電子郵件地址, 家庭電話號碼, 行動電話號碼, 好友電話號碼) VALUES (@學號, @密碼, @姓名, @電子郵件地址, @家庭電話號碼, @行動電話號碼, @好友電話號碼)" 
            SelectCommand="SELECT 學生.學號, 學生.密碼, 學生.姓名, 班級.班級別, 學生.家庭電話號碼, 學生.行動電話號碼, 學生.好友電話號碼, 學生.班級編號, 班級.入學年別, 學生.電子郵件地址 FROM 班級 INNER JOIN 學生 ON 班級.班級編號 = 學生.班級編號 WHERE (學生.學號 = @學號)" 
            
            
            
            
                        
                        UpdateCommand="UPDATE 學生 SET 學號 = @學號, 密碼 = @密碼, 姓名 = @姓名, 電子郵件地址 = @電子郵件地址, 家庭電話號碼 = @家庭電話號碼, 行動電話號碼 = @行動電話號碼, 好友電話號碼 = @好友電話號碼 WHERE (學號 = @學號)">
            <SelectParameters>
                <asp:SessionParameter Name="學號" SessionField="OK_STU" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="學號" />
                <asp:Parameter Name="密碼" />
                <asp:Parameter Name="姓名" />
                <asp:Parameter Name="電子郵件地址" />
                <asp:Parameter Name="家庭電話號碼" />
                <asp:Parameter Name="行動電話號碼" />
                <asp:Parameter Name="好友電話號碼" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="學號" />
                <asp:Parameter Name="密碼" />
                <asp:Parameter Name="姓名" />
                <asp:Parameter Name="電子郵件地址" />
                <asp:Parameter Name="家庭電話號碼" />
                <asp:Parameter Name="行動電話號碼" />
                <asp:Parameter Name="好友電話號碼" />
            </InsertParameters>
        </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </p>
</asp:Content>

