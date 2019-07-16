using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Data2.Class;

namespace Christoc.Modules.Caja
{
    public partial class CajaWebservice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            decimal Monto = Convert.ToDecimal(Request["Monto"]);
            string Detalle = Request["Detalle"];
            int TipoOperacion = Convert.ToInt16(Request["TipoOperacion"]);
            //DateTime Fecha = DateTime.Now;
            int idUsuario = Convert.ToInt16(Request["IdUser"]);
            int idSeller = 0;//
            int IDLocal = Convert.ToInt16(Request["IDLocal"]);
            decimal TotalCaja = Convert.ToDecimal(Request["TotalCaja"]);
            string Anotaciones = Request["Anotaciones"];

            switch (TipoOperacion)
            {
                case 0:// 0 es retiro
                    if (Monto != 0)
                    {
                        //guardar en la db
                        bool resultado = Struct_Retiro.InsertarRetiro(idUsuario, idSeller, DateTime.Now, Monto, "Retiro: " + Detalle);

                        if (resultado == true)
                        {
                            Responder("0");
                        }
                    }
                    break;

                case 1://1 es pago
                    if (Monto != 0)
                    {
                        //guardar en la bd
                        bool resultado = Struct_Retiro.InsertarRetiro(idUsuario, idSeller, DateTime.Now, Monto, "Pago: " + Detalle);
                        if (resultado == true)
                        {
                            Responder("1");
                        }
                    }
                    break;

                case 2://2 es ingreso
                    if (Monto != 0)
                    {
                        //guardar en la db
                        //bool resultado = Struct_Retiro.InsertarRetiro(idUsuario, idSeller, DateTime.Now, Monto, "Pago:" + Detalle);

                        bool resultado = Struct_Ingresos.Insertar_Ingreso(idUsuario, DateTime.Now, Monto, Detalle);
                        if (resultado == true)
                        {
                            Responder("2");
                        }
                    }
                    break;

                case 5: ///// CIERRE DE CAJA

                        bool res =  Struct_ArqueoDeCaja.InsertarArqueo(IDLocal,TotalCaja,DateTime.Now,Anotaciones);
                        if (res==true)
                        {
                            Responder("5");
                        }
                        else
                        {
                            Responder("6");
                        }

                    break;
            }

            /*
            if (TipoOperacion == 0) // 0 es retiro
            {
                if (Monto != 0)
                {
                    //guardar en la db
                    bool resultado = Struct_Retiro.InsertarRetiro(idUsuario, idSeller, DateTime.Now, Monto, "Retiro: " + Detalle);

                    if (resultado == true)
                    {
                        Responder("0");
                        Monto = 0;
                        Detalle = "";
                    }
                }
            }
            else if (TipoOperacion == 1) //1 es pago
            {
                if (Monto !=0)
                {
                    //guardar en la bd
                    bool resultado = Struct_Retiro.InsertarRetiro(idUsuario, idSeller, DateTime.Now, Monto, "Pago: " + Detalle);
                    if (resultado == true)
                    {
                        Responder("1");
                        Monto = 0;
                        Detalle = "";
                    }
                }
            }
            else if (TipoOperacion == 2) // ingreso
            {
                if (Monto != 0)
                {
                    //guardar en la db
                    //bool resultado = Struct_Retiro.InsertarRetiro(idUsuario, idSeller, DateTime.Now, Monto, "Pago:" + Detalle);

                    bool resultado = Struct_Ingresos.Insertar_Ingreso(idUsuario,DateTime.Now,Monto,Detalle);
                    if (resultado == true)
                    {
                        Responder("2");
                        Monto = 0;
                        Detalle = "";
                    }
                }
            }
            */
        }

        private void Responder(string Mensaje)
        {
            Response.Clear();
            Response.ClearHeaders();
            Response.Write(Mensaje);
            Response.Flush();
            Response.End();
        }
    }
}