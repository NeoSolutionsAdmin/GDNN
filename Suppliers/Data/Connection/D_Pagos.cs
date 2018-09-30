using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Data2.Connection
{
    public static class D_Pagos
    {
        public static DataTable getPagosBetweenDates(int IdUser, DateTime FechaStart, DateTime FechaEnd)
        {
            GestionDataSetTableAdapters.select_pagosbetweendatesTableAdapter TA = new GestionDataSetTableAdapters.select_pagosbetweendatesTableAdapter();
            GestionDataSet.select_pagosbetweendatesDataTable DT = new GestionDataSet.select_pagosbetweendatesDataTable();
            TA.Fill(DT, IdUser, Statics.Conversion.DateTimeToSql(FechaStart), Statics.Conversion.DateTimeToSql(FechaEnd));
            if (DT.Rows.Count > 0)
            {
                return DT;
            }
            else
            {
                return null;
            }
        }

        public static bool Insert_Pago(
            int IdUser,
            int IdSeller,
            DateTime Fecha,
            decimal Monto,
            string detalle
            )
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            if (QTA.InsertPago(IdUser, IdSeller, Statics.Conversion.DateTimeToSql(Fecha), Monto, detalle) > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

    }
}
