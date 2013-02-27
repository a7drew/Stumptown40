using Microsoft.AspNet.SignalR;

namespace Website
{
    public class NavigationHub : Hub
    {
        public void Navigate(string viewName, string jsonData)
        {
            Clients.All.onNavigate(viewName, jsonData);
        }
    }
}