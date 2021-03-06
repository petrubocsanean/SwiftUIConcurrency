//
//  AccountViewModel.swift
//  SwiftUiConcurrency
//
//  Created by Petru Bocsanean on 26/01/2022.
//

import Foundation

class AccountViewModel: ObservableObject {
    func getUser() async throws -> User {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/1") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data")}
        
        let decodedUser = try JSONDecoder().decode(User.self, from: data)
        
        return decodedUser
    }
}
