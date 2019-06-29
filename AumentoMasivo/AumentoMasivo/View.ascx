<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.AumentoMasivo.View" %>
<%@ Import Namespace="Data2" %>
<%@  Import Namespace="Data2.Class" %>

<asp:ListBox  runat="server" AutoPostBack="true" ID="cmbProveedor" OnSelectedIndexChanged="cmbProveedor_TextChanged"></asp:ListBox>
<p style="padding-top:50px" runat="server" id="ControlesDeAumento">
    <asp:Label Text="Precio Neto:" runat="server"></asp:Label><asp:TextBox ID="txtPrecioNeto" runat="server"></asp:TextBox>%<br />
    <asp:Label Text="Porcentage Ganancia:" runat="server"></asp:Label><asp:TextBox ID="txtGanancia" runat="server"></asp:TextBox>% <br />
    <asp:Button runat="server" id="btnPreview" Text="Previsualizar" />
    <asp:Button runat="server" id="btnGuardar" Text="Guardar" OnClick="btnGuardar_Click" />
</p>

<%

    if (Session["CurrentProvider"] != null)
    {
        List<Struct_Producto> LP = Session["CurrentProvider"] as List<Struct_Producto>;
        if (LP != null && LP.Count > 0)
        {
            Response.Write("<p style=\"font-weight:bolder; padding-top:20px \"> Tabla de Productos del proveedor " + (Session["Provider"] as Struct_Supplier).Nombre + "(" + (Session["Provider"] as Struct_Supplier).NombreFantasia + ")</p>");
            Response.Write("<Table style=\"width:100%;font-size:10px\"><tbody>");
            Response.Write("<tr style=\"border-bottom:black solid 1px\">");
            Response.Write("<th>Nombre</th>");
            Response.Write("<th>Codigo</th>");
            Response.Write("<th>Precio Neto</th>");
            Response.Write("<th>Iva</th>");
            Response.Write("<th>Precio Compra</th>");
            Response.Write("<th>Porcentage Gan.</th>");
            Response.Write("<th>Precio Venta</th>");
            Response.Write("<th>Ganancia</th>");
            Response.Write("<th>Perdida en producto</th>");
            Response.Write("</tr>");
            foreach (Struct_Producto p in LP)
            { 
                decimal precionetopercent =  txtPrecioNeto.Text !=""?decimal.Parse(txtPrecioNeto.Text):0;
                decimal gananciapercent =  txtGanancia.Text !=""?decimal.Parse(txtGanancia.Text):0;
                decimal newneto = ((p.PrecioNeto * precionetopercent) / 100) + p.PrecioNeto;
                decimal newcompra = ((newneto * p.IVA) / 100) + newneto;
                decimal ganancia = txtGanancia.Text != "" ? decimal.Parse(txtGanancia.Text) : p.PorcentajeGanancia;
                decimal newfinal = ((newcompra * ganancia) / 100) + newcompra;
                
                 


                Response.Write("<tr style=\"border-bottom:gray solid 1px\">");
                Response.Write("<td>" + p.Descripcion+ "</td>");
                Response.Write("<td>" + p.CodigoInterno + "</td>");
                Response.Write("<td>$ " + p.PrecioNeto.ToString("#.00") + " ($ " + newneto.ToString("#.00")  +  ")</td>");
                Response.Write("<td>" + p.IVA.ToString("#.00") + "%</td>");
                Response.Write("<td>$ " + p.PrecioCompra.ToString("#.00") + " ($" +  newcompra.ToString("#.00")  + ")" + "</td>");
                Response.Write("<td>" + p.PorcentajeGanancia.ToString("#.00") +"% (" + ganancia.ToString("#.00") + "%)" + "</td>");
                Response.Write("<td>$ " + p.PrecioFinal.ToString("#.000") + "<span style=\"color:" + (newfinal==p.PrecioFinal?"blue":(newfinal > p.PrecioFinal ? "green":"red")) + "\"> ($ " + newfinal.ToString("#.000") + ")</span>" + "</td>");
                Response.Write("<td>$ " + (p.PrecioFinal-p.PrecioCompra).ToString("#.000") + "<span style=\"color:" + (newfinal-newcompra==p.PrecioFinal-p.PrecioCompra?"blue":(newfinal-newcompra > p.PrecioFinal-p.PrecioCompra ? "green":"red")) + "\"> ($ " + (newfinal-newcompra).ToString("#.000") + ")</span>" + "</td>");
                Response.Write("<td style=\"color:red;font-wight:bolder\">" + (newfinal-newcompra>0?"":"Perdida") + "</td>");

                Response.Write("</tr>");


            }
            Response.Write("</tbody></Table>");
        }
    }
%>