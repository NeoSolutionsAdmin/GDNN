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
    public partial class ConfiguraciónForm : Form
    {
        public Timer TimerGlobal;
        public ConfiguraciónForm(Timer MiTimer)
        {
            TimerGlobal = MiTimer;
            InitializeComponent();
        }

        //cuando cambia el trackbar de posicion, ajustar la descripcion
        private void IntervaloTrackbar_Scroll(object sender, EventArgs e)
        {
            ActualizarLabel1();
        }

        //al cancelar, salir sin guardar
        private void CancelarButton_Click(object sender, EventArgs e)
        {
            ActiveForm.Hide();
        }

        //al guardar, guardar opciones de configuración y cerrar el form
        private void GuardarButton_Click(object sender, EventArgs e)
        {
            //convertir los parámetros al tipo de variable adecuado, y pasarlos a la tabla de configuracion
            Properties.Settings.Default.Intervalo = IntervaloTrackbar.Value;
            Properties.Settings.Default.Id_Usuario = Convert.ToInt32(IdUsuarioTextBox.Text);
            Properties.Settings.Default.Puerto = PuertoComboBox.Text;
            Properties.Settings.Default.Velocidad = Convert.ToInt32(VelocidadComboBox.Text);

            //guardar las configuraciones para uso futuro
            Properties.Settings.Default.Save();

            //actualizar timer en form1
            TimerGlobal.Interval = (Properties.Settings.Default.Intervalo * 1000);

            //cerrar configuracion form
            ActiveForm.Hide();
        }

        //al cargar el form, inicializar con las preferencias del user
        private void ConfiguraciónForm_Load(object sender, EventArgs e)
        {
            //levantar configuraciones de la tabla de configuracion
            IntervaloTrackbar.Value = Properties.Settings.Default.Intervalo;
            IdUsuarioTextBox.Text = Convert.ToString(Properties.Settings.Default.Id_Usuario);
            PuertoComboBox.Text = Properties.Settings.Default.Puerto;
            VelocidadComboBox.Text = Convert.ToString(Properties.Settings.Default.Velocidad);

            //actualiar el label del trackbar con el intervalo correcto de segundos
            ActualizarLabel1();
 

        }

        //actualizar el valor de label1 (valor del tracker) cuando se requiera (al cambiar un valor y al cargar el form, basicamente)
        private void ActualizarLabel1()
        {
            label1.Text = "Buscar facturas pendientes cada: " + IntervaloTrackbar.Value.ToString() + " segundos.";
        }
    }
}
