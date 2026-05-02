module TopBar (withBar) where

import Control.Concurrent (forkIO)
import Control.Monad (void)
import Themes
import XMonad
import XMonad.Hooks.DynamicLog
import Xmobar

xmobarConf :: Xmobar.Config
xmobarConf =
  Xmobar.defaultConfig
    { bgColor = backgroundColor
    , fgColor = foregroundColor
    , Xmobar.font = Themes.font
    , additionalFonts = ["Sarasa Mono SC 24", "Monaspace Neon NF 24", "Monaspace Neon NF 20"]
    , Xmobar.allDesktops = True
    , position = TopH 42
    , template = "}%UnsafeXMonadLog%{<fc=#7f849c><fn=3>%date%</fn></fc>"
    , commands =
        [ Run UnsafeXMonadLog
        , Run $ Date "%b %d %a %H:%M " "date" 10
        ]
    }

runXmobar :: IO ()
runXmobar = void . forkIO . Xmobar.xmobar $ xmobarConf

pp :: PP
pp = xmobarPP
  { ppCurrent         = wrap "<fn=2>" "</fn>" . xmobarColor backgroundColor primaryColor . wrap " " " "
  , ppVisible         = wrap "<fn=2>" "</fn>" . xmobarColor primaryColor "" . wrap " " " "
  , ppHidden          = wrap "<fn=2>" "</fn>" . xmobarColor dimColor "" . wrap " " " "
  , ppHiddenNoWindows = wrap "<fn=2>" "</fn>" . xmobarColor backgroundColor "" . wrap " " " "
  , ppTitle           = wrap "<fn=1>" "</fn>" . xmobarColor "#7f849c" "" . shorten 80
  , ppSep             = xmobarColor "#7f849c" "" " | "
  , ppOrder           = \xs -> case xs of (ws:_:t:_) -> [ws, t]; _ -> xs
  }

publishWorkspaces :: X ()
publishWorkspaces = dynamicLogString pp >>= xmonadPropLog

withBar :: XConfig l -> XConfig l
withBar c =
  c { logHook     = publishWorkspaces
    , startupHook = startupHook c <> io runXmobar
    }
