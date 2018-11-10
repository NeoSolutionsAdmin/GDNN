<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.TransferenciaStock.View" %>



<style>
@import url('https://fonts.googleapis.com/css?family=Roboto');
</style> 

<!-- TRANSFERENCIA STOCK -->
<div class="Busqueda">

    <h1>TRANSFERIR STOCK</h1>    
       

    <!-- DIV OCULTO DEL LOCAL SELECCIONADO -->
    <div id="localSeleccionado" class="divOculto" onclick="volverLocal()">
        LOCAL SELECCIONADO: <span id="labelLocalSeleccionado"></span>
    </div>
    
    <!-- DIV OCULTO DEL PRODUCTO ORIGEN SELECCIONADO -->
    <div id="productoOSeleccionado" class="divOculto" onclick="volverProductoO()" >
        
        PRODUCTO ORIGEN: <span id="labelPOSeleccionado"></span> <br />

    </div>
    
    <!-- DIV OCULTO DEL PRODUCTO DESTINO SELECCIONADO -->
    <div id="productoDSeleccionado" class="divOculto" onclick="volverProductoD()">
                
        PRODUCTO DESTINO: <span id="labelPDSeleccionado"></span>

    </div>




    <!-- BUSCADOR DE LOCAL RECEPTOR -->
    <div class="Busqueda" id="buscadorLocalReceptor">
        
        <!-- TextBox para ingresar la cadena de búsqueda -->
        <div>
            1. BUSCAR LOCAL RECEPTOR <asp:TextBox
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
        2. BUSCAR PRODUCTO ORIGEN <asp:TextBox
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




    <!-- BUSCADOR DE PRODUCTO DESTINO -->
    <div class="Busqueda" id="buscadorProductoD">
        
        <!-- TextBox para ingresar la cadena de búsqueda -->
        3. BUSCAR PRODUCTO DESTINO <asp:TextBox
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

    <!-- DEFINIR CANTIDAD A ENVIAR -->
    <div id="cantidad" style="margin:20px">
        <!-- 4.DEFINIR CANTIDAD -->
        <input class="FormButton" onclick="storeCant()" type="button" value="4. DEFINIR CANTIDAD" id="cantButton" />
        <input style="margin-left:20px" type="text" id="txtCant" />
    </div>


</div>

<!-- LOCAL ORIGEN -->
<asp:HiddenField Id="IDLO" runat="server" ClientIDMode="Static" />
<!-- PRODUCTO ORIGEN-->
<input type="hidden" id="idPO" />

<!-- PRODUCTO DESTINO -->
<input type="hidden" id="idPD" />
<!-- LOCAL DESTINO -->
<input type="hidden" id="idLD" />

<!-- CANTIDAD A TRANSFERIR POSITIVA -->
<input type="hidden" id="cant" />



<script>

    var ajaxData;

    $('#localSeleccionado').hide();
    $('#productoOSeleccionado').hide();
    $('#productoDSeleccionado').hide();

    $('#buscadorProductoO').hide();
    $('#buscadorProductoD').hide();
    $('#cantidad').hide()

    
    


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
                    
                    $('#tablaProductosO').append('<tr><td><input style="background:none;border:none" type="button" value="'+data[a].Descripcion+'" onclick="storeidPO('+ data[a].Id +',this)" /></td><td>'+ data[a].CantidadINT +'</td></tr>');
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
                    
                    $('#tablaProductosD').append('<tr><td><input style="background:none;border:none" type="button" value="'+data[a].Descripcion+'" onclick="storeidPD('+ data[a].Id +',this)" /></td><td>'+ data[a].CantidadINT +'</td></tr>');
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



    function redirigirParam() {

        //Revisa si los parámetros objetos tienen valor
        if (!$('#IDLO').val() ||
            !$('#idLD').val() ||
            !$('#idPO').val() ||
            !$('#idPD').val() ||
            !$('#cant').val())
        {
            alert('Falta información para realizar la consulta.' +
                ' Recuerde realizar todos los pasos antes de confirmar la transferencia')
        }
        else
        {
            var urlcompleta = window.location.href + "?LO=[1]&LD=[2]&PO=[3]&PD=[4]&C=[5]";
            urlcompleta = urlcompleta.replace("[1]", $('#IDLO').val());
            urlcompleta = urlcompleta.replace("[2]", $('#idLD').val());
            urlcompleta = urlcompleta.replace("[3]", $('#idPO').val());
            urlcompleta = urlcompleta.replace("[4]", $('#idPD').val());
            urlcompleta = urlcompleta.replace("[5]", $('#cant').val());

            window.location.href = urlcompleta;
        }
        
    }

           


    function clickBotonLocal() {
        $.ajax({
            url: "http://dnndev.me/DesktopModules/TransferenciaStock/WebService.aspx",
            success: function (data)
            {
                $('#TablaLocales').empty();
                $('#TablaLocales').append('<tr><th>NOMBRE</th></tr>')
                for (a = 0; a < data.length; a++) {
                    
                    $('#TablaLocales').append('<tr><td><input style="border:none; background:none;" value="'+data[a].NombreLocal+'" type="button" onclick="storeidLD('+ data[a].Id +',this)" /></td></tr>');
                };
            },
            dataType: 'json',
            data:
            {
                    buscarL: $('#txtBuscadorLocal').val()
            }

         });
    }


    //VOLVER A DEFINIR ALGUN VALOR
    //BUSCADOR LOCAL DESTINO
    function volverLocal() {

        //Se borran los hidden
        $('#idPO').val("");
        $('#idPD').val("");
        $('#idLD').val("");
        $('#cant').val("");

        //Se borra la tabla de busqueda
        $('#TablaLocales').empty();
        $('#TablaLocales').append('<tr><th>NOMBRE</th></tr>')

        //Se muestra el div buscador de local y se oculta el resto
        //Ocultos
        $('#localSeleccionado').hide('slow');
        $('#productoOSeleccionado').hide('slow');
        $('#productoDSeleccionado').hide('slow');
        $('#cantidad').hide('slow');
        $('#buscadorProductoD').hide('slow');
        $('#buscadorProductoO').hide('slow');

        //Mostrar
        $('#buscadorLocalReceptor').show('slow');

    }
    //BUSCADOR PRODUCTO ORIGEN
    function volverProductoO() {

        //Se borran los hidden
        $('#idPO').val("");
        $('#idPD').val("");
        $('#cant').val("");

        //Se borra la tabla de busqueda
        $('#tablaProductosO').empty();
        $('#tablaProductosO').append('<tr><th>DESCRIPCION</th><th>CANTIDAD</th></tr>');

        //Se muestra el div buscador de producto origen y se oculta el resto
        //Ocultos
        $('#productoOSeleccionado').hide('slow');
        $('#productoDSeleccionado').hide('slow');
        $('#cantidad').hide('slow');
        $('#buscadorProductoD').hide('slow');

        //Mostrar
        $('#buscadorProductoO').show('slow');
    }
    //BUSCADOR PRODUCTO ORIGEN
    function volverProductoD() {

        //Se borran los hidden
        $('#idPD').val("");
        $('#cant').val("");

        //Se borra la tabla de busqueda
        $('#tablaProductosD').empty();
        $('#tablaProductosD').append('<tr><th>DESCRIPCION</th><th>CANTIDAD</th></tr>');

        //Se muestra el div buscador de producto destino y se oculta el resto
        //Ocultos
        $('#productoDSeleccionado').hide('slow');
        $('#cantidad').hide('slow');

        //Mostrar
        $('#buscadorProductoD').show('slow');
    }



    // FUNCIONES DE GUARDADO EN EL HIDDEN
    //Guarda los datos y esconde el div

    function storeidLD(id,boton) {
        $('#idLD').val(id); //Guarda el ID
        $('#localSeleccionado').show('slow');    //Muestra el div con el value del boton
        $('#labelLocalSeleccionado').text($(boton).val());
        $('#buscadorLocalReceptor').hide('slow');
        $('#buscadorProductoO').show('slow');



    }
    function storeidPO(id,boton) {
        $('#idPO').val(id);
        $('#productoOSeleccionado').show('slow');
        $('#labelPOSeleccionado').text($(boton).val());
        $('#buscadorProductoO').hide('slow');
        $('#buscadorProductoD').show('slow');
        
    }
    function storeidPD(id,boton) {
        $('#idPD').val(id)
        $('#labelPDSeleccionado').text($(boton).val());        
        $('#productoDSeleccionado').show('slow');
        $('#buscadorProductoD').hide('slow');
        $('#cantidad').show('slow');
    }
    function storeCant() {
        
        var cant = $('#txtCant').val(); //Toma la cantidad del textbox (id:txtCant)

        if (isNaN(cant)) {  //Verifica si lo ingresado es un número
            alert('Introduzca un número mayor a 0 (cero)')
        }
        if (cant == "") {
            alert('Introduzca un numero mayor a 0 (cero)')
        }
        $('#cant').val(cant);   //Guarda la cantidad en el hidden
        redirigirParam();
    }



</script>