using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Data2.Statics;


namespace Data2.Connection
{
    public static class D_ArqueoDeCaja
    {

        public static void InsertArqueo(int IdLocal, decimal Total, DateTime Fecha, String Anotaciones)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            QTA.InsertArqueo(IdLocal, Total, Statics.Conversion.DateTimeToSql(Fecha), Anotaciones);
        }

        public static DataTable GetArqueosBetweenDates(DateTime Start, DateTime End, int IdLocal)
        {
            GestionDataSet.GetArqueosBetweenDatesDataTable DT = new GestionDataSet.GetArqueosBetweenDatesDataTable();
            GestionDataSetTableAdapters.GetArqueosBetweenDatesTableAdapter TA = new GestionDataSetTableAdapters.GetArqueosBetweenDatesTableAdapter();
            TA.Fill(DT, IdLocal, Conversion.DateTimeToSql(Start), Conversion.DateTimeToSql(End));
            if (DT.Rows.Count > 0)
            {
                return DT;
            }
            else
            {
                return null;
            }
        }

        public static DataRow GetLastAqrqueo(int IdLocal)
        {
            GestionDataSet.GetLastArqueoDataTable DT = new GestionDataSet.GetLastArqueoDataTable();
            GestionDataSetTableAdapters.GetLastArqueoTableAdapter TA = new GestionDataSetTableAdapters.GetLastArqueoTableAdapter();
            TA.Fill(DT, IdLocal);
            if (DT.Rows.Count > 0)
            {
                return DT.Rows[0];
            }
            else
            {
                return null;
            }
        }

    }
}
