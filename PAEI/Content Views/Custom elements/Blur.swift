//
//  Blur.swift
//  PAEI
//
//  Created by Сергей on 26.01.2021.
//

import SwiftUI

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemThinMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}



struct BlurButton: View {
    var action: () -> Void
    let text: String
    var body: some View {
        ZStack {
            Blur()
            
            Button(action: action) {
                Text(text)
                    .bold()
                    .setBlueStyleButton()
            }
            .padding()
        }
        .frame(height: 82)
    }
}


struct BlurButton_Previews: PreviewProvider {
    static var previews: some View {
        BlurButton(action: {}, text: "Кнопка" )
    }
}


struct Blur_Previews: PreviewProvider {
    static var previews: some View {
        Blur()
    }
}
