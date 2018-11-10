using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data2.Connection
{
    public class D_Treatment
    {

        /// <summary>
        /// Busca un tratamiento por el string que ingreses
        /// </summary>
        /// <param name="stringdebusqueda">Cadena de texto usada para la búsqueda</param>
        /// <returns></returns>
        public DataTable Search_Tratamiento(int LocalId, string stringdebusqueda)
        {
            GestionDataSetTableAdapters.Search_TratamientoTableAdapter TA = new GestionDataSetTableAdapters.Search_TratamientoTableAdapter();
            GestionDataSet.Search_TratamientoDataTable DT = new GestionDataSet.Search_TratamientoDataTable();
            TA.Fill(DT, LocalId, stringdebusqueda);
            if (DT.Rows.Count > 0)
            {
                return DT;
            }
            else return null;
        }
        /// <summary>
        /// Insertar en la tabla de tratamientos. Devuelve un bool si 
        /// la función insertó o no un tratamiento.
        /// </summary>
        /// <param name="nombre">Nombre del tratamiento.</param>
        /// <param name="precio">Precio del tratamiento</param>
        /// <param name="fechacre">Fecha que se comenzó a usar el tratamiento.</param>
        /// <param name="fechacad">Fecha que terminó de usarse el tratamiento.</param>
        /// <param name="descripcion">Descripción del tratamiento.</param>
        /// <param name="allowed">Si el tratamiento sigue en uso.</param>
        /// <returns></returns>
        public bool insertTreatment(
            int localID,
            string nombre,
            decimal precio,
            DateTime fechacre,
            DateTime fechacad,
            string descripcion,
            bool allowed)
        {            
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            int r = QTA.Insert_Treatment(localID, nombre, precio, fechacre, fechacad, descripcion, allowed);

            if (r == 0) return false; //Chequea si se insertó algo o no
            else return true; 
            
        }


        /// <summary>
        /// Actualiza un tratamiento. Devuelve un bool si 
        /// la función actualizó o no un tratamiento.
        /// </summary>
        /// <param name="nombre">Nombre del tratamiento.</param>
        /// <param name="fechacre">Fecha que se comenzó a usar el tratamiento.</param>
        /// <param name="fechacad">Fecha que terminó de usarse el tratamiento.</param>
        /// <param name="descripcion">Descripción del tratamiento.</param>
        /// <param name="allowed">Si el tratamiento sigue en uso.</param>
        /// <param name="id">Fila a actualizar.</param>
        /// <returns></returns>
        public bool updateTreatment(
            string nombre,
            decimal precio,
            DateTime fechacre,
            DateTime fechacad,
            string descripcion,
            bool allowed,
            int id)
        {
            
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            int r = QTA.Update_Treatment(nombre, precio, fechacre, fechacad, descripcion, allowed, id);

            if (r == 0) return false;   //Chequea si se actualizó algo o no
            else return true;

        }


        /// <summary>
        /// Actualiza la columna "allowed" a positivo de determinada fila.
        /// Devuelve un bool si se actualizó o no
        /// </summary>
        /// <param name="id">Fila a actualizar</param>
        /// <returns></returns>
        public bool allowTreatment(int id)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            int r = QTA.Allow_Treatment(id);

            if (r == 0) return false; //Chequea si se actualizó algo o no
            else return true;
        }


        /// <summary>
        /// Actualiza la columna "allowed" a negativo de determinada fila.
        /// Devuelve un bool si se actualizó o no
        /// </summary>
        /// <param name="id">Fila a actualizar</param>
        /// <returns></returns>
        public bool unallowTreatment(int id)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            int r = QTA.Unallow_Treatment(id);

            if (r == 0) return false;   //Chequea si se actualizó algo o no
            else return true;
        }


        /// <summary>
        /// Devuelve los datos de determinado Id
        /// </summary>
        /// <param name="id">Id de la fila a seleccionar</param>
        /// <returns></returns>
        public DataRow Select_TreatmentById(int id)
        {
            GestionDataSetTableAdapters.Select_TreatmentByIDTableAdapter TA = new GestionDataSetTableAdapters.Select_TreatmentByIDTableAdapter();
            GestionDataSet.Select_TreatmentByIDDataTable DT = new GestionDataSet.Select_TreatmentByIDDataTable();
            TA.Fill(DT, id);

            if (DT.Rows.Count > 0) return DT.Rows[0];   //Chequea si se seleccionó algo o no
            else return null;
        }

        /// <summary>
        /// Elimina una fila de la tabla. Devuelve un bool si se eliminó algo o no
        /// </summary>
        /// <param name="id">Fila a eliminar</param>
        /// <returns></returns>
        public bool Delete_TreatmentById(int id)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            int r = QTA.Delete_TreatmentById(id);
            QTA.Delete_SesionById(id);

            if (r == 0) return false;   //Chequea si se eliminó algo o no
            else return true;
        }


        /// <summary>
        /// Devuelve el id del último tratamiento
        /// </summary>
        /// <returns></returns>
        public int GetLastTreatment()
        {

            GestionDataSetTableAdapters.GetLastTreatmentTableAdapter TA = new GestionDataSetTableAdapters.GetLastTreatmentTableAdapter();
            GestionDataSet.GetLastTreatmentDataTable DT = new GestionDataSet.GetLastTreatmentDataTable();
            TA.Fill(DT);
            return int.Parse(DT.Rows[0]["Id"].ToString());            
    
        }

        public DataTable GetSesionesFromTreatment(int idtratamiento)
        {
            GestionDataSetTableAdapters.GetSesionesFromTreatmetTableAdapter TA = new GestionDataSetTableAdapters.GetSesionesFromTreatmetTableAdapter();
            GestionDataSet.GetSesionesFromTreatmetDataTable DT = new GestionDataSet.GetSesionesFromTreatmetDataTable();
            TA.Fill(DT, idtratamiento);
            if (DT.Rows.Count > 0) return DT;
            else return null;

        }
        
        public DataTable GetTreatmentsBySucursales(int IdSucursal)
        {
            GestionDataSetTableAdapters.GetTreatmentsBySucursalTableAdapter TA = new GestionDataSetTableAdapters.GetTreatmentsBySucursalTableAdapter();
            GestionDataSet.GetTreatmentsBySucursalDataTable DT = new GestionDataSet.GetTreatmentsBySucursalDataTable();
            TA.Fill(DT, IdSucursal);
            if (DT.Rows.Count > 0) return DT;
            else return null;
        }
    }
}
