//
//  ModalManager.swift
//  SwiftUiConcurrency
//
//  Created by Petru Bocsanean on 26/01/2022.
//

import Foundation

class ModalManager: ObservableObject {
    enum ActiveModals {
        case signIn
        case signUp
        case resetPassword
    }
    
    @Published public var showModal: Bool = false
    @Published public var activeModal: ActiveModals = .signIn
}
