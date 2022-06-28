;; ---------------------------------
;; Init
;; ---------------------------------
;package関係
(setq warning-suppress-log-types '((package reinitialization)))
(require 'package)
(setq package-user-dir "C:\\Users\\kimura.AZET\\.emacs.d\\")
(setq package-archives
      '(("gnu"   . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org"   . "http://orgmode.org/elpa/")))

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
)

(package-initialize)
(unless (package-installed-p 'use-package)
(package-refresh-contents)
(package-install 'use-package))

;; ---------------------------------
;; Basics
;; ---------------------------------
;デフォルトのワーキンjグディレクトリをデスクトップにする
(setq default-directory "C:\\Users\\kimura.AZET\\Desktop\\")

; org-agenda
;(setq org-agenda-files (list "C:\\org\\work.org"))
(setq org-agenda-files (list "C:\\org\\"))

(set-default 'buffer-file-coding-system 'utf-8-with-signature)
;(setq default-frame-alist
;      (append (list
;	      ;'(font . "CaskaydiaCove NF-10"))
;		  '(font . "ゆたぽん（コーディング）"))
;          ;    '(font . "Cascadia Mono-9"))
;              default-frame-alist))

;messagesバッファにログを作らない
(setq message-log-max nil)
;messagesバッファをつくらない（即時削除)
(when (get-buffer "*Messages*")
  (kill-buffer "*Messages*"))
;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq org-image-actual-width nil)
;; no line wrapping
(set-default 'truncate-lines t)
;;disable splash screen and startup message
(setq inhibit-startup-message t) 
(setq initial-scratch-message nil)
;; CUAモード（他エディタ互換の操作モード）をONにする
(cua-mode t)
;; Don't tabify after rectangle commands
(setq cua-auto-tabify-rectangles nil)
;; No region when it is not highlighted
(transient-mark-mode 1)
;; Standard Windows behaviour
(setq cua-keep-region-after-copy t)
;; なんだっけ?
(setq org-html-validation-link nil)
;; なんだっけ?
(remove-hook 'find-file-hooks 'vc-refresh-state)
;; 見た目
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-bar ((t (:background "#6272a4"))))
 '(org-table ((t (:foreground "LightSkyBlue" :family "ゆたぽん（コーディング）")))))
;; ツールバーを隠す
(tool-bar-mode -1)
;; スクロールバーを隠す
(scroll-bar-mode -1)
;; メニューバーを隠す
(menu-bar-mode -1)
;; カラースキーム
(require 'color-theme-sanityinc-tomorrow)
;(load-theme 'spacemacs-dark t)
;;UTF-8の設定                                                                                        
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
;; バックアップファイルを作らないようにする                                                          
(setq make-backup-files nil)
;; 括弧の対応関係をハイライト表示                                                                    
(show-paren-mode nil)
;; ツールバーを表示しないようにする（Official Emacs の場合は 0）                                     
(tool-bar-mode 0)
;;左側に行番号表示をする                                                                            
(require 'linum)
(global-linum-mode)
;org-bullets
;(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;バッファを閉じる際尋ねない
(global-set-key (kbd "C-x k") 'kill-this-buffer)
;; org 
; 画像をインライン表示する
(setq org-startup-with-inline-images t)
; 作成日付けを記入しない
(setq org-export-with-timestamps nil)
(setq org-export-time-stamp-file nil)
; subscript を無効に
(setq org-export-with-sub-superscripts nil)
; 見出しに番号を振らない
(setq org-export-with-section-numbers nil)
(setq org-beamer-outline-frame-title "Customized Title")
; 見出しをフォールドしない
(setq org-startup-folded nil)
; org-bullets
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
; org textエクスポート時のバレットの記号
(setq org-ascii-bullets '((ascii ?- ?- ?-) (latin1 ?- ?- ?-) (utf-8 ?- ?- ?-)))
;(setq org-ascii-text-width 0)
(setq org-ascii-text-width 1000)
; 改行を保持する
(setq org-export-preserve-breaks nil)
(setq org-ascii-text-width most-positive-fixnum)

;; Emoji: 😄, 🤦, 🏴󠁧󠁢󠁳󠁣󠁴󠁿
(set-fontset-font t 'symbol "Apple Color Emoji")
(set-fontset-font t 'symbol "Noto Color Emoji" nil 'append)
(set-fontset-font t 'symbol "Segoe UI Emoji" nil 'append)
(set-fontset-font t 'symbol "Symbola" nil 'append)

;; org checkbox
(add-hook 'org-mode-hook (lambda ()
  "Beautify Org Checkbox Symbol"
  (push '("[ ]" .  "☐") prettify-symbols-alist)
  (push '("[X]" . "☑" ) prettify-symbols-alist)
  ;(push '("[-]" . "❍" ) prettify-symbols-alist)
  (prettify-symbols-mode)))

;; ---------------------------------
;; Function
;; ---------------------------------
;; 本日の報告ファイル作成
(defun create-today-report-file()
  (interactive)
  (write-region "" nil (concat "C:\\org\\" (format-time-string "%Y%m%d") ".org") t)
  (find-file (concat (format-time-string "%Y%m%d") ".org"))
  )

(defun lat-work-day()
  (format-time-string "%Y%m%d" (time-subtract (current-time) (days-to-time 1)))
)

;; 本日と昨日の報告ファイルを開く
(defun open-report-files()
  (interactive)
  (setq default-directory "C:\\org\\")
  (create-today-report-file)

  ;; 別枠で昨日の報告ファイルを開く
  (split-window-horizontally)
  (let ((yesterday-date (format-time-string "%Y%m%d" (time-subtract (current-time) (days-to-time 1)))))
    (find-file (concat "C:\\org\\" yesterday-date ".org"))
  )
  (other-window 1)
)

;; 設定ファイルを開く
(defun open-conf()
  (interactive)
  ;(find-file "C:\\Users\\kimura.AZET\\AppData\\Roaming\\.emacs")
  (find-file-other-window "C:\\Users\\kimura.AZET\\AppData\\Roaming\\.emacs")
)

;; 設定ファイルを読み込みなおす
(defun reload-conf()
  (interactive)
  (load-file "C:\\Users\\kimura.AZET\\AppData\\Roaming\\.emacs")
  (message "confing re-loaded!")
)

;; org-modeにする
(defun start-org()
  (interactive)
  ;(insert "#+SETUPFILE: D:\\org\\header.setup")
  (message "org-mode!")
  (org-mode)
  )

;; orgのSETUPFILEヘッダを記入する
(defun insert-org-setup-header()
  (interactive)
  (insert "#+SETUPFILE: D:\\org\\header.setup")
)

;; ???
;;(defun fill-region-paragraphs (b e &optional justify)
;;  "Fill region between b and e like `fill-paragraph' for each paragraph in region
;;instead of `fill-region' which is implied by the original version of `fill-paragraph'.
;;Justify when called with prefix arg."
;;  (interactive "r\nP")
;;  (save-excursion
;;    (goto-char b)
;;    (while (< (point) e)
;;      (fill-paragraph justify)
;;      (forward-paragraph)
;;      )))
;;(global-set-key (kbd "C-c f") 'fill-region-paragraphs)

(defun org+-kill-list-item (&optional delete)
  "Kill list item at POINT.
Delete if DELETE is non-nil.
In interactive calls DELETE is the prefix arg."
  (interactive "P")
  (unless (org-at-item-p) (error "Not at an item"))
  (let* ((col (current-column))
         (item (point-at-bol))
         (struct (org-list-struct)))
    (org-list-send-item item (if delete 'delete 'kill) struct)
    (org-list-write-struct struct (org-list-parents-alist struct))
    (org-list-repair)
    (org-move-to-column col)))
    
(defun ced/_fetch-hours (text)
  ;; (print text)
  (let ((regexp "(\\(.+\\)h)$"))
    (if (and (stringp text) (string-match-p regexp text))
        (progn (string-match regexp text)
               (read (match-string 1 text)))
      0
      )))
 
(defun ced/_count-hours (acc line)
  (if (listp line)
      (seq-reduce 'ced/_count-hours line acc)
    (+ acc (ced/_fetch-hours line))
    ))

; org listの(xx hours)を集計する
(defun ced/sum-hours-in-list ()
  (interactive)
  (let ((position (point))
        (lines (org-list-to-lisp))) ; `org-list-to-lisp` moves point!
    (goto-char position)
    (insert (format " (%0.1fh)" (seq-reduce 'ced/_count-hours lines 0)))
    ))
  
(defun smaller-img ()
  (interactive)
  (insert (concat "#+attr_org: :width 40%\n"))
  )

; org-html--format-imageの依存
(defun replace-in-string (what with in)
  (replace-regexp-in-string (regexp-quote what) with in nil 'literal))

; orgからhtmlエクスポートする際に、画像タグはbase64エンコードする
;(defun org-html--format-image (source attributes info)
;  (progn
;    (setq source (replace-in-string "%20" " " source))
;    (format "<img src=\"data:image/%s;base64,%s\"%s />"
;            (or (file-name-extension source) "")
;            (base64-encode-string
;             (with-temp-buffer
;               (insert-file-contents-literally source)
;              (buffer-string)))
;            (file-name-nondirectory source))))

(defun org-export-to-html-custom ()
   (interactive)
   (message "exporting to html file...")
   (org-html-export-to-html))

;; ---------------------------------
;; Keybindings
;; ---------------------------------
(global-set-key [f2] 'open-report-files)
(global-set-key [f11] 'open-conf)
(global-set-key [f12] 'reload-conf)
(global-set-key [f3] 'start-org)
(global-set-key [f4] 'insert-org-setup-header)
(global-set-key [f5] 'delete-duplicate-lines)
(global-set-key (kbd "C-c d") 'org+-kill-list-item)
(global-set-key "\C-cs" 'my-org-screenshot)
; org-mode-map
(with-eval-after-load "org"
		(message "hello")
		(define-key org-mode-map "C-x C-m" 'smaller-img)
		(define-key org-mode-map (kbd "C-c j") 'ced/sum-hours-in-list)
		(define-key org-mode-map (kbd "C-.") 'org-toggle-inline-images)
		(define-key org-mode-map (kbd "C-c z") 'org-export-to-html-custom)
)


;; ---------------------------------
;; Package-Settings
;; ---------------------------------

;; htmlize
(require 'htmlize)

; ;;;;; org-download ;;;;;
(require 'org-download)
(add-hook 'dired-mode-hook 'org-download-enable)
(setq org-download-attr-list '("#+attr_html: :width 80% :align center" "#+attr_latex: :width 0.75\textwidth" "#+attr_org: :width 40%"))
(setq org-download-annotate-function (lambda (_link) ""))
;(require 'org)

; ;;;;; ox-pandoc ;;;;;
; html5でエクスポートするとき画像はbase64化する。
(setq org-pandoc-options-for-html5 '((standalone . t) (self-contained . t)))

(setq org-latex-packages-alist '(("" "fullpage") ("avoid-all" "widows-and-orphans") ("" "svg")))

;; ---------------------------------
;; Font
;;
;; https://misohena.jp/blog/2017-09-26-symbol-font-settings-for-emacs25.html
;; ---------------------------------
(set-face-attribute 'default nil :family "PlemolJP35 Console NF Medium" :height 90)
(set-fontset-font nil '(#x80 . #x10ffff) (font-spec :family "PlemolJP35 Console NF Medium"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ----------------------------------
;; emacsのインタフェースから設定を変更すると以下に記述される
;; ここから先はいじらない
;; ----------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   (vector "#1d1f21" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#8abeb7" "#c5c8c6"))
 '(beacon-color "#cc6666")
 '(custom-enabled-themes '(sanityinc-tomorrow-eighties))
 '(custom-safe-themes
   '("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default))
 '(fci-rule-color "#373b41")
 '(flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
 '(frame-background-mode 'dark)
 '(hl-todo-keyword-faces
   '(("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f")))
 '(org-fontify-done-headline nil)
 '(org-fontify-todo-headline nil)
 '(package-selected-packages
   '(color-theme-sanityinc-tomorrow org-bullets htmlize ox-pandoc spacemacs-theme-dark spacemacs-theme zenburn-theme use-package org-download))
 '(pdf-view-midnight-colors '("#b2b2b2" . "#292b2e"))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#cc6666")
     (40 . "#de935f")
     (60 . "#f0c674")
     (80 . "#b5bd68")
     (100 . "#8abeb7")
     (120 . "#81a2be")
     (140 . "#b294bb")
     (160 . "#cc6666")
     (180 . "#de935f")
     (200 . "#f0c674")
     (220 . "#b5bd68")
     (240 . "#8abeb7")
     (260 . "#81a2be")
     (280 . "#b294bb")
     (300 . "#cc6666")
     (320 . "#de935f")
     (340 . "#f0c674")
     (360 . "#b5bd68")))
 '(vc-annotate-very-old-color nil)
 '(window-divider-mode nil))

