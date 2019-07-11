using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Data2.Connection
{
    public static class D_Ingresos
    {
        public static DataTable Select_IngresosBetweenDates(int IdLocal, DateTime DateStart, DateTime DateEnd)
        {
            GestionDataSet.Select_IngresosBetweenDatesDataTable DT = new GestionDataSet.Select_IngresosBetweenDatesDataTable();
            GestionDataSetTableAdapters.Select_IngresosBetweenDatesTableAdapter TA = new GestionDataSetTableAdapters.Select_IngresosBetweenDatesTableAdapter();
            TA.Fill(DT, IdLocal, Statics.Conversion.DateTimeToSql(DateStart), Statics.Conversion.DateTimeToSql(DateEnd));

            if (DT.Rows.Count > 0)
            {
                return DT;
            }
            else
            {
                return null;
            }
        }

        public static bool Insert_Ingreso (int IdLocal, decimal Monto, string Detalle, DateTime Fecha)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter TA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            int resultado = TA.Insert_Ingreso(IdLocal, Monto, Detalle, Statics.Conversion.DateTimeToSql(Fecha));

            if (resultado > 0)
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
