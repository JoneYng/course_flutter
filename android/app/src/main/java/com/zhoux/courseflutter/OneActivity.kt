package com.zhoux.courseflutter

import android.app.Activity
import android.os.Bundle
import android.widget.TextView
import kotlinx.android.synthetic.main.activity_one.*

class OneActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_one)
        val text = intent.getStringExtra("polyId")
        textView.text = text
        ivWaitTitleBack.setOnClickListener { finish() }
    }
}