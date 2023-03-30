//
//  CoreDataCodableApp.swift
//  CoreDataCodable
//
//  Created by Danjuma Nasiru on 10/02/2023.
//

import SwiftUI

@main
struct CoreDataCodableApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            TestView()
                .environment(\.managedObjectContext, dataController.container.viewContext) 
        }
    }
}
