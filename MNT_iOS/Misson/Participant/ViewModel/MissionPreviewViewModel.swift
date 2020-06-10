//
//  MissionPreviewViewModel.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/03/25.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class MissionPreviewViewModel: ViewModel {
    let missionSendingData: MissionSendingData
    let imageData: UploadableImage?
    var missionSendingPostData: MissionSendingPostData {
        var data = missionSendingData.asMissionSendPostData
        data.img = imageData
        return data
    }
    
    init(missionSendingData: MissionSendingData, imageData: UploadableImage?, coordinator: SceneCoordinatorType) {
        self.missionSendingData = missionSendingData
        self.imageData = imageData
        super.init(title: "", coordinator: coordinator)
    }
    
    func confirmAction() {
        let alertVC = FruttoAlert1ViewController()
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.setTitleLabel(text: "이름을 입력해주세요.")
        alertVC.onConfirm = { [unowned self] in
            NotificationCenter.default.post(
                name: .init("MissionPosted"),
                object: nil)
            self.coordinator.transition(using: .popToRoot)
        }
        
        UIApplication.topViewController()?.present(alertVC, animated: true, completion: nil)
    }
    
    //
//    fileprivate func uploadImage(completion: @escaping () -> Void) {
//
//        guard let imageData = imageData else { return }
//
////        let paramName = imageData.paramName
//        let fileName = imageData.fileName
//        let image = imageData.image
//
//        let url = URL(string: "http://api-host-name/v1/api/uploadfile/single")
//
//        // generate boundary string using a unique per-app string
//        let boundary = UUID().uuidString
//
//        let session = URLSession.shared
//
//        // Set the URLRequest to POST and to the specified URL
//        var urlRequest = URLRequest(url: url!)
//        urlRequest.httpMethod = "POST"
//
//        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
//        // And the boundary is also set here
//        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//        var data = Data()
//
//        // Add the image data to the raw http request data
//        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//        data.append("Content-Disposition: form-data; name=\"\(fileName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
//        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
//        data.append(image.pngData()!)
//
//        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//
//        // Send a POST request to the URL, with the data we created earlier
//        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
//            if error == nil {
//                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
//                if let json = jsonData as? [String: Any] {
//                    completion()
//                }
//            }
//        }).resume()
//    }
}
