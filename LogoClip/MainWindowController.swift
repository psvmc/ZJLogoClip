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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(closeWindow(_:)), name: NSWindowWillCloseNotification, object: nil);
    }
    
    func closeWindow(noti:NSNotification){
        if let objWindow = noti.object{
            if(objWindow as? NSObject == self.window){
                NSApp.terminate(self);
            }
        }
    }
}
