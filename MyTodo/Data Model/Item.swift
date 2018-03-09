//
//  Item.swift
//  MyTodo
//
//  Created by Pankaj Kulkarni on 09/03/18.
//  Copyright © 2018 Pankaj Kulkarni. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
