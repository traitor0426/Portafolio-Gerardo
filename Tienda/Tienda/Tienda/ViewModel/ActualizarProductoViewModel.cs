using Firebase.Database;
using Firebase.Database.Query;
using System;
using System.Threading.Tasks;
using Tienda.Model;
using Xamarin.Forms;

namespace Tienda.ViewModel
{
    public class ActualizarProductoViewModel : BaseViewModel
    {
        private readonly FirebaseClient firebaseClient;

        private string nombre;
        private double precio;
        private int cantidad;
        private string descripcion;

        public string Id { get; set; }

        public string Nombre
        {
            get { return nombre; }
            set { SetProperty(ref nombre, value); }
        }

        public double Precio
        {
            get { return precio; }
            set { SetProperty(ref precio, value); }
        }

        public int Cantidad
        {
            get { return cantidad; }
            set { SetProperty(ref cantidad, value); }
        }

        public string Descripcion
        {
            get { return descripcion; }
            set { SetProperty(ref descripcion, value); }
        }

        public Command GuardarCommand { get; }
        public Command CancelarCommand { get; }

        public ActualizarProductoViewModel()
        {
            firebaseClient = new FirebaseClient("https://appabarrotes-7b3c8-default-rtdb.firebaseio.com/");
            GuardarCommand = new Command(async () => await Guardar());
            CancelarCommand = new Command(async () => await Cancelar());
        }

        private async Task Guardar()
        {
            var producto = new Producto
            {
                Id = this.Id,
                Nombre = this.Nombre,
                Precio = this.Precio,
                Cantidad = this.Cantidad,
                Descripcion = this.Descripcion
            };

            await firebaseClient
                .Child("productos")
                .Child(producto.Id)  // Aquí se accede correctamente a la instancia `producto`
                .PutAsync(producto);

            await Application.Current.MainPage.Navigation.PopAsync();
        }

        private async Task Cancelar()
        {
            await Application.Current.MainPage.Navigation.PopAsync();
        }

        public void CargarDatos(Producto producto)
        {
            Id = producto.Id;
            Nombre = producto.Nombre;
            Precio = producto.Precio;
            Cantidad = producto.Cantidad;
            Descripcion = producto.Descripcion;
        }
    }
}

