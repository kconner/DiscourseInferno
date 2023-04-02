//
//  CustomWindow.swift
//  DiscourseInferno
//
//  Created by Kevin Conner on 2023-04-01.
//

import AppKit

class CustomWindow: NSWindow {
    private var dockedWidth: CGFloat = 320.0
    private var dockedFrame: NSRect {
        var rect = NSScreen.main!.visibleFrame
        rect.size.width = dockedWidth
        return rect
    }

    private var floatingFrame = NSRect(x: 300, y: 300, width: 320, height: 240)

    enum WindowMode {
        case floating, docked
    }

    var mode: WindowMode = .floating {
        didSet {
            guard mode != oldValue else { return }
            
            switch mode {
            case .floating:
                setUpFloatingMode()
            case .docked:
                setUpDockedMode()
            }
        }
    }

    private func setUpFloatingMode() {
        setFrame(floatingFrame, display: true, animate: true)
        
        styleMask.insert(.resizable)
        styleMask.insert(.titled)
    }

    private func setUpDockedMode() {
        floatingFrame = frame
        
        styleMask.remove(.resizable)
        styleMask.remove(.titled)
        
        setFrame(dockedFrame, display: true, animate: true)
        presentationState = .presented
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpApplicationObserver()
        setUpInteractiveSwipeGestureMonitor()
    }

    private func setUpApplicationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: NSApplication.didBecomeActiveNotification, object: nil)
    }

    @objc private func applicationDidBecomeActive() {
        guard mode == .docked, frame.origin.x < 0 else { return }
        setFrame(dockedFrame, display: true, animate: true)
    }

    enum PresentationState {
        case presented
        case dismissed
    }
    
    var presentationState: PresentationState = .presented
    
    var panGestureInProgress = false
    
    private func setUpInteractiveSwipeGestureMonitor() {
        NSEvent.addLocalMonitorForEvents(matching: .scrollWheel) { [weak self] event in
            guard let self, self.mode == .docked else { return event }
            
            let windowFrame = frame

            if self.mode == .docked {
                if event.phase.contains(.began) {
                    panGestureInProgress = true
                }

                if event.phase.contains(.changed) {
                    var newX = windowFrame.origin.x + event.scrollingDeltaX
                    newX = min(max(newX, -dockedWidth), 0)
                    setFrame(NSRect(x: newX, y: windowFrame.origin.y, width: dockedWidth, height: windowFrame.height), display: true)
                }

                if event.phase.contains(.ended) || event.phase.contains(.cancelled) {
                    panGestureInProgress = false
                    
                    let shouldShowWindow = -dockedWidth / 4 <= windowFrame.origin.x
                    let targetX: CGFloat = shouldShowWindow ? 0 : -dockedWidth
                    
                    var newFrame = windowFrame
                    newFrame.origin.x = targetX
                    setFrame(newFrame, display: true, animate: true)
                    
                    if !shouldShowWindow {
                        NSApp.hide(nil)
                    }
                }
            }

            return event
        }
    }

}
