//
//  Migrator.swift
//  ToDo
//
//  Created by Владимир Ширяев on 07.05.2023.
//

import Foundation
import RealmSwift

class Migrator {
    init(){
        updateSchema()
    }
    
    func updateSchema(){
        let config = Realm.Configuration(schemaVersion: 1){ migrator, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                migrator.enumerateObjects(ofType: Task.className()){ _, newObject in
                    newObject!["taskLittel"] = List<TaskLittel>()
                }
            }
        }
        Realm.Configuration.defaultConfiguration = config
        let _ = try! Realm()
    }
}
