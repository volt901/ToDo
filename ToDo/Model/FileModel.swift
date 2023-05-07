//
//  FileModel.swift
//  ToDo
//
//  Created by Владимир Ширяев on 05.05.2023.
//

import Foundation
import RealmSwift

class TaskLittel: Object,ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    // @Persisted var data: Date
    // отработать по дате
}

class Task: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var color: String
    @Persisted var image: String
    @Persisted var taskLittel: List<TaskLittel> = List<TaskLittel>()
    
    override class func primaryKey() -> String? {
        "id"
    }
}
