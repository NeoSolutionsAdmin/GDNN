<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Tratamientos.View" %>



<style>
    @import url('https://fonts.googleapis.com/css?family=Roboto');
</style>

<div style="font-family:'Roboto',sans-serif">
    <h1 style="margin-left:10px">AGREGAR TRATAMIENTO</h1>

<div id="divNombre" style="margin-top:20px;margin-bottom:20px">

    <input value="NOMBRE" style="text-align: center;width:75px; height:30px;" class="fakeButton" onclick="nombreListo()" />
    <asp:TextBox ID="NombreTratamientoTextBox" style="height:30px" runat="server" ClientIDMode="Static"></asp:TextBox>

</div>
    
<div>

    <input value="DESCRIPCION" style="text-align: center;width:110px; height:30px;" class="fakeButton" onclick="descripcionListo()" />
    <asp:TextBox ID="DescripcionTratamientoTextBox" style="height:30px;resize:none" runat="server" ClientIDMode="Static"  ></asp:TextBox>

</div>




    <!-- DIV PARA DEFINIR LAS SESIONES DEL TRATAMIENTO -->
<div style="margin-top:40px" id="bloqueSesiones">
    <!-- Div para contener las sesiones -->
    <div id="contenedor"></div>
    <input type="button" style="display:inline-block" class="FormButton" onclick="crearBoton()" value="Añadir Sesion" id="botonAddSession"/>
    <input type="button" style="display:inline-block" class="FormButton" onclick="eliminarBoton()" value="Eliminar Sesion" id="botonRemoveSession"/>
</div>



<asp:hiddenfield id="TratamientosHiddenField"
              value="" 
              runat="server" ClientIDMode="static"/>

<asp:hiddenfield id="DeletedTreatment"
              value="" 
              runat="server" ClientIDMode="static"/>
<asp:HiddenField id="EditingTreatment"
              value=""
              runat="server" ClientIDMode="Static" />
<asp:HiddenField id="currentUrl"
              value=""
              runat="server" ClientIDMode="Static" />

<p>
    &nbsp;</p>

    <div style="margin-bottom:20px">
        <input value="COSTO $" style="display:inline-block;text-align: center;width:110px; height:30px;" class="fakeButton"  />
        <asp:TextBox class="textBoxBusqueda" style="display:inline-block;height:30px" ID="CostoTratamientoTextBox" runat="server" ClientIDMode="Static" Width="143px"></asp:TextBox>
    </div>


<p>
    <asp:Button style="margin: 0px 90px 50px 90px;" class="FormButton" ID="GuardarButton"   runat="server" OnClick="GuardarButton_Click" Text="Guardar" OnClientClick="return RecuperarDeTextboxes()"/>
</p>

<div class="Resumen">
    <table>
        <tr>
            <th>NOMBRE</th>
            <th>PRECIO</th>
            <th>FECHA CREACION</th>
            <th>CANTIDAD DE SESIONES</th>
            <th>DESCRIPCION</th>
            <th></th>
        </tr>
        <%
            if (Session["IdLocal"] != null)
            {
                int idlocal =  Convert.ToInt32( Session["IdLocal"] );
                List<Data2.Class.Struct_Treatment> ListaT = Data2.Class.Struct_Treatment.GetTreatmentsBySucursal(idlocal);
                if (ListaT != null && ListaT.Count != 0)
                {
                    int index = 0;
                    foreach (Data2.Class.Struct_Treatment T in ListaT)
                    {
                        index++;
                        Response.Write("<tr id=\"rowTreatment\" bavithra=\"rowIndex"+ index +"\" onclick=\"showses(this)\" >");
                        Response.Write("<td>"+ T.Nombre +"</td>");
                        Response.Write("<td> $"+T.Precio.ToString().Split(new[] {","},0)[0]+"</td>");
                        Response.Write("<td>"+T.FechaCreacion.ToShortDateString()+"</td>");
                        Response.Write("<td>" + T.ListaSesiones.Count + "</td>");
                        Response.Write("<td>"+T.Descripcion+"</td>");
                        Response.Write("<td><input type=\"button\" value=\"Editar\" onclick=\"EditarTratamiento(" + T.Id + ")\">");
                        Response.Write("<td><input type=\"button\" value=\"Borrar\" onclick=\"BorrarTratamiento(" + T.Id + ")\"> </td>");
                        Response.Write("</tr>");
                        
                        foreach (Data2.Class.Struct_Sesiones sesion in T.ListaSesiones)
                        {
                            Response.Write("<tr class=\"rowIndex"+index+"\" style=\"display:none;\" >");
                            Response.Write("<td style=\"text-align: right;\"> </td>");
                            Response.Write("<td> </td>");
                            Response.Write("<td> </td>");
                            Response.Write("<td>" + sesion.Nombre + "</td>");
                            Response.Write("<td>"+ sesion.Descripcion +"</td>");
                            Response.Write("<td> </td>");
                            Response.Write("<td> </td>");
                            Response.Write("</tr>");
                        }
                    }
                }


            }

            %>
    </table>
</div>
</div>


<script>


    function nombreListo() {
        $('#divNombre')
    }


    


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
    function crearBoton() {
        //incrementar el contador de sesiones
        numerosesion++;


        //Crea todo un div con el numero de sesion
        $('#contenedor').append('<div style="margin:10px;" id=sesionNro' + numerosesion + '><div style="margin-top:5px;margin-bottom:5px">SESIÓN '+numerosesion+'</div><br /><div>Nombre de sesion: <input class="new-input" type="text" name="Nombre Sesion"></div><br /><div>Descripcion: <input class="new-input" type="text" name="Descripcion"></div><br /><div>Precio: <input class="new-input" type="text" name="Precio"></div><br /><div>Costo: <input class="new-input" type="text" name="Costo"></div></div>')

        //Oculta y muestra automaticamente el div creado
        $('#sesionNro' + numerosesion).hide();
        $('#sesionNro' + numerosesion).show('slow');


    }
    //
    function eliminarBoton() {

        $('#sesionNro' + numerosesion).hide('slow', function () {
            $('#sesionNro' + numerosesion).remove();
             if (numerosesion > 0) {
            numerosesion--;
        }

        });        
        

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
                        if ( (i+1)%4 == 0) textboxes = textboxes + "*";

                    }
                } else {
                    //si no hay textboxes avisar que se necesita un minimo de una sesion
                    alert("El tratamiento requiere una sesión como mínimo");
                    return false;
                }

                // pasar los datos al hiddenfield
                $("#TratamientosHiddenField").val(textboxes);
            }
            //Si ya se esta editando el tratamiento, ocultar todo lo de sesion
            else
            {
                $('#EditingTreatment').val("NO");
            }

        }
    }

    function EditarTratamiento(LocalId) {
        window.location.href = $("#currentUrl").val() + "?EditTreat=" + LocalId;
    }

    function BorrarTratamiento(LocalId) {
        window.location.href = $("#currentUrl").val() + "?DeletTreat=" + LocalId;
    }

    function showses(filaTr) {
        var claseSesiones = $(filaTr).attr("bavithra");
        $('.'+claseSesiones).toggle(200);
    }
    



</script>