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

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void PR_EditarProducto_Load(object sender, EventArgs e)
        {
            llenarComboBoxEmpleado();
        }
    }
}
