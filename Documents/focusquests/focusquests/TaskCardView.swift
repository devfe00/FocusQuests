import SwiftUI

struct TaskCardView: View {
    var task: Task
    @ObservedObject var taskManager: TaskManager
    @State private var showFeedback = false
    @State private var offset: CGFloat = 0
    @State private var isPressed = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(task.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .strikethrough(task.isCompleted)
                
                HStack(spacing: 12) {
                    HStack(spacing: 4) {
                        Image(systemName: "clock.fill")
                            .font(.caption)
                            .foregroundColor(.orange)
                        
                        Text("\(task.estimatedMinutes) min")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundColor(.yellow)
                        
                        Text("\(task.xpEarned()) XP")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            
            Spacer()
            
            Image(systemName: task.isCompleted ? "checkmark.seal.fill" : "hourglass")
                .foregroundColor(task.isCompleted ? .green : .yellow)
                .font(.title2)
                .symbolEffect(.bounce, value: task.isCompleted)
                .shadow(color: task.isCompleted ? .green.opacity(0.6) : .yellow.opacity(0.6), radius: 5)
        }
        .padding()
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(.systemGray6).opacity(0.2),
                                Color(.systemGray6).opacity(0.1)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                
                RoundedRectangle(cornerRadius: 15)
                    .stroke(
                        task.isCompleted ?
                            Color.green.opacity(0.8) :
                            Color.yellow.opacity(isPressed ? 0.8 : 0.3),
                        lineWidth: isPressed ? 2 : 1
                    )
                    .animation(.easeInOut(duration: 0.2), value: isPressed)
            }
        )
        .cornerRadius(15)
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .offset(x: offset)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if !task.isCompleted {
                        offset = gesture.translation.width
                    }
                }
                .onEnded { gesture in
                    if abs(gesture.translation.width) > 100 && !task.isCompleted {
                        withAnimation {
                            taskManager.completeTask(task)
                            showFeedback = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                showFeedback = false
                            }
                        }
                    }
                    withAnimation(.spring()) {
                        offset = 0
                    }
                }
        )
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    if !task.isCompleted {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            isPressed = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(.spring()) {
                                isPressed = false
                                taskManager.completeTask(task)
                                showFeedback = true
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    showFeedback = false
                                }
                            }
                        }
                    }
                }
        )
        .overlay(
            Group {
                if showFeedback {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black.opacity(0.7))
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .symbolEffect(.variableColor.cumulative.iterative, value: showFeedback)
                            
                            Text("Missão Concluída!")
                                .font(.headline)
                                .foregroundColor(.yellow)
                                .fontWeight(.bold)
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .symbolEffect(.variableColor.cumulative.iterative, value: showFeedback)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                    }
                    .frame(height: 50)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: showFeedback)
        )
        .padding(.horizontal)
        .shadow(color: task.isCompleted ? .green.opacity(0.2) : .black.opacity(0.2), radius: 8)
    }
}

struct TaskCardView_Previews: PreviewProvider {
    static var previews: some View {
        let task = Task(title: "Test Task", estimatedMinutes: 10)
        let taskManager = TaskManager()
        ZStack {
            Color.black.ignoresSafeArea()
            TaskCardView(task: task, taskManager: taskManager)
        }
    }
}
