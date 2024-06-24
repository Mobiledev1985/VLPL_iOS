//
//  APIManager.swift
//  iOS-sample-ii
//
//  Created by Parth iOS  on 12/7/2023.
//

import UIKit

let HTTP_URL = "www.google.com"
let BASE_URL = HTTP_URL + "api/"

class APIManager {
    
    private init() {
        
    }
    
    static let sharedManager = APIManager()
    
    var authToken: String = ""
    
    var user: UserDetails? {
        willSet {

        }
    }
    
    // User Authentication API End Points
    
    let GET_CART_PRODUCTS = BASE_URL + "cart"
    
    // MARK: -  GET | POST | PUT | DELETE Data
    func getData<T: Decodable>(url: String, parameters: Dictionary<String, Any>?, completion:@escaping (T?, Error?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            self.callData(URL: url, PARAMS: parameters, METHOD_TYPE: "GET", COMPLETION: completion)
        }
    }
    
    func postData<T: Decodable>(url: String, parameters: Dictionary<String, Any>?, completion:@escaping (T?, Error?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            self.callData(URL: url, PARAMS: parameters, METHOD_TYPE: "POST", COMPLETION: completion)
        }
    }
    
    func putData<T: Decodable>(url: String, parameters: Dictionary<String, Any>?, methodType: String, completion:@escaping (T?, Error?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            self.callData(URL: url, PARAMS: parameters, METHOD_TYPE: "PUT", COMPLETION: completion)
        }
    }
    
    func deleteData<T: Decodable>(url: String, parameters: Dictionary<String, Any>?, completion:@escaping (T?, Error?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            self.callData(URL: url, PARAMS: parameters, METHOD_TYPE: "DELETE", COMPLETION: completion)
        }
    }
    
    func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    fileprivate func callData<T: Decodable>(URL url: String, PARAMS parameters: Dictionary<String, Any>?, METHOD_TYPE methodType: String, COMPLETION completion: @escaping (T?, Error?) -> ()) {
        let url1 = URL(string: url)
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        
        var request = URLRequest(url: url1!)
        request.httpMethod = methodType
        request.timeoutInterval = 60
        request.addValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + (UserDefaults.standard.string(forKey: UserDefaultType.accessToken) ?? ""), forHTTPHeaderField: "Authorization")
        print("ACCESS TOKEN:::==>\(UserDefaults.standard.string(forKey: UserDefaultType.accessToken) ?? "")")
        request.cachePolicy = .reloadIgnoringCacheData
        
        if parameters != nil {
            let params = self.getPostString(params: parameters!)
            request.httpBody = params.data(using: .utf8)
        }
        
//        if methodType != "GET" {
//            if params != nil {
//                let theJSONData = try? JSONSerialization.data(withJSONObject: params!, options: JSONSerialization.WritingOptions.init(rawValue: 0))
//
//                let JsonString = String.init(data: theJSONData!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
//
//                print("json : \(JsonString!)")
//                request.httpBody = JsonString!.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion:true)
//            }
//        }
        
        let task = session.dataTask(with: request, completionHandler:{
            (data, response, error) in
            if error == nil {
                guard let data = data else { return }
                do {
                    let jsonDecoder = JSONDecoder()
                    let dataReceived = try jsonDecoder.decode(T.self, from: data)
                    completion(dataReceived, error)
                } catch let jsonErr {
                    completion(nil, jsonErr)
                }
            } else {
                completion( nil,error)
            }
        })
        task.resume()
    }
    
    
    typealias completionBlock = (Bool, Dictionary<String, Any>?, String?) -> Void
    
    ///type: String, id: Int
    func uploadImageOrVideo<T: Decodable>(url: String, fileName: [String], files: [Any]?, image: [UIImage]?, movieDataURL: URL?, params: Dictionary<String, Any>?, COMPLETION completion: @escaping (T?, Error?) -> ()) {
        let boundary = UUID().uuidString
        let session = URLSession.shared
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (UserDefaults.standard.string(forKey: UserDefaultType.accessToken) ?? ""), forHTTPHeaderField: "Authorization")
        var data = Data()
        
        if params != nil {
            print("Parameter--------------------")
            for (key, value) in params! {
                print("Key: \(key), value: \(value) ")
                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                data.append("Content-Disposition: form-data; name=\"\("\(key)")\"\r\n\r\n".data(using: .utf8)!)
                if let value = value as? String {
                    data.append("\(value)".data(using: .utf8)!)
                } else {
                    data.append("\(value as! Int)".data(using: .utf8)!)
                }
            }
        }
        
        var index = 0
        for file in files! {
            if let tmpFile = file as? UIImage {
                let mimetype = "image/\(tmpFile.pngData()?.format ?? "png")"
                
                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                data.append("Content-Disposition: form-data; name=\"\(fileName[index])\"; filename=\"image\(index).png\"\r\n".data(using: .utf8)!)
                data.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
                data.append(tmpFile.pngData()!)
                data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            }else {
                (file as! URL).startAccessingSecurityScopedResource()
                let mimetype = (file as! URL).mimeType()
                
                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                data.append("Content-Disposition: form-data; name=\"\(fileName[index])\"; filename=\"\((file as! URL).lastPathComponent)\"\r\n".data(using: .utf8)!)
                data.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
                do {
                    data.append(try Data(contentsOf: file as! URL))
                } catch {
                    print(error.localizedDescription)
                }
                data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
                (file as! URL).stopAccessingSecurityScopedResource()
            }
            index += 1
        }
        
        session.uploadTask(with: urlRequest, from: data, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                
                if error == nil {
                    guard let data = data else { return }
                    do {
                        let jsonDecoder = JSONDecoder()
                        let dataReceived = try jsonDecoder.decode(T.self, from: data)
                        completion(dataReceived, error)
                    } catch let jsonErr {
                        completion(nil, jsonErr)
                    }
                } else {
                    completion( nil,error)
                }
            }
        }).resume()
    }
}
