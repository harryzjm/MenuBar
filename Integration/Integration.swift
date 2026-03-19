//
//  Integration.swift
//  Integration
//
//  Created by Hares on 19/03/2026.
//

import AppKit

extension Integration {
    @objc private func handleButtonClick(_ sender: NSStatusBarButton) {
        guard let event = NSApp.currentEvent else { return }
        if event.type == .rightMouseUp {
            menuItem.menu = contextMenu
            sender.performClick(nil)
            menuItem.menu = nil
        } else {
            handleTest(nil)
        }
    }

    @objc func handleQuit(_ sender:Any?) {
        exit(0)
    }

    @objc func handleTest(_ sender:Any?) {
        count += 1
        menuItem.button?.title = count.description
    }
}

@objc class Integration: NSObject {
    let menuItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    private var contextMenu: NSMenu?
    var count = 1

    override init() {
        super.init()

        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "DataChanged"), object: nil, queue: nil) { note in
            if let data = note.userInfo?["data"] as? Data {
                self.setupMenuItem(imageData: data)
            }
        }
    }
    
    func setupMenuItem(imageData: Data) {
        NSLog("[Menu] Received image data")

        if let button = menuItem.button {
            let image = NSImage(data: imageData)
            image?.isTemplate = true
            button.image = image
            button.title = count.description

            button.action = #selector(handleButtonClick)
            button.target = self
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }

        let menu = NSMenu()
        menu.addItem("Test", target: self, action: #selector(handleTest))
        menu.addItem(.separator())
        menu.addItem("Quit", target: self, action: #selector(handleQuit))

        contextMenu = menu
    }
}

extension NSMenu {
    func addItem(_ title: String, target: AnyObject?, action: Selector, keyEquivalent charCode: String = "") {
        let item = NSMenuItem(title: NSLocalizedString(title, comment: ""), action: action, keyEquivalent: charCode)
        item.target = target
        addItem(item)
    }
}
