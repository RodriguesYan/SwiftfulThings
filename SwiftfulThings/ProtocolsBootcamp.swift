//
//  ProtocolsBootcamp.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 17/09/24.
//

import SwiftUI

struct DefaultColorTheme: ColorThemeProtocol {
    let  primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct AlternativeColorTheme: ColorThemeProtocol  {
    let  primary: Color = .red
    let secondary: Color = .white
    let tertiary: Color = .green
}

struct AnotherColorTheme: ColorThemeProtocol {
    var primary: Color = .blue
    var secondary: Color = .white
    var tertiary: Color = .purple
}

protocol ColorThemeProtocol {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}

protocol ButtonTextProtocol {
    var buttonText: String { get }
}

protocol ButtonPressedProtocol {
    func buttonPressed()
}

protocol ButtonDatasourceProtocol: ButtonPressedProtocol, ButtonTextProtocol {
    
}

class DefaultDatasource: ButtonDatasourceProtocol {
    var buttonText: String = "Blablebfdsafsdfli"
    
    func buttonPressed() {
        print("button was pressed")
    }
}

class AlternativeDatasource: ButtonTextProtocol  {
    var buttonText: String = "Vravrevri"
}

struct ProtocolsBootcamp: View {
    let colorTheme: ColorThemeProtocol
    let datasource: ButtonDatasourceProtocol
    
    var body: some View {
        ZStack {
            colorTheme.tertiary
                .ignoresSafeArea()
            
            Text(datasource.buttonText)
                .font(.headline)
                .foregroundColor(colorTheme.secondary)
                .padding()
                .background(colorTheme.primary)
                .cornerRadius(10)
                .onTapGesture {
                    datasource.buttonPressed()
                }
        }
    }
}

#Preview {
    ProtocolsBootcamp(
        colorTheme: AnotherColorTheme(),
        datasource: DefaultDatasource()
    )
}
