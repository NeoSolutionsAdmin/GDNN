<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Turnero.View" %>

<h1>AGREGAR NUEVO TURNO</h1>
<table style="width:100%;">
    <tr>
        <th>
        <!-- Botón de búsqueda de clientes -->
        <button class ="FormButton"  type="button" value="buscar_cliente" onclick="OpenClientSearcher('de')">BUSCAR CLIENTE</button> <br/>
        </th>

        <th>
        <!-- Botón para buscar tratamiento -->
        <button type="button" class="FormButton" value="buscar_tratamiento"  onclick="OpenTreatSearcher('de')">Buscar tratamiento</button> <br />
        </th>
    </tr>


    <tr>
        <th>
        <!-- Nombre del cliente seleccionado -->
        NOMBRE Y APELLIDO:		<asp:Label runat="server" ID="labelrs" ClientIDMode="Static"></asp:Label><br/>
        <!-- DNI del cliente seleccionado -->
        DNI:	    <asp:Label runat="server" ID="labeldni"></asp:Label><br/>
        </th>

        <th>
        <!-- Tratamiento seleccionado -->
        TRATAMIENTO: <asp:Label runat="server" ID="labeltratamiento" ClientIDMode="Static"></asp:Label><br/>
        <!-- Sesiones -->
        SESIONES: <asp:Label runat="server" ID="labelnumsesiones" ClientIDMode="Static"></asp:Label><br/>
        </th>
    </tr>
    
</table>
<br />


<%@ Import Namespace="Data2.Class" %>

<asp:hiddenfield id="numSesiones"
                  value="" 
                  runat="server" ClientIDMode="static"/>

<%

    if (Session["tratamiento"] != null)
    {
        Data2.Class.Struct_Treatment Tratamiento = Session["tratamiento"] as Data2.Class.Struct_Treatment;
        int indiceSesiones = 1;
        numSesiones.Value = Tratamiento.ListaSesiones.Count.ToString();
        foreach (Data2.Class.Struct_Sesiones sesion in Tratamiento.ListaSesiones)
        {
            Response.Write("<div class=\"contenedorSesiones\">");
            Response.Write("<p> Sesion ");
            Response.Write("<asp:Label runat=\"server\" ID=\"numsesion\" ClientIDMode=\"Static\">"+ indiceSesiones +"  "+"</asp:Label>");
            Response.Write(" Nombre: "+ sesion.Descripcion+"  ");
            Response.Write("DIA:<select id = \"listaDia\" >");
            // Crea la lista (con 30 días) para elegir un día del turno
            for (int a = 0; a< 30; a++)
            {
                Response.Write("<option>" + DateTime.Now.AddDays(a).ToShortDateString() + "</option>");
            }
            Response.Write("</select>");
            Response.Write(" HORARIO: ");
            Response.Write("<select id = \"listaHora\" >");
            //Crea la lista (24hs) para elegir hora del turno
            for (int a = 0; a < 24; a++)
            {
                if (a < 10) //Línea estética para que los números <10 queden con un 0 delante. EJEMPLO: 03.00; 09.30
                {
                    Response.Write("<option value=\"" + "0" + a.ToString() + ".00" + "\" >" + "0" + a.ToString() + ".00" + "</option>");
                    Response.Write("<option value=\"" + "0" + a.ToString() + ".30" + "\" >" + "0" + a.ToString() + ".30" + "</option>");
                }
                else        //Línea para los números > 10
                {
                    Response.Write("<option value=\"" + a.ToString() + ".00" + "\" >" + a.ToString() + ".00" + "</option>");
                    Response.Write("<option value=\"" + a.ToString() + ".30" + "\" >" + a.ToString() + ".30" + "</option>");
                }
            }
            Response.Write("</select>");
            Response.Write("</p></div>");
            indiceSesiones++;
        }

    }
%>
    <br />

    <p>
    <asp:Button runat="server" ID="guardar" ClientIDMode="Static" Text="Guardar" OnClick="guardar_Click1"     CssClass="FormButton FirstElement LastElement" />

    </p>

&nbsp

<!-- Agenda del turnero -->
<div>

    <table style="width:100%;" border=1 class="Green">
		<tr>
            <!-- Header de la celda HORARIO -->
			<th style="text-align: center; width: 75px">HORARIO</th>
            <%
                //Header de las celdas con las 5 fechas de la agenda
                for (int a = 0; a < 5; a++)
                {
                    Response.Write("<th style=\"text-align: center\">" + DateTime.Now.AddDays(a).ToShortDateString() + "</th>");
                }
                %>
		</tr>
            <%
                // Columnas de los 48 horarios
                for ( int a = 0; a < 24; a++)
                {
                    //Línea estética para que los números <10 queden con un 0 delante. EJEMPLO: 03.00; 09.30
                    if (a < 10)
                    {
                        Response.Write(
                        "<tr>" +
                            "<td class=\"ignorar\" style=\"text-align: center; margin:500px\">" +
                                "0" + a.ToString() + ".00" +
                            "</td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                        "</tr>" +
                        "<tr>" +
                            "<td class=\"ignorar\" style=\"text-align: center\">" +
                                "0" + a.ToString() + ".30" +
                            "</td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                        "</tr>");

                    }

                    else    //Línea para los números > 10
                    {
                        Response.Write(
                        "<tr>" +
                            "<td class=\"ignorar\" style=\"text-align: center\">" +
                                a.ToString() + ".00" +
                            "</td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                        "</tr>" +
                        "<tr>" +
                             "<td class=\"ignorar\" style=\"text-align: center\">" +
                                a.ToString() + ".30" +
                            "</td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                        "</tr>");

                    }



                }
                %>
	</table>
</div>        

<!-- DIV buscador de tratamientos -->
<div title="Busqueda de tratamientos" id="dialogo">
    <div>
        <span class="FormLabel">Buscar:</span>
        <asp:TextBox CssClass="AtroxTextBox" ID="txtTreatSearcher" runat="server" ClientIDMode="Static"></asp:TextBox>
    </div>
    <div style="width: auto; display: inline-block; max-height: 300px; overflow-y: scroll">
        <table style="table-layout: fixed;">
            <tbody id="TreatResults">
                <tr class="metroheader">
                    <td>Descripcion</td>
                    <td>Precio Final</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div>
        <asp:Button ID="salirBusquedaTreat" runat="server" ClientIDMode="Static" Text="Cerrar" CssClass="FormButton FirstElement LastElement" OnClientClick="CloseTreatSearcher();return false;" />
    </div>
</div>

<!-- DIV buscador de clientes -->
<div title="Buscador Clientes" id="dialogo2">
    
    <div>
        <span class="FormLabel">Buscar:</span>
        <asp:TextBox CssClass="AtroxTextBox" ID="txtClientSearcher" runat="server" ClientIDMode="Static"></asp:TextBox>
    </div>

    <div style="width: auto; display: inline-block; max-height: 300px; overflow-y: scroll">
        <table style="table-layout: fixed;">
            <tbody id="ClientResults">
                <tr class="metroheader">
                    <td>Razón social</td>
                    <td>DNI/CUIT/CUIL</td>
                    <td>País</td>
                    <td>Pcia.</td>
                    <td>Loc.</td>
                    <td>Domic.</td>
                    <td>IVA</td>
                    <td>Descuento</td>
                    <td>E-mail</td>
                </tr>
            </tbody>
        </table>
    </div>

    <div>
        <asp:Button ID="salirBusquedaClient" runat="server" ClientIDMode="Static" Text="Cerrar" CssClass="FormButton FirstElement LastElement" OnClientClick="CloseClientSearcher();return false;" />
    </div>

</div>

<input type="hidden" value="" id="treatsearchcondition" />
<input type="hidden" value="" id="clientsearchcondition" />
<asp:HiddenField Value="" runat="server" ID="dia" ClientIDMode="Static"/>
<asp:HiddenField Value="" runat="server" ID="hora" ClientIDMode="Static"/>
<asp:HiddenField runat="server" ID="url" ClientIDMode="Static" />
<asp:HiddenField runat="server" ID="idUser" ClientIDMode="Static" />

<script>

    //Cosas de fechas (ask Losha)
    var url = $('#url').val();
    $('#listaDia').on("change", function () {
        //alert($('#listaDia').val());
        var valordia = $('#listaDia').val();
        $('#dia').val(valordia);

    });
    $('#listaHora').on("change", function () {
        var valorhora = $('#listaHora').val();
        $('#hora').val(valorhora);
    });

    // ---------------------------------------------------------------------------------------------------- //

    //Llama a la funcion de busqueda de tratamiento con el keyup del textbox de tratamiento
    $("#txtTreatSearcher").keyup(function ()
    {
        buscarTratamiento($("#idUser").val(), $("#txtTreatSearcher").val());
    });

    //Llama a la funcion de busqueda de cliente con el keyup del textbox de cliente
    $('#txtClientSearcher').keyup(function ()
    {
        buscarClient($("#idUser").val(), $('#txtClientSearcher').val());
    });

    // ---------------------------------------------------------------------------------------------------- //

    //Creación Popup Buscador de Clientes
    var ClientSearcher = $('#dialogo2').dialog(
        {
            autoOpen: false,
            closeOnEscape: false,
            dialogClass: "noclose",
            modal: true,
            resizable: false,
            draggable: false,
            width: 'auto'
        });

    //Creacion Popup Buscador de Tratamientos
    var TreatSearcher = $('#dialogo').dialog(
        {
            autoOpen: false,
            closeOnEscape: false,
            dialogClass: "noclose",
            modal: true,
            resizable: false,
            draggable: false,
            width: 'auto'
        }
    );

    // ---------------------------------------------------------------------------------------------------- //

    //Open y close de searcher de tratamientos
    function CloseTreatSearcher()
    {
        TreatSearcher.dialog('close');
    }
    function OpenTreatSearcher(columnToSearch)
    {
        $("#treatsearchcondition").val(columnToSearch);
        TreatSearcher.dialog('open');
    }

    //Open y close de searcher de clientes
    function CloseClientSearcher()
    {
        ClientSearcher.dialog('close');
    }
    function OpenClientSearcher(columnToSearch)
    {
        $("#clientsearchcondition").val(columnToSearch);
        ClientSearcher.dialog('open');
    }

    // ---------------------------------------------------------------------------------------------------- //

    //Añade fila de resultados al cuadro de busqueda de tratamiento
    function addTreatRow(D, PF, CLS, ID) {
        var CLSString = 'animationline resultline ' + CLS;
        $('#TreatResults').append('<tr class=resultline id=row' + ID + ' > <td><a href= "' + url + '?addtrat='+ ID +'">'+D+'</a></td> <td style="text-align:right;padding-right:10px"> '+ PF +' </td>  </tr>');
    }

    //Añade fila de resultados al cuadro de busqueda de clientes
    function agregarFilaBusquedaCliente(miCliente)
    {
        var htmlFila = '<tr onclick="seleccionarCliente(this)" class="resultline" name="' + miCliente.ID + '"><td><a href=" '+ url + '?addclient=' + miCliente.ID + '">' + miCliente.RS + '</a></td><td>' + miCliente.DNI + '</td><td>' + miCliente.PAIS + '</td><td>' + miCliente.PROVINCIA + '</td><td>' + miCliente.LOCALIDAD + '</td><td>' + miCliente.DOMICILIO + '</td><td>' + miCliente.TIPOIVA + '</td><td>' + miCliente.DESCUENTO + '</td><td>' + miCliente.EMAIL + '</td></tr>'
        $('#ClientResults').append(htmlFila);
    }

    // ---------------------------------------------------------------------------------------------------- //

    //Accede al webservice mediante ajax y obtiene los tratamientos buscados
    //Ramiro - 9/11/18
    function buscarTratamiento(idlocal, desc)
    {
        $.ajax({
            url: "/desktopmodules/Turnero/webservice.aspx",
            dataType: "JSON",
            data:
            {
                LocalId: idlocal,
                Name: desc
            },
            success: function (data)
            {
                $("#TreatResults").find(".resultline").remove();
                var par = true;
                var classtopass;
                for (a = 0; a < data.length; a++)
                {
                    if (par == true)
                    {
                        par = false;
                        classtopass = 'metroparline';
                    }
                    else
                    {
                        par = true;
                        classtopass = 'metroimparline';
                    }
                    addTreatRow(data[a].Nombre, data[a].Precio, classtopass, data[a].Id);
                }
            }
            

        });
    }

    //Accede al webservice mediante ajax y obtiene los clientes buscados
    // Losha
    function buscarClient(idlocal, nameClient)
    {
        $.ajax({
            url: "/desktopmodules/Turnero/webservice.aspx",
            dataType: "JSON",
            data:
            {
                LocalId: idlocal,
                RazonSocial: nameClient
            },
            success: function (data) {
                $('#ClientResults').find(".resultline").remove();

                for (a = 0; a < data.length; a++)
                {
                    var miCliente = data[a];
                    agregarFilaBusquedaCliente(miCliente);
                } 
            }
        });
    }

    // ---------------------------------------------------------------------------------------------------- //

    //Recorre los valores horarios por sesion y las guarda en el hiddenfield
    cantSesiones = $("#numSesiones").val();
    for (i = 0; i < cantSesiones; i++)
    {
        
    }
		
</script>
