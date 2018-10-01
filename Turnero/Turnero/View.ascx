<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Turnero.View" %>

<div>
	<button type="button" value="agregar_tratamiento" onclick="AbrirDialogo()">Agregar tratameinto</button>
		<p>	DIA: <select>
					<option value="1.10">1/10</option>
					<option value="2.10">2/10</option>
			    	<option value="3.10">3/10</option>
					<option value="4.10">4/10</option>
					<option value="5.10">5/10</option>
					<option value="6.10">6/10</option>
					<option value="7.10">7/10</option>
				</select>
            
			HORARIO: 	<select>
							<%               
                                
                                for (int a = 0; a < 24; a++)
                                {
                                    if (a < 10)
                                    {
                                        Response.Write("<option value=\"" + "0" + a.ToString() + ".00" + "\" >" + "0" + a.ToString() + ".00" + "</option>");
                                        Response.Write("<option value=\"" + "0" + a.ToString() + ".30" + "\" >" + "0" + a.ToString() + ".30" + "</option>");
                                    }
                                    else
                                    {
                                        Response.Write("<option value=\"" + a.ToString() + ".00" + "\" >" + a.ToString() + ".00" + "</option>");
                                        Response.Write("<option value=\"" + a.ToString() + ".30" + "\" >" + a.ToString() + ".30" + "</option>");
                                    }

                                }
                            %>							
						</select> </br>
									  </br>
			CLIENTE:	<button type="button" value="buscar_cliente">BUSCAR</button> </br>
			NOMBRE:		<label for="nombre_cliente">nombre</label></br>
			APELLIDO:	<label for="apellido_cliente">apellido</label>				
		</p>
			
</div>
		
&nbsp
		
<div>
	<table style="width:100%" border=1>
		<tr>
			<th style="text-align: center; width: 75px">HORARIO</th>
            <%
                for (int a = 0; a < 5; a++)
                {
                    Response.Write("<th style=\"text-align: center\">" + DateTime.Now.AddDays(a).ToShortDateString() + "</th>");
                }
                %>
		</tr>
            <%
                for ( int a = 0; a < 24; a++)
                {
                    if (a < 10)
                    {
                        Response.Write(
                        "<tr>" +
                            "<td style=\"text-align: center\">" +
                                "0" + a.ToString() + ".00" +
                            "</td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                        "</tr>" +
                        "<tr>" +
                            "<td style=\"text-align: center\">" +
                                "0" + a.ToString() + ".30" +
                            "</td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                        "</tr>");

                    }
                    else
                    {
                        Response.Write(
                        "<tr>" +
                            "<td style=\"text-align: center\">" +
                                a.ToString() + ".00" +
                            "</td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                        "</tr>" +
                        "<tr>" +
                             "<td style=\"text-align: center\">" +
                                a.ToString() + ".30" +
                            "</td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                            "<td></td>" +
                        "</tr>");

                    }



                }
                %>
	</table>
</div>
	
	<div id="busqueda_cliente" style="background-color: lightblue">
		<p>Hola sosoja</p>
	</div> 
        
        <script>
		
		    function AbrirDialogo()
		    {
			    $("#busqueda_cliente").dialog("open");
		    }
		
		    $(function()
		    {
			    $( "#busqueda_cliente" ).dialog(
			    	{
				    	autoOpen: false
				    }
			    );
		    });
		
		</script>
