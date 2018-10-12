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

        private void Form1_Load(object sender, EventArgs e)
        {
            NotifyIcon1.Icon = SystemIcons.Application;
            NotifyIcon1.BalloonTipText = "Controlador Fiscal";
            NotifyIcon1.ContextMenuStrip = MenuAplicacion;
            //inicializar timer
            actualizarTimer();

        }

        private void salirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();

        }

        private void opcionesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ConfiguraciónForm form = new ConfiguraciónForm(BuscarFacturasTimer);
            form.Show();
                    //ahi envias el timer como parametro en el constructor y lo usas del otro lado
            

        }
        public void actualizarTimer()
        {
            BuscarFacturasTimer.Interval = (Properties.Settings.Default.Intervalo * 1000);
            BuscarFacturasTimer.Enabled = true;
        }

        public void levantarDeFactura() 

        {
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

            MessageBox.Show("Buscar Facturas");

        }

        private void BuscarFacturasTimer_Tick(object sender, EventArgs e)
        {
            levantarDeFactura();
        }
    }
}

