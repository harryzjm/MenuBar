//
//  Loader.swift
//  MenuBar
//
//  Created by Hares on 19/03/2026.
//

import Foundation
import UIKit

class Loader: NSObject {
    var holder: NSObject?

    override init() {
        super.init()

        loadFramework()

        let data = UIImage(systemName: "bolt.fill")?.pngData()
        if holder != nil, let data = data {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DataChanged"), object: nil, userInfo: ["data" : data])
        }
    }

    func loadFramework() {
        if let path = Bundle.main.privateFrameworksPath {
            let bundlePath = "\(path)/Integration.framework"
            do {
                try Bundle(path: bundlePath)?.loadAndReturnError()

                let bundle = Bundle(path: bundlePath)!
                NSLog("[App] Loaded Successfully")

                if let IntegrationClass = bundle.classNamed("Integration.Integration") as? NSObject.Type {
                    holder = IntegrationClass.init()
                }
            } catch {
                NSLog("[App] Error: \(error)")
            }
        }
    }

}
