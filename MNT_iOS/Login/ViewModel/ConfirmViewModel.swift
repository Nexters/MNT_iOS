//
//  ConfirmViewModel.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/13.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import Alamofire

class ConfirmViewModel: ViewModel {
    
    func presentMainAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = MainViewModel(title: "메인", coordinator: self.coordinator)
            let scene = MainScene.main(viewModel)
            
            self.requestMe()
            
            return self.coordinator.transition(to: scene, using: .root, animated: true).asObservable().map { _ in }
        }
    }
    
    func requestMe() {
        var user: User?
        
        KOSessionTask.userMeTask(completion: { (error, me) in
            if let error = error as NSError? {
                UIAlertController.showMessage(error.description)
            } else if let me = me as KOUserMe? {
//                let user = User(id: "43579",
//                                name: "name",
//                                profilePic: "string",
//                                fcmToken: "string")
//
//                // Prepare URL
//                let url = URL(string: "http://ec2-15-164-49-183.ap-northeast-2.compute.amazonaws.com:8888/api/user/sign-up")
//                guard let requestUrl = url else { fatalError() }
//
//                // Prepare URL Request Object
//                var request = URLRequest(url: requestUrl)
//                request.httpMethod = "POST"
//
//
//                // HTTP Request Parameters which will be sent in HTTP Request Body
//                let postString = "id=" + user.id + "&name=" + user.name + "&profilePic=" + user.profilePic + "&fcmToken=" + user.fcmToken;
//
//                // Set HTTP Request Body
//                request.httpBody = postString.data(using: String.Encoding.utf8);
//                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                
                
//                let params: [String:Any] = [
//                    "user" : [
//                        "id" : "67858",
//                        "fcmToken" : "string",
//                        "name" : "hide",
//                        "profilePic" : "string"
//                    ]
//                ]
//
//                let user = User(id: "43579",
//                                name: "name",
//                                profilePic: "string",
//                                fcmToken: "string")
//
//                let url = URL(string: "http://ec2-15-164-49-183.ap-northeast-2.compute.amazonaws.com:8888/api/user/sign-up")!
//                var request = URLRequest(url: url)
//                request.httpMethod = "POST"
//                request.httpBody = try! JSONSerialization.data(withJSONObject: params)
//                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//
//                Alamofire.request(request)
//                    .responseJSON {
//                        response in
//                        print("res : \(response)")
//                }
                
//                let jsonData = try JSONEncoder().encode(user)
//                request.httpBody = jsonData
                
                //
//
//                // insert json data to the request
//                request.httpBody = jsonData
//                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//                let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                    guard let data = data, error == nil else {
////                        print(error?.localizedDescription ?? "No data")
//                        return
//                    }
//                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//                    if let responseJSON = responseJSON as? [String: Any] {
////                        print(responseJSON)
//                    }
//                }
//
//                task.resume()
                
                // 400 나옴
//                Alamofire.request(url,
//                                  method: .post,
//                                  parameters: params,
//                                  encoding: URLEncoding.httpBody,
//                                  headers: [ "Content-Type": "application/json" ])
//                    .responseJSON {
//                        response in
//                        print("res : \(response)")
//                }
                
//                let url = "http://ec2-15-164-49-183.ap-northeast-2.compute.amazonaws.com:8888/api/user/sign-up"
//
//                var request = URLRequest(url: URL(string: url)!)
//                request.httpMethod = "POST"
//                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//                request.httpBody = try! JSONSerialization.data(withJSONObject: params)
//                Alamofire.request(request)
//                    .responseJSON {
//                        response in
//                        print("res : \(response)")
//                }
                
                // 아래 주석 해제할 때 삭제할 것
                user = User(id: "748078",
                            name: "name",
                            profilePic: "string",
                            fcmToken: "string")
                
                // 아래 주석 해제할 때 삭제할 것
                APISource.shared.postSignUp(user: user!,
                                            completion: {
                                                UserDefaults.standard.setObject(object: user!, key: .user)
                                                if let u: User = UserDefaults.standard.getObject(key: .user) {
                                                    print("UserDefaults에 저장되어있는 user 값 : \(u)")
                                                } else {
                                                    print("UserDefaults에 user가 저장되지 않음")
                                                }
                })
                
//                APISource.shared.postMissionSend(
//                    missionSendingPostData: viewModel.missionSendingPostData,
//                    completion: {
//                        viewModel.confirmAction()
//                })
                
//                user = User(id: me.id!,
//                            name: me.nickname!,
//                            profilePic: me.profileImageURL as? String ?? "string",
//                            fcmToken: "string")
                
//                APISource.shared.postSignUp(user: user!){
//                    print("testing : signUp")
//                    UserDefaults.standard.setObject(object: user!, key: .user)
//                }?.disposed(by: self.rx.disposeBag)
            } else {
                print("has no id")
            }
        })
    }
}
