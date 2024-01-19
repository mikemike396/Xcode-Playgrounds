//
//  XDMTelus.swift
//
//
//  Created by Michael Kushinski on 11/30/23.
//

import Foundation

struct XDMTelus: Encodable {
    var customPageViews: Int?
    var notificationImpressions: Int?
    var notification: String?
}

extension XDMTelus {
    init(customPageViews: Int?) {
        self.customPageViews = customPageViews
    }

    init(notificationImpressions: Int?, notification: String?) {
        self.notificationImpressions = notificationImpressions
        self.notification = notification
    }
}
