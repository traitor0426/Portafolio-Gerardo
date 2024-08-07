using System;
using System.Collections.Generic;
using System.Text;
using Tienda.ViewModel;

namespace Tienda.Model
{
   public class ModeloUsuario : BaseViewModel
    {
        private string correo;
        private string contraseña;
        private string confirmarContraseña;
        private string tipoUsuario;

        public string Correo
        {
            get { return correo; }
            set { SetProperty(ref correo, value); }
        }
        public string Contraseña
        {
            get { return contraseña; }
            set { SetProperty(ref contraseña, value); }
        }
        public string ConfirmarContraseña
        {
            get { return confirmarContraseña; }
            set { SetProperty(ref confirmarContraseña, value); }
        }

        public string TipoUsuario {
            get { return tipoUsuario; }
            set { SetProperty(ref tipoUsuario, value); }
        }
    }
}