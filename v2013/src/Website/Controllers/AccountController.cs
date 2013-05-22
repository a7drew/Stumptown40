using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Dapper;
using Website.Models;

namespace Website.Controllers
{
    public class AccountController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult SignIn(string username, string password)
        {
            MyConfig myConfig;
            using (var connection = new SqlConnection(Settings.Cnn))
            {
                connection.Open();
                myConfig = connection.Query<MyConfig>("select * from MyConfig where MyConfigId=1").FirstOrDefault();
            }

            if (myConfig != null && myConfig.MyKey == username && myConfig.Myvalue == password)
            {
                System.Web.Security.FormsAuthentication.SetAuthCookie(username, false);

                return RedirectToAction("Index", "Admin");
            }

            return RedirectToAction("Index");
        }
    }
}
