using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Data2.Connection;

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
        public int idStockTratamiento;
        public List<Struct_ConsumoLocalStock> ListaStrockTratamiento = new List<Struct_ConsumoLocalStock>();

        D_ConsumoLocalStock DCLS = new D_ConsumoLocalStock();


        public Struct_ConsumoLocalStock(DataRow DR)
        {
            idStockTratamiento = int.Parse(DR["Id"].ToString());
            idUser = int.Parse(DR["IdUser"].ToString());
            idArticulo = int.Parse(DR["IdArticulo"].ToString());
            cantINT = int.Parse(DR["CanINT"].ToString());
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

        /// <summary>
        /// Actualiza la cantidad de un artículo ya asociado a un tratamiento
        /// </summary>
        /// <param name="idUser">ID del Usuario</param>
        /// <param name="idArticulo">ID del Artículo</param>
        /// <param name="cantINT">Cantidad a actualizar en ENTERO</param>
        /// <param name="cantDEC">Cantidad a actualizar en DECIMAL</param>
        /// <returns>Devuelve true si se actualizó, false si no</returns>
        public static bool updateStockTratamientoCantidad(
        int idUser,
        int idArticulo,
        int idTratamiento,
        int cantINT,
        decimal cantDEC)
        {
            D_ConsumoLocalStock DCLS = new D_ConsumoLocalStock();
            return DCLS.updateStockTratamientoCantidad(idUser, idArticulo,idTratamiento, cantINT, cantDEC);

        }


        /// <summary>
        /// Inserta un stock asociado a un tratamiento en la tabla StockTratamiento con la fecha de hoy
        /// </summary>
        public static void inserStockTratamientoConsumido(
            int idUser,
            int idArticulo,
            int cantINT,
            decimal cantDEC,
            int idTratamiento)
        {
            D_ConsumoLocalStock DCLS = new D_ConsumoLocalStock();
            DCLS.insertStockTratamientoConsumido(
                idUser,
                idArticulo,
                cantINT,
                cantDEC,
                idTratamiento,
                DateTime.Now);
        }


        /// <summary>
        /// Busca en la tabla StockTratamiento los articulos asociados con el id de tratamiento especificado.
        /// </summary>
        /// <param name="idUser">ID de Usuario</param>
        /// <param name="idTratamiento">ID de Tratamiento</param>
        /// <returns>Devuelve una lista llenada con objetos las filas de la tabla correspondientes</returns>
        public static List<Struct_ConsumoLocalStock> getStockTratamientoByIdTratamiento(
            int idUser,
            int idTratamiento)
        {
            D_ConsumoLocalStock DCLS = new D_ConsumoLocalStock();
            DataTable DT = DCLS.getStockTratamientoByIdTratamiento(idUser, idTratamiento);
            List<Struct_ConsumoLocalStock> SCLS = new List<Struct_ConsumoLocalStock>();
            if(DT!=null && DT.Rows.Count > 0)
            {
                for (int a = 0; a < DT.Rows.Count; a++)
                {
                    SCLS.Add(new Struct_ConsumoLocalStock(DT.Rows[a]));
                }
                return SCLS;
            }
            else
            {
                return null;
            }
            
        }

        /// <summary>
        /// Actualiza la cantidad de un artículo ya marcado como CONSUMIDO
        /// </summary>
        /// <param name="idUser">ID del Usuario/Local</param>
        /// <param name="idArticulo">ID del Artículo</param>
        /// <param name="cantINT">Cantidad a actualizar en ENTERO</param>
        /// <param name="cantDEC">Cantidad a actualizar en DECIMAL</param>
        /// <returns>Devuelve true si se actualizó, false si no</returns>
        public static bool updateStockTratamientoConsumido(
            int idUser,
            int idArticulo,
            int cantINT,
            decimal cantDEC)
        {
            D_ConsumoLocalStock DCLS = new D_ConsumoLocalStock();
            return DCLS.updateStockTratamientoConsumido(idUser, idArticulo, cantINT, cantDEC);
        }

        /// <summary>
        /// Elimina una fila de la tabla StockTratamiento si es que no quedan articulos asociados (cant==0)
        /// </summary>
        /// <param name="idStockTratamiento">ID de la fila</param>
        /// <param name="idUser">ID de Usuario/Local</param>
        /// <returns>Devuelve true si se actualizó, false si no</returns>
        public static bool deleteStockTratamientoByIdStockTratamiento(
            int idStockTratamiento)
        {
            D_ConsumoLocalStock DCLS = new D_ConsumoLocalStock();
            return DCLS.deleteStockTratamientoByIdStockTratamiento(idStockTratamiento);
        }

        /// <summary>
        /// Busca en la tabla StockTratamiento alguna fila con los parámetros ingresados.
        /// </summary>
        /// <param name="idUser">ID de Usuario/Local</param>
        /// <param name="idArticulo">ID del Artículo</param>
        /// <param name="idTratamiento">ID del Tratamiento</param>
        /// <returns>Devuelve un objeto Struct_ConsumoLocalStock específico</returns>
        public static Struct_ConsumoLocalStock getSpecificStockTratamiento(
                int idUser,
                int idArticulo,
                int idTratamiento)
        {
            D_ConsumoLocalStock DCLS = new D_ConsumoLocalStock();
            DataRow DR = DCLS.getSpecificStockTratamiento(idUser, idArticulo, idTratamiento);
            if (DR != null)
            {
                return new Struct_ConsumoLocalStock(DR);
            }
            else return null;
        }



    }
}
