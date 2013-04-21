<%@ Page Title="Registration For Edurev - The Online Quiz" Language="C#" MasterPageFile="~/RegisterMasterPage.master"
    AutoEventWireup="true" MaintainScrollPositionOnPostback="false" CodeFile="Register.aspx.cs"
    Inherits="Register" %>

<%@ Register Src="MyCaptcha.ascx" TagName="MyCaptcha" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .classname
        {
            -moz-box-shadow: inset 0px 1px 0px 0px #ffffff;
            -webkit-box-shadow: inset 0px 1px 0px 0px #ffffff;
            box-shadow: inset 0px 1px 0px 0px #ffffff;
            background-color: #ededed;
            -moz-border-radius: 6px;
            -webkit-border-radius: 6px;
            border-radius: 6px;
            border: 1px solid #dcdcdc;
            display: inline-block;
            color: #777777;
            font-family: arial;
            font-size: 15px;
            font-weight: bold;
            padding: 6px 24px;
            text-decoration: none;
            text-shadow: 1px 1px 0px #ffffff;
        }
        .classname:hover
        {
            background-color: #dfdfdf;
        }
        .classname:active
        {
            position: relative;
            top: 1px;
        }
        
        .textbox-des
        {
            height: 23px;
            width: 250px;
            -webkit-border-radius: 9px;
            -moz-border-radius: 9px;
            border-radius: 9px;
            border: 1px solid #96A4FF;
            background: rgba(181,203,255,0.1);
            padding-left: 10px;
        }
        
        .table-data
        {
            font-family: Open Sans;
            font-size: 15px;
            padding-left: 30%;
            color: #808080;
            height: 60px;
        }
        
        .focusin
        {
            height: 23px;
            width: 250px;
            -webkit-border-radius: 9px;
            -moz-border-radius: 9px;
            border-radius: 9px;
            border: 3px solid #96A4FF;
            background: rgba(181,203,255,0.6);
        }
        
        .focusout
        {
            height: 23px;
            width: 250px;
            -webkit-border-radius: 9px;
            -moz-border-radius: 9px;
            border-radius: 9px;
            border: 1px solid #96A4FF;
            background: rgba(181,203,255,0.1);
        }
        .style2
        {
            font-family: Verdana;
            font-size: 15px;
            padding-left: 30%;
            color: #808080;
            height: 35px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            var txtStuName = $("#<%=txtStuName.ClientID %>");
            var txtRollNo = $("#<%=txtRollNo.ClientID %>");
            var txtEmail = $("#<%=txtEmail.ClientID %>");
            var txtPassword = $("#<%=txtPassword.ClientID %>");
            var txtConfirm = $("#<%=txtConfirm.ClientID %>");
            var txtContactNumber = $("#<%=txtContactNumber.ClientID %>");


            txtContactNumber.focus(function () {
                txtContactNumber.addClass("focusin");
            });
            txtContactNumber.blur(function () {
                txtContactNumber.removeClass("focusin");
            });

            txtConfirm.focus(function () {
                txtConfirm.addClass("focusin");
            });
            txtConfirm.blur(function () {
                txtConfirm.removeClass("focusin");
            });





            txtPassword.focus(function () {
                txtPassword.addClass("focusin");
            });
            txtPassword.blur(function () {
                txtPassword.removeClass("focusin");
            });



            txtEmail.focus(function () {
                txtEmail.addClass("focusin");
            });
            txtEmail.blur(function () {
                txtEmail.removeClass("focusin");
            });

            txtStuName.focus(function () {
                txtStuName.addClass("focusin");
            });
            txtStuName.blur(function () {
                txtStuName.removeClass("focusin");
            });


            txtRollNo.focus(function () {
                txtRollNo.addClass("focusin");
            });
            txtRollNo.blur(function () {
                txtRollNo.removeClass("focusin");
            });
        });
    
    </script>
    <h2>
        <span style="font-family: Open Sans,sans-serif; font-size: 20px; font-weight: bold">
            Registration For Edurev</span>
    </h2>
    <hr />
   
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td class="style2">
                        <asp:Label ID="lblcaptchaerror" Visible="False" runat="server" ForeColor="Red"></asp:Label><br />
                        <asp:Label ID="lblError" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="table-data">
                        Student's Name:<br />
                        <asp:TextBox ID="txtStuName" runat="server" CssClass="textbox-des"></asp:TextBox>*<br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="This field is required."
                            ControlToValidate="txtStuName" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"
                            ValidationGroup="register"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="table-data">
                        Gender:
                        <asp:RadioButtonList ID="RadioButtonListGender" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Male" Value="M" Selected="True" />
                            <asp:ListItem Text="Female" Value="F" />
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="You must select Gender"
                            ControlToValidate="RadioButtonListGender" Display="Dynamic" ForeColor="Red" ValidationGroup="register"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="table-data">
                        Select School:<br />
                        <asp:DropDownList ID="DropDownListSchool" runat="server" 
                            >
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="table-data">
                        Select Class:<br />
                        <asp:DropDownList ID="DropDownListClass" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="table-data">
                        Select Section:<br />
                        <asp:DropDownList ID="DropDownListSection" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="table-data">
                        Enter Roll Number:<br />
                        <asp:TextBox ID="txtRollNo" runat="server" CssClass="textbox-des" ValidationGroup="register"></asp:TextBox>
                        <asp:FilteredTextBoxExtender ID="txtRollNo_FilteredTextBoxExtender" runat="server"
                            Enabled="True" TargetControlID="txtRollNo" ValidChars="0,1,2,3,4,5,6,7,8,9" FilterMode="ValidChars">
                        </asp:FilteredTextBoxExtender>
                        *<br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtRollNo"
                            Display="Dynamic" ErrorMessage="This field is required" ForeColor="Red" SetFocusOnError="True"
                            ValidationGroup="register"></asp:RequiredFieldValidator>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="table-data">
                        Select Date Of Birth:<br />
                        <asp:DropDownList ID="DropDownListDay" runat="server">
                        </asp:DropDownList>
                        &nbsp;
                        <asp:DropDownList ID="DropDownListMonth" runat="server">
                            <asp:ListItem Text="Month" Value="0" />
                            <asp:ListItem Value="1">January</asp:ListItem>
                            <asp:ListItem Value="2">Feburary</asp:ListItem>
                            <asp:ListItem Value="3">March</asp:ListItem>
                            <asp:ListItem Value="4">April</asp:ListItem>
                            <asp:ListItem Value="5">May</asp:ListItem>
                            <asp:ListItem Value="6">June</asp:ListItem>
                            <asp:ListItem Value="7">July</asp:ListItem>
                            <asp:ListItem Value="8">August</asp:ListItem>
                            <asp:ListItem Value="9">September</asp:ListItem>
                            <asp:ListItem Value="10">Octuber</asp:ListItem>
                            <asp:ListItem Value="11">November</asp:ListItem>
                            <asp:ListItem Value="12">December</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;
                        <asp:DropDownList ID="DropDownListYear" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="table-data">
                        Select State:<br />
                        <asp:DropDownList ID="DropDownListState" runat="server" AutoPostBack="True" onselectedindexchanged="DropDownListState_SelectedIndexChanged" 
                            >
                            
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="table-data">
                        Select City:<br />
                        <asp:DropDownList ID="DropDownListCity" runat="server" >
                            
                            
                        </asp:DropDownList>
                    </td>
                </tr>
                 
                <tr>
                    <td class="table-data">
                        Enter Email ID:<br />
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox-des"></asp:TextBox>*<br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="This field is required."
                            ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"
                            ValidationGroup="register"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Email"
                            ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="register"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td class="table-data">
                        Password:<br />
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="textbox-des" TextMode="Password"></asp:TextBox>*
                        <asp:PasswordStrength ID="txtPassword_PasswordStrength" runat="server" Enabled="True"
                            TargetControlID="txtPassword" PreferredPasswordLength="7">
                        </asp:PasswordStrength>
                        <br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="This field is required"
                            ControlToValidate="txtPassword" Display="Dynamic" ForeColor="Red" SetFocusOnError="True"
                            ValidationGroup="register"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="table-data">
                        Confirm Password:<br />
                        <asp:TextBox ID="txtConfirm" runat="server" CssClass="textbox-des" TextMode="Password"></asp:TextBox>*<br />
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Password doesn't match"
                            ControlToCompare="txtPassword" ControlToValidate="txtConfirm" Display="Dynamic"
                            ForeColor="Red" SetFocusOnError="True" ValidationGroup="register"></asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td class="table-data">
                        Mobile Number:<br />
                        <asp:TextBox ID="txtContactNumber" runat="server" CssClass="textbox-des"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="table-data">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <uc1:MyCaptcha ID="MyCaptcha1" runat="server" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td class="table-data">
                        <asp:Button ID="btnSubmit" ValidationGroup="register" runat="server" Text="Register"
                            CssClass="classname" OnClick="btnSubmit_Click" Font-Bold="True" />
                    </td>
                </tr>
                <tr>
                    <td class="table-data">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <img src="images-new/Big Roller.gif" alt="Alternate Text" />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </table>
            <div id="fb-root">
            </div>
            <script>                (function (d, s, id) {
                    var js, fjs = d.getElementsByTagName(s)[0];
                    if (d.getElementById(id)) return;
                    js = d.createElement(s); js.id = id;
                    js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
                    fjs.parentNode.insertBefore(js, fjs);
                } (document, 'script', 'facebook-jssdk'));</script>
            <div class="fb-like" data-href="https://www.facebook.com/TheEducationRevolution?fref=ts"
                data-send="true" data-width="450" data-show-faces="true" data-font="verdana">
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
<script type="text/javascript"><!--
google_ad_client = "ca-pub-6850899451102127";
/* left side before quiz */
google_ad_slot = "1019854833";
google_ad_width = 160;
google_ad_height = 600;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
</asp:Content>
