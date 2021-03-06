﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data2.Class
{
    public class Struct_DetalleRemito
    {
        public Struct_Producto P;
        public Struct_Unidades U;
        public int CANTINT;
        public decimal CANTDEC;
        public int Id;
        public int IdRemito;
        public int IdArticulo;
        public decimal Costo;
        public decimal Total;
        public bool IsDecimal;

        public Struct_DetalleRemito(System.Data.DataRow _DR, int IdUser) 
        {
            Id = int.Parse(_DR["Id"].ToString());
            IdRemito = int.Parse(_DR["IdRemito"].ToString());
            IdArticulo = int.Parse(_DR["IdArticulo"].ToString());
            Costo = Statics.Conversion.GetDecimal(_DR["Costo"].ToString());
            CANTDEC = Statics.Conversion.GetDecimal(_DR["CantDEC"].ToString());
            CANTINT = int.Parse(_DR["CantINT"].ToString());
            Total = Statics.Conversion.GetDecimal(_DR["Total"].ToString());
            P = Struct_Producto.Get_SingleArticle(IdUser, IdArticulo);
            U = new Struct_Unidades(P.IdUnidad);


        }

        public decimal getTotal() 
        {
            decimal total = 0;
            if (IsDecimal == true)
            {
                total = CANTDEC * P.PrecioCompra;
            }
            else
            {
                total = CANTINT * P.PrecioCompra;
            }
            return total;
        }

        public void SaveNewStock() 
        {
            int t_cantint = P.CantidadINT + CANTINT;
            decimal t_cantdec = P.CantidadDEC + CANTDEC;
            if (IsDecimal==true) 
            {
                P.UpdateStock(t_cantdec.ToString());
            } else 
            {
                P.UpdateStock(t_cantint.ToString());
            }
        }

        public bool SaveDetalle(int IdRemito) 
        {
            Data2.Connection.D_Remito R = new Connection.D_Remito();
            decimal total = 0;
            if (IsDecimal==true)
            {
                total = CANTDEC * P.PrecioCompra;
            } else 
            {
                total = CANTINT * P.PrecioCompra;
            }
            return R.insert_DetalleRemito(IdRemito, P.Id, P.PrecioCompra, CANTDEC, CANTINT, total);
        }

        public void setCANT(string CANT)
        {
            if (P != null)
            {
                U = new Struct_Unidades(P.IdUnidad);
                if (U != null)
                {
                    IsDecimal = U.Decimal;
                    switch (U.Decimal)
                    {
                        case true:
                            CANTDEC = Data2.Statics.Conversion.GetDecimal(CANT);
                            break;
                        case false:
                            CANTINT = int.Parse(CANT);
                            break;
                    }
                }
            }
        }

        public Struct_DetalleRemito(int IdArt, int IdUser, string CANT) 
        {
            P = Struct_Producto.Get_SingleArticle(IdUser, IdArt);
            if (P != null) 
            {
                U = new Struct_Unidades(P.IdUnidad);
                if (U != null) 
                {
                    IsDecimal = U.Decimal;
                    switch (U.Decimal)
                    {
                        case true: 
                            CANTDEC = Data2.Statics.Conversion.GetDecimal(CANT);
                            break;
                        case false: 
                            CANTINT = int.Parse(CANT);
                            break;
                    }
                }
            }
        }
    }
}
