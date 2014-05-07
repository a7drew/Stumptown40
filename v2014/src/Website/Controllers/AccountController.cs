using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data.SqlServerCe;
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
            using (var cnn = Settings.GetConnection())
            {
                cnn.Open();

                var list = cnn.Query<AppSetting>(@"SELECT * FROM AppSetting ORDER BY AppSettingId;").ToList();

                if (!string.IsNullOrEmpty(username) 
                    && !string.IsNullOrEmpty(password) 
                    && username == list[0].SettingValue 
                    && password == list[1].SettingValue)
                {
                    System.Web.Security.FormsAuthentication.SetAuthCookie(username, false);
                    return RedirectToAction("index", "admin");
                }
                
                return RedirectToAction("index");
            }
        }
    }
}
