//
//  MetalRenderingDevice.swift
//  VideoLab
//
//  Created by Bear on 2020/8/7.
//  Copyright (c) 2020 Chocolate. All rights reserved.
//

import Foundation
import Metal

public let sharedMetalRenderingDevice = MetalRenderingDevice()

public class MetalRenderingDevice {
    public let device: MTLDevice
    public let commandQueue: MTLCommandQueue
    public let shaderLibrary: MTLLibrary
    public lazy var textureCache: TextureCache = {
        TextureCache()
    }()
    
    init() {
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("Could not create Metal Device")
        }
        self.device = device
        
        guard let queue = self.device.makeCommandQueue() else {
            fatalError("Could not create command queue")
        }
        self.commandQueue = queue

        do {
            self.shaderLibrary = try device.makeDefaultLibrary(bundle: Bundle.module)
        } catch {
            fatalError("Could not load metal library")
        }
    }
}
