//
//  ButtonStyle.swift
//  PAEI
//
//  Created by Сергей on 08.01.2021.
//

import SwiftUI
//
//struct BlueStyleButton: ButtonStyle {
//    func makeBody(configuration: Self.Configuration) -> some View {
//            configuration.label
//                .foregroundColor(.white)
//                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
////                .padding()
//                .background( Color.blue)
//
//
//                .cornerRadius(15.0)
//        }
//}
//
//struct ButtonStyle_Previews: PreviewProvider {
//    static var previews: some View {
//        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//            Text("Button")
//        }) .buttonStyle(BlueStyleButton() )
//    }
//}




struct BlueStyleButton: ViewModifier {
    let disabledStyle: Bool
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(.white)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 44, maxHeight: 50)
            .background(disabledStyle ? Color.blue.opacity(0.4) : .blue)
            .cornerRadius(10)
    }
    
}

extension View {
    func setBlueStyleButton(disabledStyle: Bool) -> some View {
        self.modifier(BlueStyleButton(disabledStyle: disabledStyle))
    }
}

struct BlueStyleButton_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            Text("Button")
                .setBlueStyleButton(disabledStyle: true)
        })
    }
}
