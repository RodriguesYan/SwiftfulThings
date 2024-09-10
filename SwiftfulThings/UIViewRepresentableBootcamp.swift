//
//  UIViewRepresentableBootcamp.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 10/09/24.
//

import SwiftUI

struct UIViewRepresentableBootcamp: View {
    @State private var text: String = ""
    var body: some View {
        VStack {
            Text(text)
            HStack {
                Text("SwiftUI:")
                TextField(
                    "Type here...",
                    text: $text
                )
                    .frame(height: 55)
                .background(Color.gray)
            }
            HStack {
                Text("UIkit:")
                UITextFieldVIewRepresentable(
                    text: $text
                )
                .updatePlaceholder("New placeholder!!!")
                    .frame(height: 55)
                    .background(Color.gray)
            }
          
        }
    }
}

#Preview {
    UIViewRepresentableBootcamp()
}

struct UITextFieldVIewRepresentable: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    let placeholderColor: UIColor
    
    init (text: Binding<String>, placeholder: String = "Default placeholder ...", placeholderColor: UIColor = .red) {
        self._text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textfield = getTextfile()
        textfield.delegate = context.coordinator
        return textfield
    }
    
    //Send data from SwiftUI to UIKit
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    private func getTextfile() -> UITextField {
        let textfield = UITextField(frame: .zero)
        let placeholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: placeholderColor
            ]
        )
        textfield.attributedPlaceholder = placeholder
        return textfield
    }
    
    func updatePlaceholder(_ text: String) -> UITextFieldVIewRepresentable {
        var viewRepresentable = self
        viewRepresentable.placeholder = text
        return viewRepresentable
    }
    //Send data from UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}

struct BasicUIViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
