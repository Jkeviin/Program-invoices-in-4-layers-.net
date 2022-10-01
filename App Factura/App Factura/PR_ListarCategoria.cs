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
    public partial class PR_ListarCategoria : Form
    {
        public PR_ListarCategoria()
        {
            InitializeComponent();
        }

        private void PR_listar_categoria_Load(object sender, EventArgs e)
        {
            llenarGrid();
        }
        private void BtnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnEditar_Click(object sender, EventArgs e)
        {
            PR_EditarCategoria frm = new PR_EditarCategoria();

            if (DgvProducto.SelectedRows.Count > 0)
            {
                frm.txtCodigo.Text = DgvProducto.CurrentRow.Cells[0].Value.ToString();
                frm.txtNombre.Text = DgvProducto.CurrentRow.Cells[1].Value.ToString();
                frm.txtDescripcion.Text = DgvProducto.CurrentRow.Cells[2].Value.ToString();
                frm.FormClosed += new FormClosedEventHandler(ActualizarGrid);
                frm.ShowDialog();
            }
            else
            {
                MessageBox.Show("Seleccione una fila por favor");    
            }
            frm = null;
        }
        private void llenarGrid()
        {
            LN_Factura objProveedor = new LN_Factura();
            if (!objProveedor.USP_Listar_Categoria(DgvProducto))
            {
                MessageBox.Show(objProveedor.Error);
                objProveedor = null;
                return;
            }
            objProveedor = null;
            return;
        }

        private void ActualizarGrid(object sender, FormClosedEventArgs e)
        {
            llenarGrid();
        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("¿Está seguro de ELIMINAR la categoria?", "Alerta¡¡", MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                LN_Factura objProveedor = new LN_Factura();
                // declarar variables
                string codigo;
                try
                {
                    //capturar variables
                    codigo = DgvProducto.CurrentRow.Cells[0].Value.ToString();

                    //Enviar valores al LN
                    objProveedor.Cod_P = codigo;

                    if (!objProveedor.USP_eliminar_Producto())
                    {
                        MessageBox.Show(objProveedor.Error);
                        objProveedor = null;
                        return;
                    }
                    llenarGrid();
                    MessageBox.Show(objProveedor.Error);
                    objProveedor = null;
                    return;
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                    objProveedor = null;
                }
            }
        }

    }

}
