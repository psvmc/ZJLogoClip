//
//  MainWindowController.swift
//  LogoClip
//
//  Created by 张剑 on 16/9/6.
//  Copyright © 2016年 PSVMC. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(closeWindow(_:)), name: NSWindow.willCloseNotification, object: nil);
    }
    
    @objc func closeWindow(_ noti:Notification){
        if let objWindow = noti.object{
            if(objWindow as? NSObject == self.window){
                NSApp.terminate(self);
            }
        }
    }
}
