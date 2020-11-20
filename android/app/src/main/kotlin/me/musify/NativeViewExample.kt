
package me.musify

import android.content.Context
import android.view.View
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory


internal class MyNativeView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
    private val topView: LinearLayout

    override fun getView(): View {
        return topView
    }

    override fun dispose() {}

    init {
        topView = LinearLayout(context)
        topView.layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT)
        topView.orientation = LinearLayout.VERTICAL

        (0..30).forEach{
            topView.addView(TextView(context).apply {
                textSize = 16f
                text = "This text is a native view, row $it"
            })
            topView.addView(ImageView(context).apply{
                setImageResource(R.drawable.baseline_play_arrow_black_24)
            })
        }
    }
}

internal class MyNativeViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        return MyNativeView(context, id, creationParams)
    }
}