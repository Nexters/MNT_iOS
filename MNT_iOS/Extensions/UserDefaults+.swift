//
//  UserDefaults+.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/05/14.
//  Copyright © 2020 최민섭. All rights reserved.
//

extension UserDefaults {
    enum UserDefaultKeys: String {
        case user
        case manitto
    }
    
    func setObject<T: Codable>(object: T, key: UserDefaultKeys) {
        do {
            let data = try PropertyListEncoder().encode(object)
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: data)
            self.set(encodedData, forKey: key.rawValue)
        } catch {
            print(error.localizedDescription)
        }
        self.synchronize()
    }
    
    func getObject<T: Codable>(key: UserDefaultKeys) -> T? {
        guard let decoded  = self.data(forKey: key.rawValue) else {return nil}
        guard let data = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? Data else {return nil}
        
        do {
            let output = try PropertyListDecoder().decode(T.self, from: data)
            return output
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
}
