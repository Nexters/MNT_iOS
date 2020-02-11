//
//  APISourceProtocol.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/10.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import RxAlamofire
import Alamofire

struct API {
    static let baseURL = "http://ec2-15-164-216-156.ap-northeast-2.compute.amazonaws.com:8888/api"
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
}

enum URLType: String {
    case missionList = "/mission/list"
}

// for case handling
//enum NetworkResult<T> {
//    case networkSuccess(T)
//    case networkError((resCode: Int, msg: String))
//    case networkFail
//}

protocol APISourceProtocol {
    // for SingleObject
    func requestDataObject<T: Codable, P: Any>(_ method: HTTPMethod,
                                               _ url: URLType,
                                               parameters: P?,
                                               encoding: ParameterEncoding,
                                               headers: [String: String]?,
                                               completion: ((T) -> Void)?) -> Disposable?
    // for Object Array
    func requestDataArray<T: Codable, P: Any>(_ method: HTTPMethod,
                                              _ url: URLType,
                                              parameters: P?,
                                              encoding: ParameterEncoding,
                                              headers: [String: String]?,
                                              completion: (([T]) -> Void)?) -> Disposable?
}


extension APISourceProtocol {
    /**
     RxAlamofire GET Method, NetworkResult에 따른 처리와 디코딩 작업
     
     - Parameters:
     - URL: Api endPoint
     - params: Query로 들어갈 파라미터 or Path
     - completion: NetworkResult reponse에 대한 결과 처리
     - Throws: If 'who' already dead, it throws some exception
     
     - Returns: Returns false if not available skill
     */
    
    func requestDataObject<T: Codable, P: Any>(_ method: HTTPMethod,
                                               _ url: URLType,
                                               parameters: P? = nil,
                                               encoding: ParameterEncoding = URLEncoding.default,
                                               headers: [String: String]? = nil, completion: ((T) -> Void)?) -> Disposable? {
        
        let params = (parameters is [String: Any]?) == true ? parameters : nil
        let path = parameters != nil && params == nil ? "/\(String(describing: parameters!))" : ""
        
        guard let encodedUrl = (API.baseURL+url.rawValue+path).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("networking - invalid url")
            return nil
        }
        
        return RxAlamofire.requestData(method,
                                       encodedUrl,
                                       parameters: params as? [String : Any],
                                       encoding: encoding,
                                       headers: headers)
            .mapObject(type: T.self)
            .subscribe(onNext: completion,
                       onError: { err in
                        // err handling
                        print("reqeustDatas Error : \(err)")
            },
                       onCompleted: {
                        // completion handling
            })
        
    }
    
    func requestDataArray<T: Codable, P: Any>(_ method: HTTPMethod,
                                              _ url: URLType,
                                              parameters: P? = nil,
                                              encoding: ParameterEncoding = URLEncoding.default,
                                              headers: [String: String]? = nil,
                                              completion: (([T]) -> Void)? = nil) -> Disposable? {
        
        let params = (parameters is [String: Any]?) == true ? parameters : nil
        let path = parameters != nil && params == nil ? "/\(String(describing: parameters!))" : ""
        
        guard let encodedUrl = (API.baseURL+url.rawValue+path).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("networking - invalid url")
            return nil
        }
        
        return RxAlamofire.requestData(method,
                                       encodedUrl,
                                       parameters: params as? [String : Any],
                                       encoding: encoding,
                                       headers: headers)
            .mapArray(type: T.self)
            .subscribe(onNext: completion,
                       onError: { err in
                        // err handling
                        print("reqeustDatas Error : \(err)")
            },
                       onCompleted: {
                        // completion handling
            })
    }
}


