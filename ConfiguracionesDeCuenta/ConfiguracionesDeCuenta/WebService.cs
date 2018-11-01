using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Users;
using DotNetNuke.Web.Api;
using DotNetNuke.Security;
using Data2.Statics;

namespace Christoc.Modules.ConfiguracionesDeCuenta
{

    public class ModuleTaskController : DnnApiController
    {

        [AllowAnonymous]
        [DnnModuleAuthorize(AccessLevel = SecurityAccessLevel.View)]
        [HttpGet]
        public HttpResponseMessage GetPrintConfiguration(string KEY)
        {

            Data2.Connection.D_StaticWebService SWS = new Data2.Connection.D_StaticWebService();
            int IdUser = SWS.GetUserByPrivateKey(KEY);
            if (IdUser != 0)
            {
                Data2.Class.Struct_PrintConfiguration PC = Data2.Class.Struct_PrintConfiguration.GetPrintConfiguration( Conversion.ObtenerLocal(IdUser));
                if (PC != null)
                {
                    return Request.CreateResponse(HttpStatusCode.OK, PC.GetSerializad());
                }
                else {
                    return Request.CreateResponse(HttpStatusCode.OK, "null");
                }
                
            }
            else 
            {
                return Request.CreateResponse(HttpStatusCode.OK, "null");
            }
                
           
            
        }

        [AllowAnonymous]
        [DnnModuleAuthorize(AccessLevel = SecurityAccessLevel.View)]
        [HttpGet]
        public HttpResponseMessage SendPrinterCommand(string KEY, string COMMAND)
        {

            Data2.Connection.D_StaticWebService SWS = new Data2.Connection.D_StaticWebService();
            int IdUser = SWS.GetUserByPrivateKey(KEY);
            if (IdUser != 0)
            {
                Data2.Connection.D_PrinterConfig PC = new Data2.Connection.D_PrinterConfig();
                bool execution = false;
                
                switch (COMMAND.ToUpper())
                {
                    case "PRINTZ":
                        PC.InsertPrintAction(Conversion.ObtenerLocal(IdUser), Data2.PublicsEnum.Enum_Printer.PrintActions.PRINT_Z);
                        execution = true;
                        break;
                    case "PRINTX":
                        PC.InsertPrintAction(Conversion.ObtenerLocal(IdUser), Data2.PublicsEnum.Enum_Printer.PrintActions.PRINT_X);
                        execution = true;
                        break;
                    case "AVANZARPAPEL":
                        PC.InsertPrintAction(Conversion.ObtenerLocal(IdUser), Data2.PublicsEnum.Enum_Printer.PrintActions.PRINT_AVANZAR_PAPEL);
                        execution = true;
                        break;
                    default:
                        execution = false;
                        break;
                }
                if (execution)
                {
                    return Request.CreateResponse(HttpStatusCode.OK, "OK");
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
        [DnnModuleAuthorize(AccessLevel = SecurityAccessLevel.View)]
        [HttpGet]
        public HttpResponseMessage GetPrintAction(string KEY)
        {

            Data2.Connection.D_StaticWebService SWS = new Data2.Connection.D_StaticWebService();
            int IdUser = SWS.GetUserByPrivateKey(KEY);
            if (IdUser != 0)
            {
                Data2.Class.XmlSerializaers.PrinterAction PA = Data2.Class.XmlSerializaers.PrinterAction.GetLastPrinterAction(Conversion.ObtenerLocal(IdUser));
                if (PA != null)
                {
                    return Request.CreateResponse(HttpStatusCode.OK, PA.GetSerializad());
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
        [DnnModuleAuthorize(AccessLevel = SecurityAccessLevel.View)]
        [HttpGet]
        public HttpResponseMessage SendConfirmation(string KEY, int IDCOMMAND)
        {

            Data2.Connection.D_StaticWebService SWS = new Data2.Connection.D_StaticWebService();
            int IdUser = SWS.GetUserByPrivateKey(KEY);
            if (IdUser != 0)
            {
                Data2.Connection.D_PrinterConfig PC = new Data2.Connection.D_PrinterConfig();
                if (PC.ConfirmCommand(Conversion.ObtenerLocal(IdUser), IDCOMMAND))
                {
                    return Request.CreateResponse(HttpStatusCode.OK, "OK");
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