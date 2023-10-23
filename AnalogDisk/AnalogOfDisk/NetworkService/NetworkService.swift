//
//  NetworkService.swift
//  AnalogOfDisk
//
//  Created by Ольга on 19.10.2023.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func updateRecentFiles(completion: @escaping([NetworkFilesItem]) -> ())
}

class NetworkService: NetworkServiceProtocol {
    let headers = HTTPHeaders(["Authorization" : "OAuth \(SessionStorage().accessToken ?? "")"])
    let url = "https://cloud-api.yandex.net/v1/disk/resources/last-uploaded"
    
    func updateRecentFiles(completion: @escaping([NetworkFilesItem]) -> ()) {
        AF.request(url, headers: headers).validate().responseDecodable(of: NetworkFiles.self) { response in
            guard let items = response.value else {
                completion([])
                return
            }
            completion(items.items)
        }
    }
    
    func deleteFile(path: String, completion: @escaping(() -> ())) {
        let url = "https://cloud-api.yandex.net/v1/disk/resources"
        let params: [String : String] = [
            "path": path
        ]
        AF.request(url, method: .delete, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: headers, interceptor: nil, requestModifier: nil)
            .validate(statusCode: 200 ..< 299).responseData { response in
                switch response.result {
                case .success(_):
                    completion()
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func shareLink(path: String, completion: @escaping((URL) -> Void)) {
        let url = "https://cloud-api.yandex.net/v1/disk/resources/publish"
        let params: [String : Any] = [
            "path": path
        ]
        
        AF.request(url, method: .put, parameters: params, encoding: URLEncoding.queryString, headers: headers).validate(statusCode: 200..<299).responseDecodable(of: Link.self) { response in
            switch response.result {
            case .success(let link):
                completion(link.link)
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    func renameFile(from: String, path: String, completion: @escaping(() -> ())) {
        let url = "https://cloud-api.yandex.net/v1/disk/resources/move"
        let params: [String : Any] = [
            "from": from,
            "path": path
        ]
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.queryString, headers: headers)
            .validate(statusCode: 200..<299).responseData { response in
                switch response.result {
                case .success(_):
                    completion()
                case .failure(let error):
                    print(error)
                }
            }
    }
}

