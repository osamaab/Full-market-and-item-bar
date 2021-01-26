//
//  AppConstants.swift
//  talabyeh
//
//  Created by Hussein Work on 28/12/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import UIKit

struct AppConstants {
    /*
     Detect when the app is running on debug, testflight, or regular appStore
     */
    enum AppEnvironment {
        case debug
        case testFlight
        case appStore
    }
    
   static func amIBeingDebugged() -> Bool {
        var info = kinfo_proc()
        var mib : [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
        var size = MemoryLayout<kinfo_proc>.stride
        let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
        assert(junk == 0, "sysctl failed")
        return (info.kp_proc.p_flag & P_TRACED) != 0
    }
    
    static var deviceID: String {
        UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
    }
    
    static var appEnvironment: AppEnvironment {
        let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
        
        #if DEBUG
        return .debug
        #else
        if isTestFlight {
            return .testFlight
        } else {
            return .appStore
        }
        #endif
    }
}
