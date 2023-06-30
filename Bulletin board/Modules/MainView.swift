import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color(R.Colors.white).ignoresSafeArea(.all)
            content
                .onAppear {
                    viewModel.fetchData()
                }
        }
    }
}

// MARK: - Content

extension MainView {
    
    var content: some View {
        VStack(alignment: .leading) {
            if let response = viewModel.response {
                dismissImage
                Text(response.result.title)
                    .customFont(SFProDisplay.medium, category: .extraExtraExtraLarge)
                    .foregroundColor(Color(R.Colors.black))
                    .lineSpacing(5)
                    .padding(.top, 40)

                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(response.result.list.prefix(2), id: \.id) { item in
                            Button(action: {
                                
                            }) {
                                HStack {
                                    AsyncImage(url: item.icon.the52X52) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 52, height: 52)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .padding(.top, 10)
                                    .padding([.leading, .trailing], 20)
                                    .padding(.bottom, 90)
                                    
                                    VStack(alignment: .leading, spacing: 15) {
                                        Text(item.title)
                                            .customFont(SFProDisplay.medium, category: .extraLarge)
                                            .foregroundColor(Color(R.Colors.black))
                                        Text(item.description ?? "")
                                            .customFont(SFProDisplay.medium, category: .medium)
                                            .multilineTextAlignment(.leading)
                                            .lineSpacing(4)
                                            .foregroundColor(Color(R.Colors.black))
                                        Text(item.price)
                                            .customFont(SFProDisplay.medium, category: .extraLarge)
                                            .foregroundColor(Color(R.Colors.black))
                                    }
                                }
                                .padding(.vertical, 15)
                                .padding(.trailing, 70)
                                .frame(maxWidth: .infinity)
                                .background(Color(R.Colors.lightGray))
                                .cornerRadius(10)
                            }
                        }
                    }
                }
                .cornerRadius(10)
                .padding(.top, 40)
                .listStyle(.plain)
            } else {
                ProgressView()
            }
            chooseButton
                .padding(.bottom, 20)
        }
        .padding(.horizontal, 15)
    }
}

// MARK: - Setup button

extension MainView {
    
    var dismissImage: some View {
        Image("cancel")
            .foregroundColor(Color(R.Colors.black))
            .padding(.top, 10)
    }
    
    var chooseButton: some View {
        Button(
            action: { },
            label: { chooseText }
        )
        .padding(.top, 10)
        .padding(.horizontal, 10)
    }
    
    var chooseText: some View {
        Text(R.MainView.chooseButton)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(.top, 17)
            .padding(.bottom, 17)
            .background(Color(R.Colors.lightBlue))
            .foregroundColor(Color(R.Colors.white))
            .cornerRadius(10)
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
