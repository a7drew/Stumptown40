using System.Configuration;
using System.Data.SqlClient;

namespace Website.Controllers
{
    public static class Settings
    {
        public static string Cnn
        {
            get
            {
                var cnn = ConfigurationManager.ConnectionStrings["DefaultConnection"];
                return cnn.ConnectionString;
            }
        }

        public static SqlConnection GetConnection()
        {
            return new SqlConnection(Settings.Cnn);
        }
    }
}