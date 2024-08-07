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
	public partial class Inicio : ContentPage
	{
        private readonly InicioViewModel viewModel;
        public Inicio ()
		{
			InitializeComponent ();
            viewModel = BindingContext as InicioViewModel;
        }

        protected override void OnAppearing()
        {
            base.OnAppearing();
            viewModel?.CargarProductos();
        }
    }
}