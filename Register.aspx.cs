using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Net.Mail;
using System.Net.Mime;
using System.Net;
using System.Web.Security;
using System.Data.SqlClient;
using System.Configuration;
public partial class Register : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cn"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindDOB();
            BindDetails();
            statedd_bind();
        }
    }

    //Display All The Schools
    public void BindDetails()
    {
        School.Registration obj = new School.Registration();

        DataSet ds = obj.DisplayCustomRegDet();

        //Bind Schools
        DropDownListSchool.DataTextField = "schname";
        DropDownListSchool.DataValueField = "schid";
        DropDownListSchool.DataSource = ds.Tables[0];
        DropDownListSchool.DataBind();
        DropDownListSchool.Items.Insert(0, new ListItem("Select Your School", ""));
        DropDownListState.Items.Insert(0, new ListItem("select your state", ""));
        DropDownListState.Items.Insert(0, new ListItem("select you city", ""));
        //Bind Classes
        DropDownListClass.DataTextField = "clsnam";
        DropDownListClass.DataValueField = "clsid";
        DropDownListClass.DataSource = ds.Tables[1];
        DropDownListClass.DataBind();
        DropDownListClass.Items.Insert(0, new ListItem("Select Your Class", ""));

        //Bind Sections
        DropDownListSection.DataTextField = "secnam";
        DropDownListSection.DataValueField = "secid";
        DropDownListSection.DataSource = ds.Tables[2];
        DropDownListSection.DataBind();
        DropDownListSection.Items.Insert(0, new ListItem("Select Your Section", ""));

        ds.Dispose();
        ds = null;
    }

    //Bind DOB
    public void BindDOB()
    {
        for (int i = 1; i <= 31; i++)
        {
            DropDownListDay.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }
        DropDownListDay.Items.Insert(0, new ListItem("Date", ""));

        for (int i = 1995; i <= 2012; i++)
        {
            DropDownListYear.Items.Add(new ListItem(i.ToString()));
        }
        DropDownListYear.Items.Insert(0, new ListItem("Year", ""));
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //Validating Captcha Code
        if (MyCaptcha1.IsValid)
        {
            if (txtStuName.Text != string.Empty)
            {
                if (DropDownListSchool.SelectedItem.Text != "Select Your School")
                {
                    if (DropDownListClass.SelectedItem.Text != "Select Your Class")
                    {
                        if (DropDownListSection.SelectedItem.Text != "Select Your Section")
                        {
                            if (txtEmail.Text != "")
                            {
                                if (txtPassword.Text != "")
                                {
                                    if (txtConfirm.Text != "")
                                    {
                                        int ret = School.Registration.EmailCheck(txtEmail.Text);
                                      
                                        if (ret == 0)
                                        {
                                            RegisterStudent();

                                            lblcaptchaerror.Text = "You have been successfully registered with Edurev";
                                            lblcaptchaerror.Visible = true;

                                            //Send Email to the User
                                            SendEmail();

                                            //Clear All the Fields
                                            ClearFields();

                                            Response.Redirect("Thank You/confirmRegister.aspx?e=" + ViewState["email"].ToString());
                                        }
                                        else
                                        {
                                            lblcaptchaerror.Text = "User with the same email has already been registered";
                                            lblcaptchaerror.Visible = true;
                                        }
                                    }
                                    else
                                    {
                                        lblError.Text = "Please Enter The Confirm Password";
                                        lblError.Visible = true;
                                        lblcaptchaerror.Visible = false;
                                    }
                                }
                                else
                                {
                                    lblError.Text = "Please Enter The Password";
                                    lblError.Visible = true;
                                    lblcaptchaerror.Visible = false;
                                }
                            }
                            else
                            {
                                lblError.Text = "Please Enter Your Email Address";
                                lblError.Visible = true;
                                lblcaptchaerror.Visible = false;
                            }
                        }
                        else
                        {
                            lblError.Text = "Please Select Your Section";
                            lblError.Visible = true;
                            lblcaptchaerror.Visible = false;
                        }
                    }
                    else
                    {
                        lblError.Text = "Please Select Your Class";
                        lblError.Visible = true;
                        lblcaptchaerror.Visible = false;
                    }
                }
                else
                {
                    lblError.Text = "Please Select Your School";
                    lblError.Visible = true;
                    lblcaptchaerror.Visible = false;
                }
            }
            else
            {
                lblError.Text = "Please Enter Your Name";
                lblError.Visible = true;
                lblcaptchaerror.Visible = false;
            }
        }

        else
        {
            lblError.Visible = false;
            lblcaptchaerror.Text = "Please Verify the code or refresh it to enter new code again.";
            lblcaptchaerror.Visible = true;
        }

    }

    //Method for Registering a New Student
    private void RegisterStudent()
    {
        School.RegistrationProp k = new School.RegistrationProp();
        k.name = txtStuName.Text;
        k.school = Convert.ToInt32(DropDownListSchool.SelectedValue);
        k.cls = Convert.ToInt32(DropDownListClass.SelectedValue);
        k.section = Convert.ToInt32(DropDownListSection.SelectedValue);
        k.dob = Convert.ToDateTime(DropDownListMonth.SelectedValue.ToString() + "/" + DropDownListDay.SelectedValue.ToString() + "/" + DropDownListYear.SelectedValue.ToString());
        k.email = txtEmail.Text;
        k.pwd = txtPassword.Text;
        k.state = DropDownListState.SelectedValue.ToString();
        k.city = DropDownListCity.SelectedValue.ToString();
        k.cityCode = Convert.ToInt32(DropDownListCity.SelectedValue);
        k.genderCode = RadioButtonListGender.SelectedValue;

        if (txtRollNo.Text == String.Empty)
        {
            k.rollno = Convert.ToInt32(0);
        }
        else
        {
            k.rollno = Convert.ToInt32(txtRollNo.Text);
        }

        k.contact = txtContactNumber.Text;
        k.guid = Guid.NewGuid().ToString();
        ViewState["code"] = k.guid;
        ViewState["email"] = k.email;
       
        School.Registration obj = new School.Registration();
        Application.Lock();
        obj.NewMember(k);
        Application.UnLock();
        
    }

    //Method for Clearing all the fields
    public void ClearFields()
    {
        txtStuName.Text = String.Empty;
        //DropDownListSchool.Items.FindByText("Select Your School").Selected = true;
        //DropDownListClass.Items.FindByText("Select Your Class").Selected = true;
        //DropDownListSection.Items.FindByText("Select Your Section").Selected = true;
        txtRollNo.Text = String.Empty;
        //DropDownListDay.Items.FindByText("Date").Selected = true;
        //DropDownListMonth.Items.FindByText("Month").Selected = true;
        //DropDownListYear.Items.FindByText("Year").Selected = true;
        txtEmail.Text = String.Empty;
        //txtPassword.Text = String.Empty;
        //txtConfirm.Text = String.Empty;
        txtStuName.Focus();
    }

    //Method for Sending Email to the User
    private void SendEmail()
    {


        String messageBody1 = "Dear " + txtStuName.Text + ",<br/><br/>";

        String messageBody2 = "We are pleased to register you for the biggest quiz in the Tri-City area.<br/><br/>";

        String messageBody3 = "This is an opportunity to not only exploit your thinking cells, but " +
                              "also to discover your inherent talent. This quiz is a first of its " +
                              "kind (online quiz), where you will be tested on various levels to " +
                              "bring out your true potential. We believe that each child is unique " +
                              "and is capable of much more than simply following the prescribed " +
                              "curriculum, hence an initiative to bring out the true YOU!<br/><br/>";

        String messageBody4 = "To activate that account you can click on the link below or copy and" +
                              "paste the link in your browser's address bar<br/>";

        String messageActCode = ViewState["code"].ToString();
        String email = ViewState["email"].ToString();

        String messageLink = "<a href=http://www.quiz.edurev.in/confirm/confirm.aspx?e=" + email + "&c=" + messageActCode + " target=_blank>" + "http://www.quiz.edurev.in/confirm/confirm.aspx?e=" + email + "&c=" + messageActCode + "</a><br/><br/>";

        String messageBody5 = "Students are advised to go through the quiz details at link to quiz info<br/><br/>";

        String messageBody6 = "We welcome any suggestion or feedback to help us serve you better (email: <a href=" + "mailto:admin@edurev.in" + ">admin@edurev.in</a><br/><br/>";

        String messageBody7 = "Wishing you the best.<br/><br/>We hope your experience is pure Awesome!<br/><br/>Regards,<br/><br/>EduRev Team<br/><br/><a href=www.edurev.in>www.edurev.in</a>";

        String messageBody = messageBody1 + messageBody2 + messageBody3 + messageBody4 + messageLink + messageBody5 + messageBody6 + messageBody7;

        try
        {

            //System.Net.Mail.SmtpClient mail = new System.Net.Mail.SmtpClient();
            //mail.Host = "smtp.gmail.com";
            //mail.Port = 587;
            //mail.EnableSsl = true;
            //mail.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
            //mail.Credentials = new NetworkCredential("edurevregistered@gmail.com", "harman123");
            //mail.Timeout = 20000;
            //mail.Send("edurevregistered@gmail.com", txtEmail.Text.Trim(), "Thanks for registering your account at EduRev", messageBody);


            MailMessage message = new MailMessage();
            message.From = new MailAddress("admin@edurev.in");
            message.To.Add(txtEmail.Text);
            message.Subject = "Thanks for registering your account at EduRev";
            message.IsBodyHtml = true;

            message.Body = messageBody;
            SmtpClient client = new SmtpClient();
            client.Send(message);

            client.Dispose();
        }
        catch (Exception)
        {

        }

    }


    protected void DropDownListState_SelectedIndexChanged(object sender, EventArgs e)
    {
        string reg = DropDownListState.SelectedValue.ToString();
        con.Open();
        SqlDataAdapter adp = new SqlDataAdapter("select * from tbcty where regid ='" + reg + "' ", con);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        DropDownListCity.DataSource = ds;
        
        con.Close();
        ds.Dispose();
        adp.Dispose();
        DropDownListCity.DataTextField = "city";
        DropDownListCity.DataValueField = "cityid";
        DropDownListCity.DataSource = ds.Tables[0];
        DropDownListCity.DataBind();
        DropDownListCity.Items.Insert(0, new ListItem("Select Your City", ""));
    }
    public void statedd_bind()
    {
        con.Open();
        SqlDataAdapter adp = new SqlDataAdapter("select Distinct region , regid   from tbcty", con);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        DropDownListState.DataSource = ds;

        con.Close();
        ds.Dispose();
        adp.Dispose();
        DropDownListState.DataTextField = "region";
        DropDownListState.DataValueField = "regid";
        DropDownListState.DataSource = ds.Tables[0];
        DropDownListState.DataBind();
        DropDownListState.Items.Insert(0, new ListItem("Select Your state", ""));
    }
}