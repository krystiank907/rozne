//
//  RealmObjects.swift
//  empty
//
//  Created by Krystian Kulawiak on 16/04/2018.
//  Copyright © 2018 Krystian Kulawiak. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object{
    @objc dynamic var id: String? = nil
    @objc dynamic var name:String? = nil
    var age = RealmOptional<Int>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

extension User {
    func writeToRealm(){
        try! uiRealm.write{
            uiRealm.add(self, update: true)
        }
    }
    func delateall(){
        try! uiRealm.write{
            uiRealm.deleteAll()
        }
    }
}


class Model: Object{
    @objc dynamic var id: String? = nil
    @objc dynamic var text:String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
extension Model {
    func writeToRealm(){
        try! uiRealm.write{
            uiRealm.add(self, update: true)
        }
    }
    func delate(){
        try! uiRealm.write{
            uiRealm.delete(self)
        }
    }
    func delateall(){
        try! uiRealm.write{
            uiRealm.deleteAll()
        }
    }
}

class ListModel: Object{
    @objc dynamic var id: String? = nil
    let list = List<Model>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    func writeToRealm(){
        try! uiRealm.write{
            uiRealm.add(self, update: true)
        }
    }
    
}
