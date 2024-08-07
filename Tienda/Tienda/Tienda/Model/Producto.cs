using System;
using Tienda.ViewModel;

namespace Tienda.Model
{
    public class Producto : BaseViewModel
    {
        private string id;
        private string nombre;
        private double precio;
        private string descripcion;
        private int cantidad;

        public string Id
        {
            get { return id; }
            set { SetProperty(ref id, value); }
        }

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

        public string Descripcion
        {
            get { return descripcion; }
            set { SetProperty(ref descripcion, value); }
        }

        public int Cantidad
        {
            get { return cantidad; }
            set { SetProperty(ref cantidad, value); }
        }
    }
}
