<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.TransferenciaStock.View" %>



<style>
@import url('https://fonts.googleapis.com/css?family=Roboto');
</style> 

<!-- TRANSFERENCIA STOCK -->
<div class="Busqueda">

    <h1>TRANSFERIR STOCK</h1>    

    <!-- BUSCADOR DE LOCAL RECEPTOR -->
    <div class="Busqueda" id="buscadorLocalReceptor">
        
        <!-- TextBox para ingresar la cadena de búsqueda -->
        <div>
            BUSCAR LOCAL RECEPTOR <asp:TextBox
            style="margin-left:5px;"
            runat="server"
            clientIdMode="Static"
            ID="txtBuscadorLocal"></asp:TextBox>
        </div>
        

        <!-- Tabla de resultados -->
        <div>
            <table>
            <tr>
                <th>Nombre</th>
            </tr>
        </table>
        </div>
        
    </div>

    
    <!-- BUSCADOR DE PRODUCTO -->
    <div class="Busqueda" id="buscadorProducto">
        
        <!-- TextBox para ingresar la cadena de búsqueda -->
        BUSCAR PRODUCTO <asp:TextBox
            style="margin-left:5px;"
            runat="server"
            clientIdMode="Static"
            ID="txtBuscadorProducto"></asp:TextBox>

        <!-- Tabla de resultados -->
        <table>
            <tr>
                <th>Nombre</th>
                <th>Cantidad</th>
            </tr>
        </table>
    </div>




    <!-- RESUMEN TRANSFERENCIA DE STOCK -->
    
    <div class="Resumen">
        <p>RESUMEN DE TRANSFERENCIA</p>
        <table>
            <tr>
                <th>PRODUCTO</th>
                <th>CANTIDAD A ENVIAR</th>
                <th>LOCAL RECEPTOR</th>
            </tr>            
        </table>
    </div>
    


</div>