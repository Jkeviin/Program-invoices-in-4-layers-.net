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
    }
}
