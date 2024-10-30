package com.example.teste_app_vira_pacote.vero

import android.content.Context
import android.util.Log
import br.com.execucao.posmp_api.printer.Printer

class VeroPrinter {

    private lateinit var contextClass: Context
    private lateinit var printer: Printer

    fun initVero( context: Context ): Boolean {
        contextClass = context

        Log.i("initVero => ", "")

        val isInitialized = initVeroPrinter()
        Log.i("isInitialized => ", isInitialized.toString())
        if ( !isInitialized ) {
            return false
        }

        return testPrint()
    }

    private fun initVeroPrinter(): Boolean {
        Log.i("initVeroPrinter => ", "");
        try {
            printer = Printer.getInstance(contextClass)
            printer.open()
            return true
        } catch (error: Error) {
            Log.e("ERRO CONFIGURAÇÃO => ", error.toString())
            return false
        }
    }

    private fun testPrint() : Boolean {
        Log.i("testPrint => ", "")
        try {
            printer.print("Teste de impressão")
            Log.i("onFinish => ", "Print onFinish")
            return true

        } catch ( error : Exception ) {
            Log.i("catch => ", error.toString())
            return false
        }
    }

}