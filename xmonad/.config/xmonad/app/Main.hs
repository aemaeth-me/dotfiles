module Main (main) where

import Keymaps
import Themes
import TopBar
import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders

main :: IO ()
main =
  xmonad . withKeys . withBar $
    desktopConfig
      { modMask = mod4Mask,
        terminal = "alacritty",
        borderWidth = 2,
        focusedBorderColor = primaryColor,
        normalBorderColor = backgroundColor,
        workspaces = ["〩", "〨", "〧", "〦", "〥", "〤", "〣", "〢", "〡"],
        layoutHook = smartBorders $ avoidStruts (Tall 1 0.03 0.62) ||| noBorders Full
      }
