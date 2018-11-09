<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.TransferenciaStock.View" %>



<style>
@import url('https://fonts.googleapis.com/css?family=Roboto');
</style> 

<!-- TRANSFERENCIA STOCK -->
<div class="Busqueda">

    <h1>TRANSFERIR STOCK</h1>    


    
    <div style="margin:20px">
        <input onclick="cantButton_click()" type="button" runat="server" value="DEFINIR CANTIDAD" id="cantButton" />
        <asp:TextBox runat="server" id="txtCant" />
    </div>


    <!-- BUSCADOR DE LOCAL RECEPTOR -->
    <div class="Busqueda" id="buscadorLocalReceptor">
        
        <!-- TextBox para ingresar la cadena de búsqueda -->
        <div>
            BUSCAR LOCAL RECEPTOR <asp:TextBox
            style="margin-left:5px;"
            runat="server"
            clientIdMode="Static"
            ID="txtBuscadorLocal"></asp:TextBox>
        </div>
        

        <!-- Tabla de resultados -->
        <div>
            <table id="TablaLocales">
            <tr>
                <th>NOMBRE</th>
            </tr>
        </table>
        </div>
        
    </div>

    
    <!-- BUSCADOR DE PRODUCTO -->
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





    <!-- RESUMEN TRANSFERENCIA DE STOCK -->
    
    <div class="Resumen">
        <p>RESUMEN DE TRANSFERENCIA</p>
        <table id="tablaResumen" runat="server">
            <tr>
                <th>LOCAL RECEPTOR</th>
                <th>PRODUCTO</th>
                <th>CANTIDAD A ENVIAR</th>                
            </tr>     
        </table>
    </div>
    
    


</div>

<input id="idPD" />
<input id="idLD" />
<input id="" />
<input id="" />


<script>

    var ajaxData;

    $('#txtBuscadorLocal').keyup(function () {
        if ($('#txtBuscadorLocal').val() != "") {
            clickBotonLocal();
        }
        else null;
    });

    $('#txtBuscadorProducto').keyup(function () {
        if ($('#txtBuscadorProducto').val() != "") {
            clickBotonProducto();
        }
        else null;
        
    });

    function clickBotonProducto() {
        $.ajax({
            url: "http://dnndev.me/DesktopModules/TransferenciaStock/WebService.aspx",
            success: function (data) {
                $('#tablaProductos').empty();
                $('#tablaProductos').append('<tr><th>DESCRIPCION</th><th>CANTIDAD</th></tr>');
                for (a = 0; a < data.length; a++) {
                    $('#tablaProductos').append('<tr><td><a href="http://dnndev.me/Transf-Stock?idP=' + data[a].Id + '">'+ data[a].Descripcion + '</a></td><td>'+ data[a].Cantidad +'</td></tr>');
                    
                }
                ajaxData = data;
            },
            dataType: 'json',
            data:
                {
                    buscarP: $('#txtBuscadorProducto').val()
                }

        });
    }



    function clickBotonLocal() {
        $.ajax({
            url: "http://dnndev.me/DesktopModules/TransferenciaStock/WebService.aspx",
            success: function (data)
            {
                $('#TablaLocales').empty();
                $('#TablaLocales').append('<tr><th>NOMBRE</th></tr>')
                for (a = 0; a < data.length; a++) {
                    $('#TablaLocales').append('<tr onclick="storeidLD(' + data[a].Id + ')"><td>' + data[a].NombreLocal + '</td></tr>');
                };
            },
            dataType: 'json',
            data:
            {
                    buscarL: $('#txtBuscadorLocal').val()
            }

         });
    }

    function storeidLD(id) {
        $('#idLD').val(id)
    }


</script>