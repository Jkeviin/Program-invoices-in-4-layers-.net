using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using Lib_LN_Factura;
using System.Data.SqlClient;


namespace App_Factura
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        // tamaño ventana
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static IntPtr SendMessage(IntPtr hWnd, int wmsg, int wparam, int lParam);


        #region diseño Texbox
        private void txtCorreo_Enter(object sender, EventArgs e)
        {
            if (txtCorreo.Text == "CORREO")
            {
                txtCorreo.Text = "";
                txtCorreo.ForeColor = Color.LightGray;

            }
        }

        private void txtCorreo_Leave(object sender, EventArgs e)
        {
            if (txtCorreo.Text == "")
            {
                txtCorreo.Text = "CORREO";
                txtCorreo.ForeColor = Color.DimGray;
            }
        }

        private void txtContraseña_Enter(object sender, EventArgs e)
        {
            if (txtContraseña.Text == "CONTRASEÑA")
            {
                txtContraseña.Text = "";
                txtContraseña.ForeColor = Color.LightGray;
                txtContraseña.UseSystemPasswordChar = true;
            }
        }

        private void txtContraseña_Leave(object sender, EventArgs e)
        {
            if (txtContraseña.Text == "")
            {
                txtContraseña.Text = "CONTRASEÑA";
                txtContraseña.ForeColor = Color.DimGray;
                txtContraseña.UseSystemPasswordChar = false;
            }
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
        #endregion


        #region Botones ventana
        private void btnCerrar_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void btnMinimizar_Click(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Minimized;
        }

        private void Login_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(this.Handle, 0x112, 0xf012, 0);
        }
        #endregion


        private void btnLogin_Click(object sender, EventArgs e)
        {
            // CERRAR
            LN_Factura objProveedor = new LN_Factura();
            // declarar variables
            string correo, contraseña;
            SqlDataReader reader;
            // leer
            try
            {
                //capturar variables
                correo = txtCorreo.Text;
                contraseña = txtContraseña.Text;

                //Enviar valores al LN
                objProveedor.Correo_PR = correo;
                objProveedor.Contraseña_PR = contraseña;

                if (!objProveedor.USP_inicio_sesion_Proveedor())
                {
                    MessageBox.Show(objProveedor.Error);
                    objProveedor = null;
                    return;
                }
                reader = objProveedor.Reader;

                if (reader.HasRows)
                {
                    PR_DashBoard fr = new PR_DashBoard();
                    fr.Show();
                    this.Hide();

                    reader.Read();
                    fr.Nit = reader.GetString(0);
                    fr.Nombre = reader.GetString(1);
                    fr.lblNombre.Text = reader.GetString(1);
                    fr.Descripcion = reader.GetString(2);
                    fr.Direccion = reader.GetString(3);
                    fr.Correo = reader.GetString(4);
                    fr.Web = reader.GetString(6);
                    reader.Close();
                    fr = null;
                    return;
                }
                txtCorreo.Text = "";
                txtContraseña.Text = "";
                txtError.Visible = true;
                txtError.Text = "           Correo o contraseña incorrecta";
                objProveedor = null;
                return;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                objProveedor = null;
            }
        }

        private void linkCrearCuenta_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
           PR_Registro registro = new PR_Registro();
            registro.Show();
            this.Hide();
            registro = null;
        }
    }
}
