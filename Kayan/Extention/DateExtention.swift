//
//  DateExtention.swift
//  Kayan
//
//  Created by Sandal on 08/10/1442 AH.
//

import Foundation

extension Date
{
    func toString(dateFormat format: String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}

class StringFunction{
    func numberStrToEnglish(numberStr: String )->String{
           let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: "EN") as Locale?
           let final = formatter.number(from: numberStr)
           return "\(final!)"
    }
}
