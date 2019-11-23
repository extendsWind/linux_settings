;;; .emacs --- My initialization file for Emacs
;;; Commentary: Emacs Startup File --- initialization for Emacs

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;; Code:


;; coding system for Chinese: M-x revert-buffer-with-coding-system

;; emacs -q -l ~/.emacs_alone


(setq gc-cons-threshold 100000000) ;; reduce the startup time

(setq package-check-signature nil)  ;; unknown problem


;;; Commentary:
;; 

(require 'package)

(setq package-archives '(("gnu" . "http://mirrors.163.com/elpa/gnu/");; http://elpa.emacs-china.org/gnu/")
                          ;;http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))


;; activate all the packages
(package-initialize)

;; fetch the list of packages available
(unless package-archive-contents (package-refresh-contents))


;; ### for package install  
(setq package-list '(better-defaults spacemacs-theme undo-tree evil dumb-jump
				     company python-mode neotree
				     flycheck markdown-mode flymd elpy helm which-key use-package
				     js2-mode xref-js2 company-tern;; js
             org-ref
				     session ;; for start up

				     ;;    ein ;; jupyter-notebook for python
				     ))

					; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))



  
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#ffffff"])
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(custom-safe-themes
   (quote
    ("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
 '(hl-todo-keyword-faces
   (quote
    (("TODO" . "#dc752f")
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
     ("\\?\\?\\?+" . "#dc752f"))))
 '(package-selected-packages
   (quote
    (2048-game spacemacs-theme markdown-toc org-pomodoro elisp-format helm molokai-theme dumb-jump evil auto-complete-c-headers auto-complete python-mode neotree flycheck material-theme better-defaults undo-tree)))
 '(pdf-view-midnight-colors (quote ("#ffffff" . "#292b2e")))
 '(spacemacs-theme-custom-colors (quote ((base . "#ffffff"))))
 '(tool-bar-mode nil))

;; not show tool bar
;; emms not used default
;; using theme "molokai"

(provide '.emacs)
;;; .emacs ends here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "文泉驿等宽微米黑" :foundry "WQYF" :slant normal :weight normal :height 108 :width normal)))))

;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;   (set-fontset-font (frame-parameter nil 'font)
;;                     charset (font-spec :family "cascadia" :size 15)))



;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(default ((t (:family "Droid Sans Mono" :foundry "1ASC" :slant normal :weight normal :height 113 :width normal)))))






;; ### startup
(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'spacemacs-dark t)		 ;; load material theme, using
(global-linum-mode t)		 ;; enable line numbers globally

;; (global-visual-line-mode nil)  ;; not break a word

(fset 'yes-or-no-p 'y-or-n-p)  ;; change yes-or-no to y-or-n

(save-place-mode 1)  ;; restore file position after re-openning files


;;(require 'session)
;;(add-hook 'after-init-hook 'session-initialize)

(toggle-frame-maximized) ;; startup maximize



;; ### setting the font

;; default font setting
;; (set-frame-font "Microsoft Yahei 10" nil t)

;; (add-to-list 'default-frame-alist '(font . "Droid Sans Mono-11" ))
;; (set-face-attribute 'default t
;;		    :font "Droid Sans Mono-11" )


;;;中文与英文字体设置
;; 字体不等宽时会带慢光标的移动速度
;; 前面是设置英文字体（Lucida Console)，后面设置中文字体(microsoft yahei)
;; Auto generated by cnfonts
;; <https://github.com/tumashu/cnfonts>

;; (set-face-attribute 'default nil
;; 		    :font (font-spec :name
;; 				     "-outline-Lucida Console-normal-normal-normal-mono-*-*-*-*-c-*-iso10646-1"
;; 				     :weight 'normal
;; 				     :slant 'normal
;; 				     :size 10.0))
;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;   (set-fontset-font (frame-parameter nil 'font) charset (font-spec :name
;; 								   "-outline-microsoft yahei-bold-normal-normal-sans-*-*-*-*-p-*-iso10646-1"
;; 								   :weight 'normal
;; 								   :slant 'normal
;; 								   :size 10.5)))

(setq-default line-spacing 0.3)


;; ### backup file and autosave file

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

;; ### evil for vim edit
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

;; Use j/k to move one visual line insted of gj/gk
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)

;; remove all keybindings from insert-state keymap, use emacs-state when editing
(setcdr evil-insert-state-map nil)
;; ESC to switch back normal-state
(define-key evil-insert-state-map [escape] 'evil-normal-state)

;; TAB to indent in normal-state
(define-key evil-normal-state-map (kbd "TAB") 'indent-for-tab-command)

;;	(define-key evil-insert-state-map (kbd "jk") 'evil-normal-state)
;;	(define-key evil-insert-state-map (kbd "jj") 'insert-jay)
;;
;;	(define-key help-mode-map (kbd "i") 'evil-emacs-state)


;; ### for markdown
;; #### markdown-mode
;; download the markdown.pl to "~/.emacs.d/markdown-mode" first
;; add load-path for markdown-mode
(add-to-list 'load-path "~/.emacs.d/markdown-mode")
;; set autoload and ".md" file assosiation
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '(".md" . markdown-mode) auto-mode-alist))

;; #### for markdown fly render
(require 'flymd)

;; ### pandoc for org and markdown file convert to pdf
;; markdown convert may failed for too many level in TOC generated by
;; markdown-toc-generate
(defun pandoc-export-to-pdf()
  "Convert org or markdown file to pdf by pandoc."
  (interactive)
  ;;(message "test")
  ;;(message (buffer-file-name))
  ;; pandoc --pdf-engine=xelatex -V CJKmainfont=KaiTi test.md -o test1.pdf
  (defvar file-ext (file-name-extension (buffer-file-name) ))
  (if (or (string-equal file-ext "org") (string-equal file-ext "md"))
      (progn
	(defvar pandoc-str (concat
			    "pandoc --pdf-engine=xelatex "
			    ;;"-V CJKmainfont=SimSong "
			    ;;"-V geometry:\"top=2cm, bottom=1.5cm, left=1cm, right=1cm\" "
			    "-o "
			    (file-name-base (buffer-file-name))
			    ".pdf "
			    (buffer-file-name)))
	(message pandoc-str)
	(shell-command pandoc-str))
    (message "Convert Finished")
    (message "file type is not org or md")
    )
  )

;; #### markdown code block highlight
(setq markdown-fontify-code-blocks-natively t)


;; ### for org-mode and org-ref

;; #### org archive
;; 配置归档文件的名称和Headline格式
;; (setq org-archive-location "::* Archived Tasks")
(setq org-archive-location "::datetree")

;; #### org indent mode
(add-hook 'org-mode-hook 'org-indent-mode)

;; #### org line truncate
(add-hook 'org-mode-hook #'toggle-truncate-lines) 



;; #### for agenda
(setq org-agenda-files (list "~/todo.org"))

;; #### org mode todo
(setq org-log-done 'time) ;; todo 标记为DONE时加上时间

;; #### run code
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))
(setq org-confirm-babel-evaluate nil)


;; #### org capture
;; (setq org-directory "~/git/org")
(setq org-default-notes-file "~/todo.org")

;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/todo.org")
               "* TODO %?\n%T\n" )
;;              ("r" "respond" entry (file "~/todo.org")
;;               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
;;              ("n" "note" entry (file "~/note.org")
;;               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
;;              ("j" "Journal" entry (file+datetree "~/dairy.org")
;;               "* %?\n%U\n" :clock-in t :clock-resume t)
;;              ("w" "org-protocol" entry (file "~/todo.org")
;;               "* TODO Review %c\n%U\n" :immediate-finish t)
;;              ("m" "Meeting" entry (file "~/todo.org")
;;               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
;;              ("p" "Phone call" entry (file "~/todo.org")
;;               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
;;              ("h" "Habit" entry (file "~/todo.org")
;;               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n")
	      )))


;; #### org-ref
(require 'org-ref)
(setq bibtex-completion-bibliography
      '("mybib.bib"))

;; will export a random label and cause wrong if not set
(setq org-latex-prefer-user-labels t)

(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
	"bibtex %b"
	"pdflatex -interaction nonstopmode -output-directory %o %f"
	"pdflatex -interaction nonstopmode -output-directory %o %f"))

(defun pandoc-export-to-docx()
  "Convert org or markdown file to doc by pandoc."
  (interactive)
  ;;(message "test")
  ;;(message (buffer-file-name))
  ;; pandoc --pdf-engine=xelatex -V CJKmainfont=KaiTi test.md -o test1.pdf
  (defvar file-ext (file-name-extension (buffer-file-name) ))
    (if (or (string-equal file-ext "org") (string-equal file-ext "md"))
      (progn
	(defvar pandoc-str (concat
			    "pandoc --bibliography=mybib.bib --filter pandoc-citeproc "
			    "-V geometry:\"top=2cm, bottom=1.5cm, left=1cm, right=1cm\" -o "
			    (file-name-base (buffer-file-name))
			    ".docx "
			    (buffer-file-name)))
	(message pandoc-str)
	(shell-command pandoc-str))
    (message "Convert Finished")
    (message "file type is not org or md")
    )
  )

;; ### for python
;; the plugin: elpy  flycheck
;; M-n/p for auto-complete candiate chosen

;; #### elpy for python
(elpy-enable)

(when
    (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;;(elpy-use-ipython) depressed
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")

(setq elpy-rpc-python-command "python3")

;; #### realgud for debug

;; `load-library realgud`
;; `realgud:ipdb` start debugger

;; Command 	Action
;; n, F10 	Next (aka “step over”, “step through”)
;; s, SPC, F11 	Step (aka “step into”)
;; f, S-F11 	Finish (aka “step out”, “return”)
;; c, F5 	Continue (run to next break point)
;; 
;; Using breakpoints
;; Command 	Action
;; b, F9 	Set breakpoint mouse2
;; D 	Clear breakpoint mouse2 (by number)
;; 
;; Inspecting variables
;; Command 	Action
;; mouse-2 (middle button) 	Inspect variable under cursor (in tooltip) mouse2
;; e 	Evaluate expression
;; 
;; Control commands
;; Command 	Action
;; q, S-F5 	Quit
;; R, r 	Run (aka “restart”)
;; S 	Go to command window


;; ### c++ cpp



(add-hook 'after-init-hook 'global-company-mode)

(defun compile-and-run-cpp-code()
  "Compile and run a cpp code."
  (interactive)
  (defvar file-ext (file-name-extension (buffer-file-name) ))
  (if (or (string-equal file-ext "cpp") (string-equal file-ext "c"))
      (progn
	(defvar compile-run-str (concat
				 "clang++ "
				 (buffer-file-name)
				 " && ./a.out"
				 ))
	(message compile-run-str)
	(shell-command compile-run-str))
    (message "Convert Finished")
    (message "file type is not org or md")
    )
  )


;; ### javascript
;; (require 'js2-mode)
;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; 
;; ;; Better imenu
;; (add-hook 'js2-mode-hook #'js2-imenu-extras-mode)
;; 
;; (require 'xref-js2)
;; (add-hook 'js2-mode-hook (lambda ()
;;   (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))
;; 
;; (require 'company)
;; (require 'company-tern)
;; 
;; (add-to-list 'company-backends 'company-tern)
;; (add-hook 'js2-mode-hook (lambda ()
;;                            (tern-mode)
;;                            (company-mode)))
;; 
;; ;; Disable completion keybindings, as we use xref-js2 instead
;; (define-key tern-mode-keymap (kbd "M-.") nil)
;; (define-key tern-mode-keymap (kbd "M-,") nil)
;; 

;; ### emms for music play
;;(setq exec-path (append exec-path '("G:/Program Files (x86) portable/Anki")))
;;(require 'emms-setup)
;;(require 'emms-player-mplayer)
;;(emms-standard)
;;(emms-default-players)
;;(define-emms-simple-player mplayer '(file url)
;;      (regexp-opt '(".ogg" ".mp3" ".wav" ".mpg" ".mpeg" ".wmv" ".wma"
;;                    ".mov" ".avi" ".divx" ".ogm" ".asf" ".mkv" "http://" "mms://"
;;                    ".rm" ".rmvb" ".mp4" ".flac" ".vob" ".m4a" ".flv" ".ogv" ".pls"))
;;      "mplayer" "-slave" "-quiet" "-really-quiet" "-fullscreen")
;;(setq emms-source-file-default-directory "D:/Users/fly/Music")


;; ### neotree  (long time no use..)
;; (require 'neotree)
;; (global-set-key [f8] 'neotree-toggle)


;; ### coding system setting
(prefer-coding-system 'utf-8)
;;(setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
(set-language-environment 'utf-8)
(set-keyboard-coding-system 'utf-8-mac) ; For old Carbon emacs on OS X only
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(unless (eq system-type 'windows-nt)
  (set-selection-coding-system 'utf-8))


;; ### browse-file-directory
(defun open-file-directory ()
  "Open the current file's directory by system file explorer"
  (interactive)
  (if default-directory (browse-url-of-file (expand-file-name default-directory))
    (error
     "No `default-directory' to open")))

;; ### for code jump
;; depandent on ag( The Silver Searcher )
;; (dump-jump-mode)


;; ### helm
(define-key evil-normal-state-map (kbd "M-x") 'helm-M-x)
(define-key evil-insert-state-map (kbd "M-x") 'helm-M-x)

;; ### show shortcut
(require 'which-key)
(which-key-mode)
;;(use-package which-key :ensure t)


;;(recentf-mode)
;; ### spacemacs like keybinding

(define-key evil-normal-state-map (kbd "SPC SPC") 'helm-M-x)

;; file
(define-key evil-normal-state-map (kbd "SPC f f") 'helm-find-files)
(define-key evil-normal-state-map (kbd "SPC f r") 'helm-recentf)

;; window
(define-key evil-normal-state-map (kbd "SPC w /") 'split-window-right)
(define-key evil-normal-state-map (kbd "SPC w -") 'split-window-below)
(define-key evil-normal-state-map (kbd "SPC w k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "SPC w j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "SPC w h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "SPC w l") 'evil-window-right)
(define-key evil-normal-state-map (kbd "SPC w d") 'evil-window-delete)
(define-key evil-normal-state-map (kbd "SPC w o") 'delete-other-windows)

;; buffer
(define-key evil-normal-state-map (kbd "SPC b d") 'evil-delete-buffer)
(define-key evil-normal-state-map (kbd "SPC b n") 'next-buffer)
(define-key evil-normal-state-map (kbd "SPC b p") 'previous-buffer)
(define-key evil-normal-state-map (kbd "SPC b l") 'helm-buffers-list)
(define-key evil-normal-state-map (kbd "SPC TAB") 'evil-switch-to-windows-last-buffer)

;; org-mode
(define-key evil-normal-state-map (kbd "t") 'org-todo)

;; c++
(define-key evil-normal-state-map (kbd "SPC m r") 'compile-and-run-cpp-code)

