//
//  RealMDBManager.swift
//  Sippy
//
//  Created by Syed Kashan on 10/17/19.
//  Copyright (c) 2019 Syed Kashan. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import Swinject
import RealmSwift

typealias RDBM = RealMDBManager

protocol IRealMDBManager: class {
	// do someting...
}

class RealMDBManager: IRealMDBManager {
      static let shared = RealMDBManager()
    
     var realm: Realm!
     
     private init() {
         var config = Realm.Configuration(
             // Set the new schema version. This must be greater than the previously used
             // version (if you've never set a schema version before, the version is 0).
             schemaVersion: GETSCHEMAVERSION(),
             
             // Set the block which will be called automatically when opening a Realm with
             // a schema version lower than the one set above
             migrationBlock: { migration, oldSchemaVersion in
                 // We haven’t migrated anything yet, so oldSchemaVersion == 0
                 if oldSchemaVersion < GETSCHEMAVERSION() {
                     // Nothing to do!
                     // Realm will automatically detect new properties and removed properties
                     // And will update theƒ schema on disk automatically
                     printHydd("OldSchema is selected \(migration)")
                     //                    migration.enumerateObjects(ofType: Product_RModel.className()) { oldObject, newObject in
                     //                        // combine name fields into a single field
                     //                        newObject!["atest"] = "Thi is from old DB"
                     //                    }
                   
                     }
         })
         config.encryptionKey = getKey() as Data
         
         // Tell Realm to use this new configuration object for the default Realm
         Realm.Configuration.defaultConfiguration = config
         
         do {
                self.realm = try Realm()
             } catch let error as NSError {
                 // handle error
                 printHydd(error.debugDescription)
                    _ = try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
                  Realm.Configuration.defaultConfiguration = config
                  self.realm = try! Realm()
             }
         
     }
     
     func getKey() -> NSData {
         // Identifier for our keychain entry - should be unique for your application
         let keychainIdentifier = "com.hydd.driver.keychain.realm"

         let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
         
         // First check in the keychain for an existing key
         var query: [NSString: AnyObject] = [
             kSecClass: kSecClassKey,
             kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
             kSecAttrKeySizeInBits: 512 as AnyObject,
             kSecReturnData: true as AnyObject
         ]
         
         // To avoid Swift optimization bug, should use withUnsafeMutablePointer() function to retrieve the keychain item
         // See also: http://stackoverflow.com/questions/24145838/querying-ios-keychain-using-swift/27721328#27721328
         var dataTypeRef: AnyObject?
         var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
         if status == errSecSuccess {
            guard let data_ref =  dataTypeRef as? NSData else {
                return NSData()
            }
             return data_ref
         }
         // No pre-existing key from this application, so generate a new one
         let keyData = NSMutableData(length: 64)!
         let result = SecRandomCopyBytes(kSecRandomDefault, 64, keyData.mutableBytes.bindMemory(to: UInt8.self, capacity: 64))
         assert(result == 0, "Failed to get random bytes")
         
         // Store the key in the keychain
         query = [
             kSecClass: kSecClassKey,
             kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
             kSecAttrKeySizeInBits: 512 as AnyObject,
             kSecValueData: keyData
         ]
         
         status = SecItemAdd(query as CFDictionary, nil)
         assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
         
         return keyData
     }
     
     //Search Object
     class func saveObject(object: Object) {
         let realm = try! Realm()
         try! realm.write {
             realm.add(object)
         }
     }
     
     class func deleteObject(object: Object) {
         let realm = try! Realm()
         try! realm.write {
             realm.delete(object)
         }
     }
   
    func getAll<T: Object>(with type: T.Type) throws -> Results<T> {
        let realm = try! Realm()
        return realm.objects(T.self)
    }
    
    func Save<T: Object>(item: T) {
         let realm = try! Realm()
         try! realm.write {
             realm.add(item)
         }
     }
    func delete<T: Object>(item: T) {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(item)
            }
     }
    func deleteALLObject<T: Object>(with type: T.Type) {
         let realm = try! Realm()
          let items = realm.objects(T.self)
            try! realm.write {
               realm.delete(items)
            }
    }
    func deleteALL() {
       let realm = try! Realm()
       try! realm.write {
           realm.deleteAll()
       }
    }
    func updateClientStatus(status: String) {
        let realm = try! Realm()
        if let client = realm.objects(ClientModel.self).first {
            try! realm.write {
                client.status = status
            }
        }
    }
}
