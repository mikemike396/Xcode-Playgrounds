//
//  XDMWebPageDetail.swift
//
//
//  Created by Michael Kushinski on 11/30/23.
//

import Foundation

struct XDMWebPageDetail: Buildable, Encodable {
    let pageViews = XDMPageViews()
    var name: String?
    var url: String?
    var telus = XDMTelus(customPageViews: 1)

    func build() -> XDMWebPageDetail {
        return self
    }
}
