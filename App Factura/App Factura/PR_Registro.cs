using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace App_Factura
{
    public partial class Registro : Form
    {
        public Registro()
        {
            InitializeComponent();
        }

        private void iconVer_Click(object sender, EventArgs e)
        {
            iconNoVer.BringToFront();
            txtContraseña.UseSystemPasswordChar = false;
        }

        private void iconNoVer_Click(object sender, EventArgs e)
        {
            iconVer.BringToFront();
            txtContraseña.UseSystemPasswordChar = true;
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void btnMinimizar_Click(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Minimized;
        }

        private void btnRegistrar_Click(object sender, EventArgs e)
        {
            Login Vent_login = new Login();
            Vent_login.Show();
            this.Hide();
        }
    }
}
