import SwiftUI
import AVFoundation

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var taskManager: TaskManager
    @State private var taskTitle = ""
    @State private var taskMinutes = ""
    @State private var showSuccessAnimation = false

    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.black, Color("DarkGrayCustom")]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 25) {
                Text("Nova Missão")
                    .font(.system(size: 28, weight: .bold, design: .monospaced))
                    .foregroundColor(.green)

                VStack(spacing: 15) {
                    HStack {
                        Image(systemName: "pencil")
                            .foregroundColor(.green)
                        TextField("Título da Tarefa", text: $taskTitle)
                            .foregroundColor(.white)
                            .keyboardType(.default)
                            .font(.system(.body, design: .monospaced))
                    }
                    .padding()
                    .background(Color.white.opacity(0.07))
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green.opacity(0.3), lineWidth: 1))

                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(.yellow)
                        TextField("Tempo estimado (min)", text: $taskMinutes)
                            .keyboardType(.numberPad)
                            .foregroundColor(.white)
                            .font(.system(.body, design: .monospaced))
                    }
                    .padding()
                    .background(Color.white.opacity(0.07))
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.yellow.opacity(0.3), lineWidth: 1))
                }
                .padding(.horizontal)

                Button(action: {
                    if let minutes = Int(taskMinutes), !taskTitle.isEmpty {
                        taskManager.addTask(title: taskTitle, estimatedMinutes: minutes)
                        playSound()
                        withAnimation(.easeInOut(duration: 0.4)) {
                            showSuccessAnimation = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }) {
                    Text("Salvar Missão")
                        .font(.system(.headline, design: .monospaced))
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(12)
                        .shadow(color: Color.green.opacity(0.5), radius: 8, x: 0, y: 4)
                }
                .padding(.horizontal)

                Button("Cancelar") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.gray)
                .font(.system(.callout, design: .monospaced))
                .padding(.top, 10)
            }

            if showSuccessAnimation {
                VStack {
                    Image(systemName: "checkmark.seal.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.green)
                        .scaleEffect(showSuccessAnimation ? 1.2 : 0.8)
                        .transition(.scale)
                    Text("Missão Adicionada!")
                        .foregroundColor(.white)
                        .font(.system(.title3, design: .monospaced))
                        .bold()
                }
                .padding()
                .background(Color.black.opacity(0.85))
                .cornerRadius(20)
                .shadow(radius: 10)
            }
        }
    }

    func playSound() {
        AudioServicesPlaySystemSound(1103)
    }
}
