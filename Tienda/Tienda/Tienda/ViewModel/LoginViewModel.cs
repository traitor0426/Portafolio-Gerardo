using Firebase.Auth;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using Tienda.View;
using Xamarin.Forms;

namespace Tienda.ViewModel
{
    public class LoginViewModel : BaseViewModel
    {
        private string correo;
        private string contraseña;

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

        public Command IngresarCommand { get; }
        public Command CrearCuentaCommand { get; }

        public LoginViewModel()
        {
            IngresarCommand = new Command(async () => await Ingresar());
            CrearCuentaCommand = new Command(async () => await CrearCuenta());
        }

        private async Task Ingresar()
        {
            if (string.IsNullOrEmpty(Correo) || string.IsNullOrEmpty(Contraseña))
            {
                await Application.Current.MainPage.DisplayAlert("Error", "Por favor ingrese su correo y contraseña.", "OK");
                return;
            }

            try
            {
                var authProvider = new FirebaseAuthProvider(new FirebaseConfig("AIzaSyAk8S9HafsjIaJ3MZORRZS_U3q6c28HXy4"));
                var auth = await authProvider.SignInWithEmailAndPasswordAsync(Correo, Contraseña);
                var user = auth.User;

                if (!user.IsEmailVerified)
                {
                    await Application.Current.MainPage.DisplayAlert("Error", "Por favor verifica tu correo electrónico antes de iniciar sesión.", "OK");
                    return;
                }

                // Navegar a la página principal si la autenticación es exitosa
                var navigationPage = new NavigationPage(new Inicio())
                {
                    BarBackgroundColor = Color.RoyalBlue
                };
                Application.Current.MainPage = navigationPage;
            }
            catch (Exception ex)
            {
                await Application.Current.MainPage.DisplayAlert("Error", "Correo o contraseña incorrectos.", "OK");
            }
        }

        private async Task CrearCuenta()
        {
            // Navegar a la página de creación de cuenta
            await Application.Current.MainPage.Navigation.PushAsync(new CrearCenta());
        }
    }
}
