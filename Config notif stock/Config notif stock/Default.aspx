<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html >
    
<head runat="server">
   
    <title>Notificaciones Stock</title>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <link href="Estilo.css" rel="stylesheet" />

</head>

<body >
    <form id="miform" runat="server">
    <h1>CONFIGURACIÓN NOTIFICACIONES</h1>


    <!-- DIV BOTONES -->
    <div>
        <!-- Buscar usuario -->
        <p>
            BUSCAR USUARIO  <asp:Button OnClientClick="abrirBuscadorUsuario();return false" runat="server" ClientIDMode="Static" ID="buscarUsuario" Text="BUSCAR" /> <br />
            USUARIO: <asp:Label runat="server" ID="idUsuarioSelected" ClientIDMode="Static" ></asp:Label> <br />
            <br />
            BUSCAR PRODUCTO <asp:Button runat="server" ClientIDMode="Static" ID="buscarProducto" Text="BUSCAR" /> <br />
            PRODUCTO: <asp:Label runat="server" ID="productoSeleccionado" ClientIDMode="Static" ></asp:Label>
        </p>
               
    </div>

    <!-- DIV POP-UP: BUSCADOR USUARIO -->
    <div title="Búsqueda de usuarios" id="buscadorUsuario" >

        <!-- TextBox de búsqueda -->
        <div>
            <asp:TextBox runat="server" ID="txtBuscadorUsuario" ClientIDMode="Static"></asp:TextBox>
        </div>

        <!-- Tabla con resultados -->
        <div style="width: 100%; display: inline-block; max-height: 100px; overflow-y:scroll">
            <table >
                <tbody id="resultadosUsuario">
                    <tr>
                        <td>Nombre</td>                        
                    </tr>
                </tbody>
            </table>
        </div>       
    </div>



    <!-- DIV POP-UP: BUSCADOR PRODUCTO -->
    <div title="Búsqueda de productos" id="buscadorProducto">

        <!-- TextBox de búsqueda -->
        <div>
            <asp:TextBox runat="server" ID="txtBuscadorProducto" ClientIDMode="Static"></asp:TextBox>
        </div>

        <!-- Tabla con resultados -->
        <div style="width: auto; display: inline-block; max-height: 300px; overflow-y:scroll">
            <table style="table-layout: fixed;">
                <tbody id="resultadosProducto">
                    <tr>
                        <td>Nombre</td>
                        <td>Cantidad</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- CONDICIÓN DE BÚSQUEDA -->
    <asp:HiddenField runat="server" Value="" ID="condicionBusquedaProducto" />
    <asp:HiddenField runat="server" Value="" ID="condicionBusquedaUsuario" />

    <script>

        // Pop-up buscador de usuario
        var buscadorUsuario = $('#buscadorUsuario').dialog(
            {
                autoOpen: false,
                closeOnEscape: false,
                dialogClass: "noclose",
                modal: true,
                resizable: false,
                draggable: false,
                width: '400px'
            });

        // Pop-up buscador de productos
        var buscadorProducto = $('#buscadorProducto').dialog(
            {
                autoOpen: false,
                closeOnEscape: false,
                dialogClass: "noclose",
                modal: true,
                resizable: false,
                draggable: false,
                width: 'auto'
            });

        // Abrir y cerrar buscador de usuario
        function abrirBuscadorUsuario() 
        {
            $('#condicionBusquedaUsuario').val();
            buscadorUsuario.dialog('open');
        }


        // Abrir y cerrar buscador de productos
        function abrirBuscadorProducto(columnaPorBuscar) 
        {
            $('#condicionBusquedaProducto').val(columnaPorBuscar);
            buscadorProducto.dialog('open');
        }

    </script>


    </form>
</body>



</html>


