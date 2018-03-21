//
//  AppDelegate.swift
//  sushibar
//
//  Created by paishinoda on 21-03-2018
//  Copyright © 2018 paishinoda. All rights reserved.
//

import Cocoa

fileprivate extension NSTouchBarItemIdentifier {
    static let sushi = NSTouchBarItemIdentifier("com.faizalheesyam.touchbar.sushi")
    static let sushilane = NSTouchBarItemIdentifier("com.faizalheesyam.touchbar.lane.sushi")
}

@available(OSX 10.12.2, *)
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSTouchBarProvider, NSTouchBarDelegate {

    @IBOutlet weak var window: NSWindow!
    var touchBar: NSTouchBar?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window.title = "🍣"

        if let frame = window.contentView?.frame {
            let sushi = NSTextView(frame: NSMakeRect(frame.size.width/2-64, frame.size.height/2-64, 150, 128))
            sushi.string = "🍣"
            sushi.drawsBackground = false
            sushi.isEditable = false
            sushi.isSelectable = false
            sushi.font = NSFont.systemFont(ofSize: 128)
            window.contentView?.addSubview(sushi)
        }

        self.touchBar = makePrimaryTouchBar()
    }


    func makePrimaryTouchBar() -> NSTouchBar {
        let mainBar = NSTouchBar()
        mainBar.delegate = self
        mainBar.defaultItemIdentifiers = [.sushi]
        return mainBar
    }

    func makeSecondaryTouchBar(tLane _tLane:NSTouchBarItemIdentifier) -> NSTouchBar {
        let mainBar = NSTouchBar()
        mainBar.delegate = self
        mainBar.defaultItemIdentifiers = [_tLane]
        return mainBar
    }

    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        if identifier == .sushi {
            let item = NSPopoverTouchBarItem(identifier: identifier)
            item.collapsedRepresentationLabel = "🍣"
            item.popoverTouchBar = makeSecondaryTouchBar(tLane: .sushilane)
            return item
        } else if identifier == .sushilane {
            let item = NSCustomTouchBarItem(identifier: identifier)
            let sushiLaneVC = SushiLaneController()
            sushiLaneVC.setStr(str:"🍣")
            item.viewController = sushiLaneVC
            return item
        } else {
            return nil
        }
    }

    @objc
    func tapped(_ sender : NSObject) {
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

