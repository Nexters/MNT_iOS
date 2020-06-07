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
        
        let params = [
            "roomId": missionSendingPostData.roomId,
            "userId": missionSendingPostData.userId,
            "missionId": missionSendingPostData.missionId,
            "content": missionSendingPostData.content,
        ] as [String: Any]
        
        guard
            let image = missionSendingPostData.img?.image,
            let fileName = missionSendingPostData.img?.fileName.absoluteString,
            let imgData = image.jpegData(compressionQuality: 0.2),
            let encodedUrl = (API.baseURL + URLType.missionSend.rawValue).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else {
                return  requestWithoutData(.post,
                                           .missionSend,
                                           parameters: params) { completion() }
        }
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "img",
                                     fileName: self.randomString(length: 7),
                                     mimeType: "image/jpg")
            
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: encodedUrl) { (res) in
            completion()
        }
        
        return nil
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func getRoomAttend(roomId: Int, userId: String, completion: @escaping (Room?) -> Void) -> Disposable? {
        let params = [
            "userId" : userId
        ] as [String: Any]
        
        return requestIntDataObject(.get,
                                 .roomAttend,
                                 parameters: params,
                                 path: roomId) { (res: RoomResponse) in
                                    if (res.apiStatus.httpStatus == 200) { completion(res.data!) }
                                    else { completion(nil) }
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
    
    func getRoomUserList(roomId: Int, completion: @escaping ([RoomCheck]) -> Void) -> Disposable? {
        let params : [String : Any] = [:]
        
        return requestIntDataObject(.get,
                                 .roomUserList,
                                 parameters: params,
                                 path: roomId) { (res : RoomCheckResponse) in
                                    completion(res.data ?? [])
        }
    }
    
    func getRoomStart(roomId: Int, completion: @escaping (String?) -> Void) -> Disposable? {
        let params : [String : Any] = [:]
        
        return requestIntDataObject(.get,
                                 .roomStart,
                                 parameters: params,
                                 path: roomId) { (res : RoomStringResponse) in
                                    completion(String(res.data ?? ""))
        }
    }
    
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
    
    func getDashboard(roomId: Int, userId: String, completion: @escaping (DashboardInfo) -> Void) -> Disposable? {
        let params = [
            "roomId": roomId,
            "userId": userId
        ] as [String : Any]
        
        return requestDataObject(.get,
                                 .dashboard,
                                 parameters: params) { (res: DashboardResponse) in
                                    completion(res.data)
        }
    }
}
