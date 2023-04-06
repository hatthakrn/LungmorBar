import SwiftUI

struct FirstPage: View {
    @State var isActive: Bool = false
    @State private var size: CGFloat = 0.8
    @State private var opacity: Double = 0.5

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("darkBlue2"),
                        Color("darkBlue")
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                if isActive {
                    NavigationLink(
                        destination: loginView(),
                        isActive: $isActive,
                        label: {
                            EmptyView()
                        })
                        .navigationTitle("")
                        .padding()
                        .navigationBarHidden(true)
                } else {
                    VStack {
                        VStack {
                            Image("Logo1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .scaleEffect(size)
                                .opacity(opacity)
                            
                            Button(action: {
                                isActive = true
                            }, label: {
                                Text("Get Started")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(width: 250, height: 60)
                                    .background(Color("Pinkky"))
                                    .cornerRadius(10)
//                                    .scaleEffect(size)
                            })
                        }
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.5)) {
                                self.size = 0.7
                                self.opacity = 1.00
                            }
                        }
                    }
                }
            }
        }
    }
}

struct FirstPage_Previews: PreviewProvider {
    static var previews: some View {
        FirstPage()
    }
}
