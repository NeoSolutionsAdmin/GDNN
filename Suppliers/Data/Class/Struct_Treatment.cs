using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Data2.Class
{
    public class Struct_Treatment
    {

        public string Nombre;
        public decimal Precio;
        public DateTime FechaCreacion;
        public DateTime FechaCaducidad;
        public string Descripcion;
        public bool Allowed;
        public int Id;
        public List<Struct_Sesiones> ListaSesiones = new List<Struct_Sesiones>();
        
        Connection.D_Treatment DT = new Connection.D_Treatment();


        public Struct_Treatment(
            string p_nombre,
            string p_descripcion,
            DateTime p_fechacreacion,
            DateTime p_fechacaducidad,
            bool p_allowed)
        {
            Nombre = p_nombre;
            FechaCreacion = p_fechacreacion;
            FechaCaducidad = p_fechacaducidad;
            Descripcion = p_descripcion;
            Allowed = p_allowed;
        }

        

        public Struct_Treatment()
        {

        }

        public Struct_Treatment(DataRow DR)
        {
            Id = Convert.ToInt32(DR["Id"].ToString());
            Nombre = DR["Nombre"].ToString();
            Precio = Convert.ToDecimal(DR["Precio"].ToString());
            FechaCreacion = Convert.ToDateTime(DR["FechaCreacion"].ToString());
            FechaCaducidad = Convert.ToDateTime(DR["FechaCaducidad"].ToString());
            Descripcion = DR["Descripcion"].ToString();
            Allowed = Statics.Conversion.convertSQLToBoolean(DR["Allowed"]);
            AddSesionToList(Id);
        }

        /// <summary>
        /// Guarda los datos en la tabla
        /// </summary>
        public void Guardar()
        {
            
            DT.insertTreatment(
                Nombre,
                Precio,
                FechaCreacion,        //Se llama al método
                FechaCaducidad,
                Descripcion,
                Allowed);

            Id = DT.GetLastTreatment();
        }
        
        
        /// <summary>
        /// Borra los datos de una fila especifica
        /// </summary>
        public void Borrar()
        {
            DT.Delete_TreatmentById(Id);
        }

       
        
        public void Actualizar()
        {
            DT.updateTreatment(
                Nombre,
                Precio,
                FechaCreacion,
                FechaCaducidad,
                Descripcion,
                Allowed,
                Id);
        }

        private void AddSesionToList(int id)
        {
            DataTable D=DT.GetSesionesFromTreatment(id);
            for (int a = 0; a<D.Rows.Count;a++)
            {
                ListaSesiones.Add(new Struct_Sesiones(D.Rows[a]));
            }
            
        }


        public static Struct_Treatment GetTreatmentById(int p_id)
        {
            Connection.D_Treatment ST = new Connection.D_Treatment();
            DataRow DR = ST.Select_TreatmentById(p_id);
            return new Struct_Treatment(DR);
            

        }

        public static List<Struct_Treatment> SearchTreatment(string parametro)
        {
            Connection.D_Treatment DT = new Connection.D_Treatment();
            DataTable D = DT.Search_Tratamiento(parametro);
            if (D != null)
            {
                List<Struct_Treatment> ListaTemporal = new List<Struct_Treatment>();
                for (int a = 0; a < D.Rows.Count;a++)
                {
                    ListaTemporal.Add(new Struct_Treatment(D.Rows[a]));
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
