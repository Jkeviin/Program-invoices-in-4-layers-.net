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
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace App_Factura
{
    public partial class PR_EditarCategoria : Form
    {
        public PR_EditarCategoria()
        {
            InitializeComponent();
        }
     
        private void PR_EditarCategoria_Load (object sender, EventArgs e)
        {
        }
  

        private void btnEditar_Click(object sender, EventArgs e)
        {
            LN_Factura objproveedor = new LN_Factura();
            //DECLARAR VARIABLES
            string codigo, nombre, descripcion;

            try
            {
                //Captura de variables
                codigo = txtCodigo.Text;            
                nombre = txtNombre.Text;
                descripcion = txtDescripcion.Text;
       

                //Enviar valores a la LN

                objproveedor.Cod_P = codigo;
                objproveedor.Nom_P = nombre;
                objproveedor.Descripcion_P = descripcion;
  

                if(!objproveedor.USP_Actualizar_Producto())
                {
                    MessageBox.Show(objproveedor.Error);
                    objproveedor = null;
                    return;
                }
                else
                {
                    this.Close();
                    MessageBox.Show(objproveedor.Error);
                    objproveedor = null;
                    return;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                objproveedor = null;
            }
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void cBoxCategoria_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Trae contenido
            // MessageBox.Show(cBoxCategoria.GetItemText(cBoxCategoria.SelectedItem));
            //Trae index
            // MessageBox.Show(cBoxCategoria.SelectedValue.ToString());   
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }
    }
}
