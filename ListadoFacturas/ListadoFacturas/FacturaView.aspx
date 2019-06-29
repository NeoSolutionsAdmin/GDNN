<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FacturaView.aspx.cs" Inherits="Christoc.Modules.ListadoFacturas.FacturaView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="font-size: 30px; padding-bottom:10px">FERRETERIA ARGENTINA</div>
        <div style="font-size: 15px">José María Parola 640 - (5917) Arroyo Cabral (Cba.)</div>
        <div style="font-size: 15px">Cel: 3534088987</div>
        <div style="font-size: 15px">Mail: ferreteriaargentina19@gmail.com</div>
        <div style="font-size: 15px">Fecha: <%=(DateTime.Now.Day.ToString()+"/"+DateTime.Now.Month.ToString() + "/" + DateTime.Now.Year.ToString()) %></div>
        <div style="background-color:black;width:100%;height:3px;margin-top:5px;margin-bottom:5px"></div>
        <div style="text-align:center">
            <span style="margin:5px 5px 5px 5px;font-size: 25px;display: inline-block;width: 64px;height: 64px;line-height: 64px;vertical-align: middle;border-style: solid;border-radius: 10px;"> 
                <% 
                       if (Request["F"] != null)
                       {
                           int idc1 = int.Parse(Request["F"].ToString());
                           Data2.Class.Struct_Factura F = Data2.Class.Struct_Factura.GetFacturaById(1, idc1);
                           if (F != null)
                           {
                               switch (F.FacturaTipo)
                               {
                                   case Data2.Class.Struct_Factura.TipoDeFactura.FacturaA: Response.Write("X"); break;
                                   case Data2.Class.Struct_Factura.TipoDeFactura.FacturaB: Response.Write("X"); break;
                                   case Data2.Class.Struct_Factura.TipoDeFactura.FacturaC: Response.Write("X"); break;
                                   case Data2.Class.Struct_Factura.TipoDeFactura.FacturaX: Response.Write("X"); break;

                               }
                           }
                       }

                    %> </span>
        </div>
        <div style="text-align:center">
        <table cellspacing="0" cellpassing="0" style="width:100%">
        <tbody>
        <tr style="background-color:#808080;border-bottom:1px solid black">
        <th>Cantidad</th><th>Detalle</th><th>Prec. U.</th><th>Sub Total</th>

        </tr>
            <%
                decimal total = 0;
                if (Request["F"] != null)
                {
                    int idc = int.Parse(Request["F"].ToString());
                    Data2.Class.Struct_Factura F = Data2.Class.Struct_Factura.GetFacturaById(1, idc);
                    if (F != null)
                    {
                        if (F.GetDetalle()!=null && F.GetDetalle().Count > 0)
                        {
                            List<Data2.Class.Struct_DetalleFactura> Det = F.GetDetalle();
                            foreach (Data2.Class.Struct_DetalleFactura df in Det)
                            {
                                if (df.PRODUCTO != null)
                                {
                                    Response.Write("<tr>");
                                    Response.Write("<td style=\"border: 1px solid black\">" + (df.isdec ? df.DETALLEDEC.ToString("#.00") : df.DETALLEINT.ToString("#.00")) + "</td>");
                                    Response.Write("<td style=\"border: 1px solid black; padding:5px 5px 5px 5px\">" + df.PRODUCTO.Descripcion + "</td>");
                                    Response.Write("<td style=\"border: 1px solid black; text-align:right\">$ " + df.PRODUCTO.PrecioFinal.ToString("#.00") + "</td>");
                                    Response.Write("<td style=\"border: 1px solid black; text-align:right\">$ " + df.getTotalConIva().ToString("#.00") + "</td>");
                                    Response.Write("</tr>");
                                    total += df.getTotalConIva();
                                }
                            }
                            Response.Write("<tr>");
                            Response.Write("<td  style=\"border: 1px solid black; text-align:right\" colspan=\"3\">Total</td><td  style=\"border: 1px solid black; text-align:right\"> $ " + total.ToString("#.00") + "</td>");
                            Response.Write("</tr>");

                        }
                    }
                }
                %>
        </tbody>
        </table>
        </div>
        <div style="font-size: 11px; text-align:center">Comprobante no valido como factura</div>
    </form>
</body>
</html>
