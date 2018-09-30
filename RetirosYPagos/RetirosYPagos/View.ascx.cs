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

namespace Christoc.Modules.RetirosYPagos
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from RetirosYPagosModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : RetirosYPagosModuleBase, IActionable
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            

            /*try
            {

            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }*/
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

        private void cleanFields()
        {
            txt_ConceptoPago.Text = "";
            txt_MontoPago.Text = "";
            txtMontoRetiro.Text = "";
            txt_ConceptoRetiro.Text = "";
        }

        protected void btngenerarPago_Click(object sender, EventArgs e)
        {
            Data2.Class.Struct_Pago P = new Data2.Class.Struct_Pago(UserId, int.Parse(IDS.Value), DateTime.Now, Data2.Statics.Conversion.GetDecimal(txt_MontoPago.Text), txt_ConceptoPago.Text);
            bool success = P.Guardar();
            if (success == true)
            {
                ConfirmationWindow.Value = "Su pago fue registrado...";
                cleanFields();
            }
            else
            {
                ConfirmationWindow.Value = "Su pago no fue registrado en el sistema, contacte con soporte tecnico";
                cleanFields();
            }
        }

        
        protected void btngenerarRetiro_Click(object sender, EventArgs e)
        {
            Data2.Class.Struct_Retiro P = new Data2.Class.Struct_Retiro(UserId, int.Parse(IDS.Value), DateTime.Now, Data2.Statics.Conversion.GetDecimal(txtMontoRetiro.Text), txt_ConceptoRetiro.Text);
            bool success = P.Guardar();
            if (success == true)
            {
                ConfirmationWindow.Value = "Su retiro fue registrado...";
                cleanFields();
            }
            else
            {
                ConfirmationWindow.Value = "Su retiro no fue registrado en el sistema, contacte con soporte tecnico";
                cleanFields();
            }
        }
    }
}