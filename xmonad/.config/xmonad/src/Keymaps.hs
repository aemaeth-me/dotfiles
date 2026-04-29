module Keymaps (withKeys) where

import XMonad
import XMonad.Util.EZConfig

bindings :: [(String, X ())]
bindings =
  [ ("M-p", spawn "rofi -show drun -m -1 -dpi 180"),
    ("M-q", kill),
    ("M-<Return>", spawn "alacritty")
  ]

withKeys :: XConfig l -> XConfig l
withKeys = flip additionalKeysP bindings
