//
//  RegisterViewMode.swift
//  FakeStoreDemo
//
//  Created by Adam Chen on 2025/7/20.
//

import Foundation
import Combine

class RegisterViewModel {
    func registerUser(with requestModel: RegisterRequest) -> AnyPublisher<RegisterResponse, Error> {
        return APIService.post(
            urlString: APIEndpoint.registerUser,
            body: requestModel
        )
    }
}

