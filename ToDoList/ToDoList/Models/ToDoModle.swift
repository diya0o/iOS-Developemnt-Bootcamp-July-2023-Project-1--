//
//  ToDoModle.swift
//  ToDoList
//
//  Created by Diya Alowdah on 08/08/2023.
//

import Foundation
import SwiftUI

struct Information: Identifiable {
    let id = UUID()
      var dosome: String
      var backlog = false
     var todo = false
      var done = false
     var inProgrees = false
    
}

class Details: ObservableObject {
    @Published var detalil = [Information]()
    func getTasksCount() -> Int {
        return detalil.count
    }
    }
