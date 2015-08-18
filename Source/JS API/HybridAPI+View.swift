//
//  HybridAPI+View.swift
//  THGHybridWeb
//
//  Created by Angelo Di Paolo on 7/21/15.
//  Copyright (c) 2015 TheHolyGrail. All rights reserved.
//

import JavaScriptCore
import UIKit

@objc protocol ViewJSExport: JSExport {
    func show()
    func setOnAppear(callback: JSValue)
    func setOnDisappear(callback: JSValue)
}

@objc public class ViewAPI: ViewControllerChild  {

    private var hasAppeared = false
    internal var onAppearCallback: JSValue? {
        didSet {
            if hasAppeared {
                appeared()
            }
        }
    }
    private var onDisappearCallback: JSValue?
    
    func appeared() {
        hasAppeared = true
        onAppearCallback?.safelyCallWithArguments(nil)
    }
    
    func disappeared() {
        onDisappearCallback?.safelyCallWithArguments(nil)
    }
}

extension ViewAPI: ViewJSExport {
    /// Show the web view
    func show() {
        webViewController?.showWebView()
    }
    
    func setOnAppear(callback: JSValue) {
        onAppearCallback = callback
    }
    
    func setOnDisappear(callback: JSValue) {
        onDisappearCallback = callback
    }
}
