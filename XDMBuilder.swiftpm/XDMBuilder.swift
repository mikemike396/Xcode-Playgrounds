//
//  XDMBuilder.swift
//  XDMBuilder
//
//  Created by Michael Kushinski on 11/30/23.
//

import Foundation

//enum XDMAnalyticExperiences {
//    case billing(XDMBillingParameters)
//
//    var xdm: XDMResult {
//        switch self {
//        case let .billing(result):
//            return result.xdm
//        }
//    }
//}

typealias XDMResult = [String: Any]

protocol XDMBuildable {
    var xdm: XDMResult { get }
}

class XDMBuilder {
    private var webInteraction: XDMWebInteraction?
    private var webPageDetail: XDMWebPageDetail?

    init() {
    }

    func build() -> XDMResult {
        let webInternal = XDMWeb.XDMWebInternal(webPageDetail: webPageDetail, webInteraction: webInteraction)
        let web = XDMWeb(web: webInternal)
        let xdm = XDMMain(xdm: web)
        guard let dictionary = try? JSONSerialization.jsonObject(with: JSONEncoder().encode(xdm)) as? [String: Any]
        else { return [:] }

        return dictionary
    }
}

// MARK: Public Builder Functions

extension XDMBuilder  {
    // Builder methods for constructing the dictionary structure
    func addWebPageDetails(pageViews: Int, name: String, url: String, customPageViews: Int) -> Self {
        // TODO: Do conversion between . and >
        webPageDetail = XDMWebPageDetail(name: name, url: url, telus: XDMTelus(customPageViews: customPageViews))
        return self
    }
    
    func addWebInteraction(notificationImpressions: Int, notification: String, type: String = "Other") -> Self {
        webInteraction = XDMWebInteraction(telus: XDMTelus(notificationImpressions: notificationImpressions, notification: notification), type: type)
        return self
    }
}
