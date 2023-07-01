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
                        ForEach(response.result.list
                            .prefix(2)
                            .indices, id: \.self) { index in
                                let item = response.result.list[index]
                                Button(action: {
                                    viewModel.toggleSelection(for: item)
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
                                        Image(systemName: item.isSelected ? "checkmark.circle.fill" : "")
                                            .font(.system(size: 30))
                                            .foregroundColor(item.isSelected ? Color(R.Colors.lightBlue) : nil)
                                            .padding(.leading, 10)
                                            .padding(.trailing, 20)
                                            .padding(.bottom, 110)
                                        
                                    }
                                    .padding(.vertical, 15)
                                    .frame(maxWidth: .infinity)
                                    .background(Color(R.Colors.lightGray))
                                    .cornerRadius(10)
                                }
                        }
                    }
                }
                .cornerRadius(10)
                .listStyle(.plain)
                .padding(.top, 40)
            } else {
                ProgressView()
            }
            chooseButton
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
            action: { viewModel.actionAlert() },
            label: { chooseText }
        )
        .padding([.top, .horizontal], 10)
        .padding(.bottom, 20)
    }
    
    var chooseText: some View {
        Text(R.MainView.chooseButton)
            .customFont(SFProDisplay.medium, category: .extraLarge)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 17)
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
