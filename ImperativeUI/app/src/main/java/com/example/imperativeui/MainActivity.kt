package com.example.imperativeui

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.TextView

class MainActivity : AppCompatActivity() {
    private var count = 0
    private lateinit var countTextView: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        countTextView = findViewById(R.id.countTextView)
        findViewById<Button>(R.id.incrementButton).setOnClickListener(ClickListener(1))
        findViewById<Button>(R.id.decrementButton).setOnClickListener(ClickListener(-1))
        findViewById<Button>(R.id.resetButton).setOnClickListener(ClickListener(0))
    }

    private inner class ClickListener(private val delta: Int) : View.OnClickListener {
        override fun onClick(v: View?) {
            count += delta
            countTextView.text = count.toString()
        }
    }
}
