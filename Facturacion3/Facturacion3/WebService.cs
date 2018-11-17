using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Http;
using System.Web.Http;

using DotNetNuke.Web.Api;

using System.Web.Script.Serialization;
using Data2.Statics;


namespace Christoc.Modules.Facturacion3
{

    public class ModuleTaskController : DnnApiController
    {

        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage GetTargeta(int idtargeta)
        {

            JavaScriptSerializer S = new JavaScriptSerializer();
            Data2.Class.Struct_Tarjeta t = Data2.Class.Struct_Tarjeta.GetTarjetaById(idtargeta);
            if (t != null)
            {
                return Request.CreateResponse(HttpStatusCode.OK, S.Serialize(t));
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.NoContent, "No hay contenido");
            }
        }

        
        [AllowAnonymous]
        [HttpGet]
        public HttpResponseMessage Login(int iduser,string user, string pass)
        {
            int isok = Data2.Class.Struct_Vendedores.loginseller(Conversion.ObtenerLocal(iduser), user, pass);
            if (isok > 0)
            {
                return Request.CreateResponse(HttpStatusCode.OK, isok.ToString());
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.OK, "-1");
            }
        }

        [AllowAnonymous]
        [HttpGet]

        

        //Search Article
        public HttpResponseMessage SA(string K, string ss, string sc, string ip="-1")
        {


            Data2.Connection.D_Articles.SearchCondition SC = Data2.Connection.D_Articles.SearchCondition.PorDescripcion;

            if (sc == "ci") SC = Data2.Connection.D_Articles.SearchCondition.PorCodigoInterno;
            if (sc == "cb") SC = Data2.Connection.D_Articles.SearchCondition.PorCodigoBarra;
            if (sc == "de") SC = Data2.Connection.D_Articles.SearchCondition.PorDescripcion;

            int IdProvider = -1;
            try
            {
                IdProvider = int.Parse(ip);
            }
            catch { IdProvider = -1; }

            Data2.Connection.D_StaticWebService SWS = new Data2.Connection.D_StaticWebService();
            int IdUser = Data2.Statics.Conversion.ObtenerLocal(int.Parse(K));

            if (ss != null)
            {

                List<Data2.Class.Struct_Producto> _List = Data2.Class.Struct_Producto.SearchProducto(IdUser, ss, SC,IdProvider);

                if (_List != null && _List.Count>0)
                {
                    try
                    {

                        JavaScriptSerializer JSS = new JavaScriptSerializer();
                        JSS.MaxJsonLength = Int32.MaxValue;
                        string result = JSS.Serialize(_List);
                        return Request.CreateResponse(HttpStatusCode.OK, result);
                    }
                    catch (Exception E) 
                    {
                        Data2.Statics.Log.ADD(E.Message, null);
                        return Request.CreateResponse(HttpStatusCode.OK, "null");
                    }

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.OK, "null");
                }

            }
            else 
            {
                return Request.CreateResponse(HttpStatusCode.OK, "null");
            }
            

           
        }


        [AllowAnonymous]
        [HttpGet]
        //Search Treatment
        public HttpResponseMessage ST(string K, string ss)
        {

            Data2.Connection.D_StaticWebService SWS = new Data2.Connection.D_StaticWebService();
            int IdUser = Data2.Statics.Conversion.ObtenerLocal(int.Parse(K));


            if (ss != null)
            {

                List<Data2.Class.Struct_Treatment> _List = Data2.Class.Struct_Treatment.SearchTreatment(IdUser, ss);
                
                if (_List != null && _List.Count > 0)
                {
                    try
                    {

                        JavaScriptSerializer JSS = new JavaScriptSerializer();
                        JSS.MaxJsonLength = Int32.MaxValue;
                        string result = JSS.Serialize(_List);
                        return Request.CreateResponse(HttpStatusCode.OK, result);
                    }
                    catch (Exception E)
                    {
                        Data2.Statics.Log.ADD(E.Message, null);
                        return Request.CreateResponse(HttpStatusCode.OK, "null");
                    }

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.OK, "null");
                }

            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.OK, "null");
            }



        }
    }

}