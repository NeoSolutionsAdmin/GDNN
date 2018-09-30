using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Data2.Connection
{
    class D_Sesiones
    {

        /// <summary>
        /// Insertar en la tabla de sesiones. Devuelve un bool si 
        /// la función insertó o no una sesion. 
        /// </summary>
        /// <param name="idtratamiento">ID del tratamiento de la sesion</param>
        /// <param name="nombre">Nombre de la sesion</param>
        /// <param name="monto">Monto de la sesion</param>
        /// <param name="costo">Costo de la sesion</param>
        /// <param name="descripcion">Descripcion de la sesion</param>
        /// <returns></returns>
        public bool Insert_Sesion(
            int idtratamiento,
            string nombre,
            decimal monto,
            decimal costo,
            string descripcion)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            int r = QTA.Insert_Sesion(idtratamiento, nombre, monto, costo, descripcion);

            if (r == 0) return false;   //Chequea si se insertó algo o no
            else return true;
        }


        /// <summary>
        /// Actualiza una sesion. Devuelve un bool si 
        /// la función actualizó o no una sesion.
        /// </summary>
        /// <param name="idtratamiento">Id del tratamiento de la sesion</param>
        /// <param name="nombre">Nombre de la sesion</param>
        /// <param name="monto">Monto de la sesion</param>
        /// <param name="costo">Costo de la sesion</param>
        /// <param name="descripcion">Descripcion de la sesion</param>
        /// <param name="id">Fila a actualizar</param>
        /// <returns></returns>
        public bool Update_Sesion(int idtratamiento,
            string nombre,
            decimal monto,
            decimal costo,
            string descripcion,
            int id)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            int r = QTA.Update_Sesion(idtratamiento,nombre,monto,costo,descripcion,id);

            if (r == 0) return false;   //Chequea si se actualizó algo o no
            else return true;
            
        }

        /// <summary>
        /// Elimina una fila de la tabla
        /// </summary>
        /// <param name="id">FIla a eliminar</param>
        /// <returns></returns>
        public bool Delete_SesionById(int id)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            int r = QTA.Delete_SesionById(id);

            if (r == 0) return false;
            else return true;
            

        }

        /// <summary>
        /// Devuelve todos los datos de la tabla
        /// </summary>
        /// <returns></returns>
        public DataTable Select_Sesion()
        {
            GestionDataSetTableAdapters.Select_SesionTableAdapter TA = new GestionDataSetTableAdapters.Select_SesionTableAdapter();
            GestionDataSet.Select_SesionDataTable DT = new GestionDataSet.Select_SesionDataTable();
            TA.Fill(DT);

            if (DT.Rows.Count > 0) return DT;
            else return null;
        }

        


        /// <summary>
        /// Devuelve todos los datos de una fila específica de la tabla
        /// </summary>
        /// <param name="fila">Fila con los datos a devolver</param>
        /// <returns></returns>
        public DataRow Select_SesionById(int id)
        {
            GestionDataSetTableAdapters.Select_SesionByIDTableAdapter TA = new GestionDataSetTableAdapters.Select_SesionByIDTableAdapter();
            GestionDataSet.Select_SesionByIDDataTable DT = new GestionDataSet.Select_SesionByIDDataTable();
            TA.Fill(DT, id);

            if (DT.Rows.Count > 0) return DT.Rows[0];   //Chequea si se seleccionó algo o no
            else return null;
            
        }


        public int GetLastSession()
        {
            GestionDataSetTableAdapters.GetLastSessionTableAdapter TA = new GestionDataSetTableAdapters.GetLastSessionTableAdapter();
            GestionDataSet.GetLastSessionDataTable DT = new GestionDataSet.GetLastSessionDataTable();
            TA.Fill(DT);
            return Convert.ToInt32(DT.Rows[0]["Id"]);
        }

        public DataTable SearchSesion(string parametro)
        {
            GestionDataSetTableAdapters.Search_SesionTableAdapter TA = new GestionDataSetTableAdapters.Search_SesionTableAdapter();
            GestionDataSet.Search_SesionDataTable DT = new GestionDataSet.Search_SesionDataTable();
            TA.Fill(DT, parametro);
            if (DT.Rows.Count > 0) return DT;
            else return null;
        }

        
    }
}
