//
//  ServicesBuilder.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.04.21.
//

final class ServicesBuilder {
    static func makeStartupService(resolver: DependencyResolver) -> StartupService {
        StartupService()
    }
}
