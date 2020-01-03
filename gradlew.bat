package com.wenzeasy.ui.activities;

import androidx.annotation.NonNull;

import android.content.Intent;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import com.wenzeasy.MainActivity;
import com.wenzeasy.R;
import com.wenzeasy.ui.presenter.ConfirmPinPresenter;
import com.wenzeasy.ui.view.ConfirmPinView;

import dmax.dialog.SpotsDialog;

public class ConfirmPinActivity extends BaseActivity<ConfirmPinPresenter, ConfirmPinView> implements ConfirmPinView {

    public static String phoneNumber;
    private SpotsDialog dialog;
    private EditText editTextVerificationCode;
    private Button buttonConfirmCode;
    private Button buttonReSendCode;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if (savedInstanceState == null) {
            getPresenter().onSubmit(getIntent());
        }
        setContentView(R.layout.activity_confirm_pin);

        dialog = new SpotsDialog(this, "Verification en cours...");

        buttonConfirmCode = findViewById(R.id.btn_confirm_code);
        buttonReSendCode = findViewById(R.id.btn_resend_code);
        editTextVerificationCode = findViewById(R.id.editVerificationCode);

        editTextVerificationCode.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {

                String code = v.getText().toString();

                if (code.length()==2){
                    v.setText(code+" ");
                }

                getPresenter().validateEnteredCode(phoneNumber, v.getText().toString());
                return false;
            }
        });

        buttonConfirmCode.setEnabled(false);
        buttonConfirmCode.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getPresenter().confirmVerificationCode(phoneNumber, editTextVerificationCode.getText().toString());
            }
        });
    }

    public void xml_res