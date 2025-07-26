//
//  UserRequest.swift
//  FakeStoreDemo
//
//  Created by Adam Chen on 2025/7/20.
//

import Foundation

struct RegisterRequest: Codable {
    let name: String
    let email: String
    let password: String
    let avatar: String
}

struct RegisterResponse: Codable {
    let id: Int
    let name: String
    let email: String
    let password: String
    let avatar: String
    let role: String
}
