//
//  APIRequest.swift
//  MyApp
//
//  Created by ishwar lal janwa on 21/01/18.
//  Copyright © 2018 MyApp. All rights reserved.
//
/*
import Foundation
import UIKit
import Alamofire

//MARK:-
//MARK:- Networking Class

/// API Tags

let CTagSignup                      = "signup"
let CTagLogin                       = "login"
let CTagEditProfile                 = "signup"
let CTagChangePassword              = "change_password"
let CTagLanguage                    = "languages"
let CTagCategories                  = "categories"
let CTagProducts                    = "products"
let CTagReview                      = "discussions"
let CTagFeatures                    = "features"
let CTagCustomerService             = "customer_service"
let CTagReturnRequest               = "return_request"
let CTagServiceRequest              = "service_request"
let CTagQuotationRequest            = "government_quotation_request"
let CTagAddToWishList               = "wish_list"
let CTagBannerList                  = "banners"
let CTagPages                       = "pages"
let CTagBuyTogether                 = "product_tab"
let CTagProductFilter               = "product_filter"
let CTagCountryList                 = "checkout_list"




let CTagForgotPassword              = "forgot-password"
let CTagCMS                         = "cms"

// AUTH TOKEN LOCAL URL and AUTH TOKEN VPN Server
var authToken = "Basic dGVzdEBjYW00c2VsbC5jb206WlFZSXNWMTZUSDBET2Y0NmJkZnpvZUFiNDEyWDE0MGc="

// AUTH TOKEN TESTING RAEED
//var authToken = "Basic YWRtaW5AY2FtNHNlbGwuY29tOjQwRkg1bzZSV3cyN24wTGNuTTk1MElhZDZLZDdWaDUy"

// AUTH TOKEN LIVE
//var authToken = "Basic Y2FtNHNlbGxAY2FtNHNlbGwuY29tOmRqM0I5dzRpemM5UnIyN29QMjlTVlVwdjI3aFVaOHAy"

typealias ClosureSuccess = (_ task:URLSessionTask, _ response:AnyObject?) -> Void
typealias ClosureError   = (_ task:URLSessionTask, _ message:String?, _ error:NSError?) -> Void

class Networking: NSObject
{
    
    var BASEURL:String?
    var headers:[String: String] = ["Authorization" : authToken]
    
    var loggingEnabled = true
    var activityCount = 0
    
    
    /// Networking Singleton
    static let sharedInstance = Networking.init()
    override init() {
        super.init()
    }
    
    fileprivate func logging(request req:Request?) -> Void
    {
        if (loggingEnabled && req != nil)
        {
            var body:String = ""
            var length = 0
            
            if (req?.request?.httpBody != nil) {
                body = String.init(data: (req!.request!.httpBody)!, encoding: String.Encoding.utf8)!
                length = req!.request!.httpBody!.count
            }
            
            let printableString = "\(req!.request!.httpMethod!) '\(req!.request!.url!.absoluteString)': \(String(describing: req!.request!.allHTTPHeaderFields)) \(body) [\(length) bytes]"
            
            print("API Request: \(printableString)")
        }
    }
    
    fileprivate func logging(response res:DataResponse<Any>) -> Void
    {
        if (loggingEnabled && (res != nil))
        {
            
            if (res.result.error != nil) {
                print("API Response: (\(String(describing: res.response?.statusCode))) [\(res.timeline.totalDuration)s] Error:\(String(describing: res.result.error))")
            } else {
                print("API Response: (\(res.response!.statusCode)) [\(res.timeline.totalDuration)s] Response:\(String(describing: res.result.value))")
            }
        }
    }
    
    
    
    /// Uploading
    
    func upload(
        _ URLRequest: URLRequestConvertible,
        multipartFormData: (MultipartFormData) -> Void,
        encodingCompletion: ((SessionManager.MultipartFormDataEncodingResult) -> Void)?) -> Void
    {
        
        let formData = MultipartFormData()
        multipartFormData(formData)
        
        
        var URLRequestWithContentType = try? URLRequest.asURLRequest()
        
        URLRequestWithContentType?.setValue(formData.contentType, forHTTPHeaderField: "Content-Type")
        
        let fileManager = FileManager.default
        let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
        let fileName = UUID().uuidString
        
        #if swift(>=2.3)
            let directoryURL = tempDirectoryURL.appendingPathComponent("com.alamofire.manager/multipart.form.data")
            let fileURL = directoryURL.appendingPathComponent(fileName)
        #else
            
            let directoryURL = tempDirectoryURL.appendingPathComponent("com.alamofire.manager/multipart.form.data")
            let fileURL = directoryURL.appendingPathComponent(fileName)
        #endif
        
        
        do {
            try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
            try formData.writeEncodedData(to: fileURL)
            
            DispatchQueue.main.async {
                
                let encodingResult = SessionManager.MultipartFormDataEncodingResult.success(request: SessionSharedManager.shared().upload(fileURL, with: URLRequestWithContentType!), streamingFromDisk: true, streamFileURL: fileURL)
                encodingCompletion?(encodingResult)
            }
        } catch {
            DispatchQueue.main.async {
                encodingCompletion?(.failure(error as NSError))
            }
        }
    }
    
    // HTTPs Methods
    func GET(param parameters:[String: AnyObject]?, success:ClosureSuccess?,  failure:ClosureError?) -> URLSessionTask?
    {
        
        let uRequest = SessionSharedManager.shared().request(BASEURL!, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        self.logging(request: uRequest)
        
        uRequest.responseJSON { (response) in
            
            self.logging(response: response)
            if(response.result.error == nil && response.response?.statusCode == 200)
            {
                if(success != nil) {
                    success!(uRequest.task!, response.result.value as AnyObject)
                }
            }
            else
            {
                if(failure != nil) {
                    failure!(uRequest.task!, nil , response.result.error as NSError?)
                }
            }
        }
        
        return uRequest.task
    }
    
    func GET(apiTag tag:String, param parameters:[String: AnyObject]?, successBlock success:ClosureSuccess?,   failureBlock failure:ClosureError?) -> URLSessionTask?
    {
        
        let uRequest = SessionSharedManager.shared().request((BASEURL! + tag), method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        self.logging(request: uRequest)
        
        uRequest.responseJSON { (response) in
            
            self.logging(response: response)
            if(response.result.error == nil && response.response?.statusCode == 200)
            {
                if(success != nil) {
                    success!(uRequest.task!, response.result.value as AnyObject)
                }
            }
            else
            {
                if(failure != nil) {
                    failure!(uRequest.task!,nil, response.result.error as NSError?)
                }
            }
        }
        
        return uRequest.task
    }
    
    func POST(apiTag tag:String, param parameters:[String: AnyObject]?, successBlock success:ClosureSuccess?,   failureBlock failure:ClosureError?) -> URLSessionTask?
    {
        let uRequest = SessionSharedManager.shared().request((BASEURL! + tag), method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        self.logging(request: uRequest)
        
        uRequest.responseJSON { (response) in
            
            self.logging(response: response)
            if(response.result.error == nil && ([200,201] .contains(response.response!.statusCode)) )
            {
                if(success != nil) {
                    success!(uRequest.task!, response.result.value as AnyObject)
                }
            }
            else
            {
                if(failure != nil) {
                    
                    if response.result.error != nil
                    {
                        failure!(uRequest.task!,nil, response.result.error as NSError?)
                    }
                    else
                    {
                        let dict = response.result.value as? [String : AnyObject]
                        
                        guard let message = dict?.string(forJSON: "message") else
                        {
                            return failure!(uRequest.task!,nil, nil)
                        }
                        
                        failure!(uRequest.task!,message, nil)
                    }
                    
                }
            }
        }
        
        return uRequest.task
    }
   
    
    
    func POST(param parameters:[String: AnyObject]?, multipartFormData: @escaping (MultipartFormData) -> Void, success:ClosureSuccess?,  failure:ClosureError?) -> Void
    {
        
        SessionSharedManager.shared().upload(multipartFormData: { (multipart) in
            multipartFormData(multipart)
            
            for (key, value) in parameters! {
                
                multipart.append(value.data(using: String.Encoding.utf8.rawValue)! , withName: key)
            }
            
        },  to: (BASEURL! + (parameters?["tag"] as? String ?? "")), method: HTTPMethod.post , headers: headers) { (encodingResult) in
            
            switch encodingResult {
                
            case .success(let uRequest, _, _):
                
                self.logging(request: uRequest)
                
                uRequest.responseJSON { (response) in
                    
                    self.logging(response: response)
                    if(response.result.error == nil)
                    {
                        if(success != nil) {
                            success!(uRequest.task!, response.result.value as AnyObject)
                        }
                    }
                    else
                    {
                        if(failure != nil) {
                            failure!(uRequest.task!,nil, response.result.error as NSError?)
                        }
                    }
                }
                
                break
            case .failure(let encodingError):
                print(encodingError)
                break
            }
        }
        
    }
    
    func HEAD(param parameters: [String: AnyObject]?, success : ClosureSuccess?, failure:ClosureError?) -> URLSessionTask
    {
        
        let uRequest = SessionSharedManager.shared().request(BASEURL!, method: .head, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        self.logging(request: uRequest)
        
        uRequest.responseJSON { (response) in
            
            self.logging(response: response)
            if response.result.error == nil
            {
                if (success != nil) {
                    success!(uRequest.task!, response.result.value as AnyObject)
                }
            }
            else
            {
                if(failure != nil) {
                    failure!(uRequest.task!,nil, response.result.error as NSError?)
                }
            }
        }
        
        return uRequest.task!
    }
    
    func PATCH(param parameters: [String: AnyObject]?, success : ClosureSuccess?, failure:ClosureError?) -> URLSessionTask
    {
        
        let uRequest = SessionSharedManager.shared().request(BASEURL!, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        self.logging(request: uRequest)
        
        uRequest.responseJSON { (response) in
            
            self.logging(response: response)
            if response.result.error == nil
            {
                if (success != nil) {
                    success!(uRequest.task!, response.result.value as AnyObject)
                }
            }
            else
            {
                if(failure != nil) {
                    failure!(uRequest.task!, nil, response.result.error as NSError?)
                }
            }
        }
        
        return uRequest.task!
    }
    
    func PUT(apiTag tag:String, param parameters:[String: AnyObject]?, successBlock success:ClosureSuccess?,   failureBlock failure:ClosureError?) -> URLSessionTask?
    {
        
        let uRequest = SessionSharedManager.shared().request(BASEURL!+tag, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.logging(request: uRequest)
        
        uRequest.responseJSON { (response) in
            
            self.logging(response: response)
            if(response.result.error == nil && ([200,201] .contains(response.response!.statusCode)) )
            {
                if(success != nil) {
                    success!(uRequest.task!, response.result.value as AnyObject)
                }
            }
            else
            {
                if(failure != nil) {
                    
                    if response.result.error != nil
                    {
                        failure!(uRequest.task!,nil, response.result.error as NSError?)
                    }
                    else
                    {
                        let dict = response.result.value as? [String : AnyObject]
                        
                        guard let message = dict?.string(forJSON: "message") else
                        {
                            return failure!(uRequest.task!,nil, nil)
                        }
                        
                        failure!(uRequest.task!,message, nil)
                    }
                    
                }
            }
        }
        
        
        return uRequest.task!
    }
    func PUT(param parameters: [String: AnyObject]?, success : ClosureSuccess?, failure:ClosureError?) -> URLSessionTask
    {
        
        let uRequest = SessionSharedManager.shared().request(BASEURL!, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.logging(request: uRequest)
        
        uRequest.responseJSON { (response) in
            
            self.logging(response: response)
            if response.result.error == nil
            {
                if (success != nil) {
                    success!(uRequest.task!, response.result.value as AnyObject)
                }
            }
            else
            {
                if(failure != nil) {
                    failure!(uRequest.task!, nil, response.result.error as NSError?)
                }
            }
            
        }
        
        return uRequest.task!
    }
    
    func DELETE(param parameters: [String: AnyObject]?, success : ClosureSuccess?, failure:ClosureError?) -> URLSessionTask
    {
        
        let uRequest = SessionSharedManager.shared().request(BASEURL!, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        self.logging(request: uRequest)
        
        uRequest.responseJSON { (response) in
            
            self.logging(response: response)
            if response.result.error == nil
            {
                if (success != nil) {
                    success!(uRequest.task!, response.result.value as AnyObject)
                }
            }
            else
            {
                if(failure != nil) {
                    failure!(uRequest.task!, nil, response.result.error as NSError?)
                    
                }
            }
        }
        
        return uRequest.task!
    }
}


//MARK:-
//MARK:- APIRequest Class

class APIRequest: NSObject {
    
    
    typealias ClosureCompletion = (_ response:AnyObject?, _ error:NSError?) -> Void
    
    typealias successCallBack = (([String:AnyObject]?) -> ())
    typealias failureCallBack = ((String) -> ())
    
    /// API BASEURL
    
    // TESTING URL Vipul pc
    //var BASEURL:String      =   "http://192.168.1.23/testing_raed/api"
    
    // TESTING URL Vasant pc
    //var BASEURL:String      =   "http://192.168.1.31/testing_raed/api"
   // var BASEURL:String      =   "http://192.168.1.31/cam4sell/api"
    
    // VPN Server
    var BASEURL:String      =   "http://180.211.104.102/cam4sell/api/"

    // TESTING URL
   // var BASEURL:String      =   "https://www.cam4sell.com/testing_raed/api/"
    
    // LIVE  URL
//    var BASEURL:String      =   "https://www.cam4sell.com/api/"
    
    
    
    //MARK:- APIRequest Singleton
    
    private override init() {
        super.init()
    }
    
    private var apiRequest:APIRequest {
        let apiRequest = APIRequest()
        
        if (BASEURL.count > 0 && !BASEURL.hasSuffix("/")) {
            BASEURL = BASEURL + "/"
        }
        
    
        Networking.sharedInstance.BASEURL = BASEURL
        return apiRequest
    }
    
    static func shared() -> APIRequest {
        return APIRequest().apiRequest
    }
    
    private func handleStatusCode(response:AnyObject? ,suceessAlert:Bool, failurAlert:Bool, successCallBack:successCallBack , failureCallBack:failureCallBack)
    {
        
        if (response?["meta"] != nil && (response?["meta"] as? [String:Any]) != nil)
        {
            let dict =  response?["meta"] as? [String: Any]
            
            if dict?[CJsonStatus] as! NSNumber == CStatusZero
            {
                successCallBack(response as? [String : AnyObject] ?? nil)
                if(suceessAlert)
                {
                    PPAlerts.sharedAlerts().showAlert(with: .toast, withMessage: dict?[CJsonMessage] as! String)
                }
                print("yes")
            }
            else if (failurAlert)
            {
                
                //                PPAlerts.sharedAlerts().showAlert(with: .adefault, withMessage: response?[CJsonMessage] as! String)
                PPAlerts .sharedAlerts().iOsAlert(title: "", withMessage: dict?[CJsonMessage] as! String, withDelegate: nil)
            }
        }
        else if (response?[CJsonStatus] as? NSNumber) == CStatusZero
        {
            failureCallBack(response?[CJsonMessage] as? String ?? "")
        }
        else if (failurAlert)
        {
            PPAlerts .sharedAlerts().iOsAlert(title: "", withMessage: response?[CJsonMessage] as! String, withDelegate: nil)
        }
        else if (response?[CJsonStatus] as? NSNumber) == CStatusFourHundredAndOne || (response?[CJsonStatus] as? NSNumber) == CStatusFiveHundredAndFiftyFive || (response?[CJsonStatus] as? NSNumber) == CStatusFiveHundredAndFiftySix || (response?[CJsonStatus] as? NSNumber) == CStatusFiveHundredAndFifty
        {
            PPAlerts .sharedAlerts().iOsAlert(title: "", withMessage: response?[CJsonMessage] as! String, withDelegate: nil)
        }
    }
    
    func isJSONDataValid(withResponse response: AnyObject!, key:String?) -> Bool
    {
        if !(response != nil)
        {
            return false
        }
        
        if (response is String) {
            if ((response as? String)?.count ?? 0) == 0 {
                return false
            }
        }
        if (response is [Any]) {
            if (response as? [Any])?.count == 0 {
                return false
            }
        }
        if (response is [AnyHashable: Any]) {
            if (response as? [AnyHashable: Any])?.count == 0 {
                return false
            }
            else if !(key?.blank())!
            {
                if (response.value(forKey: key!) is Array<Any>)
                {
                    if ((response.value(forKey: key!)) as? Array<Any>)?.count == 0
                    {
                        return false
                    }
                }
                else if (response.value(forKey: key!) is [AnyHashable: Any])
                {
                    if ((response.value(forKey: key!)) as? [AnyHashable: Any])?.count == 0
                    {
                        return false
                    }
                }
            }
        }
        return true
    }
    //MARK:- APIRequest Methods
    
    //TODO: LRF Flow
    func signUpWith(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        var json = [String : AnyObject] ()
        for (Key, value) in param {json.updateValue(value, forKey: Key)}
        
        json.updateValue((appDelegate.isArabic ? CLanguageArabic  : "en") as AnyObject, forKey: "lang_code")
        MILoader.shared.showLoader(type: .circularRing, message: "")
        _ = Networking.sharedInstance.POST(apiTag: CTagSignup, param: json , successBlock:
            { (task, response) in
                
                MILoader.shared.hideLoader()
                if self.isJSONDataValid(withResponse: response, key: CJsonData)
                {
                    self.saveLoginUserToLocal(response![CJsonData] as! [String:AnyObject])
                    
                    self.syncLocalWishListWith(param: [:], complition: { (response, error) in
                        
                        if error == nil
                        {
                            TBLWishlist.deleteAllObjects()
                        }
                        
                    })
                    
                    self.syncLocalCartListWith(param: [:], complition: { (response, error) in
                        
                        if error == nil
                        {
                            TBLCartlist.deleteAllObjects()
                        }
                        
                    })
                }
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                MILoader.shared.hideLoader()
                
                if error != nil
                {
                    complition?(nil,error)
                    
                }
                else
                {
                    CustomAlertView.iOSAlert("", withMessage: message!.replacingOccurrences(of: "Bad Request:", with: ""), withOkTitle: CMessageOk, onView:CTopMostViewController)
                }
        })
    }
    
    func loginWith(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        var json = [String : AnyObject] ()
        for (Key, value) in param {json.updateValue(value, forKey: Key)}
        
        json.updateValue((appDelegate.isArabic ? CLanguageArabic  : "en") as AnyObject, forKey: "lang_code")
        
        
        MILoader.shared.showLoader(type: .circularRing, message: "")
        _ = Networking.sharedInstance.POST(apiTag: CTagLogin, param: json , successBlock:
            { (task, response) in
                
                MILoader.shared.hideLoader()
                if self.isJSONDataValid(withResponse: response, key: CJsonData)
                {
                    self.saveLoginUserToLocal(response![CJsonData] as! [String:AnyObject])
                    
                    self.syncLocalWishListWith(param: [:], complition: { (response, error) in
                        
                        if error == nil
                        {
                            TBLWishlist.deleteAllObjects()
                        }
                        
                    })
                    
                    self.syncLocalCartListWith(param: [:], complition: { (response, error) in
                        
                        if error == nil
                        {
                            TBLCartlist.deleteAllObjects()
                        }
                        
                    })
                }
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                MILoader.shared.hideLoader()
                if error != nil
                {
                    complition?(nil,error)
                    
                }
                else
                {
                    CustomAlertView.iOSAlert("", withMessage: message!.replacingOccurrences(of: "Not Found:", with: ""), withOkTitle: CMessageOk, onView:CTopMostViewController)
                }
        })
    }
    
    func editProfileWith(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        var json = [String : AnyObject] ()
        for (Key, value) in param {json.updateValue(value, forKey: Key)}
        
        json.updateValue((appDelegate.isArabic ? CLanguageArabic  : "en") as AnyObject, forKey: "lang_code")
    
        MILoader.shared.showLoader(type: .circularRing, message: "")
        _ = Networking.sharedInstance.PUT(apiTag: CTagEditProfile+"/"+(appDelegate.loginUser?.user_id)!, param: json , successBlock:
            { (task, response) in
                
                MILoader.shared.hideLoader()
                if self.isJSONDataValid(withResponse: response, key: CJsonData)
                {
                    self.saveLoginUserToLocal(response![CJsonData] as! [String:AnyObject])
                }
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                MILoader.shared.hideLoader()
                if error != nil
                {
                    complition?(nil,error)
                    
                }
                else
                {
                    CustomAlertView.iOSAlert("", withMessage: message!, withOkTitle: CMessageOk, onView:CTopMostViewController)
                }
        })
    }
    func changePasswordWith(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        var json = [String : AnyObject] ()
        for (Key, value) in param {json.updateValue(value, forKey: Key)}
        
        json.updateValue((appDelegate.isArabic ? CLanguageArabic  : "en") as AnyObject, forKey: "lang_code")
        
        
        MILoader.shared.showLoader(type: .circularRing, message: "")
        _ = Networking.sharedInstance.POST(apiTag:  CTagChangePassword, param: json , successBlock:
            { (task, response) in
                
                MILoader.shared.hideLoader()
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                MILoader.shared.hideLoader()
                if error != nil
                {
                    complition?(nil,error)
                    
                }
                else
                {
                    CustomAlertView.iOSAlert("", withMessage: message!.replacingOccurrences(of: "Bad Request:", with: ""), withOkTitle: CMessageOk, onView:CTopMostViewController)
                }
        })
    }
    
    //TODO: General
    
    func getLanugages(param : [String: AnyObject], successCallBack: @escaping successCallBack, failureCallBack: @escaping failureCallBack)
    {
        
        _ = Networking.sharedInstance.GET(apiTag: CTagLanguage, param: nil, successBlock:
            { (task, response) in
                
        }, failureBlock:
            { (task, message, error) in
                
        })
    }
    
    func getCountriesList(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        let json = ["lang_code":appDelegate.isArabic ? CLanguageArabic  : "en"] as [String : AnyObject]
        
        _ = Networking.sharedInstance.GET(apiTag: CTagCountryList, param: json , successBlock:
            { (task, response) in
                
                if self.isJSONDataValid(withResponse: response, key: country)
                {
                    CUserDefaults.setValue(response![country] as Any, forKey: country)
                    CUserDefaults.synchronize()
                }
            
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                complition?(nil, error ?? NSError())
        })
        
    }
    //TODO: Other Flow
    func returnRequestWith(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        var json = [String : AnyObject] ()
        for (Key, value) in param {json.updateValue(value, forKey: Key)}
        
        json.updateValue((appDelegate.isArabic ? CLanguageArabic  : "en") as AnyObject, forKey: "lang_code")
        json.updateValue(CTagReturnRequest as AnyObject, forKey: "tag")
        
        
        MILoader.shared.showLoader(type: .circularRing, message: "")
        _ = Networking.sharedInstance.POST(apiTag: CTagCustomerService, param: json , successBlock:
            { (task, response) in
                
                MILoader.shared.hideLoader()
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                MILoader.shared.hideLoader()
                if error != nil
                {
                    complition?(nil,error)
                    
                }
                else
                {
                    CustomAlertView.iOSAlert("", withMessage: message!.replacingOccurrences(of: "Bad Request:", with: ""), withOkTitle: CMessageOk, onView:CTopMostViewController)
                }
        })
    }
    func serviceRequestWith(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        var json = [String : AnyObject] ()
        for (Key, value) in param {json.updateValue(value, forKey: Key)}
        
        json.updateValue((appDelegate.isArabic ? CLanguageArabic  : "en") as AnyObject, forKey: "lang_code")
        json.updateValue(CTagServiceRequest as AnyObject, forKey: "tag")
        
        
        MILoader.shared.showLoader(type: .circularRing, message: "")
        _ = Networking.sharedInstance.POST(apiTag: CTagCustomerService, param: json , successBlock:
            { (task, response) in
                
                MILoader.shared.hideLoader()
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                MILoader.shared.hideLoader()
                if error != nil
                {
                    complition?(nil,error)
                    
                }
                else
                {
                    CustomAlertView.iOSAlert("", withMessage: message!.replacingOccurrences(of: "Bad Request:", with: ""), withOkTitle: CMessageOk, onView:CTopMostViewController)
                }
        })
    }
    func quotationRequestWith(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        var json = [String : AnyObject] ()
        for (Key, value) in param {json.updateValue(value, forKey: Key)}
        
        json.updateValue((appDelegate.isArabic ? CLanguageArabic  : "en") as AnyObject, forKey: "lang_code")
        json.updateValue(CTagQuotationRequest as AnyObject, forKey: "tag")
        
        MILoader.shared.showLoader(type: .circularRing, message: "")
        _ = Networking.sharedInstance.POST(apiTag: CTagCustomerService, param: json , successBlock:
            { (task, response) in
                
                MILoader.shared.hideLoader()
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                MILoader.shared.hideLoader()
                if error != nil
                {
                    complition?(nil,error)
                    
                }
                else
                {
                    CustomAlertView.iOSAlert("", withMessage: message!.replacingOccurrences(of: "Bad Request:", with: ""), withOkTitle: CMessageOk, onView:CTopMostViewController)
                }
        })
    }
    
    func writeReviewWith(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        var json = [String : AnyObject] ()
        for (Key, value) in param {json.updateValue(value, forKey: Key)}
        
        json.updateValue((appDelegate.isArabic ? CLanguageArabic  : "en") as AnyObject, forKey: "lang_code")
        json.updateValue("P" as AnyObject, forKey: "object_type")
        
        
        MILoader.shared.showLoader(type: .circularRing, message: "")
        _ = Networking.sharedInstance.POST(apiTag:  CTagReview, param: json , successBlock:
            { (task, response) in
                
                MILoader.shared.hideLoader()
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                MILoader.shared.hideLoader()
                if error != nil
                {
                    complition?(nil,error)
                    
                }
                else
                {
                    CustomAlertView.iOSAlert("", withMessage: message!.replacingOccurrences(of: "Bad Request:", with: ""), withOkTitle: CMessageOk, onView:CTopMostViewController)
                }
        })
    }
    
    func getReview(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        let json = ["items_per_page":20,
                    "page":param.number(forJSON:"page"),
                    "sort_by":"timestamp",
                    "status":"A",
                    "lang_code":appDelegate.isArabic ? CLanguageArabic  : "en"] as [String : AnyObject]
    
        _ = Networking.sharedInstance.GET(apiTag: CTagProducts + "/" + param.string(forJSON: "product_id") + "/" + CTagReview, param: json , successBlock:
            { (task, response) in
                
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                complition?(nil, error ?? NSError())
        })
        
    }
    func getCategories(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        let json = ["items_per_page":1000,
                    "lang_code":appDelegate.isArabic ? CLanguageArabic  : "en" ,
                    "get_images":1,
                    "group_by_level":1] as [String : AnyObject]
        
        
        _ = Networking.sharedInstance.GET(apiTag: CTagCategories, param: json , successBlock:
            { (task, response) in
                
                if self.isJSONDataValid(withResponse: response, key: "categories")
                {
                    if param.keys.count > 0 && (param["isRemove"] as? Bool)!
                    {
                        TBLCategories.deleteAllObjects()
                    }
                    self.saveCategoriesInLocal(response!["categories"] as! Array)
                    
                    NotificationCenter.default.post(name: Notification.Name("ReloadPopularCategories"), object: nil)
                }
                complition?(response,nil)
                
        }, failureBlock:
        { (task, message, error) in
         
            complition?(nil,error)
        })
        
    }
    
    func getFeatures(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        let json = ["items_per_page":1000,
                    "lang_code":appDelegate.isArabic ? CLanguageArabic  : "en" ] as [String : AnyObject]
        
        
        _ = Networking.sharedInstance.GET(apiTag: CTagFeatures, param: json , successBlock:
            { (task, response) in
                
                if self.isJSONDataValid(withResponse: response, key: "features")
                {
                    if param.keys.count > 0 && (param["isRemove"] as? Bool)!
                    {
                        TBLFeatures.deleteAllObjects()
                    }
                    self.saveFeaturesInLocal(response!["features"] as! Array)
                }
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                complition?(nil,error)
        })
        
    }
    
    func getNewProducts(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        let json = ["items_per_page":20,
                    "page":param.number(forJSON:"page"),
                    "lang_code":appDelegate.isArabic ? CLanguageArabic  : "en" ,
                    "get_images":1,
                    "sort_order":"desc",
                    "sort_by":"timestamp",
                    "status":"A",
                    "dispatch":"products.newest",
                    "pshort":"Y",
                    "pfull":"Y",
                    "pname":"Y",
                    "features_hash":"brand name"] as [String : AnyObject]
        
        _ = Networking.sharedInstance.GET(apiTag: CTagProducts, param: json , successBlock:
            { (task, response) in
                
                complition?(response,nil)
                
                
        }, failureBlock:
            { (task, message, error) in
                
                complition?(nil,error)
        })
        
    }
    
    func getOfferProducts(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        let json = ["items_per_page":20,
                    "page":param.number(forJSON:"page"),
                    "lang_code":appDelegate.isArabic ? CLanguageArabic  : "en" ,
                    "get_images":1,
                    "sort_order":"desc",
                    "sort_by":"list_price",
                    "status":"A"] as [String : AnyObject]
        
        _ = Networking.sharedInstance.GET(apiTag: CTagProducts, param: json , successBlock:
            { (task, response) in
                
                complition?(response,nil)
                
                
        }, failureBlock:
            { (task, message, error) in
                
                complition?(nil,error)
        })
        
    }
    func getProductsDetails(param : [String: AnyObject], complition:ClosureCompletion?)
    {
//        let json = ["items_per_page":1,
//                    "lang_code":appDelegate.isArabic ? CLanguageArabic  : "en" ,
//                    "get_images":1,
//                    "status":"A",
//                    "product_id":param.string(forJSON: "product_id")] as [String : AnyObject]
        
        _ = Networking.sharedInstance.GET(apiTag: CTagProducts + "/" + param.string(forJSON: "product_id"), param: nil , successBlock:
            { (task, response) in
                
                complition?(response,nil)
                
                
        }, failureBlock:
            { (task, message, error) in
                
                complition?(nil,error)
        })
        
    }
    func searchProducts(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        let json = ["items_per_page":20,
                    "page":param.number(forJSON:"page"),
                    "lang_code":appDelegate.isArabic ? CLanguageArabic  : "en" ,
                    "get_images":1,
                    "status":"A",
                    "subcats":"Y",
                    "pcode_from_q":"Y",
                    "pshort":"Y",
                    "pfull":"Y",
                    "pname":"Y",
                    "pkeywords":"Y",
                    "search_performed":"Y",
                    "q":param.string(forJSON: "search"),
                    "dispatch":"products.search"] as [String : AnyObject]
        
        _ = Networking.sharedInstance.GET(apiTag: CTagProducts, param: json , successBlock:
            { (task, response) in
                
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                complition?(nil,error)
        })
        
    }
    func productListWithCategory(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        let json = ["items_per_page":20,
                    "page":param.number(forJSON:"page"),
                    "lang_code":appDelegate.isArabic ? CLanguageArabic  : "en" ,
                    "cid":param.number(forJSON:"catId"),
                    "subcats":"Y",
                    "get_images":1,
                    "status":"A",
                    "sort_order":param.string(forJSON: "sort_order"),
                    "sort_by":param.string(forJSON: "sort_by"),
                    "features_hash":param.string(forJSON: "features_hash")] as [String : AnyObject]
        _ = Networking.sharedInstance.GET(apiTag: CTagProducts, param: json , successBlock:
            { (task, response) in
                
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                complition?(nil,error)
        })
        
    }
    
    func addRemoveToWishlistWith(param : [String: AnyObject], isAddToWishlist:Bool, complition:ClosureCompletion?)
    {
        var json = [String : AnyObject] ()
     
        
        if  isAddToWishlist
        {
            //for (Key, value) in param {json.updateValue(value, forKey: Key)}
            
            //json.updateValue((appDelegate.isArabic ? CLanguageArabic  : "en") as AnyObject, forKey: "lang_code")
            json.updateValue(param["product_id"] as AnyObject, forKey: "product_id")
            json.updateValue(appDelegate.loginUser?.user_id as AnyObject, forKey: "user_id")
            json.updateValue("add" as AnyObject, forKey: "mode")
            json.updateValue("W" as AnyObject, forKey: "type")
            json.updateValue((appDelegate.isArabic ? CLanguageArabic  : "en") as AnyObject, forKey: "lang_code")
            
            _ = Networking.sharedInstance.POST(apiTag:  CTagAddToWishList, param: json , successBlock:
                { (task, response) in
                    
                    complition?(response,nil)
                    
            }, failureBlock:
                { (task, message, error) in
                    
                    complition?(nil,error)
                    
            })
            
        }
        else
        {
            //json.updateValue((appDelegate.isArabic ? CLanguageArabic  : "en") as AnyObject, forKey: "lang_code")
            json.updateValue(appDelegate.loginUser?.user_id as AnyObject, forKey: "user_id")
            json.updateValue("W" as AnyObject, forKey: "type")
            json.updateValue("delete" as AnyObject, forKey: "mode")
            json.updateValue((appDelegate.isArabic ? CLanguageArabic  : "en") as AnyObject, forKey: "lang_code")
            
            _ = Networking.sharedInstance.PUT(apiTag:  CTagAddToWishList + "/" + param.string(forJSON: "product_id"), param: json , successBlock:
                { (task, response) in
                    
                    complition?(response,nil)
                    
            }, failureBlock:
                { (task, message, error) in
                    
                    complition?(nil,error)
                    
            })
        }

        
    }
    
    func wishListWith(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        let json = [/*"items_per_page":20,
                    "page":param.number(forJSON:"page"),*/
                    "lang_code":appDelegate.isArabic ? CLanguageArabic  : "en" ,
                    /*"status":"A",*/
                    "type":"W",
                    "user_id":appDelegate.loginUser?.user_id as AnyObject] as [String : AnyObject]
        
        _ = Networking.sharedInstance.GET(apiTag: CTagAddToWishList, param: json , successBlock:
            { (task, response) in
                
                if APIRequest.shared().isJSONDataValid(withResponse: response, key: CTagProducts)
                {
                    self.saveWishlistInLocal(response![CTagProducts] as! Array)
                }
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                complition?(nil,error ?? NSError())
        })
        
    }
    
    
    func syncLocalWishListWith(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        var json = [String : AnyObject] ()
        let arrWishlist = TBLWishlist.fetchAllObjects() as! [TBLWishlist]
       
        var products = Array<Any>()
        
        for wishlist in arrWishlist
        {
            let dict:[String:Any] = ["product_id":wishlist.productId ?? "" , "amount":"0" , "isDeleted":((wishlist.details as? [String:Any])?["isDeleted"]) ?? "0"]
            
            products.append(dict)
        }
        
       if products.count == 0 { return }
        
        
        json.updateValue(products as AnyObject, forKey: "product")
        json.updateValue(appDelegate.loginUser?.user_id as AnyObject, forKey: "user_id")
        json.updateValue("synchronize" as AnyObject, forKey: "mode")
        json.updateValue("W" as AnyObject, forKey: "type")
        json.updateValue((appDelegate.isArabic ? CLanguageArabic  : "en") as AnyObject, forKey: "lang_code")
        
        _ = Networking.sharedInstance.POST(apiTag:  CTagAddToWishList, param: json , successBlock:
            { (task, response) in
                
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                complition?(nil,error)
                
        })
        
    }
    
    func addRemoveToCartWith(param : [String: AnyObject], isAddTocart:Bool, complition:ClosureCompletion?)
    {
        
        var json = [String : AnyObject] ()
        
        
        if  isAddTocart
        {
//            for (Key, value) in param {json.updateValue(value, forKey: Key)}
            
            json.updateValue(param["product_id"] as AnyObject, forKey: "product_id")
            json.updateValue(appDelegate.loginUser?.user_id as AnyObject, forKey: "user_id")
            json.updateValue("C" as AnyObject, forKey: "type")
            json.updateValue("add" as AnyObject, forKey: "mode")
            json.updateValue((appDelegate.isArabic ? CLanguageArabic  : "en") as AnyObject, forKey: "lang_code")
            _ = Networking.sharedInstance.POST(apiTag:  CTagAddToWishList, param: json , successBlock:
                { (task, response) in
                    
                    complition?(response,nil)
                    
            }, failureBlock:
                { (task, message, error) in
                    complition?(nil,error)
                    
            })
            
        }
        else
        {
            json.updateValue((appDelegate.isArabic ? CLanguageArabic  : "en") as AnyObject, forKey: "lang_code")
            json.updateValue(appDelegate.loginUser?.user_id as AnyObject, forKey: "user_id")
            json.updateValue("C" as AnyObject, forKey: "type")
            json.updateValue("delete" as AnyObject, forKey: "mode")
            
            _ = Networking.sharedInstance.PUT(apiTag:  CTagAddToWishList + "/" + param.string(forJSON: "product_id"), param: json , successBlock:
                { (task, response) in
                    
                    complition?(response,nil)
                    
            }, failureBlock:
                { (task, message, error) in
                    
                    complition?(nil,error)
                    
            })
        }
        
        
    }
    
    func updateQuantityToCartWith(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        
        var json = [String : AnyObject] ()
        
        //            for (Key, value) in param {json.updateValue(value, forKey: Key)}
        
        json.updateValue([param["product_id"]] as AnyObject, forKey: "product_id")
        json.updateValue(appDelegate.loginUser?.user_id as AnyObject, forKey: "user_id")
        json.updateValue("C" as AnyObject, forKey: "type")
        json.updateValue((appDelegate.isArabic ? CLanguageArabic  : "en") as AnyObject, forKey: "lang_code")
        json.updateValue("\(param["quantity"] ?? "0" as AnyObject)" as AnyObject, forKey: "quantity")
        json.updateValue("quantity" as AnyObject, forKey: "mode")
        
        _ = Networking.sharedInstance.PUT(apiTag:  CTagAddToWishList + "/" + param.string(forJSON: "product_id"), param: json , successBlock:
            { (task, response) in
                
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                complition?(nil,error)
                
        })
    }
    
    func cartListWith(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        let json = [/*"items_per_page":20,
             "page":param.number(forJSON:"page"),*/
             "lang_code":appDelegate.isArabic ? CLanguageArabic  : "en" ,
             /*"status":"A",*/
            "type":"C",
            "user_id":appDelegate.loginUser?.user_id as AnyObject] as [String : AnyObject]
        
        _ = Networking.sharedInstance.GET(apiTag: CTagAddToWishList, param: json , successBlock:
            { (task, response) in
                
                if APIRequest.shared().isJSONDataValid(withResponse: response, key: CTagProducts)
                {
                    self.saveCartlistInLocal(response![CTagProducts] as! Array)
                }
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                complition?(nil,error)
        })
        
    }
    
    func clearCart(complition:ClosureCompletion?)
    {
        var json = [String : AnyObject] ()
        
        json.updateValue(appDelegate.loginUser?.user_id as AnyObject, forKey: "user_id")
        json.updateValue("C" as AnyObject, forKey: "type")
        json.updateValue((appDelegate.isArabic ? CLanguageArabic  : "en") as AnyObject, forKey: "lang_code")
        json.updateValue("clear" as AnyObject, forKey: "mode")
        MILoader.shared.showLoader(type: .circularRing, message: "")
        _ = Networking.sharedInstance.PUT(apiTag:  (CTagAddToWishList + "/" + (appDelegate.loginUser?.user_id ?? "")), param: json , successBlock:
            { (task, response) in
                MILoader.shared.hideLoader()
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                MILoader.shared.hideLoader()
                complition?(nil,error)
                
        })
    }
    
    func syncLocalCartListWith(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        var json = [String : AnyObject] ()
        let arrCartlist = TBLCartlist.fetchAllObjects() as! [TBLCartlist]
        
        var products = Array<Any>()
        for cartlist in arrCartlist
        {
            let dict:[String:Any] = ["product_id":cartlist.productId ?? "" , "amount":((cartlist.details as? [String:Any])?["cart_quantity"]) ?? "0" , "isDeleted":((cartlist.details as? [String:Any])?["isDeleted"]) ?? "0"]
            
            products.append(dict)
        }
        
        if products.count == 0 { return }
        
        json.updateValue(products as AnyObject, forKey: "product")
        json.updateValue(appDelegate.loginUser?.user_id as AnyObject, forKey: "user_id")
        json.updateValue("synchronize" as AnyObject, forKey: "mode")
        json.updateValue("C" as AnyObject, forKey: "type")
        json.updateValue((appDelegate.isArabic ? CLanguageArabic  : "en") as AnyObject, forKey: "lang_code")
        
        _ = Networking.sharedInstance.POST(apiTag:  CTagAddToWishList, param: json , successBlock:
            { (task, response) in
                
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                complition?(nil,error)
                
        })
        
    }
    
    func bannerListWith(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        let json = ["type":param.string(forJSON: "type"),
                    "lang_code":appDelegate.isArabic ? CLanguageArabic  : "en"] as [String : AnyObject]
        
        _ = Networking.sharedInstance.GET(apiTag: CTagBannerList, param: json , successBlock:
            { (task, response) in
                
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                complition?(nil,error)
        })
        
    }
    
    
    
    func pages(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        let json = [/*"items_per_page":20,
             "page":param.number(forJSON:"page"),*/
             /*"status":"A",*/
            "lang_code":appDelegate.isArabic ? CLanguageArabic  : "en" ,
            "items_per_page":25,
            "user_id":appDelegate.loginUser?.user_id as AnyObject] as [String : AnyObject]
        
        _ = Networking.sharedInstance.GET(apiTag: CTagPages, param: json , successBlock:
            { (task, response) in
                
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                complition?(nil,error ?? NSError())
        })
        
    }
    
    func buyTogetherWith(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        let json = ["type":"buytogether",
                     "lang_code":appDelegate.isArabic ? CLanguageArabic  : "en" ,
                    "product_id":param.string(forJSON: "product_id")] as [String : AnyObject]
        
        _ = Networking.sharedInstance.GET(apiTag: CTagBuyTogether, param: json , successBlock:
            { (task, response) in
                
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                complition?(nil,error)
        })
        
    }
    func inTheBoxWith(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        let json = ["type":"html_block",
                     "lang_code":appDelegate.isArabic ? CLanguageArabic  : "en" ,
                    "product_id":param.string(forJSON: "product_id")] as [String : AnyObject]
        
        _ = Networking.sharedInstance.GET(apiTag: CTagBuyTogether, param: json , successBlock:
            { (task, response) in
                
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                complition?(nil,error)
        })
        
    }
    
    func loadFilterOptionWith(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        let json = ["category_id":param.string(forJSON: "category_id"),
                     "lang_code":appDelegate.isArabic ? CLanguageArabic  : "en"] as [String : AnyObject]
        
        _ = Networking.sharedInstance.GET(apiTag: CTagProductFilter, param: json , successBlock:
            { (task, response) in
                
                complition?(response,nil)
                
        }, failureBlock:
            { (task, message, error) in
                
                complition?(nil,error)
        })
        
    }
    
    func loadGooglePlaceDetails(param : [String: AnyObject], complition:ClosureCompletion?)
    {
        let json = ["key":CGooglePlaceApiKey,
                    "placeid":CGooglePlaceId] as [String : AnyObject]
        
        let uRequest = SessionSharedManager.shared().request("https://maps.googleapis.com/maps/api/place/details/json", method: .get, parameters: json, encoding: URLEncoding.default, headers: nil)
        Networking.sharedInstance.logging(request: uRequest)
        
        uRequest.responseJSON { (response) in
            
            Networking.sharedInstance.logging(response: response)
            if(response.result.error == nil && response.response?.statusCode == 200)
            {
                if(complition != nil)
                {
                    complition!(response.result.value as AnyObject, nil)
                }
            }
            else
            {
                if(complition != nil)
                {
                    complition!(nil,response.result.error as NSError?)
                }

            }
        }
        
    }
    
    

    
    //MARK:-
    //MARK:- Save in Local
    
    
    func saveCategoriesInLocal(_ arrCategories:Array<[String: AnyObject]>)
    {
        for cat in arrCategories
        {
            if cat.keys.contains("category_id")
            {
                let tblCat = TBLCategories.findOrCreate(dictionary:["category_id":cat.int(forJSON: "category_id")]) as! TBLCategories
                tblCat.category_id = cat.int16(forJSON: "category_id")
                tblCat.category = cat.string(forJSON: "category")
                tblCat.category_path = cat.string(forJSON:"category_path")
                tblCat.company_id = cat.int16(forJSON: "company_id")
                tblCat.has_children = cat.keys.contains("has_children") ? cat.int64(forJSON: "has_children") : 0
                tblCat.id_path = cat.string(forJSON: "id_path")
                tblCat.level =  cat.int16(forJSON: "level")
                tblCat.parent_id = cat.int16(forJSON: "parent_id")
                tblCat.position = cat.int16(forJSON: "position")
                tblCat.product_count = cat.int64(forJSON: "product_count")
                tblCat.seo_name = cat.string(forJSON:"seo_name")
                tblCat.seo_path = cat.string(forJSON:"seo_path")
                tblCat.status = cat.string(forJSON:"status")
                tblCat.isSelected = tblCat.isSelected  ?  true : false
                tblCat.main_pair = cat["main_pair"]
            }
        
        }
        
        CoreData.saveContext()
        
    }
    
    func saveFeaturesInLocal(_ arrFeature:Array<[String: AnyObject]>)
    {
        for featrue in arrFeature
        {
            if let tblFeature = TBLFeatures.findOrCreate(dictionary:["feature_id":featrue.int64(forJSON: "feature_id")]) as? TBLFeatures
            {
                tblFeature.feature_id = featrue.int64(forJSON:"feature_id")
                tblFeature.feature_type = featrue.string(forJSON:"feature_type")
                tblFeature.full_description = featrue.string(forJSON:"full_description")
                tblFeature.short_description = featrue.string(forJSON:"description")
                tblFeature.categories_path = featrue.string(forJSON:"categories_path")
                tblFeature.parent_id = featrue.int64(forJSON:"parent_id")
                tblFeature.position = featrue.int64(forJSON:"position")
                tblFeature.status = featrue.string(forJSON:"status")
                tblFeature.lang_code = featrue.string(forJSON:"lang_code")
                tblFeature.comparison = featrue.string(forJSON:"comparison")
            }
        }
        
        CoreData.saveContext()
        
    }
    
    func saveWishlistInLocal(_ arrWishlist:Array<[String: AnyObject]>)
    {
        TBLWishlist.deleteAllObjects()
        for product in arrWishlist
        {
            if let tblWishList = TBLWishlist.findOrCreate(dictionary: ["productId":product.string(forJSON: "product_id")]) as? TBLWishlist
            {
                tblWishList.productId = product.string(forJSON: "product_id")
                tblWishList.details = product as NSObject
            }
        }
        
        CoreData.saveContext()
        
    }
    
    func saveCartlistInLocal(_ arrCartlist:Array<[String: AnyObject]>)
    {
        TBLCartlist.deleteAllObjects()
        for product in arrCartlist
        {
            if let tblCartList = TBLCartlist.findOrCreate(dictionary: ["productId":product.string(forJSON: "product_id")]) as? TBLCartlist
            {
                tblCartList.productId = product.string(forJSON: "product_id")
                tblCartList.details = product as Any
            }
        }
        
        CoreData.saveContext()
        
    }
    
    func saveLoginUserToLocal(_ responseObject:[String: AnyObject])
    {
        appDelegate.loginUser = self.userWithDictionary(dictUser: responseObject)
        
        guard appDelegate.loginUser?.user_id != nil else {return}
        
        CUserDefaults.setValue(appDelegate.loginUser?.user_id, forKey: "user_id")
        CUserDefaults.synchronize()
    }
    
    func userWithDictionary(dictUser:[String:AnyObject]) -> TBLUser
    {
        
        let tblUser = TBLUser.findOrCreate(dictionary:["user_id":dictUser.string(forJSON:"user_id")]) as! TBLUser
      
        tblUser.user_id      = dictUser.string(forJSON: "user_id")
        tblUser.profile_id   = dictUser.string(forJSON: "profile_id")
        tblUser.firstname    = dictUser.string(forJSON: "firstname")
        tblUser.lastname     = dictUser.string(forJSON: "lastname")
        tblUser.s_firstname  = dictUser.string(forJSON: "s_firstname")
        tblUser.s_lastname   = dictUser.string(forJSON: "s_lastname")
        tblUser.email        = dictUser.string(forJSON: "email")
        tblUser.phone        = dictUser.string(forJSON: "phone")
        tblUser.s_phone      = dictUser.string(forJSON: "s_phone")
        tblUser.s_address    = dictUser.string(forJSON: "s_address")
        tblUser.s_country    = dictUser.string(forJSON: "s_country")
        tblUser.s_city       = dictUser.string(forJSON: "s_city")
        tblUser.country_name = countyList().filterValue(key: "code", value: dictUser.string(forJSON: "s_country"), getValueForKey: "name") as? String
        
        CoreData.saveContext()
        
        return tblUser
        
    }
}

class SessionSharedManager {
    
    private init() {}
    
    private static var sessionManager:SessionManager =  {
        let sessionManager = SessionManager()
        return sessionManager
    }()
    
    static func shared() -> SessionManager {
        return self.sessionManager
    }
    
}
*/
