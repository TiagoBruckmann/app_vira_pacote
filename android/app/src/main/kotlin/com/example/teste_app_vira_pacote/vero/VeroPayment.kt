package com.example.teste_app_vira_pacote.vero

import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.core.app.ActivityCompat.startActivityForResult
import com.example.teste_app_vira_pacote.MainActivity
import io.flutter.plugin.common.MethodChannel

class VeroPayment(val context: Context, val result: MethodChannel.Result) {

    // ações da intent
    private val INTENT_PAGAR: String = "br.com.execucao.PAGAR"

    /*
    private static final String INTENT_ESTORNAR = "br.com.execucao.ESTORNAR";
    private static final String QUERY_TRANSACTION_STATUS = "br.com.execucao.action.QUERY_TRANSACTION_STATUS";
    */
    // request code
    private val REQUISICAO: Int = 123

    // intent extra
    private val VALOR_TRANSACAO: String = "VALOR"
    /*
    private static final String NUMERO_PARCELAS = "NUMPARCELAS";
    private static final String PRAZO = "PRAZO";
    private static final String DIA = "DIA";
    private static final String NSU = "NSU";
    */
    private val TRANSACAO: String = "TRANSACAO"
    private val TRANSACAO_CREDITO: String = "CREDITO_GENERICO"
    /*
    private static final String TRANSACAO_CREDITO_VISTA = "CREDITO";
    private static final String TRANSACAO_CREDITO_PARCELADO_LOJISTA = "PARCELADO_LOJISTA";
    private static final String TRANSACAO_CRETIDO_PARCELADO_EMISSOR = "PARCELADO_EMISSOR";
    private static final String TRANSACAO_CREDITO_REPAY = "REPAY";
    private static final String TRANSACAO_DEBITO = "DEBITO";
    private static final String TRANSACAO_DEBITO_VISTA = "DEBITO_VISTA";
    private static final String TRANSACAO_BANRICOMPRAS_VISTA = "BANRICOMPRAS";
    private static final String TRANSACAO_BANRICOMPRAS_PREDATADO = "PREDATADO";
    private static final String TRANSACAO_BANRICOMPRAS_PARCELADO = "DEBITO_PARCELADO";
    private static final String TRANSACAO_BANRICOMPRAS_CREDITO_1_MINUTO = "CREDITO1M";
    private static final String TRANSACAO_VOUCHER = "VOUCHER";
    private static final String TRANSACAO_WALLET = "WALLET";
    private static final String TRANSACAO_PIX = "PIX";
    private static final String TRANSACAO_DIGITADA = "DIGITADA";
    private static final String TRANSACAO_DIGITADA_VEROPAY = "VEROPAY";
    */
    private val IMPRIMIR_COMPROVANTE: String = "IMPRIMIR_COMPROVANTE"

    /*
    private static final String AGUARDAR_CONFIRMA = "br.com.execucao.extra.WAIT_USER_CONFIRMATION";
    // private static final String REQUEST_CODE = 'br.com.execucao.extra.REQUEST_CODE';
    // private static final String ESTABELECIMENTO = “br.com.execucao.payment.extra.ESTABELECIMENTO”;
    private static final String LISTA_NSU = "LIST_NSU";
    */
    // intent extra response
    /*
    public static final String SERIAL = "SERIAL";
    public static final String BANDEIRA = "BANDEIRA";
    public static final String NUMCARTAO = "NUMCARTAO";
    public static final String INTENT_EXTRA_RESPONSE_TRANSACAO = "TRANSACAO";
    public static final String VALOR = "VALOR";
    public static final String PARCELAS = "PARCELAS";
    public static final String INTENT_EXTRA_RESPONSE_PRAZO = "PRAZO";
    public static final String INTENT_EXTRA_RESPONSE_DIA = "DIA";
    */
    private val AUTORIZACAO: String = "AUTORIZACAO"

    /*
    public static final String INTENT_EXTRA_RESPONSE_NSU = "NSU";
    public static final String CNPJ_ADQUIRENTE = "CNPJ_ADQUIRENTE";
    public static final String NOME_ADQUIRENTE = "NOME_ADQUIRENTE";
    public static final String CNPJ_ESTABELECIMENTO = "CNPJ_ESTABELECIMENTO";
    public static final String NOME_ESTABELECIMENTO = "NOME_ESTABELECIMENTO";
    public static final String COMPROVANTE = "COMPROVANTE";
    public static final String COMPROVANTE_LOJISTA = "COMPROVANTE_LOJISTA";
    public static final String COMPROVANTE_CLIENTE = "COMPROVANTE_CLIENTE";
    */

    fun creditCardPayment(amount: Int?) {
        val intent = Intent(INTENT_PAGAR)
        intent.putExtra(VALOR_TRANSACAO, amount)
        intent.putExtra(TRANSACAO, TRANSACAO_CREDITO)
        callApi(intent)
    }

    private fun callApi(intent: Intent) {
        try {
            intent.putExtra(IMPRIMIR_COMPROVANTE, true)
            startActivityForResult(MainActivity(), intent, REQUISICAO, null)
        } catch (error: Exception) {
            Log.e("ERRO => ", error.message.toString())
            dispose(false, "Call_API_ERROR", error.message)
        }
    }

    /*
    protected fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode != REQUISICAO) {
            Log.i("CODIGO_DIFERE => ", requestCode.toString())
            return
        }

        if (resultCode != Activity.RESULT_OK) {
            Log.i("RESULTADO_DIFERE => ", resultCode.toString())
            return
        }

        if (!data.hasExtra(AUTORIZACAO) || Objects.requireNonNull<String?>(
                data.getStringExtra( AUTORIZACAO )
            ).isEmpty()
        ) {
            dispose(false, "INTENT_ERROR", context.getString(R.string.transaction_rejected))
            return
        }

        val extra = data.extras
        Log.i("extra => ", extra.toString())
        methodChannelResult.success(extra)
    }
     */

    private fun dispose(isSuccess: Boolean, tag: String, message: String?) {
        if (isSuccess) {
            result.success(tag)
            return
        }

        result.error(tag, message, null)
    }

}