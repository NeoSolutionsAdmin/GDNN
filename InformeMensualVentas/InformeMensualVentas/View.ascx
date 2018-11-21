<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.InformeMensualVentas.View" %>


<div>

    <table>
        <tbody>
            <tr>
                <th>Nombre</th>
                <th>Cantidad</th>
            </tr>
                    <%
                        List<Data2.Class.Struct_Treatment> ST = new List<Data2.Class.Struct_Treatment>();

                        if (Session["SF"] != null)
                        {
                            List<Data2.Class.Struct_Factura> LSF = Session["SF"] as List<Data2.Class.Struct_Factura>;

                            for (int a =0; a < LSF.Count; a++)
                            {

                                List<Data2.Class.Struct_DetalleFactura> DF = LSF[a].GetDetalle();
                                if (DF != null)
                                {
                                    for(int i = 0; i < DF.Count;i++)
                                    {
                                        if (DF[i].TRATAMIENTO != null)
                                        {
                                            ST.Add(DF[i].TRATAMIENTO);
                                        }

                                    }
                                }

                            }

                            if (ST.Count > 0)
                            {
                                List<Data2.Class.TratamientoCantidad> TC = new List<Data2.Class.TratamientoCantidad>();



                                for (int x = 0; x < ST.Count; x++)
                                {
                                    bool hayconcidencia = false;
                                    for (int y = 0; y < TC.Count; y++)
                                    {
                                        if (TC[y].Tratamientos.Id == ST[x].Id)
                                        {
                                            TC[y].cantidad++;
                                            hayconcidencia = true;
                                            break;
                                        }

                                    }
                                    if (hayconcidencia == false)
                                    {
                                        Data2.Class.TratamientoCantidad TratamientoSolo = new Data2.Class.TratamientoCantidad();
                                        TratamientoSolo.cantidad = 1;
                                        TratamientoSolo.Tratamientos = ST[x];
                                        TC.Add(TratamientoSolo);
                                    }
                                }

                                if (TC.Count > 0)
                                {
                                    for (int z = 0; z < TC.Count; z++)
                                    {
                                        Response.Write("<tr><td>" + TC[z].Tratamientos.Nombre + "</td><td>" + TC[z].cantidad.ToString() + "</td></tr>");
                                    }
                                    
                                }

                            }

                        }






        %>
        </tbody>
    </table>

    


</div>