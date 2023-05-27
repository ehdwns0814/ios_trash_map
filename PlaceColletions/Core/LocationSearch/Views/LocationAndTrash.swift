//
//  LocationAndTrash.swift
//  PlaceCollections
//
//  Created by 동준 on 2023/05/26.
//


import SwiftUI

struct LocationAndTrash: View {
    
    @State private var selectedtrashType: String = "일반쓰레기"
    @State private var selectedDistrict: String = "강남구"
    
    let districts = ["강남구", "강동구", "강북구", "강서", "관악구", "광진구", "구로구", "금천구", "노원구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"]
    
    let trashs = ["일반쓰레기","재활용쓰레기","담배꽁초"]
    
    func cleanRows(file: String) -> String {
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with:  "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }
    
    // 자치구, 쓰레기 선택후에 해당되는 데이터만 추린다.
    func loadCSVData() -> [SeoulTrashCan] {
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
                if csvColumns[1] == selectedDistrict && csvColumns[5] == selectedtrashType {
                    let lineStruct = SeoulTrashCan.init(raw: csvColumns)
                    csvToStruct.append(lineStruct)
                }
            }
        }
        
        return csvToStruct
    }
    
    var body: some View {
        VStack{
            Picker(selection: $selectedDistrict, label: Text("자치구")) {
                            ForEach(districts, id: \.self) { district in
                                Text(district).tag(district)
                            }
                        }
                        .pickerStyle(DefaultPickerStyle())
                        .background(Color.yellow)
                        .padding()
                        
                        Text("선택한 자치구: \(selectedDistrict)")
                            .padding()
        }
        VStack{
            Picker(selection: $selectedtrashType, label: Text("쓰레기타입")) {
                            ForEach(trashs, id: \.self) { trash in
                                Text(trash).tag(trash)
                            }
                        }
                        .pickerStyle(DefaultPickerStyle())
                        .background(Color.yellow)
                        .padding()
                        
                        Text("선택한 쓰레기: \(selectedtrashType)")
                            .padding()
        }
        .frame(width: UIScreen.main.bounds.width - 64,
               height: 50)
        .background(
            Capsule()
                .fill(Color.white)
                .shadow(color: .black, radius: 6)
        )
    }
}

struct LocationAndTrash_Previews: PreviewProvider {
    static var previews: some View {
        LocationAndTrash()
    }
}
