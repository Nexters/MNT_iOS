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
    
    // success
    func getRoomAttend(roomId: Int, userId: String, completion: @escaping (Room) -> Void) -> Disposable? {
        let params = [
            "userId" : userId
        ] as [String: Any]
        
        return requestDataObject(.get,
                                 .roomAttend,
                                 parameters: params,
                                 path: roomId) { (res: RoomResponse) in
                                    print("status : \(res.apiStatus.label)")
                                    if (res.apiStatus.httpStatus == 200) {
                                        completion(res.data!)
                                    } else {
                                        print("제발")
                                    }
        }
    }
    
    // success
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
    
    // success
    func getRoomCheck(userId: String, completion: @escaping ([RoomCheck]) -> Void) -> Disposable? {
        let headers = [
            "userId" : userId
        ] as [String: String]
        
        let params : [String : Any] = [:]
        
        return requestDataObject(.get,
                                 .roomCheck,
                                 parameters: params,
                                 headers: headers) { (res: RoomCheckResponse) in
                                    completion(res.data)
        }
    }
    
    // success
    func getRoomUserList(roomId: Int, completion: @escaping ([RoomCheck]) -> Void) -> Disposable? {
        let params : [String : Any] = [:]
        
        return requestDataObject(.get,
                                 .roomUserList,
                                 parameters: params,
                                 path: roomId) { (res : RoomCheckResponse) in
                                    completion(res.data)
        }
    }
    
    // success
    func getRoomStart(roomId: Int, completion: @escaping (String?) -> Void) -> Disposable? {
        let params : [String : Any] = [:]
        
        return requestDataObject(.get,
                                 .roomStart,
                                 parameters: params,
                                 path: roomId) { (res : RoomStringResponse) in
                                    completion(String(res.data ?? ""))
        }
    }
    
    // success
    func postSignUp(user: User, completion: @escaping () -> Void) -> Disposable? {
        let params = [
            "user" : user
        ] as [String : Any]
        
        return requestWithoutData(.post,
                                  .signUp,
                                  parameters: params,
                                  completion: nil)
    }
    
    // success
    func deleteRoomUser(roomId: Int, userId: String, completion: @escaping () -> Void) -> Disposable? {
        let params = [
            "roomId" : roomId,
            "userId" : userId
        ] as [String : Any]
        
        return requestWithoutData(.delete,
                                  .roomUser,
                                  parameters: params,
                                  completion: nil)
    }

    // fail
    func postRoomMake(room: Room, userId: String, completion: @escaping (String) -> Void) -> Disposable? {
        let params = [
            "room" : room,
            "userId" : userId
        ] as [String: Any]
        
        return requestDataObject(.get,
                                 .roomMake,
                                 parameters: params) { (res: RoomStringResponse) in
                                    completion(res.data ?? "")
        }
    }
    
    func getUserManitto(roomId: Int, userId: String, completion: @escaping (Manitto) -> Void) -> Disposable? {
        let params = [
            "roomId" : roomId,
            "userId" : userId
        ] as [String : Any]
        
        return requestDataObject(.get,
                                 .userManitto,
                                 parameters: params) { (res: ManittoResponse) in
                                    completion(res.data)
        }
    }
}
