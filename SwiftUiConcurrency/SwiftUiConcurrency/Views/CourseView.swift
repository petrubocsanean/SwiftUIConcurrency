//
//  CourseView.swift
//  SwiftUiConcurrency
//
//  Created by Petru Bocsanean on 27/01/2022.
//

import SwiftUI

struct CourseView: View {
    @Environment(\.presentationMode) var presentationMode
    var course: Course
    
    var body: some View {
        ZStack(alignment: .top) {
            content
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    CloseButton()
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .frame(maxWidth: .infinity)
            .frame(height: 44)
        }
        .navigationBarHidden(true)
    }
    
    var content: some View {
        ScrollView {
            CourseViewCover(course: course)
            
            LazyVStack(spacing: 0) {
                ForEach(course.sectionCollection!.sections.indices, id: \.self) { index in
                    NavigationLink(destination: SectionView(course: course, section: (course.sectionCollection?.sections[index])!)) {
                        SectionRow(section: course.sectionCollection!.sections[index], index: index + 1)
                    }
                }
            }
            .padding(20)
            .padding(.bottom, 100)
        }
        .ignoresSafeArea()
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView(course: coursePreviewData)
    }
}
