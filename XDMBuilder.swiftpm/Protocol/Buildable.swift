//
//  Buildable.swift
//
//
//  Created by Michael Kushinski on 11/30/23.
//

import Foundation

protocol Buildable {
    associatedtype BuildType
    func build() -> BuildType
}
