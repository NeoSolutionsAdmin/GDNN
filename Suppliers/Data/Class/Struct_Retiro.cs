using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data2.Class
{
    public class Struct_Retiro

    {
        int id, idUser, idSeller;
        DateTime fecha;
        decimal monto;
        string detalle;
        bool nuevo = false;

        public int ID { get => id; }
        public int IDUser { get => idUser; }
        public int IDSeller { get => idSeller; }
        public DateTime FEcha { get => fecha; }
        public decimal MOnto { get => monto; }
        public string DEtalle { get => detalle; }

        public Struct_Retiro(System.Data.DataRow dataR)
        {
            id = int.Parse(dataR["Id"].ToString());
            idUser = int.Parse(dataR["IdUser"].ToString());
            idSeller = int.Parse(dataR["IdSeller"].ToString());
            fecha = DateTime.Parse(dataR["Fecha"].ToString());
            monto = Statics.Conversion.GetDecimal(dataR["Monto"].ToString());
            detalle = dataR["Detalle"].ToString();

        }

        public static List<Struct_Retiro> GetRetirosBetweenDates(int IdUser, DateTime Start, DateTime End)
        {
            List<Struct_Retiro> LP;
            DataTable _DT = Connection.D_Retiros.getRetirosBetweenDates(IdUser, Start, End);
            if (_DT != null)
            {
                LP = new List<Struct_Retiro>();
                foreach (DataRow a in _DT.Rows)
                {
                    LP.Add(new Struct_Retiro(a));
                }
                return LP;
            }
            else
            {
                return null;
            }
        }

        public Struct_Retiro(int P_IdUser, int P_IdSeller, DateTime P_Fecha, decimal P_Monto, string P_Detalle)
        {
            idUser = P_IdUser;
            idSeller = P_IdSeller;
            fecha = P_Fecha;
            monto = P_Monto;
            detalle = P_Detalle;
            nuevo = true;
        }


        public static bool InsertarRetiro(int idUser,int idSeller,DateTime Fecha,decimal Monto,string Detalle)
        {
            try
            {
                return Connection.D_Retiros.Insert_Retiro(idUser,idSeller,Fecha,Monto,Detalle);
            }
            catch (Exception ex)
            {
                string Mensaje = ex.Message;
                return false;
            }
        }

        /* COMENTADO PARA NO HACER CAGADAS!!!!!
        public bool Guardar()
        {
            if (nuevo == true)
            {
                return Connection.D_Retiros.Insert_Retiro(idUser, idSeller, fecha, monto, detalle);
            }
            else
            {
                return false;
            }
        }
        */
    }
}
