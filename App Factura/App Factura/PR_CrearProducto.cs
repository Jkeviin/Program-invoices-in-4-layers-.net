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
    public partial class PR_CrearProducto : Form
    {
        public PR_CrearProducto()
        {
            InitializeComponent();
        }


        private void llenarComboBoxEmpleado()
        {
            LN_Factura objProveedor = new LN_Factura();
            if (!objProveedor.USP_COMBOBOX_CATEGORIA(cBoxCategoria))
            {
                MessageBox.Show(objProveedor.Error);
                objProveedor = null;
                return;
            }
        }

        private void PR_CrearProducto_Load(object sender, EventArgs e)
        {
            llenarComboBoxEmpleado();
        }

        private void cBoxCategoria_KeyPress(object sender, KeyPressEventArgs e)
        {
            e.Handled = true;
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            LN_Factura objProveedor = new LN_Factura();
            // declarar variables
            string codigo, categoria, nombre, descripcion;
            float precio;
            try
            {
                //capturar variables
                codigo = txtCodigo.Text;
                categoria = cBoxCategoria.SelectedValue.ToString();
                nombre = txtnombre.Text;
                precio = (float)Convert.ToDouble(txtPrecio.Text);
                descripcion = txtDescripcion.Text;

                //Enviar valores al LN
                objProveedor.Cod_P = codigo;
                objProveedor.Cod_referenceCT_FK = categoria;
                objProveedor.Nom_P = nombre;
                objProveedor.Valor_P = precio;
                objProveedor.Descripcion_P = descripcion;

                if (!objProveedor.USP_Registro_Producto())
                {
                    MessageBox.Show(objProveedor.Error);
                    objProveedor = null;
                    return;
                }
                else
                {
                    this.Close();
                    txtCodigo.Text = "";
                    txtnombre.Text = "";
                    txtPrecio.Text = "";
                    txtDescripcion.Text = "";
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

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
