;; -*- lexical-binding: t; -*-

;;; poe-lootfilter-mode.el --- Major mode for editing Path of Exile lootfilters

;; Copyright 2019 Jeremiah Dodds <jeremiah.dodds@gmail.com>

;; Author: Jeremiah Dodds <jeremiah.dodds@gmail.com>
;; Version: 0.1
;; Package-Requires: ((emacs "24.3"))
;; URL: https://github.com/jdodds/poe-lootfilter-mode
;; Keywords: languages, games

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Provides basic support for editing Path of Exile lootfilters.

;;; Code:

(defconst poe-lootfilter-condition-regexp
  (concat
   "^\\s-*"
   (regexp-opt
    '("ItemLevel"
      "DropLevel"
      "Quality"
      "Rarity"
      "Class"
      "BaseType"
      "Sockets"
      "LinkedSockets"
      "SocketGroup"
      "Height"
      "Width"
      "HasExplicitMod"
      "AnyEnchantment"
      "HasEnchantment"
      "StackSize"
      "GemLevel"
      "Identified"
      "Corrupted"
      "ElderItem"
      "ShaperItem"
      "FracturedItem"
      "SynthesisedItem"
      "ShapedMap"
      "MapTier"))))

(defconst poe-lootfilter-command-regexp
  (concat
   "^\\s-*"
   (regexp-opt
    '("SetBorderColor"
      "SetTextColor"
      "SetBackgroundColor"
      "SetFontSize"
      "PlayAlertSound"
      "PlayAlertSoundPositional"
      "DisableDropSound"
      "CustomAlertSound"
      "MinimapIcon"
      "Size"
      "Color"
      "Shape"
      "Displays"
      "PlayEffect"))))

(defun poe-lootfilter-indent-line ()
  "Indent the current line if we're inside a block."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (when (or (looking-at-p poe-lootfilter-condition-regexp)
              (looking-at-p poe-lootfilter-command-regexp))
      (delete-horizontal-space)
      (insert-tab))))

;;;###autoload
(define-generic-mode poe-lootfilter-mode
  '(?#)
  '("Show" "Hide")
  `((,poe-lootfilter-condition-regexp (0 font-lock-variable-name-face))
    (,poe-lootfilter-command-regexp (0 font-lock-function-name-face)))
  '("\\.filter$")
  (list
   (function
    (lambda ()
      (setq-local indent-line-function #'poe-lootfilter-indent-line)
      (setq-local mode-name "lootfilter"))))
  "Generic mode for Path of Exile item filters.")

(provide 'poe-lootfilter-mode)

;;; poe-lootfilter-mode.el ends here
