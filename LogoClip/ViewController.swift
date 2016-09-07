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

    @IBOutlet weak var sizeTextField: NSTextField!

    
    var isSelectImage = false;
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseImageButton.backgroundColor = NSColor(calibratedRed: 52.0/255, green: 146.0/255, blue: 233.0/255, alpha: 1);
        chooseImageButton.action = #selector(chooseImage);
        exportButton.action = #selector(exportImage);
        choosePathButton.action = #selector(choosePath);
        self.exportTextField.editable = false;

        let userDefault = NSUserDefaults.standardUserDefaults();
        if let exportPath = userDefault.stringForKey("exportPath"){
            exportTextField.stringValue = exportPath;
        }
        
        if let sizeValue = userDefault.stringForKey("sizeValue"){
            sizeTextField.stringValue = sizeValue;
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
                if(self.sizeTextField.stringValue != ""){
                    let sizeStr = self.sizeTextField.stringValue;
                    let sizeArr = ZJ_StringUtils.splitUTF8StrAllowEmpty(sizeStr, spliter: ",");
                    for item in sizeArr{
                        if item.hasPrefix("x"){
                            var detailArr = ZJ_StringUtils.splitUTF8StrAllowEmpty(item, spliter: ".");
                            if(detailArr.count == 2){
                                if let width = Int(ZJ_StringUtils.replace(detailArr[0], replaceStr: "x", withStr: "")){
                                    let suffix = detailArr[1];
                                    let newimage = resizeImage(image, newSize: NSSize(width: width, height: width));
                                    let exportPath = self.exportTextField.stringValue;
                                    self.saveFile(newimage, exportPath: exportPath, type: suffix, fileName: "logo");
                                }
                                
                            }
                        }
                    }
                    
                    let alert = NSAlert();
                    alert.alertStyle = NSAlertStyle.InformationalAlertStyle;
                    alert.messageText = "导出完成！";
                    alert.runModal();

                    let userDefault = NSUserDefaults.standardUserDefaults();
                    userDefault.setObject(self.sizeTextField.stringValue, forKey: "sizeValue");
                }
                
            }
            
        }else{
            let alert = NSAlert();
            alert.alertStyle = NSAlertStyle.InformationalAlertStyle;
            alert.messageText = "图片不能为空！";
            alert.runModal();
        }
    }
    
    
    func saveFile(image:NSImage,exportPath:String,type:String,fileName:String){
        let scale = NSScreen.mainScreen()!.backingScaleFactor;
        let width:Int =  Int(image.size.width) * Int(scale);
        let height:Int = Int(image.size.height) * Int(scale);
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
        
        let scale = NSScreen.mainScreen()!.backingScaleFactor;
        let ptSize = NSSize(width: newSize.width/scale, height: newSize.height/scale);
        
        let oldRect = NSMakeRect(0.0, 0.0, sourceImage.size.width, sourceImage.size.height);
        let newRect = NSMakeRect(0,0,ptSize.width,ptSize.height);
        let newImage = NSImage(size: ptSize);
        
        newImage.lockFocus();
        sourceImage.drawInRect(newRect, fromRect: oldRect, operation: NSCompositingOperation.CompositeCopy, fraction: 1.0);
        newImage.unlockFocus();
        return newImage;
    }

}

