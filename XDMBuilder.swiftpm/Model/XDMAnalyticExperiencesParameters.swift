//
//  File.swift
//  
//
//  Created by Michael Kushinski on 11/30/23.
//

import Foundation

struct XDMBillingParameters: XDMBuildable {
    let notificationImpressions: Int
    let notification: String
    let pageViews: Int
    let name: String
    let url: String
    let customPageViews: Int

    var xdm: XDMResult {
        XDMBuilder()
            .addWebInteraction(notificationImpressions: notificationImpressions, notification: notification)
            .addWebPageDetails(pageViews: pageViews, name: name, url: url, customPageViews: customPageViews)
            .build()
    }
}
