<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.RetirosYPagos.View" %>
<div>Usuario Logeado: <span id="LoggedUser" style="color:darkolivegreen;font-weight:bolder"> </span></div>


<style>
    
</style>

<div id="ContainerAccordion">
    <h3>Pagos</h3>
    <div>
        <p>
        <span class="FormLabel" style="display:inline-block; width:70px">Monto:</span>$<asp:TextBox class="AtroxTextBoxMount" ID="txt_MontoPago" runat="server"/><br />
        <span class="FormLabel" style="display:inline-block; width:70px">Concepto:</span ><asp:TextBox class="AtroxTextBoxLarge" ID="txt_ConceptoPago" runat="server" /><br />
            
        <asp:Button Text="Generar Pago" class="FormButton FirstElement LastElement" runat="server" ID="btngenerarPago" OnClick="btngenerarPago_Click" />
            </p>
    </div>
    <h3>Retiros</h3>
    <div>
         <p>
        <span class="FormLabel" style="display:inline-block; width:70px">Monto:</span>$<asp:TextBox class="AtroxTextBoxMount" ID="txtMontoRetiro" runat="server"/><br />
        <span class="FormLabel" style="display:inline-block; width:70px">Concepto:</span ><asp:TextBox class="AtroxTextBoxLarge" ID="txt_ConceptoRetiro" runat="server" /><br />
            
        <asp:Button Text="Generar Retiro" class="FormButton FirstElement LastElement" runat="server" ID="btngenerarRetiro" OnClick="btngenerarRetiro_Click" />
            </p>

    </div>

</div>
<asp:HiddenField Id="IDU" runat="server" ClientIDMode="Static" />
<asp:HiddenField Id="IDS" runat="server" ClientIDMode="Static"/>
<asp:HiddenField ID="ConfirmationWindow" runat="server" ClientIDMode="Static"/>
<!-- Cuadros emergentes -->

<div id="sellerlogin" title="Error en login">
    <div> Usted no se encuentra logeado por favor dirigirse a <br /> 
        Facturacion para establecer un login de vendedor  <br />
        haciendo click <a href="/MyManager/Facturacion2"> aquí</a>
    </div>
</div>
<script>
    var SELLER;
    $( "#ContainerAccordion" ).accordion();
    var SellerLogin = $('#sellerlogin').dialog(
        {
            autoOpen: false,
            closeOnEscape: false,
            dialogClass: "noclose",
            modal: true,
            resizable: false,
            draggable: false,
            width:'auto'
        });
    if (Cookies.get('SELLER') == undefined) {
        //Aqui muestra cuadro de dialogo mandando a registro de sistema
        SELLER = undefined;
        SellerLogin.dialog('open');
    } else
    {
        //Aqui setea usuario loggeado en Loggeduser Span...
        SELLER = Cookies.get('SELLER');
        $("#IDS").val(Cookies.get('IDSELLER'));
        setUser();
    }
   
    function checkconfirmationwindow()
    {
        var CW = $('#ConfirmationWindow').val();
        if (CW != "")
        {
            alert(CW);
        }
    }
    function setUser()
    {
        $('#LoggedUser').text(SELLER);
    }

    checkconfirmationwindow();


</script>