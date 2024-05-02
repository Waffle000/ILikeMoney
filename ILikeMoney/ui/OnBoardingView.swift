//
//  OnBoardingView.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 24/03/24.
//

import SwiftUI

struct OnBoardingView: View {
    @State private var pageIndex = 0
    private let pages: [OnBoardingModel] = OnBoardingModel.pages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        NavigationView {
            TabView(selection: $pageIndex) {
                ForEach(pages) { page in
                    VStack {
                        Spacer()
                        OnBoardingPage(data : page)
                        Spacer()
                        HStack() {
                            Spacer()
                            if page == pages.last {
                                NavigationLink(destination: ChooseCategoryView(), label: {
                                    Text("Next").foregroundColor(.primaryText)
                                })
                            } else {
                                Button(action: incrementPage) {
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 32)).foregroundColor(.primaryText)
                                }
                            }
                        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).padding(.trailing, 16)
                        Spacer()
                    }.tag(page.tag).padding(16)
                }
            }.animation(.easeInOut, value: pageIndex)
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .onAppear {
                    dotAppearance.currentPageIndicatorTintColor = .black
                    dotAppearance.pageIndicatorTintColor = .gray
                }
        }
        
    }
    
    func incrementPage() {
        pageIndex += 1
    }
    
    func goToZero() {
        pageIndex = 0
    }
}

#Preview {
    OnBoardingView()
}
