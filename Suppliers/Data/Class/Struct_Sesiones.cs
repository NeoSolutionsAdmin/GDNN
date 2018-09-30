using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Data2.Class
{

    
    public class Struct_Sesiones
    {

        public int IdTratamiento;
        public string Nombre;
        public decimal Monto;
        public decimal Costo;
        public string Descripcion;
        public int Id;

        Connection.D_Sesiones DS = new Connection.D_Sesiones();


        /// <summary>
        /// Constructor. Guarda los parámetros en las variables del mismo nombre
        /// </summary>
        /// <param name="p_idtratamiento"></param>
        /// <param name="p_nombre"></param>
        /// <param name="p_monto"></param>
        /// <param name="p_costo"></param>
        /// <param name="p_descripcion"></param>
        public Struct_Sesiones(
            int p_idtratamiento,
            string p_nombre,
            decimal p_monto,
            decimal p_costo,
            string p_descripcion)
        {
            IdTratamiento = p_idtratamiento;
            Nombre = p_nombre;
            Monto = p_monto;
            Costo = p_costo;
            Descripcion = p_descripcion;
        }

        /// <summary>
        /// Constructor DataRow. Toma los datos de un DataRow y los pasa a las variables
        /// </summary>
        /// <param name="DR">Fila de datos a pasar</param>
        public Struct_Sesiones(DataRow DR)
        {
            IdTratamiento = Convert.ToInt32(DR["IdTratamiento"].ToString());
            Nombre = DR["Nombre"].ToString();
            Monto = Convert.ToDecimal(DR["Monto"].ToString());
            Costo = Convert.ToDecimal(DR["Monto"].ToString());
            Descripcion = DR["Descripcion"].ToString();
            Id = Convert.ToInt32(DR["Id"].ToString());
        }



        /// <summary>
        /// Guarda los datos en la tabla
        /// </summary>
        public void Guardar()
        {
            DS.Insert_Sesion(
                IdTratamiento,
                Nombre,
                Monto,
                Costo,
                Descripcion);

            Id = DS.GetLastSession();
        }

        /// <summary>
        /// Borra una fila específica
        /// </summary>
        public void Borrar()
        {
            DS.Delete_SesionById(Id);
        }


      
        /// <summary>
        /// ACtualiza una fila de la tabla
        /// </summary>
        public void Actualizar()
        {
            DS.Update_Sesion(
                IdTratamiento,
                Nombre, Monto,
                Costo,
                Descripcion,
                Id);
        }


        public List<Struct_Sesiones> SearchSesiones(string parametro)
        {
            DataTable D = DS.SearchSesion(parametro);
            if (D != null)
            {
                List<Struct_Sesiones> ListaTemporal = new List<Struct_Sesiones>();
                for (int a = 0; a < D.Rows.Count; a++)
                {
                    ListaTemporal.Add(new Struct_Sesiones(D.Rows[a]));
                }
                return ListaTemporal;
            }
            else
            {
                return null;
            }
        }


    }
}
