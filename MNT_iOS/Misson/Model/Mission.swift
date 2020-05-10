//
//  Mission.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

struct MissionListResponse: Codable {
    let apiStatus: APIStatus
    var data: [Mission] = []
}

struct Mission: Codable {
    var isAbleImg: Int = 0
    var manitto: Manitto? = nil
    var missionId: Int = 0
    var missionName: String? = nil
    var userFruttoId: Int? = nil
    var userMission: UserMission = UserMission()
}

struct UserMission: Codable {
    var content: String? = nil
//    var missionId: MissionId = MissionId()
//    var missionImg: AnyObject? = nil
    var missionImg: String? = nil
    var roomId: Int = 0
    var userDone: Int? = nil
    var userDoneTime: String? = nil
    var userId: UserId = UserId()
//    var userMissions: [UserMissions] = []
}

struct MissionSendingData {
    var mission: Mission
    var content: String = ""
    var asMissionSendPostData: MissionSendingPostData {
        return MissionSendingPostData(roomId: mission.userMission.roomId,
                                      userId: mission.userMission.userId.id,
                                      missionId: mission.missionId,
                                      content: content)
    }
}

struct MissionSendingPostData {
    var roomId: CLong
    var userId: String
    var missionId: CLong
    var content: String
    var img: UploadableImage? = nil
}

struct Manitto: Codable {
    var id: String = ""
    var fruttoId: Int = 0
    var name: String = ""
}

struct MissionId: Codable {
    var isAbleImg: Int = 0
    var name: String = ""
    var roodId: Int = 0
    var userMissions: [UserMissions] = []
}

struct UserMissions: Codable {
    var manitto: Manitto? = nil
    var missionId: Int = 0
    var missionName: String = ""
    var userFruttoId: Int = 0
    var userMission: UserMission = UserMission()
}

struct UserId: Codable {
    var id: String = ""
    var name: String = ""
    var profilePic: String = ""
    var fcmToken: String = ""
}
