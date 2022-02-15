//
//  Log.swift
//  BeerApp
//
//  Created by Miguel on 15/02/2022.
//

import UIKit

import UIKit

enum LogEvent: String {
    case error = "[Error]"
    case info = "[Info]"
    case debug = "[Debug]"
    case verbose = "[Verbose]"
    case warning = "[Warning]"
}

class Log: NSObject {
    
    private class func file(_ filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
    private class func dateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM.dd hh:MM:ss.SSS"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        
        return formatter.string(from: date)
    }
    
    class func e(_ message: String, fileName: String = #file, line: Int = #line, funcName: String = #function) {
        Log.printConsole(.error, "[\(file(fileName)) | line: \(line) | func: \(funcName)] => \(message)")
    }
    
    class func i(_ message: String, fileName: String = #file, line: Int = #line, funcName: String = #function) {
        Log.printConsole(.info, "[\(file(fileName)) | line: \(line) | func: \(funcName)] => \(message)")
    }
    
    class func d(_ message: String, fileName: String = #file, line: Int = #line, funcName: String = #function) {
        Log.printConsole(.debug, "[\(file(fileName)) | line: \(line) | func: \(funcName)] => \(message)")
    }
    
    class func v(_ message: String, fileName: String = #file, line: Int = #line, funcName: String = #function) {
        Log.printConsole(.verbose, "[\(file(fileName)) | line: \(line) | func: \(funcName)] => \(message)")
    }
    
    class func w(_ message: String, fileName: String = #file, line: Int = #line, funcName: String = #function) {
        Log.printConsole(.warning, "[\(file(fileName)) | line: \(line) | func: \(funcName)] => \(message)")
    }
    
    private class func printConsole(_ event: LogEvent, _ message: String) {
        #if DEBUG
            print("\(dateString(date: Date())) \(event.rawValue) \(message)")
        #endif
    }
}
