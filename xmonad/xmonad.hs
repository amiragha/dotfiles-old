--
-- xmonad.hs file.
-- My xmonad config file.
--
-- This is made by changing the template showing all available
-- configuration hooks, and how to change them plus a selection of
-- parts from various configs on github

import XMonad
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.Magnifier
import XMonad.Util.Themes
import Data.Monoid
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.DynamicLog
import System.Exit
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Ssh
import XMonad.Prompt.Window

import qualified XMonad.Actions.Submap as SM
import qualified XMonad.Actions.Search as S
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program, which is used in a binding below
-- and by certain contrib modules.  Note that the daemon should be
-- started (e.g. in .xinitrc)
myTerminal      = "urxvtc"
myShell         = "zsh"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the
-- window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. mod4Mask is
-- the "windows key" or "super key".
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- Any string may be used as a workspace name. The number of
-- workspaces is determined by the length of this list.
--example:
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

-- colors
myFgColor       = "#888888"
myFgHLight      = "#FFFFFF"
myFgDimLight    = "#505050"
myTextHLight    = "#FAFAC0"
myNotifyColor   = "#F39D21"
myWarningColor  = "#D23D3D"

myBgColor       = "#181512"
myBgDimLight    = "#333333"
myBgHLight      = "#4C7899"
myBorderColor   = "#222222"
myBorderHLight  = "#285577"

myFont          = "xft:Inconsolata:pixelsize=14"

myXPConfig :: XPConfig
myXPConfig = defaultXPConfig
             { font        = myFont
             , bgColor     = myBgColor
             , fgColor     = myFgColor
             , fgHLight    = myFgHLight
             , bgHLight    = myBgHLight
             , borderColor = myBorderColor
             , position    = Top
             }

myWindowXPConfig = myXPConfig
                   { autoComplete = Just 500000
                   , bgColor  = "#ffdead"
                   , fgColor  = "#666666"
                   }

mySshXPConfig = myXPConfig
                { bgColor  = "#4682b4"
                , fgColor  = "#eeeeee"
                }

mySearchXPConfig = myXPConfig
                   {fgColor = "#6A6AFF"
                   }

searchEngineMap method = M.fromList $
       [ ((0, xK_g), method S.google)
       , ((0, xK_h), method S.hoogle)
       , ((0, xK_d), method S.dictionary)
       , ((0, xK_y), method S.youtube)
       , ((0, xK_w), method S.wikipedia)
       ]

myTheme = defaultTheme {
        activeColor = blue
        , inactiveColor = grey
        , activeBorderColor = blue
        , inactiveBorderColor = grey
        , activeTextColor = "white"
        , inactiveTextColor = "black"
        , fontName = "xft:inconsolata:size=12"
        , decoHeight = 16
        }
  where
    blue = "#4a708b"
    grey = "#cccccc"

------------------------------------------------------------------------
-- The help string
help :: String
help = unlines [
  "The default modifier key is 'alt'. Default keybindings:",
  "",
  "-- launching and killing programs",
  "mod-Shift-Enter  Launch xterminal",
  "mod-p            Launch dmenu",
  "mod-Shift-p      Launch gmrun",
  "mod-Shift-c      Close/kill the focused window",
  "mod-Space        Rotate through the available layout algorithms",
  "mod-Shift-Space  Reset the layouts on the current workSpace to default",
  "mod-n            Resize/refresh viewed windows to the correct size",
  "",
  "-- move focus up or down the window stack",
  "mod-Tab        Move focus to the next window",
  "mod-Shift-Tab  Move focus to the previous window",
  "mod-j          Move focus to the next window",
  "mod-k          Move focus to the previous window",
  "mod-m          Move focus to the master window",
  "",
  "-- modifying the window order",
  "mod-Return   Swap the focused window and the master window",
  "mod-Shift-j  Swap the focused window with the next window",
  "mod-Shift-k  Swap the focused window with the previous window",
  "",
  "-- resizing the master/slave ratio",
  "mod-h  Shrink the master area",
  "mod-l  Expand the master area",
  "",
  "-- floating layer support",
  "mod-t  Push window back into tiling; unfloat and re-tile it",
  "",
  "-- increase or decrease number of windows in the master area",
  "mod-comma  (mod-,)   Increment the number of windows in the master area",
  "mod-period (mod-.)   Deincrement the number of windows in the master area",
  "",
  "-- quit, or restart",
  "mod-Shift-q  Quit xmonad",
  "mod-q        Restart xmonad",
  "mod-[1..9]   Switch to workSpace N",
  "",
  "-- Workspaces & screens",
  "mod-Shift-[1..9]   Move client to workspace N",
  "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
  "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
  "",
  "-- Mouse bindings: default actions bound to mouse events",
  "mod-button1  Set the window to floating mode and move by dragging",
  "mod-button2  Raise the window to the top of the stack",
  "mod-button3  Set the window to floating mode and resize by dragging"]

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask,       xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    -- , ((modm,                     xK_p     ), spawn "dmenu_run -fn 'xft:Inconsolata 12'")

    -- launch gmrun
    -- , ((modm .|. shiftMask,       xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask,       xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,                     xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask,       xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,                     xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,                     xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,                     xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,                     xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,                     xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,                     xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask,       xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask,       xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,                     xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,                     xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,                     xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm,                     xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm,                     xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              ,    xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask,       xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              ,       xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    -- , ((modMask .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))

    -- Prompts
    , ((modm .|. controlMask,     xK_x     ), shellPrompt myXPConfig)
    , ((modm .|. controlMask,     xK_s     ), sshPrompt mySshXPConfig)
    , ((modm .|. shiftMask,       xK_g     ), windowPromptGoto myWindowXPConfig)
    , ((modm .|. shiftMask,       xK_b     ), windowPromptBring myWindowXPConfig)

    -- Search commands
    , ((modm, xK_s), SM.submap $ searchEngineMap $ S.promptSearch mySearchXPConfig)
    , ((modm .|. shiftMask, xK_s), SM.submap $ searchEngineMap $ S.selectSearch)
    --take a screenshot of entire display
    , ((modm ,                    xK_Print ), spawn "scrot screen_%Y-%m-%d-%H-%M-%S.png -d 1")

    --take a screenshot of focused window
    , ((modm .|. controlMask, xK_Print ), spawn "scrot window_%Y-%m-%d-%H-%M-%S.png -d 1-u")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = tiled ||| Mirror tiled ||| Full ||| -- simpleTabbed |||
           tabbed shrinkText myTheme |||
           magnifier (Tall 1 (3/100) (1/2))
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = spacing 8 $ Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 2/3

     -- Percent of screen to increment by when resizing panes
     delta   = 5/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
               [ className =? "MPlayer"        --> doFloat
               , className =? "Gimp"           --> doFloat
               , resource  =? "desktop_window" --> doIgnore
               , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
  where fadeAmount = 0.7

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad =<< xmobar defaults
-- main = xmonad defaults
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
