using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Lib_LN_Factura;

namespace App_Factura
{
    public partial class PR_Ajustes : Form
    {
        public PR_Ajustes()
        {
            InitializeComponent();
        }

        private void btnActualizar_Click(object sender, EventArgs e)
        {
            LN_Factura objProveedor = new LN_Factura();

            // definir variables 
            string nitprovedor, nombre_PR, descrip_PR, direccion_PR, correo_PR, contraseña_PR, pagina_PR, confirmarContraseña_PR;

            try
            {
                // capturar los datos del formulario


                nitprovedor = txtNit.Text;
                nombre_PR = txtNombre.Text;
                descrip_PR = txtDescripcion.Text;
                direccion_PR = txtDireccion.Text;
                correo_PR = txtCorreo.Text;
                pagina_PR = txtPaginaWeb.Text;
                contraseña_PR = txtContraseña.Text;
                confirmarContraseña_PR = txtConfirmarContraseña.Text;

                // verificar contraseñas

                if (contraseña_PR != confirmarContraseña_PR)
                {
                    MessageBox.Show("error las contraseñas no coinciden ");
                    return;
                }

                // mandar los datos al sql

                objProveedor.NitProveedor = nitprovedor;
                objProveedor.Nom_PR = nombre_PR;
                objProveedor.Descript_PR = descrip_PR;
                objProveedor.Direccion_PR = direccion_PR;
                objProveedor.Correo_PR = correo_PR;
                objProveedor.Pagina_web_PR = pagina_PR;
                objProveedor.Contraseña_PR = contraseña_PR;


                if (!objProveedor.USP_Actualizar_Proveedor())
                {
                    MessageBox.Show(objProveedor.Error);
                    objProveedor = null;
                    return;
                }
                MessageBox.Show(objProveedor.Error);
                objProveedor = null;
                return;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("¿Está seguro de ELIMINAR su cuenta?", "Alerta¡¡", MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                LN_Factura objProveedor = new LN_Factura();
                // definir variables 
                string nitprovedor;
                try
                {
                    // capturar los datos del formulario
                    nitprovedor = txtNit.Text;


                    objProveedor.NitProveedor = nitprovedor;

                    if (!objProveedor.USP_Eliminar_Proveedor())
                    {
                        MessageBox.Show(objProveedor.Error);
                        objProveedor = null;
                        return;
                    }

                    Login fr = new Login();
                    fr.Show();
                    this.ParentForm.Close();
                    fr = null;
                    MessageBox.Show(objProveedor.Error);
                    objProveedor = null;
                    return;

                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
        }

        private void PR_Ajustes_Load(object sender, EventArgs e)
        {
            
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
