//
//  Category.swift
//  ToDoey
//
//  Created by Mohamed Aboghali on 1/5/20.
//  Copyright © 2020 Mohamed Aboghali. All rights reserved.
//

import Foundation
import RealmSwift


class Category:Object {
    
    @objc dynamic var name:String = ""
    
    var items = List<Item>()
    
}
