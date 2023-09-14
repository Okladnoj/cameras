import android.content.Context
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar

class CamerasPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var cameraChannel: MethodChannel
    private lateinit var context: Context
    private var cameraManager: CameraManager? = null

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val instance = CamerasPlugin()
            instance.context = registrar.context()

            // Register the main channel
            val channel = MethodChannel(registrar.messenger(), "cameras")
            channel.setMethodCallHandler(instance)
            instance.channel = channel

            // Register the camera channel
            val cameraChannel = MethodChannel(registrar.messenger(), "android_camera")
            cameraChannel.setMethodCallHandler(instance)
            instance.cameraChannel = cameraChannel
        }
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext

        // Initialize the main channel
        channel = MethodChannel(binding.binaryMessenger, "cameras")
        channel.setMethodCallHandler(this)

        // Initialize the camera channel
        cameraChannel = MethodChannel(binding.binaryMessenger, "android_camera")
        cameraChannel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "getPlatformType" -> result.success("android")
            "initializeCamera" -> initializeCamera(call, result)
            "startStream" -> startStream(result)
            "stopStream" -> stopStream(result)
            "captureImage" -> captureImage(result)
            else -> result.notImplemented()
        }
    }

private var cameraDevice: CameraDevice? = null
private val cameraCallback = object : CameraDevice.StateCallback() {
    override fun onOpened(camera: CameraDevice) {
        cameraDevice = camera
    }

    override fun onDisconnected(camera: CameraDevice) {
        camera.close()
        cameraDevice = null
    }

    override fun onError(camera: CameraDevice, error: Int) {
        camera.close()
        cameraDevice = null
    }
}

  private fun initializeCamera(call: MethodCall, result: MethodChannel.Result) {
    val cameraId = call.argument<String>("cameraId") ?: run {
        result.error("NO_CAMERA_ID", "Camera ID is required", null)
        return
    }
    cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
    try {
        val cameraCharacteristics = cameraManager?.getCameraCharacteristics(cameraId)
        val afAvailableModes = cameraCharacteristics?.get(CameraCharacteristics.CONTROL_AF_AVAILABLE_MODES)
        val supportsAutoFocus = !afAvailableModes.isNullOrEmpty() && afAvailableModes[0] != CameraMetadata.CONTROL_AF_MODE_OFF
        
        if (!supportsAutoFocus) {
            result.error("AUTOFOCUS_NOT_SUPPORTED", "This camera does not support autofocus", null)
            return
        }

        cameraManager?.openCamera(cameraId, cameraCallback, null)
        result.success(true)
    } catch (e: CameraAccessException) {
        result.error("CAMERA_ACCESS", e.message, null)
    } catch (e: SecurityException) {
        result.error("CAMERA_PERMISSION", "Camera permission is not granted", null)
    }
  }


    private var captureRequestBuilder: CaptureRequest.Builder? = null
    private var cameraCaptureSession: CameraCaptureSession? = null
    private var textureView: TextureView? = null

    private fun startStream(result: MethodChannel.Result) {
        if (cameraDevice == null) {
            result.error("NO_CAMERA_DEVICE", "Camera is not initialized", null)
            return
        }

        captureRequestBuilder = cameraDevice?.createCaptureRequest(CameraDevice.TEMPLATE_PREVIEW)
        val surfaceList = ArrayList<Surface>()

        val surfaceTexture = textureView?.surfaceTexture
        surfaceTexture?.setDefaultBufferSize(/* Ex, 1920, 1080 */)
        val previewSurface = Surface(surfaceTexture)
        surfaceList.add(previewSurface)
        captureRequestBuilder?.addTarget(previewSurface)

        cameraDevice?.createCaptureSession(surfaceList, object : CameraCaptureSession.StateCallback() {
            override fun onConfigured(session: CameraCaptureSession) {
                if (cameraDevice == null) return
                cameraCaptureSession = session

                val captureRequest = captureRequestBuilder?.build()
                cameraCaptureSession?.setRepeatingRequest(captureRequest!!, null, null)
                result.success(true)
            }

            override fun onConfigureFailed(session: CameraCaptureSession) {
                result.error("CAMERA_CONFIG_FAILED", "Configuration of camera failed", null)
            }
        }, null)
    }

    private fun stopStream(result: MethodChannel.Result) {
        try {
            cameraCaptureSession?.close()
            cameraCaptureSession = null
            result.success(true)
        } catch (e: Exception) {
            result.error("CAMERA_STOP_ERROR", "Failed to stop the camera stream", e.message)
        }
    }


    private fun setupImageReader() {
        val width = 1920
        val height = 1080
        imageReader = ImageReader.newInstance(width, height, ImageFormat.JPEG, 1)
        imageReader?.setOnImageAvailableListener({ reader ->
            val image = reader.acquireLatestImage()

            // TODO: 
            image?.close()
        }, null) 
    }



private lateinit var imageReader: ImageReader

private fun captureImage(result: MethodChannel.Result) {
    try {
        val captureBuilder = cameraDevice.createCaptureRequest(CameraDevice.TEMPLATE_STILL_CAPTURE)
        captureBuilder.addTarget(imageReader.surface)

        val captureCallback = object : CameraCaptureSession.CaptureCallback() {
            override fun onCaptureCompleted(session: CameraCaptureSession, request: CaptureRequest, result: TotalCaptureResult) {
                val image = imageReader.acquireLatestImage()
                val buffer = image.planes[0].buffer
                val bytes = ByteArray(buffer.remaining())
                buffer.get(bytes)
                image.close()
                result.success(bytes)
            }

            override fun onCaptureFailed(session: CameraCaptureSession, request: CaptureRequest, failure: CaptureFailure) {
                result.error("CAPTURE_FAILED", "Failed to capture image", null)
            }
        }

        captureSession.capture(captureBuilder.build(), captureCallback, null)

    } catch (e: CameraAccessException) {
        result.error("CAMERA_ERROR", e.message, null)
    }
}



    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        cameraChannel.setMethodCallHandler(null)
    }
}
