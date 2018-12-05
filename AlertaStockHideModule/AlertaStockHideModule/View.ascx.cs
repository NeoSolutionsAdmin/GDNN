/*
' Copyright (c) 2018  Christoc.com
'  All rights reserved.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
' TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
' THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
' CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
' DEALINGS IN THE SOFTWARE.
' 
*/

using System;
using DotNetNuke.Security;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Modules.Actions;
using DotNetNuke.Services.Localization;
using System.Collections.Generic;
using Data2.Class;
using System.Net.Mail;
using DotNetNuke.Entities.Users;
using DotNetNuke.Services.Social.Messaging;

namespace Christoc.Modules.AlertaStockHideModule
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from AlertaStockHideModuleModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : AlertaStockHideModuleModuleBase, IActionable
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            
            SmtpClient Cliente = new SmtpClient();
            Cliente.DeliveryMethod = SmtpDeliveryMethod.Network;
            Cliente.EnableSsl = true;
            Cliente.Host = DotNetNuke.Common.Utilities.Config.GetSetting("Mail_Host"); 
            Cliente.Port = int.Parse(DotNetNuke.Common.Utilities.Config.GetSetting("Mail_Port"));
            string mail = DotNetNuke.Common.Utilities.Config.GetSetting("Mail_From");
            string password = DotNetNuke.Common.Utilities.Config.GetSetting("Mail_Password");
            System.Net.NetworkCredential credentials = new System.Net.NetworkCredential(mail, password);
            Cliente.Credentials = credentials;

           
           

            List<Data2.Class.Struct_AlertaProducto> P = Data2.Class.Struct_AlertaProducto.GetAllProducts();
            if (P != null && P.Count > 0)
            {
                foreach (Struct_AlertaProducto p in P)
                {
                    int currentstock = p.getProducto().CantidadINT;
                    if (p.MinCant >= currentstock)
                    {
                        MailMessage MM = new MailMessage();
                        MM.IsBodyHtml = true;
                        MM.Body += "<div>Stock Critico en el producto:" + p.getProducto().Descripcion + "</div>";
                        MM.Body += "Cantidad Actual:" + p.getProducto().CantidadINT;
                        MM.From = new MailAddress(mail,"Bryz Spa");
                        MM.Subject = "Stock Critico";

                        DotNetNuke.Services.Social.Messaging.Message Message = new DotNetNuke.Services.Social.Messaging.Message();
                        Message.Body+= "Stock Critico en el producto:" + p.getProducto().Descripcion;
                        Message.Body+= "Cantidad Actual:" + p.getProducto().CantidadINT;
                        Message.Subject += "Stock Critico";

                        List<UserInfo> ListaUsuarios = new List<UserInfo>();

                        List<Data2.Class.Struct_AlertaUsuario> U = Struct_AlertaUsuario.GetUsuarios();
                        if (U != null && U.Count > 0)
                        {
                            foreach (Struct_AlertaUsuario u in U)
                            {
                                string email = u.email;
                                
                                Cliente.UseDefaultCredentials = false;
                                Cliente.Credentials = credentials;
                                MailAddress MA = new MailAddress(email,"Bryz SPA");
                                MM.To.Add(MA);
                                ListaUsuarios.Add(UserController.GetUserById(0, u.Id));


                            }
                        }
                        if (MM.To != null && MM.To.Count > 0)
                        {
                            MessagingController.Instance.SendMessage(Message, null, ListaUsuarios, null, this.UserInfo);
                        
                        Cliente.Send(MM);
                        }
                    }

                }
            }


            if (this.EditMode == true)
            {

            }

            

            try
            {

            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        public ModuleActionCollection ModuleActions
        {
            get
            {
                var actions = new ModuleActionCollection
                    {
                        {
                            GetNextActionID(), Localization.GetString("EditModule", LocalResourceFile), "", "", "",
                            EditUrl(), false, SecurityAccessLevel.Edit, true, false
                        }
                    };
                return actions;
            }
        }
    }
}