package com.godot.game

import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import kotlin.system.exitProcess

class MainActivity : AppCompatActivity() {
    private val preferences = getSharedPreferences("godot", Context.MODE_PRIVATE)

    override fun onCreate(savedInstanceState: Bundle?) {
        if (!preferences.getBoolean("isFirstStart", true)){
            goToGodot()
            return
        }

        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        findViewById<Button>(R.id.yes).setOnClickListener {
            val editor = preferences.edit()
            editor.putBoolean("isFirstStart", false)
            editor.commit()
            goToGodot()
        }

        findViewById<Button>(R.id.no).setOnClickListener {
            exitProcess(0)
        }

    }

    private fun goToGodot(){
        startActivity(Intent(this, GodotApp::class.java))
        finish()
    }
}