//
//  FeaturedCourseList.swift
//  SwiftUiConcurrency
//
//  Created by Petru Bocsanean on 24/01/2022.
//

import SwiftUI

struct FeaturedCourseList: View {
    var featuredCourses: [Course]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                if (featuredCourses.count > 0) {
                    ForEach(featuredCourses, id: \.id) { course in
                        NavigationLink(destination: CourseView(course: course)) {
                            FeaturedCourseCard(featuredCourse: course)
                                .frame(width: 252, height: 350)
                        }
                    }
                } else {
                    ForEach(0..<4, id: \.self) { number in
                        FeaturedCourseCard(featuredCourse: coursePreviewData)
                            .frame(width: 252, height: 350)
                            .redacted(reason: .placeholder)
                    }
                }
            }.padding(.horizontal, 20)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct FeaturedCourseList_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedCourseList(featuredCourses: [coursePreviewData])
    }
}
