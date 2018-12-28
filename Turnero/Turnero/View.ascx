<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Turnero.View" %>

<h1 style="margin-bottom:50px">TURNERO</h1>
<h2>AGREGAR NUEVO TURNO</h2>
<table style="width:100%;">
    <tr>
        <th>
        <!-- Botón de búsqueda de clientes -->
        <button class ="FormButton"  type="button" value="buscar_cliente" onclick="OpenClientSearcher('de')">BUSCAR CLIENTE</button> <br/>
        </th>

        <th style="display: none" class="guiTratamiento">
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

        <th style="display: none" class="guiTratamiento">
        <!-- Tratamiento seleccionado -->
        TRATAMIENTO: <asp:Label runat="server" ID="labeltratamiento" ClientIDMode="Static"></asp:Label><br/>
        <!-- Sesiones -->
        SESIONES: <asp:Label runat="server" ID="labelnumsesiones" ClientIDMode="Static"></asp:Label><br/>
        </th>
    </tr>
    
</table>
<br />


<asp:HiddenField runat="server" ID="idUser" ClientIDMode="Static" />

<%@ Import Namespace="Data2.Class" %>

<%
    //Recuerden cambiar tambien los horarios de apertura en el webservice (seccion getTurnos) para poder calcular la coordenada
    //                      (si es que quieren cambiar la franja horaria de la agenda)
    int HoraApertura = 6;
    int HoraCierre = 22;

    if (Session["cliente"] != null)
    {
        Data2.Class.Struct_Cliente Cliente = Session["cliente"] as Data2.Class.Struct_Cliente;
        //Conseguir turnos no asignados por id cliente
        List<Struct_Turno> noAsignados = Struct_Turno.ObtenerTurnosSinAsignar(Data2.Statics.Conversion.ObtenerLocal(int.Parse(idUser.Value)), Cliente.ID);
        int indiceSesiones = 1;

        if (noAsignados != null)
        {
            Response.Write("<div class=\"saveButtonStatus\" mostrarGuardar=\"Yes\">Turnos sin asignar del cliente " + Cliente.RS + ": </div>");
            //Mostrar los turnos sin asignar
            foreach (Data2.Class.Struct_Turno turno in noAsignados)
            {
                Data2.Class.Struct_Sesiones sesion = turno.SESION;
                Data2.Class.Struct_Treatment tratamiento = Struct_Treatment.GetTreatmentById(sesion.IdTratamiento);

                Response.Write("<div class=\"contenedorSesiones\" style=\"display: inline-block;\">");
                Response.Write("<input type=\"checkbox\" onchange=\"toggleInfoSesiones(this.id)\" id=\"" + indiceSesiones + "\" class=\"checkboxTurno\" value=\"\"> Sesion \""+sesion.Nombre +"\"" );
                Response.Write(" del tratamiento \"" + tratamiento.Nombre +"\"");

                Response.Write("<div class=\"turnoBlock\" idTurno=\""+ turno.Id +"\" idSesion=\"0\" id=\"turnoElement" + indiceSesiones + "\" style=\"display: inline-block; display: none\">");
                Response.Write("DIA:<select id=\"listaDia\" class=\"turnoDias\" >");

                // Crea la lista (con 30 días) para elegir un día del turno
                Response.Write("<option value=\"\"  </option>");
                for (int a = 0; a < 30; a++)
                {
                    Response.Write("<option>" + DateTime.Now.AddDays(a).ToShortDateString() + "</option>");
                }
                Response.Write("</select>");
                Response.Write(" HORARIO: ");
                Response.Write("<select id = \"listaHora\" class=\"turnoHoras\" >");

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
                        Response.Write("<option value=\"" + a.ToString() + ":00" + "\" >" + a.ToString() + ":00" + "</option>");
                        Response.Write("<option value=\"" + a.ToString() + ":15" + "\" >" + a.ToString() + ":15" + "</option>");
                        Response.Write("<option value=\"" + a.ToString() + ":30" + "\" >" + a.ToString() + ":30" + "</option>");
                        Response.Write("<option value=\"" + a.ToString() + ":45" + "\" >" + a.ToString() + ":45" + "</option>");
                    }
                }
                Response.Write("</select>");

                int idSucursal = Data2.Statics.Conversion.ObtenerLocal(int.Parse(idUser.Value));
                List<Struct_Box> boxesDeSucursal = Struct_Box.GetBoxesBySucursal(idSucursal);

                //Crea el select para el box de cada turno
                Response.Write(" BOX: ");
                Response.Write("<select id=\"listaboxes\" class=\"turnoBoxes\" >");
                Response.Write("<option value=\"\"  </option>");
                foreach (Struct_Box box in boxesDeSucursal)
                {
                    Response.Write("<option value=\"" + box.Id + "\">" + box.Detalle + "</option>");
                }
                Response.Write("</select>");

                Response.Write("</p></div>");
                Response.Write("</div>");
                indiceSesiones++;
                Response.Write("<br />");
            }
            Response.Write("<br />");
        }
        else
        {
            Response.Write("<div class=\"saveButtonStatus\" mostrarGuardar=\"No\">Turnos sin asignar del cliente " + Cliente.RS + ": </div>");
            Response.Write("<div>-No tiene turnos sin asignar- </div>");
            Response.Write("<br />");
            Response.Write("<br />");
        }


        if (Session["tratamiento"] != null)
        {
            Data2.Class.Struct_Treatment Tratamiento = Session["tratamiento"] as Data2.Class.Struct_Treatment;

            Response.Write("<div class=\"saveButtonStatus\" mostrarGuardar=\"Yes\"> Sesiones del tratamiento " + Tratamiento.Nombre + ": </div>");
            //Mostrar los turnos del tratamiento elegido
            foreach (Data2.Class.Struct_Sesiones sesion in Tratamiento.ListaSesiones)
            {
                Response.Write("<div class=\"contenedorSesiones\" style=\"display: inline-block;\">");
                Response.Write("<input type=\"checkbox\" onchange=\"toggleInfoSesiones(this.id)\" id=\"" + indiceSesiones + "\" class=\"checkboxTurno\" value=\"\"> Sesion \""+sesion.Nombre +"\"" );

                Response.Write("<div class=\"turnoBlock\" idSesion=\"" + sesion.Id + "\" idTurno=\"0\" id=\"turnoElement" + indiceSesiones + "\" style=\"display: inline-block; display: none\">");
                Response.Write("DIA:<select id=\"listaDia\" class=\"turnoDias\" >");

                // Crea la lista (con 30 días) para elegir un día del turno
                Response.Write("<option value=\"\"  </option>");
                for (int a = 0; a < 30; a++)
                {
                    Response.Write("<option>" + DateTime.Now.AddDays(a).ToShortDateString() + "</option>");
                }
                Response.Write("</select>");
                Response.Write(" HORARIO: ");
                Response.Write("<select id = \"listaHora\" class=\"turnoHoras\" >");

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
                        Response.Write("<option value=\"" + a.ToString() + ":00" + "\" >" + a.ToString() + ":00" + "</option>");
                        Response.Write("<option value=\"" + a.ToString() + ":15" + "\" >" + a.ToString() + ":15" + "</option>");
                        Response.Write("<option value=\"" + a.ToString() + ":30" + "\" >" + a.ToString() + ":30" + "</option>");
                        Response.Write("<option value=\"" + a.ToString() + ":45" + "\" >" + a.ToString() + ":45" + "</option>");
                    }
                }
                Response.Write("</select>");

                int idSucursal = Data2.Statics.Conversion.ObtenerLocal(int.Parse(idUser.Value));
                List<Struct_Box> boxesDeSucursal = Struct_Box.GetBoxesBySucursal(idSucursal);

                //Crea el select para el box de cada turno
                Response.Write(" BOX: ");
                //Response.Write("<select onchange=\"addBox()\" id=\"listaboxes\" class=\"turnoBoxes\" >");
                Response.Write("<select id=\"listaboxes\" class=\"turnoBoxes\" >");
                Response.Write("<option value=\"\"  </option>");
                foreach (Struct_Box box in boxesDeSucursal)
                {
                    Response.Write("<option value=\"" + box.Id + "\">" + box.Detalle + "</option>");
                }
                Response.Write("</select>");

                Response.Write("</p></div>");
                Response.Write("</div>");
                Response.Write("<br />");
                indiceSesiones++;
            }

        }
    }


%>
    <br />
    <br />
    <p>
    <asp:Button runat="server" ID="guardar" ClientIDMode="Static" Text="Guardar" OnClick="guardar_Click1" OnClientClick="return guardarTurnos()" CssClass="FormButton FirstElement LastElement" />
    </p>
    <!--OnClick="guardar_Click1"-->
&nbsp


<!-- Agenda del turnero -->
<h2>AGENDA TURNOS</h2>

<div>

    <!-- Eleccion de local a consultar -->
    <div>Local:
    <%
        List<Struct_Sucursales> listaLocales = Struct_Sucursales.searchLocales("%%%");

        Response.Write("<select onchange=\"listarBoxes(this.value)\"  class=\"localElegido\" >");
        Response.Write("<option value=\"-1\"></option>");
        foreach (Struct_Sucursales sucursal in listaLocales)
        {
            Response.Write("<option value=\"" + sucursal.Id +"\">" + sucursal.NombreLocal + "</option>");
        }
        Response.Write("</select>");
    %>
        <br />
        <script>
            function listarBoxes(idSucursal) {
                changeLocal(idSucursal);
                $.ajax({
                url: "/DesktopModules/Turnero/WebService.aspx",
                data: {
                    idsucursal: idSucursal
                },
                dataType: "json",
                success: function (data) {
                    $("#listaBoxes").empty();
                    $("#listaBoxes").append("<option value=\"\"> </option>");
                    for (i = 0; i < data.length; i++) {
                        var detalle = data[i].Detalle;
                        var idB = data[i].Id;
                        $("#listaBoxes").append("<option value=\"" + idB + "\">" + detalle + "</option>");
                    }
                },
                });
            }
            
        </script></div>

        <div style="display: inline-block;" id="boxLabel" >Box: 
            <select onchange="changeBox(this.value)" id="listaBoxes" style="display:none" class="boxElegido">
                <option value=""></option>
            </select>
        </div>
    <br />
    
    
    <input class="FormButton" type="button" style="margin-right: -4px;display:inline-block;" value="<" OnClick="moverColumnas(-1)" />
    <input class="FormButton" type="button" style="margin-left: 95.3%;margin-right: -4px;display:inline-block;" value=">" OnClick="moverColumnas(1)" />

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

<!-- Dialog de borrado de turnos -->
<div title="" id="PopupDeletThis">
    <div>Se borrarán todos los turnos correspondientes a este tratamiento y cliente. Está seguro? </div> <br />
    <asp:Button ID="aceptarDelete" runat="server" ClientIDMode="Static" Text="Aceptar" OnClientClick="ClosePopupYES(); return false;" />
    <asp:Button ID="cancelarDelete" runat="server" ClientIDMode="Static" Text="Cancelar" OnClientClick="ClosePopupNO(); return false;" />

</div>

<!-- Dialog de unassign de turnos -->
<div title="" id="PopupUnassignThis">
    <div>Este turno será borrado de la agenda y marcado como pendiente. Está seguro?</div> <br />
    <asp:Button ID="aceptarUnassign" runat="server" ClientIDMode="Static" Text="Aceptar" OnClientClick="ClosePopupUnassignYES(); return false;" />
    <asp:Button ID="cancelarUnassign" runat="server" ClientIDMode="Static" Text="Cancelar" OnClientClick="ClosePopupUnassignNO(); return false;" />

</div>


<input type="hidden" value="" id="treatsearchcondition" />
<input type="hidden" value="" id="clientsearchcondition" />
<input type="hidden" value="" id="popupDelete" />
<asp:HiddenField Value="" runat="server" ID="dia" ClientIDMode="Static"/>
<asp:HiddenField Value="" runat="server" ID="hora" ClientIDMode="Static"/>
<asp:HiddenField runat="server" ID="url" ClientIDMode="Static" />
<asp:HiddenField value="" runat="server" ID="turnosElegidos" ClientIDMode="Static"/>
<asp:HiddenField Value="" runat="server" id="offsetTabla" ClientIDMode="Static" />
<asp:HiddenField Value="" runat="server" ID="Sucursal" ClientIDMode="Static" />
<asp:HiddenField Value="" runat="server" ID="Box" ClientIDMode="Static" />
<asp:HiddenField Value="" runat="server" ID="modify" ClientIDMode="Static" />
<asp:HiddenField Value="" runat="server" ID="unassign" ClientIDMode="Static" />


<asp:HiddenField Value="" runat="server" ID="addTurnoStatus" ClientIDMode="Static" />
<asp:HiddenField Value="" runat="server" ID="conflictingHour" ClientIDMode="Static" />
<asp:HiddenField Value="" runat="server" ID="conflictingTime" ClientIDMode="Static" />
<asp:HiddenField Value="" runat="server" ID="conflictingBox" ClientIDMode="Static" />
<asp:HiddenField Value="" runat="server" ID="ocultarGUI" ClientIDMode="Static" />

<div id="detalleTurno" style="position: absolute; display:none; background-color:white; border:solid; border-color:crimson"></div>

<script>

    $("#boxLabel").hide();
    $('#guardar').hide();

    //Oculta o muestra el boton de tratamiento dependiendo de si se eligio o no cliente
    if ($("#ocultarGUI").val() == "true") {
        $(".guiTratamiento").hide();
    }
    else {
        $(".guiTratamiento").show();
    }

    //Chequea si hay un turno ya asignado en la fecha y hora elegida
    if ($("#addTurnoStatus").val() == "conflictingDate") {
        var fechaConflicto = $("#conflictingHour").val();
        var horaConflicto = $("#conflictingTime").val();
        var boxConflicto = $("#conflictingBox").val();
        alert('Ya hay un turno el ' + fechaConflicto + 'a las ' + horaConflicto + ' en el box ' + boxConflicto + '.');
    }

    if ($("#addTurnoStatus").val() == "success") {
        alert('Los turnos fueron agregados correctamente.');
    }


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
    
    //Creacion de popup de eliminacion de turnos
    var ConfirmDelete = $('#PopupDeletThis').dialog(
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

    //Creacion de popup de desasignacion de turnos
    var ConfirmUnassign = $('#PopupUnassignThis').dialog(
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

    //Close searcher del popup de aviso de eliminacion de tratamiento
    function ClosePopupYES() {
        $.ajax({
            url: "/desktopmodules/Turnero/webservice.aspx",
            dataType: "text",
            data:
            {
                IdTurnoDelete: $('#modify').val()
            },
            success: function (data)
            {
                if (data == "true") { alert('El/los turnos han sido borrados exitosamente'); }
                else { alert('Error no especificado'); }
                moverColumnas(0);
            }

        });
        ConfirmDelete.dialog('close');
    }
    function ClosePopupNO() {
        ConfirmDelete.dialog('close');
    }

    //Close searcher del popup de aviso de unassign de tratamiento
    function ClosePopupUnassignYES() {
        $.ajax({
            url: "/desktopmodules/Turnero/webservice.aspx",
            dataType: "text",
            data:
            {
                IdTurnoUnassign: $('#unassign').val()
            },
            success: function (data) {
                if (data == "true") { alert('La operacion ha sido completada exitosamente'); }
                else { alert('Error no especificado'); }
                moverColumnas(0);
            }
        });
        ConfirmUnassign.dialog('close');
    }
    function ClosePopupUnassignNO() {
        ConfirmUnassign.dialog('close');
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

    var url = $('#url').val();
    //Guarda turnos en el hiddenfield para que C# los pase a la base de datos
    function guardarTurnos()
    {
        var flag = true;
        var indexFields = 1;
        $("#turnosElegidos").val("");
        $(".turnoBlock").each(function (){
            if ($("#" + indexFields).prop('checked')) {
                valorIdTurno = $(this).attr("idTurno");
                valorIdSesion = $(this).attr("idSesion");

                var valordia = $(this).children(".turnoDias").val();
                var valorhora = $(this).children(".turnoHoras").val();
                var valorbox = $(this).children(".turnoBoxes").val();

                //Si no hay ningun valor vacio, crea el hiddenfield con el turno
                if ((valordia != "") && (valorhora != "") && (valorbox != "") ) {
                    actual = $("#turnosElegidos").val();
                    $("#turnosElegidos").val(actual + valorIdTurno + "," + valorIdSesion + "," + valordia + "," + valorhora + "," + valorbox + "*");
                }
                //Si hay algun valor vacio, borra el hidden y avisa que hay un valor vacio
                else {
                    $("#turnosElegidos").val("");
                    alert("Uno o mas campos no han sido completados");
                    flag = false;
                }

            }
            indexFields++;
        });

        return flag;
    }

    //Esconde el boton de guardado si no se eligio tratamiento
    $(".saveButtonStatus").each(function () {
        if ($(this).attr("mostrarGuardar") == "Yes") {
            $('#guardar').show();
        }
        else {
            $('#guardar').hide();
        }
    });


    // ---------------------------------------------------------------------------------------------------- //


    //Mueve las columnas de la agenda
    var turnosAjax;
    var fechaB = $('#dia').val();
    var offset = 0;
    function moverColumnas(scroll)
    {
        //Inception parte 1
        offset += scroll;
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

        //Inception parte 2
        function ajaxTurnos(fechaBas) {
            $.ajax({
                url: "/DesktopModules/Turnero/Webservice.aspx",
                data: {
                    BoxId: $('#Box').val(), fechaBase: fechaBas
                },
                dataType: "json",
                success: function (data) {
                    pintarTurnos(data);
                }
            });
        }

        //Inception parte 3
        //limpia la grid
        function pintarTurnos(turnosAjax) {
            var contador = 0;
            var conthora = 0;
            $('.dataGridTurnero').each(function () {
                if (contador == 5) { contador = 0; conthora++;}
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
                            $(this).text(turnosAjax[i].cliente + ' ');
                            var infoSesion = turnosAjax[i].idTurno;
                            $(this).append('<button class ="FormButton" type="button" value="editar_turno" OnClick="editarTurno(' + turnosAjax[i].idTurno + ')"> / </button>');
                            $(this).append('<button class ="FormButton" type="button" value="borrar_turno" OnClick="borrarTurno(' + turnosAjax[i].idTurno + ')"> X </button>');
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

    //Inception parte 4
    //Llena los hover de la agenda con datos sobre el turno
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


    // ---------------------------------------------------------------------------------------------------- //


    //Cambia la agenda depende del local que fue seleccionado
    function changeLocal(idSucursal) {

        if (idSucursal == -1) {
            $("#listaBoxes").hide();
            $("#boxLabel").hide();
        }
        else {
            $("#listaBoxes").show();
            $("#boxLabel").show();
        }

        $('#Sucursal').val(idSucursal);
        $('.dataGridTurnero').each(function () {
            $(this).text("");
            $(this).removeAttr("idSesion");
            $(this).unbind('mouseenter').unbind('mouseleave');
        });
    }

    //Cambia la agenda depende del local y box que fue seleccionado:
    function changeBox(idBox) {
        $('#Box').val(idBox);
        moverColumnas(0);
    }

    //Edita el turno seleccionado
    function editarTurno(IdTurno) {
        $('#unassign').val(IdTurno);
        ConfirmUnassign.dialog('open');
    }

    //Borra los turnos relacionados
    function borrarTurno(IdTurno) {
        $('#modify').val(IdTurno);
        ConfirmDelete.dialog('open');
    }

    // ---------------------------------------------------------------------------------------------------- //

    //Recorre las sesiones a turnear y muestra solo si tiene checkbox activado
    function toggleInfoSesiones(numId) {
        $("#turnoElement"+ numId).toggle();
    }

    

</script>
