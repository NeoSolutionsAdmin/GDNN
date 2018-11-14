using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Data2.Connection;

namespace Data2.Class
{
    public class Struct_Tarjeta
    {

        int id;
        int idlocal;
        decimal recargo;
        string nombretarjeta;
        bool available;
        string rutadeimagen;

        public int ID { get{ return id; } }
        public int IDLOCAL { get { return idlocal; } }
        public decimal RECARGO { get { return recargo; } }
        public string NOMBRE { get { return nombretarjeta; } }
        public bool AVAILABLE { get { return available; } }
        

        private Struct_Tarjeta(DataRow p_dr)
        {
            id = int.Parse(p_dr["Id"].ToString());
            idlocal = int.Parse(p_dr["IdLocal"].ToString());
            recargo = decimal.Parse(p_dr["Recargo"].ToString());
            nombretarjeta = p_dr["NombreTarjeta"].ToString();
            available = Statics.Conversion.convertSQLToBoolean(p_dr["Available"]);

        }

        private void ChangeStateCreditCard(bool state)
        {
            Connection.D_Tarjeta.UpdateTarjetaAvailability(id, state);
        }

        public void HabilitarTarjeta()
        {
            ChangeStateCreditCard(true);
        }

        public void DeshabilitarTarjeta()
        {
            ChangeStateCreditCard(false);
        }

        public void ChangeTarjetaName(string NuevoNombre)
        {
            D_Tarjeta.UpdateNombreTarjeta(id, NuevoNombre);
        }

        public void CambiarRecargo(decimal nuevoRecargo)
        {
            D_Tarjeta.UpdateRecargoTarjeta(id, nuevoRecargo);
        }

        public static Struct_Tarjeta GetTarjetaById(int idtarjeta)
        {
            DataRow dr = D_Tarjeta.GetTarjetaById(idtarjeta);
            if (dr != null)
            {
                return new Struct_Tarjeta(dr);
            }
            else
            {
                return null;
            }
        }

        public static List<Struct_Tarjeta> GetAvailableCreditCards(int IdLocal)
        {
            DataTable DT = D_Tarjeta.GetAvailableTarjetasByIdLocal(IdLocal);
            if (DT != null)
            {
                List<Struct_Tarjeta> list = new List<Struct_Tarjeta>();
                foreach (DataRow dr in DT.Rows)
                {
                    list.Add(new Struct_Tarjeta(dr));
                }
                return list;
            }
            else
            {
                return null;
            }
        }

        public static List<Struct_Tarjeta> GetAllCreditCards(int IdLocal)
        {
            DataTable DT = D_Tarjeta.GetAllTarjetasByIdLocal(IdLocal);
            if (DT != null)
            {
                List<Struct_Tarjeta> list = new List<Struct_Tarjeta>();
                foreach (DataRow dr in DT.Rows)
                {
                    list.Add(new Struct_Tarjeta(dr));
                }
                return list;
            }
            else
            {
                return null;
            }
        }

        


    }
}
