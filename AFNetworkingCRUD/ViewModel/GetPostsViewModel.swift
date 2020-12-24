//
//  GetPostViewModel.swift
//  AFNetworkingCRUD
//
//  Created by MD Tanvir Alam on 21/12/20.
//

import Foundation

class GetPostsViewModel:ObservableObject{
    //@Published var posts = PostModel(dictionary: [String : Any]?)
    @Published var posts = [postViewModel]()
    @Published var userId = ""
    @Published var body = ""
    @Published var title = ""
    @Published var id = ""
    
    func getPosts(){
        APICalls.getPosts() { posts in
            if let posts = posts{
                posts.forEach { (post) in
                    self.posts.append(postViewModel.init(post: post))
                }
            }else{
                print("Something is wrong")
            }
        }
    }
    func createPost(){
        let params:[String:Any] = [
            "title":self.title,
            "body":self.body,
            "userId":Int(self.userId) ?? 0
        ]
        APICalls.createPost(param: params) { code, posts  in
            if let posts = posts{
               debugPrint("Success: \(posts)")
                debugPrint("code: \(code!)")
            }else{
                print("Something is wrong")
                debugPrint("code: \(code!)")
            }
        }
     }
    
    func updatePost(){
        let params:[String:Any] = [
            "id":Int(self.id)!,
            "title":self.title,
            "body":self.body,
            "userId":Int(self.userId) ?? 0
        ]
        APICalls.updatePost(param: params) { code, posts  in
            if let posts = posts{
               debugPrint("Success: \(posts)")
                debugPrint("code: \(code!)")
            }else{
                print("Something is wrong")
                debugPrint("code: \(code!)")
            }
        }
    }
    
    func deletePost(){
        let params:[String:Any] = [
            "id":Int(self.id)!,
        ]
        APICalls.deletePost(param: params) { code, posts  in
            if let posts = posts{
               debugPrint("Success: \(posts)")
                debugPrint("code: \(code!)")
            }else{
                print("Something is wrong")
                debugPrint("code: \(code!)")
            }
        }
    }
}

class postViewModel:Identifiable{
    var id = UUID()
    var post:Post
    init(post:Post){
        self.post = post
    }
    var body:String {
        return self.post.body
    }
    
    var title: String{
        return self.post.title
    }
    var userId:String{
        return String(self.post.userId)
    }
}
