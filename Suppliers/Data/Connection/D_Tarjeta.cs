using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data2.Connection
{
    public static class D_Tarjeta
    {
        public static DataTable GetAvailableTarjetasByIdLocal(int IdLocal)
        {
            GestionDataSet.GetAvailableTarjetasByIdLocalDataTable DT = new GestionDataSet.GetAvailableTarjetasByIdLocalDataTable();
            GestionDataSetTableAdapters.GetAvailableTarjetasByIdLocalTableAdapter TA = new GestionDataSetTableAdapters.GetAvailableTarjetasByIdLocalTableAdapter();
            TA.Fill(DT, IdLocal);
            if (DT.Rows.Count > 0)
            {
                return DT;
            }
            else
            {
                return null;
            }
        }

        public static DataTable GetAllTarjetasByIdLocal(int IdLocal)
        {
            GestionDataSet.GetAllTarjetasByIdLocalDataTable DT = new GestionDataSet.GetAllTarjetasByIdLocalDataTable();
            GestionDataSetTableAdapters.GetAllTarjetasByIdLocalTableAdapter TA = new GestionDataSetTableAdapters.GetAllTarjetasByIdLocalTableAdapter();
            TA.Fill(DT, IdLocal);
            if (DT.Rows.Count > 0)
            {
                return DT;
            }
            else
            {
                return null;
            }
        }

        public static DataRow GetTarjetaById(int IdTarjeta)
        {
            GestionDataSet.GetTarjetaByIdDataTable DT = new GestionDataSet.GetTarjetaByIdDataTable();
            GestionDataSetTableAdapters.GetTarjetaByIdTableAdapter TA = new GestionDataSetTableAdapters.GetTarjetaByIdTableAdapter();
            TA.Fill(DT, IdTarjeta);
            if (DT.Rows.Count > 0)
            {
                return DT.Rows[0];
            }
            else
            {
                return null;
            }
        }

        public static void UpdateRecargoTarjeta(int IdTarjeta, decimal Recargo)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            QTA.UpdateRecargoTarjetaById(IdTarjeta, Recargo);

        }
        public static void UpdateNombreTarjeta(int IdTarjeta, string Name)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            QTA.UpdateNombreTarjetaById(IdTarjeta, Name);
        }
        public static void UpdateTarjetaAvailability(int IdTarjeta, bool Availability)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            QTA.UpdateAvailabilityTarjetaById(IdTarjeta, Availability);
        }

        public static void InsertarTarjeta(int IdLocal,decimal Recargo,string Nombre)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            QTA.INSERT_TARJETA(IdLocal, Recargo, Nombre);
        }

    }
}
