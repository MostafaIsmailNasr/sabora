package com.sabora.app_flutter
import android.content.Intent
import android.net.Uri

import android.app.Application
import android.content.Context
import android.media.AudioManager
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.core.content.FileProvider
import android.webkit.MimeTypeMap
import android.widget.Toast
import android.content.ActivityNotFoundException
import java.io.File

class MainActivity: FlutterActivity() {

    private val CHANNEL = "e_class.course.com/muteMic"


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "setMicMute") {
                setMicMuted(this@MainActivity,true)
                Log.d("TAG", ": ")
            }else if (call.method == "releaseMicMute") {
                setMicMuted(this@MainActivity,false)
            } else if (call.method == "openUrl") {
                openUrl(call.arguments.toString())
            } else if (call.method == "viewFile") {
                viewFile(call.arguments.toString())
            } else {
                result.notImplemented()
            }
        }
    }


    fun setMicMuted(context: Context, state: Boolean) {
//        AudioManager myAudioManager = (AudioManager)context.getSystemService(Context.AUDIO_SERVICE);
        val myAudioManager = context.getSystemService(Application.AUDIO_SERVICE) as AudioManager
        // get the working mode and keep it
        val workingAudioMode = myAudioManager.mode
        myAudioManager.mode = AudioManager.MODE_IN_COMMUNICATION
        //myAudioManager.setStreamMute(AudioManager.STREAM_ACCESSIBILITY,state)



        // change mic state only if needed
        if (myAudioManager.isMicrophoneMute != state) {
            myAudioManager.isMicrophoneMute = state
        }

        // set back the original working mode
        myAudioManager.mode = workingAudioMode
        Log.d("TAG", "setMicMuted: ${state}")
    }

    fun openUrl(url:String){
        try {
            val uri: Uri = Uri.parse(url) // missing 'http://' will cause crashed
            val intent = Intent(Intent.ACTION_VIEW, uri)
            startActivity(intent)
        }catch (e:Exception){

        }

    }

    private fun viewFile(path: String) {
        try {
           val attachment = File(path)
//            if (!attachment.exists()) {
//                return;
//            }
            val fileUri = Uri.parse(packageName+path)/*FileProvider.getUriForFile(
                this,
                packageName  ".provider",
                attachment
            )*/
            Log.d("fileUrl", "onClick: fileUrl2"+fileUri)
            val mime = getMimeType(fileUri.toString())
            Log.d("fileUrl", "onClick:mime fileUrl3"+mime)
            val intent = Intent(Intent.ACTION_VIEW)
            intent.setDataAndType(fileUri, mime)
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            startActivity(intent)
        } catch (e: ActivityNotFoundException) {
            Toast.makeText(
                this,
                "cannot open this file",
                Toast.LENGTH_SHORT
            ).show()
        }
//        catch (e: FileUriExposedException) {
//        }
    }

    fun getMimeType(fileUrl: String): String? {
        val fileExtension = MimeTypeMap.getFileExtensionFromUrl(fileUrl)
        return MimeTypeMap.getSingleton().getMimeTypeFromExtension(fileExtension)
    }
}
