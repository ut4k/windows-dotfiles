;; --------------------------------
;; Init
;; ---------------------------------
(setq user-dir (getenv "HOME"))
(setq dotemacs-file (concat user-dir "\\.emacs"))
(setq custom-file (concat user-dir "\\custom.el"))

;;straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'rainbow-identifiers)
(straight-use-package 'color-theme-sanityinc-tomorrow)
(straight-use-package 'org-download)
(straight-use-package 'org-bullets)
(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-langs)
(straight-use-package 'all-the-icons)
(straight-use-package 'ivy)
(straight-use-package 'projectile)
(straight-use-package 'company)
(straight-use-package 'company-php)
(straight-use-package 'helm)
(straight-use-package 'helm-projectile)
(straight-use-package 'minions)
(straight-use-package 'exotica-theme)
(straight-use-package 'doom-themes)
(straight-use-package 'jazz-theme)
(straight-use-package 'railscasts-theme)
(straight-use-package 'darcula-theme)
(straight-use-package 'rg)
(straight-use-package 'undo-fu)
(straight-use-package 'doom-modeline)
(straight-use-package 'nyan-mode)
(straight-use-package 'all-the-icons)
(straight-use-package 'dashboard)
(straight-use-package 'whitespace)
(straight-use-package 'bind-key)
(straight-use-package 'imenu-list)
(straight-use-package 'web-mode)
(straight-use-package 'org-super-agenda)
(straight-use-package 'color-theme-sanityinc-tomorrow)
(straight-use-package 'ample-theme)
(straight-use-package 'swiper)
(straight-use-package 'emojify)
(straight-use-package 'go-mode)
(straight-use-package 'ob-go)
(straight-use-package 'yaml-mode)
(straight-use-package 'material-theme)
;; ---------------------------------
;; Basics
;; ---------------------------------
(load-file custom-file)
;; マウス選択範囲を自動でコピーする 
(setq mouse-drag-copy-region nil)
;;デフォルトのワーキングディレクトリをデスクトップにする
;;(setq default-directory (concat user-dir "\\Desktop\\"))
;;フレームタイトルにディレクトリを表示
(setq frame-title-format '((:eval (concat "Emacs [server: " (daemonp) "] - " default-directory) )))
;;空白スタイル
(setq whitespace-style '(trailing tabs newline tab-mark newline-mark))
;;utf-8でバッファを読む
(set-default 'buffer-file-coding-system 'utf-8-with-signature)
;;カーソルを線に
(setq-default cursor-type 'bar) 

;;messagesバッファにログを作らない
(setq message-log-max nil)
;;messagesバッファをつくらない（即時削除)
;; (when (get-buffer "*Messages*")
;;   (kill-buffer "*Messages*"))
;; バックアップファイルを作らない
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq org-image-actual-width nil)
;; no line wrapping
(set-default 'truncate-lines t)
;;disable splash screen and startup message
(setq inhibit-startup-message t) 
(setq initial-scratch-message nil)
;; CUAモード（他エディタ互換の操作モード）
(cua-mode nil)
;;矩形
(define-key global-map (kbd "C-x SPC") 'cua-set-rectangle-mark)
;; Don't tabify after rectangle commands
(setq cua-auto-tabify-rectangles nil)
;; No region when it is not highlighted
(transient-mark-mode 1)
;; Standard Windows behaviour
(setq cua-keep-region-after-copy t)
;; org htmlバリデーションのリンクを表示 off
(setq org-html-validation-link nil)
;; fild-fileフック削除 Version Controlシステムの状態を更新しない
(remove-hook 'find-file-hooks 'vc-refresh-state)
;;orgを解釈して表示 OFF
(setq org-pretty-entities nil)
;; ツールバーを隠す
(tool-bar-mode -1)
;; スクロールバーを隠す
(scroll-bar-mode -1)
;; メニューバーを隠す
(menu-bar-mode -1)
;; 変更後自動リロード
(global-auto-revert-mode)
;; foldのアイコン
(setq org-ellipsis " ⤵") ; ARROW POINTING RIGHTWARDS THEN CURVING DOWNWARDS

(defun contextual-menubar (&optional frame)
  "Display the menubar in FRAME (default: selected frame) if on a
graphical display, but hide it if in terminal."
  (interactive)
  (set-frame-parameter frame 'menu-bar-lines (if (display-graphic-p frame) 1 0)))

;;UTF-8の設定                                                                                        
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; (set-buffer-file-coding-system 'utf-8) ;これを有効にすると毎回変更が入っちゃう
;; 括弧の対応関係をハイライト表示                                                                    
(show-paren-mode nil)
;; ツールバーを表示しないようにする（Official Emacs の場合は 0）                                     
(tool-bar-mode 0)
;;左側に行番号表示をする                                                                            
(global-display-line-numbers-mode)

;;バッファを閉じる際尋ねない
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-q") 'delete-window)
;; org 
;; 画像をインライン表示する/しない
(setq org-startup-with-inline-images nil)
;; 作成日付を記入しない
(setq org-export-with-timestamps nil)
(setq org-export-time-stamp-file nil)
;; subscript を無効に
(setq org-export-with-sub-superscripts nil)
;; 見出しに番号を振らない
(setq org-export-with-section-numbers nil)
(setq org-beamer-outline-frame-title "Customized Title")
;; 見出しをフォールドしない
(setq org-startup-folded nil)
;; ?
(setq org-ascii-text-width 1000)
;; 改行を保持する
(setq org-export-preserve-breaks t)
(setq org-ascii-text-width most-positive-fixnum)
(setq org-ascii-headline-spacing nil)
(setq split-width-threshold 0)
(setq split-height-threshold nil)
;; disable indentation
(setq org-adapt-indentation nil)
;; https://emacs.stackexchange.com/questions/64019/how-can-i-suppress-the-message-when-done-with-this-frame-type-c-x-5-0
(setq server-client-instructions nil)
;; 検索時のハイライトを保持する ;うまくいってない?
(setq lazy-highlight-cleanup nil)
(setq lazy-highlight-max-at-a-time nil)
(setq lazy-highlight-initial-delay 0)
;;タブでのインデント
(setq indent-tabs-mode t)
(setq left-fringe-width 28)
(set-fringe-style (quote (20 . 20)))
;; vimのshowcmd
(setq echo-keystrokes .1)

;; ---------------------------------
;; Babel
;; ---------------------------------
(require 'ob-go)

;; plantuml.jarへのパスを設定
(setq org-plantuml-jar-path "C:\\app\\plantuml\\plantuml.jar")

;; org-babelで使用する言語を登録
(org-babel-do-load-languages 'org-babel-load-languages
 '(
   (plantuml . t)
   (go . t)
  )
)

;; ---------------------------------
;; Org Export
;; ---------------------------------
(setq org-latex-pdf-process
      '("platex -shell-escape %f"
        "dvipdfmx %b.dvi"))

(require 'ox-latex)
(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("\\makeatletter"
		 ("\\renewcommand{\tableofcontents}{%")
		 (" \\@starttoc{toc}%")
		 ("}")
		 ("\\makeatother")))
  )
;; ---------------------------------
;; Org Mode
;; ---------------------------------
(add-hook 'org-mode-hook 'org-indent-mode)

(defun org-img-attr ()
  (concat
   "#+ATTR_HTML: :width 50%"
   "\n"
   "#+CAPTION:"
   "\n"))

;; クリップボードから画像を貼り付ける
;;https://lists.gnu.org/archive/html/emacs-orgmode/2011-07/msg01292.html
(defun org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the same 
directory as the org-buffer and insert
a link to this file."
  (interactive)
  (setq tilde-buffer-filename
        (replace-regexp-in-string "/" "\\" (buffer-file-name) t t))
  (setq filename
        (concat
         (make-temp-name
          (concat tilde-buffer-filename
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".jpg"))
  ;; Linux: ImageMagick: (call-process "import" nil nil nil filename)
  ;; Windows: Irfanview
  (call-process "C:\\Program Files\\IrfanView\\i_view64.exe" nil nil nil (concat "/clippaste /convert=" filename))
  ;;属性追加
  (insert (org-img-attr))
  ;;画像挿入
  (insert (concat "[[file:" filename "]]"))
  (org-display-inline-images))
(global-set-key (kbd "C-x p") 'org-screenshot)

(setq org-todo-keywords
      '((sequence "[TODO]" "[課題起票]" "[作業中]" "[管理者レビュー待ち]" "[レビュー待ち]" "[返信済]" "[お返事待ち]" "|" "[完了]" "[調査済み]")))

;;勝手に改行するのを防ぐ
(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

(global-hl-line-mode t)

;; org checkbox
;; (add-hook 'org-mode-hook (lambda ()
;; "Beautify Org Checkbox Symbol"
;; (push '("[ ]" .  "☐") prettify-symbols-alist)
;; (push '("[X]" . "☑" ) prettify-symbols-alist)
;;(push '("[-]" . "❍" ) prettify-symbols-alist)
;; (prettify-symbols-mode)))

;; smooth-scrolling
(setq fast-but-imprecise-scrolling t)
;; 描画はやく
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

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
  (find-file-other-window dotemacs-file)
 )

;; 設定ファイルを読み込みなおす
(defun reload-conf()
  (interactive)
  (load-file dotemacs-file)
 )

;; orgのSETUPFILEヘッダを記入する
(defun insert-org-setup-header()
  (interactive)
  (insert "#+SETUPFILE: D:\\org\\header.setup")
  )

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

;;画像をフレームに合わせてレスポンシブ表示する
;;https://stackoverflow.com/questions/36465878/how-to-make-inline-images-responsive-in-org-mode
(defun org-image-resize (frame)
  (setq org-image-resize-width 30)

  (when (derived-mode-p 'org-mode)
    (if (< (window-total-width) org-image-resize-width)
	(setq org-image-actual-width (window-pixel-width))
      (setq org-image-actual-width (* org-image-resize-width (window-font-width))))
    (org-redisplay-inline-images)))
(add-hook 'window-size-change-functions 'org-image-resize)

(defun org-insert-html-img-attr()
  (interactive)
  (insert (concat "#+ATTR_HTML: :width 50%\n"))
  (insert (concat "#+CAPTION: \n"))
  )

;; orgからhtmlエクスポートする際に、画像タグはbase64エンコードする
;;下記サイトの方の関数でようやく動いた...
;;https://niklasfasching.de/posts/org-html-export-inline-images/
(defun org-html-export-to-mhtml (async subtree visible body)
  (cl-letf (((symbol-function 'org-html--format-image) 'format-image-inline))
    (org-html-export-to-html nil subtree visible body)))

(defun format-image-inline (source attributes info)
  (let* ((ext (file-name-extension source))
         (prefix (if (string= "svg" ext) "data:image/svg+xml;base64," "data:;base64,"))
         (data (with-temp-buffer (url-insert-file-contents source) (buffer-string)))
         (data-url (concat prefix (base64-encode-string data)))
         (attributes (org-combine-plists `(:src ,data-url) attributes)))
    (org-html-close-tag "img" (org-html--make-attribute-string attributes) info)))

(org-export-define-derived-backend 'html-inline-images 'html
  :menu-entry '(?h "Export to HTML" ((?h "Export to HTML (self-contained)" org-html-export-to-mhtml))))

(defun org-to-daily-report ()
  (interactive)
  (message "exporting to text file...")
  (org-ascii-export-as-ascii))

(defun slash-to-backslash (value)
  (interactive)
  (replace-regexp-in-string "/" "\\\\" value))

(defun format-path-for-wslsync (value)
  (interactive)
  (slash-to-backslash (replace-regexp-in-string "\/$" "" value)))

(defun lowercase-driveletter-in-path (value)
  (interactive)
  (replace-regexp-in-string "^C" "c" value t))

(defun my/kill-buffer-file-name-nondirectory ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (when-let ((filename (if (eq major-mode 'dired-mode)
                           default-directory
                         ;; (buffer-file-name))))
                         (replace-regexp-in-string default-directory "" buffer-file-name))))
    (message (file-name-nondirectory (kill-new filename)))))

;; ---------------------------------
;; Keybindings
;; ---------------------------------
(global-set-key [f2] 'open-report-files)
(global-set-key [f11] 'open-conf)
(global-set-key [f12] 'reload-conf)
(global-set-key [f3] 'projectile-invalidate-cache)
(global-set-key [f4] 'insert-org-setup-header)
(global-set-key (kbd "C-c d") 'org+-kill-list-item)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c n") 'my/kill-buffer-file-name-nondirectory)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-c C-0") (lambda() (interactive) (text-scale-set 0)))
(global-set-key (kbd "C-x ,") 'font-lock-mode)

;; org-mode-map
(with-eval-after-load "org"
  (define-key org-mode-map "C-x C-k" 'org-insert-html-img-attr)
  (define-key org-mode-map (kbd "C-c j") 'ced/sum-hours-in-list)
  (define-key org-mode-map (kbd "C-;") 'org-toggle-inline-images)
  (define-key org-mode-map (kbd "C-c z") 'org-export-to-html-custom)
  (define-key org-mode-map (kbd "C-c t") 'org-to-daily-report)
  )

;; ---------------------------------
;; Package-Settings
;; ---------------------------------
;; org-bullets
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;; org textエクスポート時のバレットの記号
(setq org-ascii-bullets '((ascii ?- ?- ?-) (latin1 ?- ?- ?-) (utf-8 ?- ?- ?-)))

;;(setq org-bullets-bullet-list '("" "" "" "" "" "" "" "" "" ""))
(setq org-bullets-bullet-list '("❖" "◆" "▼" "＊" "•" "•"))

;; org-superstar
(setq inhibit-compacting-font-caches t)

;; ;;;;; whitespace
;; タブや全角空白などを強調表示
(global-whitespace-mode 1)
;; whitespace-mode の 色設定
;;http://ergoemacs.org/emacs/whitespace-mode.html
(setq whitespace-style 
      '(face tabs tab-mark spaces space-mark))

(setq whitespace-display-mappings
      '(
        (space-mark ?\u3000 [?□])  ; 全角スペース
        (space-mark ?\u0020 [?\xB7])  ; 半角スペース
        (newline-mark 10 [8629 10] [182 10] [36 10])
        (tab-mark ?\t [?\xBB ?\t])
        ))

;; ;;;;; ivy
(ivy-mode t)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(define-key ivy-minibuffer-map [escape] 'minibuffer-keyboard-quit)
(setq swiper-stay-on-quit t)

;; ;;;;; company
(company-mode t)
(setq company-tooltip-align-annotations t)

;; ;;;;; dashborad
(dashboard-setup-startup-hook)
(setq dashboard-items '((recents  . 5)
                        ))

(setq dashboard-startup-banner 'logo) 
(setq dashboard-center-content t)

;; ;;;;; nyan-mode
;; (nyan-mode nil)
;; (setq nyan-wavy-trail nil)
;; (setq nyan-animate-nyancat nil)

;; ;;;;; doom-modeline
(defun pretty-buffername ()
  (if buffer-file-truename
      (let* ((cur-dir (file-name-directory buffer-file-truename))
             (two-up-dir (-as-> cur-dir it (or (f-parent it) "") (or (f-parent it) "")))
             (shrunk (shrink-path-file-mixed two-up-dir cur-dir buffer-file-truename)))
        (concat (car shrunk)
                (mapconcat #'identity (butlast (cdr shrunk)) "/")
                (car (last shrunk))))
    (buffer-name)))


(doom-modeline-mode)
;; (setq doom-modeline-buffer-file-name-style 'truncate-with-project)
(setq doom-modeline-icon t)
(setq doom-modeline-major-mode-icon nil)
(setq doom-modeline-minor-modes nil)
(setq doom-modeline-buffer-file-name-style 'truncate-upto-project)
(setq mode-line-buffer-identification '((:eval (pretty-buffername))) )
;;(add-hook 'after-init-hook doom-modeline-mode)

(defun shrink-window-horizontally-more ()
  (interactive)
  (shrink-window-horizontally 14))

(defun enlarge-window-horizontally-more ()
  (interactive)
  (enlarge-window-horizontally 14))

(add-to-list 'display-buffer-alist
	     '((lambda (buffer _) (with-current-buffer buffer
				    (seq-some (lambda (mode)
						(derived-mode-p mode))
					      '(help-mode))))
	       (display-buffer-reuse-window display-buffer-below-selected)
	       (reusable-frames . visible)
	       (window-height . 0.33)))

;; ;;;;; ripgrep
;; ;;;;; rg.el
(setq rg-command-line-flags '("--vimgrep" "--max-columns 1000" "--max-columns-preview" "--path-separator /" "--glob=!/ent"))
(setq rg-show-header t)

(setq gc-cons-threshold 128000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;; ;;;;; minions
(minions-mode t)
;; ;;;;; rainbow-identifiers-mode
;;(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)
;; ;;;;; projectile ;;;;;
(projectile-mode t)
(setq projectile-enable-caching t)
(setq projectile-svn-command "fd")
;; (setq projectile-svn-command "fd")
;; (setq projectile-svn-command "fzf")
(setq helm-source-projectile-buffer nil)
(setq helm-source-projectile-buffer-list nil)
(setq projectile-indexing-method 'native)
(setq projectile-require-project-root "prompt")

;; (global-set-key (kbd "C-c p") 'helm-projectile)
(global-set-key (kbd "C-c p") 'projectile-find-file)

;; (global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c f") 'rg-project)

;; ;;;;; org-download ;;;;;
(require 'org-download)
(add-hook 'dired-mode-hook 'org-download-enable)
;; (setq org-download-image-attr-list "aaa")
(setq org-download-annotate-function (lambda (_link) ""))
;; 画像挿入の際、絶対パスを挿入する
;; こうしないと、エクスポート時にbase64化するフック関数が上手く動かない為
(setq-default org-download-abbreviate-filename-function 'expand-file-name)

(require 'tree-sitter)
(require 'tree-sitter-langs)
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
;; (tree-sitter-hl-mode)

;; ;;;;; ox-pandoc ;;;;;
;; html5でエクスポートするとき画像はbase64化する。
(setq org-pandoc-options-for-html5 '((standalone . t) (self-contained . t)))
(setq org-latex-packages-alist '(("" "fullpage") ("avoid-all" "widows-and-orphans") ("" "svg")))

;; ;;;;; all-the-icons ;;;;;
(require 'all-the-icons)

;;NTEmacsだとfzfはうまくうごかないのでfdを代用する
;;(setq counsel-fzf-cmd "fzf -f \"%s\"")
;; (setq counsel-fzf-cmd "fd --path-separator / \"%s\"")

;; -----------------------------------------
;; UTF-8 をベースとして利用するための設定
;;
;; https://w.atwiki.jp/ntemacs/pages/16.html
;; ------------------------------------------
(require 'cl-lib)

(setenv "LANG" "ja_JP.UTF-8")

;; IME の設定をした後には実行しないこと
;; (set-language-environment "Japanese")

;(set-default-coding-systems 'utf-8-dos)
(set-default-coding-systems 'utf-8)
;(prefer-coding-system 'utf-8-unix)
(set-file-name-coding-system 'cp932)
;(setq locale-coding-system 'utf-8-unix)
(set-language-environment "UTF-8")
(set-locale-environment "ja_JP.UTF-8")
(prefer-coding-system 'utf-8)
;(setq system-time-locale nil)
;(setq system-time-locale "C")

(defun org-mode-time-locale ()
  (set (make-local-variable 'system-time-locale) "C"))
;カスタムフォーマットにするとS-up/downで変更できなくなる
;(setq-default org-display-custom-times t)
;(setq org-time-stamp-custom-formats '("<%Y/%m/%d>" . "<%Y/%m/%d %H:%M:%>"))


;; プロセスが出力する文字コードを判定して、process-coding-system の DECODING の設定値を決定する
(setq default-process-coding-system '(undecided-dos . utf-8-unix))

;; サブプロセスに渡すパラメータの文字コードを cp932 にする
(cl-loop for (func args-pos) in '((call-process        4)
                                  (call-process-region 6)
                                  (start-process       3))
         do (eval `(advice-add ',func
                               :around (lambda (orig-fun &rest args)
                                         (setf (nthcdr ,args-pos args)
                                               (mapcar (lambda (arg)
                                                         (if (multibyte-string-p arg)
                                                             (encode-coding-string arg 'cp932)
                                                           arg))
                                                       (nthcdr ,args-pos args)))
                                         (apply orig-fun args))
                               '((depth . 99)))))

;; ---------------------------------
;; Font
;;
;; https://misohena.jp/blog/2017-09-26-symbol-font-settings-for-emacs25.html
;; ---------------------------------
;; デフォルトはASCII用のフォントでなければダメっぽい。
;;(set-face-attribute 'default nil :family "Inconsolata" :height 120)
;; ASCII以外のUnicodeコードポイント全部を一括で設定する。他国語を使用する人は細かく指定した方が良いかも。
;;(set-fontset-font nil '(#x80 . #x10ffff) (font-spec :family "MS Gothic"))
(setq use-default-font-for-symbols nil)

(setq my-font "PlemolJP35 Console NF")
;(setq my-second-font "ＭＳ Ｐゴシック")
(setq my-second-font "Terminus-ja")

;; Set the default font for all text
(set-face-attribute 'default nil :family my-font :height 100 :weight 'normal)

(defun set-org-font ()
  "Set the font for Org Mode buffers."
  (face-remap-add-relative 'default :family my-second-font :height 120 :weight 'normal))

(defun restore-default-font ()
  "Restore the default font for non-Org Mode buffers."
  (interactive)
  (face-remap-reset-base 'default))

(add-hook 'org-mode-hook #'set-org-font)
(add-hook 'after-change-major-mode-hook #'restore-default-font)
(add-hook 'org-mode-hook
          (lambda ()
            (set-fontset-font t 'japanese-jisx0208 (font-spec :family my-second-font))))

(custom-set-faces
  '(org-default ((t (:family my-second-font :height 1.2))))
)

(setq-default line-spacing 0)

;;https://www.philnewton.net/guides/emacs-as-a-php-editor/
;; 下記のファイルはweb-modeで扱う
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\.twig\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(defun xah-new-empty-buffer ()
  "Create a new empty buffer.
New buffer will be named “untitled” or “untitled<2>”, “untitled<3>”, etc.

URL `http://ergoemacs.org/emacs/emacs_new_empty_buffer.html'
Version 2016-12-27"
  (interactive)
  (let ((-buf (generate-new-buffer "untitled"))) ;; 空のバッファを作成する。このとき-buf変数にどこのバッファかを情報として残しておく
    (switch-to-buffer -buf) ;; -buf(空の新しいバッファ)にスイッチする
    (funcall initial-major-mode) ;; バッファのメジャーモードはまっさらにしておく
    (setq buffer-offer-save t))) ;; Emacsを終了するときに保存するかどうかを確認する

;; custom-theme-set-faces 'user
;; (org-level-1 ((t (:underline t :height 1.5))))
;; (org-level-2 ((t (:height 1.25))))
;; (org-level-3 ((t (:height 1.25))))
;; (org-level-4 ((t ())))

(defun increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0-9")
  (or (looking-at "[0-9]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

(global-set-key (kbd "C-c +") 'increment-number-at-point)

(defun create-scratch-buffer nil
  "create a scratch buffer"
  (interactive)
  (switch-to-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode))           

;; ----------------------------
(require 'emojify)
(global-emojify-mode)

(defun farynaio/org-link-copy (&optional arg)
  "Extract URL from org-mode link and add it to kill ring."
  (interactive "P")
  (let* ((link (org-element-lineage (org-element-context) '(link) t))
          (type (org-element-property :type link))
          (url (org-element-property :path link))
          (url (concat type ":" url)))
    (kill-new url)
    (message (concat "Copied URL: " url))))
(define-key org-mode-map (kbd "C-x C-l") 'farynaio/org-link-copy)


;(custom-set-faces
; '(org-level-1 ((t (:underline t :background "black")))))

(custom-set-faces
 '(org-block ((t (:background "#1f1f1f" :border "2px solid red")))))

(custom-set-faces
  '(org-level-1 ((t (:underline t)))))

(global-font-lock-mode t)
(setq org-src-fontify-natively t)

(setq org-export-headline-levels 0)
(setq org-export-with-section-numbers nil)
(setq org-export-with-toc nil)

(defun 795-now-playing ()
  (interactive)
  (let ((data (get-json "https://www.nack5.co.jp/on-air.json")))
	(message "Song: `%s` by `%s`" (alist-get 'music_title data) (alist-get 'artist_name data))
	))

(defun get-json (uri)
  "Fetch the contents of URI and parse."
  (with-current-buffer (url-retrieve-synchronously uri)
    (goto-char (point-min))
    (goto-char url-http-end-of-headers)
    (prog1 (json-read)
      (kill-buffer))))

(defun my-org-open-unc-link ()
  "Open UNC links in Windows Explorer."
  (interactive)
  (let ((link (org-element-context)))
    (if (string= (org-element-type link) "link")
        (let ((path (org-element-property :path link)))
          (if (string-match "^\\\\\\\\" path) ; Check if it's a UNC path
              (progn
                ;; Replace backslashes with forward slashes
                (setq path (replace-regexp-in-string "\\\\" "/" path))
                (w32-shell-execute "open" path)) ; Open in Windows Explorer
            (org-open-at-point)))))) ; Open other links as usual

;; Bind a key to the custom function (you can change the keybinding to your preference)
(global-set-key (kbd "C-c o") 'my-org-open-unc-link)


  (defun set-buffer-variable-pitch ()
    (interactive)
    (variable-pitch-mode t)
    (setq line-spacing 3)
     (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
     (set-face-attribute 'org-code nil :inherit 'fixed-pitch)
     (set-face-attribute 'org-block nil :inherit 'fixed-pitch)
     ;(set-face-attribute 'org-block-background nil :inherit 'fixed-pitch)
    )

  (add-hook 'org-mode-hook 'set-buffer-variable-pitch)
  (add-hook 'eww-mode-hook 'set-buffer-variable-pitch)
  (add-hook 'markdown-mode-hook 'set-buffer-variable-pitch)
  (add-hook 'Info-mode-hook 'set-buffer-variable-pitch)

 '(variable-pitch ((t (:height 200 :family "Georgia"))))
