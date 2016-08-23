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
    let borderColor = UIColor.grayColor().CGColor
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

        // this is temporary faked data
        // todo: Take care of order later
        habitLogsForTargetWeek = [
            HabitLog(date: NSDate(dateString: "2016-08-22")),
            HabitLog(date: NSDate(dateString: "2016-08-23")),
            HabitLog(date: NSDate(dateString: "2016-08-24")),
            HabitLog(date: NSDate(dateString: "2016-08-25")),
            HabitLog(date: NSDate(dateString: "2016-08-26")),
            HabitLog(date: NSDate(dateString: "2016-08-27")),
        ]
    }

    func dayTapped(gestureRecognizer: UIGestureRecognizer) {
        gestureRecognizer.view?.backgroundColor = UIColor.greenColor()
        if let view: UIView = gestureRecognizer.view {
            if let habitLog: HabitLog = viewToHabitLog(view) {
                habitLog.done = !habitLog.done
                view.backgroundColor = habitLog.done ? UIColor.greenColor() : UIColor.redColor()
            }
        }
    }

    private func viewToHabitLog(view: UIView) -> HabitLog? {
        let index = dayIndexFromGestureRecognizer(view)
        if index == -1 {
            return nil
        } else {
            return habitLogsForTargetWeek[index]
        }
    }


    private func dayIndexFromGestureRecognizer(view: UIView) -> Int {
        for i in 0...weekDayViews.count {
            if weekDayViews[i] == view {
                return i
            }
        }
        // Never reached
        return -1
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
