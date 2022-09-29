using Lib_LN_Factura;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace App_Factura
{
    public partial class PR_EditarProducto : Form
    {
        public PR_EditarProducto()
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

        private void PR_EditarProducto_Load(object sender, EventArgs e)
        {
            llenarComboBoxEmpleado();
        }

        private void cBoxCategoria_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Trae contenido
           // MessageBox.Show(cBoxCategoria.GetItemText(cBoxCategoria.SelectedItem));
            //Trae index
           // MessageBox.Show(cBoxCategoria.SelectedValue.ToString());   
            
        }

        private void btnEditar_Click(object sender, EventArgs e)
        {
            LN_Factura objProveedor = new LN_Factura();
            // declarar variables
            string codigo, categoria, nombre, descripcion;
            float valor;
            int stock; 
            try
            {
                //capturar variables
                codigo = txtCodigo.Text;
                categoria = cBoxCategoria.SelectedValue.ToString();
                nombre = txtNombre.Text;
                descripcion = txtDescripcion.Text;
                valor = (float)Convert.ToDouble(txtValor.Text);
                stock = Convert.ToInt16(txtStock.Text);

                //Enviar valores al LN

                objProveedor.Cod_P = codigo;
                objProveedor.Cod_referenceCT_FK = categoria;
                objProveedor.Nom_P = nombre;
                objProveedor.Descripcion_P = descripcion;
                objProveedor.Valor_P = valor;
                objProveedor.Stock_P = stock;

                if (!objProveedor.USP_Actualizar_Producto())
                {
                    MessageBox.Show(objProveedor.Error);
                    objProveedor = null;
                    return;
                }
                else
                {
                    this.Close();
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
