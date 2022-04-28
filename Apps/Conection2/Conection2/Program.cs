using System;
using Microsoft.Data.SqlClient;

namespace DBConnectV2
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Interactuando con la BD desde la consola");
            string connString = "Data Source=v-w7-des;Initial Catalog=Exam2Verif;Integrated Security=True";
            //string connString = "Data Source = V-W7-DES; Initial Catalog = Exam2Verif; User ID = TestDBExam; Password = examen";
            SqlConnection conn = new SqlConnection(connString);
            try
            {
                Console.WriteLine("Abrimos la conexión ...");
                conn.Open();
                Console.WriteLine("Connexión exitosa");

            }
            catch (Exception e)
            {
                Console.WriteLine("Error: " + e.Message);
                Environment.Exit(0);
            }


            // Primer ejercicio: un comando SQL directo
            Console.WriteLine("Ejecutamos un comando SQL directamente");
            SqlCommand comando = new SqlCommand("select * from Autores", conn);
            SqlDataReader ejecutor = comando.ExecuteReader();
            while (ejecutor.Read())
            {
                Console.WriteLine(ejecutor["IdAutor"] + " | " + ejecutor["Nombre"] + " | " + ejecutor["Nacionalidad"]);
            }
            Console.WriteLine("**_______________________**");
            Console.ReadKey();
            ejecutor.Close();


        }
    }
}
