//
//  XDMWebInteraction.swift.swift
//
//
//  Created by Michael Kushinski on 11/30/23.
//

import Foundation

struct XDMWebInteraction: Buildable, Encodable {
    var telus: XDMTelus
    var type = "Other"

    func build() -> XDMWebInteraction {
        return self
    }
}
