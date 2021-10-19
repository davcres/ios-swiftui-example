//
//  Handler.swift
//  AcademicPass
//
//  Created by Gonzalo Gonzalez  on 07/01/2021.
//

enum DomainError: Error {
    case persistence
    case invalidPasscode
    case biometricsError
    case httpError(Int, String)
    case refreshTokenError
    case refreshSessionTokenError
    case sessionError
}

typealias Handler<T> = (Result<T, DomainError>) -> Void
