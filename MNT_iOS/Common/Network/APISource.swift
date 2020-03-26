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
                                    completion(res.data)
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

    // fail
    func postRoomMake(room: Room, userId: String, completion: @escaping (String) -> Void) -> Disposable? {
        let params = [
            "room" : room,
            "userId" : userId
        ] as [String: Any]
        
        print("second")

        return requestDataObject(.get,
                                 .roomMake,
                                 parameters: params) { (res: RoomStringResponseTest) in
                                    print("third - \(res.apiStatus.label)")
                                    completion(res.data)
        }
    }
    
    // fail
    func postSignUp(user: User) -> Disposable? {
        let params = [
            "user" : user
        ] as [String: Any]
        
        return requestWithoutData(.post,
                                  .signUp,
                                  parameters: params,
                                  encoding: JSONEncoding.default,
                                  completion: {})
    }
    
    // fail - requestDatas Error : keyNotFound(CodingKeys(stringValue: "apiStatus", intValue: nil)
    func deleteRoomUser(roomId: Int, userId: String, completion: @escaping (String?) -> Void) -> Disposable? {
        let params = [
            "roomId" : roomId,
            "userId" : userId
        ] as [String : Any]
        
        return requestDataObject(.delete,
                                 .roomUser,
                                 parameters: params) { (res: RoomStringResponse) in
                                    completion(res.data)
        }
    }
}
