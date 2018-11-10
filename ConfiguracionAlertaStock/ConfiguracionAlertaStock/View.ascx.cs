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
using System.Web.UI.HtmlControls;

namespace Christoc.Modules.ConfiguracionAlertaStock
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from ConfiguracionAlertaStockModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : ConfiguracionAlertaStockModuleBase, IActionable
    {

        private void adduser(int iduser)
        {
            Data2.Class.Struct_UserConfig.AgregarUsuarioAlerta(iduser);
            Response.Redirect("./");
        }

        private void addprod(int idprod)
        {
          Data2.Class.Struct_Producto P =   Data2.Class.Struct_Producto.Get_SingleArticle(Data2.Statics.Conversion.ObtenerLocal(UserId), idprod);
            if (P != null)
            {
                P.AgregarAlerta(1m);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {


            LocalId.Value = Data2.Statics.Conversion.ObtenerLocal(UserId).ToString();

            try
            {

                if (Request["addprod"] != null)
                {
                    int prod = int.Parse(Request["addprod"].ToString());
                    addprod(prod);
                }
                

                if (Request["adduser"] != null)
                {
                    int iduser = int.Parse(Request["adduser"].ToString());
                    adduser(iduser);
                    
                    
                }

                //loadear users de bd hacia la tabla de users 

                System.Collections.ArrayList ListaDeUsuarios = DotNetNuke.Entities.Users.UserController.GetUsers(0);

                for (int i = 0; i < ListaDeUsuarios.Count; i++)
                {
                    DotNetNuke.Entities.Users.UserInfo InfoUsuario;
                    InfoUsuario = ListaDeUsuarios[i] as DotNetNuke.Entities.Users.UserInfo;

                    String NombreUsuario = InfoUsuario.Username;
                    String IdUsuario = InfoUsuario.UserID.ToString();

                    HtmlGenericControl Fila = new HtmlGenericControl("tr");
                    HtmlGenericControl ColumnaNombreUser= new HtmlGenericControl("td");
                  


                    ColumnaNombreUser.InnerText = NombreUsuario;
                    
                    Fila.Attributes.Add("Onclick", "AgregarUsuario(" + IdUsuario  +  ")");
                    Fila.Controls.Add(ColumnaNombreUser);
                    
                   

                    TablaD.Controls.Add(Fila);


                }





                {

        }

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