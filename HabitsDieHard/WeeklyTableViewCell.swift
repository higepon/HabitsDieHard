//
//  WeeklyTableViewCell.swift
//  HabitsDieHard
//
//  Created by Taro Minowa on 8/20/16.
//  Copyright © 2016 Higepon Taro Minowa. All rights reserved.
//

import UIKit

class WeeklyTableViewCell: UITableViewCell {
    @IBOutlet weak var mondayView: UIView!
    @IBOutlet weak var tuesdayView: UIView!
    @IBOutlet weak var wednesdayView: UIView!
    @IBOutlet weak var thursdayView: UIView!
    @IBOutlet weak var fridayView: UIView!
    @IBOutlet weak var saturdayView: UIView!
    @IBOutlet weak var sundayView: UIView!
    let borderColor = UIColor.gray.cgColor
    let borderWidth: CGFloat = 0.5
    var weekDayViews: [UIView] = []
    var habitLogsForTargetWeek: [HabitLog] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        let selector = #selector(WeeklyTableViewCell.dayTapped)
        weekDayViews = [mondayView, tuesdayView, wednesdayView, thursdayView, fridayView, saturdayView, sundayView]
        weekDayViews.forEach { (view) in
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: selector))
            view.layer.borderWidth = borderWidth
            view.layer.borderColor = borderColor
        }
    }

    func dayTapped(_ gestureRecognizer: UIGestureRecognizer) {
        gestureRecognizer.view?.backgroundColor = UIColor.green
        if let view: UIView = gestureRecognizer.view {
            if let habitLog: HabitLog = viewToHabitLog(view) {
                switch habitLog.state {
                case .Done:
                    habitLog.state = .Missed
                case .Missed:
                    habitLog.state = .Unassigned
                case .Unassigned:
                    habitLog.state = .Done
                }
            }
            setNeedsLayout()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        weekDayViews.forEach { (view) in
            if let habitLog: HabitLog = viewToHabitLog(view) {
                switch habitLog.state {
                case .Done:
                    view.backgroundColor = UIColor.green
                case .Missed:
                    view.backgroundColor = UIColor.red
                case .Unassigned:
                    view.backgroundColor = UIColor.white
                }
            }
        }

    }

    fileprivate func viewToHabitLog(_ view: UIView) -> HabitLog? {
        let index = dayIndexFromGestureRecognizer(view)
        if index == -1 {
            return nil
        } else if (habitLogsForTargetWeek.count > index) {
            return habitLogsForTargetWeek[index]
        } else {
            return nil
        }
    }


    fileprivate func dayIndexFromGestureRecognizer(_ view: UIView) -> Int {
        for i in 0...weekDayViews.count {
            if weekDayViews[i] == view {
                return i
            }
        }
        // Never reached
        return -1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
