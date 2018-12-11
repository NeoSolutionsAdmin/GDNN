<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.ArqueoCaja.View" %>

<style>
    @import url('https://fonts.googleapis.com/css?family=Roboto');
</style>



<div>
    
    <!-- Título -->
    <h1>ARQUEO DE CAJA</h1>


    <input type="button" value="ACTUALIZAR" class="FormButton" /> <br />
    <input type="button" value="INGRESO" style="display:inline-block" class="FormButton" />
    <input type="button" value="RETIRO" style="display:inline-block" class="FormButton" /> <br />
    <input type="button" value="CERRAR CAJA" class="FormButton" />

    <!-- Tabla del arqueo -->
    <div class="arqueoTabla">
        <table>
            <tr>
                <th style="width:150px">FECHA</th>
                <th>DETALLE</th>
                <th style="width:125px">DEBE</th>
                <th style="width:125px">HABER</th>
            </tr>

            <!-- Ejemplos -->
            <tr class="arqueoTableBlue">
                <td>10/12/2018 02:37</td>
                <td style="text-align:left;">Último arqueo de caja</td>
                <td>$0,00</td>
                <td>$550,00</td>
            </tr>
            <tr class="arqueoTableGreen" >
                <td>09/12/2018 02:37</td>
                <td style="text-align:left">EJEMPLO DETALLE 1</td>
                <td>$500,00</td>
                <td>$0,00</td>
            </tr>
            <tr class="arqueoTableRed">
                <td>10/12/2018 02:37</td>
                <td style="text-align:left">EJEMPLO DETALLE 2</td>
                <td>$0,00</td>
                <td>$550,00</td>
            </tr>
            
        </table>
    </div>




</div>





<script>



</script>