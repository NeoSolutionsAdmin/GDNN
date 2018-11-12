using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data2.Connection
{
    public static class D_Turno
    {
        public static DataRow GetTurnoById(int IdTurno)
        {
            GestionDataSet.SELECT_DateAgendaByIdDataTable DT = new GestionDataSet.SELECT_DateAgendaByIdDataTable();
            GestionDataSetTableAdapters.SELECT_DateAgendaByIdTableAdapter TA = new GestionDataSetTableAdapters.SELECT_DateAgendaByIdTableAdapter();
            TA.Fill(DT, IdTurno);
            if (DT.Rows.Count > 0)
            {
                return DT.Rows[0];
            }
            else
            {
                return null;
            }
        }

        public static bool GuardarTurno(DateTime DateReservacion,int IdCliente,int IdUsuario, int IdSesion, string Estado)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            int result = QTA.INSERT_DateAgenda(DateReservacion, IdCliente, IdUsuario, IdSesion, Estado);
            if (result == 1) { return true; } else { return false; }
        }

        public static DataTable GetTurnosEntreDias(DateTime Start, DateTime End, int UserId)
        {
            GestionDataSet.SELECT_DateAgendaBetweenDateDataTable DT = new GestionDataSet.SELECT_DateAgendaBetweenDateDataTable();
            GestionDataSetTableAdapters.SELECT_DateAgendaBetweenDateTableAdapter TA = new GestionDataSetTableAdapters.SELECT_DateAgendaBetweenDateTableAdapter();
            TA.Fill(DT, Start, End,UserId);
            if (DT.Rows.Count > 0)
            {
                return DT;
            }
            else
            {
                return null;
            }

        }
    }
}
