//
//  CourseViewModel.swift
//  SwiftUiConcurrency
//
//  Created by Petru Bocsanean on 24/01/2022.
//

import Foundation
import Apollo

enum FeaturedSubject: String, CaseIterable {
    case SwiftUI = "SwiftUI"
    case Design = "Design"
}

class CourseViewModel: ObservableObject {
    @Published public private(set) var courses: [Course] = []
    var featuredSubject: FeaturedSubject = FeaturedSubject.allCases.randomElement() ?? .SwiftUI
    @Published public private(set) var featuredCourses: [Course] = []
    
    private func queryCourses() async throws -> GraphQLResult<CourseQuery.Data>? {
        return await withCheckedContinuation { continuation in
            let preferredLanguage = Locale.preferredLanguages[0]
            let locale = preferredLanguage.contains("pt") ? "pt-PT" : "en-US"
            Network.shared.apollo.fetch(query: CourseQuery(locale: locale)) { result in
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
            let result = try await queryCourses()
            
            if let result = result {
                if let courseCollection = result.data?.courseCollection {
                    DispatchQueue.main.async {
                        self.courses = self.process(data: courseCollection)
                        self.findFeaturedCourses()
                    }
                }
            }
        } catch {
            print("Error", error)
        }
        
    }
    
    private func process(data: CoursesData) -> [Course] {
        let content = CoursesCollection.init(data)
        return content.courses
    }
    
    private func findFeaturedCourses() {
        guard courses.count > 0 else { return }
        
        featuredCourses = courses.filter { course in
            course.subject == featuredSubject.rawValue
        }
    }
}
