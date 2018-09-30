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

namespace Christoc.Modules.Tratamientos
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from TratamientosModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : TratamientosModuleBase, IActionable
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }


            //hay una variable de sesion que contenga un tratamiento?
            if (Session["TratamientoSession"]!=null)
            {
                //hay un tratamiento: llenar campos desde la variable session
                //transformar la variable session en un objeto
                Struct_Treatment TratamientoSession;
                TratamientoSession = (Data2.Class.Struct_Treatment)Session["TratamientoSesion"];

                //llenar los campos desde tratamiento
                NombreTratamientoTextBox.Text = TratamientoSession.Nombre;
                DescripcionTratamientoTextBox.Text = TratamientoSession.Descripcion;
                // TODO: Recuperar Precio, Sesiones ( Losha)

                // Ya se recuperaron los datos, desaparecer la variable Session
                Session.Remove("TratamientoSession");
                //recargar la pagina
                Response.Redirect("./");
            }
            else
            {
                //No hay tratamiento: Quiero Crear, no hacer nada
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

            //instanciar objeto tratamiento
            

            //levantar contenidos del form a variables
            nombre_tratamiento = NombreTratamientoTextBox.Text;
            descripcion_tratamiento = DescripcionTratamientoTextBox.Text;
            costo_tratamiento = Convert.ToInt32(CostoTratamientoTextBox.Text);
            sesiones = TratamientosHiddenField.Value;

            //levantar fecha en que se creo el tratamiento
            fecha = DateTime.Now;

            // crear objeto tratamiento y rellenarlo con los datos del form
            Struct_Treatment tratamiento = new Data2.Class.Struct_Treatment(nombre_tratamiento, descripcion_tratamiento, fecha,fecha,true);
            //llamar a la funcion de guardado del objeto

            tratamiento.Guardar();

           
            


            //guardar las variables en variables de sesssion
            //Session.Add("nombre_tratamiento", nombre_tratamiento);
            //Session.Add("descripcion_tratamiento", descripcion_tratamiento);
            //Session.Add("costo", costo_tratamiento);
        }

        //machete de uso de session
        //Session.Add("NombreDeVariable", Value)
        //value = (int)Session["NombreDeVariable"];
        //operacion = (string)Session["operacion"];

        

    }
}