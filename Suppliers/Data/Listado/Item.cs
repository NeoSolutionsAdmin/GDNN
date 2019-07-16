using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Data2.Class;

namespace Data2.Listado
{

    public class Item
    {
        public enum Tipo { Factura, MovCC, Retiro, Ingreso, TarjetaCC }

        public DateTime tiempo;
        public Tipo tipoDeItem;
        public object objeto;

        public Item (Struct_DetalleCuentaCorriente d)
        {
            objeto = d;
            tiempo = d.Fecha;
            if (d.TIPOCC == Struct_DetalleCuentaCorriente.TipoDetalleCC.Entrega)
            {
                tipoDeItem = Tipo.MovCC;
            }
            else if (d.TIPOCC == Struct_DetalleCuentaCorriente.TipoDetalleCC.Tarjeta)
            {
                tipoDeItem = Tipo.TarjetaCC;
            }
        }

        public Item (Struct_Factura f)
        {
            objeto = f;
            tiempo = f.Fecha;
            tipoDeItem = Tipo.Factura;
        }

        public Item (Struct_Ingresos I)
        {
            objeto = I;
            tiempo = I.FECHA;
            tipoDeItem = Tipo.Ingreso;
        }

        public Item(Struct_Retiro r)
        {
            objeto = r;
            tiempo = r.FEcha;
            tipoDeItem = Tipo.Retiro;
        }
    }
}
