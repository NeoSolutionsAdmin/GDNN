using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Data2.Connection
{
    public class D_StockTratamientoConsumido
    {
        /// <summary>
        /// Actualiza la cantidad de un artículo marcado como CONSUMIDO
        /// </summary>
        /// <param name="idUser">ID del Usuario</param>
        /// <param name="idArticulo">ID del Artículo</param>
        /// <param name="cantINT">Cant a actualizar en ENTERO</param>
        /// <param name="cantDEC">Cant a actualizar en DECIMAL</param>
        /// <returns>Devuelve true si se actualizó, false si no</returns>
        public bool updateStockTratamientoConsumido(
            int idUser,
            int idArticulo,
            int cantINT,
            decimal cantDEC)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA =
                new GestionDataSetTableAdapters.QueriesTableAdapter();
            int r = QTA.updateStockTratamientoConsumido(idUser, idArticulo, cantINT, cantDEC);
            if (r > 0) return true;
            else return false;
        }

        /// <summary>
        /// Indica que cierto stock asociado a un tratamiento fue consumido
        /// </summary>
        /// <param name="idUser">ID de Usuario</param>
        /// <param name="idArticulo">ID de Artículo CONSUMIDO</param>
        /// <param name="idTratamiento">ID de Tratamiento al que estaba asociado</param>
        /// <param name="fechaConsumido">Fecha en la que el stock fue consumido</param>
        /// <param name="idStockTratamiento">ID de la fila de stock asociado en la tabla STOCKTRATAMIENTO</param>
        /// <returns>Devuelve un booleano (false: no se insertó;true: se insertó algo)</returns>
        public bool insertStockTratamientoConsumido(
            int idUser,
            int idArticulo,
            int cantINT,
            decimal cantDEC,
            int idTratamiento,
            DateTime fechaConsumido)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA =
                new GestionDataSetTableAdapters.QueriesTableAdapter();
            int r = QTA.insertStockTratamientoConsumido(idUser, idArticulo, cantINT, cantDEC, idTratamiento, Statics.Conversion.DateTimeToSql(fechaConsumido));
            if (r != 0) return true;
            else return false;
        }


        /// <summary>
        /// Busca en la tabla StockTratamientoConsumido las filas entre X fechas
        /// </summary>
        /// <param name="idUser">ID de Usuario/Local</param>
        /// <param name="FechaInicio">Fecha de inicio</param>
        /// <param name="FechaFin">Fecha de fin</param>
        /// <returns>Devuelve una tabla con las filas buscadas</returns>
        public DataTable getStockConsumidoByDates(
            int idUser,
            DateTime FechaInicio,
            DateTime FechaFin)
        {
            GestionDataSet.getStockConsumidoByDatesDataTable DT =
                new GestionDataSet.getStockConsumidoByDatesDataTable();
            GestionDataSetTableAdapters.getStockConsumidoByDatesTableAdapter TA
                = new GestionDataSetTableAdapters.getStockConsumidoByDatesTableAdapter();

            TA.Fill(DT, idUser, Statics.Conversion.DateTimeToSql(FechaInicio.Date), Statics.Conversion.DateTimeToSql(FechaFin.Date));
            if (DT.Rows.Count > 0) return DT;
            else return null;
        }
    }
}
