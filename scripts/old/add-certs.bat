:: Installs certificates so the drivers can install

:: Add the certs, with verbose output
e:\cert\VBoxCertUtil.exe -v add-trusted-publisher e:\cert\vbox*.cer --root e:\cert\vbox*.cer > c:\windows\temp\vboxcertinstall.txt
