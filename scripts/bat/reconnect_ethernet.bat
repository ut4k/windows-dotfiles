@echo off
REM 参考: https://www.action1.com/how-to-disable-or-enable-network-adapter-in-windows/
REM
REM インターフェース一覧取得: netsh interface ip show interface
REM
REM 管理者として実行するには...
REM このbatのショートカットを作成 -> プロパティ -> ショートカット -> 詳細設定 -> 管理者として実行

REM 切断
netsh interface set interface "イーサネット" disable
REM 接続
netsh interface set interface "イーサネット" enable