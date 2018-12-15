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
using System.Data;
using System.Collections.Generic;

namespace Christoc.Modules.ConsumoLocalStock
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from ConsumoLocalStockModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : ConsumoLocalStockModuleBase, IActionable
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            url.Value = DotNetNuke.Common.Globals.NavigateURL();    //URL de la página pasado al .ascx
            int idL = Data2.Statics.Conversion.ObtenerLocal(UserId);    //Obtiene el ID del Usuario logueado
            id.Value = idL.ToString();  //ID del Usuario pasado al .ascx
            Data2.Class.Struct_Producto ST; //Instancia objeto Producto
            int agregarNuevo = 0;

            //Se fija los parámetros de la URL para comenzar
            if (Request["ids"] != null)
            {
                
                //Como existe el parámetro, agrega los id necesarios a un array de string
                string[] ids = Request["ids"].Split('*');   //ids[0] = "IdStock"; ids[1] = stock
                                                            //ids[2] = "IdTratamiento"; ids[3] = tratamiento


                ST = Data2.Class.Struct_Producto.Get_SingleArticle(idL, int.Parse(ids[1]));
                List<Data2.Class.Struct_ConsumoLocalStock> LSCLS =
                    Data2.Class.Struct_ConsumoLocalStock.getStockTratamientoByIdTratamiento(
                        idL,
                        int.Parse(ids[3]));
                if(LSCLS != null)
                {
                    foreach (Data2.Class.Struct_ConsumoLocalStock SCLS in LSCLS)
                    {
                        if (SCLS.idArticulo == int.Parse(ids[1]) &&
                            SCLS.idUser == idL &&
                            SCLS.idArticulo == int.Parse(ids[3]))
                        {
                            if (SCLS.cantINT == 0)
                            {
                                decimal cantDEC = decimal.Parse(Request["cantDEC"]);
                                Data2.Class.Struct_ConsumoLocalStock.updateStockTratamientoCantidad(
                                    idL,
                                    int.Parse(ids[1]),
                                    0,
                                    (SCLS.cantDEC + cantDEC));
                                ST.UpdateStock((ST.CantidadDEC - cantDEC).ToString());
                            }
                            if (SCLS.cantINT != 0)
                            {
                                int cantINT = int.Parse(Request["cantINT"]);
                                Data2.Class.Struct_ConsumoLocalStock.updateStockTratamientoCantidad(
                                    idL,
                                    int.Parse(ids[1]),
                                    (SCLS.cantINT + cantINT),
                                    0);
                                ST.UpdateStock((ST.CantidadINT - cantINT).ToString());
                                
                            }

                        }
                        else
                        {
                            if (Request["cantDEC"] != null)
                            {
                                decimal cantDEC = decimal.Parse(Request["cantDEC"].ToString());
                                Data2.Class.Struct_ConsumoLocalStock StructCLS =
                                    new Data2.Class.Struct_ConsumoLocalStock(idL, int.Parse(ids[1]), 0, cantDEC, int.Parse(ids[3]));

                                ST.UpdateStock((ST.CantidadDEC - cantDEC).ToString());


                            }
                            if (Request["cantINT"] != null)
                            {
                                int cantINT = int.Parse(Request["cantINT"].ToString());
                                Data2.Class.Struct_ConsumoLocalStock StructCLS =
                                    new Data2.Class.Struct_ConsumoLocalStock(idL, int.Parse(ids[1]), cantINT, 0, int.Parse(ids[3]));
                                ST.UpdateStock((ST.CantidadINT - cantINT).ToString());

                            }
                        }

                    }
                }            
                if(LSCLS == null )
                {
                    if (Request["cantDEC"] != null)
                    {
                        decimal cantDEC = decimal.Parse(Request["cantDEC"].ToString());
                        Data2.Class.Struct_ConsumoLocalStock StructCLS =
                            new Data2.Class.Struct_ConsumoLocalStock(idL, int.Parse(ids[1]), 0, cantDEC, int.Parse(ids[3]));

                        ST.UpdateStock((ST.CantidadDEC - cantDEC).ToString());


                    }
                    if (Request["cantINT"] != null)
                    {
                        int cantINT = int.Parse(Request["cantINT"].ToString());
                        Data2.Class.Struct_ConsumoLocalStock StructCLS =
                            new Data2.Class.Struct_ConsumoLocalStock(idL, int.Parse(ids[1]), cantINT, 0, int.Parse(ids[3]));
                        ST.UpdateStock((ST.CantidadINT - cantINT).ToString());

                        agregarNuevo = 0;
                    }
                }

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