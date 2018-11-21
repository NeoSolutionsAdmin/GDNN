<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Resportes.View" %>
<asp:Button Id="btnReporteDeVentaTratamientos" runat="server" onclick="btnReporteDeVentaTratamientos_Click"/>
<div id="ContainerView" runat="server">
    <table id="mitabla">
        <tbody>
            <tr><th>Hola1</th><th>Hola2</th><th>Hola3</th></tr>
            <tr><th>1</th><th>2</th><th>3</th></tr>
        </tbody>

    </table>
</div>
<script>
    
function ExportToExcel(mytblId){
       var htmltable= document.getElementById(mytblId);
       var html = htmltable.outerHTML;
       window.open('data:application/vnd.ms-excel,' + encodeURIComponent(html));
    }

    ExportToExcel("mitabla");

</script>
