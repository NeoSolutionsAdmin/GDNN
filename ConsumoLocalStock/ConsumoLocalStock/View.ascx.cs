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
using Data2.Class;
using Data2.Connection;

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
            
            //Se fija los parámetros de la URL para comenzar para marcar como CONSUMIDO
            



            //Se fija los parámetros de la URL para comenzar para AGREGAR
            if (Request["ids"] != null)
            {
                
                //Como existe el parámetro, agrega los id necesarios a un array de string
                string[] idsRaw = Request["ids"].Split('*');    //ids[0] = "IdStock"; ids[1] = stock
                                                                //ids[2] = "IdTratamiento"; ids[3] = tratamiento

                int[] ids = new int[2]; //Crea un array de ENTEROS para reemplazar al array de strings                        
                //ASIGNA los valores del idsRaw al nuevo array
                ids[0] = int.Parse(idsRaw[1]);
                ids[1] = int.Parse(idsRaw[3]);

                //Crea las cantidades (entera y decimal)
                decimal cantDEC = 0;
                int cantINT = 0;
                bool isdecimal = false;
                Struct_Producto SP; //Instancia objeto Producto (va a contener todas las propiedades
                                    //que se van a usar)

                
                //Se asignan las cantidades dependiendo si el parámetro existe o no
                if (Request["cantDEC"] != null)
                {
                    cantDEC = decimal.Parse(Request["cantDEC"]);
                    isdecimal = true;
                }
                else
                {
                    cantINT = int.Parse(Request["cantINT"]);
                    isdecimal = false;
                }

                //Se llena el objeto por los parámetros que se asignan en el View.ascx
                SP = Struct_Producto.Get_SingleArticle(idL, ids[0]);

                //Se llena una lista con las filas de la tabla StockTratamiento
                List<Struct_ConsumoLocalStock> LSCLS =
                    Struct_ConsumoLocalStock.getStockTratamientoByIdTratamiento(
                        idL,
                        ids[1]);

                bool coincidencia = false;

                //Si la lista es null
                if(LSCLS != null)
                {
                    foreach (Struct_ConsumoLocalStock SCLS in LSCLS)
                    {

                        if (SCLS.idArticulo == ids[0] &&
                            SCLS.idUser == idL &&
                            SCLS.idTratamiento == ids[1])
                        {
                            coincidencia = true;
                            acumularStock(cantDEC, cantINT, idL, ids, SCLS, SP);
                            break;
                        }
                    }
                    if (coincidencia == false)
                    {
                        crearNuevaFilaStock(cantDEC, cantINT, idL, ids, SP, isdecimal);
                    }                                                                       
                }            
                else
                {
                    crearNuevaFilaStock(cantDEC,cantINT,idL,ids,SP,isdecimal);
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

        /// <summary>
        /// Agrega una nueva fila en caso de que no haya nada en la tabla
        /// </summary>
        /// <param name="cantDEC">Cantidad a ingresar en DECIMAL</param>
        /// <param name="cantINT">Cantidad a ingresar en ENTERO</param>
        /// <param name="idL">ID de Usuario/Local</param>
        /// <param name="ids">Array de entero de los ids de stock y tratamiento</param>
        /// <param name="SP">Objeto Struct_Producto. Se sacan varias propiedades de ahí</param>
        void crearNuevaFilaStock(
            decimal cantDEC,
            int cantINT,
            int idL,
            int[] ids,
            Struct_Producto SP,
            bool isdecimal)
        {
            //Se fija que unidad se debe usar para ingresar datos
            if (isdecimal == true)
            {
                //Se instancia un objeto con el constructor que ingresa los datos en la tabla
                Struct_ConsumoLocalStock StructCLS =
                            new Struct_ConsumoLocalStock(idL,
                            ids[0],
                            0,
                            cantDEC,
                            ids[1]);

                //Se actualiza la cantidad del artículo en la tabla de Artículos
                SP.UpdateStock((SP.CantidadDEC - cantDEC).ToString());

                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL());
            }
            //Si es que no se usa la unidad ENTERA...
            else
            {
                Struct_ConsumoLocalStock StructCLS =
                            new Struct_ConsumoLocalStock(
                                idL,
                                ids[0],
                                cantINT,
                                0,
                                ids[1]);

                SP.UpdateStock((SP.CantidadINT - cantINT).ToString());

                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL());
            }
        }
        /// <summary>
        /// En vez de agregar una nueva fila, se actualiza la cantidad que tiene un stock previamente asociado
        /// </summary>
        /// <param name="cantDEC">Cantidad a añadir en DECIMAL</param>
        /// <param name="cantINT">Cantidad a añadir en ENTERO</param>
        /// <param name="idL">ID de Usuario/Local</param>
        /// <param name="ids">Array de entero de los ids de stock y tratamiento</param>
        /// <param name="SCLS">Objeto Struct_ConsumoLocalStock. Se sacan varias propiedades para proceder</param>
        /// <param name="SP">Objeto Struct_Producto. Se sacan varias propiedades para proceder</param>
        void acumularStock(decimal cantDEC,
            int cantINT,
            int idL,
            int[] ids,
            Struct_ConsumoLocalStock SCLS,
            Struct_Producto SP)
        {
            //Se fija que unidad usa el objeto Struct_ConsumoLocalStock
            if(SCLS.cantINT == 0)
            {
                //Actualiza la cantidad de stock en la tabla StockTratamiento
                Struct_ConsumoLocalStock.updateStockTratamientoCantidad(
                                    idL,
                                    ids[0],
                                    0,
                                    (SCLS.cantDEC  + cantDEC));
                //Actualiza la cantidad de stock en la tabla Artículos
                SP.UpdateStock((SP.CantidadDEC - cantDEC).ToString());

                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL());
            }
            //Si no se usa la cantidad en ENTERO...
            else
            {
                Struct_ConsumoLocalStock.updateStockTratamientoCantidad(
                                    idL,
                                    ids[0],
                                    (SCLS.cantINT + cantINT),
                                    0);
                SP.UpdateStock((SP.CantidadINT - cantINT).ToString());

                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL());
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