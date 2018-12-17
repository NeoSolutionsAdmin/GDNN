using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Data2.Connection
{
    public class D_ConsumoLocalStock
    {

        /// <summary>
        /// Devuelve una fila con los datos del stock asociado a un tratamiento
        /// </summary>
        /// <param name="idUser">ID del usuario</param>
        /// <param name="idTratamiento">ID del tratamiento</param>
        /// <returns>Devuelve la fila con los datos del stock asociado</returns>
        public DataTable getStockTratamientoByIdTratamiento(int idUser, int idTratamiento)
        {
            GestionDataSetTableAdapters.getStockTratamientoByIdTratamientoTableAdapter TA =
                new GestionDataSetTableAdapters.getStockTratamientoByIdTratamientoTableAdapter();
            GestionDataSet.getStockTratamientoByIdTratamientoDataTable DT = 
                new GestionDataSet.getStockTratamientoByIdTratamientoDataTable();

            TA.Fill(DT, idUser, idTratamiento);
            if (DT.Count > 0) return DT;
            else return null;
        }

        /// <summary>
        /// Asocia un artículo a un tratamiento. Inserta en la tabla Stock Tratamiento
        /// </summary>
        /// <param name="idUser">ID de Usuario</param>
        /// <param name="idArticulo">ID del Artículo a insertar</param>
        /// <param name="idUnidad">ID de la Unidad a usar (1:CANT;2:MET;3:KG)</param>
        /// <param name="cantINT">Cantidad a insertar en número entero</param>
        /// <param name="cantDEC">Cantidad a insertar en número decimal</param>
        /// <param name="idTratamiento">ID del Tratamiento a insertar</param>
        /// <returns>Devuelve un booleano (false: no se insertó;true: se insertó algo)</returns>
        public bool insertStockTratamiento(
            int idUser,
            int idArticulo,
            int cantINT,
            decimal cantDEC,
            int idTratamiento)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA =
                new GestionDataSetTableAdapters.QueriesTableAdapter();
            int r = QTA.insertStockATratamiento(idUser, idArticulo, cantINT, cantDEC, idTratamiento);
            if (r != 0) return true;
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
            int r = QTA.insertStockTratamientoConsumido(idUser, idArticulo,cantINT,cantDEC, idTratamiento, Statics.Conversion.DateTimeToSql(fechaConsumido));
            if (r != 0) return true;
            else return false;
        }

        /// <summary>
        /// Devuelve el ID de lo último insertado en la tabla
        /// </summary>
        /// <returns>Devuelve el ID de lo último insertado en la tabla</returns>
        public int getLastStockTratamiento()
        {
            GestionDataSetTableAdapters.getLastStockTratamientoTableAdapter TA =
                new GestionDataSetTableAdapters.getLastStockTratamientoTableAdapter();
            GestionDataSet.getLastStockTratamientoDataTable DT = 
                new GestionDataSet.getLastStockTratamientoDataTable();

            TA.Fill(DT);
            return int.Parse(DT.Rows[0]["Id"].ToString());
        }

        /// <summary>
        /// Actualiza la cantidad de un artículo ya asociado a un tratamiento
        /// </summary>
        /// <param name="idUser">ID del Usuario</param>
        /// <param name="idArticulo">ID del Artículo</param>
        /// <param name="cantINT">Cant a actualizar en ENTERO</param>
        /// <param name="cantDEC">Cant a actualizar en DECIMAL</param>
        /// <returns>Devuelve true si se actualizó, false si no</returns>
        public bool updateStockTratamientoCantidad(
            int idUser,
            int idArticulo,
            int idTratamiento,
            int cantINT,
            decimal cantDEC)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA =
                new GestionDataSetTableAdapters.QueriesTableAdapter();
            int r = QTA.updateStockTratamientoCantidad(idUser, idArticulo, idTratamiento, cantINT, cantDEC);
            if (r > 0) return true;
            else return false;
        }


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
            int r = QTA.updateStockTratamientoConsumido(idUser,idArticulo,cantINT,cantDEC);
            if (r > 0) return true;
            else return false;
        }

        /// <summary>
        /// Elimina una fila de la tabla StockTratamiento si es que no quedan articulos asociados (cant==0)
        /// </summary>
        /// <param name="idStockTratamiento">ID de la fila</param>
        /// <param name="idUser">ID de Usuario/Local</param>
        /// <returns>Devuelve true si se actualizó, false si no</returns>
        public bool deleteStockTratamientoByIdStockTratamiento(
            int idStockTratamiento)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = 
                new GestionDataSetTableAdapters.QueriesTableAdapter();
            int r = QTA.deleteFromStockTratamientoByIdStockTratameinto(idStockTratamiento);
            if (r > 0) return true;
            else return false;
        }

        public DataRow getSpecificStockTratamiento(
            int idUser,
            int idArticulo,
            int idTratamiento)
        {
            GestionDataSetTableAdapters.getSpecificStockTratamientoTableAdapter TA =
                new GestionDataSetTableAdapters.getSpecificStockTratamientoTableAdapter();
            GestionDataSet.getSpecificStockTratamientoDataTable DT = 
                new GestionDataSet.getSpecificStockTratamientoDataTable();

            TA.Fill(DT, idUser, idArticulo, idTratamiento);
            if (DT.Rows.Count > 0) return DT.Rows[0];
            else return null;
        }

    }
}
