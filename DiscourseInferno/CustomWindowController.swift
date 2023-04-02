//
//  CustomWindowController.swift
//  DiscourseInferno
//
//  Created by Kevin Conner on 2023-04-01.
//

import AppKit
import SwiftUI

class CustomWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
        
        updateMenuItems()
        
        guard let window = window as? CustomWindow else { return }
        
        // Create an NSHostingController with your ContentView
        let contentView = ContentView()
        let hostingController = NSHostingController(rootView: contentView)

        // Set the hostingController as the contentViewController of the window
        window.contentViewController = hostingController
    }
    
    private func updateMenuItems() {
        if let window = self.window as? CustomWindow {
            let mode = window.mode
            let viewMenu = NSApplication.shared.mainMenu?.item(withTitle: "View")?.submenu
            
            viewMenu?.item(withTitle: "Docked")?.state = mode == .docked ? .on : .off
            viewMenu?.item(withTitle: "Floating")?.state = mode == .floating ? .on : .off
        }
    }
    
    @IBAction func switchWindowMode(_ sender: NSMenuItem) {
        if let window = self.window as? CustomWindow {
            let mode: CustomWindow.WindowMode = sender.tag == 1 ? .docked : .floating
            window.mode = mode
            updateMenuItems()
        }
    }
}
