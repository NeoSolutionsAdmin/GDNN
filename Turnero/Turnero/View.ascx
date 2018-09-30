<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Turnero.View" %>
		<div>
			<button type="button" value="agregar_tratamiento" onclick="AbrirDialogo()">Agregar tratameinto</button>
			<p>	DIA:		<select>
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
                                        
                                        Response.Write("<option value=\"" + a.ToString() + "\" >" + a.ToString() + "</option>");
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
					<th>HORARIO</th>
					<th>LUNES 1/10</th>
					<th>MARTES 2/10</th>
					<th>MIÉRCOLES 3/10</th>
					<th>JUEVES 4/10</th>
					<th>VIERNES 5/10</th>
					<th>SÁBADO 6/10</th>
					<th>DOMINGO 7/10</th>
					<th>SIG</th>
				</tr>		
				<tr>
					<th>0:00</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>			
				<tr>
					<th>0:30</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>			
				<tr>
					<th>1:00</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>			
				<tr>
					<th>1:30</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>			
				<tr>
					<th>2:00</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>			
				<tr>
					<th>2:30</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>		
				<tr>
					<th>3:00</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>			
				<tr>
					<th>3:30</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>			
				<tr>
					<th>4:00</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>			
				<tr>
					<th>4:30</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>			
				<tr>
					<th>5:00</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>			
				<tr>
					<th>5:30</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
				<tr>
					<th>6:00</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
				<tr>
					<th>6:30</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
				<tr>
					<th>7:00</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
				<tr>
					<th>7:30</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
				<tr>
					<th>8:00</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
				<tr>
					<th>8:30</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
				<tr>
					<th>9:00</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
				<tr>
					<th>9:30</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
				<tr>
					<th>10:00</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
				<tr>
					<th>10:30</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
				<tr>
					<th>11:00</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
				<tr>
					<th>11:30</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
				<tr>
					<th>12:00</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
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
