<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Tratamientos.View" %>


<p>
    Agregar Tratamiento</p>
<p>
    Nombre del Tratamiento</p>
<asp:TextBox ID="NombreTratamientoTextBox" runat="server" Width="425px"></asp:TextBox>
<p>
    Descripcion del Tratamiento</p>
<asp:TextBox ID="DescripcionTratamientoTextBox" runat="server" Height="77px" TextMode="MultiLine" Width="427px"></asp:TextBox>


<p>
    Sesiones del tratamiento</p>

<div id="contenedor"> </div>

<input type="button" onclick="crearBoton()" value="Añadir Sesion" />

<asp:hiddenfield id="TratamientosHiddenField"
              value="" 
              runat="server" ClientIDMode="static"/>


<p>
    &nbsp;</p>
<p>
    Costo ($)</p>
<asp:TextBox ID="CostoTratamientoTextBox" runat="server" Width="143px"></asp:TextBox>
<p>
    <asp:Button ID="GuardarButton" runat="server" OnClick="GuardarButton_Click" Text="Guardar" OnClientClick="RecuperarDeTextboxes()"/>
</p>

<div>
    <table>
        <tr>
            <th>Nombre</th>
            <th>Precio</th>
            <th>Fecha Creacion</th>
            <th>Fecha Caducidad</th>
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
                    Response.Write("<td>"+T.Precio.ToString()+"</td>");
                    Response.Write("<td>"+T.FechaCreacion.ToShortDateString()+"</td>");
                    Response.Write("<td>"+T.FechaCaducidad.ToShortDateString()+"</td>");
                    Response.Write("<td>"+T.Descripcion+"</td>");
                    Response.Write("<td><input type=\"button\" value=\"Editar\" onclick=\"EditarTratamiento(" + T.Id + ")\"</td>");
                    Response.Write("</tr>");
                }

            }

            %>
    </table>
</div>

<script>

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
        $('#contenedor').append('<p>Nombre de sesion:');
        $('#contenedor').append('<input class="new-input" type="text" name="Nombre Sesion">');
        $('#contenedor').append('</p>');

        $('#contenedor').append('<p>Descripcion:');
        $('#contenedor').append('<input class="new-input" type="text" name="Descripcion">');
        $('#contenedor').append('</p>');

        $('#contenedor').append('<p>Precio:');
        $('#contenedor').append('<input class="new-input" type="text" name="Precio">');
        $('#contenedor').append('</p>');

        $('#contenedor').append('<p>Costo:');
        $('#contenedor').append('<input class="new-input" type="text" name="Costo">');
        $('#contenedor').append('</p>');

    }

    //recupera los datos cargados en los textboxes de sesion que fueron creados 
    function RecuperarDeTextboxes() {
        
        // array que contiene los items
        var newInputs = $('.new-input');
        // string para pasar a las funciones
        var textboxes = "";
        
        //recorrer los nuevos textboxes que se agregaron en agregar sesiones
        if (newInputs.length) {
            for (i = 0; i < newInputs.length; i++) {

                //armar el string
                textboxes = textboxes + newInputs[i].value + ",";
                if (i == newInputs.length - 1)  textboxes = textboxes + "*";
                
            }
        } else {
            //si no hay textboxes avisar que se necesita un minimo de una sesion
            alert("El tratamiento requiere una sesión como mínimo");
        }

        // pasar los datos al hiddenfield
        $("#TratamientosHiddenField").val([textboxes]);
    }

    function EditarTratamiento(LocalId)
    {
        window.location.href = "./?EditTreat=" + LocalId; 
    }

</script>