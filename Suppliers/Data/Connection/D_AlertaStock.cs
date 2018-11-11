using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Data2.Connection
{
    public class D_AlertaStock
    {
        public static void InsertarUsuarioAlerta(int iduser)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            QTA.AgregarUserParaAlertar(iduser);
            
        }

        public static void InsertarProductoAlertar(int ProductID, decimal StockMinimo)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            QTA.AgregarProductoConAlertaDeStock(ProductID, StockMinimo);

        }

        public static DataTable RecuperarUsuariosConAlerta()
        {
            GestionDataSet.RecuperarUsuariosParaAlertarDataTable DT = new GestionDataSet.RecuperarUsuariosParaAlertarDataTable();
            GestionDataSetTableAdapters.RecuperarUsuariosParaAlertarTableAdapter TA = new GestionDataSetTableAdapters.RecuperarUsuariosParaAlertarTableAdapter();
            TA.Fill(DT);
            if (DT.Rows.Count > 0)
            {
                return DT;
            }
            else
            {
                return null;
            }
        }

        public static void SetearCantidadMin(int Prod, int cant)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            QTA.ModificarProductoConAlertaDeStock(Prod, cant);
        }

        public static DataTable RecuperarProductosConAlerta()
        {
            GestionDataSet.RecuperarProductosConAlertaDeStockDataTable DT = new GestionDataSet.RecuperarProductosConAlertaDeStockDataTable();
            GestionDataSetTableAdapters.RecuperarProductosConAlertaDeStockTableAdapter TA = new GestionDataSetTableAdapters.RecuperarProductosConAlertaDeStockTableAdapter();
            TA.Fill(DT);
            if (DT.Rows.Count > 0)
            {
                return DT;
            }
            else
            {
                return null;
            }
        }

        public static void QuitarUsuario(int UserId)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            QTA.BorrarUserParaAlertar(UserId);
        }

        public static void QuitarProducto(int ProdId)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            QTA.BorrarProductoConAlerta(ProdId);
        }
    
    }
}
