//
//  AFNetWorkingServiceManager.swift
//  GoRN
//
//  Created by Vishnu on 11/09/18.
//  Copyright © 2018 Vishnu. All rights reserved.
//

import UIKit
import AFNetworking

private var serviceManager : AFNetWorkingServiceManager!

class AFNetWorkingServiceManager: NSObject {
    let manager                     = AFHTTPSessionManager()
    

      static var baseUrl : String     =  "http://127.0.0.1:3300/api/" // LOCAL
    

    
  
    //MARK:- Singleton
    
    class var sharedManager :AFNetWorkingServiceManager
    {
        if serviceManager == nil
        {
            serviceManager = AFNetWorkingServiceManager()
        }
        return serviceManager
    }
    
    func initWithManager() -> String {
        let url : NSURL = NSURL(string: "http://127.0.0.1:3300/api/")! //LOCAL
        
        let urlString : String = url.absoluteString!
        return urlString
    }
    
    
    //MARK:- GET
    
    func parseLinkUsingGetMethod(servicename:String,parameter:NSDictionary?,completion: @escaping (Bool,AnyObject?,NSError?) -> Void){
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: JSONSerialization.ReadingOptions.allowFragments)
        manager.responseSerializer.acceptableContentTypes = NSSet(objects:"application/json", "text/html") as? Set<String>
        var strUrl = self.initWithManager()
        
        manager.get(strUrl+servicename, parameters: parameter, progress: { (progress) in
            
        }, success: { (task, response) in
            completion(true, response as! NSDictionary?, nil)
        }) { (task, error) in
            completion(false, nil, error as NSError?)
        }
    }
    
    func parseUsingGetMethod(urlString:String,parameter:NSDictionary?,completion: @escaping (Bool,AnyObject?,NSError?) -> Void){
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: JSONSerialization.ReadingOptions.allowFragments)
        manager.responseSerializer.acceptableContentTypes = NSSet(objects:"application/json", "text/html") as? Set<String>
        let _ : String = self.initWithManager()
        manager.get(urlString, parameters: parameter, progress: { (progress) in
            
        }, success: { (task, response) in
            
            completion(true, response as! NSDictionary?, nil)
        }) { (task, error) in
            completion(false, nil, error as NSError?)
        }
    }
    //MARK:- POST
    
    func parseLinkUsingPostMethod(servicename:String,parameter:NSDictionary?,completion: @escaping (Bool?,AnyObject?,NSError?) -> Void){
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: JSONSerialization.ReadingOptions.allowFragments)
        manager.responseSerializer.acceptableContentTypes = NSSet(objects:"application/json","text/html","application/x-www-form-urlencoded","multipart/form-data") as? Set<String>
        /* let serializer = AFJSONRequestSerializer(writingOptions: .prettyPrinted)
         serializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
         serializer.setValue("application/json", forHTTPHeaderField: "Accept")
         AFNetWorkingServiceManager.sharedManager.manager.requestSerializer = serializer*/
        let strUrl : String = self.initWithManager()
        manager.post(strUrl+servicename, parameters: parameter, progress: nil, success: { (operation, responseObj) -> Void in
            
            completion(true, responseObj as! NSDictionary?, nil)
        }) { (operation, error) in
            completion(false, nil, error as NSError?)
        }
    }
    
    
    
    
    func parseLinkUsingPostMethod(service servicename : String,Parameter parameter :NSMutableDictionary?,withData data : NSData?, path: String, containerName : String ,completionBlock: @escaping (Bool?,Any?,Error?)-> Void , progressUpload :@escaping (Progress) -> Void)
    {
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: JSONSerialization.ReadingOptions.allowFragments)
        manager.responseSerializer.acceptableContentTypes = NSSet(objects:"application/json","text/html","application/x-www-form-urlencoded","multipart/form-data") as? Set<String>
        let strUrl : String = self.initWithManager()
        let mimeType = (path == "image") ? "image/jpeg" : "video/mp4"
        manager.post(strUrl + servicename, parameters: parameter, constructingBodyWith: { (formData) in
            formData.appendPart(withFileData: data! as Data, name:path, fileName: "\(containerName)/\(self.makeFileName(type: mimeType.components(separatedBy: "/")[1]))", mimeType:  mimeType)
        }, progress: { (progress) in
            progressUpload(progress)
        }, success: { (dataTask , resultObj ) in
            completionBlock(true, resultObj, nil)
        }) { (dataTask, error) in
            completionBlock(false, nil, error)
        }
    }
    
    func makeFileName(type : String) ->String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMddHHmmssSSS"
        let filename = dateFormatter.string(from: NSDate() as Date) as String
        
        return "\(filename).\(type)"
    }
}
