//
//  AddAccountScreen.swift
//  BankApp
//
//  Created by Anuj Soni on 10/06/22.
//

import SwiftUI

struct AddAccountScreen: View {
    
@Environment(\.presentationMode) var presentationMode
@ObservedObject private var addAccountVM = AddAccountViewModel()
    
    
var body: some View {
        Form{
        
        TextField("Name", text:$addAccountVM.name)
        Picker(selection:$addAccountVM.accountType,
                   label:EmptyView()){
            ForEach(AccountType.allCases,id:\.self){accounttype in
        Text(accounttype.title)
        }
        }.pickerStyle(.segmented)
            
        TextField("Balance",text:$addAccountVM.balance)
            
        HStack{
        Spacer()
        Button("Submit"){
        addAccountVM.createAccount { success in
            if success{
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        }
        Spacer()
        }
        Text(addAccountVM.errorMessage)
        }
        .navigationTitle("Add Account")
        .embedInNavigationView()
    }
}

struct AddAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddAccountScreen()
    }
}

