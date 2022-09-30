using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Lib_LN_Factura;

namespace App_Factura
{
    public partial class PR_Registro : Form
    {
        public PR_Registro()
        {
            InitializeComponent();
        }

        /// //////////////////////////

        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static IntPtr SendMessage(IntPtr hWnd, int wmsg, int wparam, int lParam);

        //////////////////////////////


        #region ICON VER CONTRASEÑA
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

        private void iconVer2_Click(object sender, EventArgs e)
        {
            IconNoVer2.BringToFront();
            txtConfirmContraseña.UseSystemPasswordChar = false;
        }

        private void IconNoVer2_Click(object sender, EventArgs e)
        {
            iconVer2.BringToFront();
            txtConfirmContraseña.UseSystemPasswordChar = true;
        }

        #endregion

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
            if (txtContraseña.Text != txtConfirmContraseña.Text)
            {
                MessageBox.Show("La contraseña no coincide.");
                return;
            }
                
            LN_Factura objProveedor = new LN_Factura();
            // declarar variables
            string nit, nombre, web, direccion, telefono, descripcion, correo, contraseña;
            try
            {
                //capturar variables
                nit = txtNit.Text;
                nombre = txtNombre.Text;
                web = txtPaginaWeb.Text;
                direccion = txtDireccion.Text;
                telefono = txtTelefono.Text;
                descripcion = txtDescripcion.Text;
                correo = txtCorreo.Text;
                contraseña = txtContraseña.Text;

                //Enviar valores al LN
                objProveedor.NitProveedor = nit;
                objProveedor.Nom_PR = nombre;
                objProveedor.Pagina_web_PR = web;
                objProveedor.Direccion_PR = direccion;
                objProveedor.Telefono = telefono;
                objProveedor.Descript_PR = descripcion;
                objProveedor.Correo_PR = correo;
                objProveedor.Contraseña_PR = contraseña;

                if (!objProveedor.USP_Registro_Proveedor())
                {
                    MessageBox.Show(objProveedor.Error);
                    objProveedor = null;
                    return;
                }
                else
                {
                    Login Vent_login = new Login();
                    Vent_login.Show();
                    this.Hide();
                    MessageBox.Show(objProveedor.Error);
                    objProveedor = null;
                    return;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                objProveedor = null;
            }
        }

        private void panel1_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(this.Handle, 0x112, 0xf012, 0);
        }

        #region DISEÑO TEXTBOX
        //Enter
        private void txtNit_Enter(object sender, EventArgs e)
        {
            if (txtNit.Text == "NIT")
            {
                txtNit.Text = "";
                txtNit.ForeColor = Color.LightGray;

            }
        }
        private void txtNombre_Enter(object sender, EventArgs e)
        {
            if (txtNombre.Text == "NOMBRE COMPLETO")
            {
                txtNombre.Text = "";
                txtNombre.ForeColor = Color.LightGray;
            }
        }
        private void txtPaginaWeb_Enter(object sender, EventArgs e)
        {
            if (txtPaginaWeb.Text == "PAGINA WEB (OPCIONAL)")
            {
                txtPaginaWeb.Text = "";
                txtPaginaWeb.ForeColor = Color.LightGray;
            }
        }
        private void txtDireccion_Enter(object sender, EventArgs e)
        {
            if (txtDireccion.Text == "DIRECCION NEGOCIO")
            {
                txtDireccion.Text = "";
                txtDireccion.ForeColor = Color.LightGray;
            }
        }
        private void txtTelefono_Enter(object sender, EventArgs e)
        {
            if (txtTelefono.Text == "TELEFONO")
            {
                txtTelefono.Text = "";
                txtTelefono.ForeColor = Color.LightGray;
            }
        }
        private void txtDescripcion_Enter(object sender, EventArgs e)
        {
            if (txtDescripcion.Text == "DESCRIPCION DE NEGOCIO")
            {
                txtDescripcion.Text = "";
                txtDescripcion.ForeColor = Color.LightGray;
            }
        }
        private void txtCorreo_Enter(object sender, EventArgs e)
        {
            if (txtCorreo.Text == "CORREO ELECTRONICO")
            {
                txtCorreo.Text = "";
                txtCorreo.ForeColor = Color.LightGray;
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
        private void txtConfirmContraseña_Enter(object sender, EventArgs e)
        {
            if (txtConfirmContraseña.Text == "CONFIRMAR CONTRASEÑA")
            {
                txtConfirmContraseña.Text = "";
                txtConfirmContraseña.ForeColor = Color.LightGray;
                txtConfirmContraseña.UseSystemPasswordChar = true;
            }
        }

        //LEAVE
        private void txtNit_Leave(object sender, EventArgs e)
        {
            if (txtNit.Text == "")
            {
                txtNit.Text = "NIT";
                txtNit.ForeColor = Color.DimGray;
            }
        }
        private void txtNombre_Leave(object sender, EventArgs e)
        {
            if (txtNombre.Text == "")
            {
                txtNombre.Text = "NOMBRE COMPLETO";
                txtNombre.ForeColor = Color.DimGray;
            }
        }
        private void txtPaginaWeb_Leave(object sender, EventArgs e)
        {
            if (txtPaginaWeb.Text == "")
            {
                txtPaginaWeb.Text = "PAGINA WEB (OPCIONAL)";
                txtPaginaWeb.ForeColor = Color.DimGray;
            }
        }
        private void txtDireccion_Leave(object sender, EventArgs e)
        {
            if (txtDireccion.Text == "")
            {
                txtDireccion.Text = "DIRECCION NEGOCIO";
                txtDireccion.ForeColor = Color.DimGray;
            }
        }
        private void txtTelefono_Leave(object sender, EventArgs e)
        {
            if (txtTelefono.Text == "")
            {
                txtTelefono.Text = "TELEFONO";
                txtTelefono.ForeColor = Color.DimGray;
            }
        }
        private void txtDescripcion_Leave(object sender, EventArgs e)
        {
            if (txtDescripcion.Text == "")
            {
                txtDescripcion.Text = "DESCRIPCION DE NEGOCIO";
                txtDescripcion.ForeColor = Color.DimGray;
            }
        }
        private void txtCorreo_Leave(object sender, EventArgs e)
        {
            if (txtCorreo.Text == "")
            {
                txtCorreo.Text = "CORREO ELECTRONICO";
                txtCorreo.ForeColor = Color.DimGray;
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
        private void txtConfirmContraseña_Leave(object sender, EventArgs e)
        {
            if (txtConfirmContraseña.Text == "")
            {
                txtConfirmContraseña.Text = "CONFIRMAR CONTRASEÑA";
                txtConfirmContraseña.ForeColor = Color.DimGray;
                txtConfirmContraseña.UseSystemPasswordChar = false;
            }
        }


        #endregion


    }
}
