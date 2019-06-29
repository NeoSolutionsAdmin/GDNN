<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.ListadoFacturas.View" %>

<div>
    <div class="ResponsiveDiv">
        <span class="FormLabel">Fecha desde:</span>
        <asp:TextBox data-inline="true" runat="server" ID="txt_fechadesde" ClientIDMode="Static" autocomplete="off"></asp:TextBox>  
    </div>
    <div class="ResponsiveDiv">
        <span class="FormLabel">Fecha hasta:</span>
        <asp:TextBox data-inline="true" runat="server" ID="txt_fechahasta" ClientIDMode="Static" autocomplete="off"></asp:TextBox>
    </div>
    <div class="ResponsiveDiv">
        <span class="FormLabel">Tipo de Factura:</span>
        <asp:DropDownList runat="server" ID="cmb_TipoComprobante">
            <asp:ListItem Text="Todas" Value="0"/>
            <asp:ListItem Text="Factura A" Value="A" />
            <asp:ListItem Text="Factura B" Value="B" />
            <asp:ListItem Text="Factura C" Value="C" />
            <asp:ListItem Text="Factura X" Value="X" />
            <asp:ListItem Text="Presupuesto" Value="P" />
            


        </asp:DropDownList><br />
        <asp:Button runat="server" Text="Buscar Facturas" ID="btnBuscar" CssClass="FormButton FirstElement LastElement" onclick="btnBuscar_Click"/>
        <asp:Button runat="server" Text="Buscar Remitos" ID="btnBuscarRemitos" CssClass="FormButton FirstElement LastElement" onclick="btnBuscarRemitos_Click"/>
    </div>


    <div class="ResponsiveDiv">
        <canvas id="myChart"></canvas>
    </div>

    <div runat="server" id="ListadoFacturas" class="ResponsiveDiv LimitedHeightList">
    </div>
    <div  class="ResponsiveDiv">Total:  <span id="totallistado" runat="server"></span></div>

    <div runat="server" Id="Det" class="ResponsiveDiv LimitedHeightList">
        <div>
        <table style="width:100%">
            <tbody>
                <tr><td>Fecha:</td><td runat="server" id="field_date">[Place Holder Fecha]</td></tr>
                <tr runat="server" id="row_name"><td>Señore/s:</td><td colspan="2" runat="server" id="field_name">[Place Holder Razon Social]</td></tr>
                <tr runat="server" id="row_domi"><td>Domicilio:</td><td colspan="2" runat="server" id="field_domi">[Place Holder Domicilio]</td></tr>
                <tr runat="server" id="telefono"><td>Telefono:</td><td colspan="2" runat="server" id="field_phone">[Place Holder Telefono]</td></tr>
                <tr ><td>Sit. Iva:</td><td runat="server" id="field_iva">[Place Holder IVA]</td><td>Forma de pago:</td><td runat="server" id="field_pay">[Place Holder Pago]</td></tr>
            </tbody>
        </table>
        <table style="width:100%">
            <tbody runat="server" id="Table_detail">
                <tr class="metroheader"><td>Cant.</td><td>Descripcion</td><td>Precio U.</td><td>Total</td></tr>
                
            </tbody>
        </table>
            </div>
        <input type="button" value="imprimir" id="imprimirfactura"  />
    </div>
    <div Id="Div1" class="ResponsiveDiv LimitedHeightList">
        <h3>Estadisticas de ventas por productos</h3>
        </div>
    <div runat="server" Id="ListOfProducts" class="ResponsiveDiv LimitedHeightList">
        
    </div>
    <div Id="Div1" class="ResponsiveDiv LimitedHeightList">
        <h3>Estadisticas de ventas en materias primas</h3>
        </div>
    <div runat="server" Id="ListOfMateriasPrimas" class="ResponsiveDiv LimitedHeightList">
        
    </div>
    <div id="ListOfRetiros" class="ResponsiveDiv LimitedHeightList">
        <h3>Planilla de retiros</h3>
        <table style="width:90%">
            
            <tbody>
                <tr class="metroheader">
           <td>Fecha</td>
           <td>Hora</td>
           <td>Usuario</td>
           <td>Detalle</td>
           <td>Monto</td>
                </tr>
                <%
                    //MODIFICAR RETIROS AQUI -- EN PROGRESO
                    string sessionkey = "SearchFacturas";
                    string sessionkeypagos = "SearchPagos";
                    string sessionkeyretiros = "SearchRetiros";
                    if (Session[sessionkeyretiros] != null)
                    {

                        List<Data2.Class.Struct_Retiro> MisRetiros = Session[sessionkeyretiros] as List<Data2.Class.Struct_Retiro>;
                        bool par = false;
                        decimal totalRetiros = 0M;

                        foreach (Data2.Class.Struct_Retiro R in MisRetiros)
                        {
                            totalRetiros += R.MOnto;
                            if (par == true)
                            {
                                par = false;
                            }
                            else
                            {
                                par = true;
                            }
                            if (par == true)
                            {
                                Response.Write("<tr class='metroparline animationline'>");
                            }
                            else
                            {
                                Response.Write("<tr class='metroimparline animationline'>");
                            }

                            Response.Write("<td>" + R.FEcha.ToShortDateString() + "</td>");
                            Response.Write("<td>" + R.FEcha.ToShortTimeString() + "</td>");
                            if (Data2.Class.Struct_Vendedores.Get_VendedorById(R.IDSeller) != null)
                            {
                                Response.Write("<td>" + Data2.Class.Struct_Vendedores.Get_VendedorById(R.IDSeller).NombreVendedor + "</td>");
                            }
                            else
                            {
                                Response.Write("<td>" + "Vendedor Borrado(" + R.IDSeller + ")" + "</td>");
                            }

                            Response.Write("<td class='descripcionarticulo'>" + R.DEtalle + "</td>");
                            Response.Write("<td class='valuepiedefactura'>" + R.MOnto.ToString("#######0.00") + "</td>");

                            Response.Write("</tr>");
                        }
                        Response.Write("<tr class='colorpiedefactura'><td colspan=3 class='valuepedefactura labelpiedefactura'>Total:<td><td class='valuepiedefactura'>$ " + totalRetiros.ToString("#######0.00")  + "</td></tr>");
                    }

            %>
                </tbody>
         </table>
    </div>
    <div id="ListOfPagos" class="ResponsiveDiv LimitedHeightList">
        <h3>Planilla de pagos</h3>
        <table style="width:90%">
            
            <tbody>
                <tr class="metroheader">
           <td>Fecha</td>
           <td>Hora</td>
           <td>Usuario</td>
           <td>Detalle</td>
           <td>Monto</td>
                </tr>
                <%
                    
                    
                    if (Session[sessionkeypagos] != null)
                    {

                        List<Data2.Class.Struct_Pago> MisPagos = Session[sessionkeypagos] as List<Data2.Class.Struct_Pago>;
                        bool par = false;
                        decimal totalPagos = 0M;

                        foreach (Data2.Class.Struct_Pago P in MisPagos)
                        {
                            totalPagos += P.MOnto;
                            if (par == true)
                            {
                                par = false;
                            }
                            else
                            {
                                par = true;
                            }
                            if (par == true)
                            {
                                Response.Write("<tr class='metroparline animationline'>");
                            }
                            else
                            {
                                Response.Write("<tr class='metroimparline animationline'>");
                            }

                            Response.Write("<td>" + P.FEcha.ToShortDateString() + "</td>");
                            Response.Write("<td>" + P.FEcha.ToShortTimeString() + "</td>");
                            if (Data2.Class.Struct_Vendedores.Get_VendedorById(P.IDSeller) != null)
                            {
                                Response.Write("<td>" + Data2.Class.Struct_Vendedores.Get_VendedorById(P.IDSeller).NombreVendedor + "</td>");
                            }
                            else
                            {
                                Response.Write("<td>" + "Vendedor Borrado(" + P.IDSeller + ")" + "</td>");
                            }

                            Response.Write("<td class='descripcionarticulo'>" + P.DEtalle + "</td>");
                            Response.Write("<td class='valuepiedefactura'>" + P.MOnto.ToString("#######0.00") + "</td>");

                            Response.Write("</tr>");
                        }
                        Response.Write("<tr class='colorpiedefactura'><td colspan=3 class='valuepedefactura labelpiedefactura'>Total:<td><td class='valuepiedefactura'>$ " + totalPagos.ToString("#######0.00")  + "</td></tr>");
                    }

            %>
                </tbody>
         </table>
    </div>
</div>
<asp:HiddenField ID="urlbase" ClientIDMode="Static" runat="server" value=""/>
<asp:HiddenField ID="HF_Data" ClientIDMode="Static" runat="server" Value="" />
<asp:HiddenField ID="HF_DataCant" ClientIDMode="Static" runat="server" />
<asp:HiddenField ID="HF_DataColors" ClientIDMode="Static" runat="server" />
<asp:HiddenField ID="HF_DataTitle" ClientIDMode="Static" runat="server" />
<script>
//estoy probando unos cambios por las dudas
    $('#txt_fechadesde').datepicker({
        dateFormat: 'dd/mm/yy'
    }
        );

    $('#txt_fechahasta').datepicker({
        dateFormat: 'dd/mm/yy'
    }
        );
    
    function ImprimirFactura(IDF)
    {
        window.open("/DesktopModules/ListadoFacturas/FacturaView.aspx?F=" + IDF);
    }

    function OpenC(key,IsRemito)
    {
        if (IsRemito == false) {
            window.location.href = $('#urlbase').val() + "?VC=" + key;
        } else
        {
            window.location.href = $('#urlbase').val() + "?VC=" + key + "&R=1";
        }
    }
    var A_labels = new Array();
    var A_data = new Array();
    var A_colors = new Array();
    var chartinvar = $('#myChart');
    var A_title;

    if ($('#HF_Data').val() == '1')
    {
        GetCants();
        GetColors();
        GetTitle();
        $('html, body').animate({
            scrollTop: $("#myChart").offset().top
        }, 1);
    }

    function GetTitle()
    {
        A_title = $('#HF_DataTitle').val();
    }

    function GetCants()
    {
        var cants = $('#HF_DataCant').val().split(',');
        for (a=0;a<cants.length;a++)
        {
            A_data.push(parseInt(cants[a]));
        }

    }

    function GetColors() {
        var cants = $('#HF_DataColors').val().split(',');
        for (a = 0; a < cants.length; a++) {
            A_colors.push(parseInt(cants[a]));
        }

    }

    
    A_labels.push('Fact. A', 'Fact. B', 'Fact. C', 'Fact. X', 'Presup.', "Remitos");
    


    var data = {
        labels: A_labels,
        datasets: [
            {
                data: A_data,
                backgroundColor: [
                    "#FF6384",
                    "#36A2EB",
                    "#FFCE56",
                    "#FF6384",
                    "#36A2EB",
                    "#FF6384"
                ],
                hoverBackgroundColor: [
                    "#FF6384",
                    "#36A2EB",
                    "#FFCE56",
                    "#FF6384",
                    "#36A2EB",
                    "#FF6384"
                ]
            }]
    };

    var mypiechart = new Chart(chartinvar,
        {
            type: 'horizontalBar',
            labels: ['Fact. A', 'Fact. B', 'Fact. C', 'Fact. X', 'Presup', 'Remitos'],
            data: data,
            animation: {
                animateScale: true
            },
            options:
                {
                    responsive: true,
                    legend:
                        {
                            display:false
                        },
                    title:
                        {
                            display: true,
                            text: A_title
                        },
                    scales:
                        {
                            xAxes:[
                                {
                                    ticks:
                                        {
                                            beginAtZero:true
                                        }
                                }]
                        }
                }
        });

</script>