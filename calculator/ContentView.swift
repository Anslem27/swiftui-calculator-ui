//
//  ContentView.swift
//  calculator
//
//  Created by Anslem on 09/02/2024.
//

import SwiftUI


enum CalcButtons: String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color{
        switch self{
        case .add, .multiply,.divide,.subtract,.equal:
            return .orange
            
        case .clear,.negative, .percent:
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
        
    }
    
}

enum Operations{
    case add, subtract, multiply, divide, equal, none
}

struct ContentView: View {
    
    @State var calcValue = "0"
    @State var runningValue = 0
    @State var currentOperation: Operations = .none
    
//  @State private var showSheet = false
    
    let buttons:[[CalcButtons]]=[
        [.clear,.negative,.percent, .divide],
        [.seven,.eight,.nine,.multiply],
        [.four,.five,.six,.subtract],
        [.one,.two,.three,.add],
        [.zero, .decimal, .equal]
    ]
    
    func getButtonWidth(item:CalcButtons)->CGFloat{
        
        if item == .zero{
            return ((UIScreen.main.bounds.width-(4*12))/4)*2
        }
        return (UIScreen.main.bounds.width-(5*12))/4
    }
    
    func getButtonHeight()-> CGFloat{
        return (UIScreen.main.bounds.width-(5*12))/4
    }
    
    // not complement. Clearly was too lazy
    func tapButton(button:CalcButtons){
        
        switch button{
        case .add, .subtract, .divide, .multiply,.equal:
            
            if button == .add {
                self.currentOperation = .add
                self.runningValue += Int(self.calcValue) ?? 0
                
            } else if button == .divide {
                self.currentOperation = .divide
                
            }else if button == .multiply {
                self.currentOperation = .multiply
                
            }else if button == .equal {
                self.currentOperation = .equal
                
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                
            }
            break
        case .decimal, .negative, .percent:
            break
        case .clear:
            
            self.calcValue = "0"
            break
            
        default:
            let number = button.rawValue
            if self.calcValue == "0" {
                print(self.calcValue)
                calcValue = number
            }else{
                self.calcValue = "\(self.calcValue)\(number)"
            }
            break
        }
        
    }
    var body: some View {
       
        NavigationView{
            ZStack(){
                VStack(){
                   Spacer() // push body to the bottom
                    HStack(){
                        Spacer()
                        Text(calcValue).font(.system(size: 64)).bold().padding()
                    }
                    Divider().padding(.leading,8).padding(.trailing,8).frame(height: 10)
                    
                    ForEach(buttons, id: \.self){ row in
                        HStack (spacing:12){
              
                            ForEach(row, id:\.self){ item in
                                Button(action: {
                                    self.tapButton(button: item)
                                },
                                    label: {
                                    Text(item.rawValue)
                                        .font(.system(size: 32))
                                        .frame(width: self.getButtonWidth(item: item), height: self.getButtonHeight())
                                        .background(item.buttonColor).foregroundColor(Color.white)
                                        .cornerRadius(35)
                                })
                                 
                            }
                        }.padding(.bottom,3)
                    }
                }
            }.navigationTitle("Calculator")
                
        }
    }
}

#Preview {
    ContentView()
}
