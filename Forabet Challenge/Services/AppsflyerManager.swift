//
//  AppsflyerManager.swift
//  Forabet Challenge
//
//  Created by BSergio on 14.04.2022.
//

import AppsFlyerLib

class AppsflyerManager: NSObject {
    
    var delegate: MainDelegate!
    
    init(delegate: MainDelegate) {
        super.init()
        AppsFlyerLib.shared().start()
        AppsFlyerLib.shared().delegate = self
        self.delegate = delegate
    }
    
    private func parsConversionInfo(for conversionInfo: [AnyHashable: Any], completion: (_ paramets: String?) -> Void) {
        guard let status = conversionInfo["af_status"] as? String else {
            completion(nil)
            return
        }
        
        var parametrs = "app_id=id\(DataManager.ProjectConstant.appId.rawValue)"
        parametrs += "&aftoken=\(DataManager.ProjectConstant.appsFlyerKey.rawValue)"
        parametrs += "&af_status=\(status)"
        parametrs += "&afid=\(AppsFlyerLib.shared().getAppsFlyerUID())"
        
        if status != "Organic" {
            
            if let name = conversionInfo["campaign"] as? String {
                parametrs += ParserName(dataName: name).getParametrs()
            }
            
            if let campaignId = conversionInfo["campaignId"] {
                parametrs += "&sub11=\(campaignId)"
            }
            
            if let source = conversionInfo["media_source"] {
                parametrs += "&media_source=\(source)"
            }
        }
        completion(parametrs)
    }
}

extension AppsflyerManager: AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        parsConversionInfo(for: conversionInfo) { parametrs in
            guard let parametrs = parametrs else {
                return
            }
            delegate.setParametrs(paramers: parametrs)
        }
    }
    
    func onConversionDataFail(_ error: Error) {
        delegate.setParametrs(paramers: "sub1=failedAppsflyer")
    }
}
