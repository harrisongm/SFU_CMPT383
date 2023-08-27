{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_a2 (
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

bindir     = "/Users/harrison/Desktop/CMPT383/a2/.stack-work/install/x86_64-osx/fcd9a10afcc983f6616f0dc1b641fcbee1e8039e3fca94e75fa2fa69ffbc1508/9.0.2/bin"
libdir     = "/Users/harrison/Desktop/CMPT383/a2/.stack-work/install/x86_64-osx/fcd9a10afcc983f6616f0dc1b641fcbee1e8039e3fca94e75fa2fa69ffbc1508/9.0.2/lib/x86_64-osx-ghc-9.0.2/a2-0.1.0.0-8VysMXNUM2C6pmoQwbUb7m-a2-exe"
dynlibdir  = "/Users/harrison/Desktop/CMPT383/a2/.stack-work/install/x86_64-osx/fcd9a10afcc983f6616f0dc1b641fcbee1e8039e3fca94e75fa2fa69ffbc1508/9.0.2/lib/x86_64-osx-ghc-9.0.2"
datadir    = "/Users/harrison/Desktop/CMPT383/a2/.stack-work/install/x86_64-osx/fcd9a10afcc983f6616f0dc1b641fcbee1e8039e3fca94e75fa2fa69ffbc1508/9.0.2/share/x86_64-osx-ghc-9.0.2/a2-0.1.0.0"
libexecdir = "/Users/harrison/Desktop/CMPT383/a2/.stack-work/install/x86_64-osx/fcd9a10afcc983f6616f0dc1b641fcbee1e8039e3fca94e75fa2fa69ffbc1508/9.0.2/libexec/x86_64-osx-ghc-9.0.2/a2-0.1.0.0"
sysconfdir = "/Users/harrison/Desktop/CMPT383/a2/.stack-work/install/x86_64-osx/fcd9a10afcc983f6616f0dc1b641fcbee1e8039e3fca94e75fa2fa69ffbc1508/9.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "a2_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "a2_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "a2_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "a2_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "a2_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "a2_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
