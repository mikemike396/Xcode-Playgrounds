//
//  XDMMain.swift
//
//
//  Created by Michael Kushinski on 11/30/23.
//

import Foundation

struct XDMMain: Encodable {
    let xdm: XDMWeb
}

struct XDMWeb: Encodable {
    let web: XDMWebInternal

    struct XDMWebInternal: Encodable {
        var webPageDetail: XDMWebPageDetail?
        var webInteraction: XDMWebInteraction?
    }
}
