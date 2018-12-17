using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Data2.Connection;

namespace Data2.Class
{
    public class Struct_StockTratamientoConsumido
    {
        public int idUser;
        public int idArticulo;
        public int cantINT;
        public decimal cantDEC;
        public int idTratamiento;
        public DateTime FechaConsumido;
        public int idFila;



        public Struct_StockTratamientoConsumido(DataRow DR)
        {
            idFila = int.Parse(DR["Id"].ToString());
            idUser = int.Parse(DR["IdUser"].ToString());
            idArticulo = int.Parse(DR["IdArticulo"].ToString());
            cantINT = int.Parse(DR["CantINT"].ToString());
            cantDEC = int.Parse(DR["CantDEC"].ToString());
            FechaConsumido = DateTime.Parse(DR["FechaConsumido"].ToString());
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
            D_StockTratamientoConsumido DCLS = new D_StockTratamientoConsumido();
            return DCLS.updateStockTratamientoConsumido(idUser, idArticulo, cantINT, cantDEC);
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
            D_StockTratamientoConsumido DCLS = new D_StockTratamientoConsumido();
            DCLS.insertStockTratamientoConsumido(
                idUser,
                idArticulo,
                cantINT,
                cantDEC,
                idTratamiento,
                DateTime.Now);
        }

        public static List<Struct_StockTratamientoConsumido> getStockConsumidoByDates(
            int idUser,
            DateTime Fecha1,
            DateTime Fecha2)
        {
            D_StockTratamientoConsumido DCLS = new D_StockTratamientoConsumido();
            DataTable DT = DCLS.getStockConsumidoByDates(idUser, Fecha1, Fecha2);
            List<Struct_StockTratamientoConsumido> LSSTC = new List<Struct_StockTratamientoConsumido>();

            if (DT != null && DT.Rows.Count > 0)
            {
                for (int a = 0; a < DT.Rows.Count; a++)
                {
                    LSSTC.Add(new Struct_StockTratamientoConsumido(DT.Rows[a]));
                }
                return LSSTC;
            }
            else return null;


        }

    }
}
