//
//  SignInAPIModel.swift
//  FakeStoreDemo
//
//  Created by Adam Chen on 2025/7/20.
//

import Foundation

struct SignInRequest: Codable {
    let email: String
    let password: String
}

struct SignInResponse: Codable {
    let access_token: String
    let refresh_token: String
}
