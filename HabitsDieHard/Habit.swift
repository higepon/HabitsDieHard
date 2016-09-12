//
//  Habit.swift
//  HabitsDieHard
//
//  Created by Taro Minowa on 8/20/16.
//  Copyright © 2016 Higepon Taro Minowa. All rights reserved.
//

import Foundation
import Firebase

class Habit: CustomStringConvertible {
    let key: String
    let name: String
    
    init(key: String, name: String) {
        self.key = key
        self.name = name
    }

    var description: String { return "Habit {name:\(name)}" }
}

