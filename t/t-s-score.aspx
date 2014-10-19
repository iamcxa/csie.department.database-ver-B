<%@ Page Language="VB" MasterPageFile="~/t/t-MasterPage.master" Title="OTS:Online Test System" %>

<script runat="server">

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("class_name_no") = DropDownList1.SelectedValue
        Session("class_no") = DropDownList2.SelectedValue
        Session("t_day") = DropDownList3.SelectedValue
        Me.GridView1.Visible = True
        Me.Label2.Visible = False
        Me.DropDownList3.Visible = False
        Me.Button1.Visible = False
        Me.Button2.Visible = True
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("class_no") = DropDownList2.SelectedValue
    End Sub

    Protected Sub Button2_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("class_no") = DropDownList2.SelectedValue
        Me.Label2.Visible = True
        Me.DropDownList3.Visible = True
        Me.Button1.Visible = True
        Me.Button2.Visible = False
        Me.GridView1.Visible = False
    End Sub
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../javascripts/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../javascripts/jquery.curvycorners.min.js" type="text/javascript"></script>
    <script src="../javascripts/corner.js" type="text/javascript"></script>
    <script src="../javascripts/wait.js" type="text/javascript"></script>
    <script src="../javascripts/T-display.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="../style.css" />
    <style type="text/css">
        .style7
        {
            font-family: �����®دB��r��;
            font-weight: bold;
            font-size: xx-large;
        }
        .style9
        {
            font-size: x-large;
            font-weight: bold;
        }
        .style10
        {
            font-size: x-large;
        }
        .style11
        {
            width: 100%;
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="Main" class="Main">
        <div id="container2" class="container2">
            <div id="mainContent">
                <table style="width: 100%;">
                    <tr>
                        <td style="text-align: center;border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: #C0C0C0;
                            height: 30px;">
                            <asp:Label ID="Label_notice" runat="server" Font-Bold="True" ForeColor="Red" 
                                Font-Size="XX-Large">���Z�C��</asp:Label>
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
                    <asp:MultiView ID="MultiView_Main" runat="server" ActiveViewIndex="0">
                        <asp:View ID="View1" runat="server">
                         
                            <table align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <table class="style11">
                                      
                                                <td class="style11">
                                                 
                                                
                                                    <span><b><span class="style10">&nbsp;&nbsp; �Z�šG<asp:DropDownList ID="DropDownList1"
                                                        runat="server" DataSourceID="SqlDataSource1" DataTextField="�Z�ŧO" DataValueField="�Z�Žs��"
                                                        Style="font-weight: 700; font-size: large;">
                                                    </asp:DropDownList>
                                                        &nbsp; �ҵ{�G<asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource3"
                                                            DataTextField="�ҵ{�W��" DataValueField="�ҵ{�s��" Style="font-weight: 700; font-size: large;">
                                                        </asp:DropDownList>
                                                        &nbsp;<asp:Button ID="Button2" runat="server" BackColor="#6699FF" BorderColor="#999999"
                                                            BorderStyle="Outset" Height="24px" OnClick="Button2_Click1" Style="font-weight: 700;
                                                            font-size: large" Text="�T�{" />
                                                        &nbsp;<br />
                                                        <asp:Label ID="Label2" runat="server" Text="�������G" Visible="False"></asp:Label>
                                                        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource4"
                                                            DataTextField="������" DataValueField="������" Style="font-weight: 700; font-size: large;"
                                                            Visible="False">
                                                        </asp:DropDownList>
                                                    </span></b></span><span class="style8"><span class="style9">
                                                        <asp:Button ID="Button1" runat="server" BackColor="#6699FF" BorderColor="#999999"
                                                            BorderStyle="Outset" Height="22px" OnClick="Button1_Click" Style="font-size: large;
                                                            font-weight: 700" Text="�d��" Visible="False" Width="49px" />
                                                    </span></span>
                                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                                        SelectCommand="SELECT [�Z�Žs��], [�Z�ŧO] FROM [�Z��]"></asp:SqlDataSource>
                                                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                                        SelectCommand="SELECT DISTINCT �ҵ{.�ҵ{�s��, �ҵ{.�ҵ{�W�� FROM �}�� INNER JOIN �ҵ{ ON �}��.�ҵ{�s�� = �ҵ{.�ҵ{�s��">
                                                    </asp:SqlDataSource>
                                                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                                        SelectCommand="SELECT DISTINCT �ҵ{.�ҵ{�s��, ����.������ FROM �D�w INNER JOIN �ҵ{ ON �D�w.�ҵ{�s�� = �ҵ{.�ҵ{�s�� INNER JOIN ���D ON �D�w.�D�ؽs�� = ���D.�D�ؽs�� INNER JOIN �R�D�d�� ON ���D.�ը��s�� = �R�D�d��.�ը��s�� INNER JOIN ���� ON �R�D�d��.�ը��s�� = ����.�ը��s�� WHERE (�ҵ{.�ҵ{�s�� = @�ҵ{�s��)">
                                                        <SelectParameters>
                                                            <asp:SessionParameter Name="�ҵ{�s��" SessionField="class_no" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                        BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px"
                                                        CellPadding="3" CellSpacing="2" DataKeyNames="�Ǹ�" DataSourceID="SqlDataSource2"
                                                        HorizontalAlign="Center" Style="font-size: large; font-weight: 700" Visible="False">
                                                        <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                                                        <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                                                        <Columns>
                                                            <asp:BoundField DataField="�Ǹ�" HeaderText="�Ǹ�" ReadOnly="True" SortExpression="�Ǹ�" />
                                                            <asp:BoundField DataField="�Z�ŧO" HeaderText="�Z�ŧO" SortExpression="�Z�ŧO" />
                                                            <asp:BoundField DataField="�ҵ{�W��" HeaderText="�ҵ{�W��" SortExpression="�ҵ{�W��" />
                                                            <asp:BoundField DataField="���զ��Z" HeaderText="���զ��Z" SortExpression="���զ��Z" />
                                                            <asp:BoundField DataField="������" HeaderText="������" SortExpression="������" />
                                                        </Columns>
                                                        <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                                                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                                                        <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                                                    </asp:GridView>
                                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                                        SelectCommand="SELECT DISTINCT �ǥ�.�Ǹ�, �Z��.�Z�ŧO, �ҵ{.�ҵ{�W��, ����.���զ��Z, ����.������ FROM �ǥ� INNER JOIN �Z�� ON �ǥ�.�Z�Žs�� = �Z��.�Z�Žs�� INNER JOIN �}�� ON �Z��.�Z�Žs�� = �}��.�Z�Žs�� INNER JOIN �ҵ{ ON �}��.�ҵ{�s�� = �ҵ{.�ҵ{�s�� INNER JOIN ���ץd ON �ǥ�.�Ǹ� = ���ץd.�Ǹ� INNER JOIN ���� ON ���ץd.���ץd�s�� = ����.���ץd�s�� INNER JOIN �R�D�d�� ON ����.�ը��s�� = �R�D�d��.�ը��s�� WHERE (�Z��.�Z�Žs�� = @�Z�Žs��) AND (�ҵ{.�ҵ{�s�� = @�ҵ{�s��) AND (����.������ = @������)">
                                                        <SelectParameters>
                                                            <asp:SessionParameter Name="�Z�Žs��" SessionField="class_name_no" />
                                                            <asp:SessionParameter Name="�ҵ{�s��" SessionField="class_no" />
                                                            <asp:SessionParameter DefaultValue="" Name="������" SessionField="t_day" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:View>
                    </asp:MultiView>
                </div>
                <!-- end #mainContent -->
            </div>
            <!-- end #container -->
        </div>
    </div>
</asp:Content>
