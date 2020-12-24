//
//  HomeView.swift
//  AFNetworkingCRUD
//
//  Created by MD Tanvir Alam on 21/12/20.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("isDarkMood") private var isDarkMood = false
    @StateObject var getPostsVM = GetPostsViewModel()
    var body: some View {
        VStack(spacing: 10){
            Picker("Mood", selection: $isDarkMood) {
                Text("light").tag(false)
                Text("Dark").tag(true)
            }.pickerStyle(SegmentedPickerStyle())
            .padding()
            .padding(.top,60)
            
            Text("This is an AFNetworking App")
                .foregroundColor(Color.MyTheme.fontColor)
            
                Button(action: {
                    getPostsVM.getPosts()
                }, label: {
                    Text("Get Posts")
                        .padding()
                        .background(Color.MyTheme.fontColor)
                        .cornerRadius(10)
                })
            ScrollView(){
                VStack{
                    ForEach(getPostsVM.posts){ post in
                        Text(post.title)
                    }
                }
            }
            
            
            Section(header: Text("Create Post")) {
                TextField("Id only for update and delete", text: $getPostsVM.id)
                TextField("userId", text: $getPostsVM.userId)
                TextField("Title", text: $getPostsVM.title)
                TextField("Body", text: $getPostsVM.body)

                Button(action: {
                    getPostsVM.createPost()
                }, label: {
                    Text("Create")
                        .padding()
                        .background(Color.MyTheme.fontColor)
                        .cornerRadius(10)
                })
                Button(action: {
                    getPostsVM.updatePost()
                }, label: {
                    Text("Update")
                        .padding()
                        .background(Color.MyTheme.fontColor)
                        .cornerRadius(10)
                })
                Button(action: {
                    getPostsVM.deletePost()
                }, label: {
                    Text("Delete")
                        .padding()
                        .background(Color.MyTheme.fontColor)
                        .cornerRadius(10)
                })
            }.padding()
            Spacer()
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.MyTheme.backGroundColor)
        .navigationBarHidden(true)
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }

}
