//
//  AccountSummaryScreen.swift
//  BankApp
//
//  Created by Anuj Soni on 03/06/22.
//

import SwiftUI

enum ActiveSheet{
case addAccount
case transferFunds
}

struct AccountSummaryScreen: View {
    
    @ObservedObject private var accountSummaryVM:AccountSummaryViewModel = AccountSummaryViewModel()
    
    @State private var isPresented : Bool = false
    @State private var activeSheet:ActiveSheet = .addAccount
    
    var body: some View {
        
        VStack
        {
        GeometryReader{g in
            
        VStack{
        
        AccountListView(accounts: accountSummaryVM.accounts)
        .frame(height:g.size.height/2)
        Text("\(self.accountSummaryVM.total.formatAsCurrency())")
        Spacer()
        Button("Transfer Funds"){
        activeSheet = .transferFunds
        isPresented = true
        }.padding()
        }
        
        }
        }
        .onAppear(){
            self.accountSummaryVM.getAllAccounts()
        }
        .sheet(isPresented: $isPresented){
            self.accountSummaryVM.getAllAccounts()
        } content :{
            if self.activeSheet == .transferFunds{
            TransferFundsScreen()
            }
            else if self.activeSheet == .addAccount{
            AddAccountScreen()
            }
        }
        
//        .sheet(isPresented:$isPresented){
//        //             AddEmployeeView().environment(\.managedObjectContext,self.managedObjectContext)
//            AddAccountScreen()
//        }
        .navigationBarItems(trailing:Button("Add Account"){
            activeSheet = .addAccount
            isPresented = true
        })
        .navigationBarTitle("Accounts Summary")
        .embedInNavigationView()
    }
}

struct AccountSummaryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountSummaryScreen()
    }
}



