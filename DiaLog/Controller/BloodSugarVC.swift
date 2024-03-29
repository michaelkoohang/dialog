//
//  BloodSugarVC.swift
//  DiaLog
//
//  Created by Michael on 2/4/19.
//  Copyright © 2019 Koohang. All rights reserved.
//

import UIKit
import CoreData

class BloodSugarVC: BaseVC {
    
    let segmentedControl = UISegmentedControl(items: ["Data", "Graphs"])
            
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "All Logs", style: .plain, target: self, action: #selector(showAllLogs))
        self.navigationItem.titleView = segmentedControl
//        segmentedControl.
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadGraphs()
    }
    
    func setup() {
        self.dataView.addSubview(dailyAverage)
        self.dataView.addSubview(beforeBreakfast)
        self.dataView.addSubview(afterBreakfast)
        self.dataView.addSubview(beforeLunch)
        self.dataView.addSubview(afterLunch)
        self.dataView.addSubview(beforeDinner)
        self.dataView.addSubview(afterDinner)
        self.view.addSubview(dataView)
        
        NSLayoutConstraint.activate([
            dataView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            dataView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            dataView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            dataView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
                        
            dailyAverage.topAnchor.constraint(equalTo: self.dataView.topAnchor, constant: 14),
            dailyAverage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14),
            dailyAverage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14),
            dailyAverage.heightAnchor.constraint(equalToConstant: 300),
            
            beforeBreakfast.topAnchor.constraint(equalTo: self.dailyAverage.bottomAnchor, constant: 14),
            beforeBreakfast.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14),
            beforeBreakfast.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14),
            beforeBreakfast.heightAnchor.constraint(equalToConstant: 300),
            
            afterBreakfast.topAnchor.constraint(equalTo: self.beforeBreakfast.bottomAnchor, constant: 14),
            afterBreakfast.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14),
            afterBreakfast.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14),
            afterBreakfast.heightAnchor.constraint(equalToConstant: 300),
            
            beforeLunch.topAnchor.constraint(equalTo: self.afterBreakfast.bottomAnchor, constant: 14),
            beforeLunch.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14),
            beforeLunch.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14),
            beforeLunch.heightAnchor.constraint(equalToConstant: 300),
            
            afterLunch.topAnchor.constraint(equalTo: self.beforeLunch.bottomAnchor, constant: 14),
            afterLunch.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14),
            afterLunch.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14),
            afterLunch.heightAnchor.constraint(equalToConstant: 300),
            
            beforeDinner.topAnchor.constraint(equalTo: self.afterLunch.bottomAnchor, constant: 14),
            beforeDinner.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14),
            beforeDinner.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14),
            beforeDinner.heightAnchor.constraint(equalToConstant: 300),
            
            afterDinner.topAnchor.constraint(equalTo: self.beforeDinner.bottomAnchor, constant: 14),
            afterDinner.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14),
            afterDinner.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14),
            afterDinner.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        
    }
    
    // UI Components
    
    let dataView: UIScrollView = {
        var v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 2225)
        return v
    }()
    
    let dailyAverage = BarGraphView(title: "Daily Average")
        
    let beforeBreakfast = BarGraphView(title: "Before Breakfast")
    let afterBreakfast = BarGraphView(title: "After Breakfast")
    let beforeLunch = BarGraphView(title: "Before Lunch")
    let afterLunch = BarGraphView(title: "After Lunch")
    let beforeDinner = BarGraphView(title: "Before Dinner")
    let afterDinner = BarGraphView(title: "After Dinner")
    
    // Navigation
    
    @objc func showAllLogs() {
        self.navigationController?.pushViewController(AllBloodSugarVC(), animated: true)
    }
        
    // Logic
    
    func reloadGraphs() {
        let dailyAverageData = getBloodSugar(predicate: NSPredicate(format: "type != %@", "Target"))
        dailyAverage.updateGraph(data: extractLogs(data: dailyAverageData))
        
        let beforeBreakfastData = getBloodSugar(predicate: NSPredicate(format: "type == %@", "Before Breakfast"))
        beforeBreakfast.updateGraph(data: extractLogs(data: beforeBreakfastData))
        
        let afterBreakfastData = getBloodSugar(predicate: NSPredicate(format: "type == %@", "After Breakfast"))
        afterBreakfast.updateGraph(data: extractLogs(data: afterBreakfastData))
        
        let beforeLunchData = getBloodSugar(predicate: NSPredicate(format: "type == %@", "Before Lunch"))
        beforeLunch.updateGraph(data: extractLogs(data: beforeLunchData))
        
        let afterLunchData = getBloodSugar(predicate: NSPredicate(format: "type == %@", "After Lunch"))
        afterLunch.updateGraph(data: extractLogs(data: afterLunchData))
        
        let beforeDinnerData = getBloodSugar(predicate: NSPredicate(format: "type == %@", "Before Dinner"))
        beforeDinner.updateGraph(data: extractLogs(data: beforeDinnerData))
        
        let afterDinnerData = getBloodSugar(predicate: NSPredicate(format: "type == %@", "After Dinner"))
        afterDinner.updateGraph(data: extractLogs(data: afterDinnerData))
    }
    
    func getBloodSugar(predicate: NSPredicate) -> [BloodSugar] {
        var result = [BloodSugar]()
        let fetchRequest: NSFetchRequest<BloodSugar> = BloodSugar.fetchRequest()
        fetchRequest.predicate = predicate
        do {
            result = try PersistanceService.context.fetch(fetchRequest)
            return result
        } catch {
            print("error")
        }
        return result
    }
    
    func extractLogs(data: [BloodSugar]) -> [Double] {
        var result = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        
        var sun = 0.0, sunCount = 0.0
        var mon = 0.0, monCount = 0.0
        var tue = 0.0, tueCount = 0.0
        var wed = 0.0, wedCount = 0.0
        var thu = 0.0, thuCount = 0.0
        var fri = 0.0, friCount = 0.0
        var sat = 0.0, satCount = 0.0
        
        for bs in data {
            let calendar = Calendar.current
            let day = calendar.component(.weekday, from: bs.date!)
            switch day {
            case 1:
                sun += Double(bs.value)
                sunCount += 1
            case 2:
                mon += Double(bs.value)
                monCount += 1
            case 3:
                tue += Double(bs.value)
                tueCount += 1
            case 4:
                wed += Double(bs.value)
                wedCount += 1
            case 5:
                thu += Double(bs.value)
                thuCount += 1
            case 6:
                fri += Double(bs.value)
                friCount += 1
            case 7:
                sat += Double(bs.value)
                satCount += 1
            default:
                break
            }
        }
        
        result[0] = (sunCount > 0) ? sun / sunCount : 0.0
        result[1] = (monCount > 0) ? mon / monCount : 0.0
        result[2] = (tueCount > 0) ? tue / tueCount : 0.0
        result[3] = (wedCount > 0) ? wed / wedCount : 0.0
        result[4] = (thuCount > 0) ? thu / thuCount : 0.0
        result[5] = (friCount > 0) ? fri / friCount : 0.0
        result[6] = (satCount > 0) ? sat / satCount : 0.0

        return result
    }
    
}

