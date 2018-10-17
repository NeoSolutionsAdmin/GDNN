using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ControladorFiscal
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        //Inicializar app
        private void Form1_Load(object sender, EventArgs e)
        {
            NotifyIcon1.Icon = SystemIcons.Application;
            NotifyIcon1.BalloonTipText = "Controlador Fiscal";
            NotifyIcon1.ContextMenuStrip = MenuAplicacion;
            //inicializar timer
            actualizarTimer();

        }

        //Menú de la app

        //Opciones
        private void opcionesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ConfiguraciónForm form = new ConfiguraciónForm(BuscarFacturasTimer);
            form.Show();
                    //ahi envias el timer como parametro en el constructor y lo usas del otro lado
            

        }
        //Salir
        private void salirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }


        //Actualizar el timer de búsqueda de facturas.
        public void actualizarTimer()
        {
            BuscarFacturasTimer.Interval = (Properties.Settings.Default.Intervalo * 1000);
            BuscarFacturasTimer.Enabled = true;
        }

        //Cuando se cumpla el tiempo, buscar e imprimir facturas pendientes
        private void BuscarFacturasTimer_Tick(object sender, EventArgs e) 
        {
            
            //Bloque de comentarios de referencia
            
            //Esto te tira un listado de facturas A de ese usuario o negocio
            //Lo mismo para las B? si
            //Iteras el listado... a la ultima la imprimis... no hace falta ir
            //List<Data2.Class.Struct_Factura> MisFacturas = Data2.Class.Struct_Factura.GetFacturasBetweenDates(DateTime.Now.AddDays(-1), DateTime.Now.AddDays(1),/*este id de usuario lo levantas de un parametro*/, false, Data2.Class.Struct_Factura.TipoDeFactura.FacturaB);
            //tenias ahi un bool impresa, fueimpresa, algo asi
            //son propiedades, no mnetodos, yo necesito un metodo que la marque en la base de datos..
            //para ver si entendi bien
            //1) armar un listado de todas las facturas entre ayer y mañana
            //2) de esas facturas, buscar las que ! han sido impresas
            //3) profit?
            //las que no fueron impresas e imprimirlas
            //Si el ! significa not
            //jajajajajaja eso...
            //por ahora arma la base para que envie la ultima factura de ese listad
            //oka
            //y como saco de esa factura los items?
            //MisFacturas[MisFacturas.Count-1].GetDetalle()[0].PRODUCTO.Descripcion etc etc etc //esto te tira un list de DetalleFactura, te diste cuenta?
            // y como saco si la factura tiene mas de un item? hay un indice?
            //List<Data2.Class.Struct_DetalleFactura> ElDetalle;
            //for (int a = 0; a < ElDetalle.Count; a++)
            //{
            //    lineatexto =  ElDetalle[a].PRODUCTO.Descripcion; ???
            //        //vas construyendo la linea de comando en base a las propiedades del detalle
            //ElDetalle[a].getPrecioFinalSinIva
            //ElDetalle[a].getTotalSinIva
            //concatenas todo 
            //ya
            //otra cosa tenes datos de ejemplo en la base de datos para que lo pruebe?
            //que id de usuario necesito?
            //abri sql
            //MessageBox.Show("Buscar Facturas");

            //Código

            //Declarar e inicializar variables
            int id_usuario = Properties.Settings.Default.Id_Usuario;
            string lineatexto;
            string ContenidoTxtIxbatch;
            string AbreFacturaIxbatch;
            string CierraFacturaIxbatch;
            string NombreCliente ="";
            string CUITCliente = "";
            string DireccionCliente = "";

            List<string> ItemsFacturaIxbatch = new List<string>();
            List<string> PrecioItemsFacturaIxbatch = new List<string>();

            List<Data2.Class.Struct_Factura> FacturasRecuperadas = Data2.Class.Struct_Factura.GetFacturasBetweenDates(DateTime.Now.AddDays(-100), DateTime.Now.AddDays(100), id_usuario, false, Data2.Class.Struct_Factura.TipoDeFactura.FacturaB);
            
            //TODO Chequear por Null (sin registros)
            //En caso que FacturasRecuperadas sea null, significa que no hay registros... tira error aca
            List<Data2.Class.Struct_DetalleFactura> DetalleDeFactura = /*aca*/FacturasRecuperadas[FacturasRecuperadas.Count - 1].GetDetalle();

            //1) armar listado de facturas entre ayer y mañana
            //de ese listado, recuperar la ultima factura y poner sus detalles en una lista

            //TODO:           
            //2) comprobar cuales de esas no han sido impresas (pendiente funcionalidad de db a implementar mañana o el lunes o cuando se pueda)

            //3) POR AHORA imprimir la última

            //4) Parsear esa factura recorriendo item por item y armar un string gigante con comandos de ixbatch

            //recorrer la factura, agregar los detalles de factura a listas
            for (int a = 0; a < DetalleDeFactura.Count; a++)
            {
            if (DetalleDeFactura[a].PRODUCTO != null)
            {

                    //TODO: Limitar Descripcion y Domicilio a 25 caracteres

                    ItemsFacturaIxbatch.Add(DetalleDeFactura[a].PRODUCTO.Descripcion);
                    PrecioItemsFacturaIxbatch.Add(DetalleDeFactura[a].PRODUCTO.PrecioFinal.ToString());
                    NombreCliente = FacturasRecuperadas[FacturasRecuperadas.Count - 1].senores;
                    CUITCliente = FacturasRecuperadas[FacturasRecuperadas.Count - 1].cuit;
                    DireccionCliente = FacturasRecuperadas[FacturasRecuperadas.Count - 1].domicilio;
                }

            

            //armar encabezado proba sacando los espacios

            AbreFacturaIxbatch = "@FACTABRE|T|C|B|1|P|10|E|I|" +NombreCliente+ "||CUIT|"+ CUITCliente + "|N|" + DireccionCliente+ "||| C";
            //agregar encabezado a factura
            ContenidoTxtIxbatch = AbreFacturaIxbatch;

                //armar y agregar items a factura
                //Recorrer los items
                for (int i = 0; i < ItemsFacturaIxbatch.Count; i++)
                {
                    //TODO limitar a 20 caracteres por item

                    //armar una linea usando descripcion de items, precio, etc
                    lineatexto = "@FACTITEM|" + ItemsFacturaIxbatch[i] + "|1|" + PrecioItemsFacturaIxbatch[i] + "|21.00|M|1|0||||0|0";
                    //agregar esa linea al string que luego se guarda como txt y se pasa a ixbatch
                    ContenidoTxtIxbatch = ContenidoTxtIxbatch + Environment.NewLine + lineatexto;
                }

             //armar cierre de factura
             CierraFacturaIxbatch = "@FACTCIERRA|T|C|FINAL";
             //agregar cierre de factura
             ContenidoTxtIxbatch = ContenidoTxtIxbatch + Environment.NewLine + CierraFacturaIxbatch;


            //5) guardar el string gigante contenidotxtixbatch en un txt

            //guardar la factura de ejemplo
            System.IO.File.WriteAllText(Application.StartupPath + "\\ixbatch.txt", ContenidoTxtIxbatch);

            
            //6) llamar a ixbatch y pasarle el txt

            //MessageBox.Show("Mandando a IxBatch");

            try
            {
                System.Diagnostics.Process pProcess = new System.Diagnostics.Process();
                pProcess.StartInfo.FileName = Application.StartupPath + "\\ixbatchw.exe";

               //TODO hacer que los argumentos salgan de la configuracion en vez de ser hard codeados
                pProcess.StartInfo.Arguments = "-p COM7 -i ixbatch.txt -o salida.txt -s 9600 "; //argument

                pProcess.StartInfo.UseShellExecute = false;
                pProcess.StartInfo.RedirectStandardOutput = true;
                pProcess.StartInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                pProcess.StartInfo.CreateNoWindow = true; //not diplay a windows
                pProcess.Start();
                string output = pProcess.StandardOutput.ReadToEnd(); //The output result
                pProcess.WaitForExit();
            }
            catch (Exception E)
            {
                MessageBox.Show(E.Message); 
            }

            //7) resetear la bandera de facturas pendientes


        }




    }

    }
}


