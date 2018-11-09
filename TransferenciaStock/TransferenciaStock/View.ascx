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

    
    <!-- BUSCADOR DE PRODUCTO ORIGEN -->
    <div class="Busqueda" id="buscadorProductoO">
        
        <!-- TextBox para ingresar la cadena de búsqueda -->
        BUSCAR PRODUCTO ORIGEN <asp:TextBox
            style="margin-left:5px;"
            runat="server"
            clientIdMode="Static"
            ID="txtBuscadorProductoO"></asp:TextBox> <br />

        <!-- Tabla de resultados -->
        <table id="tablaProductosO">
            <tr>
                <th>DESCRIPCION</th>
                <th>CANITDAD</th>
            </tr>
        </table>

    </div>





    <div class="Busqueda" id="buscadorProductoD">
        
        <!-- TextBox para ingresar la cadena de búsqueda -->
        BUSCAR PRODUCTO DESTINO <asp:TextBox
            style="margin-left:5px;"
            runat="server"
            clientIdMode="Static"
            ID="txtBuscadorProductoD"></asp:TextBox> <br />

        <!-- Tabla de resultados -->
        <table id="tablaProductosD">
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
    
    <input type="button" onclick="storeidLD('+ data[a].Id +')" />


</div>

<!-- LOCAL ORIGEN -->
<asp:HiddenField Id="IDLO" runat="server" ClientIDMode="Static" />
<!-- PRODUCTO ORIGEN-->
<input type="hidden" id="idPO" />

<!-- PRODUCTO DESTINO -->
<input type="hidden" id="idPD" />
<!-- LOCAL DESTINO -->
<input type="hidden" id="idLD" />



<script>

    var ajaxData;

    $('#txtBuscadorLocal').keyup(function () {
        if ($('#txtBuscadorLocal').val() != "") {
            clickBotonLocal();
        }
        else null;
    });

    $('#txtBuscadorProductoO').keyup(function () {
        if ($('#txtBuscadorProductoO').val() != "") {
            clickBotonProductoO();
        }
        else null;
        
    });

    $('#txtBuscadorProductoD').keyup(function () {
        if ($('#txtBuscadorProductoD').val() != "") {
            clickBotonProductoD();
        }
        else null;
        
    });


    function clickBotonProductoO() {
        $.ajax({
            url: "http://dnndev.me/DesktopModules/TransferenciaStock/WebService.aspx",
            success: function (data) {
                if (data != "null") {
                $('#tablaProductosO').empty();
                $('#tablaProductosO').append('<tr><th>DESCRIPCION</th><th>CANTIDAD</th></tr>');
                for (a = 0; a < data.length; a++) {
                    
                    $('#tablaProductosO').append('<tr><td><input style="background:none;border:none" type="button" value="'+data[a].Descripcion+'" onclick="storeidPO('+ data[a].Id +')" /></td><td>'+ data[a].CantidadINT +'</td></tr>');
                }
                    ajaxData = data;
                    } 
            },
            dataType: 'json',
            data:
                {
                    buscarP: $('#txtBuscadorProductoO').val(),
                    Id: $('#IDLO').val()
                }

        });
    }

   function clickBotonProductoD() {
        $.ajax({
            url: "http://dnndev.me/DesktopModules/TransferenciaStock/WebService.aspx",
            success: function (data) {
                if (data != "null") {
                $('#tablaProductosD').empty();
                $('#tablaProductosD').append('<tr><th>DESCRIPCION</th><th>CANTIDAD</th></tr>');
                for (a = 0; a < data.length; a++) {
                    
                    $('#tablaProductosD').append('<tr><td><input style="background:none;border:none" type="button" value="'+data[a].Descripcion+'" onclick="storeidPD('+ data[a].Id +')" /></td><td>'+ data[a].CantidadINT +'</td></tr>');
                }
                    ajaxData = data;
                    } 
            },
            dataType: 'json',
            data:
                {
                    buscarP: $('#txtBuscadorProductoD').val(),
                    Id: $('#idLD').val()
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
                    
                    $('#TablaLocales').append('<tr><td><input style="border:none; background:none;" value="'+data[a].NombreLocal+'" type="button" onclick="storeidP('+ data[a].Id +')" /></td></tr>');
                };
            },
            dataType: 'json',
            data:
            {
                    buscarL: $('#txtBuscadorLocal').val()
            }

         });
    }

    // FUNCIONES DE GUARDADO EN EL HIDDEN
    function storeidLD(id) {
        $('#idLD').val(id)
    }
    function storeidPO(id) {
        $('#idPO').val(id)
    }
    function storeidPD(id) {
        $('#idPD').val(id)
    }




</script>