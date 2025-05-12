//
//  HTTPWriteMethod.swift
//  SwiftRESTKit
//
//  Created by Nikolai Nobadi on 5/12/25.
//
enum HTTPWriteMethod: String {
    case put, post, patch
    
    var httpMethod: String {
        rawValue.uppercased()
    }
}
