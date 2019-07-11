using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Data2.Connection;
using System.Data;

namespace Data2.Class
{
    public class Struct_Ingresos
    {

        private DateTime Fecha;
        private string Detalle;
        private int IdLocal;
        private int id;
        private decimal Monto;

       
        public DateTime FECHA { get => Fecha;  }
        public string DETALLE { get => Detalle;  }
        public int IDLOCAL { get => IdLocal;  }
        public int ID { get => id;  }
        public decimal MONTO { get => Monto;  }

        

        private Struct_Ingresos (DataRow dr)
        {
            Fecha = DateTime.Parse(dr["Fecha"].ToString());
            Detalle = dr["Detalle"].ToString();
            IdLocal = int.Parse(dr["IdLocal"].ToString());
            id = int.Parse(dr["Id"].ToString());
            Monto = Decimal.Parse(dr["Monto"].ToString());

        }

        public static List<Struct_Ingresos> Obtener_IngresosBetweenDates(int IdLocal, DateTime DateStart, DateTime DateEnd)
        {
            DataTable DT = D_Ingresos.Select_IngresosBetweenDates(IdLocal,DateStart,DateEnd);

            if (DT != null)
            {
                List<Struct_Ingresos> Auxiliar = new List<Struct_Ingresos>();

                foreach (DataRow row in DT.Rows)
                {
                    Auxiliar.Add(new Struct_Ingresos(row));
                }

                return Auxiliar;
            }
            else
            {
                return null;
            }
            
        }

        public static bool Insertar_Ingreso(int IdLocal, DateTime Fecha, decimal Monto, string Detalle)
        {
            return Data2.Connection.D_Ingresos.Insert_Ingreso(IdLocal, Monto, Detalle, Fecha);

        }




    }
}
