﻿

<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Caja.View" %>
<%@ Import namespace ="Data2.Class" %>


     <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">





<main>

 


<div class="container">
    <h4 class="text-center">Arqueo de Caja</h4>
</div>



<div class="container">
  <div class="row justify-content-md-center">
    <div class="col-lg align-content-center">
        <a href="#Boton_Ingreso" role="button" class="btn btn-large btn-dark" data-toggle="modal">Ingreso</a>
    </div>
    <div class="col-lg">
        <a href="#Boton_Retiro" role="button" class="btn btn-large btn-dark" data-toggle="modal">Retiro Y Pagos</a>
    </div>
    <div class="col-lg">
        <a href="#Boton_Cierre_Caja" role="button" class="btn btn-large btn-dark" data-toggle="modal">Cerrar Caja</a>
    </div>
  </div>
</div>

<div>
    
    <br />
    
</div>

<div class="container">
    <table class="table table-sm table-hover">
  <thead class="thead-dark">
    <tr>
      <th scope="col">Fecha</th>
      <th scope="col">Detalle</th>
      <th scope="col">Debe</th>
      <th scope="col">Haber</th>
    </tr>
  </thead>
  <tbody>
      
      

       <%
           string Cliente;
           string detalle ="";
           decimal totalEfectivo = 0m;
           decimal totalTarjetas = 0m;
           decimal TotalRetiros = 0m;
           decimal TotalPagos = 0m;
           decimal TotalPagosyRetiros = 0m;
           decimal Monto = 0m;
           decimal SaldoAlUltimoCierre = 0m;
           int Id_Usuario = (int)Session["Id_Usuario"];
           int Id_Local = Data2.Statics.Conversion.ObtenerLocal(Id_Usuario);

           List<Christoc.Modules.Caja.PartialUser> ListadeUsers = (List<Christoc.Modules.Caja.PartialUser>)Session["ListaUsuarios"];

           Data2.Class.Struct_ArqueoDeCaja UltimoArqueo = Data2.Class.Struct_ArqueoDeCaja.GetLastArqueo(Id_Local);

           List<Struct_Factura> ListaFacturas = Struct_Factura.GetFacturasBetweenDates(UltimoArqueo.GetFecha, DateTime.Now, Id_Local, false, Struct_Factura.TipoDeFactura.Null);
           List<Struct_Retiro> ListaRetiros = Struct_Retiro.GetRetirosBetweenDates(Id_Local, UltimoArqueo.GetFecha, DateTime.Now);
           List<Struct_Factura> Facturas_Tarjeta = new List<Struct_Factura>();
           List<Struct_Factura> Facturas_CC = new List<Struct_Factura>();
           List<Struct_Ingresos> ListaIngresos = Struct_Ingresos.Obtener_IngresosBetweenDates(Id_Local,UltimoArqueo.GetFecha,DateTime.Now);
           List<Data2.Listado.Item> auxiliar = new List<Data2.Listado.Item>();

           List<Struct_Factura> Facturas_Efectivo = new List<Struct_Factura>();
           List<Struct_DetalleCuentaCorriente> MovimientosCC = Data2.Class.Struct_DetalleCuentaCorriente.Obtener_movimientosBetweenDates(UltimoArqueo.GetFecha, DateTime.Now, Id_Local, Struct_DetalleCuentaCorriente.TipoDetalleCC.Entrega);



           if (MovimientosCC != null)
           {
               foreach (var i in MovimientosCC)
               {
                   auxiliar.Add(new Data2.Listado.Item(i));
               }
           }
           if (ListaIngresos != null)
           {
               foreach (var i in ListaIngresos)
               {
                   auxiliar.Add(new Data2.Listado.Item(i));
                   totalEfectivo += i.MONTO;
               }
           }

           if (ListaRetiros != null)
           {
               foreach (var i in ListaRetiros)
               {
                   auxiliar.Add(new Data2.Listado.Item(i));
                   TotalRetiros += i.MOnto;
               }
           }


           foreach (var factura in ListaFacturas)
           {
               if (factura.Pago == Struct_Factura.CondicionPago.Contado)
               {
                   totalEfectivo += factura.total; //Facturas_Efectivo.Add(factura);
               }

               if (factura.Pago == Struct_Factura.CondicionPago.Tarjeta) //Facturas_Tarjeta.Add(factura);
               {
                   totalTarjetas += factura.total;
               }

               if (factura.Pago == Struct_Factura.CondicionPago.CtaCte)
               {
                   Facturas_CC.Add(factura);

               }

               auxiliar.Add(new Data2.Listado.Item(factura));
           }

           foreach (var f in auxiliar)
           {
               if (f.tipoDeItem == Data2.Listado.Item.Tipo.Factura)
               {

               }
           }


           auxiliar.Sort((p,q)=> p.tiempo.CompareTo(q.tiempo));

          
           //List<Struct_Retiro> ListaRetiros = Struct_Retiro.GetRetirosBetweenDates(Id_Local,UltimoArqueo.GetFecha,DateTime.Now);

           /////////////// BOOTSTRAP: ULTIMO ARQUEO DE CAJA ///////////////////////
           Response.Write("<tr class=\"bg-primary\">");
           Response.Write("<th scope=\"row\">" + UltimoArqueo.GetFecha + "</th>");
           Response.Write("<td>Ultimo Cierre de Caja</td>");
           Response.Write("<td class=\"text-white\">" + "$ " + UltimoArqueo.GetTotal + "</td>");
           Response.Write("<td>$---</td>");
           Response.Write("</tr>");
           ///////////////////////////////////////////////////////////////


           //IOrderedQueryable<Struct_Factura> prueba = 
           //Facturas_Efectivo.Sort((p,q)=> p.Fecha.CompareTo(q.Fecha));// (x => x.Fecha);







           for (int i = 0; i < auxiliar.Count; i++)
           {
               //////// cuenta corriente
               if (auxiliar[i].tipoDeItem == Data2.Listado.Item.Tipo.MovCC)
               {
                   Struct_DetalleCuentaCorriente detallecc = (Struct_DetalleCuentaCorriente)auxiliar[i].objeto;
                   Cliente  = Struct_Cliente.GetClient(detallecc.IdCliente,Id_Local).RS;
                   detalle = "Entrega en CC[EFECTIVO]: " + Cliente;
                   Monto = detallecc.Monto;
               }
               /////// ingresos
               if (auxiliar[i].tipoDeItem == Data2.Listado.Item.Tipo.Ingreso)
               {
                   Struct_Ingresos I = (Struct_Ingresos)auxiliar[i].objeto;
                   detalle = "Ingreso: " + I.DETALLE;
                   Monto = I.MONTO;
               }



               ////// factura
               if (auxiliar[i].tipoDeItem == Data2.Listado.Item.Tipo.Factura)
               {
                   //Struct_DetalleFactura detalleFactura = (Struct_DetalleFactura)auxiliar[i].objeto;
                   //Cliente  = Struct_Cliente.GetClient(5,Id_Local).RS;

                   Struct_Factura f = (Struct_Factura)auxiliar[i].objeto;

                   detalle = "Factura: " + f.Id.ToString();
                   Monto = f.total;
               }
               ////// Retiro
               if (auxiliar[i].tipoDeItem == Data2.Listado.Item.Tipo.Retiro)
               {
                   Struct_Retiro r = (Struct_Retiro)auxiliar[i].objeto;
                   /*Christoc.Modules.Caja.PartialUser usuario = ListadeUsers.Find((x) => x.id == r.IDUser);
                   if (usuario != null)
                   {
                       detalle = r.DEtalle + ":" + usuario.name;
                   }
                   else
                   {
                       detalle = r.DEtalle + ": Usuario no encontrado.";
                   }
                   Monto = r.MOnto;*/
                   detalle = r.DEtalle;
                   Monto = r.MOnto;
               }


               /////color de la fila////
               if (auxiliar[i].tipoDeItem == Data2.Listado.Item.Tipo.Retiro )
               {
                   Response.Write("<tr class=\"table-danger\">" );
               }
               else if (auxiliar[i].tipoDeItem == Data2.Listado.Item.Tipo.Factura)
               {
                   Response.Write("<tr class=\"table-success\">" );
               }
               else if (auxiliar[i].tipoDeItem == Data2.Listado.Item.Tipo.Ingreso)
               {
                   Response.Write("<tr class=\"table-primary\">" );
               }
               else if (auxiliar[i].tipoDeItem == Data2.Listado.Item.Tipo.MovCC)
               {
                   Response.Write("<tr class=\"table-info\">" );
               }

               ////// FECHA //////
               Response.Write("<td scope=\"row\">" + auxiliar[i].tiempo.ToString() + "</td>");

               ////// DETALLE ///////
               Response.Write("<td> " + detalle + "</td>");

               ////// HABER /////////
               if (auxiliar[i].tipoDeItem == Data2.Listado.Item.Tipo.Retiro )
               {
                   Response.Write("<td>$" + "---" + "</td>");
               }
               else
               {
                   Response.Write("<td class=\"text-danger\">$" + Monto.ToString("0.00") + "</td>");
               }

               /////// DEBE ////////
               if (auxiliar[i].tipoDeItem == Data2.Listado.Item.Tipo.Factura || auxiliar[i].tipoDeItem == Data2.Listado.Item.Tipo.Ingreso || auxiliar[i].tipoDeItem == Data2.Listado.Item.Tipo.MovCC)
               {
                   Response.Write("<td>$" + "---" + "</td>");
               }
               else
               {
                   Response.Write("<td class=\"text-success\">$" + Monto.ToString("0.00") + "</td>");
               }



               Response.Write("</tr>");
               /*
               Response.Write("<tr class=\"table-success\">" );
               Response.Write("<th scope=\"row\">" + "FECHA" + "</th>");
               Response.Write("<td>" + "DETALLE" + "</td>");
               Response.Write("<td>" + "DEBE" + "</td>");
               Response.Write("<td class=\"text-success\">" + "HABER" + "</td>");
               Response.Write("</tr>");
               */
           }

           // string valor = "5645316431";

           SaldoAlUltimoCierre = UltimoArqueo.GetTotal + totalEfectivo - TotalRetiros;
           TotalPagosyRetiros = TotalRetiros;
          %>
    
     <!-- 
    <tr class="table-danger">
      <th scope="row">01/01/2019</th>
      <td>Gasto: Libreria</td>
      <td class="text-danger">$875.25</td>
      <td>$---</td>
    </tr>
      
    <tr class="table-danger">
      <th scope="row">10/01/2019</th>
      <td>Gasto: Limpieza</td>
      <td class="text-danger">$463.20</td>
      <td>$---</td>
    </tr>
    <tr class="table-success">
      <th scope="row">15/02/2019</th>
      <td>Pago cuenta</td>
      <td>$---</td>
      <td class="text-success">$450.00</td>
    </tr>
         -->
  </tbody>
</table>

</div>


<div>
    
    <br />
    
</div>


<div class="d-flex justify-content-between">
    <div class="row">
        <div class="col">
            <p>Saldo Actual al Ult. Cierre: <%
                                                 if (SaldoAlUltimoCierre <= 0)
                                                 {
                                                     Response.Write("<span class=\"badge badge-danger\">$");
                                                 }
                                                 else if (SaldoAlUltimoCierre > 0)
                                                 {
                                                     Response.Write("<span class=\"badge badge-success\">$");
                                                 }


                                                 %><%=SaldoAlUltimoCierre.ToString("0.00")%></span></p>
            <p>Total de retiros y pagos: <%
                                             if (TotalPagosyRetiros <= 0)
                                                 {
                                                     Response.Write("<span class=\"badge badge-danger\">$");
                                                 }
                                                 else if (TotalPagosyRetiros > 0)
                                                 {
                                                     Response.Write("<span class=\"badge badge-success\">$");
                                                 }
                                             %>
                <%=TotalPagosyRetiros %></span></p>
            <p>Total notas de credito: <span class="badge badge-secondary">$0.00</span></p>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <p>Total Tarjetas de credito: <span class="badge badge-info"><%=totalTarjetas %></span></p>
            <p>Total de cheques: <span class="badge badge-secondary">$17547.50</span></p>
            <p>Total efectivo: <span class="badge badge-success">$<%=totalEfectivo.ToString("0.00") %></span></p>
        </div>
    </div>
</div>

</main>

<!-- Ventana modal ingreso de plata -->
<div id="Boton_Ingreso" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <!--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>-->
                <h4 class="modal-title">Ingreso a Caja</h4>
            </div>
            <div class="modal-body">
                <div>
                    <div class="container">
                        <div class="row justify-content-md-center">
                            <div class="col-lg align-content-center">
                                <p>Ingrese monto: </p>
                            </div>
                        </div>
                    </div>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text" id="basic-addon1">$</span>
                        </div>
                        <input  id="montoIngreso" type="number" step="0.01" class="form-control" placeholder="Ingrese Monto" aria-label="Monto" aria-describedby="basic-addon1" required>
                    </div>
                    <div class="container">
	                    <div class="row justify-content-md-center">
		                    <div class="col-lg align-content-center">
			                    <p>Ingrese Detalle del Haber:</p>
		                    </div>
	                    </div>
                    </div>
                    <div class="input-group mb-3">
	                    <div class="input-group-prepend">
		                    <span class="input-group-text" id="basic-addon1">abc</span>
	                    </div>
	                    <input name="DetalleHaber" id="DetalleHaber" type="text" class="form-control" placeholder="Ingrese Detalle del Haber" aria-label="Detalle" aria-describedby="basic-addon1">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <form action="/" method="post">
                    <button type="button" class="btn btn-default" data-dismiss="modal" >Descartar</button>
                    <!--<button type="submit" class="btn btn-danger" runat="server" >Guardar1</button>-->
                    <input type="button" class="btn btn-danger"  ID="Btn_GuardarIngreso" value="Guardar Ingreso" OnClick="GuardarIngreso()"  />
                </form>
            </div>
        </div>
    </div>
</div>


    
    


<!-- Ventana modal RETIRO de plata -->
<div id="Boton_Retiro" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <!--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>-->
                <h4 class="modal-title">Retiro de Caja</h4>
            </div>
            <div class="modal-body">
                <div>
                    <div class="container">
                        <div class="row justify-content-md-center">
                            <div class="col-lg align-content-center">
                                <p>Ingrese monto: </p>
                            </div>
                        </div>
                    </div>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text" id="basic-addon2">$</span>
                        </div>
                        <input type="number" id="MontoRetiro" step="0.01" class="form-control" placeholder="Ingrese Monto" aria-label="Monto" aria-describedby="basic-addon2" required>
                    </div>
                    <div class="container">
	                    <div class="row justify-content-md-center">
		                    <div class="col-lg align-content-center">
			                    <p>Ingrese Detalle del Retiro:</p>
		                    </div>
	                    </div>
                    </div>
                    <div class="input-group mb-3">
	                    <div class="input-group-prepend">
		                    <span class="input-group-text" id="basic-addon3">abc</span>
	                    </div>
	                    <input type="text" id="DetalleRetiro" class="form-control" placeholder="Ingrese Detalle del Retiro" aria-label="Detalle" aria-describedby="basic-addon3">
                    </div>
                    <fieldset>
                        <input type="radio" class="sosoja" checked="checked" id="Retiro" name="gender" value="0"> Retiro
                        <input type="radio" class="sosoja" id="Pago" name="gender" value="1"> Pagos
                    </fieldset>
                </div>
            </div>
            <div class="modal-footer">
                <form action="/" method="post">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Descartar</button>
                    <input type="button" class="btn btn-danger" ID="Btn_Guardar_retiro" value="Guardar Retiro/Pago" onclick="GuardarRetiro()" />
                    <!--<button type="submit" class="btn btn-danger">Guardar</button>-->
                </form>
            </div>
        </div>
    </div>
</div>

<asp:HiddenField ID="iduser" runat="server" ClientIDMode="Static" />

<script>

    function GuardarIngreso() {
        var montoingreso = $("#montoIngreso").val();
        var DetalleHaber = $("#DetalleHaber").val();
        var tipoOperacion = 2;
        var userId = $("#iduser").val();

        $.ajax({

            url: "/DesktopModules/caja/cajawebservice.aspx",
            method: "GET",
            data: { Monto: montoingreso, Detalle: DetalleHaber, IdUser: userId, TipoOperacion: tipoOperacion },
            //preguntar si se guardo en sql
            success: function (dato) {

                if (dato == "2") {
                    alert("Ingreso Registrado con exito!!!");
                    window.location.href = "./";
                }
            }
        });

        $("#montoIngreso").val("");
        $("#DetalleHaber").val("");
    }


</script>

<script>

    function GuardarRetiro() {
        var montoRetiro = $("#MontoRetiro").val();
        var detalleRetiro = $("#DetalleRetiro").val();
        var tipoOperacion = $(".sosoja:checked").val();
        var userId = $("#iduser").val();

        $.ajax({

            url: "/DesktopModules/caja/cajawebservice.aspx",
            method: "GET",
            data: { Monto: montoRetiro, Detalle: detalleRetiro, IdUser: userId, TipoOperacion: tipoOperacion },
            // preguntar si se guardo en sql
            success: function (dato) {
                
                if (dato == "0") {
                    alert("Retiro Registrado con exito!!!");
                }
                if (dato == "1") {
                    alert("Pago Registrado con exito!!!");
                }
                window.location.href = "./";
            }
        });

        $("MontoRetiro").val("");
        $("DetalleRetiro").val("");
    }

</script>


<!-- Ventana modal Cierre Caja -->
<div id="Boton_Cierre_Caja" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Cierre de Caja</h4>
            </div>
            <div class="modal-body">
                <p>¿Seguro que desea efectuar el cierre de caja? </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <button type="submit" class="btn btn-danger">Realizar Cierre</button>
            </div>
        </div>
    </div>
</div>