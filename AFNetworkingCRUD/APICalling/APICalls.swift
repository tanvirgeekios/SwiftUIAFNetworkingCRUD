//
//  APICalls.swift
//  AFNetworkingCRUD
//
//  Created by MD Tanvir Alam on 21/12/20.
//


import Foundation
import AFNetworking

class APICalls {
    
    static func getPosts(completion: @escaping (_ posts: [Post]?) -> Void)  {
        let urlString = EndPointSouce.getEndPoint(type: EndPoint.Base) + EndPointSouce.getEndPoint(type: EndPoint.Posts)
        guard let _ = URL(string: urlString) else { return}
        
        let manager = AFHTTPSessionManager.init(sessionConfiguration: .default)
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableStatusCodes = [200, 400, 401, 422]
        
        manager.get(urlString, parameters: nil, headers: EndPointSouce.basicHeaders, progress: nil) { (sessionTask, responseObject) in
            
            DispatchQueue.main.async {
                
                
                if let response = sessionTask.response as? HTTPURLResponse,let responseObject = responseObject, response.statusCode == 200{
                    do{
                        let jsonData = try? JSONSerialization.data(withJSONObject:responseObject)
                        if let jsonData = jsonData{
                            let responseData = try JSONDecoder().decode([Post].self, from: jsonData )
                            DispatchQueue.main.async {
                                //print(responseData)
                                completion(responseData)
                            }
                        }else{
                            print("JsonData is nil")
                        }
    
                    }catch{
                        print("Error In DoCach: \(error)")
                    }
                }else {
                    completion(nil)
                }
            }
            
        } failure: { (sessionTask, error) in
            DispatchQueue.main.async {
                print("Post API: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    
        static func createPost(param:[String:Any], completion: @escaping ( _ stausCode:Int?, _ post:Post?) -> Void)  {
            print(param)
            guard let url = URL(string: EndPointSouce.getEndPoint(type: EndPoint.Base)) else { return}
            let manager = AFHTTPSessionManager(baseURL: url, sessionConfiguration: URLSessionConfiguration.default)
            manager.requestSerializer = AFJSONRequestSerializer()
            manager.responseSerializer = AFJSONResponseSerializer()
            manager.responseSerializer.acceptableStatusCodes = [200,401, 406,201]
            manager.post(EndPointSouce.getEndPoint(type: EndPoint.Posts), parameters: param, headers: EndPointSouce.basicHeaders, progress: nil) { (sessionTask, responseObject) in
                DispatchQueue.main.async {
                   
                    if let response = sessionTask.response as? HTTPURLResponse {
                        let code = response.statusCode
    
                        if code == 201 {
                            do{
                                let jsonData = try? JSONSerialization.data(withJSONObject:responseObject!)
                                if let jsonData = jsonData{
                                    let responseData = try JSONDecoder().decode(Post.self, from: jsonData )
                                    DispatchQueue.main.async {
                                        //print(responseData)
                                        completion(code,responseData)
                                    }
                                }else{
                                    print("JsonData is nil")
                                    completion(code, nil)
                                }
            
                            }catch{
                                print("Error In DoCach: \(error)")
                                completion(code, nil)
                            }
                            
                        } else {
                            completion(code, nil)
                        }
                    }

                }
    
            } failure: { (sessionTask, error) in
                DispatchQueue.main.async {
                    print("Post failed: \(error.localizedDescription)")
                    if let response = sessionTask?.response as? HTTPURLResponse {
                        let code = response.statusCode
                        completion(code, nil)
                    }
                    
                }
            }
        }
    
    
    static func updatePost(param: [String:Any], completion: @escaping ( _ stausCode:Int?, _ post:Post?) -> Void)  {
            guard let url = URL(string: EndPointSouce.getEndPoint(type: EndPoint.Base)) else { return }
            let manager = AFHTTPSessionManager(baseURL: url, sessionConfiguration: URLSessionConfiguration.default)
            manager.requestSerializer = AFJSONRequestSerializer()
            manager.responseSerializer = AFJSONResponseSerializer()
        let updateURL = EndPointSouce.getEndPoint(type: EndPoint.SpecificPost(param["id"] as! Int))
            manager.put(updateURL, parameters: param, headers: EndPointSouce.basicHeaders) { (sessionTask, responseObject) in
                DispatchQueue.main.async {
                    
                    if let response = sessionTask.response as? HTTPURLResponse {
                        let code = response.statusCode
    
                        if code == 200 {
                            do{
                                let jsonData = try? JSONSerialization.data(withJSONObject:responseObject!)
                                if let jsonData = jsonData{
                                    let responseData = try JSONDecoder().decode(Post.self, from: jsonData )
                                    DispatchQueue.main.async {
                                        //print(responseData)
                                        completion(code,responseData)
                                    }
                                }else{
                                    print("JsonData is nil")
                                    completion(code, nil)
                                }
            
                            }catch{
                                print("Error In DoCach: \(error)")
                                completion(code, nil)
                            }
                            
                        } else {
                            completion(code, nil)
                        }
                    }

                }

            } failure: { (sessionTask, error) in
                DispatchQueue.main.async {
                    print("Update Post: \(error.localizedDescription)")
                }
            }
        }
    
    //Delete Post
    
    static func deletePost(param: [String:Any], completion: @escaping ( _ stausCode:Int?, _ post:Post?) -> Void)  {
            guard let url = URL(string: EndPointSouce.getEndPoint(type: EndPoint.Base)) else { return }
            let manager = AFHTTPSessionManager(baseURL: url, sessionConfiguration: URLSessionConfiguration.default)
            manager.requestSerializer = AFJSONRequestSerializer()
            manager.responseSerializer = AFJSONResponseSerializer()
        let deleteURL = EndPointSouce.getEndPoint(type: EndPoint.SpecificPost(param["id"] as! Int))
            manager.delete(deleteURL, parameters: param, headers: EndPointSouce.basicHeaders) { (sessionTask, responseObject) in
                DispatchQueue.main.async {
                    
                    if let response = sessionTask.response as? HTTPURLResponse {
                        let code = response.statusCode
    
                        if code == 200 {
                            do{
                                let jsonData = try? JSONSerialization.data(withJSONObject:responseObject!)
                                if let jsonData = jsonData{
                                    let responseData = try JSONDecoder().decode(Post.self, from: jsonData )
                                    DispatchQueue.main.async {
                                        //print(responseData)
                                        completion(code,responseData)
                                    }
                                }else{
                                    print("JsonData is nil")
                                    completion(code, nil)
                                }
            
                            }catch{
                                print("Error In DoCach: \(error)")
                                completion(code, nil)
                            }
                            
                        } else {
                            completion(code, nil)
                        }
                    }

                }

            } failure: { (sessionTask, error) in
                DispatchQueue.main.async {
                    print("delete Post: \(error.localizedDescription)")
                }
            }
        }
    
}
