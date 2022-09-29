using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LibConexionBD;
using System.Data.Sql;
using System.Data.SqlClient;
//using System.Windows.Forms;
using LibLlenarGrid;

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
        }

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

        #endregion
    }
}
