//
//  DataBase.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 11.11.2020.
//  Copyright © 2020 Maxim Skorynin. All rights reserved.
//

import RealmSwift

final class Storage {
    
    var db: Realm?
    
    var dbPath: String? {
        return db?.configuration.fileURL?.deletingLastPathComponent().path
    }
    
    // MARK: - Life Cycle
    
    init() {
        do {
            self.db = try Realm()
            print("DB created at path: \(dbPath ?? "")")
        } catch {
            print("Couldn't init Realm data base. Error: \(error)")
        }
    }
    
    // MARK: - Private Functions (not used)
    
    private func setProtectionKey() {
        guard let folderDBPath = db?.configuration.fileURL!.deletingLastPathComponent().path else {
            print("Couldn't get Realm Data Base path")
            return
        }
        
        do {
            try FileManager.default.setAttributes([.protectionKey: false], ofItemAtPath: folderDBPath)
        } catch {
            print("Couldn't set protection key for Realm Data Base path. Error: \(error)")
        }
    }
    
}
