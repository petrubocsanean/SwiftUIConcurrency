//
//  SectionViewModel.swift
//  SwiftUiConcurrency
//
//  Created by Petru Bocsanean on 25/01/2022.
//

import Foundation
import Apollo

class SectionViewModel: ObservableObject {
    @Published public var sections: [SectionsDataCollection.SectionModel] = []
    @Published public private(set) var filteredSections: [SectionsDataCollection.SectionModel] = []
    
    private func querySections() async throws -> GraphQLResult<SectionQuery.Data>? {
        return await withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: SectionQuery()) { result in
                switch result {
                case .success(let GraphQLResult):
                    continuation.resume(returning: GraphQLResult)
                case .failure(let error):
                    if let error = error as? Never {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    func fetch() async {
        do {
            let result = try await querySections()
            
            if let result = result {
                if let sectionCollection = result.data?.sectionCollection {
                    DispatchQueue.main.async {
                        self.sections = self.process(data: sectionCollection)
                    }
                }
            }
        } catch {
            print("Error", error)
        }
        
    }
    
    private func process(data: SectionsCollectionData) -> [SectionsDataCollection.SectionModel] {
        let content = SectionsDataCollection.init(data)
        return content.sections
    }
    
    func randomizeSections() async {
        sections.shuffle()
    }
    
    func orderSectionsByPinned() {
        sections.sort {
            $0.isPinned && !$1.isPinned
        }
    }
    
    func filterSections(for text:String) {
        filteredSections = []
        let searchText = text.lowercased()
        
        sections.forEach { section in
            let searchContent = section.title
            
            if searchContent.lowercased().range(of: searchText, options: .regularExpression) != nil {
                filteredSections.append(section)
            }
        }
    }
}
