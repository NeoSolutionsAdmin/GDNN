<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.ConsumoLocalStock.View" %>


<div>

    <div  style="display:inline-block">
        <!-- BUSCADOR DE PRODUCTO ORIGEN -->
        <div class="Busqueda" id="buscadorProducto">
        
            <!-- TextBox para ingresar la cadena de búsqueda -->
                BUSCAR PRODUCTO <asp:TextBox
                style="margin-left:5px;"
                runat="server"
                clientIdMode="Static"
                ID="txtBuscadorProducto"></asp:TextBox> <br />

            <!-- Tabla de resultados -->
            <table id="tablaProductos">
                <tr>
                    <th>DESCRIPCION</th>
                    <th>CANITDAD</th>
                </tr>
            </table>

        </div>
    </div>

    <div style="display:inline-block">
        <!-- BUSCADOR DE TRATAMIENTOS -->
        <div class="Busqueda" id="buscadorTratamiento">
        
            <!-- TextBox para ingresar la cadena de búsqueda -->
                BUSCAR TRATAMIENTO <asp:TextBox
                style="margin-left:5px;"
                runat="server"
                clientIdMode="Static"
                ID="txtBuscadorTratamiento"></asp:TextBox> <br />


            <!-- Tabla de resultados -->
            <table id="tablaTratamiento">
                <tr>
                    <th>NOMBRE</th>
                    <th>DESCRIPCION</th>
                </tr>
            </table>

        </div>
    </div>



</div>

<!-- LOCAL ORIGEN -->
<asp:HiddenField Id="id" runat="server" ClientIDMode="Static" />

<script>

    //Ejecuta la función de buscar TRATAMIENTOS al presionar tecla
    $('#txtBuscadorTratamiento').keyup(function () {
        if ($('#txtBuscadorTratamiento').val() != "") {
            clickBotonTratamiento();
        }
        else null;
        
    });

    //Buscador de ARTÍCULOS
    function clickBotonTratamiento() {
        $.ajax({
            url: "/DesktopModules/ConsumoLocalStock/WebService.aspx",
            success: function (data) {
                if (data != "null") {
                    $('#tablaTratamiento').empty();
                    $('#tablaTratamiento').append('<tr><th>NOMBRE</th><th>DESCRIPCION</th></tr>');
                    for (a = 0; a < data.length; a++) {

                        $('#tablaTratamiento').append('<tr class="droppable"><td>' + data[a].Nombre + '</td><td>' + data[a].Descripcion + '</td></tr>')
                    }
                    ajaxData = data;
                }
                $('.droppable').droppable({
                    drop: function (event, ui) {
                        alert('STOCK ASIGNADO CON EXITO')
                    }
                })
            },
            dataType: 'json',
            data:
                {
                    buscarT: $('#txtBuscadorTratamiento').val(),
                    id: $('#id').val()
                }

        });
    }







    //Ejecuta la función de buscar ARTÍCULOS al presionar tecla
    $('#txtBuscadorProducto').keyup(function () {
        if ($('#txtBuscadorProducto').val() != "") {
            clickBotonProducto();
        }
        else null;
        
    });

    //Buscador de ARTÍCULOS
    function clickBotonProducto() {
        $.ajax({
            url: "/DesktopModules/ConsumoLocalStock/WebService.aspx",
            success: function (data) {
                if (data != "null") {
                    $('#tablaProductos').empty();
                    $('#tablaProductos').append('<tr><th>DESCRIPCION</th><th>CANTIDAD</th></tr>');
                    for (a = 0; a < data.length; a++) {
                    
                        $('#tablaProductos').append('<tr class="draggable"><td>' + data[a].Descripcion + '</td><td>' + data[a].CantidadINT + '</td></tr>')
                    }
                    ajaxData = data;
                }
                $('.draggable').draggable({
                    opacity: 0.35,
                    revert: true,
                    revertDuration: 500,
                })
            },
            dataType: 'json',
            data:
                {
                    buscarP: $('#txtBuscadorProducto').val(),
                    id: $('#id').val()
                }

        });
    }


</script>
