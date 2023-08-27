{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_v1 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/harrison/Desktop/CMPT383/vitamins/v1/.stack-work/install/x86_64-linux-tinfo6/6cbd1326150558db82bacf4b16a6390937240fbe2a4c55123dcc1c43b60e5515/9.0.2/bin"
libdir     = "/home/harrison/Desktop/CMPT383/vitamins/v1/.stack-work/install/x86_64-linux-tinfo6/6cbd1326150558db82bacf4b16a6390937240fbe2a4c55123dcc1c43b60e5515/9.0.2/lib/x86_64-linux-ghc-9.0.2/v1-0.1.0.0-fHLFPQ0RN0JBlyUVsOmqc"
dynlibdir  = "/home/harrison/Desktop/CMPT383/vitamins/v1/.stack-work/install/x86_64-linux-tinfo6/6cbd1326150558db82bacf4b16a6390937240fbe2a4c55123dcc1c43b60e5515/9.0.2/lib/x86_64-linux-ghc-9.0.2"
datadir    = "/home/harrison/Desktop/CMPT383/vitamins/v1/.stack-work/install/x86_64-linux-tinfo6/6cbd1326150558db82bacf4b16a6390937240fbe2a4c55123dcc1c43b60e5515/9.0.2/share/x86_64-linux-ghc-9.0.2/v1-0.1.0.0"
libexecdir = "/home/harrison/Desktop/CMPT383/vitamins/v1/.stack-work/install/x86_64-linux-tinfo6/6cbd1326150558db82bacf4b16a6390937240fbe2a4c55123dcc1c43b60e5515/9.0.2/libexec/x86_64-linux-ghc-9.0.2/v1-0.1.0.0"
sysconfdir = "/home/harrison/Desktop/CMPT383/vitamins/v1/.stack-work/install/x86_64-linux-tinfo6/6cbd1326150558db82bacf4b16a6390937240fbe2a4c55123dcc1c43b60e5515/9.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "v1_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "v1_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "v1_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "v1_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "v1_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "v1_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
