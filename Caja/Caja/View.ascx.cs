/*
' Copyright (c) 2019  Christoc.com
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
using DotNetNuke.Entities.Portals;
using System.Collections;
using System.Collections.Generic;
using DotNetNuke.Entities.Users;

namespace Christoc.Modules.Caja
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from CajaModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    /// 


    public class PartialUser
    {
        public int id;
        public string name;
    }

    public partial class View : CajaModuleBase, IActionable
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Remove("Id_Usuario");
            Session.Add("Id_Usuario",UserId);
            
            iduser.Value = UserId.ToString();

            List<PartialUser> Lpu = new List<PartialUser>();

            System.Collections.ArrayList ListaDeUsuarios = DotNetNuke.Entities.Users.UserController.GetUsers(DotNetNuke.Entities.Portals.PortalSettings.Current.PortalId);
            Response.Write(ListaDeUsuarios.Count.ToString());
            for (int i = 0; i < ListaDeUsuarios.Count; i++)
            {
                DotNetNuke.Entities.Users.UserInfo InfoUsuario = ListaDeUsuarios[i] as DotNetNuke.Entities.Users.UserInfo;
                PartialUser PU = new PartialUser();
                PU.id = InfoUsuario.UserID;
                PU.name = InfoUsuario.FirstName + " " + InfoUsuario.LastName;
                Lpu.Add(PU);
            }
            Session.Add("ListaUsuarios", Lpu);
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