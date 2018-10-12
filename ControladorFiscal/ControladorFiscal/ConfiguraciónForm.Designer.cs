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
            this.CancelarButton = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.IntervaloTrackbar)).BeginInit();
            this.SuspendLayout();
            // 
            // IntervaloTrackbar
            // 
            this.IntervaloTrackbar.Location = new System.Drawing.Point(12, 55);
            this.IntervaloTrackbar.Maximum = 60;
            this.IntervaloTrackbar.Minimum = 5;
            this.IntervaloTrackbar.Name = "IntervaloTrackbar";
            this.IntervaloTrackbar.Size = new System.Drawing.Size(229, 45);
            this.IntervaloTrackbar.SmallChange = 5;
            this.IntervaloTrackbar.TabIndex = 0;
            this.IntervaloTrackbar.TabStop = false;
            this.IntervaloTrackbar.TickFrequency = 5;
            this.IntervaloTrackbar.Value = 60;
            this.IntervaloTrackbar.Scroll += new System.EventHandler(this.IntervaloTrackbar_Scroll);
            // 
            // GuardarButton
            // 
            this.GuardarButton.Location = new System.Drawing.Point(12, 106);
            this.GuardarButton.Name = "GuardarButton";
            this.GuardarButton.Size = new System.Drawing.Size(75, 23);
            this.GuardarButton.TabIndex = 1;
            this.GuardarButton.Text = "Guardar";
            this.GuardarButton.UseVisualStyleBackColor = true;
            // 
            // CancelarButton
            // 
            this.CancelarButton.Location = new System.Drawing.Point(167, 106);
            this.CancelarButton.Name = "CancelarButton";
            this.CancelarButton.Size = new System.Drawing.Size(75, 23);
            this.CancelarButton.TabIndex = 2;
            this.CancelarButton.Text = "Cancelar";
            this.CancelarButton.UseVisualStyleBackColor = true;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(13, 23);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(166, 13);
            this.label1.TabIndex = 3;
            this.label1.Text = "Buscar facturas pendientes cada:";
            // 
            // ConfiguraciónForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(258, 141);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.CancelarButton);
            this.Controls.Add(this.GuardarButton);
            this.Controls.Add(this.IntervaloTrackbar);
            this.Name = "ConfiguraciónForm";
            this.Text = "Configuración";
            ((System.ComponentModel.ISupportInitialize)(this.IntervaloTrackbar)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TrackBar IntervaloTrackbar;
        private System.Windows.Forms.Button GuardarButton;
        private System.Windows.Forms.Button CancelarButton;
        private System.Windows.Forms.Label label1;
    }
}