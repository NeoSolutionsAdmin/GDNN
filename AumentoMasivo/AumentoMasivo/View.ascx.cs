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
using Data2.Statics;
using System.Web.UI.WebControls;
using System.Data;
using Data2.Class;
using System.Collections.Generic;

namespace Christoc.Modules.AumentoMasivo
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from AumentoMasivoModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : AumentoMasivoModuleBase, IActionable
    {


        private void LlenarProveedores()
        {
            

            if (cmbProveedor.Items.Count == 0)
            {
                DataTable DT = Data2.Connection.D_Supplier.Get_AllNames(Conversion.ObtenerLocal(UserId));
                if (DT != null)
                {
                    for (int a = 0; a < DT.Rows.Count; a++)
                    {
                        string t_id = DT.Rows[a]["Id"].ToString();
                        string t_Nombre = DT.Rows[a]["Nombre"].ToString();
                        string t_NombreFantasia = DT.Rows[a]["NombreFantasía"].ToString();
                        ListItem t_LI = new ListItem(t_Nombre + "|" + t_NombreFantasia, t_id);
                        cmbProveedor.Items.Add(t_LI);
                    }
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                LlenarProveedores();
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

        protected void cmbProveedor_TextChanged(object sender, EventArgs e)
        {
            Session.Remove("CurrentProvider");
            Session.Remove("Provider");
            int idprovider = int.Parse(cmbProveedor.SelectedValue.ToString());
            Data2.Class.Struct_Supplier S = new Struct_Supplier(Conversion.ObtenerLocal(UserId), idprovider);
            Session.Add("Provider",S);
            List<Struct_Producto> SP = Struct_Producto.SearchProducto(Conversion.ObtenerLocal(UserId), "%%%%", Data2.Connection.D_Articles.SearchCondition.PorDescripcion, idprovider);
            if (SP!=null && SP.Count > 0) { 
           Session.Add("CurrentProvider", SP);
            
           
            }

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Session["CurrentProvider"] != null)
            {
                List<Struct_Producto> ListaProductos = Session["CurrentProvider"] as List<Struct_Producto>;

                if (txtGanancia.Text.Length > 0)
                {

                    bool gan = false;
                    decimal Ganancia = 0;
                    try
                    {
                        Ganancia = decimal.Parse(txtGanancia.Text);
                        gan = true;
                    }
                    catch (Exception E) { }
                    if (gan == true)
                    {

                        foreach (Struct_Producto p in ListaProductos)
                        {
                            p.PorcentajeGanancia = Ganancia;
                            



                        }

                    }



                }
                if (txtPrecioNeto.Text.Length > 0)
                {
                    bool net = false;
                    decimal netopercent = 0;
                    try
                    {
                        netopercent = decimal.Parse(txtPrecioNeto.Text);
                        net = true;
                    }
                    catch (Exception E) { }
                    if (net == true)
                    {
                        foreach (Struct_Producto p in ListaProductos)
                        {
                            p.PrecioNeto = ((p.PrecioNeto * netopercent) / 100) + p.PrecioNeto;
                            
                        }
                    }
                }
                foreach (Struct_Producto p in ListaProductos)
                {
                    p.Recalcular();
                    p.ActualizarPrecios();


                }

                Session.Remove("CurrentProvider");

                Session.Remove("Provider");
                txtGanancia.Text="";
                txtPrecioNeto.Text="";
                cmbProveedor_TextChanged(null, null);
                

            }
        }
    }
}