namespace ControladorFiscal
{
    partial class ConfiguraciónForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.IntervaloTrackbar = new System.Windows.Forms.TrackBar();
            this.GuardarButton = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.IdUsuarioTextBox = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.PuertoComboBox = new System.Windows.Forms.ComboBox();
            this.VelocidadComboBox = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.IntervaloTrackbar)).BeginInit();
            this.SuspendLayout();
            // 
            // IntervaloTrackbar
            // 
            this.IntervaloTrackbar.Location = new System.Drawing.Point(12, 25);
            this.IntervaloTrackbar.Maximum = 60;
            this.IntervaloTrackbar.Minimum = 5;
            this.IntervaloTrackbar.Name = "IntervaloTrackbar";
            this.IntervaloTrackbar.Size = new System.Drawing.Size(225, 45);
            this.IntervaloTrackbar.SmallChange = 5;
            this.IntervaloTrackbar.TabIndex = 0;
            this.IntervaloTrackbar.TabStop = false;
            this.IntervaloTrackbar.TickFrequency = 5;
            this.IntervaloTrackbar.Value = 60;
            this.IntervaloTrackbar.Scroll += new System.EventHandler(this.IntervaloTrackbar_Scroll);
            // 
            // GuardarButton
            // 
            this.GuardarButton.Location = new System.Drawing.Point(12, 205);
            this.GuardarButton.Name = "GuardarButton";
            this.GuardarButton.Size = new System.Drawing.Size(225, 23);
            this.GuardarButton.TabIndex = 1;
            this.GuardarButton.Text = "Guardar";
            this.GuardarButton.UseVisualStyleBackColor = true;
            this.GuardarButton.Click += new System.EventHandler(this.GuardarButton_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(9, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(230, 13);
            this.label1.TabIndex = 3;
            this.label1.Text = "Buscar facturas pendientes cada: 60 segundos";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(9, 57);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(68, 13);
            this.label2.TabIndex = 4;
            this.label2.Text = "Id de usuario";
            // 
            // IdUsuarioTextBox
            // 
            this.IdUsuarioTextBox.Location = new System.Drawing.Point(12, 76);
            this.IdUsuarioTextBox.Name = "IdUsuarioTextBox";
            this.IdUsuarioTextBox.Size = new System.Drawing.Size(225, 20);
            this.IdUsuarioTextBox.TabIndex = 5;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(12, 103);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(38, 13);
            this.label3.TabIndex = 6;
            this.label3.Text = "Puerto";
            // 
            // PuertoComboBox
            // 
            this.PuertoComboBox.FormattingEnabled = true;
            this.PuertoComboBox.Items.AddRange(new object[] {
            "COM1",
            "COM2"});
            this.PuertoComboBox.Location = new System.Drawing.Point(12, 120);
            this.PuertoComboBox.Name = "PuertoComboBox";
            this.PuertoComboBox.Size = new System.Drawing.Size(225, 21);
            this.PuertoComboBox.TabIndex = 7;
            // 
            // VelocidadComboBox
            // 
            this.VelocidadComboBox.FormattingEnabled = true;
            this.VelocidadComboBox.Items.AddRange(new object[] {
            "9600",
            "19200",
            "38400"});
            this.VelocidadComboBox.Location = new System.Drawing.Point(12, 164);
            this.VelocidadComboBox.Name = "VelocidadComboBox";
            this.VelocidadComboBox.Size = new System.Drawing.Size(225, 21);
            this.VelocidadComboBox.TabIndex = 8;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(12, 148);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(79, 13);
            this.label4.TabIndex = 9;
            this.label4.Text = "Velocidad (b/s)";
            // 
            // ConfiguraciónForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(249, 245);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.VelocidadComboBox);
            this.Controls.Add(this.PuertoComboBox);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.IdUsuarioTextBox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.GuardarButton);
            this.Controls.Add(this.IntervaloTrackbar);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "ConfiguraciónForm";
            this.Text = "Configuración";
            this.Load += new System.EventHandler(this.ConfiguraciónForm_Load);
            ((System.ComponentModel.ISupportInitialize)(this.IntervaloTrackbar)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TrackBar IntervaloTrackbar;
        private System.Windows.Forms.Button GuardarButton;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox IdUsuarioTextBox;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.ComboBox PuertoComboBox;
        private System.Windows.Forms.ComboBox VelocidadComboBox;
        private System.Windows.Forms.Label label4;
    }
}