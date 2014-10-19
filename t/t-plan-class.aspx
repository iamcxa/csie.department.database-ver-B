<%@ Page Language="VB" MasterPageFile="~/t/t-MasterPage.master" Title="OTS:Online Test System" %>

<script runat="server">

    Protected Sub Button7_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim a, b, c, d, f As String
        a = CType(FormView1.Row.Cells(0).FindControl("DropDownList1"), DropDownList).Text
        b = CType(FormView1.Row.Cells(0).FindControl("DropDownList2"), DropDownList).Text
        c = CType(FormView1.Row.Cells(0).FindControl("DropDownList3"), DropDownList).Text
        d = CType(FormView1.Row.Cells(0).FindControl("DropDownList4"), DropDownList).Text
        f = CType(FormView1.Row.Cells(0).FindControl("DropDownList5"), DropDownList).Text
        CType(FormView1.Row.Cells(0).FindControl("Label2"), Label).Text = a & b & c & d & f
        CType(FormView1.Row.Cells(0).FindControl("Label2"), Label).Visible = True
    End Sub
    
    Protected Sub Button5_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
        If Me.FormView1.Visible = False Then
            Me.FormView1.Visible = True
        ElseIf Me.FormView1.Visible = True Then
            Me.FormView1.Visible = False
        End If
        
    End Sub
    
    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Me.GridView1.Visible = True Then
            Me.GridView1.Visible = False
        ElseIf Me.GridView1.Visible = False Then
            Me.GridView1.Visible = True
        End If
        
    End Sub

    Protected Sub InsertButton_Click3(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">

        .style7
        {
            font-size: x-large;
        text-align: center;
    }
        .style9
        {
            font-size: xx-large;
            font-family: 金梅黑框浮體字形;
        }
        .style10
        {
            font-size: xx-large;
            font-family: 金梅黑框浮體字形;
            font-weight: bold;
            text-align: center;
        }
        .style11
        {
            text-align: center;
        }
        .style13
        {
            font-family: 金梅樹枝美工字體;
        }
    .style14
    {
        height: 154px;
    }
    .style15
    {
        font-family: 金梅樹枝美工字體;
        font-weight: bold;
    }
    .style16
    {
            font-weight: bold;
            font-size: large;
        }
        .style17
        {
            font-family: 金梅黑框浮體字形;
            font-size: xx-large;
            color: #000000;
            font-weight: bold;
        }
        .style18
        {
            font-family: 金梅黑框浮體字形;
            font-weight: bold;
            font-size: xx-large;
        }
        .style19
        {
            font-family: 金梅樹枝美工字體;
            font-weight: bold;
            font-size: large;
        }
        .style20
        {
            font-family: 標楷體;
            font-size: large;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
        <tr>
            <td class="style11">
                <br />
                <span class="style10">班級規劃</span><b><br class="style9" />
                </b>&nbsp;　</td>
        </tr>
        <tr>
            <td class="style14">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="班級編號" 
                    DataSourceID="SqlDataSource1" DefaultMode="Insert" 
                    HorizontalAlign="Center" BackColor="#DEBA84" BorderColor="#DEBA84" 
                    BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" 
                    GridLines="Both" style="font-family: 金梅樹枝美工字體; font-size: large;" 
                    Width="897px">
                    <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                    <EditItemTemplate>
                        班級編號:
                        <asp:Label ID="班級編號Label1" runat="server" Text='<%# Eval("班級編號") %>' />
                        <br />
                        班級別:
                        <asp:TextBox ID="班級別TextBox" runat="server" Text='<%# Bind("班級別") %>' />
                        <br />
                        入學年別:
                        <asp:TextBox ID="入學年別TextBox" runat="server" Text='<%# Bind("入學年別") %>' />
                        <br />
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                            CommandName="Update" Text="更新" />
                        &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                            CausesValidation="False" CommandName="Cancel" Text="取消" />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <span class="style7"><span class="style4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span> 
                        </span><span class="style11">
                        <span class="style18">新增班級</span></span><span class="style4"><br />
                        </span>
                        <span class="style13"><b>入學年別:</b> </span><span class="style4"><span class="style4">
                        <span class="style13">
                        <asp:TextBox ID="TextBox1" runat="server" 
                            style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large;" 
                            Text='<%# Bind("入學年別") %>' Height="24px"></asp:TextBox>
                        </span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ControlToValidate="TextBox1" Display="Dynamic" 
                            ErrorMessage="RequiredFieldValidator" 
                            style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: x-large;">請輸入正確入學年別!</asp:RequiredFieldValidator>
                        </span></span>
                        <br class="style13" />
                        <span class="style15">班級別: </span>
                        <table class="style1">
                            <tr>
                                <td class="style20">
                                    <span class="style19">部別：</span><span class="style4"><span class="style13"><asp:DropDownList 
                                        ID="DropDownList1" runat="server" style="font-family: 金梅樹枝美工字體; " 
                                        CssClass="style16">
                                        <asp:ListItem>日間部</asp:ListItem>
                                        <asp:ListItem>進修部</asp:ListItem>
                                        <asp:ListItem>在職班</asp:ListItem>
                                    </asp:DropDownList>
                                    </span>
                                    </span>
                                </td>
                                <td class="style4">
                                    <span class="style19">學制別：</span><span class="style4"><span class="style13"><asp:DropDownList 
                                        ID="DropDownList2" runat="server" style="font-family: 金梅樹枝美工字體; " 
                                        CssClass="style16">
                                        <asp:ListItem>四技</asp:ListItem>
                                        <asp:ListItem>二技</asp:ListItem>
                                        <asp:ListItem>研究所</asp:ListItem>
                                    </asp:DropDownList>
                                    </span>
                                    </span>
                                </td>
                                <td class="style4">
                                    <span class="style19">系別：</span><span class="style4"><span class="style13"><asp:DropDownList 
                                        ID="DropDownList3" runat="server" style="font-family: 金梅樹枝美工字體; " 
                                        CssClass="style16">
                                        <asp:ListItem>資訊工程系</asp:ListItem>
                                        <asp:ListItem>電子工程系</asp:ListItem>
                                    </asp:DropDownList>
                                    </span>
                                    </span>
                                </td>
                                <td class="style4">
                                    <span class="style19">級別：</span><span class="style4"><span class="style13"><asp:DropDownList 
                                        ID="DropDownList4" runat="server" 
                                        style="font-family: 金梅樹枝美工字體; " CssClass="style16">
                                        <asp:ListItem>一年級</asp:ListItem>
                                        <asp:ListItem>二年級</asp:ListItem>
                                        <asp:ListItem>三年級</asp:ListItem>
                                        <asp:ListItem>四年級</asp:ListItem>
                                    </asp:DropDownList>
                                    </span>
                                    </span>
                                </td>
                                <td class="style4">
                                    <span class="style19">班別：</span><span class="style4"><span class="style13"><asp:DropDownList 
                                        ID="DropDownList5" runat="server" style="font-family: 金梅樹枝美工字體; " 
                                        CssClass="style16">
                                        <asp:ListItem>甲</asp:ListItem>
                                        <asp:ListItem>乙</asp:ListItem>
                                        <asp:ListItem>丙</asp:ListItem>
                                        <asp:ListItem>丁</asp:ListItem>
                                    </asp:DropDownList>
                                    </span>
                                    </span>
                                </td>
                                <td class="style13">
                                    <asp:Button ID="Button7" runat="server" onclick="Button7_Click" Text="確認" 
                                        BackColor="#6699FF" BorderColor="#999999" 
                                        style="font-family: 金梅樹枝美工字體; " CssClass="style16" BorderStyle="Outset" />
                                </td>
                            </tr>
                        </table>
                        <span class="style15">
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("班級別") %>' Visible="False"></asp:Label>
                        </span>
                        <b>
                        <br class="style13" />
                        </b>
                        <span class="style13">
                        <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                            CommandName="Insert" Text="登錄" onclick="InsertButton_Click3" 
                            style="font-weight: 700" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </span>&nbsp;<span class="style13"><asp:LinkButton ID="InsertCancelButton" 
                            runat="server" CausesValidation="False" CommandName="Cancel" Text="取消" 
                            style="font-weight: 700" />
                        </span>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        班級編號:
                        <asp:Label ID="班級編號Label" runat="server" Text='<%# Eval("班級編號") %>' />
                        <br />
                        班級別:
                        <asp:Label ID="班級別Label" runat="server" Text='<%# Bind("班級別") %>' />
                        <br />
                        入學年別:
                        <asp:Label ID="入學年別Label" runat="server" Text='<%# Bind("入學年別") %>' />
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
            <td style="text-align: center">
                <br />
                <br />
                <span class="style17">現有班級<br />
                </span><br />
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                    AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="班級編號" 
                    DataSourceID="SqlDataSource1" HorizontalAlign="Center" BackColor="#DEBA84" 
                    BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                    CellSpacing="2" 
                    style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large">
                    <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:TemplateField HeaderText="班級別" SortExpression="班級別">
                            <EditItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("班級別") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("班級別") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="入學年別" HeaderText="入學年別" SortExpression="入學年別" />
                    </Columns>
                    <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConflictDetection="CompareAllValues" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    DeleteCommand="DELETE FROM 班級 WHERE (班級編號 = @original_班級編號) OR (班級編號 = @original_班級編號) OR (班級編號 = @original_班級編號) OR (班級編號 = @original_班級編號)" 
                    InsertCommand="INSERT INTO [班級] ([班級別], [入學年別]) VALUES (@班級別, @入學年別)" 
                    OldValuesParameterFormatString="original_{0}" 
                    SelectCommand="SELECT * FROM [班級]" 
                    
                    
                    
                    
                    
                    UpdateCommand="UPDATE [班級] SET [班級別] = @班級別, [入學年別] = @入學年別 WHERE [班級編號] = @original_班級編號 AND (([班級別] = @original_班級別) OR ([班級別] IS NULL AND @original_班級別 IS NULL)) AND (([入學年別] = @original_入學年別) OR ([入學年別] IS NULL AND @original_入學年別 IS NULL))">
                    <DeleteParameters>
                        <asp:Parameter Name="original_班級編號" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="班級別" Type="String" />
                        <asp:Parameter Name="入學年別" Type="String" />
                        <asp:Parameter Name="original_班級編號" Type="Int32" />
                        <asp:Parameter Name="original_班級別" Type="String" />
                        <asp:Parameter Name="original_入學年別" Type="String" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="班級別" Type="String" />
                        <asp:Parameter Name="入學年別" Type="String" />
                    </InsertParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>

