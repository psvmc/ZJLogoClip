//
//  StringUtils.swift
//  ecms_ios
//
//  Created by PSVMC on 15/6/26.
//
//

import Cocoa

class ZJ_StringUtils{
    
    ///替换字符串
    static func replace(str:String,replaceStr:String,withStr:String)->String{
        let newStr = str.stringByReplacingOccurrencesOfString(replaceStr, withString: withStr, options: NSStringCompareOptions.LiteralSearch, range: nil);
        return newStr;
    }
    
    ///去除空格
    static func trimString(str:String)->String{
        let nowStr = str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        return nowStr
    }
    ///去除空格和回车
    static func trimLineString(str:String)->String{
        let nowStr = str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return nowStr
    }
    
    
    
    static func isNotNilOrEmpty(str:String?) -> Bool{
        if(str == nil){
            return false;
        }else{
            let length = NSString(string: str!).length;
            if(length > 0){
                return true;
            }else{
                return false;
            }
        }
        
    }
    
    //字符串是否为nil或Empty
    static func isNilOrEmpty(str:String?) -> Bool{
        if(str == nil){
            return true;
        }else{
            let length = NSString(string: str!).length;
            if(length == 0){
                return true;
            }else{
                return false;
            }
        }
        
    }
    
    //为空时用空字符串代替
    static func strValue(str:String?) -> String!{
        if(str == nil){
            return "";
        }else{
            return str!;
        }
    }
    
    ///获取文件名（a.jpg）
    static func getFileName(str:String!) -> String{
        var arr = str.characters.split{ $0 == "/" }.map { String($0) };
        return arr[arr.count-1];
    }
    
    ///获取没有-的uuid字符串
    static func getUUID() -> String{
        let uuidStr = NSUUID().UUIDString;
        let uuidNewStr = replace(uuidStr, replaceStr: "-", withStr: "");
        return uuidNewStr;
    }
    
    ///切割,分割的字符串
    static func splitUTF8StrAllowEmpty(str:String) -> Array<String>{
        
        let strArr = splitUTF8StrAllowEmpty(str, spliter: ",");
        return strArr;
    }
    
    ///分割字符串
    static func splitUTF8StrAllowEmpty(str:String,spliter:Character) -> Array<String>{
        let maxSplit = str.lengthOfBytesUsingEncoding(NSUTF8StringEncoding);
        let strArr = str.characters.split(spliter, maxSplit: maxSplit, allowEmptySlices: true).map { String($0) };
        
        return strArr;
    }
    
    ///判断字符串为正整数
    static func isInt(str:String) -> Bool{
        for char in str.utf8 {
            if (char > "9".utf8.first || char < "0".utf8.first){
                return false;
            }
        }
        return true;
    }
}
