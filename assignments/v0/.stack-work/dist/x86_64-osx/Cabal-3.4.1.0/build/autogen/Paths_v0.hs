{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_v0 (
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

bindir     = "/Users/harrison/Desktop/CMPT383/vitamins/v0/.stack-work/install/x86_64-osx/98b4a4ed2d35c034040a70b6eaca8172417df97c8f864f5ba29e30964dff610f/9.0.2/bin"
libdir     = "/Users/harrison/Desktop/CMPT383/vitamins/v0/.stack-work/install/x86_64-osx/98b4a4ed2d35c034040a70b6eaca8172417df97c8f864f5ba29e30964dff610f/9.0.2/lib/x86_64-osx-ghc-9.0.2/v0-0.1.0.0-LDyhUERPAaz4EU0o3vRw4Z"
dynlibdir  = "/Users/harrison/Desktop/CMPT383/vitamins/v0/.stack-work/install/x86_64-osx/98b4a4ed2d35c034040a70b6eaca8172417df97c8f864f5ba29e30964dff610f/9.0.2/lib/x86_64-osx-ghc-9.0.2"
datadir    = "/Users/harrison/Desktop/CMPT383/vitamins/v0/.stack-work/install/x86_64-osx/98b4a4ed2d35c034040a70b6eaca8172417df97c8f864f5ba29e30964dff610f/9.0.2/share/x86_64-osx-ghc-9.0.2/v0-0.1.0.0"
libexecdir = "/Users/harrison/Desktop/CMPT383/vitamins/v0/.stack-work/install/x86_64-osx/98b4a4ed2d35c034040a70b6eaca8172417df97c8f864f5ba29e30964dff610f/9.0.2/libexec/x86_64-osx-ghc-9.0.2/v0-0.1.0.0"
sysconfdir = "/Users/harrison/Desktop/CMPT383/vitamins/v0/.stack-work/install/x86_64-osx/98b4a4ed2d35c034040a70b6eaca8172417df97c8f864f5ba29e30964dff610f/9.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "v0_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "v0_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "v0_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "v0_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "v0_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "v0_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
