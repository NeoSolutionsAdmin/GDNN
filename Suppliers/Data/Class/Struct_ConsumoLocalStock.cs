using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Data2.Class
{
    public class Struct_ConsumoLocalStock
    {

        public int idUser;
        public int idArticulo;
        public int idUnidad;
        public int cantINT;
        public decimal cantDEC;
        public int idTratamiento;
        int idStockTratamiento;
        public List<Struct_ConsumoLocalStock> ListaStrockTratamiento = new List<Struct_ConsumoLocalStock>();

        Connection.D_ConsumoLocalStock DCLS = new Connection.D_ConsumoLocalStock();


        public Struct_ConsumoLocalStock(DataRow DR)
        {
            idStockTratamiento = int.Parse(DR["Id"].ToString());
            idUser = int.Parse(DR["IdUser"].ToString());
            idArticulo = int.Parse(DR["IdArticulo"].ToString());
            cantINT = int.Parse(DR["CantINT"].ToString());
            cantDEC = decimal.Parse(DR["CantDEC"].ToString());
            idTratamiento = int.Parse(DR["IdTratamiento"].ToString());

            

        }

        /// <summary>
        /// Utilizado SOLAMENTE para guardar en la tabla StockTratamiento
        /// </summary>
        /// <param name="p_idUser">ID de Usuario</param>
        /// <param name="p_idArticulo">ID del Artículo a insertar</param>
        /// <param name="p_idUnidad">ID de la Unidad a usar (1:CANT;2:MET;3:KG)</param>
        /// <param name="p_cantINT">Cantidad a insertar en número entero</param>
        /// <param name="p_cantDEC">Cantidad a insertar en número decimal</param>
        /// <param name="p_idTratamiento">ID del Tratamiento a insertar</param>
        public Struct_ConsumoLocalStock(
            int p_idUser,
            int p_idArticulo,
            int p_cantINT,
            decimal p_cantDEC,
            int p_idTratamiento)
        {
            idUser = p_idUser;
            idArticulo = p_idArticulo;
            cantINT = p_cantINT;
            cantDEC = p_cantDEC;
            idTratamiento = p_idTratamiento;

            insertStockTratamiento();
        }


        /// <summary>
        /// Inserta un stock asociado a determinado tratamiento
        /// </summary>
        public void insertStockTratamiento()
        {
            DCLS.insertStockTratamiento(
                idUser,
                idArticulo,
                cantINT,
                cantDEC,
                idTratamiento);

            idStockTratamiento = DCLS.getLastStockTratamiento();
            
        }

        public void inserStockTratamientoConsumido()
        {
            DCLS.insertStockTratamientoConsumido(
                idUser,
                idArticulo,
                idTratamiento,
                DateTime.Now,
                idStockTratamiento);
        }

    }
}
