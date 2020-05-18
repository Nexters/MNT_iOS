import Foundation
import Alamofire
import RxAlamofire

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
                                 .roomUserList,
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
        
        var params = [
            "roomId": missionSendingPostData.roomId,
            "userId": missionSendingPostData.userId,
            "missionId": missionSendingPostData.missionId,
            "content": missionSendingPostData.content,
        ] as [String: Any]
        
        if let image = missionSendingPostData.img {
            params["img"] = image
        }
        
        return requestWithoutData(.post,
                                  .missionSend,
                                  parameters: params) {
                                    completion()
        }
    }
    
    // success
    func getRoomAttend(roomId: Int, userId: String, completion: @escaping (Room) -> Void) -> Disposable? {
        let params = [
            "userId" : userId
        ] as [String: Any]
        
        return requestIntDataObject(.get,
                                 .roomAttend,
                                 parameters: params,
                                 path: roomId) { (res: RoomResponse) in
                                    print("response : \(res)")
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
    func getRoomCheck(userId: String, completion: @escaping ([RoomCheck]?) -> Void) -> Disposable? {
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
        
        return requestIntDataObject(.get,
                                 .roomUserList,
                                 parameters: params,
                                 path: roomId) { (res : RoomCheckResponse) in
                                    completion(res.data ?? [])
        }
    }
    
    // success
    func getRoomStart(roomId: Int, completion: @escaping (String?) -> Void) -> Disposable? {
        let params : [String : Any] = [:]
        
        return requestIntDataObject(.get,
                                 .roomStart,
                                 parameters: params,
                                 path: roomId) { (res : RoomStringResponse) in
                                    completion(String(res.data ?? ""))
        }
    }
    
    // success
    func postSignUp(user: User, completion: @escaping () -> Void) -> Disposable? {
        let params = [
            "fcmToken" : user.fcmToken,
            "id" : user.id,
            "name" : user.name,
            "profilePic" : user.profilePic
        ]

        return requestWithoutData(.post,
                                  .signUp,
                                  parameters: params,
                                  encoding: JSONEncoding.default,
                                  headers: ["Content-Type": "application/json; charset=utf-8"]) {
                                    completion()
        }
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
            "room" : ["endDay" : "2020-05-20",
                      "id" : 0,
                      "isDone" : 0,
                      "isStart" : 0,
                      "maxPeople" : 0,
                      "name" : "string",
                      "startDay" : "2020-05-20"
                ],
            "userId" : "645654"
            ] as [String: Any]
        
        return requestDataObject(.post,
                                 .roomMake,
                                 parameters: params) { (res: RoomStringResponse) in
                                    print("\(res)")
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
