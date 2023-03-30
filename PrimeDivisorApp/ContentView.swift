//
//  ContentView.swift
//  PrimeDivisorApp
//
//  Created by 神　樹里乃 on 2023/03/30.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var listNumbers: [Int] = []
    @State private var showCount: String = ""
    @State private var isShowingAlert: Bool = false

    var body: some View {
        VStack {
            TextField("１以上の整数を入力してください", text: $inputText)
                .padding()
            HStack {
                Button {
                    print("素数ボタンがタップされた")
                    showCount = "素数"
                } label: {
                    Text("素数チェック")
                }
                .buttonStyle(.borderedProminent)
                Button {
                    print("約数ボタンがタップされた")
                    showCount = "約数"

                } label: {
                    Text("約数チェック")
                }
                .buttonStyle(.borderedProminent)
            }
            Text("\(inputText) の \(showCount) は、\(listNumbers.count + 1) 個です")
            List(listNumbers, id: \.self) { number in
                Text("\(number)")
            }
        }// VStack
        .alert("１以上の整数を入力してください", isPresented: $isShowingAlert) {
            Button("OK") { }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
