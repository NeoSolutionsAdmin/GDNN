<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.DetalleDeComprobantes.View" %>
<%@ Import Namespace="Data2.Class" %> 
<div class="Busqueda">
    <h1>DETALLE DE COMPROBANTES</h1>

<%
    if (Session["F"] != null)
    {
        Struct_Factura F = Session["F"] as Struct_Factura;
        string TipoDeFactura = "No se encontro el tipo de factura";
        switch (F.FacturaTipo) {
            case Struct_Factura.TipoDeFactura.FacturaA:
                TipoDeFactura = "A";
                break;
            case Struct_Factura.TipoDeFactura.FacturaB:
                TipoDeFactura = "B";
                break;
            case Struct_Factura.TipoDeFactura.FacturaC:
                TipoDeFactura = "V";
                break;
        }
        Response.Write("<Div><div style=\"display: inline-block;margin-right: 5px;\" class=\"FormButton\">Factura tipo:</div><b>"  + TipoDeFactura  + "</b></Div>");
        Response.Write("<Div>");
        Response.Write("<Div>");
        Response.Write("<table id=\"export\"><tbody>");
        Response.Write("<tr>");
        Response.Write("<th>Detalle</th>");
        Response.Write("<th>Precio</th>");
        Response.Write("<th>Cantidad</th>");
        Response.Write("<th>Total</th>");
        Response.Write("</tr>");

        List<Struct_DetalleFactura> DetalleFactura = F.GetDetalle();
        if (DetalleFactura != null && DetalleFactura.Count > 0)
        {
            foreach (Struct_DetalleFactura D in DetalleFactura)
            {

                if (D != null && (D.PRODUCTO!=null || D.TRATAMIENTO!=null))
                {
                    decimal precio;
                    int cantidad;
                    decimal total;
                    string detalle;

                    if (D.PRODUCTO == null) precio = D.TRATAMIENTO.Precio; else precio = D.getPrecioFinalSinIva();
                    if (D.PRODUCTO == null) cantidad = 1; else cantidad = D.DETALLEINT;
                    if (D.PRODUCTO == null) total = D.TRATAMIENTO.Precio; else total = D.getTotalSinIva();
                    if (D.PRODUCTO == null) detalle = D.TRATAMIENTO.Nombre; else detalle = D.PRODUCTO.Descripcion;



                    Response.Write("<tr>");
                    Response.Write("<td style=\"width:150px\">" + detalle +"</td>");
                    Response.Write("<td style=\"width:70px\">" + precio.ToString() +"</td>");
                    Response.Write("<td>" + cantidad.ToString() +"</td>");
                    Response.Write("<td style=\"width:70px\">" + total.ToString() +"</td>");
                    Response.Write("</tr>");

                }

            }
        }


        Response.Write("</tbody></table>");
        Response.Write("</Div>");
    }

    %>
</div>