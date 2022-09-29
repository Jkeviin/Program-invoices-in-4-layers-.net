using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LibConexionBD;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Windows.Forms;
using LibLlenarGrid;
using LibLlenarCombos;

namespace Lib_LN_Factura
{
    public class LN_Factura
    {

        #region Atributos
        //Variables Extra
        private string error;
        SqlDataReader reader;

        // PROVEEDOR
        private string nitProveedor;
        private string nom_PR;
        private string descript_PR;
        private string direccion_PR;
        private string correo_PR;
        private string contraseña_PR;
        private string pagina_web_PR;

        // TELEFONO PROVEEDOR
        private string telefono;
        //--------------

        // CATEGORIA
        private string cod_referenceCT;
        private string nom_CT;
        private string descripcion_CT;
        //--------------

        // PRODUCTO
        private string cod_P;
        private string nom_P;
        private string cod_referenceCT_FK;
        private string descripcion_P;
        private float valor_P;
        private int stock_P;


        #endregion

        #region Propiedades
        //Variables Extra
        public string Error { get => error; set => error = value; }
        public SqlDataReader Reader { get => reader; set => reader = value; }
        // PROVEEDOR
        public string NitProveedor { get => nitProveedor; set => nitProveedor = value; }
        public string Nom_PR { get => nom_PR; set => nom_PR = value; }
        public string Descript_PR { get => descript_PR; set => descript_PR = value; }
        public string Direccion_PR { get => direccion_PR; set => direccion_PR = value; }
        public string Correo_PR { get => correo_PR; set => correo_PR = value; }
        public string Contraseña_PR { get => contraseña_PR; set => contraseña_PR = value; }
        public string Pagina_web_PR { get => pagina_web_PR; set => pagina_web_PR = value; }
        // TELEFONO PROVEEDOR
        public string Telefono { get => telefono; set => telefono = value; }
        
        //--------------

        // CATEGORIA
        public string Cod_referenceCT { get => cod_referenceCT; set => cod_referenceCT = value; }
        public string Nom_CT { get => nom_CT; set => nom_CT = value; }
        public string Descripcion_CT { get => descripcion_CT; set => descripcion_CT = value; }

        //--------------

        // PRODUCTO
        public string Cod_P { get => cod_P; set => cod_P = value; }
        public string Nom_P { get => nom_P; set => nom_P = value; }
        public string Cod_referenceCT_FK { get => cod_referenceCT_FK; set => cod_referenceCT_FK = value; }
        public string Descripcion_P { get => descripcion_P; set => descripcion_P = value; }
        public float Valor_P { get => valor_P; set => valor_P = value; }
        public int Stock_P { get => stock_P; set => stock_P = value; }

        //--------------

        // PRODUCTO

        #endregion

        #region Metodos Publicos

        public LN_Factura()
        {
            // Variables extra
            error = "";

            // PROVEEDOR
            nitProveedor = "";
            nom_PR = "";
            descript_PR = "";
            direccion_PR = "";
            correo_PR = "";
            contraseña_PR = "";
            pagina_web_PR = "";

            // TELEFONO PROVEEDOR
            telefono = "";

            //--------------

            // CATEGORIA
            cod_referenceCT = "";
            nom_CT = "";
            descripcion_CT = "";

            //--------------

            // PRODUCTO
            cod_P = "";
            nom_P = "";
            cod_referenceCT_FK = "";
            descripcion_P = "";
            valor_P = 0;
            stock_P = 0;
        }

        #region REGISTRO
        public bool USP_Registro_Proveedor()
        {
            ClsConexion objConexion = new ClsConexion();
            String sentencia = $"execute USP_Registro_Proveedor '{nitProveedor}', '{nom_PR}', '{descript_PR}', '{direccion_PR}', '{correo_PR}', '{contraseña_PR}', '{pagina_web_PR}', '{telefono}';";
            if (!objConexion.EjecutarSentencia(sentencia, false))
            {
                error = objConexion.Error;
                objConexion = null;
                return false;
            }
            else
            {
                error = "Proveedor registrado exitosamente";
                objConexion = null;
                return true;
            }
        }

        public bool USP_Registro_Categoria()
        {
            ClsConexion objConexion = new ClsConexion();
            String sentencia = $"execute USP_Registro_Categoria '{cod_referenceCT}', '{nom_CT}', '{descripcion_CT}';";
            if (!objConexion.EjecutarSentencia(sentencia, false))
            {
                error = objConexion.Error;
                objConexion = null;
                return false;
            }
            else
            {
                error = "Categoria registrada exitosamente";
                objConexion = null;
                return true;
            }
        }

        #endregion

        #region ACTUALIZAR

        public bool USP_Actualizar_Producto()
        {
            ClsConexion objConexion = new ClsConexion();
            String sentencia = $"execute USP_Actualizar_Producto '{cod_P}','{nom_P}','{cod_referenceCT_FK}','{descripcion_P}',{valor_P},{stock_P};";
            if (!objConexion.EjecutarSentencia(sentencia, false))
            {
                error = objConexion.Error;
                objConexion = null;
                return false;

            }
            reader = objConexion.Reader;
            error = "Producto Actualizado";
            objConexion = null;
            return true;
        }

        #endregion 

        public bool USP_inicio_sesion_Proveedor()
        {
            ClsConexion objConexion = new ClsConexion();
            String sentencia = $"execute USP_inicio_sesion_Proveedor '{correo_PR}','{contraseña_PR}'";
            if (!objConexion.Consultar(sentencia, false))
            {
                error = objConexion.Error;
                objConexion = null;
                return false;

            }
            reader = objConexion.Reader;
            error = "Proovedor consultado";
            objConexion = null;
            return true;
        }

        public bool USP_COMBOBOX_CATEGORIA(ComboBox objCb)
        {
            /*objCb y obC es diferente, el primero es un objeto de comboBox y el otro de la clase
            llenar combos*/
            ClsLlenarCombos objC = new ClsLlenarCombos();
            objC.NombreTabla = "Datos Categoria";
            objC.SQL = "execute USP_COMBOBOX_CATEGORIA";
            objC.ColumnaTexto = "nom_CT";
            objC.ColumnaValor = "cod_referenceCT";
            try
            {
                if (!objC.LlenarCombo(objCb))
                {
                    error = objC.Error;
                    objC = null;
                    return false;
                }
                objC = null;
                return true;

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                objC = null;
                return false;
            }
        }


        public bool USP_Listar_Productos(DataGridView objDVG)
        {

            ClsLlenarGrid objGrid = new ClsLlenarGrid();

            objGrid.SQL = $"execute USP_Listar_Productos";
            objGrid.NombreTabla = "Productos";
            if (!objGrid.LlenarGrid(objDVG))
            {
                error = objGrid.Error;
                objGrid = null;
                return false;
            }
            objGrid = null;
            return true;
        }

        #endregion
    }
}
