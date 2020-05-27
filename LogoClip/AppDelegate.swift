//
//  AppDelegate.swift
//  LogoClip
//
//  Created by 张剑 on 16/9/6.
//  Copyright © 2016年 PSVMC. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    static var appDelegate:AppDelegate!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        AppDelegate.appDelegate = self
    }

    func applicationWillTerminate(_ aNotification: Notification) {

    }
    
}

extension AppDelegate: NSUserNotificationCenterDelegate, PasteboardObserverSubscriber {
    // 强行通知
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        
        
    }
    
    func pasteboardChanged(_ pasteboard: NSPasteboard) {
//        ImageService.shared.uploadImg(pasteboard)
    }
    
//    func registerHotKeys() {
//        var gMyHotKeyRef: EventHotKeyRef? = nil
//        var gMyHotKeyIDU = EventHotKeyID()
//        var eventType = EventTypeSpec()
//
//        eventType.eventClass = OSType(kEventClassKeyboard)
//        eventType.eventKind = OSType(kEventHotKeyPressed)
//        gMyHotKeyIDU.signature = OSType(32)
//        gMyHotKeyIDU.id = UInt32(kVK_ANSI_U);
//
//        RegisterEventHotKey(UInt32(kVK_ANSI_U), UInt32(cmdKey), gMyHotKeyIDU, GetApplicationEventTarget(), 0, &gMyHotKeyRef)
//
//        // Install handler.
//        InstallEventHandler(GetApplicationEventTarget(), { (nextHanlder, theEvent, userData) -> OSStatus in
//            var hkCom = EventHotKeyID()
//            GetEventParameter(theEvent, EventParamName(kEventParamDirectObject), EventParamType(typeEventHotKeyID), nil, MemoryLayout<EventHotKeyID>.size, nil, &hkCom)
//            switch hkCom.id {
//            case UInt32(kVK_ANSI_U):
//                let pboard = NSPasteboard.general
//                ImageService.shared.uploadImg(pboard)
//            default:
//                break
//            }
//
//            return 33
//        }, 1, &eventType, nil, nil)
//
//    }
    
    
    
}


