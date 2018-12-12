using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data2.Class
{
    public class Struct_Turno
    {

        public static string Estado_Ingresado = "Ingresado";
        public static string Estado_EnProceso = "EnProceso";
        public static string Estado_Finalizado = "Finalizado";

        public int Id;
        public DateTime DiaReservacion;
        public int IdCliente;
        public int IdUsuario;
        public int IdSesion;
        public string Estado;
        public Struct_Cliente CLIENTE;
        public Struct_Sesiones SESION;
        public string ShortDate;
        public Struct_Box BOX;
        public int IdBox;
        public string IdUnico;

        public Struct_Turno()
        {

        }

        public Struct_Turno(DataRow DR)
        {
            Id = int.Parse(DR["Id"].ToString());
            DiaReservacion = DateTime.Parse(DR["DateReservacion"].ToString());
            ShortDate = DiaReservacion.Day + "/" + DiaReservacion.Month + "/" + DiaReservacion.Year;
            IdCliente = int.Parse(DR["IdCliente"].ToString());
            IdUsuario = int.Parse(DR["IdUsuario"].ToString());
            IdSesion = int.Parse(DR["IdTratamiento"].ToString());
            IdBox = int.Parse(DR["IdBox"].ToString());
            Estado = DR["Estado"].ToString();
            CLIENTE = Struct_Cliente.GetClient(IdCliente, IdUsuario);
            SESION = Struct_Sesiones.GetSesionById(IdSesion);
            BOX = Struct_Box.GetBoxById(IdBox);
            IdUnico = DR["IdUnico"].ToString();
        }

        public static Struct_Turno ObtenerTurnoById(int IdTurno)
        {

            return new Struct_Turno(Connection.D_Turno.GetTurnoById(IdTurno));
        }

        public Struct_Turno(DateTime p_DiaReservacion, Struct_Cliente p_Cliente, int p_IdUsuario, Struct_Sesiones p_Sesion, Struct_Box p_box, string p_IdUnico)
        {
            Estado = Estado_Ingresado;
            DiaReservacion = p_DiaReservacion;
            IdCliente = p_Cliente.ID;
            IdUsuario = p_IdUsuario;
            IdSesion = p_Sesion.Id;
            CLIENTE = p_Cliente;
            SESION = p_Sesion;
            BOX = p_box;
            IdBox = p_box.Id;
            IdUnico = p_IdUnico;
        }

        public Boolean GuardarTurno()
        {
            return Connection.D_Turno.GuardarTurno(DiaReservacion, IdCliente,IdUsuario, IdSesion, Estado, IdBox, IdUnico);
        }

        public static List<Struct_Turno> ObtenerTurnosEntreDias(DateTime Start, DateTime End, int UserId, int IdBox)
        {
            
            List<Struct_Turno> ListaTurnos = new List<Struct_Turno>();
            DataTable DT = Connection.D_Turno.GetTurnosEntreDias(Start, End, UserId, IdBox); //ACA VA IDBOX
            if (DT != null)
            {
                foreach (DataRow DR in DT.Rows)
                {
                    ListaTurnos.Add(new Struct_Turno(DR));

                }
                return ListaTurnos;
            }
            else
            {
                return null;
            }


        }

        public static bool DeleteTurnos(string IdUnico)
        {
            bool verify = Connection.D_Turno.DeleteTurnos(IdUnico);
            return verify;
        }
    }
}
