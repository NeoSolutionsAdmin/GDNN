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

            if (Request["addtrat"] != null)
            {
                string idtrat = Request["addtrat"];
                Data2.Class.Struct_Treatment ST = Data2.Class.Struct_Treatment.GetTreatmentById(int.Parse(idtrat));
                Session.Remove("tratamiento");
                Session.Add("tratamiento", ST);

            }
            if (Request["addclient"] != null)
            {
                string idclient = Request["addclient"];
                Data2.Class.Struct_Cliente SC = Data2.Class.Struct_Cliente.GetClient(int.Parse(idclient), Conversion.ObtenerLocal(UserId) );
                Session.Remove("cliente");
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
                Struct_Cliente SC = Session["cliente"] as Struct_Cliente;
                labelrs.Text = SC.RS;
                labeldni.Text = SC.DNI;
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
            Struct_Turno turnoAux = new Struct_Turno();
            List<Struct_Sesiones> sesionAux = new List<Struct_Sesiones>();
            Struct_Cliente clienteAux = Session["cliente"] as Struct_Cliente;
            Struct_Treatment tratamientoAux = Session["tratamiento"] as Struct_Treatment;

            String[] infoTurnos = turnosElegidos.Value.Split('*');
            String[] elementoTurno;
            DateTime FechaYHora = new DateTime();
            //Recorre las sesiones del tratamiento a turnear (?)
            Log.ADD( turnosElegidos.Value ,this);
            foreach (Struct_Sesiones sesion in tratamientoAux.ListaSesiones )
            {
                //Recorre y parsea los valores del hiddenfield para completar el struct_sesiones
                //Formato del hiddenfield:
                //Elementos de turno separados por comas y asteriscos: 
                //
                //              "dia" + indiceSesion + "," + valorDia + "*"
                //              "hora" + indiceSesion + "," + valorHora + "*"
                //
                //NO estan ordenados, se guardan en orden de selección del usuario, por eso tanta comprobacion
                for (int indice= 0; indice < infoTurnos.Length-1; indice++ )
                {
                    elementoTurno = infoTurnos[indice].Split(',');
                    //Si no completaron algun campo, avisar que habian datos vacios
                    if (string.Equals(elementoTurno[1], "")){ Response.Redirect("./?addTurnoStatus=emptyOption"); }
                    string diaActual = "dia" + indice+1;
                    string horaActual = "hora" + indice+1;

                    if (string.Equals(elementoTurno[0], diaActual))
                    {
                        Log.ADD(elementoTurno[1], this);
                        FechaYHora = DateTime.Parse(elementoTurno[1]);
                        Log.ADD(FechaYHora.ToString(), this);
                    }
                    if (string.Equals(elementoTurno[0], horaActual))
                    {
                        int hora = 0, minutos = 0;
                        String[] horaTurno = elementoTurno[1].Split(':');
                        hora = int.Parse(horaTurno[0]); minutos = int.Parse(horaTurno[1]);
                        TimeSpan horaParaElTimeDate = new TimeSpan(hora, minutos, 0);
                        Log.ADD(horaParaElTimeDate.ToString(), this);
                        FechaYHora = FechaYHora.Date + horaParaElTimeDate;
                        turnoAux.DiaReservacion = FechaYHora;
                    }
                    turnoAux.DiaReservacion = FechaYHora;
                }
                //Crea el turno para la sesion correspondiente
                turnoAux = new Struct_Turno(turnoAux.DiaReservacion, clienteAux, Conversion.ObtenerLocal(UserId), sesion);
                //turnoAux.GuardarTurno();
            }
            
            Session.Remove("cliente");
            Session.Remove("tratamiento");
            labeldni.Text = "";
            labelrs.Text = "";
            labeltratamiento.Text = "";
            labelnumsesiones.Text = "";
            Response.Redirect("./?addTurnoStatus=success");
        }
    }
}