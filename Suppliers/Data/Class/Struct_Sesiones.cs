using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Data2.Class
{

    
    class Struct_Sesiones
    {

        public int IdTratamiento;
        public string Nombre;
        public decimal Monto;
        public decimal Costo;
        public string Descripcion;
        public int Id;

        Connection.D_Sesiones DS = new Connection.D_Sesiones();



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
        /// <param name="p_id">Id de la fila</param>
        public void Borrar(int p_id)
        {
            Id = p_id;                   //Se igualan los parametros
            DS.Delete_SesionById(p_id);
        }


        /// <summary>
        /// Actualiza los datos de la tabla en determinada fila
        /// </summary>
        /// <param name="p_idtratamiento">Id del tratamiento de la sesion</param>
        /// <param name="p_nombre">Nombre de la sesion</param>
        /// <param name="p_monto">Monto de la sesion</param>
        /// <param name="p_costo">Costo de la sesion</param>
        /// <param name="p_descripcion">Descripción de la sesion</param>
        /// <param name="p_id">Id de la fila</param>
        public void Actualizar(int p_idtratamiento,
            string p_nombre,
            decimal p_monto,
            decimal p_costo,
            string p_descripcion,
            int p_id)
        {
            IdTratamiento = p_idtratamiento;
            Nombre = p_nombre;
            Monto = p_monto;                //Se igualan los parametros
            Costo = p_costo;
            Descripcion = p_descripcion;
            Id = p_id;

            DS.Update_Sesion(p_idtratamiento,p_nombre,p_monto,p_costo,p_descripcion,p_id);
        }


    }
}
