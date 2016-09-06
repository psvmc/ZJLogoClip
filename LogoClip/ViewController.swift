//
//  ViewController.swift
//  LogoClip
//
//  Created by 张剑 on 16/9/6.
//  Copyright © 2016年 PSVMC. All rights reserved.
//

import Cocoa
import Quartz

class ViewController: NSViewController {

    @IBOutlet weak var chooseImageButton: NSButtonCell!
    @IBOutlet weak var selectImageView: NSImageView!
    @IBOutlet weak var exportButton: NSButton!
    @IBOutlet weak var exportTextField: NSTextField!
    @IBOutlet weak var choosePathButton: NSButton!
    
    var isSelectImage = false;
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseImageButton.backgroundColor = NSColor(calibratedRed: 52.0/255, green: 146.0/255, blue: 233.0/255, alpha: 1);
        chooseImageButton.action = #selector(chooseImage);
        exportButton.action = #selector(exportImage);
        choosePathButton.action = #selector(choosePath);
        
        
        let userDefault = NSUserDefaults.standardUserDefaults();
        if let exportPath = userDefault.stringForKey("exportPath"){
            exportTextField.stringValue = exportPath;
        }
        
    }

    override var representedObject: AnyObject? {
        didSet {
        
        }
    }
    
    func chooseImage(){
        let picTaker = IKPictureTaker.pictureTaker();
        picTaker.setValue(false, forKey: IKPictureTakerAllowsEditingKey);
        picTaker.setValue(false, forKey: IKPictureTakerRemainOpenAfterValidateKey);
        picTaker.setValue(false, forKey: IKPictureTakerAllowsVideoCaptureKey);
        picTaker.beginPictureTakerWithDelegate(self, didEndSelector: #selector(pictureTakerDidEnd(_:returnCode:contextInfo:)), contextInfo: nil);
    }
    
    func pictureTakerDidEnd(picker: IKPictureTaker, returnCode: NSInteger, contextInfo: UnsafePointer<Void>) {
        
        if let image = picker.outputImage(){
            self.selectImageView.image = image;
            self.isSelectImage = true;
        }
    }
    
    func choosePath(){
        let panel = NSOpenPanel();
        panel.message = "选择导出路径";
        panel.prompt = "确定";
        panel.canChooseFiles = false;
        panel.canChooseDirectories = true;
        panel.canCreateDirectories = true;
        panel.allowsMultipleSelection = false;
        let result = panel.runModal();
        if(result == NSFileHandlingPanelOKButton){
            if let path = panel.URL!.path{
                self.exportTextField.stringValue = path;
                let userDefault = NSUserDefaults.standardUserDefaults();
                userDefault.setObject(path, forKey: "exportPath");
            }
            
        }
    }
    
    func exportImage(){
        if(self.isSelectImage){
            
            if let image = self.selectImageView.image{
                let newimage = resizeImage(image, newSize: NSSize(width: 32, height: 32));
                let exportPath = self.exportTextField.stringValue;
                self.saveFile(image, exportPath: exportPath, type: "png", fileName: "o_logo");
                self.saveFile(newimage, exportPath: exportPath, type: "png", fileName: "logo");
                self.saveFile(newimage, exportPath: exportPath, type: "jpg", fileName: "logo");
                
            }
            
        }else{
            let alert = NSAlert();
            alert.alertStyle = NSAlertStyle.InformationalAlertStyle;
            alert.messageText = "图片不能为空！";
            alert.runModal();
        }
    }
    
    
    func saveFile(image:NSImage,exportPath:String,type:String,fileName:String){
        let width:Int =  Int(image.size.width);
        let height:Int = Int(image.size.height);
        if(type == "png"){
            image.lockFocus();
            let bits = NSBitmapImageRep(focusedViewRect: NSMakeRect(0, 0, image.size.width, image.size.width));
            image.unlockFocus();
            let imageProps = [NSImageCompressionFactor:0];
            let imageData = bits?.representationUsingType(NSBitmapImageFileType.NSPNGFileType, properties: imageProps);
            imageData?.writeToFile("\(exportPath)/\(fileName)_\(width)x\(height).\(type)", atomically: true);
        }else if(type == "jpg"){
            image.lockFocus();
            let bits = NSBitmapImageRep(focusedViewRect: NSMakeRect(0, 0, image.size.width, image.size.width));
            image.unlockFocus();
            let imageProps = [NSImageCompressionFactor:0.8];
            let imageData = bits?.representationUsingType(NSBitmapImageFileType.NSJPEGFileType, properties: imageProps);
            imageData?.writeToFile("\(exportPath)/\(fileName)_\(width)x\(height).\(type)", atomically: true);
        }
    }

    func resizeImage(sourceImage:NSImage,newSize:NSSize)->NSImage{
        if(sourceImage.valid){
            if (sourceImage.size.width == newSize.width && sourceImage.size.height == newSize.height) {
                return sourceImage;
            }
        }
        
        let oldRect = NSMakeRect(0.0, 0.0, sourceImage.size.width, sourceImage.size.height);
        let newRect = NSMakeRect(0,0,newSize.width,newSize.height);
        let newImage = NSImage(size: newSize);
        
        newImage.lockFocus();
        sourceImage.drawInRect(newRect, fromRect: oldRect, operation: NSCompositingOperation.CompositeCopy, fraction: 1.0);
        newImage.unlockFocus();
        return newImage;
    }

}

