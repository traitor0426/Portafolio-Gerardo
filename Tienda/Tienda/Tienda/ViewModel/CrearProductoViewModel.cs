using System;
using System.Threading.Tasks;
using Firebase.Database;
using Firebase.Database.Query;
using Tienda.Model;
using Xamarin.Forms;

namespace Tienda.ViewModel
{
    public class CrearProductoViewModel : BaseViewModel
    {
        private string nombre;
        private string precio; // Cambiar a string para validar la entrada
        private string descripcion;
        private string cantidad; // Cambiar a string para validar la entrada

        public string Nombre
        {
            get { return nombre; }
            set { SetProperty(ref nombre, value); }
        }

        public string Precio
        {
            get { return precio; }
            set { SetProperty(ref precio, value); }
        }

        public string Descripcion
        {
            get { return descripcion; }
            set { SetProperty(ref descripcion, value); }
        }

        public string Cantidad
        {
            get { return cantidad; }
            set { SetProperty(ref cantidad, value); }
        }

        public Command AgregarProductoCommand { get; }

        private readonly FirebaseClient firebaseClient;

        public CrearProductoViewModel()
        {
            firebaseClient = new FirebaseClient("https://appabarrotes-7b3c8-default-rtdb.firebaseio.com/");
            AgregarProductoCommand = new Command(async () => await AgregarProducto());
        }

        public async Task<bool> AgregarProducto()
        {
            try
            {
                // Validar los campos
                if (string.IsNullOrWhiteSpace(Nombre))
                    throw new ArgumentException("El nombre no puede estar vacío.");
                if (!int.TryParse(Precio, out int precioInt) || precioInt <= 0)
                    throw new ArgumentException("El precio debe ser un número entero positivo mayor que 0.");
                if (!int.TryParse(Cantidad, out int cantidadInt) || cantidadInt < 0)
                    throw new ArgumentException("La cantidad debe ser un número entero positivo.");
                if (string.IsNullOrWhiteSpace(Descripcion))
                    throw new ArgumentException("La descripción no puede estar vacía.");

                var producto = new Producto
                {
                    Nombre = this.Nombre,
                    Precio = precioInt,
                    Descripcion = this.Descripcion,
                    Cantidad = cantidadInt
                };

                await firebaseClient
                    .Child("productos")
                    .PostAsync(producto);

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
