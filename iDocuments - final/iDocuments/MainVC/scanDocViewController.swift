//
//  scanDocViewController.swift
//  iDocuments
//
//  Created by Martina on 01/06/22.
//

import UIKit
import CoreNFC


class scanDocViewController: UIViewController {
    
    // var session: NFCNDEFReaderSession?
    var session: NFCTagReaderSession?
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startScanning()
        
    }

    func startScanning() {
        guard session == nil else {
            return
        }
        session = NFCTagReaderSession(pollingOption: [.iso18092, .iso14443, .iso15693], delegate: self)
        session?.alertMessage = "Hold your iPhone near the item to learn more about it."
        session?.begin()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session = nil
    }

}


//extension scanDocViewController: NFCNDEFReaderSessionDelegate {
//
//
//    // MARK: - NFCNDEFReaderSessionDelegate
//
//    /// - Tag: processingTagData
//    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
//
//        guard
//            let ndefMessage = messages.first,
//            let record = ndefMessage.records.first,
//            record.typeNameFormat == .absoluteURI || record.typeNameFormat == .nfcWellKnown,
//            let payloadText = String(data: record.payload, encoding: .utf8),
//            let sku = payloadText.split(separator: "/").last else {
//                return
//        }
//
//
//
//        self.session = nil
//
//
//    }
//
//
//
//
//    /// - Tag: endScanning
//    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
//        // Check the invalidation reason from the returned error.
//        if let readerError = error as? NFCReaderError {
//            // Show an alert when the invalidation reason is not because of a success read
//            // during a single tag read mode, or user canceled a multi-tag read mode session
//            // from the UI or programmatically using the invalidate method call.
//            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
//                && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
//                let alertController = UIAlertController(
//                    title: "Session Invalidated",
//                    message: error.localizedDescription,
//                    preferredStyle: .alert
//                )
//                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                DispatchQueue.main.async {
//                    self.present(alertController, animated: true, completion: nil)
//                }
//            }
//        }
//
//        // A new session instance is required to read new tags.
//        self.session = nil
//    }
//
//}
//


extension scanDocViewController: NFCTagReaderSessionDelegate {
    
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        print("session active")
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        print("session error: \(error)")
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        print("session tag found: \(tags)")
    }
    
    
    
    
    
}
