package com.kmf.polyv.player;

import android.content.Context;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.ProgressBar;

import androidx.annotation.AttrRes;
import androidx.annotation.NonNull;

import com.easefun.polyvsdk.video.PolyvVideoView;
import com.easefun.polyvsdk.video.auxiliary.PolyvAuxiliaryVideoView;
import com.kmf.polyv.R;

/**
 * Created by Administrator on 2017/12/25.
 */
public class PolyvPlayerVideoViewController extends FrameLayout {
    private ImageView iv_vlms_cover;
    /**
     * 播放主视频播放器
     */
    public PolyvVideoView videoView = null;
    /**
     * 视频广告，视频片头加载缓冲视图
     */
    public ProgressBar auxiliaryLoadingProgress = null;
    /**
     * 用于播放广告片头的播放器
     */
    public PolyvAuxiliaryVideoView auxiliaryVideoView = null;
    /**
     * 视频加载缓冲视图
     */
    public ProgressBar loadingProgress = null;
    /**
     * 手势出现的进度界面
     */
    public PolyvPlayerProgressView progressView = null;
    /**
     * 手势出现的亮度界面
     */
    public PolyvPlayerLightView lightView = null;
    /**
     * 手势出现的音量界面
     */
    public PolyvPlayerVolumeView volumeView = null;
    private View view;
    private PolyvPlayerMediaController mediaController;

    public PolyvPlayerVideoViewController(@NonNull Context context) {
        super(context);
        this.view = LayoutInflater.from(context).inflate(R.layout.polyv_controller_video_view, this);
        findIdAndNew(context);
    }

    public PolyvPlayerVideoViewController(@NonNull Context context, @NonNull AttributeSet attrs) {
        super(context, attrs);
        this.view = LayoutInflater.from(context).inflate(R.layout.polyv_controller_video_view, this);
        findIdAndNew(context);
    }

    public PolyvPlayerVideoViewController(@NonNull Context context, @NonNull AttributeSet attrs, @AttrRes int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        this.view = LayoutInflater.from(context).inflate(R.layout.polyv_controller_video_view, this);
        findIdAndNew(context);
    }

    private void findIdAndNew(Context context) {
        videoView = (PolyvVideoView) findViewById(R.id.polyv_video_view);
        lightView = (PolyvPlayerLightView) findViewById(R.id.polyv_player_light_view);
        volumeView = (PolyvPlayerVolumeView) findViewById(R.id.polyv_player_volume_view);
        progressView = (PolyvPlayerProgressView) findViewById(R.id.polyv_player_progress_view);
        loadingProgress = (ProgressBar) findViewById(R.id.loading_progress);
        auxiliaryVideoView = (PolyvAuxiliaryVideoView) findViewById(R.id.polyv_auxiliary_video_view);
        auxiliaryLoadingProgress = (ProgressBar) findViewById(R.id.auxiliary_loading_progress);
        mediaController = PolyvPlayerMediaController.getInstance(context);

    }
    /**
     * 播放视频
     *
     * @param vid               视频id
     * @param //bitrate         码率（清晰度）
     * @param //startNow        是否现在开始播放视频
     * @param //isMustFromLocal 是否必须从本地（本地缓存的视频）播放
     */
    public void play(final String vid) {
        if (TextUtils.isEmpty(vid)) return;
        if (iv_vlms_cover != null && iv_vlms_cover.getVisibility() == View.VISIBLE)
            iv_vlms_cover.setVisibility(View.GONE);

        videoView.release();
        mediaController.hide();
        loadingProgress.setVisibility(View.GONE);
        auxiliaryVideoView.hide();
        auxiliaryLoadingProgress.setVisibility(View.GONE);
        //调用setVid方法视频会自动播放
        videoView.setVid(vid);

    }

    public void clearGestureInfo() {
        videoView.clearGestureInfo();
        progressView.hide();
        volumeView.hide();
        lightView.hide();
    }

    /**
     * 播放模式
     *
     * @author TanQu
     */
    public enum PlayMode {
        /**
         * 横屏
         */
        landScape(3),
        /**
         * 竖屏
         */
        portrait(4);

        private final int code;

        private PlayMode(int code) {
            this.code = code;
        }

        /**
         * 取得类型对应的code
         *
         * @return
         */
        public int getCode() {
            return code;
        }

        public static PlayMode getPlayMode(int code) {
            switch (code) {
                case 3:
                    return landScape;
                case 4:
                    return portrait;
            }

            return null;
        }
    }
}
