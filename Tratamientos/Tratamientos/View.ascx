<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Tratamientos.View" %>


<p>
    Agregar Tratamiento</p>
<p>
    Nombre del Tratamiento</p>
<asp:TextBox ID="NombreTratamientoTextBox" runat="server" Width="425px" ClientIDMode="Static"></asp:TextBox>
<p>
    Descripcion del Tratamiento</p>
<asp:TextBox ID="DescripcionTratamientoTextBox"  runat="server" Height="77px" ClientIDMode="Static" TextMode="MultiLine" Width="427px" ></asp:TextBox>

<div id="bloqueSesiones">
    <p>Sesiones del tratamiento:</p>
    <div id="contenedor"> </div>
</div>

<input type="button" onclick="crearBoton()" value="Añadir Sesion" id="botonAddSession"/>

<asp:hiddenfield id="TratamientosHiddenField"
              value="" 
              runat="server" ClientIDMode="static"/>

<asp:hiddenfield id="DeletedTreatment"
              value="" 
              runat="server" ClientIDMode="static"/>
<asp:HiddenField id="EditingTreatment"
              value=""
              runat="server" ClientIDMode="Static" />

<p>
    &nbsp;</p>
<p>
    Costo ($)</p>
<asp:TextBox ID="CostoTratamientoTextBox" runat="server" ClientIDMode="Static" Width="143px"></asp:TextBox>
<p>
    <asp:Button ID="GuardarButton"   runat="server" OnClick="GuardarButton_Click" Text="Guardar" OnClientClick="return RecuperarDeTextboxes()"/>
</p>

<div>
    <table>
        <tr>
            <th>Nombre</th>
            <th>Precio</th>
            <th>Fecha Creacion</th>
            <th>Descripcion</th>
        </tr>
        <%
            if (Session["IdLocal"] != null)
            {
                int idlocal =  Convert.ToInt32( Session["IdLocal"] );
                List<Data2.Class.Struct_Treatment> ListaT = Data2.Class.Struct_Treatment.GetTreatmentsBySucursal(idlocal);
                foreach (Data2.Class.Struct_Treatment T in ListaT)
                {
                    Response.Write("<tr>");
                    Response.Write("<td>"+ T.Nombre +"</td>");
                    Response.Write("<td> $"+T.Precio.ToString().Split(new[] {","},0)[0]+"</td>");
                    Response.Write("<td>"+T.FechaCreacion.ToShortDateString()+"</td>");
                    Response.Write("<td>"+T.Descripcion+"</td>");
                    Response.Write("<td><input type=\"button\" value=\"Editar\" onclick=\"EditarTratamiento(" + T.Id + ")\">");
                    Response.Write("<td><input type=\"button\" value=\"Borrar\" onclick=\"BorrarTratamiento(" + T.Id + ")\"> </td>");
                    Response.Write("</tr>");
                }

            }

            %>
    </table>
</div>

<script>
    //Chequear si se borró un tratamiento antes del page reload
    if ($('#DeletedTreatment').val() == "YES") {
        alert("El tratamiento se borró correctamente");
        $('#DeletedTreatment').val("NO");
    }

    //Chequear si se esta editando un tratamiento para ocultar el boton de sesion
    if ($('#EditingTreatment').val() == "YES")
    {
        $('#bloqueSesiones').hide();
        $('#botonAddSession').hide();
    }
    else
    {
        $('#bloqueSesiones').show();
        $('#botonAddSession').show();
    }

    //registrar el numero de textboxes agregados
    var numerosesion = 0;

    //cuando el user hace clic en agregar una sesion,
    function crearBoton()
    
        {
        //incrementar el contador de sesiones
        numerosesion++;

        //agregar el texto indicando el numero de sesion
        $('#contenedor').append('<p>Sesion número: ' + numerosesion+'</p>');

        //agregar el text box para que el user cargue lo que se va a hacer en la sesion
        $('#contenedor').append('<p>Nombre de sesion: <input class="new-input" type="text" name="Nombre Sesion"> </p>');
        $('#contenedor').append('<p>Descripcion: <input class="new-input" type="text" name="Descripcion">');
        $('#contenedor').append('<p>Precio: <input class="new-input" type="text" name="Precio"></p>');
        $('#contenedor').append('<p>Costo: <input class="new-input" type="text" name="Costo"></p>');

    }

    //recupera los datos cargados en los textboxes de sesion que fueron creados 
    function RecuperarDeTextboxes() {

        if ($('#NombreTratamientoTextBox').val().length == 0 || $('#DescripcionTratamientoTextBox').val().length == 0 || $('#CostoTratamientoTextBox').val().length == 0)
        {
            alert("Uno o mas campos no fueron completados");
            return false;
        }
        else
        {
            //Si no se esta editando un tratamiento, se empiezan a leer los valores de las sesiones
            if ($('#EditingTreatment').val() != "YES")
            {
                // array que contiene los items
                var newInputs = $('.new-input');
                // string para pasar a las funciones
                var textboxes = "";

                //recorrer los nuevos textboxes que se agregaron en agregar sesiones
                if (newInputs.length) {
                    for (i = 0; i < newInputs.length; i++) {

                        //armar el string
                        textboxes = textboxes + newInputs[i].value + ",";
                        if (i == newInputs.length - 1) textboxes = textboxes + "*";

                    }
                } else {
                    //si no hay textboxes avisar que se necesita un minimo de una sesion
                    alert("El tratamiento requiere una sesión como mínimo");
                    return false;
                }

                // pasar los datos al hiddenfield
                $("#TratamientosHiddenField").val([textboxes]);
            }
            //Si ya se esta editando el tratamiento, ocultar todo lo de sesion
            else
            {
                $('#EditingTreatment').val("NO");
            }

        }
    }

    function EditarTratamiento(LocalId) {
        window.location.href = "./?EditTreat=" + LocalId;
    }

    function BorrarTratamiento(LocalId) {
        window.location.href = "./?DeletTreat=" + LocalId;
    }




</script>