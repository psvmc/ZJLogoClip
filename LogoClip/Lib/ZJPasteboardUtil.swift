//
//  PasteboardUtil.swift
//
//  Created by 张剑 on 2018/1/13.
//  Copyright © 2018年 psvmc. All rights reserved.
//

import Foundation
import Cocoa

open class ZJPasteboardUtil{
    public static func getImage(_ pboard: NSPasteboard)->NSImage?{
        let pasteboardTypeFileURL  = NSPasteboard.PasteboardType.init("public.file-url")
        if let pasteboardItems = pboard.pasteboardItems{
            if(pasteboardItems.count > 0){
                let itemFirst = pasteboardItems[0]
                //print(itemFirst.types)
                if(itemFirst.types.contains(NSPasteboard.PasteboardType.tiff)){
                    let image = NSImage(pasteboard: pboard)
                    return image;
                }else if(itemFirst.types.contains(pasteboardTypeFileURL)){
                    if let fileURL = itemFirst.propertyList(forType: pasteboardTypeFileURL) as? String{
                        let image = NSImage.init(contentsOf: URL.init(string: fileURL)!)
                        return image;
                    }
                }
            }
            
        }
        return nil
    }
    
    
    public static func getImageData(_ pboard: NSPasteboard)->Data?{
        let pasteboardTypeFileURL  = NSPasteboard.PasteboardType.init("public.file-url")
        if let pasteboardItems = pboard.pasteboardItems{
            let itemFirst = pasteboardItems[0]
            if(itemFirst.types.contains(NSPasteboard.PasteboardType.tiff)){
                return NSImage(pasteboard: pboard)?.tiffRepresentation(using: .jpeg, factor: 0.8)
            }else if(itemFirst.types.contains(pasteboardTypeFileURL)){
                if let fileURL = itemFirst.propertyList(forType: pasteboardTypeFileURL) as? String{
                    do{
                        let data = try Data.init(contentsOf: URL.init(string: fileURL)!)
                        return data
                    }catch{
                        return nil
                    }
                }
            }
        }
        return nil
    }
    
}
