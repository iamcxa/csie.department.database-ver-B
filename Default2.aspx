<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default2.aspx.vb" Inherits="Default2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <script src="../javascripts/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../javascripts/jquery.curvycorners.min.js" type="text/javascript"></script>
    <script src="../javascripts/corner.js" type="text/javascript"></script>
    <script src="../javascripts/wait.js" type="text/javascript"></script>
    <script src="../javascripts/T-display.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="../style.css" />
    <style type="text/css">

        .Main
        {
              margin-top: -0px;

            }
        .container2
        {
            
            background: #FFFFFF;
            height: 100%;
            width: 1000px; /* 這樣將會建立為 80% 瀏覽器寬度的容器 */
            background-repeat: no-repeat;
                        background-position: 50% 0%;
            background-attachment:  fixed    ;

            background-image: url(   './images/bg.jpg' );
            margin: 0 auto; /* 自動邊界 (搭配寬度) 會讓頁面置中對齊 */
            border: 1px solid #CCCCCC;
            text-align: left; /* 這樣做會覆寫 Body 元素上的 text-align: center。 */
            
             
        }
        

        .style6
        {
            width: 912px;
        }
        

        .style5
        {
            width: 100%;
        }


        .style7
        {
            width: 606px;
        }


            .style64
        {
            text-align: center;
            font-family: Corbel;
            font-size: 12px;
            color: #FFFFFF;
        }
        
        
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <div id="Main" class="Main">
        <div id="container2" class ="container2">
            <div id="mainContent">
                            <table style="width: 100%;">
                                <tr>
                                    <td style="border-bottom: 1px solid #C0C0C0; height: 30px; text-align: center;">
                                        <asp:Label ID="Label_notice" runat="server" Font-Bold="True" ForeColor="Red" Font-Size="XX-Large">學生資料列表</asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <div id="Div_UpdateProgress" style="width: 100%; height: 20px; margin-right: auto;
                                position: static;">
                                <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0">
                                    <ProgressTemplate>
                                        <div style="text-align: center;">
                                            <img alt="loading" src="images/ajax-loader.gif" /></div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </div>
                            <div id="MutiView">
                                <asp:MultiView ID="MultiView_Notice" runat="server">
                                </asp:MultiView>
                                <asp:MultiView ID="MultiView_Main" runat="server" ActiveViewIndex="0">
                                 
                                    <asp:View ID="View_ADDNotice" runat="server">
                                        
                                    
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
    
    </div>
    </form>
    
    <div class="style64">
        - Powered-by-許鈞霆/陳獻欽/陳紀緯-©2011-CSU-CSIE - 99學年度學生專題 -
    </div>
    </body>
</html>
