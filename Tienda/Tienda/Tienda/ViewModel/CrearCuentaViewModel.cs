using Firebase.Auth;
using Firebase.Database;
using Firebase.Database.Query;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using Tienda.Model;
using Xamarin.Forms;

namespace Tienda.ViewModel
{
    public class CrearCuentaViewModel : BaseViewModel
    {
        public ModeloUsuario Usuario { get; set; }

        public Command RegistrarCommand { get; }

        public CrearCuentaViewModel()
        {
            Usuario = new ModeloUsuario();
            RegistrarCommand = new Command(async () => await RegistrarUsuario());
        }

        private async Task RegistrarUsuario()
        {
            if (Usuario.Contraseña != Usuario.ConfirmarContraseña)
            {
                await Application.Current.MainPage.DisplayAlert("Error", "Las contraseñas no coinciden.", "Aceptar");
                return;
            }

            try
            {
                var authProvider = new FirebaseAuthProvider(new FirebaseConfig("AIzaSyAk8S9HafsjIaJ3MZORRZS_U3q6c28HXy4"));
                var auth = await authProvider.CreateUserWithEmailAndPasswordAsync(Usuario.Correo, Usuario.Contraseña);
                var token = auth.FirebaseToken;

                // Enviar correo de verificación
                await authProvider.SendEmailVerificationAsync(token);

                await Application.Current.MainPage.DisplayAlert("Éxito", "Cuenta creada exitosamente. Por favor, verifica tu correo electrónico.", "Aceptar");

                // Registrar datos del usuario en la base de datos
                var usuario = new ModeloUsuario
                {
                    Correo = Usuario.Correo,
                    TipoUsuario = "Cliente"
                };

                var database = new FirebaseClient("https://appabarrotes-7b3c8-default-rtdb.firebaseio.com/");
                await database
                    .Child("usuarios")
                    .Child(auth.User.LocalId)
                    .PutAsync(usuario);

                // Navegar a la página de inicio de sesión o principal después de registrar los datos
                var navigationPage = new NavigationPage(new MainPage())
                {
                    BarBackgroundColor = Color.RoyalBlue
                };
                Application.Current.MainPage = navigationPage;
            }
            catch (Exception ex)
            {
                await Application.Current.MainPage.DisplayAlert("Error", $"Exception occurred while processing the request: {ex.Message}", "Aceptar");
            }
        }
    }
}
