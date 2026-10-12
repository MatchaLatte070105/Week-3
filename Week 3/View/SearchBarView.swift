//
//  SearchBarView.swift
//  Week 3
//
//  Created by MAY 04 on 5/10/26.
//

import SwiftUI

struct SearchBarView: View {

    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        HStack(spacing: 12) {

            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField(
                "Tìm kiếm cá cảnh, phụ kiện...",
                text: $viewModel.searchText
            )
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()

            if !viewModel.searchText.isEmpty {
                Button {
                    viewModel.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
            }

            Button {
                viewModel.openImagePicker()
            } label: {
                Image(systemName: "camera")
                    .foregroundStyle(.teal)
                    .font(.title3)
            }
        }
        .padding()
        .background(
            Color(.secondarySystemBackground),
            in: RoundedRectangle(cornerRadius: 12)
        )
    }
}

#Preview {
    SearchBarView(viewModel: SearchViewModel())
}

 
