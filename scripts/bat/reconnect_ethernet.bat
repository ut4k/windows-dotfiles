@echo off
REM �Q�l: https://www.action1.com/how-to-disable-or-enable-network-adapter-in-windows/
REM
REM �C���^�[�t�F�[�X�ꗗ�擾: netsh interface ip show interface
REM
REM �Ǘ��҂Ƃ��Ď��s����ɂ�...
REM ����bat�̃V���[�g�J�b�g���쐬 -> �v���p�e�B -> �V���[�g�J�b�g -> �ڍאݒ� -> �Ǘ��҂Ƃ��Ď��s

REM �ؒf
netsh interface set interface "�C�[�T�l�b�g" disable
REM �ڑ�
netsh interface set interface "�C�[�T�l�b�g" enable