
;; cask
(require 'cask "~/.cask/cask.el")

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'cask)
(cask-initialize)

;; theme
(load-theme 'tango-dark t)

(fset 'yes-or-no-p 'y-or-n-p)

(recentf-mode 1)

(prefer-coding-system 'utf-8-unix)
(set-file-name-coding-system 'utf-8-unix)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

(setq load-path
      (append '("~/.emacs.d/site-lisp") load-path))

(setq make-backup-files nil)
;;; バックアップファイルを作らない
(setq backup-inhibited t)
;;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)
;; テンキーのエンター
(global-set-key [kp-enter] 'newline)

(setq-default indent-tabs-mode nil)

(menu-bar-mode nil)

(column-number-mode t)

;; バッファ中の行番号表示
(global-linum-mode t)

;; 行番号のフォーマット
(set-face-attribute 'linum nil :foreground "MediumVioletRed" :height 0.8)
(setq linum-format "%4d|")

;; 現在行をハイライト
(global-hl-line-mode t)
(defface my-hl-line-face
  '((((class color) (background dark))
     (:background "DarkSlateGray" t))
    (((class color) (background light))
     (:background "DarkSlateGray" t))
    (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; php-mode
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(php-mode-force-pear t))

(defun php-mode-hook ()
  (setq tab-width 4
        c-basic-offset 4
        c-hanging-comment-ender-p nil
        indent-tabs-mode
        (not
         (and (string-match "/\\(PEAR\\|pear\\)/" (buffer-file-name))
              (string-match "\.php$" (buffer-file-name))))))

(add-hook 'php-mode-hook
          (function (lambda ()
                      (define-key php-mode-map "/" 'self-insert-command)
                      (setq comment-style 'extra-line)
                      (setq comment-continue " * ")
                      (setq comment-start "/** ")
                      (setq comment-end " */"))))

(defun php-cs-fix ()
  (interactive)
  (progn (shell-command (concat "~/.composer/vendor/bin/php-cs-fixer fix " (buffer-file-name) " --rules=@PSR2"))
         (revert-buffer nil t)))
(add-hook 'php-mode-hook 'flycheck-mode)

;; ruby-mode
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))

;; auto-save-buffers
(require 'auto-save-buffers-enhanced)
(auto-save-buffers-enhanced t)
;(run-with-idle-timer 0.5 t 'auto-save-buffers-enhanced)


(setq truncate-partial-width-windows nil)

;; cperl-mode
(defalias 'perl-mode 'cperl-mode)
(add-hook 'cperl-mode-hook
          '(lambda ()
             (cperl-set-style "PerlStyle")))

;; Lua
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; ActionScript
(autoload 'actionscript-mode "actionscript-mode" "actionscript" t)
(setq auto-mode-alist
      (append '(("\\.as$" . actionscript-mode))
              auto-mode-alist))

;; golang
(add-hook 'go-mode-hook
          (lambda ()
            (setq gofmt-command "goimports")
            (setq-default)))
;; git
(require 'magit)
(setq magit-last-seen-setup-instructions "1.4.0")
;(require 'git-blame)
;(require 'vc-git)

;; company-mode
(add-hook 'php-mode-hook 'company-mode)
(add-hook 'python-mode-hook 'company-mode)
(add-hook 'ruby-mode-hook 'company-mode)

;; org-mode
(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; markdown
(setq auto-mode-alist
      (append '(("\\.md$" . markdown-mode)) auto-mode-alist))

(setq require-final-newline nil)

;; YAML
(require 'yaml-mode)
(put 'downcase-region 'disabled nil)

;; coffee
(defun coffee-custom ()
  "coffee-mode-hook"
 (set (make-local-variable 'tab-width) 2)
 (setq coffee-tab-width 2))

(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

;; scss
(autoload 'scss-mode "scss-mode")
(setq scss-compile-at-save nil) ;; 自動コンパイルをオフにする
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; helm
(require 'helm)
;(require 'helm-config)
;(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-r") 'helm-recentf)

(require 'cl)
(defun close-all-buffers ()
  (interactive)
  (loop for buffer being the buffers
        do (kill-buffer buffer)))

;; rst.elを読み込み
(require 'rst)
;; *.rst, *.restファイルをrst-modeでOpen
(setq auto-mode-alist
      (append '(("\\.rst$" . rst-mode)
                ("\\.rest$" . rst-mode)
                ) auto-mode-alist))

;; yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"))
(yas-global-mode 1)

(require 'autoinsert)
;; テンプレートのディレクトリ
(setq auto-insert-directory "~/.emacs.d/template/")
;; 各ファイルによってテンプレートを切り替える
(setq auto-insert-alist
      (nconc '(
               ("\\.md$" . ["template.md" my-template])
               ("\\.rst$" . ["template.rst" my-template])
               ("\\.rb$" . ["ruby" my-template])
               ("Rakefile$" . ["ruby" my-template])
               ) auto-insert-alist))

;; テンプレート置換文字列
(defvar template-replacements-alists
  '(("%date%" . (lambda () (format-time-string "%Y-%m-%d %H:%M:%S")))))

(defun my-template ()
  (time-stamp)
  (mapc #'(lambda(c)
        (progn
          (goto-char (point-min))
          (replace-string (car c) (funcall (cdr c)) nil)))
    template-replacements-alists)
  (goto-char (point-max))
  (message "done."))
(add-hook 'find-file-not-found-hooks 'auto-insert)

;; all indent
(defun all-indent ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max))))
(defun electric-indent ()
  "Indent specified region.
When resion is active, indent region.
Otherwise indent whole buffer."
  (interactive)
  (if (use-region-p)
      (indent-region (region-beginning) (region-end))
    (all-indent)))
(global-set-key (kbd "C-M-\\") 'electric-indent)

(add-hook 'rhtml-mode-hook
          (lambda ()
            (set-face-background 'erb-face "brightblack")
            (set-face-underline-p 'erb-face t)
            (set-face-background 'erb-exec-face "brightblack")
            (set-face-underline-p 'erb-exec-face t)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-builtin-face ((t (:foreground "color-141"))))
 '(font-lock-string-face ((t (:foreground "color-142"))))
 '(magit-section-highlight ((t (:background "brightblack")))))

(provide 'init)
;;; init.el ends here
