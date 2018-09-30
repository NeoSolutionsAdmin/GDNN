using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data2.Class
{
    public class Struct_Pago
    {
        int id, idUser, idSeller;
        DateTime fecha;
        decimal monto;
        string detalle;
        bool nuevo = false;

        public int ID { get => id;  }
        public int IDUser { get => idUser; }
        public int IDSeller { get => idSeller;}
        public DateTime FEcha { get => fecha;}
        public decimal MOnto { get => monto;}
        public string DEtalle { get => detalle;}

        public static List<Struct_Pago> GetPagosBetweenDates(int IdUser, DateTime Start, DateTime End)
        {
            List<Struct_Pago> LP;
            DataTable _DT = Connection.D_Pagos.getPagosBetweenDates(IdUser, Start, End);
            if (_DT != null)
            {
                LP = new List<Struct_Pago>();
                foreach (DataRow a in _DT.Rows)
                {
                    LP.Add(new Struct_Pago(a));
                }
                return LP;
            }
            else
            {
                return null;
            }
        }
        

        public Struct_Pago(System.Data.DataRow dataR)
        {
            id = int.Parse(dataR["Id"].ToString());
            idUser = int.Parse(dataR["IdUser"].ToString());
            idSeller = int.Parse(dataR["IdSeller"].ToString());
            fecha = DateTime.Parse(dataR["Fecha"].ToString());
            monto = Statics.Conversion.GetDecimal(dataR["Monto"].ToString());
            detalle = dataR["Detalle"].ToString();

        }

        public Struct_Pago(int P_IdUser, int P_IdSeller, DateTime P_Fecha, decimal P_Monto, string P_Detalle)
        {
            idUser = P_IdUser;
            idSeller = P_IdSeller;
            fecha = P_Fecha;
            monto = P_Monto;
            detalle = P_Detalle;
            nuevo = true;
        }

        public bool Guardar()
        {
            if (nuevo == true)
            {
                return Connection.D_Pagos.Insert_Pago(idUser, idSeller, fecha, monto, detalle);
            }
            else
            {
                return false;
            }
        }
    }
}
