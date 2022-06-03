//
//  AccountSummaryScreen.swift
//  BankApp
//
//  Created by Anuj Soni on 03/06/22.
//

import SwiftUI

struct AccountSummaryScreen: View {
    
    @ObservedObject private var accountSummaryVM:AccountSummaryViewModel = AccountSummaryViewModel()
    
    var body: some View {
        
        VStack
        {
        GeometryReader{g in
            
        VStack{
        
        AccountListView(accounts: accountSummaryVM.accounts)
        .frame(height:g.size.height/2)
        Text("\(self.accountSummaryVM.total.formatAsCurrency())")
        Spacer()
        }
        
        }
        }
        .onAppear(){
            self.accountSummaryVM.getAllAccounts()
        }
        .navigationBarTitle("Accounts Summary")
        .embedInNavigationView()
    }
}

struct AccountSummaryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountSummaryScreen()
    }
}

