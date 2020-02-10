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
    
    func getMissionList(roomId: Int, completion: @escaping ([Mission]) -> Void) -> Disposable? {        
        return requestDataObject(.get,
                    .missionList,
                    parameters: roomId) { (res: MissionListResponse) in
                        completion(res.data)
        }
    }
}
