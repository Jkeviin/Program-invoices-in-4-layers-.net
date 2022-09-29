using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

//Referenciar
using LibConexionBD;
using System.Windows.Forms;
using System.Web.UI.WebControls;

namespace LibLlenarCombos
{
    public class ClsLlenarCombos
    {
        #region "Constructor"
            public ClsLlenarCombos()
            {
                strNombreTabla = "";
                strSQL = "";
                strError = "";
                strColumnaTexto = "";
                strColumnaValor = "";
            }
        #endregion


        #region "Atributos"
            private string strNombreTabla;
            private string strSQL;
            private string strError;
            private string strColumnaTexto;
            private string strColumnaValor;
        #endregion 

        #region "Propiedades"
            public string NombreTabla
            {   get { return strNombreTabla; }
                set { strNombreTabla = value;  }
            }
            public string SQL
            {
                get { return SQL; }
                set { strSQL = value; }
            }
            public string ColumnaTexto
            {
                get { return strColumnaTexto;  }
                set { strColumnaTexto = value; }
            }
            public string ColumnaValor
            {
                get { return strColumnaValor; }
                set { strColumnaValor = value; }
            }
            public string Error
            { 
                get { return strError; } 
            }
        #endregion



        #region "Metodos Publicos"
            public bool LlenarCombo(ComboBox cboGenerico)
            {
                if (Validar())
                {
                    ClsConexion objConexionBD = new ClsConexion();
                    if (objConexionBD.LlenarDataSet(strNombreTabla, strSQL, false))
                    {
                        cboGenerico.DataSource = objConexionBD.DataSet_Retornado.Tables[strNombreTabla];
                        cboGenerico.DisplayMember = strColumnaTexto;
                        cboGenerico.ValueMember = strColumnaValor;
                        objConexionBD.CerrarConexion();
                        objConexionBD = null;
                        return true;
                    }
                    else
                    {
                        strError = objConexionBD.Error;
                        objConexionBD.CerrarConexion();
                        objConexionBD = null;
                        return false;
                    }
                }
                else
                    return false;
            }


            public bool LlenarComboWeb(DropDownList cboGenerico)
            {
                if (Validar())
                {
                    ClsConexion objConexionBD = new ClsConexion();
                    if (objConexionBD.LlenarDataSet(strNombreTabla, strSQL, false))
                    {
                        cboGenerico.DataSource = objConexionBD.DataSet_Retornado.Tables[strNombreTabla];
                        cboGenerico.DataTextField = strColumnaTexto;
                        cboGenerico.DataValueField = strColumnaValor;
                        cboGenerico.DataBind();
                        objConexionBD.CerrarConexion();
                        objConexionBD = null;
                        return true;
                    }
                    else
                    {
                        strError = objConexionBD.Error;
                        objConexionBD.CerrarConexion();
                        objConexionBD = null;
                        return false;
                    }
                }
                else
                    return false;
            }
        #endregion


        #region "Metodos Privados"
            private bool Validar()
            {if (strSQL == "")
            {  strError = "No definio la instrucción SQL";
                return false;
            }
            if (strColumnaTexto == "")
            {
                strError = "No definio el nombre de la columna para el texto del Combobox";
                return false;
            }

            if (strColumnaValor == "")
            {
                strError = "No definio el nombre de la columna para el valor del combobox";
                return false;
            }

            if (strNombreTabla == "")
                strNombreTabla = "Tabla";
                return true;
            }
        #endregion





    }
}
