//
//  ResultView.swift
//  PAEI
//
//  Created by Сергей on 06.01.2021.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var screenManager: ScreenManager
    @EnvironmentObject var conditionManager: СonditionManager
//    @Environment(\.colorScheme) private var colorScheme
    
    let answer: Answer
    var isNewResult = true
    
    var body: some View {
        VStack {
            ScrollView {
              
                    LazyVStack{
                        
                        Image(resultTest.picture)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: screenSize.width * 0.55, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .clipped()
                            .cornerRadius(20)
                        
                        if let shortInfo = resultTest.shortInfo {
                            Text("Вы – " + shortInfo)
                                .bold()
                                .multilineTextAlignment(.center)
                                .font(.largeTitle)
                        }
                        
                        if let characteristic = resultTest.characteristic {
                            VStack {
                                Text("Характеристика:")
                                    .bold()
                                    .padding(EdgeInsets(top: 0,
                                                        leading: 0,
                                                        bottom: 4,
                                                        trailing: 0))
                                Text(characteristic)
                            }
                            .setCustomBackgroung()
                        }
                        
                        if  let qualities = resultTest.qualities {
                            VStack {
                                Text("Качества:")
                                    .bold()
                                    .padding(EdgeInsets(top: 0,
                                                        leading: 0,
                                                        bottom: 4,
                                                        trailing: 0))
                                HStack {
                                    VStack(alignment: .leading){
                                        ForEach(qualities, id: \.self) {quality in
                                            Text("– \(quality)")
                                                .multilineTextAlignment(.leading)
                                        }
                                    }
                                    Spacer()
                                }
                            }
                            .setCustomBackgroung()
                        }
                        if let skills = resultTest.skills {
                            VStack {
                                Text("Навыки:")
                                    .bold()
                                    .padding(EdgeInsets(top: 0,
                                                        leading: 0,
                                                        bottom: 4,
                                                        trailing: 0))
                                HStack {
                                    VStack(alignment: .leading){
                                        ForEach(skills, id: \.self) {quality in
                                            Text("– \(quality)")
                                                .multilineTextAlignment(.leading)
                                        }
                                    }
                                    Spacer()
                                }
                            }
                            .setCustomBackgroung()
                        }
                        
                        VStack {
                            CircleProgressBar(
                                currentValue: answer.producer,
                                maxValue: 48,
                                insideLabel: "P=\(answer.producer)"
                            )
                            .frame(height: 100)
                            .padding(EdgeInsets(top: 0,
                                                leading: 0,
                                                bottom: 8,
                                                trailing: 0))
                            
                            Text(detailedResult.pCharacteristic)
                        }
                        .setCustomBackgroung()
                        
                        VStack {
                            CircleProgressBar(
                                currentValue: answer.administrator,
                                maxValue: 48,
                                insideLabel: "A=\(answer.administrator)"
                            )
                            .frame(height: 100)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                            
                            Text(detailedResult.aCharacteristic)
                        }
                        .setCustomBackgroung()
                        
                        VStack {
                            CircleProgressBar(
                                currentValue: answer.entrepreneur,
                                maxValue: 48,
                                insideLabel: "E=\(answer.entrepreneur)"
                            )
                            .frame(height: 100)
                            .padding(EdgeInsets(top: 0,
                                                leading: 0,
                                                bottom: 8,
                                                trailing: 0))
                            
                            Text(detailedResult.eCharacteristic)
                        }
                        .setCustomBackgroung()
                        
                        VStack {
                            CircleProgressBar(
                                currentValue: answer.integrator,
                                maxValue: 48,
                                insideLabel: "I=\(answer.integrator)"
                            )
                            .frame(height: 100)
                            .padding(EdgeInsets(top: 0,leading: 0,bottom: 8,trailing: 0))
                            
                            Text(detailedResult.iCharacteristic)
                        }
                        .setCustomBackgroung()
                        
                        
                        if !isNewResult {
                            Button(action: {
                                screenManager.isModalPresentResultView = false
                                DataManager.shared.clear(
                                    conditionManager: conditionManager
                                )
                                
                            }) {
                                Text("Удалить результат")
                                    .bold()
                                    .setBlueStyleButton(color: .red)
                            }
                            .padding(EdgeInsets(top: 16,leading: 0,bottom: 0 ,trailing: 0))
                        }
                    }
                    .padding(EdgeInsets(top: 0,leading: 0,bottom: 4 ,trailing: 0))
//                    .shadow(color: shadowColor.opacity(0.5), radius: 25, x: 0, y: 0)
                    
            
                .padding()
            }
            .shadow(radius: 25)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Ваш ключ: \(paeiKey)")
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button(action: {}) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
            
            //кнопка выхода
            if isNewResult {
                Button(action: {
                    screenManager.isModalPresentPassingTest = false
                    screenManager.isModalPresentResultView = false
                }) {
                    Text("Выход")
                        .bold()
                        .setBlueStyleButton()
                }
                .padding()
            }
        }
    }
}


extension ResultView {
    //MARK: - Properties
    
    private var screenSize: CGSize {
        UIScreen.main.bounds.size
    }
    private var paeiKey: String{
        calculateResultKey(from: answer)
    }
    
    private var resultTest: Result {
        Result.getResult(text: paeiKey)
    }
    
    private var detailedResult: DetailedResult {
        DetailedResult.customPael(key: paeiKey)
    }
    
//    private var shadowColor: Color {
//        colorScheme == .dark ? .blue : .gray
//    }
    
}


extension ResultView {
    //MARK: - Расчет ключа paei
    private func calculateResultKey(from answer: Answer) -> String {
        var paelKey = ""
        
        paelKey += identify(characters: ["P", "p"], from: answer.producer)
        paelKey += identify(characters: ["A", "a"], from: answer.administrator)
        paelKey += identify(characters: ["E", "e"], from: answer.entrepreneur)
        paelKey += identify(characters: ["I", "i"], from: answer.integrator)
        
        return paelKey
    }
    
    //MARK: - Логика определения буквы для ключа pael
    private func identify(characters: [String], from number: Int) -> String {
        var characterForKey = ""
        
        assert(characters.count == 2, "Передан неверный массив")
        
        switch number {
        case 30...:
            characterForKey = characters.first ?? "😱"
        case 20..<30:
            characterForKey = characters.last ?? "😱"
        default:
            characterForKey = "-"
        }
        
        return characterForKey
    }
    //MARK: - Вытаскиваем нужный символ из строки
    private func getСharacter(number: Int, from string: String) -> String {
        let index = string.index(string.startIndex, offsetBy: number)
        return String(string[index])
    }
    
}

/*
 struct TextBlock: View {
 @Environment(\.colorScheme) private var colorScheme
 let text: String
 var body: some View {
 ZStack {
 RoundedRectangle(cornerRadius: 20.0)
 .foregroundColor(colorScheme == .dark ? .customGray : .white)
 //                .shadow(color: shadowColor.opacity(0.5), radius: 25, x: 0, y: 0)
 
 Text(text)
 .padding()
 }
 }
 
 private var shadowColor: Color {
 colorScheme == .dark ? .blue : .gray
 }
 }
 */





struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
       
            ResultView(answer: Answer())
//                .preferredColorScheme(.dark)
                .environmentObject(ScreenManager())
            
    }
}
/*
 struct TextBlock_Previews: PreviewProvider {
 static var previews: some View {
 TextBlock(text: "hinkjnkn")
 }
 }
 */



/*
 //MARK: - Расчет ключа paei
 private func calculateResultTest(from answers: [Answer]) -> String {
 var paelKey = ""
 var pointsAccumulated: (p: Int, a: Int, e: Int, i:Int) = (0, 0, 0, 0)
 
 answers.forEach { answer in
 pointsAccumulated.p += answer.producer
 pointsAccumulated.a += answer.administrator
 pointsAccumulated.e += answer.entrepreneur
 pointsAccumulated.i += answer.integrator
 }
 
 paelKey += identify(characters: ["P", "p"], from: pointsAccumulated.p)
 paelKey += identify(characters: ["A", "a"], from: pointsAccumulated.a)
 paelKey += identify(characters: ["E", "e"], from: pointsAccumulated.e)
 paelKey += identify(characters: ["I", "i"], from: pointsAccumulated.i)
 
 return paelKey
 }
 
 */


