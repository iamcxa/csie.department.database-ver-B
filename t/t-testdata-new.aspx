<%@ Page Language="VB" MasterPageFile="~/t/t-MasterPage.master" Title="OTS:Online Test System" %>

<%@ Import Namespace="System.Data" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Import Namespace="System.Drawing" %>

<script runat="server">
    Dim No, FileSize As String
    Public SaveAspath As String = HttpContext.Current.Request.MapPath("~")
    Dim FolderName As String = "Questions_pics"
  
    Public Sub MsgBox(ByVal Message As String)
        Dim sScript As String
        Dim sMessage As String

        sMessage = Strings.Replace(Message, "'", "\'") '處理單引號
        sMessage = Strings.Replace(sMessage, vbNewLine, "\n") '處理換行
        sScript = String.Format("alert('{0}');", sMessage)
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", sScript, True)
    End Sub
    
    Protected Sub Button6_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim conn As Data.SqlClient.SqlConnection, cmd As Data.SqlClient.SqlCommand
        Dim Rd As Data.SqlClient.SqlDataReader, SQL As String
        Dim Pic1Path As String = ""
        Dim Pic2Path As String = ""
        
        conn = New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|INTE.mdf;Integrated Security=True;User Instance=True")
        conn.Open()
        
        If Not ImageButton_Pic1.ImageUrl = "../images/Add.png" Then
            Pic1Path = (ImageButton_Pic1.ImageUrl)
        End If
        If Not ImageButton_Pic2.ImageUrl = "../images/Add.png" Then
            Pic2Path = ImageButton_Pic2.ImageUrl
        End If
        
        SQL = "Insert Into 題庫 (課程編號,題目敘述,題型,正確解答選項,所屬章節,題目圖檔) Values ('" & Me.DropDownList6.SelectedValue & "','" & Me.TextBox5.Text & "','" & Me.DropDownList7.SelectedValue & "','" & Me.TextBox7.Text & "','" & Me.TextBox8.Text & "','" & Pic1Path & "')"
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        cmd.ExecuteNonQuery()
        conn.Close()
        
        Dim i As Integer
        conn.Open()
        SQL = "SELECT MAX (題目編號) FROM 題庫"
        cmd = New Data.SqlClient.SqlCommand(SQL, conn)
        Rd = cmd.ExecuteReader
        If Rd.Read() Then
            i = Rd.GetValue(0)
            conn.Close()
        End If
        conn.Close()
        Me.Session("t_no") = i
        
        For j As Integer = 1 To Me.TextBox6.Text Step 1
            conn.Open()
            SQL = "Insert Into 答案 (題目編號) Values ('" & i & "')"
            cmd = New Data.SqlClient.SqlCommand(SQL, conn)
            cmd.ExecuteNonQuery()
            conn.Close()
        Next
        Me.Label9.Visible = True
        Me.Label9.Text = "新增成功"
        Me.TextBox5.Text = ""
        Me.TextBox7.Text = ""
        Me.MultiView1.ActiveViewIndex = 1
    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
    End Sub
    
    Protected Sub Page_UnLoad(ByVal sender As Object, ByVal e As System.EventArgs)
           
        If Session("IsThisSave") = False And Session("IsLeave") = True Then
            RemovePic(ImageButton_Pic1, Session("Pic1Path"))
            RemovePic(ImageButton_Pic2, Session("Pic2Path"))
               Session.RemoveAll()
        End If
     
    End Sub

 

    Protected Sub Button8_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        RequiredFieldValidator1.Enabled = True
        RequiredFieldValidator2.Enabled = True
        RequiredFieldValidator3.Enabled = True
        RequiredFieldValidator4.Enabled = True
        Button6.Enabled = True
    End Sub

  

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        MultiView1.ActiveViewIndex = 0
    End Sub

    Protected Sub DropDownList2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub Button9_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub Button9_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.MultiView1.ActiveViewIndex = 0
    End Sub
      
    Sub SetImagebutton(ByVal ButtonID As Object, ByVal PicPath As String)
        ButtonID.ImageUrl = "../" & FolderName & "/" & PicPath
        If System.Drawing.Image.FromFile(SaveAspath & "\" & FolderName & "\" & PicPath).Width > 129 Then
            ButtonID.Width = 128
        Else
            ButtonID.Width = ButtonID.Width
        End If
    End Sub
    
    Sub CratePicFile(ByVal Fileupdata_ID As FileUpload)
        If (Fileupdata_ID.HasFile) Then
            Dim fileName As String = Fileupdata_ID.FileName
            Dim extension As String = System.IO.Path.GetExtension(fileName)
            Dim user As String = Session("user")
            If (extension = ".jpg") Or (extension = ".gif") Or (extension = ".png") Then
                FileSize = Fileupdata_ID.PostedFile.ContentLength
                If Fileupdata_ID.PostedFile.ContentLength > 2048000 Then
                    Me.Label_UploadState.Text = "超出單一檔案 2MB 限制！"
                Else
                    If Not System.IO.Directory.Exists(SaveAspath & "\" & FolderName & "\" & Me.Page.User.Identity.Name & "/") Then
                        System.IO.Directory.CreateDirectory(SaveAspath & "\" & FolderName & "\" & Me.Page.User.Identity.Name & "/")
                    Else
                        Dim path As String
                        Me.UpdateProgress1.DataBind()
                        If Session("IsPic1") = True Then
                            session("Pic1Path") = Now.Year & Now.Month & Now.Day & Now.Hour & Now.Minute & Now.Second & Now.Millisecond & Fileupdata_ID.FileName.Trim()
                            Fileupdata_ID.SaveAs(SaveAspath & "\" & FolderName & "\" & session("Pic1Path"))
                            path = Session("Pic1Path")
                        Else
                            Session("Pic2Path") = Now.Year & Now.Month & Now.Day & Now.Hour & Now.Minute & Now.Second & Now.Millisecond & Fileupdata_ID.FileName.Trim()
                            Fileupdata_ID.SaveAs(SaveAspath & "\" & FolderName & "\" & Session("Pic2Path"))
                        End If

                        If Not System.IO.File.Exists(SaveAspath & "\" & FolderName & "\" & path) Then
                            Me.Label_UploadState.Text = "上傳失敗！"
                        Else
                            Session("IsUploadDone") = True
                            Session("IsThisSave") = False
                            Session("useTime") = Now.Hour & Now.Minute & Now.Second & Now.Millisecond
                        End If
                    End If
                End If
            Else
                Me.Label_UploadState.Text = "檔案格式錯誤！"
            End If
        Else
            Me.Label_UploadState.Text = "沒有選擇檔案！"
        End If
    End Sub
    


    Protected Sub LinkButton_UploadPicCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_UploadPicCancel.Click
        Session("ActiveViewIndex") = 1
        Session.Remove("IsPic1")
        Me.MultiView_ADDPic.ActiveViewIndex = -1

    End Sub
    
    Sub AddPicButton(ByVal Pic_ID As Object)
        If Not Pic_ID.ImageUrl = "../images/Add.png" Then
            If Me.MultiView_ADDPic.ActiveViewIndex <> 1 Then
                Image_PreViewPic.ImageUrl = Pic_ID.ImageUrl
                If System.Drawing.Image.FromFile(SaveAspath & Image_PreViewPic.ImageUrl.Remove(0, 1)).Width > 980 Then
                    Image_PreViewPic.Width = 800
                End If
                Me.MultiView_ADDPic.ActiveViewIndex = 1
            Else
                Me.MultiView_ADDPic.ActiveViewIndex = -1
            End If
        Else
            Me.MultiView_ADDPic.ActiveViewIndex = 0
            Me.Label_UploadState.Text = ""
        End If
    End Sub
    
    Protected Sub ImageButton_Pic1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        AddPicButton(ImageButton_Pic1)
        Session("IsPic1") = True
        Session("IsLeave") = False
        Me.Panel_UploadPic.GroupingText = "上傳至附圖1"
    End Sub
    
    Protected Sub ImageButton_Pic2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        AddPicButton(ImageButton_Pic2)
        Session("IsPic1") = False
         Session("IsLeave") = False
        Me.Panel_UploadPic.GroupingText = "上傳至附圖2"
    End Sub
    Protected Sub LinkButton_UploadPic_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim useTime As String = Now.Hour & Now.Minute & Now.Second & Now.Millisecond
        CratePicFile(FileUpload_Pic1)
        If Session("IsUploadDone") = True Then
            If Session("IsPic1") = True Then
                SetImagebutton(ImageButton_Pic1, session("Pic1Path"))
            Else
                SetImagebutton(ImageButton_Pic2, session("Pic2Path"))
            End If
            Me.MultiView_ADDPic.ActiveViewIndex = -1
            Me.LinkButton_DelPic1.Visible = True
            If Session("IsPic1") = True Then
                Me.LinkButton_DelPic1.Enabled = True
                Me.LinkButton_DelPic1.Text = "刪除附圖"
            Else
                Me.LinkButton_DelPic2.Enabled = True
                Me.LinkButton_DelPic2.Text = "刪除附圖"
            End If

        End If
        If Application("IsDebug") = True Then
            MsgBox("圖片上傳狀態:" & session("Pic1Path") & vbNewLine & "圖片檔案大小:" & Int(FileSize / 1024) & "KB" & vbNewLine & "耗　時 : " & Session("useTime") - useTime & " 毫秒")
        End If
    End Sub

    Sub RemovePic(ByVal Pic_ID As Object, ByVal PicPath As String)
        If System.IO.File.Exists(SaveAspath & "\" & FolderName & "\" & PicPath) Then
            System.IO.File.Delete(SaveAspath & "\" & FolderName & "\" & PicPath)
            If Application("IsDebug") = True Then
                MsgBox("成功刪除 " & SaveAspath & "\" & FolderName & "\" & PicPath)
            End If
            Pic_ID.ImageUrl = "../images/Add.png"
            Pic_ID.Height = 83
            Pic_ID.Width = 84
            Pic_ID.Enabled = True
            Me.Image_PreViewPic.ImageUrl = ""
            Me.Image_PreViewPic.Width = 0
        Else
            If Application("IsDebug") = True Then
                MsgBox("未刪除任何圖片")
            End If
        End If
    End Sub
    
    Protected Sub LinkButton_DelPic2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        RemovePic(ImageButton_Pic2, session("Pic2Path"))
        If Me.ImageButton_Pic2.ImageUrl = "../images/Add.png" Then
            Me.LinkButton_DelPic2.Enabled = False
            Me.LinkButton_DelPic2.Text = "附圖2"
        End If
    End Sub

    Protected Sub LinkButton_DelPic1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        RemovePic(ImageButton_Pic1, session("Pic1Path"))
        If Me.ImageButton_Pic1.ImageUrl = "../images/Add.png" Then
            Me.LinkButton_DelPic1.Enabled = False
            Me.LinkButton_DelPic1.Text = "附圖1"
        End If
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

        #MutiView
        {
            text-align: center;
        }

        .style5
        {
            width: 100%;
        }

        .style6
        {
            text-align: right;
        }
        .style7
        {
            text-align: left;
        }
        .style21
        {
            text-align: center;
        }
              
        .style20
        {
            font-weight: 700;
            font-size: large;
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
            <div id="mainContent0">
                            <table style="width: 100%;">
                                <tr>
                                    <td style="border-bottom: 1px solid #C0C0C0; height: 30px; text-align: center;">
                                        <asp:Label ID="Label_notice" runat="server" Font-Bold="True" ForeColor="Red" Font-Size="XX-Large">新增題目</asp:Label>
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
                                <asp:MultiView ID="MultiView_ADDPic" runat="server">
                                    <asp:View ID="View_UploadPic" runat="server">
                                        <table align="center" cellpadding="0" cellspacing="0" class="style5">
                                            <tr>
                                                <td align="center">
                                                    <asp:Panel ID="Panel_UploadPic" runat="server" 
                                                        DefaultButton="LinkButton_UploadPic" GroupingText="上傳" Height="98px" 
                                                        meta:resourcekey="Panel_UploadPicResource1" Width="950px" 
                                                        style="text-align: left">
                                                        <div class="style21">
                                                            &nbsp;<asp:Label ID="Label_UploadState" runat="server" Font-Bold="True" 
                                                                Font-Size="Small" ForeColor="Red" meta:resourcekey="Label_UploadStateResource1"></asp:Label>
                                                            <br />
                                                        </div>
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td class="style20">
                                                                    &nbsp;<asp:Label ID="Label_pic4" runat="server" Font-Bold="True" Font-Size="Small" 
                                                                        meta:resourcekey="Label_pic4Resource1" Text="&nbsp;圖形 :" 
                                                                        style="font-size: large"></asp:Label>
                                                                    <span lang="zh-tw">&nbsp;&nbsp;</span><asp:FileUpload ID="FileUpload_Pic1" runat="server" 
                                                                        Font-Size="X-Small" meta:resourcekey="FileUpload_Pic1Resource1" 
                                                                        Width="700px" style="font-size: large; height: 27px;" /> <span lang="zh-tw">
                                                            <asp:LinkButton ID="LinkButton_UploadPic" runat="server" 
                                                                CausesValidation="False" meta:resourcekey="LinkButton_UploadPicResource1" 
                                                                onclick="LinkButton_UploadPic_Click">上 傳</asp:LinkButton>
                                                            &nbsp;|
                                                            <asp:LinkButton ID="LinkButton_UploadPicCancel" runat="server" 
                                                                CausesValidation="False" meta:resourcekey="LinkButton_UploadPicCancelResource1">取 消</asp:LinkButton>
                                                            </span>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <br />
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:View>
                                    <asp:View ID="View_PreViewPic" runat="server">
                                        <asp:Image ID="Image_PreViewPic" runat="server" />
                                    </asp:View>
                                </asp:MultiView>
    <table style="width: 100%;">
        <tr>
            <td style="text-align: center; font-size: large;">
               <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0" 
                   >
                    <asp:View ID="View1" runat="server">
                        <table style="width: 100%; text-align: center">
                            <tr>
                                <td class="style22">
                                    &nbsp;</td>
                                <td class="style25">
                                    <b><span class="style13">
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 課程：<asp:DropDownList 
                                        ID="DropDownList6" runat="server" DataSourceID="SqlDataSource2" 
                                        DataTextField="課程名稱" DataValueField="課程編號" 
                                        style="font-size: large; font-family: 金梅樹枝美工字體; font-weight: 700">
                                    </asp:DropDownList>
                                    </span>&nbsp;<asp:Button ID="Button8" runat="server" BackColor="#6699FF" 
                                        BorderColor="#999999" Height="25px" onclick="Button8_Click" 
                                        style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large" 
                                        Text="確定" BorderStyle="Outset" />
                                    </b>
                                </td>
                            </tr>
                            <tr>
                                <td class="style23">
                                    <asp:ImageButton ID="ImageButton_Pic1" runat="server" 
                                        ImageUrl="../images/Add.png" onclick="ImageButton_Pic1_Click" />
                                    <span class="style13"><b>
                                    <br />
                                    <asp:LinkButton ID="LinkButton_DelPic1" runat="server" 
                                        onclick="LinkButton_DelPic1_Click" Enabled="False">附圖1</asp:LinkButton>
                                    </b></span>
                                </td>
                                <td class="style26">
                                    <span class="style16">&nbsp;&nbsp;&nbsp; 題目敘述：<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                        ControlToValidate="TextBox5" Display="Dynamic" 
                                        ErrorMessage="RequiredFieldValidator" Enabled="False" 
                                        style="font-size: large">請輸入題目!</asp:RequiredFieldValidator>
                                    <br />
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:TextBox ID="TextBox5" runat="server" Rows="10" 
                                        style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: medium;" 
                                        TextMode="MultiLine" Width="80%"></asp:TextBox>
                                    <br />
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td class="style24">
                                    <br class="style21" />
                                    <asp:ImageButton ID="ImageButton_Pic2" runat="server" 
                                        ImageUrl="../images/Add.png" onclick="ImageButton_Pic2_Click" 
                                        style="height: 84px" Enabled="False" />
                                    <span class="style13"><b>
                                    <br />
                                    <asp:LinkButton ID="LinkButton_DelPic2" runat="server" 
                                        onclick="LinkButton_DelPic2_Click" Enabled="False">附圖2</asp:LinkButton>
                                    </b></span>
                                    <br class="style21" />
                                    <br class="style21" />
                                    <br class="style21" />
                                    <span class="style13"><b><span class="style12">　　　&nbsp;
                                    <br />
                                    </span></b></span>
                                </td>
                                <td class="style27">
                                    <p class="style28">
                                        <span class="style13"><b><span class="style12">　</span><table 
                                            style="width: 100%">
                                            <tr>
                                                <td class="style6">
                                                    <span class="style13"><b><span class="style12">題型</span></b></span></td>
                                                <td class="style7">
                                                    <span class="style13"><b><span class="style12">：<asp:DropDownList 
                                                        ID="DropDownList7" runat="server" Height="28px" 
                                                        style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large;" Width="86px">
                                                        <asp:ListItem Value="1">選擇</asp:ListItem>
                                                        <asp:ListItem Value="2">是非</asp:ListItem>
                                                        <asp:ListItem Value="3">問答</asp:ListItem>
                                                    </asp:DropDownList>
                                                    </span></b></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style6">
                                                    <span class="style13"><b><span class="style12">答案選項總數</span></b></span></td>
                                                <td class="style7">
                                                    <span class="style13"><b><span class="style12">：<asp:TextBox ID="TextBox6" 
                                                        runat="server" Width="165px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                                        ControlToValidate="TextBox6" Display="Dynamic" 
                                                        ErrorMessage="RequiredFieldValidator" Enabled="False" 
                                                        style="font-size: large">請輸入選項數量!</asp:RequiredFieldValidator>
                                                    </span></b></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style6">
                                                    <span class="style13"><b><span class="style12">正確解答敘述</span></b></span></td>
                                                <td class="style7">
                                                    <span class="style13"><b><span class="style12">：<asp:TextBox ID="TextBox7" 
                                                        runat="server" style="font-family: 金梅樹枝美工字體; font-size: medium;"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                                        ControlToValidate="TextBox7" Display="Dynamic" 
                                                        ErrorMessage="RequiredFieldValidator" Enabled="False" 
                                                        style="font-size: large">請輸入答案敘述!</asp:RequiredFieldValidator>
                                                    </span></b></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style6">
                                                    <span class="style13"><b><span class="style12">章節</span></b></span></td>
                                                <td class="style7">
                                                    <span class="style13"><b><span class="style12">：<asp:TextBox ID="TextBox8" 
                                                        runat="server" Width="163px"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                                        ControlToValidate="TextBox8" Display="Dynamic" 
                                                        ErrorMessage="RequiredFieldValidator" style="font-size: large" 
                                                        Enabled="False">請輸入章節!</asp:RequiredFieldValidator>
                                                    </span></b></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style6">
                                                    &nbsp;</td>
                                                <td class="style7">
                                                    <span class="style13"><b><span class="style12">
                                                    &nbsp;
                                                    </span>
                                                    </b></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style6">
                                                    <span class="style13"><b><span class="style12">
                                                    <asp:Label ID="Label9" runat="server" Visible="False"></asp:Label>
                                                    </span></b></span></td>
                                                <td class="style7">
                                                    <span class="style13"><b><span class="style12">
                                                    <asp:Button ID="Button6" runat="server" BackColor="#6699FF" 
                                                        BorderColor="#999999" BorderStyle="Outset" Enabled="False" 
                                                        onclick="Button6_Click" 
                                                        style="font-family: 金梅樹枝美工字體; font-weight: 700; font-size: large;" 
                                                        Text="確定新增" />
                                                    </span></b></span>
                                                </td>
                                            </tr>
                                        </table>
                                        </b></span>
                                    </p>
                                </td>
                            </tr>
                        </table>
                        <b><span class="style13">
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                            SelectCommand="SELECT * FROM [課程]"></asp:SqlDataSource>
                        </span></b>
                    </asp:View>
                    <asp:View ID="View4" runat="server">
                        <br />
                        <span class="style30">答案編輯</span><table align="center" cellpadding="0" 
                            cellspacing="0" class="style5">
                            <tr>
                                <td>
                                    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                                        BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" 
                                        CellPadding="3" CellSpacing="2" DataKeyNames="選項編號" 
                                        DataSourceID="SqlDataSource4" 
                                        style="font-size: x-large; font-weight: 700;" EnableModelValidation="True">
                                        <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                                        <Columns>
                                            <asp:BoundField DataField="選項編號" HeaderText="選項編號" InsertVisible="False" 
                                                ReadOnly="True" SortExpression="選項編號" />
                                            <asp:BoundField DataField="題目編號" HeaderText="題目編號" SortExpression="題目編號" />
                                            <asp:BoundField DataField="答案選項敘述" HeaderText="答案選項敘述" 
                                                SortExpression="答案選項敘述" />
                                            <asp:BoundField DataField="答案選項圖檔" HeaderText="答案選項圖檔" 
                                                SortExpression="答案選項圖檔" />
                                            <asp:CheckBoxField DataField="圖或文" HeaderText="圖或文" SortExpression="圖或文" />
                                            <asp:BoundField DataField="正確解答選項" HeaderText="正確解答選項" 
                                                SortExpression="正確解答選項" />
                                            <asp:BoundField DataField="題目敘述" HeaderText="題目敘述" SortExpression="題目敘述" />
                                        </Columns>
                                        <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                                        <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <asp:Button ID="Button9" runat="server" Text="返回題目新增" 
                            onclick="Button9_Click1" BackColor="#6699FF" BorderColor="#999999" 
                            BorderStyle="Outset" Font-Size="Large" />
                    </asp:View>
                </asp:MultiView>
            </td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    DeleteCommand="DELETE FROM [題庫] WHERE [題目編號] = @題目編號" 
                    InsertCommand="INSERT INTO 題庫(課程編號, 題目敘述, 題型, 正確解答選項, 所屬章節) VALUES (@課程編號, @題目敘述, @題型, @正確解答選項, @所屬章節)" 
                    SelectCommand="SELECT 題庫.題目編號, 題庫.課程編號, 題庫.題目敘述, 題庫.題型, 題庫.正確解答選項, 題庫.所屬章節, 課程.課程名稱 FROM 題庫 INNER JOIN 課程 ON 題庫.課程編號 = 課程.課程編號 WHERE (題庫.課程編號 = @課程編號)" 
                    
                    
                    UpdateCommand="UPDATE 題庫 SET 課程編號 = @課程編號, 題目敘述 = @題目敘述, 題型 = @題型, 正確解答選項 = @正確解答選項, 所屬章節 = @所屬章節 WHERE (題目編號 = @題目編號)">
                    <SelectParameters>
                        <asp:SessionParameter Name="課程編號" SessionField="OK_CLASS" />
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
                            SelectCommand="SELECT 答案.選項編號, 答案.題目編號, 答案.答案選項敘述, 答案.答案選項圖檔, 答案.圖或文, 題庫.正確解答選項, 題庫.題目敘述 FROM 答案 INNER JOIN 題庫 ON 答案.題目編號 = 題庫.題目編號 WHERE (答案.題目編號 = @題目編號)" 
                            
                            UpdateCommand="UPDATE [答案] SET [題目編號] = @題目編號, [答案選項敘述] = @答案選項敘述, [答案選項圖檔] = @答案選項圖檔, [圖或文] = @圖或文 WHERE [選項編號] = @選項編號" 
                            DeleteCommand="DELETE FROM [答案] WHERE [選項編號] = @選項編號" 
                            
                            
                    InsertCommand="INSERT INTO [答案] ([題目編號], [答案選項敘述], [答案選項圖檔], [圖或文]) VALUES (@題目編號, @答案選項敘述, @答案選項圖檔, @圖或文)">
                            <SelectParameters>
                                <asp:SessionParameter Name="題目編號" SessionField="t_no" />
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="選項編號" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="題目編號" Type="Int32" />
                                <asp:Parameter Name="答案選項敘述" Type="String" />
                                <asp:Parameter Name="答案選項圖檔" Type="String" />
                                <asp:Parameter Name="圖或文" Type="Boolean" />
                                <asp:Parameter Name="選項編號" Type="Int32" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Name="題目編號" Type="Int32" />
                                <asp:Parameter Name="答案選項敘述" Type="String" />
                                <asp:Parameter Name="答案選項圖檔" Type="String" />
                                <asp:Parameter Name="圖或文" Type="Boolean" />
                            </InsertParameters>
                        </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style14">
                &nbsp;</td>
        </tr>
    </table>
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
    <br />
    <br />
    <br />
    </asp:Content>

