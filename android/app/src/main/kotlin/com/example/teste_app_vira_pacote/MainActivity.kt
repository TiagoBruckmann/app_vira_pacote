package com.example.teste_app_vira_pacote

import android.os.Bundle
import android.util.Log
import com.example.teste_app_vira_pacote.vero.VeroPayment
import com.example.teste_app_vira_pacote.vero.VeroPrinter
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import java.lang.String
import kotlin.Int
import kotlin.let

class MainActivity: FlutterActivity() {

    private val CHANNEL = "acquiring_sdk"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.i("onCreate => ", "")

        flutterEngine?.dartExecutor?.binaryMessenger?.let {
            MethodChannel(it, CHANNEL).setMethodCallHandler { call, result ->
                if ( call.method == "vero_printer" ) {
                    val response = VeroPrinter().initVero(context)
                    if ( response ) {
                        result.success("Retorno da função nativa")
                    } else {
                        result.error("UNAVAILABLE", "Printer not available.", null)
                    }

                } else if ( call.method == "vero_credit_card_payment" ) {

                    Log.i("credit_card_payment => ", String.valueOf(call.arguments))
                    val amount: Int? = call.argument("amount")
                    if ( amount == null ) {
                        result.error("INVALID AMOUNT => ", "invalid amount.", null)
                    } else {

                        Log.i("amount => ", amount.toString())
                        VeroPayment(context, result).creditCardPayment(amount)

                    }

                } else {
                    result.notImplemented()
                }
            }
        }
    }

}
