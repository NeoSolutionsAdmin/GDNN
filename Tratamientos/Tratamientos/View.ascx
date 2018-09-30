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
              runat="server"/>

<script>

    //registrar el numero de textboxes agregados
    var numerosesion = 0;

    //cuando el user hace clic en agregar una sesion,
    function crearBoton()
    
        {
        //incrementar el contador de sesiones
        numerosesion = numerosesion + 1;

        //agregar el texto indicando el numero de sesion
        $('#contenedor').append('<p>Sesion número: ' + numerosesion);
        $('#contenedor').append('</p>');

        //agregar el text box para que el user cargue lo que se va a hacer en la sesion
        $('#contenedor').append('<input class="new-input" type="text" name="TextBoxSession">');
            
    }

    //recupera los datos cargados en los textboxes de sesion que fueron creados 
    function RecuperarDeTextboxes() {
        
        // array que contiene los items
        var newInputs = $('.new-input');
        // string para pasar a las funciones
        var textboxes = "";
        //negrada parte 1
        var imasuno = "0"
        
        //recorrer los nuevos textboxes que se agregaron en agregar sesiones
        if (newInputs.length) {
            for (i = 0; i < newInputs.length; i++) {

                //negrada parte 2
                imasuno = i + 1

                //armar el string
                textboxes = textboxes + " Sesion Numero " + imasuno + ":" + newInputs[i].value + " "
                
                //deprecated
                //$('#contenedor').append('<p>Value of input ' + (i + 1) + ': ' + newInputs[i].value + '</p>');
            }
        } else {
            //si no hay textboxes avisar que se necesita un minimo de una sesion
            alert("El tratamiento requiere una sesión como mínimo");
        }

        //test
        //alert("anda el boton");

        // pasar los datos al hiddenfield
        $("#TratamientosHiddenField").val([textboxes]);

    }

</script>


<p>
    &nbsp;</p>
<p>
    Costo ($)</p>
<asp:TextBox ID="CostoTratamientoTextBox" runat="server" Width="143px"></asp:TextBox>
<p>
    <asp:Button ID="GuardarButton" runat="server" OnClick="GuardarButton_Click" Text="Guardar" OnClientClick="RecuperarDeTextboxes()"/>
</p>



