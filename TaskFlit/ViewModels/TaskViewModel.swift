//
//  TaskViewModel.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import Foundation

@Observable
class TaskViewModel {
    var allTasks: [TaskItem] = []
    
    var selectedFilter: AppFilter = .all
    
    enum AppFilter: String, CaseIterable, Identifiable {
        case all = "Todas"
        case pending = "Pendentes"
        case completed = "Concluídas"
        
        var id: String { self.rawValue }
    }

    init() {
        fetchTasks()
    }
    
    func fetchTasks() {
        self.allTasks = StorageService.loadTasks()
    }
    
    var filteredTasks: [TaskItem] {
        switch selectedFilter {
        case .all:
            return allTasks
        case .pending:
            return allTasks.filter { !$0.isCompleted }
        case .completed:
            return allTasks.filter { $0.isCompleted }
        }
    }
    
    func toggleTaskCompletion(task: TaskItem) {
        if let index = allTasks.firstIndex(where: { $0.id == task.id }) {
            allTasks[index].isCompleted.toggle()
            StorageService.saveTasks(allTasks)
        }
    }

    func addTask(_ task: TaskItem) {
        allTasks.insert(task, at: 0)
        StorageService.saveTasks(allTasks)
    }
    
    func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            let taskToDelete = filteredTasks[index]
            
            if let mainIndex = allTasks.firstIndex(where: { $0.id == taskToDelete.id }) {
                allTasks.remove(at: mainIndex)
            }
        }
    }
    func updateTask(_ updatedTask: TaskItem) {
        if let index = allTasks.firstIndex(where: { $0.id == updatedTask.id }) {
            allTasks[index] = updatedTask
            StorageService.saveTasks(allTasks)
        }
    }
}
