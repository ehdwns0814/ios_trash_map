//
//  HandleCSV.swift
//  PlaceCollections
//
//  Created by 동준 on 2023/05/20.
//

import Foundation


func cleanRows(file: String) -> String {
    var cleanFile = file
    cleanFile = cleanFile.replacingOccurrences(of: "\r", with:  "\n")
    cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
    return cleanFile
}

func loadCSVData(trashType: TrashType) -> [SeoulTrashCan] {
    var csvToStruct = [SeoulTrashCan]()
    
    // Locate the CSV file
    guard let filePath = Bundle.main.path(forResource: "SeoulTrashCan", ofType: "csv") else {
        print("Error: file not found")
        return []
    }
    
    // Convert the contents of the file into one very long string
    var data = ""
    do{
        data = try String(contentsOfFile: filePath)
    } catch {
        print(error)
        return []
    }
    
    // Clean up the \r and \n occurances
    data = cleanRows(file: data)
    
    // Split the long string into an array of 'rows' of data. Each row is a String.
    // When we detect the \n
    var rows = data.components(separatedBy: "\n")

    // Remove the header 첫째 줄 지우기
    rows.removeFirst()
    
    // Now loop around and split each row into columns
    for row in rows {
        let csvColumns = row.components(separatedBy: ";")
        if csvColumns.count == rows.first?.components(separatedBy: ";").count {
            //** 쓰레기 종류 타입
            switch trashType{
            case .generalTrash:
                if csvColumns[5] == "일반쓰레기" {
                    let lineStruct = SeoulTrashCan.init(raw: csvColumns)
                    csvToStruct.append(lineStruct)
                    break
                }
                else{
                    break
                }
            case .recyclableWaste:
                if csvColumns[5] == "재활용쓰레기" {
                    let lineStruct = SeoulTrashCan.init(raw: csvColumns)
                    csvToStruct.append(lineStruct)
                    break
                }
                else{
                    break
                }
            case .cigaretteButt:
                if csvColumns[5] == "담배꽁초" {
                    let lineStruct = SeoulTrashCan.init(raw: csvColumns)
                    csvToStruct.append(lineStruct)
                    break
                }
                else{
                    break
                }
            }
            
//            let lineStruct = SeoulTrashCan.init(raw: csvColumns)
            
        }
    }
    
    return csvToStruct
}
 
