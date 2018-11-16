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
        
        /// <summary>
        /// Constructor privado
        /// </summary>
        /// <param name="p_dr"></param>
        private Struct_Tarjeta(DataRow p_dr)
        {
            id = int.Parse(p_dr["Id"].ToString());
            idlocal = int.Parse(p_dr["IdLocal"].ToString());
            recargo = decimal.Parse(p_dr["Recargo"].ToString());
            nombretarjeta = p_dr["NombreTarjeta"].ToString();
            available = Statics.Conversion.convertSQLToBoolean(p_dr["Available"]);

        }

        /// <summary>
        /// Crea en la base de datos una tarjeta y devuelve una clase del tipo Struct_Tarjeta
        /// </summary>
        /// <param name="IdLocal"></param>
        /// <param name="Recargo"></param>
        /// <param name="Nombre"></param>
        /// <returns></returns>

        public static Struct_Tarjeta NuevaTarjeta(int IdLocal, decimal Recargo, string Nombre)
        {
            Connection.D_Tarjeta.InsertarTarjeta(IdLocal, Recargo, Nombre);
            List<Struct_Tarjeta> ML = Struct_Tarjeta.GetAvailableCreditCards(IdLocal);
            return ML[ML.Count - 1];
        }
        /// <summary>
        /// Privado, sirve para cambiar el estado de la tarjeta
        /// </summary>
        /// <param name="state"></param>
        private void ChangeStateCreditCard(bool state)
        {
            Connection.D_Tarjeta.UpdateTarjetaAvailability(id, state);
        }
        /// <summary>
        /// Este procedimiento habilita una tarjeta
        /// </summary>
        public void HabilitarTarjeta()
        {
            ChangeStateCreditCard(true);
        }
        /// <summary>
        /// Este procedimiento deshabilita la tarjeta
        /// </summary>
        public void DeshabilitarTarjeta()
        {
            ChangeStateCreditCard(false);
        }
        /// <summary>
        /// Este procedimiento actualiza el nombre de la tarjeta en la base de datos
        /// </summary>
        /// <param name="NuevoNombre"></param>
        public void ChangeTarjetaName(string NuevoNombre)
        {
            D_Tarjeta.UpdateNombreTarjeta(id, NuevoNombre);
        }
        /// <summary>
        /// Este procedimiento actualiza el recargo de la tarjeta en la base de datos
        /// </summary>
        /// <param name="nuevoRecargo"></param>
        public void CambiarRecargo(decimal nuevoRecargo)
        {
            D_Tarjeta.UpdateRecargoTarjeta(id, nuevoRecargo);
        }
        /// <summary>
        /// Este procedimiento obtiene una tarjeta por id
        /// </summary>
        /// <param name="idtarjeta"></param>
        /// <returns></returns>
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
        /// <summary>
        /// Este procedimiento obtiene un listado de tarjetas habilitadas
        /// </summary>
        /// <param name="IdLocal"></param>
        /// <returns></returns>
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
        /// <summary>
        /// Este procedimiento obtiene un listado de todas las tarjetas
        /// </summary>
        /// <param name="IdLocal"></param>
        /// <returns></returns>
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
