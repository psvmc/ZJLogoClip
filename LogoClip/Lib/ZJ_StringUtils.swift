//
//  StringUtils.swift
//  ecms_ios
//
//  Created by PSVMC on 15/6/26.
//
//

import Cocoa
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class ZJ_StringUtils{
    
    ///替换字符串
    static func replace(_ str:String,replaceStr:String,withStr:String)->String{
        let newStr = str.replacingOccurrences(of: replaceStr, with: withStr, options: NSString.CompareOptions.literal, range: nil);
        return newStr;
    }
    
    ///去除空格
    static func trimString(_ str:String)->String{
        let nowStr = str.trimmingCharacters(in: CharacterSet.whitespaces)
        return nowStr
    }
    ///去除空格和回车
    static func trimLineString(_ str:String)->String{
        let nowStr = str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return nowStr
    }
    
    
    
    static func isNotNilOrEmpty(_ str:String?) -> Bool{
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
    static func isNilOrEmpty(_ str:String?) -> Bool{
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
    static func strValue(_ str:String?) -> String!{
        if(str == nil){
            return "";
        }else{
            return str!;
        }
    }
    
    ///获取文件名（a.jpg）
    static func getFileName(_ str:String!) -> String{
        var arr = str.characters.split{ $0 == "/" }.map { String($0) };
        return arr[arr.count-1];
    }
    
    ///获取没有-的uuid字符串
    static func getUUID() -> String{
        let uuidStr = UUID().uuidString;
        let uuidNewStr = replace(uuidStr, replaceStr: "-", withStr: "");
        return uuidNewStr;
    }
    
    ///切割,分割的字符串
    static func splitUTF8StrAllowEmpty(_ str:String) -> Array<String>{
        
        let strArr = splitUTF8StrAllowEmpty(str, spliter: ",");
        return strArr;
    }
    
    ///分割字符串
    static func splitUTF8StrAllowEmpty(_ str:String,spliter:Character) -> Array<String>{
        let maxSplit = str.lengthOfBytes(using: String.Encoding.utf8);
        let strArr = str.characters.split(separator: spliter, maxSplits: maxSplit, omittingEmptySubsequences: false).map { String($0) };
        
        return strArr;
    }
    
    ///判断字符串为正整数
    static func isInt(_ str:String) -> Bool{
        for char in str.utf8 {
            if (char > "9".utf8.first || char < "0".utf8.first){
                return false;
            }
        }
        return true;
    }
}
