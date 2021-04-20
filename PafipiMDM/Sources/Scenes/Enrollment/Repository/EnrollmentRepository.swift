//
//  EnrollmentRepository.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import Foundation
import Combine
import Resolver
import Core

protocol EnrollmentRepository {
    
    func fetchUsers() 
}

protocol EnrollmentRepositoryDelegate: AnyObject {
    
    func onDidFetchUserSuccess(users: [User])
    func onDidFetchUserFailed()
}

final class EnrollmentRepositoryImpl: EnrollmentRepository {
    
    @LazyInjected private var networking: EnrollmentNetworking
    
    private var disposeBag = Set<AnyCancellable>()

    func fetchUsers() {
        networking.getUsers()
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    print("Couldn't get users: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { users in
                print(users)
            })
            .store(in: &disposeBag)
    }
}
