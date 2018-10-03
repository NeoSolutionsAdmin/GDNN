<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Turnero.View" %>

<div>
    <!-- Botón para buscar tratamiento -->
	<button type="button" class="FormButton" value="agregar_tratamiento"  onclick="OpenTreatSearcher('de')">Agregar tratameinto</button>
    
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
			CLIENTE:	<button class ="FormButton" type="button" value="buscar_cliente">BUSCAR</button> <br/>
			<!-- Nombre del cliente seleccionado -->
            NOMBRE:		<label for="nombre_cliente">nombre</label> <br/>
            <!
			APELLIDO:	<label for="apellido_cliente">apellido</label>				
		</p>
			
</div>
		
&nbsp
		
<div>
	<table style="width:100%" border=1>
		<tr>
			<th style="text-align: center; width: 75px">HORARIO</th>
            <%
                for (int a = 0; a < 5; a++)
                {
                    Response.Write("<th style=\"text-align: center\">" + DateTime.Now.AddDays(a).ToShortDateString() + "</th>");
                }
                %>
		</tr>
            <%
                for ( int a = 0; a < 24; a++)
                {
                    if (a < 10)
                    {
                        Response.Write(
                        "<tr>" +
                            "<td style=\"text-align: center\">" +
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
                    else
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
	
<div id="busqueda_cliente" style="background-color: lightblue">
		<p>Hola sosoja</p>
</div> 
        


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
        <asp:Button ID="salirBusqueda" runat="server" ClientIDMode="Static" Text="Cerrar" CssClass="FormButton FirstElement LastElement" OnClientClick="CloseTreatSearcher();return false;" />
    </div>

</div>

<script>

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
        $("#searchcondition").val(columnToSearch);
        TreatSearcher.dialog('open');
    }
		
		    function AbrirDialogo()
		    {
			    $("#busqueda_cliente").dialog("open");
		    }
		
		    $(function()
		    {
			    $( "#busqueda_cliente" ).dialog(
			    	{
				    	autoOpen: false
				    }
			    );
            });

            //Text searcher de tratamientos
            $('#txtTreatSearcher').keyup(function (event) {

                $("#TreatResults").find(".resultline").remove();
                searchTreat($('#txtTreatSearcher').val());
                counterTreat = 0;

            });

            //Busqueda de tratamientos en la base de datos
    function searchTreat(searchChain) {
        $.ajax({
            url: $('#baseurl').val() + '/DesktopModules/Facturacion3/API/ModuleTask/ST',
            cache: false,
            data: { k: MyKey, ss: searchChain },
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
        $('#TreatResults').append('<tr class=resultline id=row' + ID + ' > <td> '+ D +' </td> <td> '+ PF +' </td> <td> '+ button +' </td>  </tr>');
    }
		
</script>


