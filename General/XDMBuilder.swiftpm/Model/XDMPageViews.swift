//
//  File.swift
//  
//
//  Created by Michael Kushinski on 11/30/23.
//

import Foundation

struct XDMPageViews: Encodable {
    var value: Int?

    init(value: Int = 1) {
        self.value = value
    }
}
