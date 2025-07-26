//
//  APIEndpoint.swift
//  FakeStoreDemo
//
//  Created by Adam Chen on 2025/7/20.
//

import Foundation

enum APIEndpoint {
    private static let baseURL = "https://api.escuelajs.co/api/v1"

    static var registerUser: String {
        return "\(baseURL)/users/"
    }

    static var login: String {
        return "\(baseURL)/auth/login"
    }
}
