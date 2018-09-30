using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Data2.Connection
{
    public class D_Vendedores
    {
        public int logme(int iduser, string seller, string pass)
        {
            GestionDataSet.LogmeDataTable DT = new GestionDataSet.LogmeDataTable();
            GestionDataSetTableAdapters.LogmeTableAdapter TA = new GestionDataSetTableAdapters.LogmeTableAdapter();
            TA.Fill(DT, seller, pass, iduser);
            if (DT.Rows.Count > 0)
            {
                return int.Parse(DT.Rows[0]["Id"].ToString());
            }
            else
            {
                return -1;
            }

        }

        public bool UpdatePassword(int IdVendedor, int IdUser, string password)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            int cambios = QTA.Update_Password_Vendedor(IdUser, IdVendedor, password);
            if (cambios != 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool Insert_Vendedor(string NombreVendedor, int IdUser, decimal Porcentaje) 
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            int _cambios = QTA.Insert_Vendedor(IdUser, NombreVendedor, Porcentaje);
            if (_cambios != 0)
            {
                return true;
            }
            else 
            {
                return false;
            }

        }

        public DataTable Get_All_Vendedores(int IdUser)
        {
            GestionDataSetTableAdapters.GetVendedoresByIdUserTableAdapter TA = new GestionDataSetTableAdapters.GetVendedoresByIdUserTableAdapter();
            GestionDataSet.GetVendedoresByIdUserDataTable DT = new GestionDataSet.GetVendedoresByIdUserDataTable();
            TA.Fill(DT,IdUser);
            if (DT.Rows.Count>0)
            {
                return DT;
            } else 
            {
                return null;
            }
        }

        public bool Delete_Vendedor(int IdVendedor, int Iduser) 
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            int _change = QTA.Delete_Vendedor(Iduser, IdVendedor);
            if (_change != 0)
            {
                return true;
            }
            else 
            {
                return false;
            }
        }

        public DataRow get_vendedorById(int IdVendedor)
        {
            GestionDataSet.GetVendedorByIdDataTable DT = new GestionDataSet.GetVendedorByIdDataTable();
            GestionDataSetTableAdapters.GetVendedorByIdTableAdapter TA = new GestionDataSetTableAdapters.GetVendedorByIdTableAdapter();
            TA.Fill(DT, IdVendedor);
            if (DT.Rows.Count > 0)
            {
                return DT.Rows[0];
            }
            else
            {
                return null;
            } 
        }

        public bool Update_Vendedor(string NombreVendedor, int IdUser, int IdVendedor, decimal Porcentaje)
        {
            GestionDataSetTableAdapters.QueriesTableAdapter QTA = new GestionDataSetTableAdapters.QueriesTableAdapter();
            int _change = QTA.UpdateVendedor(IdUser, IdVendedor, NombreVendedor, Porcentaje);
            if (_change != 0)
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
