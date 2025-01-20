package com.checksum

import android.util.Log
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.module.annotations.ReactModule
import java.security.MessageDigest


@ReactModule(name = ChecksumModule.NAME)
class ChecksumModule(val reactContext: ReactApplicationContext) :
  NativeChecksumSpec(reactContext) {

  override fun getName(): String {
    return NAME
  }

  private fun getAssetChecksum(filePath: String): String {
    var hash: ByteArray? = null
    val sb = StringBuilder()
    try {
      val assetManager = reactContext.assets
      val stream = assetManager.open(filePath)
      val size = stream.available()
      val buffer = ByteArray(size)
      stream.read(buffer)
      stream.close()
      hash = MessageDigest.getInstance("SHA-256").digest(buffer)
      if (hash == null) {
        Log.d(NAME, "No hash")
        return ""
      }
    } catch (ex: java.io.FileNotFoundException) {
      Log.e(NAME, "$filePath is not found")
      return ""
    } catch (ex: Exception) {
      ex.printStackTrace()
      Log.e(NAME, "Error while access to asset: $ex")
      return ""
    }

    try {
      for (i in hash.indices) {
        sb.append(((hash[i].toInt() and 0xff) + 0x100).toString(16).substring(1))
      }
      return sb.toString()
    } catch (e: Exception) {
      e.printStackTrace()
      return ""
    }
  }

  override fun getBundleChecksum(): String {
    return getAssetChecksum("index.android.bundle")
  }


  override fun getChecksumFile(filePath: String): String {
    return getAssetChecksum(filePath)
  }

  companion object {
    const val NAME = "Checksum"
  }
}
