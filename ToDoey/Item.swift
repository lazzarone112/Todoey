//
//  Item.swift
//  ToDoey
//
//  Created by Mohamed Aboghali on 12/23/19.
//  Copyright © 2019 Mohamed Aboghali. All rights reserved.
//

import Foundation

class Item: Encodable,Decodable{
    var title :String = ""
    var done :Bool = false
}
