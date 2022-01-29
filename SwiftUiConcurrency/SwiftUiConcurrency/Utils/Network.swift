//
//  Network.swift
//  SwiftUiConcurrency
//
//  Created by Petru Bocsanean on 24/01/2022.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()
    
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://graphql.contentful.com/content/v1/spaces/replace_with_spaceID?access_token=replace_with_acces_token")!)
}
