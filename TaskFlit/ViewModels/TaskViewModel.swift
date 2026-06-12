//
//  TaskViewModel.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import Foundation

@Observable //ta sendo obervando os estados de alteracao
class TaskViewModel {
    var allTasks: [TaskItem] = [] //dona de todas as tasks
    var selectedFilter: AppFilter = .all
    var searchText: String = ""
    
    enum AppFilter: String, CaseIterable, Identifiable { //nao deixa textos soltos
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

    var filteredTasks: [TaskItem] { //filtro e busca
        
        let tasksByStatus: [TaskItem]
        
        switch selectedFilter {
        case .all:
            tasksByStatus = allTasks
        case .pending:
            tasksByStatus = allTasks.filter { !$0.isCompleted }
        case .completed:
            tasksByStatus = allTasks.filter { $0.isCompleted }
        }

        if searchText.isEmpty {
            return tasksByStatus
        } else {
            return tasksByStatus.filter { task in
                task.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    func toggleTaskCompletion(task: TaskItem) { //alterar
        if let index = allTasks.firstIndex(where: { $0.id == task.id }) {
            allTasks[index].isCompleted.toggle()
            StorageService.saveTasks(allTasks)
        }
    }

    func addTask(_ task: TaskItem) { //adicionar
        allTasks.insert(task, at: 0)
        StorageService.saveTasks(allTasks)
    }
    
    func deleteTask(at offsets: IndexSet) { //deletar
        for index in offsets {
            let taskToDelete = filteredTasks[index]
            
            if let mainIndex = allTasks.firstIndex(where: { $0.id == taskToDelete.id }) {
                allTasks.remove(at: mainIndex)
            }
        }
    }
    func updateTask(_ updatedTask: TaskItem) { //atualizar
        if let index = allTasks.firstIndex(where: { $0.id == updatedTask.id }) {
            allTasks[index] = updatedTask
            StorageService.saveTasks(allTasks)
        }
    }
}
