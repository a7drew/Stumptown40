using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Website.Models
{
    public class AppSetting
    {
        public int AppSettingId { get; set; }
        public string SettingName { get; set; }
        public string SettingValue { get; set; }
    }
}