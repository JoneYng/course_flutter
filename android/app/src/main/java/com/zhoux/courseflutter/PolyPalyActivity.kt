package com.zhoux.courseflutter

import android.content.res.Configuration
import android.os.Bundle
import android.util.Log
import android.view.KeyEvent
import android.view.View
import androidx.fragment.app.FragmentActivity
import com.easefun.polyvsdk.video.listener.IPolyvOnGestureSwipeLeftListener
import com.easefun.polyvsdk.video.listener.IPolyvOnGestureSwipeRightListener
import com.easefun.polyvsdk.video.listener.IPolyvOnPreparedListener2
import com.kmf.polyv.R
import com.kmf.polyv.activity.PolyvPlayerActivity
import com.kmf.polyv.app.PolyvManager
import com.kmf.polyv.player.PolyvPlayerMediaController
import com.kmf.polyv.player.PolyvPlayerVideoViewController
import com.kmf.polyv.player.PolyvPlayerVideoViewController.PlayMode
import com.kmf.polyv.utils.PolyvScreenUtils
import kotlinx.android.synthetic.main.activity_polyv_player.*
import kotlinx.android.synthetic.main.activity_polyv_player.view.*

class PolyPalyActivity : FragmentActivity() {
    /**
     * 播放器的parentView
     */

    /**
     * 视频控制栏 polyvMediaController
     */

    private var fastForwardPos = 0
    private var isPlay = false
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_polyv_player)
        val polyId = intent.getStringExtra("polyId")
        val mPolyvManager = PolyvManager()
        mPolyvManager.initPolyvCilent(this)
        findIdAndNew()
        initView()
        val playModeCode = intent.getIntExtra("playMode", PlayMode.portrait.code)
        var playMode = PlayMode.getPlayMode(playModeCode)
        if (playMode == null) playMode = PlayMode.portrait
        when (playMode) {
            PlayMode.landScape -> polyvMediaController!!.changeToLandscape()
            PlayMode.portrait -> polyvMediaController!!.changeToPortrait()
        }
        videoViewController.play(polyId);
    }

    override fun onConfigurationChanged(newConfig: Configuration) {
        super.onConfigurationChanged(newConfig)
        if (newConfig.orientation === Configuration.ORIENTATION_LANDSCAPE) {
            rlWaitTitle.visibility=View.GONE
        } else {
            rlWaitTitle.visibility=View.VISIBLE
        }
    }

    private fun findIdAndNew() {
        polyvMediaController!!.initConfig(viewLayout)
        videoViewController!!.auxiliaryVideoView.setPlayerBufferingIndicator(videoViewController!!.auxiliaryLoadingProgress)
        videoViewController!!.videoView.setMediaController(polyvMediaController)
        videoViewController!!.videoView.auxiliaryVideoView = videoViewController!!.auxiliaryVideoView
        videoViewController!!.videoView.setPlayerBufferingIndicator(videoViewController!!.loadingProgress)
        ivWaitTitleBack.setOnClickListener {
            finish()
        }
    }

    private fun initView() {
        videoViewController!!.videoView.setOpenAd(true)
        videoViewController!!.videoView.setOpenTeaser(true)
        videoViewController!!.videoView.setOpenQuestion(true)
        videoViewController!!.videoView.setOpenSRT(true)
        videoViewController!!.videoView.setOpenPreload(true, 2)
        videoViewController!!.videoView.setAutoContinue(true)
        videoViewController!!.videoView.needGestureDetector = true
        videoViewController!!.videoView.setOnPreparedListener(IPolyvOnPreparedListener2 { polyvMediaController!!.preparedView() })
        videoViewController!!.videoView.setOnGestureLeftUpListener { start, end ->
            var brightness = videoViewController!!.videoView.getBrightness(this@PolyPalyActivity) + 5
            if (brightness > 100) {
                brightness = 100
            }
            videoViewController!!.videoView.setBrightness(this@PolyPalyActivity, brightness)
            videoViewController!!.lightView.setViewLightValue(brightness, end)
        }
        videoViewController!!.videoView.setOnGestureLeftDownListener { start, end ->
            var brightness = videoViewController!!.videoView.getBrightness(this@PolyPalyActivity) - 5
            if (brightness < 0) {
                brightness = 0
            }
            videoViewController!!.videoView.setBrightness(this@PolyPalyActivity, brightness)
            videoViewController!!.lightView.setViewLightValue(brightness, end)
        }
        videoViewController!!.videoView.setOnGestureRightUpListener { start, end -> // 加减单位最小为10，否则无效果
            var volume = videoViewController!!.videoView.volume + 10
            if (volume > 100) {
                volume = 100
            }
            videoViewController!!.videoView.volume = volume
            videoViewController!!.volumeView.setViewVolumeValue(volume, end)
        }
        videoViewController!!.videoView.setOnGestureRightDownListener { start, end ->
            Log.d(TAG, String.format("RightDown %b %b volume %d", start, end, videoViewController!!.videoView.volume))
            // 加减单位最小为10，否则无效果
            var volume = videoViewController!!.videoView.volume - 10
            if (volume < 0) {
                volume = 0
            }
            videoViewController!!.videoView.volume = volume
            videoViewController!!.volumeView.setViewVolumeValue(volume, end)
        }
        videoViewController!!.videoView.setOnGestureSwipeLeftListener(object : IPolyvOnGestureSwipeLeftListener() {
            override fun callback(start: Boolean, end: Boolean) {
                // 左滑事件
                if (fastForwardPos == 0) {
                    fastForwardPos = videoViewController!!.videoView.currentPosition
                }
                if (end) {
                    if (fastForwardPos < 0) fastForwardPos = 0
                    videoViewController!!.videoView.seekTo(fastForwardPos)
                    if (videoViewController!!.videoView.isCompletedState) {
                        videoViewController!!.videoView.start()
                    }
                    fastForwardPos = 0
                } else {
                    fastForwardPos -= 10000
                    if (fastForwardPos <= 0) fastForwardPos = -1
                }
                videoViewController!!.progressView.setViewProgressValue(fastForwardPos, videoViewController!!.videoView.duration, end, false)
            }
        })
        videoViewController!!.videoView.setOnGestureSwipeRightListener(object : IPolyvOnGestureSwipeRightListener() {
            override fun callback(start: Boolean, end: Boolean) {
                // 右滑事件
                if (fastForwardPos == 0) {
                    fastForwardPos = videoViewController!!.videoView.currentPosition
                }
                if (end) {
                    if (fastForwardPos > videoViewController!!.videoView.duration) fastForwardPos = videoViewController!!.videoView.duration
                    videoViewController!!.videoView.seekTo(fastForwardPos)
                    if (videoViewController!!.videoView.isCompletedState) {
                        videoViewController!!.videoView.start()
                    }
                    fastForwardPos = 0
                } else {
                    fastForwardPos += 10000
                    if (fastForwardPos > videoViewController!!.videoView.duration) fastForwardPos = videoViewController!!.videoView.duration
                }
                videoViewController!!.progressView.setViewProgressValue(fastForwardPos, videoViewController!!.videoView.duration, end, true)
            }
        })
        videoViewController!!.videoView.setOnGestureClickListener { start, end -> if (videoViewController!!.videoView.isInPlaybackState && polyvMediaController != null) if (polyvMediaController!!.isShowing) polyvMediaController!!.hide() else polyvMediaController!!.show() }
    }

    override fun onResume() {
        super.onResume()
        //回来后继续播放
        if (isPlay) {
            videoViewController!!.videoView.onActivityResume()
        }
        polyvMediaController!!.resume()
    }

    override fun onPause() {
        super.onPause()
        videoViewController!!.clearGestureInfo()
        polyvMediaController!!.pause()
    }

    override fun onStop() {
        super.onStop()
        //弹出去暂停
        isPlay = videoViewController!!.videoView.onActivityStop()
    }

    override fun onDestroy() {
        super.onDestroy()
        videoViewController!!.videoView.destroy()
        polyvMediaController!!.disable()
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent): Boolean {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            if (PolyvScreenUtils.isLandscape(this) && polyvMediaController != null) {
                polyvMediaController!!.changeToPortrait()
                return true
            }
        }
        return super.onKeyDown(keyCode, event)
    }

    companion object {
        private val TAG = PolyvPlayerActivity::class.java.simpleName
    }
}