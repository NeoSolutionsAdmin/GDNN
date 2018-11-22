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

namespace Christoc.Modules.InformeMensualVentas
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from InformeMensualVentasModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : InformeMensualVentasModuleBase, IActionable
    {
        int id_User;
        DateTime start;
        DateTime end;
        List<Data2.Class.Struct_Factura> SF = new List<Data2.Class.Struct_Factura>();


        protected void Page_Load(object sender, EventArgs e)
        {
            URL.Value = DotNetNuke.Common.Globals.NavigateURL();
            Session.Remove("SF");
            try
            {

            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }

            id_User = Data2.Statics.Conversion.ObtenerLocal(UserId);
            if (Request["fechaI"] != null &&
                Request["fechaO"] != null)
            {
                start = DateTime.Parse(Request["fechaI"]);
                end = DateTime.Parse(Request["fechaO"]);
                SF = Data2.Class.Struct_Factura.GetFacturasBetweenDates(start, end, id_User, false, Data2.Class.Struct_Factura.TipoDeFactura.Null);
                if (SF != null) Session.Add("SF", SF);
                //Response.Redirect(DotNetNuke.Common.Globals.NavigateURL());

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