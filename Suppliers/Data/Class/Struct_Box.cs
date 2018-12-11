using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data2.Class
{
    public class Struct_Box
    {
        public int Id;
        public int IdSucursal;
        public string Detalle;
        public int IdProfesional;

        static Connection.D_Boxes DB = new Connection.D_Boxes();

        public Struct_Box()
        {

        }

        //Constructor con variables
        public Struct_Box(
            int p_id,
            int p_idsucursal,
            string p_detalle,
            int p_idprofesional
            )
        {
            Id = p_id;
            IdSucursal = p_idsucursal;
            Detalle = p_detalle;
            IdProfesional = p_idprofesional;
        }

        //Constructor con DataTable
        public Struct_Box(DataRow data)
        {
            Id = Convert.ToInt32(data["Id"].ToString());
            IdSucursal = Convert.ToInt32(data["IdSucursal"].ToString());
            Detalle = data["Detalle"].ToString();
            IdProfesional = Convert.ToInt32(data["IdProfesional"].ToString());
        }

        public static Struct_Box GetBoxById(int Id)
        {
            DataRow B = DB.GetBoxById(Id);
            if (B != null)
            {
                return new Struct_Box(B);
            }
            else
            {
                return null;
            }
        }

        public static List<Struct_Box> GetBoxesBySucursal(int SucursalId)
        {
            DataTable B = DB.GetBoxesBySucursal(SucursalId);
            List<Struct_Box> Aux = new List<Struct_Box>();
            if (B != null)
            {
                foreach (DataRow box in B.Rows)
                {
                    Aux.Add(new Struct_Box(box));
                }
                return Aux;
            }
            else
            {
                return null;
            }
        }

    }
}
