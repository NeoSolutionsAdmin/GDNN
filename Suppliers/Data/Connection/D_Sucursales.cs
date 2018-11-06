using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Data2.Connection
{
    class D_Sucursales
    {

        /// <summary>
        /// Devuelve una tabla con los resultados de la búsqueda
        /// </summary>
        /// <param name="stringBusqueda">String usado para la búsqueda</param>
        /// <returns>Devuelve un DataTable con los resultados de la búsqueda</returns>
        public DataTable searchSucursales(string stringBusqueda)
        {
            GestionDataSetTableAdapters.searchLocalesTableAdapter TA =
                new GestionDataSetTableAdapters.searchLocalesTableAdapter();
            GestionDataSet.searchLocalesDataTable DT =
                new GestionDataSet.searchLocalesDataTable();

            TA.Fill(DT, stringBusqueda);

            if (DT.Rows.Count != 0) return DT;            
            return null;
        }

    }
}
