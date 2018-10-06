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
        public int IdTratamiento;
        public string Estado;
        public Struct_Cliente CLIENTE;
        public Struct_Treatment TRATAMIENTO;

        public Struct_Turno(DataRow DR)
        {
            Id = int.Parse(DR["Id"].ToString());
            DiaReservacion = DateTime.Parse(DR["DateReservación"].ToString());
            IdCliente = int.Parse(DR["IdCliente"].ToString());
            IdUsuario = int.Parse(DR["IdUsuario"].ToString());
            IdTratamiento = int.Parse(DR["IdTratamiento"].ToString());
            Estado = DR["Estado"].ToString();
            CLIENTE = Struct_Cliente.GetClient(IdCliente, IdUsuario);
            TRATAMIENTO = Struct_Treatment.GetTreatmentById(IdTratamiento);
        }

        public static Struct_Turno ObtenerTurnoById(int IdTurno)
        {
            return new Struct_Turno(Connection.D_Turno.GetTurnoById(IdTurno));
        }

        public Struct_Turno(DateTime p_DiaReservacion, Struct_Cliente p_Cliente, int p_IdUsuario, Struct_Treatment p_Tratamiento)
        {
            Estado = Estado_Ingresado;
            DiaReservacion = p_DiaReservacion;
            IdCliente = p_Cliente.ID;
            IdUsuario = p_IdUsuario;
            IdTratamiento = p_Tratamiento.Id;
            CLIENTE = p_Cliente;
            TRATAMIENTO = p_Tratamiento;

        }

        public Boolean GuardarTurno()
        {
            return Connection.D_Turno.GuardarTurno(DiaReservacion, IdCliente,IdUsuario, IdTratamiento, Estado);
        }

        public static List<Struct_Turno> ObtenerTurnosEntreDias(DateTime Start, DateTime End, int UserId)
        {
            List<Struct_Turno> ListaTurnos = new List<Struct_Turno>();
            DataTable DT = Connection.D_Turno.GetTurnosEntreDias(Start, End, UserId);
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

    }
}
