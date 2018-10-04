<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Turnero.View" %>

<div>
    <h1>AGREGAR NUEVO TURNO</h1>
    <!-- Botón para buscar tratamiento -->
	<button type="button" class="FormButton" value="buscar_tratamiento"  onclick="OpenTreatSearcher('de')">Buscar tratameinto</button>
   
    
    <!-- Párrafo de los botones para agregar un turno:
        Elegir día, elegir hora y elegir cliente-->
		<p>	DIA:<select>
					<%
                        // Crea la lista (con 5 días) para elegir un día del turno
                        for (int a = 0; a < 5; a++)
                        {
                            Response.Write("<option>" + DateTime.Now.AddDays(a).ToShortDateString() + "</option>");
                        }
                        %>
				</select>
            
			HORARIO: 	<select>
							<%  
                                
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
                            %>							
						</select>
            <!-- Botón de búsqueda de clientes -->
			CLIENTE:	<button class ="FormButton" type="button" value="buscar_cliente" onclick="OpenClientSearcher('de')">BUSCAR</button> <br/>
			<!-- Nombre del cliente seleccionado -->
            NOMBRE:		<label for="nombre_cliente">nombre</label> <br/>
            <!-- Apellido del cliente seleccionado -->
			APELLIDO:	<label for="apellido_cliente">apellido</label>	<br/>
            <button></button>
		</p>
			
</div>
		
&nbsp
		
<div>
    <!-- Agenda del turnero -->
	<table style="width:100%;" border=1>
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
                            "<td style=\"text-align: center; margin:500px\">" +
                                "0" + a.ToString() + ".00" +
                            "</td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                        "</tr>" +
                        "<tr>" +
                            "<td style=\"text-align: center\">" +
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
                            "<td style=\"text-align: center\">" +
                                a.ToString() + ".00" +
                            "</td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                        "</tr>" +
                        "<tr>" +
                             "<td style=\"text-align: center\">" +
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
    <div style="width: auto; display: inline-block; max-height: 100px; overflow-y: scroll">
        <table style="table-layout: fixed;">
            <tbody id="TreatResults">
                <tr class="metroheader">
                    <td>Descripcion</td>
                    <td>Precio Final</td>
                    <td>Seleccionar</td>
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

    <div style="width: auto; display: inline-block; max-height: 100px; overflow-y: scroll">
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
<asp:HiddenField runat="server" ID="baseurl" ClientIDMode="Static"/>

<input type="button" onclick="buscarClient()" value="boton de prueba" />

<script>



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

            //Popup Searcher de tratamientos
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

            //Open y close de searcher de tratamientos
    function CloseTreatSearcher() {
        TreatSearcher.dialog('close');
    }
    function OpenTreatSearcher(columnToSearch) {
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

    //Text searcher de Clientes
    function agregarFilaBusquedaCliente(miCliente)
    {
        var htmlFila = '<tr onclick="seleccionarCliente(this)" class="resultline" name="'+ miCliente.ID +'"><td>' + miCliente.RS + '</td><td>' + miCliente.DNI + '</td><td>' + miCliente.PAIS + '</td><td>' + miCliente.PROVINCIA + '</td><td>' + miCliente.LOCALIDAD + '</td><td>' + miCliente.DOMICILIO + '</td><td>' + miCliente.TIPOIVA + '</td><td>'+ miCliente.DESCUENTO +'</td><td>'+ miCliente.EMAIL +'</td></tr>'
        $('#ClientResults').append(htmlFila);
    }

    function seleccionarCliente(objetoFila) {
        //alert(objetoFila);
        var clienteSeleccionado = $(objetoFila).attr("name");
        alert(clienteSeleccionado);
        
    }


    function buscarClient(searchChain)
    {

            $.ajax({
                url: "http://dnndev.me/DesktopModules/Clientes/API/ModuleTask/SC",
                success: function (result)
                {
                    $('#ClientResults').find(".resultline").remove();
                    if (result != null)
                    {
                        var ordenado = JSON.parse(result);
                        for (a = 0; a < ordenado.length; a++)
                        {
                            var miCliente = ordenado[a];
                            agregarFilaBusquedaCliente(miCliente);
                        }
                    }
                    
                },
                cache: false,
                data: { k: 'minion', ss: '%' + searchChain + '%'},
                dataType: 'json',
                method: 'GET'
                
            });
    }


            //Text searcher de tratamientos
            $('#txtTreatSearcher').keyup(function (event) {

                $("#TreatResults").find(".resultline").remove();
                searchTreat($('#txtTreatSearcher').val());
                counterTreat = 0;

    });

    $('#txtClientSearcher').keyup(function (event) {

                //$("#TreatResults").find(".resultline").remove();
                buscarClient($('#txtClientSearcher').val());
                //counterTreat = 0;

    });


            //Busqueda de tratamientos en la base de datos
    function searchTreat(searchChain) {
        $.ajax({
            url: /*$('#baseurl').val() +*/ '/DesktopModules/Facturacion3/API/ModuleTask/ST',
            cache: false,
            data: { k: '', ss: searchChain },
            dataType: 'json',
            method: 'GET',
            success: function (data) {
                $("#TreatResults").find(".resultline").remove();
                if (data != 'null') {
                    var jsonobj = JSON.parse(data);
                    if (jsonobj.length != 0) {

                        var par = true;
                        var classtopass;
                        for (a = 0; a < jsonobj.length; a++) {
                            var row = jsonobj[a];
                            if (par == true) {
                                par = false;
                                classtopass = 'metroparline';
                            } else {
                                par = true;
                                classtopass = 'metroimparline';
                            }


                            addTreatRow(row.Nombre, row.Precio, classtopass, row.Id);
                        }

                    }
                }
            },
            error: function () {
                $("#TreatResults").find(".resultline").remove();
            }

        });
            }

            //Añade fila de resultados al cuadro de busqueda de tratamiento
    function addTreatRow(D, PF, CLS, ID) {
        var CLSString = 'animationline resultline ' + CLS;
        var button = '<div class="buttoncell" onclick="IncludeArt(' + ID + ')">Seleccionar</div>';
        $('#TreatResults').append('<tr class=resultline id=row' + ID + ' > <td> '+ D +' </td> <td style="text-align:right;padding-right:10px"> '+ PF +' </td> <td> '+ button +' </td>  </tr>');
    }

    
		
</script>
