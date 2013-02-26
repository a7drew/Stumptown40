using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LinqToTwitter;
using Website.Infrastructure;
using Website.Models;

namespace Website.Controllers
{
	public class TwitterController : Controller
	{
		public ActionResult Index(string term)
		{
			var twitterCtx = new TwitterContext();

            var queryResults =
                from search in twitterCtx.Search
                where search.Type == SearchType.Search &&
                      search.Query == term
                select search;

			var model = queryResults.Single().Results;

			return new JsonpResult
			{
				Data = model, 
				JsonRequestBehavior = JsonRequestBehavior.AllowGet
			};
		}
	}
}
