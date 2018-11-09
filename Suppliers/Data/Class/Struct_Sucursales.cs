using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Data2.Class
{
    public class Struct_Sucursales
    {
        public int Id;
        public string NombreLocal;

        private Struct_Sucursales(DataRow DR)
        {
            Id = int.Parse(DR["Id"].ToString());
            NombreLocal = DR["NombreLocal"].ToString();
        }



        /// <summary>
        /// Devuelve una lista con todos los ítems de la tabla con los resultados de la búsqueda
        /// </summary>
        /// <param name="busqueda">Parámetro de búsqueda</param>
        /// <returns>Devuelve la lista con los resultados</returns>
        public static List<Struct_Sucursales> searchLocales(string busqueda)
        {
            List<Struct_Sucursales> listaSucursales = new List<Struct_Sucursales>();
            Connection.D_Sucursales DS = new Connection.D_Sucursales();
            DataTable D = DS.searchSucursales(busqueda);
            if (D != null)
            {
                foreach (DataRow DR in D.Rows)
                {
                    Struct_Sucursales SS = new Struct_Sucursales(DR);
                    listaSucursales.Add(SS);
                }
                return listaSucursales;
            }
            else return null;
        }

        


    }
}
