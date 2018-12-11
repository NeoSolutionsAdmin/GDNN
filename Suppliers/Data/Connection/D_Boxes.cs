using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data2.Connection
{
    class D_Boxes
    {
        public DataTable GetBoxesBySucursal(int IdSucursal)
        {
            GestionDataSetTableAdapters.GetBoxesBySucursalTableAdapter TA = new GestionDataSetTableAdapters.GetBoxesBySucursalTableAdapter();
            GestionDataSet.GetBoxesBySucursalDataTable DT = new GestionDataSet.GetBoxesBySucursalDataTable();
            TA.Fill(DT, IdSucursal);

            if (DT.Rows.Count > 0) return DT;
            else return null;
        }

        public DataRow GetBoxById(int IdBox)
        {
            GestionDataSetTableAdapters.Get_BoxByIdTableAdapter TA = new GestionDataSetTableAdapters.Get_BoxByIdTableAdapter();
            GestionDataSet.Get_BoxByIdDataTable DR = new GestionDataSet.Get_BoxByIdDataTable();
            TA.Fill(DR, IdBox);

            if (DR.Rows.Count > 0) return DR[0];
            else return null;
        }

    }
}
