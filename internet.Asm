.386
.model flat, stdcall  ;32 bit memory model
option casemap :none  ;case sensitive

include internet.inc

.code

start:

	invoke GetModuleHandle,NULL
	mov		hInstance,eax

    invoke InitCommonControls
	invoke DialogBoxParam,hInstance,IDD_DIALOG1,NULL,addr DlgProc,NULL
	invoke ExitProcess,0

;########################################################################

DlgProc proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM

	mov		eax,uMsg
	.if eax==WM_INITDIALOG

	.elseif eax==WM_COMMAND
      .if wParam==1001
      invoke GetDlgItemText,hWin,1003,offset host,sizeof host
      invoke InternetOpen,addr ag,INTERNET_OPEN_TYPE_PRECONFIG,NULL,NULL,0
      mov hopen,eax
      .if hopen==NULL
      invoke MessageBox,0,addr msg,0,MB_OK
      .endif
      
      invoke InternetOpenUrl,hopen,offset host,NULL,NULL,INTERNET_FLAG_RELOAD,0
      mov hcon,eax
      .if hcon==NULL
      	invoke MessageBox,0,addr msg,0,MB_OK
      .endif
       invoke InternetReadFile,hcon,offset idata,5000,offset bytesread
       .if eax==FALSE
       	invoke MessageBox,0,addr msg,0,MB_OK
        .else
            
        	invoke GetDlgItem,hWin,1002
        	mov htext,eax
        	invoke SetWindowText,htext,addr idata
       .endif
      .endif
      
	.elseif eax==WM_CLOSE
	    invoke CloseHandle,hopen
	    invoke CloseHandle,hcon
	    invoke CloseHandle,htext
		invoke EndDialog,hWin,0
	.else
		mov		eax,FALSE
		ret
	.endif
	mov		eax,TRUE
	ret

DlgProc endp

end start
