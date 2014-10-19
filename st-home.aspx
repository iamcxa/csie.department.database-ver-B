<%@ Page Language="VB" MasterPageFile="~/St1-MasterPage.master" Title="未命名頁面" %>

<script runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
    .style4
    {
        font-size: x-large;
    }
        .style12
    {
        text-align: center;
        line-height: 200%;
        width: 847px;
    }
    .style13
    {
        font-size: large;
        font-family: 金梅樹枝美工字體;
        font-weight: bold;
    }
    .style14
    {
        font-size: large;
        font-family: 金梅樹枝美工字體;
        font-weight: bold;
        text-align: left;
    }
        .style15
        {
            width: 671px;
        }
        .style16
        {
            width: 900px;
        }
        .style17
        {
            width: 283px;
        }
        .style18
        {
            width: 108px;
        }
        .style19
        {
            font-size: x-large;
            font-family: 金梅大胖胖個性字;
            text-align: right;
        }
        .style20
        {
            font-family: 金梅特黑吐舌頭字;
            text-align: right;
        }
    .style21
    {
        font-size: large;
        font-family: 金梅樹枝美工字體;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
    SelectCommand="SELECT [姓名], [學號] FROM [學生] WHERE ([學號] = @學號)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="" Name="學號" SessionField="OK_STU" 
                Type="Int32" />
        </SelectParameters>
</asp:SqlDataSource>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="學號" 
        DataSourceID="SqlDataSource1" style="text-align: center; font-size: x-large; font-family: 金梅樹枝美工字體; font-weight: 700;" 
    HorizontalAlign="Center" Height="66px" Width="512px" Font-Size="X-Large">
        <EditItemTemplate>
            學號:
            <asp:Label ID="學號Label1" runat="server" Text='<%# Eval("學號") %>' />
            <br />
            姓名:
            <asp:TextBox ID="姓名TextBox" runat="server" Text='<%# Bind("姓名") %>' />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                CommandName="Update" Text="更新" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                CausesValidation="False" CommandName="Cancel" Text="取消" />
        </EditItemTemplate>
        <InsertItemTemplate>
            學號:
            <asp:TextBox ID="姓名TextBox" runat="server" Text='<%# Bind("姓名") %>' />
            <br />
            姓名:
            <asp:TextBox ID="學號TextBox" runat="server" Text='<%# Bind("學號") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                CommandName="Insert" Text="插入" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                CausesValidation="False" CommandName="Cancel" Text="取消" />
        </InsertItemTemplate>
        <ItemTemplate>
            <span class="style19"><span class="style20">歡迎 
            <asp:Label ID="姓名Label" runat="server" Text='<%# Bind("姓名") %>' 
                Font-Bold="True" ForeColor="Lime" style="color: #00CC00" />
            進入本系統</span></span><br />
        </ItemTemplate>
    </asp:FormView>
    <br />
    <table class="style16">
        <tr>
            <td class="style17">
                &nbsp;</td>
            <td class="style15">
                            <span class="style14">※使用者第一次進入，請先到基本資料填寫資料。</span><br class="style13" />
                            <span class="style14">※慎選課程，</span><b><span class="style21">如需更改請與導師連絡。</span><br 
                                class="style21" />
                            <span class="style21">※欲知考題答案，請至&quot;成績查詢&quot;。</span><br class="style21" />
                            <span class="style21">※考試日期，皆公佈在此處，務必隨時注意。</span><br class="style21" />
                            </b>
            </td>
            <td class="style18">
                &nbsp;</td>
        </tr>
    </table>
                        <p class="style12">
                            <br />
</p>
</asp:Content>

