package com.godot.game

import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.KeyEvent
import android.widget.Button
import kotlin.system.exitProcess

class RealStart : AppCompatActivity() {
    private lateinit var preferences: SharedPreferences

    override fun onCreate(savedInstanceState: Bundle?) {
        preferences = getSharedPreferences("godot", Context.MODE_PRIVATE)

        if (!preferences.getBoolean("isFirstStart", true)){
            goToGodot()
            return
        }

        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_real_start)

        findViewById<Button>(R.id.button).setOnClickListener{
            val editor = preferences.edit()
            editor.putBoolean("isFirstStart", false)
            editor.commit()
            goToGodot()
        }

        findViewById<Button>(R.id.button2).setOnClickListener {
            exitProcess(0)
        }

    }

    private fun goToGodot() {
        startActivity(Intent(this, GodotApp::class.java))
        finish()
    }
}