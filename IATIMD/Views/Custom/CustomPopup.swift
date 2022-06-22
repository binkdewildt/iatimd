//
//  CustomPopup.swift
//  IATIMD
//
//  Created by Bink de Wildt on 17/06/2022.
//

import SwiftUI

struct CustomPopup: View {
  // MARK: - Properties
  var alertType: AlertTypes = .normal
  var title, image: String
  var text: String
  var dismissText: String?
  @Binding var isPresented: Bool
  var action: () -> Void
  var dismissAction: () -> Void
  
  
  // MARK: - Body
  var body: some View {
    GeometryReader { geo in

      Color.black.opacity(0.7)
        .edgesIgnoringSafeArea(.all)
        .allowsHitTesting(false)

      VStack {
        ZStack (alignment: .top)  {

          // Icon
          ZStack {
            Circle()
              .foregroundColor(Color.white)
              .frame(width: 87, height: 87)
              .shadow(radius: 4)

            Image(systemName: image.isEmpty ? alertType.image : image)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 40, height: 40)
              .foregroundColor(Color.white)
              .padding(20)
              .background( alertType.defaultColor )
              .clipShape(Circle())

          } //: ZSTACK
          .offset(y: -87 / 2)   // height / 2
          .zIndex(1)

          VStack (spacing: 30) {

            // Title
            Text(title.isEmpty ? alertType.defaultTitle : title)
              .font(.system(size: 24))
              .padding(.top, 35)


            // Text
            Text(text)
              .font(.system(size: 17))
              .multilineTextAlignment(.center)


            // Spacer
            Spacer()


            // Buttons
            if (alertType == .normal || alertType == .help) {
              CustomButton(buttonType: .primary, text: alertType.defaultButtonText) {

                // Dismiss the view here
                withAnimation() { isPresented.toggle() }

              }

            }

            // Error button
            else if (alertType == .error) {
              
              VStack (spacing: 5) {
                if (self.dismissText != nil) {
                  CustomButton(buttonType: .error, text: dismissText!) {
                    withAnimation() {
                      self.dismissAction()
                    }
                  }
                }
                
                CustomButton(buttonType: self.dismissText == "" ? .error : .errorSecondary, text: alertType.defaultButtonText) {

                  // Dismiss the view here
                  withAnimation() { isPresented.toggle() }

                }
              }
            }


            // Confirm buttons
            else if (alertType == .confirm) {
              VStack (spacing: 5) {
                CustomButton(buttonType: .secondary, text: dismissText ?? "Cancel") {

                  // Dismiss the view here
                  withAnimation() {
                    self.dismissAction()
                    isPresented.toggle()
                  }

                }

                CustomButton(buttonType: .primary, text: alertType.defaultButtonText) {

                  // Handle action here
                  self.action()

                  // Dismiss the view here
                  withAnimation() { isPresented.toggle() }

                }
              } //: VSTACK
            }



          } //: VSTACK
          .padding(30)
          .frame(maxWidth: getRect().width < 300 ? getRect().width * 0.7 : 300,
                 maxHeight: getRect().height < 400 ? getRect().height / 2.2 : 400)
          .background( Color.white )
          .cornerRadius( 10 )
        } //: ZSTACK

      } //: VSTACK
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

    } //: GEO READER
  }
}


// MARK: - Preview
struct CustomPopup_Previews: PreviewProvider {
  static var previews: some View {
    CustomPopup(
      title: "", image: "", text: "", isPresented: .constant(true)) {
        print("Hello world")
      } dismissAction: {
        
      }

  }
}
