//
//  CustomInputField.swift
//  PlaceColletions
//
//  Created by 동준 on 2023/05/10.
//

import SwiftUI

struct CustomInputField: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            
            Text(title)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .foregroundColor(.white)
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(.white)
            }
       
            Rectangle()
                .foregroundColor(Color(.init(white: 1, alpha: 0.3)))
                .frame(width: UIScreen.main.bounds.width - 32,
                       height: 0.7)
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(text: .constant(""), title: "이메일", placeholder: "dong01@example.com")
    }
}

