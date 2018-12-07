<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.CreditCardManager.View" %>



<!-- CONTENEDOR -->
<div>
    <h1>ADMINISTRADOR DE TARJETAS</h1>

    <!-- MENÚ OPCIONES A REALIZAR -->
   <div>
       <!-- Primer menú, opciones básicas -->
       <div>
           <input type="button" id="mostrarAgregarButton" class="FormButton" value="AGREGAR" onclick="showAgregarTarjeta()"/>
       </div>





    <!-- AGREGAR -->
    <div style="display:none" id="agregarTarjeta">
        <!-- Definir nombre de tarjeta -->
        <div id="definirNombre">
            <input type="button" style="margin-right:-5px" class="FormButton" value="NOMBRE" onclick="guardarNombre()"/>
            <input type="text" style="height:39.5px" id="txtNombreTarjeta" />
        </div>

        <!-- Definir recargo -->
        <div id="definirRecargo">
            <input type="button" style="margin-right:-5px" class="FormButton" value="RECARGO %" onclick="guardarRecargo()"/>
            <input type="text" style="height:39.5px" id="txtRecargoTarjeta" />
        </div>
        
        <div>
            <input type="button" class="FormButton" value="GUARDAR" onclick="guardarTodo()" />
        </div>


    </div>


    
    
    <div style="display:none" id="tarjetaSeleccionada" onclick="volverElegirTarjeta()">
        <span id="labelTarjetaSeleccionada"></span>
    </div>
    <!-- BUSCADOR DE TARJETAS -->
    <div class="Busqueda" id="seleccionadorTarjeta">
        <!-- Tarjetas -->
        <table id="tablaTarjetas">
            <tr>
                <th>NOMBRE</th>
                <th>RECARGO</th>
                <th>ESTADO</th>
            </tr>
            <%
                List<Data2.Class.Struct_Tarjeta> ListadoTarjetas =  Data2.Class.Struct_Tarjeta.GetAllCreditCards(int.Parse(idLocalHidden.Value));
                if (ListadoTarjetas != null)
                {
                    foreach (Data2.Class.Struct_Tarjeta T in ListadoTarjetas)
                    {
                        string estado="Habilitado";

                        if (T.AVAILABLE == false)
                        {
                            estado = "Deshabilitado";
                        }
                        Response.Write("<tr><td><input value=\""+T.NOMBRE+"\" style=\"background:none;border:none\" type=\"button\" onclick=\"guardarIdTarjeta("+T.ID+",this)\" /> </td>");
                        Response.Write("<td>"+T.RECARGO+"</td>");
                        Response.Write("<td>"+ estado +"</td>");

                        if(T.AVAILABLE == false)
                        {
                            Response.Write("<td><input id=\"" +T.ID.ToString()+ "\" value=\"Habilitar\" onclick=\"habilitarTarjeta(this)\" type=\"button\"/></td>");
                        }
                        else
                        {
                            Response.Write("<td><input id=\"" +T.ID.ToString()+ "\" value=\"Deshabilitar\" onclick=\"deshabilitarTarjeta(this)\" type=\"button\"/></td>");
                        }

                        Response.Write("</tr>");

                    }
                }


            %>
        </table>
    </div>
    


    <!-- HIDDENS -->
    <!---->
    <!-- Id Local -->
    <asp:HiddenField ID="idLocalHidden" ClientIDMode="Static" runat="server"></asp:HiddenField>
    <!-- Id Tarjeta -->
    <input type="hidden" id="idTarjetaHidden" />
    <!-- Nombre Tarjeta -->
    <input type="hidden" id="nombreTarjetaHidden" />
    <!-- Recargo Tarjeta -->
    <input type="hidden" id="recargoTarjetaHidden" />

</div>
    </div>




<script>



    function volverElegirTarjeta() {
        $('#tarjetaSeleccionada').hide('slow')
        $('#labelTarjetaSeleccionada').text('')
        $('#seleccionadorTarjeta').show('slow')
        $('#idTarjetaHidden').val('')

    }

    function habilitarTarjeta(objeto) {
        window.location.href = window.location.href + "?idT=" + $(objeto).attr("id") + "&h=1"
    }
    function deshabilitarTarjeta(objeto) {
        window.location.href = window.location.href + "?idT=" + $(objeto).attr("id") + "&h=0"
    }



    //      ----------    MOSTRAR / OCULTAR    ----------
    //
    //-----  Mostrar AgregarTarjeta  -----
    function mostrarAgregarTarjeta() {

        $('#agregarTarjeta').show('slow');      //Muestra el div para agregar tarjetas
        
    }
    //
    //-----  Ocultar AgregarTarjeta  -----
    function ocultarAgregarTarjeta() {
        $('#agregarTarjeta').hide('slow');
    }

    var isVisible = 0;
    function showAgregarTarjeta() {
        

        if (isVisible == 0) {
            $('#agregarTarjeta').show('slow');
            $('#mostrarAgregarButton').val('OCULTAR')
            isVisible = 1
        }
        else {
            $('#agregarTarjeta').hide('slow');
            $('#mostrarAgregarButton').val('AGREGAR')
            isVisible = 0
        }
            
    }

    //      ----------    MANEJO DE HIDDENS    ----------
    //
    function guardarTodo() {

         if ($('#txtNombreTarjeta').val() != '') {
            $('#nombreTarjetaHidden').val($('#txtNombreTarjeta').val())
         }
         else alert('Inserte un nombre válido')

        if (isNaN($('#txtRecargoTarjeta').val())) {
            alert('Por favor inserte un número válido.')
        }
        else {
            $('#recargoTarjetaHidden').val($('#txtRecargoTarjeta').val())        
        }     

        if ($('#recargoTarjetaHidden').val() != '' && $('#nombreTarjetaHidden').val() != '') {
            var url = window.location.href 
        window.location.href = url + '?nombre=' + $('#nombreTarjetaHidden').val() + '&recargo=' + $('#recargoTarjetaHidden').val() + "&idL=" + $('#idLocalHidden').val()
        }
        
    }
    //
    //-----  Guardar ID Tarjeta  -----
    /*function guardarIdTarjeta(id, boton) {
        var text = $(boton).val()
        $('#idTarjetaHidden').val(id)
        //$('#seleccionadorTarjeta').hide('slow')
        $('#tarjetaSeleccionada').show('slow')
        $('#labelTarjetaSeleccionada').text(text)

    }*/



    //      ----------    AJAX    ----------
    //
    // TODAS las tarjetas de crédito
    /*function listaTarjetas() {
        $.ajax({
            url: window.location.href + "/WebService.aspx",
            success: function (data) {

                if (data != null) {
                    $('#tablaTarjetas').empty();
                    $('#tablaTarjetas').append('<tr><th>NOMBRE</th><th>RECARGO</th><th>ESTADO</th></tr>');

                    var estado

                    for (a = 0; a < data.lenght; a++) {
                        
                        if (data[a].Available = "1") {
                            estado = "Habilitada"
                        }
                        if (data[a].Available = "0") {
                            estado = "Deshabilitada"
                        }

                        $('#tablaTarjetas').append('<tr><td><input style="background:none;border:none" type="button" value="'+data[a].Nombre+'" onclick="guardarIdTarjeta('+data[a].Id+',this)" /></td><td>'+data[a].Recargo+'</td><td>'+estado+'</td></tr>')
                    }
                }
            },
            dataType: 'json',
            data:
            {
                    id: $('#idLocalHidden').val()
            }

        });
    }*/


    



</script>