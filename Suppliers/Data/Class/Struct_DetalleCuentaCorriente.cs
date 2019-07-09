using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Data2.Class
{
    public class Struct_DetalleCuentaCorriente
    {
        public enum TipoDetalleCC { Entrega, Factura, Inicializacion, ErrorEnMovimiento }
        public DateTime Fecha;
        public TipoDetalleCC TIPOCC;
        public decimal Monto;
        public int IdFactura=0;
        public int Local = 0;
        public int IdCliente = 0;
        public Struct_DetalleCuentaCorriente(DataRow DR, int IdUser)
        {
            IdCliente = Convert.ToInt32(DR["IdCliente"].ToString());
            Fecha = DateTime.Parse(DR["Fecha"].ToString());
            Monto = Statics.Conversion.GetDecimal(DR["Importe"].ToString());
            if (DR.IsNull("IdLocal") == false)
            {
                Local = int.Parse(DR["IdLocal"].ToString());
            }
            switch (DR["TipoMovimiento"].ToString())
            {
                case "F":
                    TIPOCC = TipoDetalleCC.Factura;
                    Connection.D_Factura CONN = new Connection.D_Factura();
                    int IdF = int.Parse(DR["IdFactura"].ToString());
                    IdFactura = IdF;
                    DataRow _DR = CONN.GetFacturaById(IdUser, IdF);
                    Monto = new Struct_Factura(_DR).total;
                    break;
                case "I":
                    TIPOCC = TipoDetalleCC.Inicializacion;
                    break;
                case "E":
                    TIPOCC = TipoDetalleCC.Entrega;
                    break;
                    default:
                        TIPOCC=TipoDetalleCC.ErrorEnMovimiento;
                        break;
            }


        }

        public static List<Struct_DetalleCuentaCorriente> Obtener_movimientosBetweenDates(DateTime Start, DateTime End, int IdLocal, TipoDetalleCC TipoMove)
        {
            string mov = "";
            switch (TipoMove)
            {

                case TipoDetalleCC.Entrega: mov = "E";break;
                case TipoDetalleCC.Factura: mov = "F";break;
            }
            
            DataTable Tabla = Connection.D_Clientes.GetMovimientosBetweenDates(Start, End, IdLocal,mov);
            
            if (Tabla != null)
            {
                List<Struct_DetalleCuentaCorriente> ListaAuxiliar = new List<Struct_DetalleCuentaCorriente>();

                foreach (DataRow dr in Tabla.Rows)
                {
                    Struct_DetalleCuentaCorriente detalleauxiliar = new Struct_DetalleCuentaCorriente(dr, IdLocal);
                    ListaAuxiliar.Add(detalleauxiliar);
                }
                return ListaAuxiliar;
            }
            else
            {
                return null;
            }

        }




    }
}
