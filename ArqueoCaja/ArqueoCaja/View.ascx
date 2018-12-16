<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.ArqueoCaja.View" %>
<%@ Import Namespace="Data2.Class"%>
<style>
    @import url('https://fonts.googleapis.com/css?family=Roboto');
</style>



<div>
    
    <!-- Título -->
    <h1>ARQUEO DE CAJA</h1>


    <input type="button" value="ACTUALIZAR" class="FormButton" onclick="actualizar()"  /> <br />
    <input type="button" value="INGRESO" style="display:inline-block" class="FormButton" onclick="abrirIngresoPopUp()" />
    <input type="button" value="RETIRO" style="display:inline-block" class="FormButton" onclick="abrirRetiroPopUp()" /> <br />
    <input type="button" value="CERRAR CAJA" class="FormButton" onclick="abrirCerrarArqueoPopUp()" />

    <!-- Tabla del arqueo -->
    <div class="arqueoTabla">
        <table>
            <tr>
                <th style="width:150px">FECHA</th>
                <th>DETALLE</th>
                <th style="width:125px">DEBE</th>
                <th style="width:125px">HABER</th>
            </tr>
            <asp:HiddenField runat="server" id="hf_userid" />
            <!-- Ejemplos -->
            <%
                int LocalId = Data2.Statics.Conversion.ObtenerLocal(int.Parse(hf_userid.Value));
                Struct_ArqueoDeCaja auxArq =  Data2.Class.Struct_ArqueoDeCaja.GetLastArqueo(LocalId);
                if (auxArq != null)
                {
                    Response.Write("<tr class=\"arqueoTableBlue\">");
                    Response.Write("<td>" + auxArq.GetFecha.ToString() + "</td>");
                    Response.Write("<td>" + auxArq.GetAnotaciones.ToString() + "</td>");
                    decimal DEBE = 0m;
                    decimal HABER = 0m;

                    if (auxArq.GetTotal > 0m)
                    {
                        DEBE = auxArq.GetTotal;
                    }
                    else
                    {
                        HABER -= auxArq.GetTotal;
                    }

                    Response.Write("<td>" + auxArq.GetAnotaciones.ToString() + "</td>");
                    Response.Write("<td>" + DEBE.ToString() + "</td>");
                    Response.Write("<td>" + HABER.ToString() + "</td>");
                    Response.Write("</tr>");
                    List<Struct_Factura> ListaFacturas =  Struct_Factura.GetFacturasBetweenDates(auxArq.GetFecha, DateTime.Now.AddDays(2), LocalId, false, Struct_Factura.TipoDeFactura.Null);
                    if (ListaFacturas != null && ListaFacturas.Count > 0)
                    {
                        foreach (Struct_Factura f in ListaFacturas)
                        {
                            Response.Write("<tr class=\"arqueoTableGreen\">");
                            Response.Write("<td>" + f.Fecha + "</td>");
                            if (f.IdCuentaCorriente != 0)
                            {
                                Response.Write("<td>" + "VENTA Factura:" + Struct_Cliente.GetClient(f.IdCuentaCorriente, LocalId).RS + "</td>");
                            }
                            else
                            {
                                Response.Write("<td>" + "VENTA LIBRE" + "</td>");
                            }
                            Response.Write("<td>" +f.GetTotalConIvaIncluido().ToString() +"<td>" );
                            Response.Write("<td>0</td>");
                        }
                    }
                }


                %>
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

    <!-- REGISTRAR INGRESO -->
    <div id="ingresoPupUp" title="REGISTRAR INGRESO">
        
        <!-- Contiene el botón Detalle y el textarea para introducir el detalle -->
        <div>
            <input type="button" value="DETALLE"  style="display:inline-block; width:300px" class="fakeButton" />  <br />
            <textarea maxlength="250" id="ingresoTextboxDetalle" style="margin-top:-5px; resize:none; height:150px; width:300px; display:inline-block" rows:10 ></textarea> 
        </div> <br />
        <!-- Contiene el botón Monto y el textbox para introducir el monto -->
        <div style="margin-top: -25.5px;">
            <input type="button" value="MONTO ($)" class="fakeButton" />
            <input type="text" id="ingresoTextboxMonto" style="height:39.5px; width: 214px; margin-left: -1.5px;" placeholder="0,00" />
        </div>
        
        <!-- Guardar los valores -->
        <input style="width:100%" type="button" value="GUARDAR" class="FormButton" onclick="guardarIngreso()" />

    </div>

    <!-- REGISTRAR RETIRO -->
    <div id="retiroPopPup" title="REGISTRAR RETIRO">

        <!-- Contiene el botón Detalle y el textarea para introducir el detalle -->
        <div>
            <input type="button" value="DETALLE"  style="display:inline-block; width:300px" class="fakeButton" />  <br />
            <textarea id="retiroTextboxDetalle" maxlength="250" style="margin-top:-5px; resize:none; height:150px; width:300px; display:inline-block" rows:10 ></textarea> 
        </div> <br />
        <!-- Contiene el botón Monto y el textbox para introducir el monto -->
        <div style="margin-top: -25.5px;">
            <input type="button" value="MONTO ($)" class="fakeButton" />
            <input type="text" id="retiroTextboxMonto" style="height:39.5px; width: 214px; margin-left: -1.5px;" placeholder="0,00" />
        </div>

        <!-- Guardar los valores -->
        <input type="button" style="width:100%" value="CERRAR" class="FormButton" onclick="guardarRetiro()" />

    </div>


    <!-- CERRAR ARQUEO DE CAJA -->
    <div id="cerrarArqueoPopUp" title="CERRAR ARQUEO DE CAJA">
        
        
        <!-- Listado de datos a ingresar -->
        <div class="divArqueo">
            <input type="button" value="MONEDAS" class="buttonArqueo fakeButton" />
            <input type="text" class="textboxArqueo" placeholder="Ingrese monto total" />
        </div>
        <div class="divArqueo">
            <input type="button" value="BILLETES $2" class="buttonArqueo fakeButton" />
            <input type="text" class="textboxArqueo" placeholder="Ingrese cant. de billetes" />
        </div>
        <div class="divArqueo">
            <input type="button" value="BILLETES $5" class="buttonArqueo fakeButton" />
            <input type="text" class="textboxArqueo" placeholder="Ingrese cant. de billetes" />
        </div>
        <div class="divArqueo">
            <input type="button" value="BILLETES $10" class="buttonArqueo fakeButton" />
            <input type="text" class="textboxArqueo" placeholder="Ingrese cant. de billetes" />
        </div>
        <div class="divArqueo">
            <input type="button" value="BILLETES $20" class="buttonArqueo fakeButton" />
            <input type="text" class="textboxArqueo" placeholder="Ingrese cant. de billetes" />
        </div>
        <div class="divArqueo">
            <input type="button" value="BILLETES $50" class="buttonArqueo fakeButton" />
            <input type="text" class="textboxArqueo" placeholder="Ingrese cant. de billetes" />
        </div>
        <div class="divArqueo">
            <input type="button" value="BILLETES $100" class="buttonArqueo fakeButton" />
            <input type="text" class="textboxArqueo" placeholder="Ingrese cant. de billetes" />
        </div>
        <div class="divArqueo">
            <input type="button" value="BILLETES $500" class="buttonArqueo fakeButton" />
            <input type="text" class="textboxArqueo" placeholder="Ingrese cant. de billetes" />
        </div>
        <div class="divArqueo">
            <input type="button" value="BILLETES $1000" class="buttonArqueo fakeButton" />
            <input type="text" class="textboxArqueo" placeholder="Ingrese cant. de billetes" />
        </div>
        <div class="divArqueo">
            <input type="button" value="CHEQUES"class="buttonArqueo fakeButton" />
            <input type="text" class="textboxArqueo" placeholder="Ingrese monto total"/>
        </div>
        <div class="divArqueo">
            <input type="button" value="TARJ. CRED."class="buttonArqueo fakeButton" />
            <input type="text" class="textboxArqueo" placeholder="Ingrese monto total"/>
        </div>
        <div class="divArqueo"> 
            <input type="button" value="OTROS"class="buttonArqueo fakeButton" />
            <input type="text" class="textboxArqueo" placeholder="Ingrese monto total"/>
        </div>
        
        <!-- Guardar los valores -->
        <input type="button" value="CERRAR" class="FormButton" onclick="guardarCerrarArqueo()" />


    </div>
</div>

<!-- Hiddens -->

<!-- INGRESO -->
<input type="hidden" id="ingresoHidden" />

<!-- RETIRO -->
<input type="hidden" id="retiroHidden" />

<!-- CERRAR ARQUEO -->
<input type="hidden" id="cerrarHidden" />

<!-- URL -->
<asp:HiddenField runat="server" ID="url" ClientIDMode="Static"  />


<script>

    //----------     POPUPS     ----------
    //
    // INGRESO
    var ingresoPopUp = $('#ingresoPupUp').dialog(
        {
            autoOpen: false,
            closeOnEscape: false,
            modal: true,
            dialogClass: 'dnnFormPopup',
            resizable: false,
            draggable: false,
            width: 'auto',
            show: 'blind',
            hide: 'blind',
            closeOnEscape: true,

        });
    //
    // Abrir INGRESO
    function abrirIngresoPopUp() {

        ingresoPopUp.dialog('open')

    }
    //
    // RETIRO
    var retiroPopUp = $('#retiroPopPup').dialog(
        {
            autoOpen: false,
            closeOnEscape: false,
            modal: true,
            dialogClass: 'dnnFormPopup',
            resizable: false,
            draggable: false,
            width: 'auto',
            show: 'blind',
            hide: 'blind',
            closeOnEscape: true,
        });
    //
    // Abrir RETIRO
    function abrirRetiroPopUp() {

        retiroPopUp.dialog('open')

    }
    //
    // CERRAR ARQUEO
    var cerrarArqueoPopUp = $('#cerrarArqueoPopUp').dialog(
        {
            autoOpen: false,
            closeOnEscape: false,
            modal: true,
            dialogClass: 'dnnFormPopup',
            resizable: false,
            draggable: false,
            width: 'auto',
            show: 'blind',
            hide: 'blind',
            closeOnEscape: true,
            height: 500,
            width: 370,
        });
    //
    // Abrir CERRAR ARQUEO
    function abrirCerrarArqueoPopUp() {

        cerrarArqueoPopUp.dialog('open')

    }




    //----------     HIDDENS     --------
    //
    //ARQUEO
    function guardarCerrarArqueo() {

        //Guardar todo en un hidden
        var textBoxes = $('.textboxArqueo');
        var string = '';

        for (a = 0; a < textBoxes.length; a++) {
            if (textBoxes[a].value == '' || isNaN(textBoxes[a].value)) {
                alert('Ingrese un valor correcto en los espacios.');
                string = '';
                break;
            }
            else {
                string = string + '*' + textBoxes[a].value;                
            }
            
        }
        if (string != '') {
            var url = $('#url').val()
            window.location.href = url + '?cerrar=' + string
        }


    }
    //
    //INGRESO
    function guardarIngreso() {

        var string = ''

        if ($('#ingresoTextboxDetalle').val() != '' && $('#ingresoTextboxMonto').val() != '') {
            if (isNaN($('#ingresoTextboxMonto').val())) {
                alert('Ingrese un valor correcto en los espacios.')
            }
            else {
                string = $('#ingresoTextboxDetalle').val() + '*' + $('#ingresoTextboxMonto').val()

                window.location.href = $('#url').val() + '?ingreso=' + string
            }
            
        }


    }
    //
    //RETIRO
    function guardarRetiro() {

        var string = ''

        if ($('#retiroTextboxDetalle').val() != '' && $('#retiroTextboxMonto').val()) {
            if (isNaN($('#retiroTextboxMonto').val())) {
                alert('Ingrese un valor correcto en los espacios.')
            }
            else {
                string = $('#retiroTextboxDetalle').val() + '*' + $('#retiroTextboxMonto').val()

                window.location.href = $('#url').val() + '?retiro=' + string
            }
        }


    }



    //----------     OTROS     ----------
    //
    function actualizar() {
        window.location.href = $('#url').val();
    }



</script>