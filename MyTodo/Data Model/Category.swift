//
//  Category.swift
//  MyTodo
//
//  Created by Pankaj Kulkarni on 09/03/18.
//  Copyright © 2018 Pankaj Kulkarni. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
}
