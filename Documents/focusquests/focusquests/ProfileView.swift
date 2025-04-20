import SwiftUI

struct ProfileView: View {
    @AppStorage("userName") var userName: String = ""
    @AppStorage("userAvatar") var userAvatar: String = "🧑‍💻"
    @AppStorage("userThemeColor") var userThemeColor: String = "blue"
    @AppStorage("userBio") var userBio: String = ""
    
    let avatarOptions = [
        "👨🏻‍💻", "👩🏻‍💻", "👨🏼‍💻", "👩🏼‍💻", "👨🏽‍💻", "👩🏽‍💻", "👨🏾‍💻", "👩🏾‍💻", "👨🏿‍💻", "👩🏿‍💻",
        "👶", "👶🏻", "👶🏼", "👶🏽", "👶🏾", "👶🏿",
        "👧", "👧🏻", "👧🏼", "👧🏽", "👧🏾", "👧🏿",
        "👨", "👨🏻", "👨🏼", "👨🏽", "👨🏾", "👨🏿",
        "👩", "👩🏻", "👩🏼", "👩🏽", "👩🏾", "👩🏿",
        "👴", "👴🏻", "👴🏼", "👴🏽", "👴🏾", "👴🏿",
        "👵", "👵🏻", "👵🏼", "👵🏽", "👵🏾", "👵🏿",
        "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🐧", "🐦", "🦆", "🦉", "🦇", "🐺", "🐗", "🐴", "🦄", "🐝", "🐢", "🐙", "🦑", "🦞", "🦀", "🐬", "🐳", "🦈", "🐊","👾", "🤖", "👽", "👻", "🧚‍♀️", "🧚‍♂️", "🧙‍♀️", "🧙‍♂️", "🧛‍♀️", "🧛‍♂️", "🧜‍♀️", "🧜‍♂️", "🧝‍♀️", "🧝‍♂️", "🧞‍♀️", "🧞‍♂️",
        "👑", "🌟", "🦸‍♂️", "🦸‍♀️", "🤠", "👨‍🎤", "👩‍🎤", "🌈", "🦋", "🌺", "🌻", "🍀", "⭐️", "🔥", "💥", "💫", "🎮", "🎯", "🎨", "🎭", "🎧"
    ]
    
    let themeColors = ["blue", "green", "purple", "orange", "pink", "red", "teal", "yellow", "indigo"]
    
    @State private var isAvatarPickerPresented = false
    @State private var isColorPickerPresented = false
    @State private var isEditingProfile = false
    @State private var previewMode = false
    
    func getColor(_ name: String) -> Color {
        switch name {
        case "blue": return .blue
        case "green": return .green
        case "purple": return .purple
        case "orange": return .orange
        case "pink": return .pink
        case "red": return .red
        case "teal": return .teal
        case "yellow": return .yellow
        case "indigo": return .indigo
        default: return .blue
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                getColor(userThemeColor).opacity(0.1).edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(getColor(userThemeColor).opacity(0.2))
                                .frame(height: 200)
                                .shadow(radius: 3)
                            
                            VStack {
                                Text(userAvatar)
                                    .font(.system(size: 80))
                                    .padding(.bottom, 5)
                                
                                Text(userName.isEmpty ? "Seu Nome" : userName)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(getColor(userThemeColor))
                            }
                        }
                        .padding(.horizontal)
                        
                        if previewMode {
                            PreviewProfileView(
                                userName: userName,
                                userAvatar: userAvatar,
                                userThemeColor: userThemeColor,
                                userBio: userBio,
                                getColor: getColor
                            )
                            .transition(.scale)
                        } else {
                            VStack(spacing: 15) {
                                HStack {
                                    Image(systemName: "person.fill")
                                        .foregroundColor(getColor(userThemeColor))
                                    TextField("Seu nome", text: $userName)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(color: Color.black.opacity(0.1), radius: 5)
                                }
                                .padding(.horizontal)
                                
                                HStack {
                                    Image(systemName: "face.smiling.fill")
                                        .foregroundColor(getColor(userThemeColor))
                                    
                                    Button(action: {
                                        isAvatarPickerPresented = true
                                    }) {
                                        HStack {
                                            Text("Escolher Avatar")
                                            Spacer()
                                            Text(userAvatar)
                                                .font(.largeTitle)
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(getColor(userThemeColor))
                                        }
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(color: Color.black.opacity(0.1), radius: 5)
                                    }
                                }
                                .padding(.horizontal)
                                
                                HStack {
                                    Image(systemName: "paintpalette.fill")
                                        .foregroundColor(getColor(userThemeColor))
                                    
                                    Button(action: {
                                        isColorPickerPresented = true
                                    }) {
                                        HStack {
                                            Text("Tema de Cores")
                                            Spacer()
                                            Circle()
                                                .fill(getColor(userThemeColor))
                                                .frame(width: 24, height: 24)
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(getColor(userThemeColor))
                                        }
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(color: Color.black.opacity(0.1), radius: 5)
                                    }
                                }
                                .padding(.horizontal)
                                
                                HStack(alignment: .top) {
                                    Image(systemName: "text.quote")
                                        .foregroundColor(getColor(userThemeColor))
                                        .padding(.top, 12)
                                    
                                    TextEditor(text: $userBio)
                                        .frame(height: 100)
                                        .padding(10)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(color: Color.black.opacity(0.1), radius: 5)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(getColor(userThemeColor).opacity(0.3), lineWidth: 1)
                                        )
                                        .overlay(
                                            Group {
                                                if userBio.isEmpty {
                                                    Text("Escreva algo sobre você...")
                                                        .foregroundColor(Color.gray.opacity(0.7))
                                                        .padding(15)
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                                }
                                            }
                                        )
                                }
                                .padding(.horizontal)
                                
                                Button(action: {
                                    withAnimation {
                                        previewMode.toggle()
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: previewMode ? "pencil" : "eye.fill")
                                        Text(previewMode ? "Editar Perfil" : "Visualizar Perfil")
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(getColor(userThemeColor))
                                    .cornerRadius(15)
                                    .foregroundColor(.white)
                                    .shadow(radius: 3)
                                }
                                .padding(.horizontal)
                                .padding(.top, 10)
                            }
                            .transition(.scale)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Seu Perfil")
            .sheet(isPresented: $isAvatarPickerPresented) {
                AvatarPickerView(avatarOptions: avatarOptions, selectedAvatar: $userAvatar)
            }
            .sheet(isPresented: $isColorPickerPresented) {
                ColorPickerView(themeColors: themeColors, selectedColor: $userThemeColor, getColor: getColor)
            }
            .animation(.easeInOut, value: previewMode)
        }
    }
}

struct AvatarPickerView: View {
    let avatarOptions: [String]
    @Binding var selectedAvatar: String
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""
    
    var filteredAvatars: [String] {
        if searchText.isEmpty {
            return avatarOptions
        } else {
            return avatarOptions
        }
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 70), spacing: 10)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Buscar emoji...", text: $searchText)
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(filteredAvatars, id: \.self) { avatar in
                            Button(action: {
                                selectedAvatar = avatar
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text(avatar)
                                    .font(.system(size: 40))
                                    .frame(width: 70, height: 70)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(selectedAvatar == avatar ? Color.blue.opacity(0.2) : Color(.systemGray6))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(selectedAvatar == avatar ? Color.blue : Color.clear, lineWidth: 2)
                                    )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Escolha um Avatar")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Pronto") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct ColorPickerView: View {
    let themeColors: [String]
    @Binding var selectedColor: String
    let getColor: (String) -> Color
    @Environment(\.presentationMode) var presentationMode
    
    let columns = [
        GridItem(.adaptive(minimum: 60), spacing: 15)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(themeColors, id: \.self) { colorName in
                        Button(action: {
                            selectedColor = colorName
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            ZStack {
                                Circle()
                                    .fill(getColor(colorName))
                                    .frame(width: 60, height: 60)
                                    .shadow(radius: 3)
                                
                                if selectedColor == colorName {
                                    Circle()
                                        .stroke(Color.white, lineWidth: 3)
                                        .frame(width: 66, height: 66)
                                    
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.white)
                                        .font(.system(size: 24, weight: .bold))
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Escolha uma Cor")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Pronto") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
        }
    }
}

struct PreviewProfileView: View {
    let userName: String
    let userAvatar: String
    let userThemeColor: String
    let userBio: String
    let getColor: (String) -> Color
    
    var body: some View {
        VStack(spacing: 25) {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(getColor(userThemeColor).opacity(0.7))
                    .frame(height: 100)
                    .cornerRadius(15, corners: [.topLeft, .topRight])
                
                Text(userAvatar)
                    .font(.system(size: 70))
                    .background(
                        Circle()
                            .fill(Color.white)
                            .frame(width: 100, height: 100)
                    )
                    .offset(y: 35)
            }
            .padding(.bottom, 35)
            
            Text(userName.isEmpty ? "Seu Nome" : userName)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(getColor(userThemeColor))
            
            if !userBio.isEmpty {
                VStack(alignment: .leading) {
                    Text("Sobre mim")
                        .font(.headline)
                        .foregroundColor(getColor(userThemeColor))
                        .padding(.bottom, 5)
                    
                    Text(userBio)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 5)
                }
                .padding(.horizontal)
            }
            
            HStack(spacing: 30) {
                VStack {
                    Text("42")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Posts")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                VStack {
                    Text("987")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Seguidores")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                VStack {
                    Text("156")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Seguindo")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1), radius: 5)
            .padding(.horizontal)
        }
        .padding(.bottom)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorners(radius: radius, corners: corners))
    }
}

struct RoundedCorners: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
