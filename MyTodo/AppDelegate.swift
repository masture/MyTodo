//
//  AppDelegate.swift
//  MyTodo
//
//  Created by Pankaj Kulkarni on 07/03/18.
//  Copyright © 2018 Pankaj Kulkarni. All rights reserved.
//

import UIKit
import RealmSwift



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // print(Realm.Configuration.defaultConfiguration.fileURL)

        do {
            let _ = try Realm()

            
        } catch {
            print("Error instantiating Realm. Error\(error)")
        }
        
        return true
    }

}

