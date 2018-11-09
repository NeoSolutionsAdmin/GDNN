<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.ConfiguracionAlertaStock.View" %>

<h1>CONFIGURACIÓN NOTIFICACIONES</h1> <br />


    <!-- DIV BOTONES -->
    <div>
        <!-- Buscar usuario -->
        <p>
            BUSCAR USUARIO  <asp:Button  CssClass="FormButton" OnClientClick="abrirBuscadorUsuario();return false" runat="server" ClientIDMode="Static" ID="buscarUsuario" Text="BUSCAR" /> <br />
            <br />
            BUSCAR PRODUCTO <asp:Button  CssClass="FormButton" OnClientClick="abrirBuscadorProducto();return false" runat="server" ClientIDMode="Static" ID="buscarProducto" Text="BUSCAR" /> <br />
        </p>
               
    </div>

    <!-- DIV POP-UP: BUSCADOR USUARIO -->
    <div title="Búsqueda de usuarios" id="buscadorUsuario" >

        
        <!-- Tabla con resultados -->
        <div style="width: 100%; display: inline-block; max-height: 100px; overflow-y:scroll">
            <table>
                <tbody id="TablaD"  runat="server">  
                                       
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
        <div style="width: 100%; display: inline-block; max-height: 100px; overflow-y:scroll">
            <table style="table-layout: fixed;">
                <tbody id="resultadosProducto">
                    <tr>
                        <td>Nombre</td>
                        <td style="padding-left:50px;">Cantidad</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- TABLAS DE RESULTADOS -->
    <div>

        <!-- Tabla usuarios agregados -->
        <div class="R">

            <table >
                <tbody id ="TUsuarios">
                <tr><th>USUARIOS</th></tr>
                <tr>
                    <td>Nombre</td>
                    <td>Alertar?</td>
                </tr>
                    </tbody>
            </table>


        </div> 

        <!-- Tabla productos agregados -->
        <div class="P">

            <table>
                <tr>
                    <th>PRODUCTOS</th>
                    <th>CANTIDAD</th>
                    <th>CANTIDAD MINIMA</th>                    
                </tr>                
            </table>

        </div>
        
    </div>

    <!-- CONDICIÓN DE BÚSQUEDA -->
    <asp:HiddenField runat="server" Value="" ID="condicionBusquedaProducto" />
    <asp:HiddenField runat="server" Value="" ID="condicionBusquedaUsuario" />

    <script>

        function AgregarUsuario(uid)
        {
            window.location.href = "./adduser=" + uid;
        }


        // Pop-up buscador de usuario
        var buscadorUsuario = $('#buscadorUsuario').dialog(
            {
                autoOpen: false,
                closeOnEscape: false,
                dialogClass: "noclose",
                modal: false,
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
                width: '400px'
            });

        // Abrir buscador de usuario
        function abrirBuscadorUsuario() 
        {
            $('#condicionBusquedaUsuario').val();
            buscadorUsuario.dialog('open');
        }


        // Abrir buscador de productos
        function abrirBuscadorProducto() 
        {
            $('#condicionBusquedaProducto').val();
            buscadorProducto.dialog('open');
        }

    </script>


    </form>

