<%@ Page Language="VB" MasterPageFile="~/St1-MasterPage.master" Title="���R�W����" %>

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
        font-family: ������K���u�r��;
        font-weight: bold;
    }
    .style14
    {
        font-size: large;
        font-family: ������K���u�r��;
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
            font-family: �����j�D�D�өʦr;
            text-align: right;
        }
        .style20
        {
            font-family: �����S�¦R���Y�r;
            text-align: right;
        }
    .style21
    {
        font-size: large;
        font-family: ������K���u�r��;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
    SelectCommand="SELECT [�m�W], [�Ǹ�] FROM [�ǥ�] WHERE ([�Ǹ�] = @�Ǹ�)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="" Name="�Ǹ�" SessionField="OK_STU" 
                Type="Int32" />
        </SelectParameters>
</asp:SqlDataSource>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="�Ǹ�" 
        DataSourceID="SqlDataSource1" style="text-align: center; font-size: x-large; font-family: ������K���u�r��; font-weight: 700;" 
    HorizontalAlign="Center" Height="66px" Width="512px" Font-Size="X-Large">
        <EditItemTemplate>
            �Ǹ�:
            <asp:Label ID="�Ǹ�Label1" runat="server" Text='<%# Eval("�Ǹ�") %>' />
            <br />
            �m�W:
            <asp:TextBox ID="�m�WTextBox" runat="server" Text='<%# Bind("�m�W") %>' />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                CommandName="Update" Text="��s" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                CausesValidation="False" CommandName="Cancel" Text="����" />
        </EditItemTemplate>
        <InsertItemTemplate>
            �Ǹ�:
            <asp:TextBox ID="�m�WTextBox" runat="server" Text='<%# Bind("�m�W") %>' />
            <br />
            �m�W:
            <asp:TextBox ID="�Ǹ�TextBox" runat="server" Text='<%# Bind("�Ǹ�") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                CommandName="Insert" Text="���J" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                CausesValidation="False" CommandName="Cancel" Text="����" />
        </InsertItemTemplate>
        <ItemTemplate>
            <span class="style19"><span class="style20">�w�� 
            <asp:Label ID="�m�WLabel" runat="server" Text='<%# Bind("�m�W") %>' 
                Font-Bold="True" ForeColor="Lime" style="color: #00CC00" />
            �i�J���t��</span></span><br />
        </ItemTemplate>
    </asp:FormView>
    <br />
    <table class="style16">
        <tr>
            <td class="style17">
                &nbsp;</td>
            <td class="style15">
                            <span class="style14">���ϥΪ̲Ĥ@���i�J�A�Х���򥻸�ƶ�g��ơC</span><br class="style13" />
                            <span class="style14">���V��ҵ{�A</span><b><span class="style21">�p�ݧ��лP�ɮv�s���C</span><br 
                                class="style21" />
                            <span class="style21">���������D���סA�Ц�&quot;���Z�d��&quot;�C</span><br class="style21" />
                            <span class="style21">���Ҹդ���A�Ҥ��G�b���B�A�ȥ��H�ɪ`�N�C</span><br class="style21" />
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

