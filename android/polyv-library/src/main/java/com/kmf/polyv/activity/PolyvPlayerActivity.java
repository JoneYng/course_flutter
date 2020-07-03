package com.kmf.polyv.activity;

import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.widget.RelativeLayout;

import androidx.fragment.app.FragmentActivity;

import com.kmf.polyv.R;
import com.kmf.polyv.player.PolyvPlayerMediaController;
import com.kmf.polyv.player.PolyvPlayerVideoViewController;
import com.kmf.polyv.utils.PolyvScreenUtils;
import com.easefun.polyvsdk.video.listener.IPolyvOnGestureClickListener;
import com.easefun.polyvsdk.video.listener.IPolyvOnGestureLeftDownListener;
import com.easefun.polyvsdk.video.listener.IPolyvOnGestureLeftUpListener;
import com.easefun.polyvsdk.video.listener.IPolyvOnGestureRightDownListener;
import com.easefun.polyvsdk.video.listener.IPolyvOnGestureRightUpListener;
import com.easefun.polyvsdk.video.listener.IPolyvOnGestureSwipeLeftListener;
import com.easefun.polyvsdk.video.listener.IPolyvOnGestureSwipeRightListener;
import com.easefun.polyvsdk.video.listener.IPolyvOnPreparedListener2;

public class PolyvPlayerActivity extends FragmentActivity {
    private static final String TAG = PolyvPlayerActivity.class.getSimpleName();

    /**
     * 播放器的parentView
     */
    private RelativeLayout viewLayout = null;
//    /**
//     * 播放主视频播放器
//     */
//    private PolyvVideoView videoView = null;
    /**
     * 视频控制栏
     */
    private PolyvPlayerMediaController     mediaController     = null;
    private PolyvPlayerVideoViewController videoViewController = null;
    private int                            fastForwardPos      = 0;
    private boolean isPlay = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        if (savedInstanceState != null)
            savedInstanceState.putParcelable("android:support:fragments", null);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_polyv_player);
        findIdAndNew();
        initView();

        int playModeCode = getIntent().getIntExtra("playMode", PolyvPlayerVideoViewController.PlayMode.portrait.getCode());
        PolyvPlayerVideoViewController.PlayMode playMode = PolyvPlayerVideoViewController.PlayMode.getPlayMode(playModeCode);
        if (playMode == null)
            playMode = PolyvPlayerVideoViewController.PlayMode.portrait;
        //加密视频：7ac375c1ed01ca3226b6c59eb358f672_7
        //不加密视频：7ac375c1ed34d573a17dc80127835261_7

//        String vid = "7ac375c1ed34d573a17dc80127835261_7";
        String vid = "510de8f5bb5a6252f297bef44b9b7187_5";
//        int bitrate = getIntent().getIntExtra("bitrate", PolyvBitRate.ziDong.getNum());
//        boolean startNow = getIntent().getBooleanExtra("startNow", false);
//        boolean isMustFromLocal = getIntent().getBooleanExtra("isMustFromLocal", false);

        switch (playMode) {
            case landScape:
                mediaController.changeToLandscape();
                break;
            case portrait:
                mediaController.changeToPortrait();
                break;
        }

        videoViewController.play(vid);
    }

    private void findIdAndNew() {
        viewLayout = (RelativeLayout) findViewById(R.id.view_layout);
        //videoView = (PolyvVideoView) findViewById(R.id.polyv_video_view);
        mediaController = (PolyvPlayerMediaController) findViewById(R.id.polyv_player_media_controller);
        videoViewController = (PolyvPlayerVideoViewController) findViewById(R.id.polyv_player_video_view_controller);

        mediaController.initConfig(viewLayout);
        videoViewController.auxiliaryVideoView.setPlayerBufferingIndicator(videoViewController.auxiliaryLoadingProgress);
        videoViewController.videoView.setMediaController(mediaController);
        videoViewController.videoView.setAuxiliaryVideoView(videoViewController.auxiliaryVideoView);
        videoViewController.videoView.setPlayerBufferingIndicator(videoViewController.loadingProgress);
    }

    private void initView() {
        videoViewController.videoView.setOpenAd(true);
        videoViewController.videoView.setOpenTeaser(true);
        videoViewController.videoView.setOpenQuestion(true);
        videoViewController.videoView.setOpenSRT(true);
        videoViewController.videoView.setOpenPreload(true, 2);
        videoViewController.videoView.setAutoContinue(true);
        videoViewController.videoView.setNeedGestureDetector(true);

        videoViewController.videoView.setOnPreparedListener(new IPolyvOnPreparedListener2() {
            @Override
            public void onPrepared() {
                mediaController.preparedView();
            }
        });


        videoViewController.videoView.setOnGestureLeftUpListener(new IPolyvOnGestureLeftUpListener() {

            @Override
            public void callback(boolean start, boolean end) {
                int brightness = videoViewController.videoView.getBrightness(PolyvPlayerActivity.this) + 5;
                if (brightness > 100) {
                    brightness = 100;
                }

                videoViewController.videoView.setBrightness(PolyvPlayerActivity.this, brightness);
                videoViewController.lightView.setViewLightValue(brightness, end);
            }
        });

        videoViewController.videoView.setOnGestureLeftDownListener(new IPolyvOnGestureLeftDownListener() {

            @Override
            public void callback(boolean start, boolean end) {
                int brightness = videoViewController.videoView.getBrightness(PolyvPlayerActivity.this) - 5;
                if (brightness < 0) {
                    brightness = 0;
                }

                videoViewController.videoView.setBrightness(PolyvPlayerActivity.this, brightness);
                videoViewController.lightView.setViewLightValue(brightness, end);
            }
        });

        videoViewController.videoView.setOnGestureRightUpListener(new IPolyvOnGestureRightUpListener() {

            @Override
            public void callback(boolean start, boolean end) {
                // 加减单位最小为10，否则无效果
                int volume = videoViewController.videoView.getVolume() + 10;
                if (volume > 100) {
                    volume = 100;
                }

                videoViewController.videoView.setVolume(volume);
                videoViewController.volumeView.setViewVolumeValue(volume, end);
            }
        });

        videoViewController.videoView.setOnGestureRightDownListener(new IPolyvOnGestureRightDownListener() {

            @Override
            public void callback(boolean start, boolean end) {
                Log.d(TAG, String.format("RightDown %b %b volume %d", start, end, videoViewController.videoView.getVolume()));
                // 加减单位最小为10，否则无效果
                int volume = videoViewController.videoView.getVolume() - 10;
                if (volume < 0) {
                    volume = 0;
                }

                videoViewController.videoView.setVolume(volume);
                videoViewController.volumeView.setViewVolumeValue(volume, end);
            }
        });

        videoViewController.videoView.setOnGestureSwipeLeftListener(new IPolyvOnGestureSwipeLeftListener() {

            @Override
            public void callback(boolean start, boolean end) {
                // 左滑事件
                if (fastForwardPos == 0) {
                    fastForwardPos = videoViewController.videoView.getCurrentPosition();
                }

                if (end) {
                    if (fastForwardPos < 0)
                        fastForwardPos = 0;
                    videoViewController.videoView.seekTo(fastForwardPos);
                    if (videoViewController.videoView.isCompletedState()) {
                        videoViewController.videoView.start();
                    }
                    fastForwardPos = 0;
                } else {
                    fastForwardPos -= 10000;
                    if (fastForwardPos <= 0)
                        fastForwardPos = -1;
                }
                videoViewController.progressView.setViewProgressValue(fastForwardPos, videoViewController.videoView.getDuration(), end, false);
            }
        });

        videoViewController.videoView.setOnGestureSwipeRightListener(new IPolyvOnGestureSwipeRightListener() {

            @Override
            public void callback(boolean start, boolean end) {
                // 右滑事件
                if (fastForwardPos == 0) {
                    fastForwardPos = videoViewController.videoView.getCurrentPosition();
                }

                if (end) {
                    if (fastForwardPos > videoViewController.videoView.getDuration())
                        fastForwardPos = videoViewController.videoView.getDuration();
                    videoViewController.videoView.seekTo(fastForwardPos);
                    if (videoViewController.videoView.isCompletedState()) {
                        videoViewController.videoView.start();
                    }
                    fastForwardPos = 0;
                } else {
                    fastForwardPos += 10000;
                    if (fastForwardPos > videoViewController.videoView.getDuration())
                        fastForwardPos = videoViewController.videoView.getDuration();
                }
                videoViewController.progressView.setViewProgressValue(fastForwardPos, videoViewController.videoView.getDuration(), end, true);
            }
        });

        videoViewController.videoView.setOnGestureClickListener(new IPolyvOnGestureClickListener() {
            @Override
            public void callback(boolean start, boolean end) {
                if (videoViewController.videoView.isInPlaybackState() && mediaController != null)
                    if (mediaController.isShowing())
                        mediaController.hide();
                    else
                        mediaController.show();
            }
        });
    }



    @Override
    protected void onResume() {
        super.onResume();
        //回来后继续播放
        if (isPlay) {
            videoViewController.videoView.onActivityResume();
        }
        mediaController.resume();
    }

    @Override
    protected void onPause() {
        super.onPause();
        videoViewController.clearGestureInfo();
        mediaController.pause();
    }

    @Override
    protected void onStop() {
        super.onStop();
        //弹出去暂停
        isPlay = videoViewController.videoView.onActivityStop();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        videoViewController.videoView.destroy();
        mediaController.disable();
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            if (PolyvScreenUtils.isLandscape(this) && mediaController != null) {
                mediaController.changeToPortrait();
                return true;
            }
        }

        return super.onKeyDown(keyCode, event);
    }


}
