

<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Caja.View" %>
<%@ Import Namespace ="Data2.Class" %>
<header>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
</header>


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
        <a href="#Boton_Retiro" role="button" class="btn btn-large btn-dark" data-toggle="modal">Retiro</a>
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
           int Id_Usuario = (int)Session["Id_Usuario"];
           int Id_Local = Data2.Statics.Conversion.ObtenerLocal(Id_Usuario);

           Data2.Class.Struct_ArqueoDeCaja UltimoArqueo = Data2.Class.Struct_ArqueoDeCaja.GetLastArqueo(Id_Local);

           List<Struct_Factura> ListaFacturas = Struct_Factura.GetFacturasBetweenDates(UltimoArqueo.GetFecha, DateTime.Now, Id_Local, false, Struct_Factura.TipoDeFactura.Null);
           List<Struct_Retiro> ListaRetiros = Struct_Retiro.GetRetirosBetweenDates(Id_Local,UltimoArqueo.GetFecha,DateTime.Now);

           


           

           Response.Write("<tr class=\"table-success\">");

           Response.Write("<th scope=\"row\">" + UltimoArqueo.GetFecha + "</th>");
           Response.Write("<td>Ultimo Cierre de Caja</td>");
           Response.Write("<td>---</td>");
           Response.Write("<td class=\"text-success\">" + "$ " + UltimoArqueo.GetTotal + "</td>");

           Response.Write("</tr>");



          %>
    
     <!-- 
    <tr class="table-danger">
      <th scope="row">01/01/2019</th>
      <td>Gasto: Libreria</td>
      <td class="text-danger">$875.25</td>
      <td>$---</td>
    </tr>
      -->
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
  </tbody>
</table>

</div>


<div>
    
    <br />
    
</div>


<div class="d-flex justify-content-between">
    <div class="row">
        <div class="col">
            <p>Saldo Actual al Ult. Cierre: <span class="badge badge-secondary">$1500.00</span></p>
            <p>Total de retiros y pagos: <span class="badge badge-danger">$520.30</span></p>
            <p>Total notas de credito: <span class="badge badge-secondary">$0.00</span></p>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <p>Total Tarjetas de credito: <span class="badge badge-info">$2654.20</span></p>
            <p>Total de cheques: <span class="badge badge-secondary">$17547.50</span></p>
            <p>Total efectivo: <span class="badge badge-success">$4365.00</span></p>
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
                        <input type="number" step="0.01" class="form-control" placeholder="Ingrese Monto" aria-label="Monto" aria-describedby="basic-addon1" required>
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
	                    <input type="text" class="form-control" placeholder="Ingrese Detalle del Haber" aria-label="Detalle" aria-describedby="basic-addon1">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Descartar</button>
                <button type="submit" class="btn btn-danger">Guardar</button>
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
                            <span class="input-group-text" id="basic-addon1">$</span>
                        </div>
                        <input type="number" step="0.01" class="form-control" placeholder="Ingrese Monto" aria-label="Monto" aria-describedby="basic-addon1" required>
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
		                    <span class="input-group-text" id="basic-addon1">abc</span>
	                    </div>
	                    <input type="text" class="form-control" placeholder="Ingrese Detalle del Retiro" aria-label="Detalle" aria-describedby="basic-addon1">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Descartar</button>
                <button type="submit" class="btn btn-danger">Guardar</button>
            </div>
        </div>
    </div>
</div>


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