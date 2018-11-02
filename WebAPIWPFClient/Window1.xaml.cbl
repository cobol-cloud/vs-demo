       class-id AmortWPFClient.Window1 is partial
                 inherits type System.Windows.Window.

       working-storage section.
       method-id NEW.
       procedure division.
           invoke self::InitializeComponent()
           goback.
       end method.

       method-id btnAmort_Click.
       01 AmortURL String value "http://localhost:7071/api/Function1?".
       01 wc type WebClient.
       01 jSer type DataContractJsonSerializer.
       01 result type Byte occurs any.
       01 LoanDataObj type LoanData.
       01 AmortList List[type AmortData].
       
       procedure division using by value sender as object e as type System.Windows.RoutedEventArgs.
           declare P = tbPrincipal::Text
           declare T = tbMonths::Text
           declare R = tbRate::Text

           set AmortURL to AmortURL & "P=" & P & "&" & "T=" & T & "&" & "R=" & R
           set wc to new WebClient

           set result to wc::DownloadData(AmortURL)
           declare ms = new MemoryStream(result)
           set jSer to new DataContractJsonSerializer(type of LoanData)
           set LoanDataObj to jSer::ReadObject(ms) as type LoanData
           
           set AmortList to LoanDataObj::AmortList
           set dgAmortData::ItemsSource to AmortList
           set lblTotInterest::Content to LoanDataObj::TotalInterest
           set lblInterest::Visibility to type Visibility::Visible
           
           goback.

       end method.

       method-id btnAmortString_Click.
       01 AmortURL String value "http://localhost/AmortService/AmortService/amortstring?".
       01 wc type WebClient.
       01 jSer type DataContractJsonSerializer.
       01 result type Byte occurs any.
       01 LoanDataObj String.
       01 AmortList List[type AmortData].
       01 loanterm binary-long.
       01 payInfo type LoanData.
       
       01 outdata.
           03 Payments occurs 1 to 480 depending on loanterm.
               05 outIntPaid     pic $$,$$$.99.
               05 outPrincPaid   pic $$,$$$.99.
               05 outPayment     pic $$,$$$.99.
               05 outBalance     pic $$$,$$$.99.
           03 outTotIntPaid  pic $$,$$$.99.       
       
       procedure division using by value sender as object e as type System.Windows.RoutedEventArgs.
           declare P = tbPrincipal::Text
           declare T = tbMonths::Text
           declare R = tbRate::Text
           set loanterm to type Convert::ToInt32(T)           
           set AmortURL to AmortURL & "P=" & P & "&" & "T=" & T & "&" & "R=" & R
           set wc to new WebClient
           set result to wc::DownloadData(AmortURL)
           declare ms = new MemoryStream(result)
           set jSer to new DataContractJsonSerializer(type of String)
           set LoanDataObj to jSer::ReadObject(ms) as type String
           set outdata to type Convert::FromBase64String(LoanDataObj)
           
           set PayInfo to new type LoanData
           set AmortList to new List[type AmortData]
           declare currDate = type DateTime::Now
           if currDate::Day > 28
               declare daysAdjust = currDate::Day - 28
               set currDate to currDate::AddDays(daysAdjust * -1)
           end-if           
           perform varying Month as binary-long from 1 by 1 until Month > loanterm
               declare AmortObj = new AmortData
               declare payDate = currDate::AddMonths(Month)
               set AmortObj::PayDateNo     to "#" & Month & "    " & payDate::ToShortDateString
               set AmortObj::Balance       to outBalance(Month)
               set AmortObj::InterestPaid  to outIntPaid(Month)
               set AmortObj::PrincipalPaid to outPrincPaid(Month)
               set AmortObj::Payment       to outPayment(Month)
               invoke AmortList::Add(AmortObj)
           end-perform
           
           set PayInfo::AmortList to AmortList
           set PayInfo::TotalInterest to outTotIntPaid           
           set dgAmortData::ItemsSource to AmortList
           set lblTotInterest::Content to payInfo::TotalInterest
           set lblInterest::Visibility to type Visibility::Visible           
           
           goback.
       
       end method.

       method-id btnAdd_Click. *> !!! Work in Progress - Not working yet !!!
       01 AmortURL String value "http://localhost/WebAPICOB/api/TestCOBOL/AddData".

       01 jSer type DataContractJsonSerializer.
       01 result type Byte occurs any.
       01 LoanDataObj String.
       01 AmortList List[type AmortData].
       01 loanterm binary-long.
       01 payInfo type LoanData.
       01 queryParms type NameValueCollection.

       procedure division using by value sender as object e as type System.Windows.RoutedEventArgs.
           
           declare P = tbPrincipal::Text
           declare T = tbMonths::Text
           declare R = tbRate::Text
           set queryParms to new NameValueCollection
           invoke queryParms::Add("P", "40000")
           invoke queryParms::Add("T", "40")
           invoke queryParms::Add("R", "4.0")

           declare postParms = "P=" & P & "&" & "T=" & T & "&" & "R=" & R 

           perform using wc as type WebClient = new WebClient
               set wc::Headers[type HttpRequestHeader::ContentType] to "application/x-www-form-urlencoded"
      *        set wc::QueryString to queryParms
               declare boolResult = wc::UploadString(AmortURL, postParms)
           end-perform
           goback

       end method.

       end class.
       

