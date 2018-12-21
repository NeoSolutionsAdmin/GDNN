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
using DotNetNuke.Entities.Tabs;
using Data2.Statics;
using System.Collections.Generic;
using Data2.Class;

namespace Christoc.Modules.Turnero
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from TurneroModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : TurneroModuleBase, IActionable
    {
        void configmodule()
        {
            string baseUrl = Request.Url.Scheme + "://" + Request.Url.Authority +
            Request.ApplicationPath.TrimEnd('/') + "/";
            DotNetNuke.Entities.Tabs.TabController TC = new DotNetNuke.Entities.Tabs.TabController();
            TabInfo TI = TC.GetTab(TabId, PortalId);
            url.Value = TI.FullUrl;
            
            

        }

        //Prueba modulo CS Turno
        protected void Page_Load(object sender, EventArgs e)
        {
            configmodule();
            idUser.Value = UserId.ToString();
            Sucursal.Value = Conversion.ObtenerLocal(UserId).ToString();

            //Chequeo de status en addturno
            if (Request["addTurnoStatus"] == "conflictingDate")
            {
                string fecha = Request["fecha"];
                string hora = Request["hora"];
                string box = Request["box"];

                addTurnoStatus.Value = Request["addTurnoStatus"];
                conflictingHour.Value = fecha;
                conflictingTime.Value = hora;
                conflictingBox.Value = box;
                
            }
            
            if (Request["addTurnoStatus"] == "success")
            {
                addTurnoStatus.Value = Request["addTurnoStatus"];
            }


            //-----------------------------------------------------------------------//

            if (Request["addtrat"] != null)
            {
                string idtrat = Request["addtrat"];
                Struct_Treatment ST = Struct_Treatment.GetTreatmentById(int.Parse(idtrat));
                Session.Remove("tratamiento");
                Session.Add("tratamiento", ST);

            }
            if (Request["addclient"] != null)
            {
                string idclient = Request["addclient"];
                Struct_Cliente SC = Struct_Cliente.GetClient(int.Parse(idclient), Conversion.ObtenerLocal(UserId) );
                Session.Remove("cliente");
                Session.Remove("tratamiento");
                Session.Add("cliente", SC);

            }


            llenarCampos();

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

        public void llenarCampos()
        {
            if(Session["cliente"] != null)
            {
                ocultarGUI.Value = "false";
                Struct_Cliente SC = Session["cliente"] as Struct_Cliente;
                labelrs.Text = SC.RS;
                labeldni.Text = SC.DNI;
            }
            else
            {
                ocultarGUI.Value = "true";
            }

            if (Session["tratamiento"] != null)
            {
                Struct_Treatment ST = Session["tratamiento"] as Struct_Treatment;
                labeltratamiento.Text = ST.Nombre;
                List<Struct_Sesiones> SesionesActuales = ST.ListaSesiones;
                labelnumsesiones.Text = SesionesActuales.Count.ToString();
            }
        }

    

        protected void guardar_Click1(object sender, EventArgs e)
        {
            Struct_Cliente clienteAux = Session["cliente"] as Struct_Cliente;
            Struct_Treatment tratamientoAux = Session["tratamiento"] as Struct_Treatment;
            Guid IdUnico = Guid.NewGuid();
            bool turnoOcupado = false;
            bool errorSaving = false;
            string tipoTurno = "none";

            //Formato del hiddenfield:
            //Elementos de turno separados por comas y asteriscos: 
            //
            //        "idTurno","idSesion","dia","hora","box"+"*"
            //
            //        Si IdTurno es 0, se crea un turno nuevo, 
            //        si no es 0, se asigna el turno no asignado.
            //
            String[] infoTurnos = turnosElegidos.Value.Split('*');
            String[] elementoTurno;
            int IdTurno;
            int IdSesion;
            DateTime FechayHora = new DateTime();
            Struct_Box Box = new Struct_Box();
            Struct_Turno TurnoAux = new Struct_Turno();
            Struct_Sesiones SesionAux = new Struct_Sesiones();
            TurnoAux.CLIENTE = clienteAux;

            //Se recorre el hiddenfield de turnos a guardar o asignar
            for (int i=0; i<infoTurnos.Length-1; i++)
            {
                //Guardado de valores en variables auxilares
                elementoTurno = infoTurnos[i].Split(',');
                IdTurno = int.Parse(elementoTurno[0]);
                IdSesion = int.Parse(elementoTurno[1]);
                FechayHora = DateTime.Parse(elementoTurno[2] + ' ' + elementoTurno[3]);
                Box = Struct_Box.GetBoxById(int.Parse(elementoTurno[4]));

                //Si el IdTurno es distinto de 0, se trata de un turno existente que no fue asignado:
                if (IdTurno != 0)
                {
                    TurnoAux = Struct_Turno.ObtenerTurnoById(IdTurno);
                    TurnoAux.DiaReservacion = FechayHora;
                    TurnoAux.BOX = Box;
                    TurnoAux.Estado = "Ingresado";
                    tipoTurno = "NoAsignado";
                }
                //Si el IdTurno es igual a 0, se trata de un turno nuevo de un tratamiento nuevo:
                else
                {
                    SesionAux = Struct_Sesiones.GetSesionById(IdSesion);
                    TurnoAux = new Struct_Turno(FechayHora, clienteAux, Conversion.ObtenerLocal(UserId), SesionAux, Box, IdUnico.ToString(), "Ingresado");
                    tipoTurno = "Nuevo";
                }

                //Chequea si el turno ya existe
                List<Struct_Turno> turnosDeHoy = Struct_Turno.ObtenerTurnosDia(TurnoAux.DiaReservacion, Conversion.ObtenerLocal(UserId), Box.Id);
                if (turnosDeHoy != null)
                {
                    foreach (Struct_Turno turno in turnosDeHoy)
                    {
                        if (turno.DiaReservacion == TurnoAux.DiaReservacion)
                        {
                            turnoOcupado = true;
                        }
                    }
                    break;
                }

                //Si se trata de un turno no asignado, se actualiza el turno, de lo contrario se guarda el turno nuevo
                if (string.Equals(tipoTurno, "NoAsignado"))
                {
                    //TO DO
                    //TurnoAux.ActualizarTurno();
                }
                if (string.Equals(tipoTurno, "Nuevo"))
                {
                    TurnoAux.GuardarTurno();
                }

            }

            if (turnoOcupado)
            {
                string diaConflicto = TurnoAux.DiaReservacion.ToShortDateString();
                string horaConflicto = TurnoAux.DiaReservacion.ToShortTimeString();
                string boxConflicto = Box.Detalle;
                errorSaving = true;
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL() + "?addTurnoStatus=conflictingDate&fecha=" + diaConflicto + "&hora=" + horaConflicto + "&box=" + boxConflicto);
            }


            //Se recorren las sesiones del tratamiento para ver si quedo alguna sin asignar:
            foreach (Struct_Sesiones sesion in tratamientoAux.ListaSesiones)
            {
                //TO DO
                //List<Struct_Turno> asignados = Struct_Turno.ObtenerTurnoByGuid(IdUnico);
                // si la sesion no existe en "asignados", crear un turno nuevo y ponerlo como no asignado
                //  TurnoAux.DiaReservacion = new DateTime(1753, 1, 1);
                //  Box = new Struct_Box();
                //  TurnoAux.Estado = "NoAsignado";
                //  TurnoAux.GuardarTurno();
            }

            if (!errorSaving)
            {
                Session.Remove("cliente");
                Session.Remove("tratamiento");
                labeldni.Text = "";
                labelrs.Text = "";
                labeltratamiento.Text = "";
                labelnumsesiones.Text = "";
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL() + "?addTurnoStatus=success");
            }

        }

    }
}