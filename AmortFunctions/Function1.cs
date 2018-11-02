using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Azure.WebJobs.Host;

namespace AmortFunctions
{
    public static class Function1
    {
        [FunctionName("Function1")]
        public static HttpResponseMessage Run([HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = null)]HttpRequestMessage req, TraceWriter log)
        {
            log.Info("C# HTTP trigger function processed a request.");

            // parse query parameter
            int p = Convert.ToInt32(req.GetQueryNameValuePairs()
                .FirstOrDefault(q => string.Compare(q.Key, "p", true) == 0)
                .Value);

            int t = Convert.ToInt32(req.GetQueryNameValuePairs()
                .FirstOrDefault(q => string.Compare(q.Key, "t", true) == 0)
                .Value);

            decimal r = Convert.ToDecimal(req.GetQueryNameValuePairs()
                .FirstOrDefault(q => string.Compare(q.Key, "r", true) == 0)
                .Value);

            CobList cList = new CobList();
            LoanData PaymentInfo = cList.AmortInfo(p, t, r);

            //if (name == null)
            //{
            //    // Get request body
            //    dynamic data = await req.Content.ReadAsAsync<object>();
            //    name = data?.name;
            //}

            return  req.CreateResponse(HttpStatusCode.OK, PaymentInfo);
        }
    }
}
