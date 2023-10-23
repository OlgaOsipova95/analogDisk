//
//  DataProvider.swift
//  AnalogOfDisk
//
//  Created by Дмитрий on 21.10.2023.
//

import Foundation
import Alamofire
import UIKit

class DataProvider {
    
    var filesCache = NSCache<NSString, NSData>()
    
    func downloadFile( id: String, url: URL, showProgress: @escaping (Float) -> Void, completion: @escaping (Data) -> Void) {
        
        if let pdfFile = self.filesCache.object(forKey: (id as NSString)) {
            completion(pdfFile as Data)
        } else {
            let request = AF.request(url, method: .get)
            request.downloadProgress(queue: .main) { progress in
                showProgress(Float(progress.fractionCompleted))
            }
            
            request.responseData { response in
                switch response.result {
                case .success(let data):
                    self.filesCache.setObject((data as NSData), forKey: (id as NSString))
                    completion(data)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
