//
//  APISource.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/10.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import Alamofire

// MARK:- Singleton Object for Networking API
class APISource: APISourceProtocol {
    static let shared = APISource()
    private init() {}
    
    func getUserList(roomId: Int, completion: @escaping ([Participant]) -> Void) -> Disposable? {
        return requestDataObject(.get,
                                 .userList,
                                 parameters: roomId) { (res: UserListResponse) in
                                    completion(res.data)
        }
    }
    
    func getRoomAttend(roomId: Int, userId: String, completion: @escaping (Room) -> Void) -> Disposable? {
        let params = [
            "userId" : userId
        ] as [String: Any]
        
        return requestDataObject(.get,
                                 .roomAttend,
                                 parameters: params,
                                 path: roomId) { (res: RoomResponse) in
                                    print("label = \(res.apiStatus.label)")
                                    completion(res.data)
        }
    }
    
    func getRoomExistCheck(userId: String, completion: @escaping (Int) -> Void) -> Disposable? {
        let headers = [
            "userId" : userId
        ] as [String: String]
        
        let params : [String : Any] = [:]
        
        return requestDataObject(.get,
                                 .roomCheck,
                                 parameters: params,
                                 headers: headers) { (res: RoomCheckResponse) in
                                    completion(res.apiStatus.httpStatus)
        }
    }
    
    func getRoomCheck(userId: String, completion: @escaping ([RoomCheck]) -> Void) -> Disposable? {
        let params = [
            "userId" : userId
        ] as [String: Any]
        
        return requestDataObject(.get,
                                 .roomCheck,
                                 parameters: params) { (res: RoomCheckResponse) in
                                    completion(res.data)
        }
    }
    
    func postRoomMake(room: Room, userId: String, completion: @escaping (String) -> Void) -> Disposable? {
        let params = [
            "room" : room,
            "userId" : userId
        ] as [String: Any]

        return requestDataObject(.get,
                                 .userList,
                                 parameters: params) { (res: RoomStringResponse) in
                                    completion(res.data)
        }
    }
    
    func postSignUp(user: User) -> Disposable? {
        let params = [
            "user" : user
        ] as [String: Any]
        
        return requestWithoutData(.post,
                                  .signUp,
                                  parameters: params,
                                  completion: {})
    }
}
