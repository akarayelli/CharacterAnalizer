//
//  NetworkManager.swift
//  TruecallerCharacterAnalyzer
//
//  Created by Alican Karayelli on 14.10.2017.
//  Copyright © 2017 Alican Karayelli. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private let url: String
    
    typealias NetworkHandler = (ResponseType) -> ()
    
    class var sharedInstance: NetworkManager {
        struct Singleton {
            static let instance : NetworkManager = NetworkManager(url: Constant.Network.WebsiteURL)
        }
        return Singleton.instance
    }
    
    private init(url: String) {
        self.url = url
    }
    

    /**
     Makes request to defined URL and gets content of URL as String. Returns source with the type of 'ResponseType'
     
     - parameter (ResponseType) : Callback function to return success or fail status
     
     - Returns: Void
     */
    public func request(completionCallBack: @escaping (ResponseType) -> Void) {
        var request = URLRequest(url: URL(string: self.url)!)
        request.cachePolicy = .reloadIgnoringCacheData
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
                        
            guard error == nil else{
                print(Constant.Log.ErrorPrefix, "HTTP error exists!")
                completionCallBack(ResponseType.failure(NetworkError.http))
                return
            }
            
            guard data != nil else{
                print(Constant.Log.ErrorPrefix, "NSData is invalid!")
                completionCallBack(ResponseType.failure(NetworkError.invalidData))
                return
            }
            
            if let remoteSiteSource = String(data: data!, encoding: .utf8) {
                print(Constant.Log.SuccessPrefix, "Data converted to string successfully...")
                completionCallBack(ResponseType.success(remoteSiteSource))
            }else{
                print(Constant.Log.ErrorPrefix, "Can not convert data to string!")
                completionCallBack(ResponseType.failure(GeneralError.programatic))
            }
        }
        task.resume()
    }
}

