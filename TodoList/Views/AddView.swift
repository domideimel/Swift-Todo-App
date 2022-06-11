//
//  AddView.swift
//  TodoList
//
//  Created by Dominik Deimel on 27.02.22.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldString: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here...", text: $textFieldString)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(.thinMaterial)
                    .cornerRadius(10)
                Button(action: onSaveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })

            }.padding(14)
                
        }
        .navigationTitle("Add an Item ✏️")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func onSaveButtonPressed () {
        if textIsLongEnough() {
            listViewModel.onSaveButtonPressed(title: textFieldString)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsLongEnough () -> Bool {
        if textFieldString.count < 3 {
            alertTitle = "Your new Todo Item must be at least 3 characters long."
            showAlert.toggle()
            return false
        }
        
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }

}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddView()
        }.environmentObject(ListViewModel())
    }
}
