import SwiftUI

struct ContentView: View {
    @StateObject private var taskManager = TaskManager()
    @State private var showingAddTask = false
    @State private var animateGradient = false
    
    @AppStorage("userName") var userName: String = ""
    @AppStorage("userAvatar") var userAvatar: String = "🧑‍💻"

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.8), Color.black]),
                               startPoint: animateGradient ? .topLeading : .bottomTrailing,
                               endPoint: animateGradient ? .bottomTrailing : .topLeading)
                    .ignoresSafeArea()
                    .animation(Animation.easeInOut(duration: 5.0).repeatForever(autoreverses: true), value: animateGradient)
                    .onAppear {
                        animateGradient.toggle()
                    }

                VStack(spacing: 20) {
                    HStack {
                        Text(userAvatar)
                            .font(.system(size: 45))
                            .shadow(color: .white.opacity(0.5), radius: 2)
                        
                        VStack(alignment: .leading) {
                            Text(userName.isEmpty ? "Aventureiro" : userName)
                                .font(.title2)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            
                            Text("FocusQuests")
                                .font(.system(size: 28, weight: .heavy))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .shadow(color: .green.opacity(0.6), radius: 4)
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                    .padding()
                    
                    VStack(spacing: 6) {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("Nível: \(taskManager.level)")
                                .font(.headline)
                                .foregroundColor(.green)
                                .fontWeight(.bold)
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }

                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 14)
                                .foregroundColor(.gray.opacity(0.4))

                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: CGFloat(taskManager.currentXPPercentage) * 200, height: 14)
                                .foregroundColor(.green)
                                .animation(.spring(), value: taskManager.currentXPPercentage)
                        }
                        .frame(width: 200)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white.opacity(0.5), lineWidth: 2)
                        )
                    }

                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(taskManager.tasks) { task in
                                TaskCardView(task: task, taskManager: taskManager)
                                    .transition(.scale.combined(with: .opacity))
                                    .animation(.spring(), value: task.isCompleted)
                            }
                        }
                        .padding()
                    }

                    Button(action: {
                        withAnimation(.spring()) {
                            showingAddTask.toggle()
                        }
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                            Text("Nova Missão")
                                .fontWeight(.heavy)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.green, Color.green.opacity(0.7)]),
                                          startPoint: .leading, endPoint: .trailing)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(18)
                        .shadow(color: .green.opacity(0.5), radius: 5, x: 0, y: 3)
                    }
                    .padding([.horizontal, .bottom])
                    .buttonStyle(ScaleButtonStyle())
                    .sheet(isPresented: $showingAddTask) {
                        AddTaskView(taskManager: taskManager)
                    }
                }

                if taskManager.justLeveledUp {
                    Color.black.opacity(0.7)
                        .ignoresSafeArea()
                        .transition(.opacity)
                    
                    VStack {
                        Image(systemName: "star.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.yellow)
                            .symbolEffect(.bounce, options: .repeating)
                        
                        Text("NÍVEL CONQUISTADO!")
                            .font(.system(size: 32, weight: .black))
                            .foregroundColor(.yellow)
                            .padding()
                            .glow(color: .yellow, radius: 5)
                        
                        Text("Você alcançou o nível \(taskManager.level)!")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    .padding(30)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.black.opacity(0.9))
                            .shadow(color: .yellow.opacity(0.6), radius: 20)
                    )
                    .transition(.scale.combined(with: .slide))
                    .animation(.spring(response: 0.6, dampingFraction: 0.7), value: taskManager.justLeveledUp)
                }
            }
            .navigationBarHidden(true)
        }
    }
}
 
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.spring(response: 0.3), value: configuration.isPressed)
    }
}

extension View {
    func glow(color: Color, radius: CGFloat) -> some View {
        self
            .shadow(color: color, radius: radius / 2)
            .shadow(color: color, radius: radius / 2)
    }
}



//código finalizado, agora é só esperar os bugs aparecerem
  //Fe – o dev mestre dos bugs
  
  /*
       ,--./,-.        </ >ˆ$
      / #      /
     |       |
      \        \
       `._,._,'
  */
