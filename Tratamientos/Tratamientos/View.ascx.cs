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
using Data2.Class;
using Data2.Statics;
using System.Collections.Generic;

namespace Christoc.Modules.Tratamientos
{
    public partial class View : TratamientosModuleBase, IActionable
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Session.Remove("IdLocal");
                Session.Add("IdLocal", Data2.Statics.Conversion.ObtenerLocal(UserId));
            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }


            //hay una variable de sesion que contenga un tratamiento?
            if (Session["TratamientoSession"]!=null )
            {
                if (!IsPostBack)
                {
                    //hay un tratamiento: llenar campos desde la variable session
                    //transformar la variable session en un objeto
                    Struct_Treatment TratamientoSession;
                    TratamientoSession = Session["TratamientoSession"] as Struct_Treatment;

                    //llenar los campos desde tratamiento
                    NombreTratamientoTextBox.Text = TratamientoSession.Nombre;
                    DescripcionTratamientoTextBox.Text = TratamientoSession.Descripcion;
                    CostoTratamientoTextBox.Text = TratamientoSession.Precio.ToString();
                    // TODO: Recuperar Sesiones ( Losha)
                }
                

            }
            

            if (Request["EditTreat"] != null)
            {
                int TreatId = int.Parse(Request["EditTreat"]);
                
                Struct_Treatment TreatAEditar = Struct_Treatment.GetTreatmentById(TreatId);
                if (TreatAEditar != null)
                {
                    Session.Add("TratamientoSession", TreatAEditar);
                    Response.Redirect("./");
                }

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

        
            
protected void GuardarButton_Click(object sender, EventArgs e)
        {

            //declaraciones
            string nombre_tratamiento;
            string descripcion_tratamiento;
            string sesiones;
            int costo_tratamiento;
            DateTime fecha;

            //levantar contenidos del form a variables
            nombre_tratamiento = NombreTratamientoTextBox.Text;
            descripcion_tratamiento = DescripcionTratamientoTextBox.Text;
            costo_tratamiento = Convert.ToInt32(CostoTratamientoTextBox.Text);
            sesiones = TratamientosHiddenField.Value;

            fecha = DateTime.Now; //levantar fecha en que se creo el tratamiento

            if (Session["TratamientoSession"] == null)
            {
                // crear objeto tratamiento y rellenarlo con los datos del form
                Struct_Treatment tratamiento = new Struct_Treatment(Conversion.ObtenerLocal(UserId), nombre_tratamiento, costo_tratamiento, descripcion_tratamiento, fecha, fecha, true);

                tratamiento.Guardar();  //llamar a la funcion de guardado del objeto

                //Guardado de sesiones//
                sesiones = TratamientosHiddenField.Value;
                string[] SesionesAux, SesionesParametrosAux;
                SesionesAux = sesiones.Split('*');
                foreach (string i in SesionesAux)
                {
                    if (i != "")
                    {
                        SesionesParametrosAux = i.Split(',');
                        Struct_Sesiones SS = new Struct_Sesiones(tratamiento.Id,
                                                                    SesionesParametrosAux[0],
                                                                    int.Parse(SesionesParametrosAux[2]),
                                                                    int.Parse(SesionesParametrosAux[3]),
                                                                    SesionesParametrosAux[1]);

                        SS.Guardar();
                        Response.Redirect("./");
                    }
                }
            }
            else
            {
                Struct_Treatment ET = Session["TratamientoSession"] as Struct_Treatment;
                ET.Nombre = nombre_tratamiento;
                ET.Descripcion = descripcion_tratamiento;
                ET.Precio = costo_tratamiento;
                ET.Actualizar();
                Session.Remove("TratamientoSession");
                Response.Redirect("./");

            }

        }

        //machete de uso de session
        //Session.Add("NombreDeVariable", Value)
        //value = (int)Session["NombreDeVariable"];
        //operacion = (string)Session["operacion"];

        

    }
}