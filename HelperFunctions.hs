module HelperFunctions where

import Control.Monad
import Control.Monad.IO.Class
import Data.IORef
import Graphics.UI.Gtk hiding (rectangle)
import Graphics.Rendering.Cairo
import Data.List
import Data.Typeable
import Text.Read
import Data.Maybe

-- | The 'moveForward' function moves the logo in forward direction.
-- It takes one argument of type 'Double'.
moveForward :: Double -> Render ()
moveForward distance = do

    (w, h) <- getCurrentPoint

    lineTo w (h - distance)
    stroke

    markEnd w (h - distance)
    where markEnd x y = do

            setSourceRGB 0 1 0
            moveTo x y
            lineTo x y
            stroke
            setSourceRGB 1 0 0
            moveTo x y
            strokePreserve

-- | The 'moveBackward' function moves the logo in backward direction.
-- It takes one argument of type 'Double'.
moveBackward :: Double -> Render ()
moveBackward distance = moveForward (-1 * distance)

-- | The 'turnRight' function rotates the logo in clockwise direction.
-- It takes one argument of type 'Double'.
turnRight :: Double -> Render ()
turnRight angle = do

    rotate (angle * pi / 180)
    (w, h) <- getCurrentPoint

    markEnd w h
    where markEnd x y = do
      
            setSourceRGB 0 1 0
            moveTo x y
            lineTo x y
            stroke
            setSourceRGB 1 0 0
            moveTo x y
            strokePreserve

-- | The 'turnLeft' function rotates the logo in anticlockwise direction.
-- It takes one argument of type 'Double'.
turnLeft :: Double -> Render ()
turnLeft angle = turnRight (-1 * angle)

-- | The 'tree' function draws a tree of size provided
-- It takes one argument of type 'Double'.
tree :: Double -> Render ()
tree size
    | size < 5  = do
      
                  moveForward size 
                  moveBackward size
                  return ()
 
    | otherwise = do
      
                  moveForward (size / 3)  
                  turnLeft 30
                  tree (2 * size / 3)
                  turnRight 30
                  moveForward (size / 6)
                  turnRight 25
                  tree (size / 2)
                  turnLeft 25
                  moveForward (size / 3)
                  turnRight 25
                  tree (size / 2)
                  turnLeft 25
                  moveForward (size / 6)
                  moveBackward size
                  return ()

clearScreen :: Render ()
clearScreen = do
    
    setSourceRGB 1 1 1
    paint
    strokePreserve

    (w, h) <- getCurrentPoint
    markEnd 400 150
    
    where markEnd x y = do
    
            setSourceRGB 0 1 0
            moveTo x y
            lineTo x y
            stroke
            setSourceRGB 1 0 0
            moveTo x y
            strokePreserve