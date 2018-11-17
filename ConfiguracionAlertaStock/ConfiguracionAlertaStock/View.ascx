<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.ConfiguracionAlertaStock.View" %>

<%@ Import Namespace="Data2.Class" %>



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
        <div>
            <div> Usuarios: </div>
            <table class="alerttable">
                <tbody id ="TUsuarios">
                
                <tr>
                    <th>Nombre</th>
                    <th>Alerta</th>
                </tr>
                    <%
                        List<Data2.Class.Struct_AlertaUsuario> LU = Data2.Class.Struct_AlertaUsuario.GetUsuarios();
                        if (LU != null)
                        {
                            foreach (Struct_AlertaUsuario u in LU)
                            {
                                Response.Write("<tr class=\"mytablerow\"><td>" + u.Name + " " + u.LastName + "</td><td><input type=\"button\" value=\"Quitar\" onclick=\"QuitarUsuario(" + u.Id + ",this)\"/></td></tr>");
                            }
                        }
                        %>
                    </tbody>
            </table>


        </div> 

        <!-- Tabla productos agregados -->
        <div style="margin-top:20px">
            <div> Productos: </div>
            <table class="alerttable">
                <tr>
                    <th>PRODUCTO</th>
                    <th>CANTIDAD</th>
                    <th>CANTIDAD MINIMA</th>                    
                </tr>                
                <% 
                    List<Struct_AlertaProducto> L = Data2.Class.Struct_AlertaProducto.GetAllProducts();
                    if (L != null)
                    {
                        foreach (Struct_AlertaProducto p in L)
                        {
                            Response.Write("<tr class=\"mytablerow\">");
                            Response.Write("<td>" + p.getProducto().Descripcion + "</td>");
                            Response.Write("<td>" + p.getProducto().CantidadINT + "</td>");
                            Response.Write("<td>");
                            Response.Write("<input type=\"text\" id=\"mincant" + p.IdProducto + "\" value=\"" + p.MinCant + "\"/>");
                            Response.Write("<input type=\"button\" value=\"Guardar\" onclick=\"GuardarCantidadMinima("  + p.IdProducto + ",this)\"/>");
                            Response.Write("<input type=\"button\" value=\"Quitar\" onclick=\"QuitarArticulo("  + p.IdProducto + ",this)\"/>");
                            Response.Write("</td>");
                            Response.Write("</tr>");
                        }
                    }
                    %>
            </table>

        </div>
        
    </div>

    <!-- CONDICIÓN DE BÚSQUEDA -->
    <asp:HiddenField runat="server" Value="" ID="condicionBusquedaProducto" />
    <asp:HiddenField runat="server" Value="" ID="condicionBusquedaUsuario" />
    <asp:HiddenField runat="server" Value="" ClientIDMode="Static" ID="LocalId" />
    <asp:HiddenField runat="server" Value="" ClientIDMode="Static" ID="SelectedUser" />
    <asp:HiddenField runat="server" Value="" ClientIDMode="Static" ID="SelectedProduct" />
    <asp:HiddenField runat="server" Value="" ClientIDMode="Static" ID="currentUrl" />

    <script>

        function GuardarCantidadMinima(idprod, object) {

            $.ajax({
                url: "/desktopmodules/ConfiguracionAlertaStock/WebService.aspx",
                data:
                    {
                        IdProd: idprod,
                        CantMin: $("#mincant" + idprod).val()
                    },
                success: function (data) {
                    $(object).parent().parent().animate(
                        {
                            backgroundColor: "#00ff00"
                        }, 1000);
                    $(object).parent().parent().animate(
                        {
                            backgroundColor: "#ffffff"
                        }, 1000);
                },
                error: function ()
                {
                     $(object).parent().parent().animate(
                        {
                            backgroundColor: "#ff0000"
                        }, 1000);
                    $(object).parent().parent().animate(
                        {
                            backgroundColor: "#ffffff"
                        }, 1000);
                }

            });

        }

        function QuitarUsuario(id, object)
        {
            $(object).parent().parent().hide("fast");
            $.ajax({
                url: "/desktopmodules/ConfiguracionAlertaStock/WebService.aspx",
                data:
                    {
                        QuitarUsuario:id
                    }
            });
        }

        function QuitarArticulo(id, object)
        {
            $(object).parent().parent().hide("fast");
            $.ajax({
                url: "/desktopmodules/ConfiguracionAlertaStock/WebService.aspx",
                data:
                    {
                        QuitarArticulo:id
                    }
            });
        }

        $("#txtBuscadorProducto").keyup(function ()
        {
            buscararticulo($("#txtBuscadorProducto").val());
        });

        

        function SeleccionarUsuario(uid)
        {
            
            cerrarBuscadorUsuario();
            window.location.href =$("#currentUrl").val() + "?AddUser=" + uid;
        }

        function AgregarArticulo(data)
        {
            if (data != "null") {
                for (a = 0; a < data.length; a++)
                {
                    $('#resultadosProducto').append("<tr onclick=\"SeleccionarArticulo(" + data[a].Id + ")\"><td>" + data[a].Descripcion + "</td><td>" + data[a].CantidadINT + "</td></tr>");
                }
            }

        }

        function SeleccionarArticulo(idart)
        {

            cerrarBuscadorProducto();
            window.location.href = $("#currentUrl").val() + "?AddArt=" + idart;
        }

        function buscararticulo(searchstring)
        {
            $.ajax(
                {
                    url: "/DesktopModules/ConfiguracionAlertaStock/WebService.aspx",
                    dataType: "json",
                    data:
                        {
                            busqueda: searchstring,
                            LocalId:$('#LocalId').val()
                            
                        },
                    success: function (data)
                    {
                        $('#resultadosProducto').empty();
                        $('#resultadosProducto').append("<tr><th>Detalle</th><th>Cantidad</th></tr>");
                        AgregarArticulo(data);
                        
                    }
                });
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

        function cerrarBuscadorUsuario()
        {
            buscadorUsuario.dialog('close');
        }

        function cerrarBuscadorProducto()
        {
             buscadorProducto.dialog('close');
        }

        // Abrir buscador de productos
        function abrirBuscadorProducto() 
        {
            $('#condicionBusquedaProducto').val();
            buscadorProducto.dialog('open');
        }

    </script>


    </form>

