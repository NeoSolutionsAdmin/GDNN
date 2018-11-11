using Data2.Connection;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data2.Class
{
    public class Struct_AlertaProducto
    {
        public int IdProducto;
        public decimal MinCant;
        public int Id;


        private Struct_AlertaProducto(DataRow dr)
        {
            Id = int.Parse(dr["Id"].ToString());
            IdProducto = int.Parse(dr["Id_Producto"].ToString());
            MinCant = Statics.Conversion.GetDecimal(dr["Stock_Minimo"].ToString());
        }

        public Struct_Producto getProducto()
        {
            Struct_Producto p = Struct_Producto.GetById(IdProducto);
            if (p != null)
            {
                return p;
            }
            else
            {
                return null;
            }
        }



        public static void SetMinCant(int idprod, int cant)
        {
            Data2.Connection.D_AlertaStock.SetearCantidadMin(idprod, cant);
        }

        public static void QuitarProducto(int idprod)
        {
            Connection.D_AlertaStock.QuitarProducto(idprod);
        }

        public static List<Struct_AlertaProducto> GetAllProducts()
        {
            DataTable dt = D_AlertaStock.RecuperarProductosConAlerta();
            if (dt != null)
            {
                List<Struct_AlertaProducto> lista = new List<Struct_AlertaProducto>();
                foreach (DataRow dr in dt.Rows)
                {
                    Struct_AlertaProducto prod = new Struct_AlertaProducto(dr);
                    if (Struct_Producto.GetById(prod.IdProducto) != null)
                    {
                        lista.Add(prod);
                    }
                }
                if (lista.Count > 0) { return lista; } else { return null; }
            }
            else
            {
                return null;
            }
        }
    }
}
