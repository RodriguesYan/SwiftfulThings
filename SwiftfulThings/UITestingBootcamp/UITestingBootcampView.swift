//
//  UITestingBootcampView.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 27/09/24.
//

import SwiftUI

class UITestingViewModel: ObservableObject {
    let placeholderText: String = "Add your name..."
    
    @Published var textFieldText: String = ""
    @Published var currentUserIsSignedIn: Bool
    
    init(currentUserIsSignedIn: Bool) {
        self.currentUserIsSignedIn = currentUserIsSignedIn
    }
    
    func signUpButtonPressed() {
        guard !textFieldText.isEmpty else { return }
        currentUserIsSignedIn = true
    }
}

struct UITestingBootcampView: View {
    @StateObject private var vm: UITestingViewModel
    
    init(currentUserIsSignedIn: Bool) {
        _vm = StateObject(wrappedValue: UITestingViewModel(currentUserIsSignedIn: currentUserIsSignedIn))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(
                    colors: [Color.blue, Color.black]
                ),
                startPoint: .topLeading, 
                endPoint: .bottomTrailing
            ).ignoresSafeArea()
            
            ZStack {
                if vm.currentUserIsSignedIn {
                    SignedInHomeView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .trailing))
                }
                
                if !vm.currentUserIsSignedIn {
                    signUpLayer
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .leading))
                }
            }
            
        }
    }
}

#Preview {
    UITestingBootcampView(currentUserIsSignedIn: true)
}

extension UITestingBootcampView {
    private var signUpLayer: some View {
        VStack  {
            TextField(vm.placeholderText, text: $vm.textFieldText)
                .font(.headline)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .accessibilityIdentifier("SignUpTextfield")
            
            Button(action: {
                withAnimation(.spring()) {
                    vm.signUpButtonPressed()
                }
            }, label: {
                Text("Sign up")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            .accessibilityIdentifier("SignUpButton")
        }
        .padding()
    }
}

struct SignedInHomeView: View {
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button(action: {
                    showAlert.toggle()
                }, label: {
                    Text("SHow welcome alert!")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                })
                .accessibilityIdentifier("ShowAlertButton")
                .alert(isPresented: $showAlert, content: {
                    return Alert(title: Text("Welcome to the app!"))
                })
                
                NavigationLink(destination: Text("Destination"), label: {
                    Text("Navigate")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                .accessibilityIdentifier("NavigationLinkToDestination")
            }
            .padding()
            .navigationTitle("Welcome")
        }
    }
}
