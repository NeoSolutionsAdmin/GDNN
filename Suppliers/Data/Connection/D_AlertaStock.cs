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
    
    }
}
