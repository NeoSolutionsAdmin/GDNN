using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Data2.Class
{
    public class Struct_ArqueoDeCaja
    {

        int id;
        int idLocal;
        decimal total;
        DateTime fecha;
        string anotaciones;

        public int GetId { get { return id; } }
        public int GetIdLocal { get { return idLocal; } }
        public decimal GetTotal { get { return total; } }
        public DateTime GetFecha { get { return fecha; } }
        public string GetAnotaciones { get { return anotaciones; } }


        private Struct_ArqueoDeCaja(DataRow DR)
        {
            id = int.Parse(DR["Id"].ToString());
            idLocal = int.Parse(DR["IdLocal"].ToString());
            total = decimal.Parse(DR["Total"].ToString());
            fecha = DateTime.Parse(DR["Fecha"].ToString());
            if (DR.IsNull("Total")) { anotaciones = ""; } else { anotaciones = DR["Anotaciones"].ToString(); }
        }

        public static Struct_ArqueoDeCaja GetLastArqueo(int IdLocal)
        {
            DataRow DR = Connection.D_ArqueoDeCaja.GetLastAqrqueo(IdLocal);
            if (DR != null)
            {
                return new Struct_ArqueoDeCaja(DR);
            }
            else
            {
                return null;
            }
        }

        public static bool InsertarArqueo(int IdLocal, decimal Total, DateTime Fecha, string Anotaciones)
        {
            return Connection.D_ArqueoDeCaja.InsertArqueo(IdLocal, Total, Fecha, Anotaciones);
        }

        public List<Struct_ArqueoDeCaja> GetArqueosEntreDias(DateTime Start, DateTime End, int IdLocal)
        {
            DataTable Daux = Connection.D_ArqueoDeCaja.GetArqueosBetweenDates(Start, End, IdLocal);
            if (Daux != null)
            {
                List<Struct_ArqueoDeCaja> auxlist = new List<Struct_ArqueoDeCaja>();
                foreach (DataRow dr in Daux.Rows)
                {
                    auxlist.Add(new Struct_ArqueoDeCaja(dr));
                } 
                return auxlist;
                
            }
            else
            {
                return null;
            }
        }

    }
}
