<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Turnero.View" %>

<h1 style="margin-bottom:50px">TURNERO</h1>
<h2>AGREGAR NUEVO TURNO</h2>
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

<%
    //Recuerden cambiar los horarios de apertura en el webservice (seccion getTurnos) para poder calcular la coordenada
    int HoraApertura = 6;
    int HoraCierre = 22;

    if (Session["tratamiento"] != null)
    {
        Data2.Class.Struct_Treatment Tratamiento = Session["tratamiento"] as Data2.Class.Struct_Treatment;
        int indiceSesiones = 1;
        foreach (Data2.Class.Struct_Sesiones sesion in Tratamiento.ListaSesiones)
        {
            Response.Write("<div class=\"contenedorSesiones\">");
            Response.Write("<p> Sesion ");
            Response.Write("<asp:Label runat=\"server\" ID=\"numsesion\" ClientIDMode=\"Static\">"+ indiceSesiones +"  "+"</asp:Label>");
            Response.Write(" Nombre: "+ sesion.Descripcion+"  ");
            Response.Write("DIA:<select onchange=\"addDate()\" id=\"listaDia\" class=\"turnoDias\" >");

            // Crea la lista (con 30 días) para elegir un día del turno
            Response.Write("<option value=\"\"  </option>");
            for (int a = 0; a< 30; a++)
            {
                Response.Write("<option>" + DateTime.Now.AddDays(a).ToShortDateString() + "</option>");
            }
            Response.Write("</select>");
            Response.Write(" HORARIO: ");
            Response.Write("<select onchange=\"addTime()\" id = \"listaHora\" class=\"turnoHoras\" >");

            //Crea la lista (24hs) para elegir hora del turno
            Response.Write("<option value=\"\"  </option>");
            for (int a = HoraApertura; a < HoraCierre; a++)
            {
                if (a < 10) //Línea estética para que los números <10 queden con un 0 delante. EJEMPLO: 03.00; 09.30
                {
                    Response.Write("<option value=\"" + "0" + a.ToString() + ":00" + "\" >" + "0" + a.ToString() + ":00" + "</option>");
                    Response.Write("<option value=\"" + "0" + a.ToString() + ":15" + "\" >" + "0" + a.ToString() + ":15" + "</option>");
                    Response.Write("<option value=\"" + "0" + a.ToString() + ":30" + "\" >" + "0" + a.ToString() + ":30" + "</option>");
                    Response.Write("<option value=\"" + "0" + a.ToString() + ":45" + "\" >" + "0" + a.ToString() + ":45" + "</option>");
                }
                else        //Línea para los números > 10
                {
                    Response.Write("<option value=\"" + "0" + a.ToString() + ":00" + "\" >" + "0" + a.ToString() + ":00" + "</option>");
                    Response.Write("<option value=\"" + "0" + a.ToString() + ":15" + "\" >" + "0" + a.ToString() + ":15" + "</option>");
                    Response.Write("<option value=\"" + "0" + a.ToString() + ":30" + "\" >" + "0" + a.ToString() + ":30" + "</option>");
                    Response.Write("<option value=\"" + "0" + a.ToString() + ":45" + "\" >" + "0" + a.ToString() + ":45" + "</option>");
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
    <asp:Button runat="server" ID="guardar" ClientIDMode="Static" Text="Guardar" OnClick="guardar_Click1" OnClientClick="return guardarTurnos()" CssClass="FormButton FirstElement LastElement" />

    </p>

&nbsp


<!-- Agenda del turnero -->
<h2>AGENDA TURNOS</h2>

<div>

    <!-- Eleccion de local a consultar -->
    <div>Local:
    <%
        List<Struct_Sucursales> listaLocales = Struct_Sucursales.searchLocales("%%%");

        Response.Write("<select onchange=\"changeLocal(this.value)\"  class=\"localElegido\" >");
        Response.Write("<option value=\"-1\"></option>");
        foreach (Struct_Sucursales sucursal in listaLocales)
        {
            Response.Write("<option value=\"" + sucursal.Id +"\">" + sucursal.NombreLocal + "</option>");
        }
        Response.Write("</select>");
    %>
    </div>
    <br />
    
    
    <input class="FormButton" type="button" style="margin-right: -4px;display:inline-block;" value="<" OnClick="moverColumnas(-1)" />
    <input class="FormButton" type="button" style="margin-right: -4px;display:inline-block;" value=">" OnClick="moverColumnas(1)" />

    <table style="width:100%;" border=1 class="Green">
		<tr id="rowHeader">
            <!-- Header de la celda HORARIO -->
			<th style="text-align: center; width: 75px">HORARIO</th>
            <th class="columnaFecha"></th>
            <th class="columnaFecha"></th>
            <th class="columnaFecha"></th>
            <th class="columnaFecha"></th>
            <th class="columnaFecha"></th>
		</tr>
            <%
                dia.Value = DateTime.Now.ToShortDateString();
                // Columnas de los 48 horarios
                for ( int a = HoraApertura; a < HoraCierre; a++)
                {
                    //Línea estética para que los números <10 queden con un 0 delante. EJEMPLO: 03.00; 09.30
                    if (a < 10)
                    {
                        Response.Write(
                        "<tr>" +
                            "<td style=\"font-size:13px;\" class=\"ignorar\" style=\"text-align: center; margin:500px\">" +
                                "0" + a.ToString() + ".00" +
                            "</td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                        "</tr>" +
                        "<tr>" +
                            "<td style=\"font-size:13px;\" class=\"ignorar\" style=\"text-align: center\">" +
                                "0" + a.ToString() + ".15" +
                            "</td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                        "</tr>" +
                        "<tr>" +
                            "<td style=\"font-size:13px;\" class=\"ignorar\" style=\"text-align: center\">" +
                                "0" + a.ToString() + ".30" +
                            "</td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                        "</tr>" +
                        "<tr>" +
                            "<td style=\"font-size:13px;\" class=\"ignorar\" style=\"text-align: center\">" +
                                "0" + a.ToString() + ".45" +
                            "</td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                        "</tr>");

                    }

                    else    //Línea para los números > 10
                    {
                        Response.Write(
                        "<tr>" +
                            "<td style=\"font-size:13px;\" class=\"ignorar\" style=\"text-align: center\">" +
                                a.ToString() + ".00" +
                            "</td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                        "</tr>" +
                        "<tr>" +
                            "<td style=\"font-size:13px;\" class=\"ignorar\" style=\"text-align: center\">" +
                                a.ToString() + ".15" +
                            "</td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                        "</tr>" +
                        "<tr>" +
                             "<td style=\"font-size:13px;\" class=\"ignorar\" style=\"text-align: center\">" +
                                a.ToString() + ".30" +
                            "</td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                        "</tr>"+
                        "<tr>" +
                            "<td style=\"font-size:13px;\" class=\"ignorar\" style=\"text-align: center\">" +
                                a.ToString() + ".45" +
                            "</td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
                            "<td class=\"dataGridTurnero\"></td>" +
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
<asp:HiddenField value="" runat="server" ID="turnosElegidos" ClientIDMode="Static"/>
<asp:HiddenField Value="" runat="server" id="offsetTabla" ClientIDMode="Static" />
<asp:HiddenField Value="" runat="server" ID="Sucursal" ClientIDMode="Static" />

<div id="detalleTurno" style="position: absolute; display:none; background-color:white; border:solid; border-color:crimson"></div>

<script>


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

    //Accede al webservice mediante ajax y obtiene los TRATAMIENTOS buscados
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

    //Accede al webservice mediante ajax y obtiene los CLIENTES buscados
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

    //Cosas de fechas
    var dateIndex = 0;
    var timeIndex = 0;
    var url = $('#url').val();
    var valordia = "", valorhora = "";
    var offset = 0;
    function guardarTurnos()
    {
        var flag = false;
        //Jquery que recorre todos los select de clase turnoDias y guarda variable
        $('.turnoDias').each(function () {
            valordia = $(this).val();
            if (valordia != "") {
                dateIndex++;
                $("#turnosElegidos").val($("#turnosElegidos").val() + "dia" + dateIndex + "," + valordia + "*");
            }
            else
            {
                flag = true;
            }
        });

        $('.turnoHoras').each(function () {
            valorhora = $(this).val();
            if (valorhora != "")
            {
                timeIndex++;
                $("#turnosElegidos").val( $("#turnosElegidos").val() + "hora" + timeIndex + "," + valorhora + "*");
            }
            else
            {
                flag = true;
            }
        });

        if (flag) {
            alert("Uno o mas campos no han sido completados");
            return false;
        }
        else
        {
            alert("El turno fue agregado correctamente");
        }
    }

    //Esconde el boton de guardado si no se eligio tratamiento
    if ( $('#labelnumsesiones').text() == "" || $('#labelrs').text() == "" ) { $('#guardar').hide(); }
    else { $('#guardar').show(); }

    // ---------------------------------------------------------------------------------------------------- //

    //Mueve las columnas de la agenda
    var turnosAjax;
    var fechaB = $('#dia').val();
    function moverColumnas(scroll)
    {
        offset +=scroll;
        $.ajax({
            url: "/DesktopModules/Turnero/WebService.aspx",
            data: {
                GetDate: offset
            },
            dataType: "json",
            success: function (data) {
                var cantidad = 0;
                $('.columnaFecha').each(function () {

                    $(this).animate({'opacity': 0},200, function () {     
                        }).animate({'opacity':1},200)

                     $(this).text(data[cantidad])


                    if (cantidad == 1){ fechaB = $(this).text(); }
                    cantidad++;
                    
                });
                ajaxTurnos(data[0]);
            },
            error: function () {
                alert("Servidor Desconectado - La agenda no esta disponible");
            }
        }); 

        function ajaxTurnos(fechaBas) {
            $.ajax({
                url: "/DesktopModules/Turnero/Webservice.aspx",
                data: {
                    LocalId: $('#Sucursal').val(), fechaBase: fechaBas
                },
                dataType: "json",
                success: function (data) {
                    pintarTurnos(data);
                }
            });
        }
        
        
        function pintarTurnos(turnosAjax) {
            //limpia la grid
            var contador = 0;
            var conthora = 0;
            $('.dataGridTurnero').each(function () {
                if (contador == 5) { contador = 0; conthora++;}
                //$(this).text(contador + "," + conthora);
                $(this).text("");
                $(this).removeAttr("idSesion");
                $(this).unbind('mouseenter').unbind('mouseleave')
                contador++;
            });

        
            //Asocia cada celda de la agenda a su respectivo dia y hora
            var numHora = 0;
            var numFecha = 0; //esto es un int
            $('.dataGridTurnero').each(function () {
                if (numFecha == 5) { numFecha = 0; numHora++; }
                if (turnosAjax != undefined)
                {
                    for (i = 0; i < turnosAjax.length; i++)
                    {
                        if (numFecha == turnosAjax[i].coordfecha && numHora == turnosAjax[i].coordhora) {
                            $(this).text(turnosAjax[i].cliente);
                            $(this).attr("idSesion", turnosAjax[i].idTurno);
                            $(this).hover(function (e) {
                                $("#detalleTurno").show();
                                llenarHover(e.target);
                            });
                            $(this).mouseout(function () {
                                $('#detalleTurno').hide();
                            });
                        }
                    }
                }
                numFecha++;
            });
            
        }

    }
    moverColumnas(0);

    $(document).on('mousemove', function(e){
        $('#detalleTurno').css('top', e.pageY-120);
        $('#detalleTurno').css('left', e.pageX-70);
    });

    function llenarHover(obj){

        var idSesion = $(obj).attr("idSesion");
        $.ajax({
            url: "/DesktopModules/Turnero/WebService.aspx",
            data: {
                identSesion: idSesion
            },
            dataType: "json",
            success: function (data) {
                $('#detalleTurno').empty();
                $('#detalleTurno').append("Nombre Cliente: " + data.turno.CLIENTE.RS + "</br>");
                $('#detalleTurno').append("Tratamiento: " + data.tratamiento.Nombre + "</br>");
                $('#detalleTurno').append("Sesion: " + data.turno.SESION.Nombre + "</br>");

            },
        });

    }


    function changeLocal(idSucursal) {
        $('#Sucursal').val(idSucursal);
        moverColumnas(0);
    }


</script>
