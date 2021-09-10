//
//  SchedulingHelper.swift
//  aimoon-main
//
//  Created by Maxim Skorynin on 13.04.2021.
//  Copyright © 2021 Maxim Skorynin. All rights reserved.
//

protocol Schedulable: AnyObject {
    
    func completeTask(_ task: SchedulingHelper.Task)
    
}

final class SchedulingHelper {
    
    static let shared = SchedulingHelper()
    
    private var tasks: Set<Task> = []
    
    weak var delegate: Schedulable?
    
    // MARK: - Life Cycle
    
    private init() {
        Events.shared.addTarget(self)
    }
    
    // MARK: - Public Functions
    
    func scheduleTask(_ task: SchedulingHelper.Task) {
        tasks.insert(task)
    }
    
    func removeTask(_ task: SchedulingHelper.Task) {
        tasks.remove(task)
    }
    
    // MARK: - Private Functions
    
    private func completeTask(_ task: SchedulingHelper.Task) {
        guard tasks.contains(task) else {
            return
        }
        
        switch task {
            case .openUserOrders:
                delegate?.completeTask(task)
        }
        
        tasks.remove(task)
    }
    
}

// MARK: - Eventable

extension SchedulingHelper: Eventable {
    
    func handleEvent(_ message: Events.Message) {
        switch message {
            case .profileViewDidAppear:
                completeTask(.openUserOrders)
            
            default:
                break
        }
    }
    
}
