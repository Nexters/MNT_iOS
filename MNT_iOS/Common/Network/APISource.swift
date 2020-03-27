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
    
    func getTimeline(roomId: Int, completion: @escaping ([Mission]) -> Void) -> Disposable? {        
        return requestDataObject(.get,
                    .missionList,
                    parameters: roomId) { (res: MissionListResponse) in
                        completion(res.data)
        }
    }
    
    func getUserList(roomId: Int, completion: @escaping ([Participant]) -> Void) -> Disposable? {
        return requestDataObject(.get,
                                 .userList,
                                 parameters: roomId) { (res: UserListResponse) in
                                    completion(res.data)
        }
    }
    
    func getMyMissionDoneList(roomId: Int, userId: String, completion: @escaping ([Mission]) -> Void) -> Disposable? {
        let params = [
            "roomId": roomId
        ] as [String: Any]
        
        return requestDataObject(.get,
                                 .myMissionDoneList,
                                 parameters: params,
                                 path: userId) { (res: MissionListResponse) in
                                    completion(res.data)
        }
    }
    
    func getMissionDoneList(roomId: Int, completion: @escaping ([OrderMission]) -> Void) -> Disposable? {
        return requestDataObject(.get,
                                 .missionDoneList,
                                 parameters: roomId) { (res: OrderMissionResponse) in
                                    completion(res.data)
        }
    }
    
    func postMissionSend(missionSendingPostData: MissionSendingPostData, completion: @escaping () -> Void) -> Disposable? {
        let params = [
            "roomId": missionSendingPostData.roomId,
            "userId": missionSendingPostData.userId,
            "missionId": missionSendingPostData.missionId,
            "content": missionSendingPostData.content
            //"img": missionSendingPostData.img
        ] as [String: Any]
        
        return requestWithoutData(.post,
                                  .missionSend,
                                  parameters: params) {
                                    completion()
        }
    }
    
    func getRoomAttend(roomId: Int, userId: String, completion: @escaping ([Room]) -> Void) -> Disposable? {
        let params = [
            "roomId" : roomId,
            "userId" : userId
            ] as [String: Any]
        
        return requestDataObject(.get,
                                 .roomAttend,
                                 parameters: params) { (res: RoomAttendResponse) in
                                    completion([res.data])
        }
    }
}
