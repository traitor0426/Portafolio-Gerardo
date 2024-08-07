using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tienda.ViewModel;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace Tienda.View
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class CrearProducto : ContentPage
    {
        public CrearProducto()
        {
            InitializeComponent();
            BindingContext = new CrearProductoViewModel();
        }

        private async void AlHacerClickEnAgregarProducto(object sender, EventArgs e)
        {
            var viewModel = BindingContext as CrearProductoViewModel;
            if (viewModel != null)
            {
                try
                {
                    // Validar y agregar producto
                    if (string.IsNullOrWhiteSpace(viewModel.Nombre))
                    {
                        await DisplayAlert("Error", "El nombre no puede estar vacío.", "OK");
                        return;
                    }
                    if (!int.TryParse(viewModel.Precio, out int precioInt) || precioInt <= 0)
                    {
                        await DisplayAlert("Error", "El precio debe ser un número entero positivo mayor que 0.", "OK");
                        return;
                    }
                    if (!int.TryParse(viewModel.Cantidad, out int cantidadInt) || cantidadInt < 0)
                    {
                        await DisplayAlert("Error", "La cantidad debe ser un número entero positivo.", "OK");
                        return;
                    }
                    if (string.IsNullOrWhiteSpace(viewModel.Descripcion))
                    {
                        await DisplayAlert("Error", "La descripción no puede estar vacía.", "OK");
                        return;
                    }

                    var result = await viewModel.AgregarProducto();
                    if (result)
                    {
                        await DisplayAlert("Éxito", "Producto agregado correctamente.", "OK");
                        await Navigation.PopAsync(); // Volver a la página de inicio
                    }
                    else
                    {
                        await DisplayAlert("Error", "No se pudo agregar el producto.", "OK");
                    }
                }
                catch (ArgumentException ex)
                {
                    await DisplayAlert("Error", ex.Message, "OK");
                }
                catch (Exception)
                {
                    await DisplayAlert("Error", "Ocurrió un error inesperado.", "OK");
                }
            }
        }
    }
}



