using Firebase.Database;
using Firebase.Database.Query;
using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;
using Tienda.Model;
using Tienda.View;
using Xamarin.Forms;

namespace Tienda.ViewModel
{
    public class InicioViewModel : BaseViewModel
    {
        private readonly FirebaseClient firebaseClient;

        public ObservableCollection<Producto> Productos { get; set; }
        public Command<Producto> EliminarCommand { get; }
        public Command<Producto> ActualizarCommand { get; }
        public Command AgregarProductoCommand { get; }

        private int totalInventario;
        public int TotalInventario
        {
            get { return totalInventario; }
            set { SetProperty(ref totalInventario, value); }
        }

        public InicioViewModel()
        {
            firebaseClient = new FirebaseClient("https://appabarrotes-7b3c8-default-rtdb.firebaseio.com/");
            Productos = new ObservableCollection<Producto>();
            AgregarProductoCommand = new Command(async () => await AgregarProducto());
            EliminarCommand = new Command<Producto>(async (producto) => await EliminarProducto(producto));
            ActualizarCommand = new Command<Producto>(async (producto) => await ActualizarProducto(producto));

            _ = CargarProductos();
        }

        public async Task CargarProductos()
        {
            var productos = await firebaseClient
                .Child("productos")
                .OnceAsync<Producto>();

            Productos.Clear();
            foreach (var producto in productos)
            {
                Productos.Add(new Producto
                {
                    Id = producto.Key,
                    Nombre = producto.Object.Nombre,
                    Precio = producto.Object.Precio,
                    Descripcion = producto.Object.Descripcion,
                    Cantidad = producto.Object.Cantidad
                });
            }

            CalcularTotalInventario();
        }

        private async Task EliminarProducto(Producto producto)
        {
            await firebaseClient
                .Child("productos")
                .Child(producto.Id)
                .DeleteAsync();

            Productos.Remove(producto);
            CalcularTotalInventario();
        }

        private async Task ActualizarProducto(Producto producto)
        {
            var viewModel = new ActualizarProductoViewModel();
            viewModel.CargarDatos(producto);
            var page = new ActualizarProducto { BindingContext = viewModel };
            await Application.Current.MainPage.Navigation.PushAsync(page);
        }

        private async Task AgregarProducto()
        {
            await Application.Current.MainPage.Navigation.PushAsync(new CrearProducto());
        }

        private void CalcularTotalInventario()
        {
            TotalInventario = Productos.Sum(p => p.Cantidad);
        }
    }
}
