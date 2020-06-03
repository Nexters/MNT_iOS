//
//  UserDefaults+.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/05/14.
//  Copyright © 2020 최민섭. All rights reserved.
//

extension UserDefaults {
    enum UserDefaultKeys: String {
        case user // struct User
        case manitto // struct Manitto
        case room // struct Room
        case userFruttoId // userFruttoId: Int
        case socialLogin // socialLogin: String
        case appleUserId
        case appleUserName
        case fcmToken
    }
    
    func setObject<T: Codable>(object: T, key: UserDefaultKeys) {
        do {
            let data = try PropertyListEncoder().encode(object)
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: data)
            self.set(encodedData, forKey: key.rawValue)
        } catch {
            print("Error setObject : \(error.localizedDescription)")
        }
        self.synchronize()
    }
    
    func setIntValue(value: Int, key: UserDefaultKeys) {
        self.set(value, forKey: key.rawValue)
        
        self.synchronize()
    }
    
    func setStringValue(value: String, key: UserDefaultKeys) {
        self.set(value, forKey: key.rawValue)
        
        self.synchronize()
    }
    
    func getObject<T: Codable>(key: UserDefaultKeys) -> T? {
        guard let decodedData  = self.data(forKey: key.rawValue) else {return nil}
        guard let data = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? Data else {return nil}
        
        do {
            let output = try PropertyListDecoder().decode(T.self, from: data)
            return output
        } catch {
            print("Error getObject : \(error.localizedDescription)")
        }
        
        return nil
    }
    
    func getIntValue(key: UserDefaultKeys) -> Int {
        let output = self.value(forKey: key.rawValue) as? Int ?? 0
        
        return output
    }
    
    func getStringValue(key: UserDefaultKeys) -> String? {
        let output = self.value(forKey: key.rawValue) as? String
        
        return output
    }
}
